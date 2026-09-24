# Errores del asistente, sesión 33 (2026-09-24)

Registro en el momento en que ocurren (POLITICA 0.5; SETTINGS §2.2.15, diez campos en layout de bloque).

**ERR-33-01**
- `momento`: Fase A, medición a mano del candado 0bis antes de que corriera `/apertura` (primer turno de la sesión).
- `disparador`: asistente lo señaló espontáneamente (advertencias `unable to unlink '.git/objects/maintenance.lock'` y `'.git/index.lock': Operation not permitted` en la salida del puente).
- `que_paso`: corrí `git fetch` desde el puente de Cowork siguiendo el bloque de 0bis de SETTINGS §1.2.2, y después un `git status` sin `GIT_OPTIONAL_LOCKS=0`; ambos crearon candados en `.git/` que el puente no puede borrar, y quedaron en la estación.
- `regla_violada`: traspaso v32 §12 (⚠️ «NO correr ningún comando de git que escriba desde el puente de Cowork») y aviso 9 del mensaje de apertura de la sesión 33.
- `causa_raiz`: apliqué literal el bloque de 0bis de SETTINGS como fallback sin propagarle la restricción del traspaso sobre el puente; además traté `git status` como lectura pura, sin medir que refresca el índice y toma `index.lock`.
- `salvaguarda_presente`: traspaso v32 §12, mensaje de apertura (aviso 9), ERR-32-04 (efecto de una herramienta propia sobre el árbol del ejecutor).
- `patron`: PAT-07, restricción leída (git que escribe, no desde el puente) no propagada al procedimiento de fallback de 0bis.
- `gatillo_observable`: restriccion-no-propagada: un bloque de comandos con `git fetch` a punto de correrse por `device_bash` en una sesión cuyo traspaso prohíbe git que escriba desde el puente.
- `intentos_previos`: 0.
- `costo`: dos candados huérfanos (`.git/index.lock` dos veces, `.git/objects/maintenance.lock`) movidos a `_archivo/20260924/git_locks/`; sin mover, `/apertura` habría fallado por `index.lock`. Ningún cambio en el historial ni en el árbol versionado. Desde entonces todo git del puente corre con `GIT_OPTIONAL_LOCKS=0` y solo en lectura.
