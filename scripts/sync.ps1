# Sincroniza las skills y MCP del Qorex Team en Windows (PowerShell 5.1 o 7).
# Uso: powershell -ExecutionPolicy Bypass -File $HOME\qorex-skills\scripts\sync.ps1
$ErrorActionPreference = "Continue"
$RepoDir   = Split-Path $PSScriptRoot -Parent
$SkillsDir = Join-Path $HOME ".claude\skills"
$Cache     = Join-Path $HOME ".qorex\externos"
New-Item -ItemType Directory -Force -Path $SkillsDir, $Cache | Out-Null

function Read-List($file) {
  if (-not (Test-Path $file)) { return @() }
  Get-Content $file | Where-Object { $_.Trim() -ne "" -and -not $_.Trim().StartsWith("#") } | ForEach-Object { $_.Trim() }
}

Write-Host "== Actualizando repo del equipo"
git -C $RepoDir pull --ff-only
if ($LASTEXITCODE -ne 0) { Write-Host "(aviso) no se pudo hacer pull; revisa cambios locales" }

Write-Host "== Skills del equipo (siempre se actualizan a la version del repo)"
Get-ChildItem (Join-Path $RepoDir "skills") -Directory | ForEach-Object {
  $dst = Join-Path $SkillsDir $_.Name
  if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
  Copy-Item $_.FullName $dst -Recurse
  Write-Host "  ok $($_.Name)"
}

$overrides = Read-List (Join-Path $RepoDir "overrides.txt")

Write-Host "== Repos externos (no pisan skills existentes)"
foreach ($url in Read-List (Join-Path $RepoDir "repos-externos.txt")) {
  $name = [IO.Path]::GetFileNameWithoutExtension(($url -split "/")[-1])
  $dst = Join-Path $Cache $name
  if (Test-Path (Join-Path $dst ".git")) { git -C $dst pull -q --ff-only } else { git clone -q --depth 1 $url $dst }
  $added = 0
  Get-ChildItem $dst -Recurse -Filter "SKILL.md" -File | Where-Object { $_.FullName -notmatch "[\\/]\.git[\\/]" } | ForEach-Object {
    $sd = $_.Directory
    $n = $sd.Name
    $target = Join-Path $SkillsDir $n
    if ($overrides -contains "$n|$name") {
      if (Test-Path $target) { Remove-Item $target -Recurse -Force }
      Copy-Item $sd.FullName $target -Recurse
      Write-Host "  reemplazada $n (desde $name)"
    } elseif (-not (Test-Path $target)) {
      Copy-Item $sd.FullName $target -Recurse
      $added++
    }
  }
  Write-Host "  ${name}: $added nuevas"
}

Write-Host "== Servidores MCP en Claude Code"
if (Get-Command claude -ErrorAction SilentlyContinue) {
  $existing = (claude mcp list 2>$null) -join "`n"
  foreach ($line in Read-List (Join-Path $RepoDir "mcp-servers.txt")) {
    $n, $cmd = $line -split "\|", 2
    if ($existing -match "(?m)^${n}:") { Write-Host "  ya esta $n"; continue }
    $parts = $cmd -split " "
    if ($parts[0] -eq "npx") { $parts = @("cmd", "/c") + $parts }
    claude mcp add $n -s user -- @parts
    if ($LASTEXITCODE -eq 0) { Write-Host "  agregado $n" }
  }
} else {
  Write-Host "  (Claude Code no instalado; se omiten los MCP)"
}
$count = (Get-ChildItem $SkillsDir -Directory).Count
Write-Host "== Listo: $count skills en $SkillsDir"
