#!/usr/bin/env bash
# Sincroniza las skills y MCP del Qorex Team en este Mac. Seguro de ejecutar varias veces.
set -euo pipefail
REPO_DIR="$(cd "$(dirname "$0")/.." && pwd)"
SKILLS_DIR="$HOME/.claude/skills"
CACHE="$HOME/.qorex/externos"
mkdir -p "$SKILLS_DIR" "$CACHE"

echo "== Actualizando repo del equipo"
git -C "$REPO_DIR" pull --ff-only || echo "(aviso) no se pudo hacer pull; revisa cambios locales"

echo "== Skills del equipo (siempre se actualizan a la versión del repo)"
for d in "$REPO_DIR"/skills/*/; do
  n=$(basename "$d"); rm -rf "$SKILLS_DIR/$n"; cp -R "${d%/}" "$SKILLS_DIR/"; echo "  ok $n"
done

echo "== Repos externos (no pisan skills existentes)"
grep -vE '^[[:space:]]*(#|$)' "$REPO_DIR/repos-externos.txt" | while read -r url; do
  name=$(basename "$url" .git); dst="$CACHE/$name"
  if [ -d "$dst/.git" ]; then git -C "$dst" pull -q --ff-only || true; else git clone -q --depth 1 "$url" "$dst"; fi
  added=0
  while read -r f; do
    sd=$(dirname "$f"); n=$(basename "$sd")
    if [ ! -e "$SKILLS_DIR/$n" ]; then cp -R "$sd" "$SKILLS_DIR/"; added=$((added+1)); fi
  done < <(find "$dst" -name SKILL.md -not -path '*/.git/*')
  echo "  $name: $added nuevas"
done

echo "== Servidores MCP en Claude Code"
if command -v claude >/dev/null; then
  existing=$(claude mcp list 2>/dev/null || true)
  grep -vE '^[[:space:]]*(#|$)' "$REPO_DIR/mcp-servers.txt" | while IFS='|' read -r n cmd; do
    if echo "$existing" | grep -q "^$n:"; then echo "  ya está $n"; else claude mcp add "$n" -s user -- $cmd && echo "  agregado $n"; fi
  done
else
  echo "  (Claude Code no instalado; se omiten los MCP)"
fi
echo "== Listo: $(ls "$SKILLS_DIR" | wc -l | tr -d ' ') skills en $SKILLS_DIR"
