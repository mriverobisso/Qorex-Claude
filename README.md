# qorex-skills

Skills, repos y servidores MCP compartidos del **Qorex Team** (Ecuador ↔ Argentina).
Lo que uno agrega aquí, el otro lo recibe con un comando.

## Primera vez (en cada Mac)
```bash
git clone https://github.com/mriverobisso/Qorex-Claude.git ~/qorex-skills
~/qorex-skills/scripts/sync.sh
```

## Cada día / cuando el otro avise de un cambio
```bash
~/qorex-skills/scripts/sync.sh
```
Hace `git pull`, actualiza las skills del equipo, instala las skills nuevas de los repos externos (sin pisar las que ya tienes) y agrega los servidores MCP que falten en Claude Code.

## Como plugin de Claude Code (alternativa)
```
/plugin marketplace add mriverobisso/Qorex-Claude
/plugin install qorex-skills@qorex
```

## Qué hay
| Archivo | Para qué |
|---|---|
| `skills/` | Skills propias del equipo |
| `repos-externos.txt` | Repos de skills de terceros que usamos |
| `mcp-servers.txt` | Servidores MCP del equipo |
| `REGISTRO.md` | Historial: quién agregó qué y por qué (solo agregar) |
| `scripts/sync.sh` | Sincroniza todo en tu Mac |

## Reglas
- `git pull` antes de cambiar algo; commits pequeños; nunca `push --force`.
- `REGISTRO.md` solo se agrega al final.
- Cambios a lo aprobado (marca, protocolo) se proponen por Pull Request y los aprueba el otro.
