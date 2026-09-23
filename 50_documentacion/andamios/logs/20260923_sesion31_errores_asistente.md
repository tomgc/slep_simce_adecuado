# Errores del asistente, sesión 31 (registro en el momento)

Se vuelca a §15 del traspaso v31 con los diez campos de SETTINGS §2.2.15.

**ERR-31-01**
- `momento`: apertura de emergencia, al preparar el árbol para el cierre v30.
- `disparador`: asistente lo señaló espontáneamente.
- `que_paso`: ejecuté `git restore --staged --worktree` desde el puente de Cowork, que no puede borrar archivos, y el comando dejó un `.git/index.lock` huérfano nuevo, del mismo tipo que el que acababa de retirar.
- `regla_violada`: SETTINGS §1.2.6, «ningún comando asume el entorno»; instrucción ⚠️ del traspaso v30 sobre operar git desde el puente.
- `causa_raiz`: leí la restricción del puente como «sin credenciales» (lo que impide commitear) y no como «sin permiso de borrado» (lo que impide a git soltar su propio candado), aunque el candado de 2026-09-09 era evidencia directa de lo segundo.
- `salvaguarda_presente`: SETTINGS y traspaso v30.
- `patron`: PAT-03, sobre capacidades de escritura de git en el puente.
- `gatillo_observable`: comando-entorno: un comando de git que escribe el índice se lanzó en una máquina donde `rm` falla con «Operation not permitted».
- `intentos_previos`: 0.
- `costo`: un candado huérfano más, retirado con `mv` a `_archivo/20260923/`; ESTADO.md restaurado con `git show HEAD:` en vez de `git restore`.
