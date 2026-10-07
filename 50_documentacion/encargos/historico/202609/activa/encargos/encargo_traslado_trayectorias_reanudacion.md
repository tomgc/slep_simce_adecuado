# Reanudación del traslado (T1), tras la detención de la adenda

Formato: `encargo_autonomo_claude_code_v1.md` v1.6. Sesión 32 (2026-09-23). Se ejecuta la adenda
(`50_documentacion/activa/encargos/encargo_traslado_trayectorias_adenda.md`) completa, desde su FASE 0, sobre el
encargo que complementa (`encargo_traslado_trayectorias.md`), leídos ambos enteros. **Precedencia: esta reanudación
manda sobre la adenda, y la adenda sobre el encargo.** Lo que aquí se fija sustituye lo que dicen los otros dos.

**D1 del log de la adenda, resuelta por el redactor:** `Claude outputs/` lo creó la entrega de archivos al chat del
redactor (ERR-32-04). Sus dos copias se movieron a `_archivo/20260923/claude_outputs_s32/` (fuera de git) y la carpeta
vacía a `_archivo/20260923/claude_outputs_vacio_s32`. `.gitignore` gana la entrada `Claude outputs/`, que viaja en el
commit de T1 con las otras cinco rutas.

## 1. Contrato (sustituye lo correspondiente de la adenda y el encargo)

- **LOG:** `50_documentacion/andamios/logs/20260923_traslado_trayectorias_reanudacion_log.md` (nuevo). Tras el
  `git commit` de FASE L el LOG no se vuelve a tocar: el hash del `docs(log)` y la salida del push van solo en el
  reporte final.
- **ALCANCE:** el de T1 del encargo (seis rutas); más, para FASE L, este archivo, su LOG y
  `50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`.
- **PUNTO DE RETORNO:** `31d00b3`. Los 🔒 del encargo se siguen midiendo contra `760ce01`.
- **Regla 1, reemplazada:** tras el fetch, detén la sesión si `git rev-parse --short HEAD` no es `31d00b3`, si
  `git rev-parse --short origin/main` (otra llamada) no es `760ce01`, o si
  `git merge-base --is-ancestor origin/main HEAD && echo ancestro` no imprime `ancestro`.
- **Regla 2:** detén la sesión si el `git status --porcelain` del paso 3 de FASE 0 no son exactamente las 9 líneas
  de §2.
- **Regla 5:** la de la adenda (cualquier prueba en FALLA congela T1; en D10 solo cuenta `de ellas sin empate 0`).
- **Autorizaciones (lista cerrada):**
  1. `cp` de `40_salidas/intermedios/*.parquet` a `/tmp/slep_s32_traslado/`.
  2. `git add` de rutas explícitas del ALCANCE y `git commit`: uno para T1, los `fix(auditoria)` de FASE R y el
     `docs(log)` de FASE L.
  3. `git push origin main` al final de FASE L, **solo si T1 quedó commiteada** y el árbol queda limpio. Publica
     `git log 760ce01..HEAD`: `801ce5e`, `31d00b3`, el commit de T1, los `fix(auditoria)` si los hubo y el
     `docs(log)`.

  Nada más.
- Topes, POSICIÓN, scratch (`/tmp/slep_s32_traslado`), PRUEBAS, 🔒 y FASE R: como en el encargo y la adenda.

## 2. Estado de partida (premisas)

- `HEAD` = `31d00b3`, `origin/main` = `760ce01` (fuente: `git log` del redactor en la estación; hipótesis, se mide
  en FASE 0).
- `git status --porcelain` medido en FASE 0 paso 3, **después de crear el LOG**, 9 líneas:
  - ` M .gitignore`
  - ` M 00_build.R`
  - ` M 50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`
  - `?? 30_procesamiento/36_funciones_trayectorias.R`
  - `?? 30_procesamiento/36_generar_trayectorias.R`
  - `?? 30_procesamiento/36_trayectorias_template.html`
  - `?? 30_procesamiento/36_verificar_trayectorias.R`
  - `?? 50_documentacion/activa/encargos/encargo_traslado_trayectorias_reanudacion.md`
  - `?? 50_documentacion/andamios/logs/20260923_traslado_trayectorias_reanudacion_log.md`

  (fuente: `git status --porcelain` del redactor, después de depositar este archivo: las ocho primeras; la novena
  la crea FASE 0 paso 1; hipótesis, se mide en FASE 0). No debe aparecer `Claude outputs/`.
- md5 de los cuatro `36_*`: los de §2 de la adenda (fuente: `md5sum` en la VM del puente sobre los archivos de la
  estación; hipótesis, se mide en FASE 0 con `tools::md5sum`).
- `grep -c '^Claude outputs/$' .gitignore` → `1` (fuente: comando del redactor en la estación).

## 3. Fases

### FASE 0

Los pasos de la FASE 0 de la adenda, con estos esperados: paso 2, `31d00b3` y `760ce01`, y además
`git merge-base --is-ancestor origin/main HEAD && echo ancestro` → `ancestro`; paso 3, las 9 líneas de §2; agrega
`grep -c '^Claude outputs/$' .gitignore` → `1`.

### FASE 1 (T1)

La de la adenda, sin cambios: build, batería (17 pruebas, `de ellas sin empate 0`, D13 y D13c en PASA), md5 del HTML
`8b0a586bf9577e5164d7f10e2fadd835`, DATA canónico `661da614aacc67b2d63757534f5f9f55`, commit de las seis rutas con el
mensaje del encargo.

### FASE R

La del encargo (§5), íntegra, sobre este LOG, con el punto de retorno `31d00b3` para el chequeo global de alcance.

### FASE L

Los siete pasos del encargo, con estos valores literales:

1. `git status --porcelain` → si T1 se commiteó, exactamente 3 líneas:
   ` M 50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`,
   `?? 50_documentacion/activa/encargos/encargo_traslado_trayectorias_reanudacion.md`,
   `?? 50_documentacion/andamios/logs/20260923_traslado_trayectorias_reanudacion_log.md`. Si T1 quedó congelada,
   esas 3 más las seis rutas de T1.
2. Cierre del log, que agrega la sección `### FASE L: cierre`. El estado de cierre dice «commit docs(log) y push:
   ver reporte final».
3. Bloque J.
4. `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' 50_documentacion/andamios/logs/20260923_traslado_trayectorias_reanudacion_log.md`
   → sin salida.
5. `ls -l` y `wc -l` de ese LOG; `grep -c '^### FASE'` → `4` (FASE 0, FASE 1, FASE R, FASE L); `grep -c '^esperado:'`
   igual a `grep -c '^obtenido:'`; `grep -c '^## J'` → `1`.
6. `git add 50_documentacion/andamios/logs/20260923_traslado_trayectorias_reanudacion_log.md 50_documentacion/activa/encargos/encargo_traslado_trayectorias_reanudacion.md 50_documentacion/andamios/logs/20260923_sesion32_errores_asistente.md`
   y `git commit -m "docs(log): reanudacion del traslado (s32)"`. Después, solo si T1 se commiteó,
   `git status --porcelain` → vacío y `git push origin main`.
7. Fuera del LOG, en el reporte final: `git log -1 --format=%h`, `git status --porcelain` y
   `git ls-remote origin refs/heads/main | cut -f1` → igual a `git rev-parse HEAD` si hubo push; `760ce01…` si no.

## 4. Reporte final

Primera línea: `ls -l` y `wc -l` del LOG y el hash del `docs(log)`. Después, el bloque J tal cual.
