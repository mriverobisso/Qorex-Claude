---
name: instalar-repo-skills-mcp
description: Usar cuando alguien del Qorex Team pase un repo de GitHub (URL o 'gh repo clone owner/repo') y pida instalarlo: lo revisa, lo registra en el repo del equipo para que el otro lo reciba, y da el comando de instalación.
---

# Instalar repos de skills o servidores MCP (Qorex Team)

Todo lo que se instala se registra en el repo compartido `Qorex-Claude` (github.com/mriverobisso/Qorex-Claude, clonado en `~/qorex-skills`), para que el otro integrante lo reciba con `scripts/sync.sh`.

## Pasos
1. Clonar en una carpeta temporal con `git clone --depth 1 https://github.com/<owner>/<repo>.git` (no `gh repo clone`). Si falla, probar variantes obvias del nombre (`server` → `servers`) y avisar.
2. Detectar el tipo:
   - Archivos `SKILL.md` → repo de skills (contar y ver si van en subcarpetas por categoría).
   - Paquetes de servidores MCP (`src/<servidor>` con `package.json`/`pyproject.toml`) → servidores MCP.
3. Revisar el contenido antes de recomendarlo (nada de scripts sospechosos o instrucciones raras en los SKILL.md).
4. Registrar en el repo del equipo (`git pull` primero):
   - Skills de terceros → agregar la URL a `repos-externos.txt`.
   - Servidor MCP → agregar `nombre|comando` a `mcp-servers.txt`.
   - Skill propia → carpeta nueva en `skills/<nombre>/SKILL.md`.
   - Agregar una línea al final de `REGISTRO.md`: `- AAAA-MM-DD · <nombre> · <qué> · <motivo>`.
   - Commit pequeño y `git push` (nunca `--force`).
5. Indicar a ambos que ejecuten `~/qorex-skills/scripts/sync.sh`. El script no pisa skills que ya existan con el mismo nombre (avisar de duplicados).
6. Si no hay acceso al repo desde la sesión, hacer el cambio en el Mac del usuario (`~/qorex-skills`) o darle los cambios exactos para que haga el commit.

## Notas
- Las skills en `~/.claude/skills` funcionan en Claude Code. Para Cowork/claude.ai se usan las skills de la cuenta o el plugin de la organización.
- MCP: `npx` requiere Node.js; `uvx` requiere `brew install uv`. Comprobar con `claude mcp list`.

## Estilo
Respuesta breve en español: qué contiene el repo, qué se registró y el comando a ejecutar.
