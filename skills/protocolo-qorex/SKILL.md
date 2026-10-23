---
name: protocolo-qorex
description: Usar en cualquier proyecto compartido del Qorex Team: al iniciar y cerrar sesiones, y antes de editar documentos, artifacts, diseños o archivos compartidos.
---

# Protocolo Qorex Team

Mario (Ecuador) y su compañero (Argentina) trabajan los mismos proyectos. Los chats y la memoria personal no se comparten, así que la memoria común del equipo son los documentos del proyecto y el repo `Qorex-Claude` (github.com/mriverobisso/Qorex-Claude).

## Documentos base de cada proyecto
- `protocolo-equipo.md` (reglas), `contexto.md` (cliente, alcance, decisiones vigentes), `bitacora.md` (historial), `marca-aprobada.md` (diseño aprobado, si aplica).
- Si el proyecto no los tiene, ofrecer crearlos.

## Al empezar
1. Leer `contexto.md`, las últimas entradas de `bitacora.md` y `marca-aprobada.md` si hay diseño.
2. Resumir en 2-3 líneas el estado y lo último que hizo el otro integrante.

## Al terminar (o tras un cambio importante)
- Agregar al final de `bitacora.md`: `- AAAA-MM-DD · <nombre> · <qué se hizo> · <archivos/artifacts> · <pendientes>`.
- Si cambió una decisión, actualizar `contexto.md` con fecha y autor.

## No sobrescribir
- Releer cada documento justo antes de escribirlo e integrar el cambio sobre la versión actual; nunca reescribir desde una copia vieja.
- `bitacora.md` y `REGISTRO.md` son solo de agregar; nunca editar ni borrar entradas del otro.
- Artifacts: actualizar el mismo enlace tras leer la versión publicada; ante conflicto, fusionar. Nunca usar `force`.
- Carpeta compartida: no reemplazar archivos del otro; versiones nuevas con sufijo `_AAAAMMDD_<iniciales>`.
- Repo del equipo: `git pull` antes de cambiar; commits pequeños; nunca `push --force`.

## Diseño y marca
- Lo aprobado en `marca-aprobada.md` o en el sistema de diseño del equipo (paleta, tipografías, logo, tono, reglas de uso) no se cambia sin aprobación de ambos.
- Propuestas: en "Propuestas pendientes" o como comentario en el artifact, con autor y fecha. Solo pasan a "Aprobado" cuando ambos lo confirman.

## Si no se puede escribir en el proyecto
- Entregar los documentos como archivos y pedir que se suban al conocimiento del proyecto. Avisar claramente que no quedaron guardados.
