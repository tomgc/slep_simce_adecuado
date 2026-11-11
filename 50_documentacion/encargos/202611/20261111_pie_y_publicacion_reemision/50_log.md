---
expediente: 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision
repo: slep_simce_adecuado
encargo_md5: "1c45082697df0a4abfd3f4f1e8d54626"
origen: 50_documentacion/encargos/202611/20261111_pie_y_publicacion
inicio: 2026-11-11T19:48:20+00:00
fin: 2026-11-11T20:07:22+00:00
hash_inicial: "76863d3"
hash_final: "1e6e707"
auditoria_redaccion: {nivel: 2, puntaje: 3, rondas: 1, bloquea: 0, corregir: 3, menor: 2, menor_abiertos: 0, completa: "si"}
resultado_meta: cumplida
tareas: {completadas: 2, congeladas: 0, no_ejecutadas: 0}
fase_r: {veredicto: "APROBADO CON ADVERTENCIAS", bloquea: 0, repara: 0, advierte: 2, reparados: 0}
invariantes: {pasa: 4, total: 4}
errores_propios: 1
defectos_encargo: 0
fricciones_entorno: 0
dudas_abiertas: 0
intervenciones_humanas: 0
compactaciones_contexto: {n: 0, fases: []}
subagentes: {opus: 0, intermedios: 0}
push: "no"
---

# Log · pie_y_publicacion_reemision

- **Meta:** (T1) que el pie del modal «Resultados excluidos del cálculo» diga de dónde salen los nombres de los establecimientos que ya no están en el directorio, con el texto que aprobó el titular (D36-15), y que dos comentarios de código dejen de describir el esquema anterior de `simce_rbd.parquet`; (T2) publicar en `docs/` el motor y la vista con el procedimiento de `50_documentacion/activa/publicacion_github_pages.md` (D36-16); commits locales, sin push. Reemisión: T1 no edita, verifica y commitea las tres ediciones que el ORIGEN dejó hechas y sin commit.
- **Fecha:** 2026-11-11.
- **Repo y rama:** `slep_simce_adecuado`, `main` (declarados por el encargo; se miden en H1).
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision` · **ORIGEN:** `50_documentacion/encargos/202611/20261111_pie_y_publicacion`.
- **ENTORNO:** Claude Code en la estación Windows del titular (`estacion_windows`), Git Bash, lanzado en la raíz del repo; titular presente de punta a punta, sin FASE -1; sin red (ningún `fetch`, `pull` ni `push`).
- **EJECUCIÓN:** declarada esfuerzo `high`, orquestador el modelo de la sesión, subagentes 0, total Opus 0; modo real de la sesión: el que fijó el titular al lanzarla (no observable desde dentro de la sesión), sin subagentes.
- **AUDITORÍA DE REDACCIÓN:** nivel 2 (puntaje 3: C1 y C8); 1 ronda de 3 (reemisión: hereda las dos del ORIGEN); anexo del encargo.
- **Grafo:** T1 → T2 (T2 publica la salida que T1 construye y prueba). FASE R y FASE L fuera del grafo.
- **Concurrencia:** sin subagentes.
- **Topes:** 3 intentos por bug; 1 ciclo de reparación en FASE R; 1 reintento por comando con falla transitoria.

## J. Juicio
- Meta y resultado: que el pie del modal cite también la base de la Agencia como fuente de nombres (D36-15) y dos comentarios describan el esquema vigente (T1), y publicar el motor y la vista en `docs/` (T2), con commits locales y sin push → cumplida.
- Estado por tarea: T1 completada (1223816) · T2 completada (1e6e707).
- Commits: 2 en 76863d3..1e6e707 (`git log --oneline --first-parent`; sin contar `docs(encargo)`, que es hash_inicial, ni `docs(log)`), de los cuales 0 fix(auditoria).
- Auditoría (FASE R): APROBADO CON ADVERTENCIAS; hallazgos B/R/A = 0/0/2; reparados 0; abiertos 0 (ninguno).
- Auditoría de redacción: nivel 2 (puntaje 3); rondas 1; BLOQUEA/CORREGIR/MENOR = 0/3/2; MENOR abiertos 0.
- Invariantes: 4/4 PASA; FALLA: ninguno.
- Cifras críticas: intactas (evidencia: `50_sonda_json_igual.R` da `igual TRUE` entre la línea base, el motor de T1, el de FASE R y lo publicado, y entre lo publicado antes y después del encargo; M12, VMOTOR y VTRAY iguales a su línea base; md5 de `docs/trayectorias.html` igual al de partida).
- Decisiones autónomas de mayor riesgo: (1) encadenar con `&&` el commit de la publicación al guion que la verifica, sin una llamada intermedia para mirar la salida (alternativa: dos llamadas); (2) correr build y baterías de cada fase en un solo guion con los comandos transcritos (alternativa: una llamada por comando); (3) sumar a FASE R chequeos que el encargo no lista, entre ellos el conteo de columnas del parquet con un guion de R del temporal (alternativa: solo los de §6). Las tres son reversibles; sin push no hay nada publicado.
- Desviaciones respecto del encargo: ninguna en tareas, criterios ni esperados; como añadidos, FASE R y FASE L corrieron lecturas y comparaciones que el encargo no lista (declaradas en sus secciones y en el cierre), y hubo avisos de estado al titular y la lista de tareas que exige la aplicación.
- Calidad del encargo: ninguno.
- Dudas abiertas: 0; ninguna.
- Errores propios: 1 registrado (4.1); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: la lectura del pie en el navegador (modal «Resultados excluidos del cálculo» de `docs/index.html`), que esta sesión no miró; y, tras el push, que Pages sirve el md5 `3734a83573e3e22b2f51edde3d65462d`.
- No publicado / queda al usuario: push retenido (todos los commits desde `2eb0483`, con `docs(log)`); verificación de la URL pública después del push.
- Ejecución: modo de sesión high; subagentes 0, por contrato; duración 00:19 (ficha); compactaciones de contexto 0.

## Registro por fase

### FASE 0: log, punto de retorno y línea base

dato: testigo `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36q\n" > "${TMPDIR:-${TEMP:?}}/simce_s36q_testigo.txt" && echo raiz_ok'` → `raiz_ok` (escrito después: paso 0)
dato: llamada de las rutas corrida (`cygpath -w` de la raíz, del temporal y del kit); salida solo a la terminal (escrito después: paso 0)
dato: herramientas de lectura, edición (`testigo s36q` → `testigo s36q editado`) y escritura ejercidas sobre `"${TMPDIR:-${TEMP:?}}/simce_s36q_testigo.txt"` y `"${TMPDIR:-${TEMP:?}}/simce_s36q_lecturas.txt"` sin denegación (escrito después: paso 0)
dato: lecturas previas al testigo (`"${TMPDIR:-${TEMP:?}}/simce_s36q_lecturas.txt"`): el encargo (no se lista); `CLAUDE.md` del repo y el estado de git del arranque, que el entorno carga en el contexto sin llamada propia; ninguna otra lectura ni comando (escrito después: paso 0)
dato: lecturas entre el testigo y la creación del log: `<PROT>` (encabezados con `command grep -nE`, L818 a L1027 y L1585 a L1924); `50_documentacion/activa/publicacion_github_pages.md`; el log del ORIGEN completo (modelo de forma), con `wc -l` de ese log, del de `20261111_modal_simbologia_sin_directorio` y del procedimiento, y `ls` de los dos expedientes; `git diff -U0 -- 30_procesamiento` (las tres ediciones heredadas: una línea quitada y una agregada por archivo) (escrito después: paso 0)
dato: inicio `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-11T19:48:20+00:00` (offset `+00:00`: fricción conocida del encargo, registrada tal cual)

**H1** `bash -c 'basename "$(git remote get-url origin)" .git'`; `git rev-parse --short HEAD`; `git rev-parse --short origin/main`; `git symbolic-ref --short HEAD`; `bash -c 'git stash list | wc -l | tr -d " "'`; `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'`
esperado: slep_simce_adecuado / 1c2babe / 2eb0483 / main / 0 / 0

**Árbol** `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'`
esperado: exactamente 5 líneas, en este orden: ` M 30_procesamiento/31_leer_normalizar.R`, ` M 30_procesamiento/33_motor_template.html`, ` M 30_procesamiento/34_historico_pct_adecuado_costa_central.R`, `?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_encargo.md` y `?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_log.md` (comparación con `diff` contra `"${TMPDIR:-${TEMP:?}}/simce_s36q_arbol_esperado.txt"`, que conserva el espacio inicial de las líneas ` M`)

**H2** `<MD5 <SONDA_IGUAL>>`; `<MD5>` de `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_motor_template.html` y `30_procesamiento/34_historico_pct_adecuado_costa_central.R`; `bash -c 'git diff --numstat -- 30_procesamiento | LC_ALL=C sort -k3'`; `<MD5 docs/index.html>`; `<MD5 docs/trayectorias.html>`
esperado: d30362ed33555966894685414e36a06f / 40e250a046b855abe98eead84664482b, d59e4e3ed75d00968b9e905c54eb66bc y 0bcc8b665d24fe5497c9adf8ac98695e / tres líneas `1	1	<ruta>`, de `31_leer_normalizar.R`, `33_motor_template.html` y `34_historico_pct_adecuado_costa_central.R`, en ese orden / 6017a43e10068dacbf998ff69fcca0b3 / e0681b9e486428a6ab3cc38e2c531cfc
obtenido: H1 `slep_simce_adecuado` / `1c2babe` / `2eb0483` / `main` / `0` / `0` → PASA
obtenido: árbol, las 5 líneas esperadas (tres ` M` de las ediciones heredadas y dos `??`, el encargo y el log), `diff` sin diferencias → PASA
obtenido: H2 `d30362ed33555966894685414e36a06f` / `40e250a046b855abe98eead84664482b`, `d59e4e3ed75d00968b9e905c54eb66bc` y `0bcc8b665d24fe5497c9adf8ac98695e` / `1	1	30_procesamiento/31_leer_normalizar.R`, `1	1	30_procesamiento/33_motor_template.html` y `1	1	30_procesamiento/34_historico_pct_adecuado_costa_central.R` / `6017a43e10068dacbf998ff69fcca0b3` / `e0681b9e486428a6ab3cc38e2c531cfc` → PASA
dato: las tres mediciones anteriores corrieron juntas en `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_f0_h.sh"`, con los comandos transcritos y la comparación con el esperado hecha por el propio guion (`H1 igual`, `ARBOL igual`, `H2 igual`).
dato: `bash -c 'command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'` → `0` (no detiene)

**Línea base**
`<BUILD f0>`
esperado: rc 0
`<TAGREG f0>`
esperado: rc 0 y `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.`
`<VMOTOR f0>`
esperado: rc 0 y `Resultado: 12 pruebas, 12 pasan, 0 fallan` (la duración no se compara)
`<M12 f0>`
esperado: `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado`
`<VTRAY f0>`
esperado: rc 0 y `Resultado: 35 pruebas, 35 pasan, 0 fallan`
`bash -c 'cmp -s 40_salidas/trayectorias_traspasos.html docs/trayectorias.html; echo "cmp $?"'`
esperado: cmp 0 (si da `cmp 1` va como `dato:` y T2 espera también `docs/trayectorias.html`; no detiene)
`bash -c 'cp 40_salidas/motor_comparacion.html "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_f0.html"; echo $?'`
esperado: 0
obtenido: BUILD f0 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 12 segundos ===` → PASA
obtenido: TAGREG f0 `rc 0` / `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.` → PASA
obtenido: VMOTOR f0 `rc 0` / `Resultado: 12 pruebas, 12 pasan, 0 fallan (en 97 segundos)` → PASA
obtenido: M12 f0 `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` → PASA
obtenido: VTRAY f0 `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
obtenido: `cmp 0` → PASA (la vista construida es byte a byte la publicada; T2 espera cambio solo en `docs/index.html`)
obtenido: `0` → PASA (copia `"${TMPDIR:-${TEMP:?}}/simce_s36q_motor_f0.html"` hecha)
dato: [ locale ] 1 líneas (build f0)
dato: la línea base corrió en una sola llamada, `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_f0_base.sh"`, con los comandos de §0.0 transcritos en el orden del encargo y el tiempo máximo de la herramienta (600000 ms).

**Paso 3** `bash -c 'md5sum "50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_encargo.md" | cut -d" " -f1'` → `encargo_md5`

dato: encargo_md5 `1c45082697df0a4abfd3f4f1e8d54626`; `auditoria_redaccion` copiada del anexo a la ficha (nivel 2, puntaje 3, rondas 1 de 3; ronda 1: BLOQUEA 0, CORREGIR 3, MENOR 2; MENOR abiertos 0; condición completa).

**Paso 4** `git add -- 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_encargo.md`, `<STAGED>`, `git commit -m "docs(encargo): pie_y_publicacion_reemision" -- 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_encargo.md`, `hash_inicial` (`git rev-parse --short HEAD`), `<ARBOL>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_f0_commit.sh"`, que commitea solo si `<STAGED>` es igual a esa ruta)
esperado: STAGED = `50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_encargo.md`; commit rc 0; ARBOL 3 (las tres ediciones heredadas, que commitea T1)
obtenido: STAGED = esa ruta (`staged_ok`); commit rc 0, `[main 76863d3] docs(encargo): pie_y_publicacion_reemision`, 1 archivo, 557 inserciones; `hash_inicial` `76863d3`; ARBOL `3` → PASA

- **Estado:** completada.
- **Commits:** `76863d3` docs(encargo): pie_y_publicacion_reemision.
- **Cambios sustantivos:** ninguno sobre código; el log creado, la línea base tomada (con las tres ediciones heredadas en el árbol) y el punto de retorno fijado.
- **Verificación:** las de arriba (H1, árbol, H2, línea base, pasos 3 y 4), todas en PASA.
- **Alcance:** el log y archivos `simce_s36q_` del temporal; el build escribió en `40_salidas/` (ignorado; `<ARBOL>` `3`, las tres ediciones heredadas). ⊆ ALCANCE de FASE 0. md5 del encargo `1c45082697df0a4abfd3f4f1e8d54626` (ficha).
- **Regresión:** línea base tomada (BUILD rc 0, TAGREG 9/9, VMOTOR 12/12, M12 con `difieren=0` y 25 de 25, VTRAY 35/35).
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** (1) la línea base corre en un solo guion con los comandos de §0.0 transcritos, y no en una llamada por comando (alternativa descartada: llamadas separadas; reversible). (2) El commit de FASE 0 va dentro de un `.sh` que compara `<STAGED>` con la ruta esperada y commitea solo si coinciden (alternativa descartada: llamadas separadas; reversible).
- **Errores propios:** ninguno.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna nueva (el offset `+00:00` de `date` es la fricción conocida que el encargo manda registrar como `dato:`).
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** ninguna.

### FASE T1: verificar y commitear las ediciones heredadas

**Paso 0** `bash -c 'git status --porcelain -- 30_procesamiento/33_motor_template.html 30_procesamiento/31_leer_normalizar.R 30_procesamiento/34_historico_pct_adecuado_costa_central.R | wc -l | tr -d " "'`
esperado: 3

**Verificación T1** (no se edita nada: las tres ediciones son las heredadas del ORIGEN)
`bash -c 'command grep -c "base de la Agencia</span>" 30_procesamiento/33_motor_template.html; command grep -c "nombres: directorio oficial MINEDUC</span>" 30_procesamiento/33_motor_template.html'`
esperado: 1 y 0
`bash -c 'git diff --numstat -- 30_procesamiento | LC_ALL=C sort -k3'`
esperado: exactamente tres líneas `1	1	<ruta>`, de `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_motor_template.html` y `30_procesamiento/34_historico_pct_adecuado_costa_central.R`, en ese orden
`<BUILD T1>`
esperado: rc 0
`<VMOTOR T1>`
esperado: rc 0 y `Resultado: 12 pruebas, 12 pasan, 0 fallan` (la duración no se compara)
`<M12 T1>`
esperado: `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` (igual a `<M12 f0>`)
`<VTRAY T1>`
esperado: rc 0 y `Resultado: 35 pruebas, 35 pasan, 0 fallan`
`bash -c 'command grep -c -F "# Extrae las columnas base (rbd, nom_rbd, comuna y GSE)" 30_procesamiento/31_leer_normalizar.R; command grep -c -F "(17 columnas, ver" 30_procesamiento/34_historico_pct_adecuado_costa_central.R'`
esperado: 1 y 1
`bash -c 'command grep -c -F "base de la Agencia\"" 40_salidas/motor_comparacion.html; command grep -c -F "directorio oficial MINEDUC\"" 40_salidas/motor_comparacion.html'`
esperado: 1 y 0
`bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_f0.html" 40_salidas/motor_comparacion.html 2>&1 | tr -d "\r" | command grep -E "^igual "'`
esperado: igual TRUE
`bash -c 'cp 40_salidas/motor_comparacion.html "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html"; echo $?; cp 40_salidas/trayectorias_traspasos.html "${TMPDIR:-${TEMP:?}}/simce_s36q_tray_T1.html"; echo $?'` (solo con todo lo anterior en PASA)
esperado: 0 y 0

**Alcance T1** `<PRECOMMIT>` y `<MD5 50_encargo.md>`
esperado: `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R`; `1c45082697df0a4abfd3f4f1e8d54626`

**Commit T1** `git add -- <3 rutas>`, `<STAGED>`, `git commit -m "fix(motor): el pie del modal cita la base de la Agencia como fuente de nombres (D36-15)" -- 30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R`, `<ARBOL>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_T1_commit.sh"`, que commitea solo si `<PRECOMMIT>`, el md5 y `<STAGED>` son los esperados)
esperado: STAGED = las 3 rutas; commit rc 0; ARBOL 0
obtenido: Paso 0 `3` → PASA
obtenido: `1` y `0` → PASA (la plantilla trae el pie nuevo una vez y el anterior ninguna)
obtenido: `1	1	30_procesamiento/31_leer_normalizar.R` / `1	1	30_procesamiento/33_motor_template.html` / `1	1	30_procesamiento/34_historico_pct_adecuado_costa_central.R` → PASA
obtenido: BUILD T1 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 11 segundos ===` → PASA
obtenido: VMOTOR T1 `rc 0` / `Resultado: 12 pruebas, 12 pasan, 0 fallan (en 98 segundos)` → PASA
obtenido: M12 T1 `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` → PASA (igual a M12 f0)
obtenido: VTRAY T1 `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
obtenido: `1` y `1` → PASA (los dos comentarios nuevos)
obtenido: `1` y `0` → PASA (el motor construido trae el pie nuevo una vez, como cadena de JavaScript, y el anterior ninguna)
obtenido: `igual TRUE` → PASA (las cifras del motor de T1 son las de la línea base)
obtenido: `0` y `0` → PASA (copias `"${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html"` y `"${TMPDIR:-${TEMP:?}}/simce_s36q_tray_T1.html"` hechas, con todo lo anterior en PASA)
dato: [ locale ] 1 líneas (build T1)
dato: paso 0 y pruebas corrieron en una sola llamada, `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_T1_pruebas.sh"`, con los comandos transcritos; el guion compara cada salida con su esperado (15 comparaciones `igual`, `ok=1`) y guarda las copias solo si todas coinciden.
dato: corrección a la línea anterior: las comparaciones del guion son 14, no 15 (`command grep -c "^chk " "${TMPDIR:-${TEMP:?}}/simce_s36q_T1_pruebas.sh"` → `14`); las 14 salieron `igual`.
obtenido: Alcance T1 `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R`; `1c45082697df0a4abfd3f4f1e8d54626` → PASA (`precommit_y_md5_ok`)
obtenido: Commit T1: STAGED = las 3 rutas (`staged_ok`); commit rc 0, `[main 1223816] fix(motor): el pie del modal cita la base de la Agencia como fuente de nombres (D36-15)`, 3 archivos, 3 inserciones y 3 eliminaciones; ARBOL `0` → PASA

- **Estado:** completada.
- **Commits:** `1223816` fix(motor): el pie del modal cita la base de la Agencia como fuente de nombres (D36-15).
- **Cambios sustantivos:** ninguna edición en esta sesión (T1 no edita). Se commitean las tres ediciones que el ORIGEN dejó hechas y sin commit, una línea por archivo: en `33_motor_template.html` el `<span>` del pie lleva el texto de D36-15; en `31_leer_normalizar.R` el comentario describe las columnas base y las de la prueba; en `34_historico_pct_adecuado_costa_central.R` «14 columnas» pasa a «17 columnas». Causa raíz que atienden: el pie nombraba una sola fuente de nombres y dos comentarios describían el esquema anterior del parquet. La verificación del pie sobre el motor construido usa ahora el patrón de cadena de JavaScript (sin `</span>`), que es lo que corrige esta reemisión, y dio `1` y `0`.
- **Verificación:** las de arriba (paso 0, plantilla, numstat, build, baterías, comentarios, pie en el motor construido, sonda, guardado, alcance y commit), todas en PASA.
- **Alcance:** las 3 rutas commiteadas ⊆ ALCANCE de T1; el build escribió en `40_salidas/` (ignorado); copias en el temporal; md5 del encargo igual al de la ficha.
- **Regresión:** BUILD T1 rc 0; VMOTOR T1 12/12; M12 T1 igual a f0; VTRAY T1 35/35; sonda `igual TRUE` contra la línea base.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** el guion de pruebas compara cada salida con su esperado y condiciona el guardado a que todas coincidan, y el del commit condiciona el `git add` a `<PRECOMMIT>` y al md5, y el commit a `<STAGED>` (alternativa descartada: comparar a la vista y correr cada paso en su llamada; reversible).
- **Errores propios:** una cifra escrita antes de contarla («15 comparaciones» del guion de pruebas; el recuento da 14), corregida con una línea nueva sin editar la anterior (costo: una línea; ningún resultado cambia).
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** ninguna.

### FASE T2: publicación en `docs/`

**Paso 0** `bash -c 'git status --porcelain -- docs/index.html docs/trayectorias.html | wc -l | tr -d " "'`
esperado: 0

**Paso 1** `bash -c 'cp "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html" docs/index.html; echo $?; cp "${TMPDIR:-${TEMP:?}}/simce_s36q_tray_T1.html" docs/trayectorias.html; echo $?'`
esperado: 0 y 0

**Paso 2**
🔒1 `bash -c 'cmp -s docs/index.html "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html" && cmp -s docs/trayectorias.html "${TMPDIR:-${TEMP:?}}/simce_s36q_tray_T1.html" && echo identicos || echo distintos'`
esperado: identicos
`<RED>`
esperado: 0 0 0 0
`bash -c 'git -c core.quotePath=false status --porcelain -- docs | cut -c4- | LC_ALL=C sort | paste -sd " " -'`
esperado: `docs/index.html` (FASE 0 midió `cmp 0` para la vista: `docs/trayectorias.html` no cambia)
`<MD5 docs/index.html>`
esperado: distinto de `6017a43e10068dacbf998ff69fcca0b3`

**Alcance T2** `<PRECOMMIT>` y `<MD5 50_encargo.md>`
esperado: `docs/index.html`; `1c45082697df0a4abfd3f4f1e8d54626`

**Commit T2** `git add -- docs/index.html`, `<STAGED>`, `git commit -m "deploy(pages): D36-13 y D36-15, modal de simbologia con resultados sin directorio" -- docs/index.html`, `<ARBOL>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_T2_commit.sh"`, que corre solo si el guion de la copia terminó con todas sus comparaciones iguales, y commitea solo si `<PRECOMMIT>`, el md5 y `<STAGED>` son los esperados)
esperado: STAGED = `docs/index.html`; commit rc 0; ARBOL 0
obtenido: Paso 0 `0` → PASA
obtenido: `0` y `0` → PASA (las dos copias con `cp`)
obtenido: 🔒1 `identicos` → PASA (antes del commit de T2)
obtenido: `0 0 0 0` → PASA
obtenido: `docs/index.html` → PASA (solo cambia el motor publicado; la vista copiada es idéntica a la que ya estaba)
obtenido: `3734a83573e3e22b2f51edde3d65462d` → PASA (distinto de `6017a43e10068dacbf998ff69fcca0b3`)
obtenido: Alcance T2 `docs/index.html`; `1c45082697df0a4abfd3f4f1e8d54626` → PASA (`precommit_y_md5_ok`)
obtenido: Commit T2: STAGED = `docs/index.html` (`staged_ok`); commit rc 0, `[main 1e6e707] deploy(pages): D36-13 y D36-15, modal de simbologia con resultados sin directorio`, 1 archivo, 85 inserciones y 52 eliminaciones; ARBOL `0` → PASA
dato: paso 0, copia y paso 2 corrieron en `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_T2_copia.sh"`, que compara cada salida con su esperado (`ok=1`) y termina con código 0 solo si todas coinciden; el guion del commit corrió encadenado con `&&`, en la misma llamada.

- **Estado:** completada.
- **Commits:** `1e6e707` deploy(pages): D36-13 y D36-15, modal de simbologia con resultados sin directorio.
- **Cambios sustantivos:** `docs/index.html` pasa a ser copia byte a byte del motor que T1 construyó y probó (trae el catálogo de simbología de D36-13 y el pie de D36-15); `docs/trayectorias.html` se copió y quedó igual (la vista no cambió). Sin reconstruir y sin push: lo publicado en la URL pública no cambia hasta el push del titular.
- **Verificación:** las de arriba (paso 0, copia, 🔒1, `<RED>`, status de `docs/`, md5, alcance y commit), todas en PASA.
- **Alcance:** `docs/index.html` commiteado y `docs/trayectorias.html` copiado sin cambio ⊆ ALCANCE de T2; md5 del encargo igual al de la ficha.
- **Regresión:** no tocó código.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** encadenar el guion del commit al de la copia con `&&`, de modo que el commit de la publicación corre solo si las verificaciones del paso 2 coinciden con sus esperados (alternativa descartada: mirar la salida y lanzar el commit en otra llamada; reversible con un commit nuevo, y sin push no hay nada publicado).
- **Errores propios:** ninguno.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** ninguna.

### FASE R: auditoría y reparación

**Paso 1, inventario** (R-01 a R-28, escrito antes de auditar): `anexos/50_R_inventario.txt` (R-01 a R-09 FASE 0; R-10 a R-16 T1; R-17 a R-19 T2; R-20 commits; R-21 alcance global; R-22 md5 del encargo; R-23 a R-26 los cuatro invariantes; R-27 contrato de arranque; R-28 errores propios de forma).

**Pasos 2 y 5, regresión completa** (sobre el estado final, con T1 y T2 commiteadas), en `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_R_regresion.sh"`
`<BUILD r>`
esperado: rc 0
`<TAGREG r>`
esperado: rc 0 y `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.`
`<VMOTOR r>`
esperado: rc 0 y `Resultado: 12 pruebas, 12 pasan, 0 fallan` (la duración no se compara)
`<M12 r>`
esperado: `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado`
`<VTRAY r>`
esperado: rc 0 y `Resultado: 35 pruebas, 35 pasan, 0 fallan`
`bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R docs/index.html 40_salidas/motor_comparacion.html 2>&1 | tr -d "\r" | command grep -E "^igual "'` (con T2 commiteada: lo publicado contra lo que construye FASE R, sin el catálogo ni la fecha)
esperado: igual TRUE

**Paso 2, re-derivación independiente** `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_R_rederivar.sh"` (comandos distintos de los que produjeron cada afirmación)
(a) `git log --format="%h %s" 1c2babe..HEAD`; `git rev-parse --short 76863d3~1`; `git rev-parse --short origin/main` (R-01, R-20)
esperado: 3 commits (`1e6e707 deploy(pages): D36-13 y D36-15, modal de simbologia con resultados sin directorio`, `1223816 fix(motor): el pie del modal cita la base de la Agencia como fuente de nombres (D36-15)` y `76863d3 docs(encargo): pie_y_publicacion_reemision`); `1c2babe`; `2eb0483`
(b) `git show --name-only --format=` de `76863d3`, de `1223816` y de `1e6e707` (R-02, R-09, R-16, R-19)
esperado: el encargo / las 3 rutas de T1 (`31_leer_normalizar.R`, `33_motor_template.html` y `34_historico_pct_adecuado_costa_central.R`) / `docs/index.html`
(c) `git show --numstat --format= 1223816` (§6 paso 2; R-02, R-04, R-16)
esperado: tres líneas `1	1	<ruta>`, de `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_motor_template.html` y `30_procesamiento/34_historico_pct_adecuado_costa_central.R`
(d) md5 con `Rscript -e "cat(unname(tools::md5sum(\"<ruta>\")))"` del encargo y de `<SONDA_IGUAL>` (R-03, R-08, R-22)
esperado: 1c45082697df0a4abfd3f4f1e8d54626 / d30362ed33555966894685414e36a06f
(e) md5 con el mismo comando de R de los tres archivos de T1 (R-04, R-16: T1 no editó, siguen como en H2)
esperado: 40e250a046b855abe98eead84664482b / d59e4e3ed75d00968b9e905c54eb66bc / 0bcc8b665d24fe5497c9adf8ac98695e
(f) md5 con el mismo comando de R de `docs/index.html` y `<MD5 "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html">` con `md5sum` (§6 paso 2; R-17)
esperado: iguales entre sí, las dos `3734a83573e3e22b2f51edde3d65462d` (el md5 medido en T2)
(g) md5 con el mismo comando de R de `docs/trayectorias.html` y de `40_salidas/trayectorias_traspasos.html`, construido por `<BUILD r>` (R-05, R-07, R-17)
esperado: e0681b9e486428a6ab3cc38e2c531cfc las dos
(h) el pie sobre lo commiteado: `git grep -c "base de la Agencia</span>" HEAD -- 30_procesamiento/33_motor_template.html` y `git grep -c -F "base de la Agencia\"" HEAD -- docs/index.html` (§6 paso 2; R-10, R-13)
esperado: `HEAD:30_procesamiento/33_motor_template.html:1` / `HEAD:docs/index.html:1`
(i) el texto íntegro de D36-15, con `git show HEAD:<ruta> | command grep -c -F`: en la plantilla, el `<span>` completo con el texto aprobado; en lo publicado, la cadena de JavaScript completa (con `\xF3` y `\xE9` por las vocales acentuadas) (R-10, R-13)
esperado: 1 / 1
(j) el pie anterior ya no está en lo publicado, con su control positivo sobre `1c2babe`: `git grep -c -F "directorio oficial MINEDUC\"" HEAD -- docs/index.html; echo "rc $?"` y `git grep -c -F "directorio oficial MINEDUC\"" 1c2babe -- docs/index.html` (R-13, R-17)
esperado: sin salida, rc 1 / `1c2babe:docs/index.html:1`
(k) los comentarios sobre lo commiteado: `git grep -c -F` de los dos nuevos en `HEAD`; de los dos anteriores (`# Extrae las 7 columnas base` y `(14 columnas, ver`) en `HEAD`, con su control positivo en `1c2babe` (R-11)
esperado: `HEAD:30_procesamiento/31_leer_normalizar.R:1` / `HEAD:30_procesamiento/34_historico_pct_adecuado_costa_central.R:1` / sin salida, rc 1 / `1c2babe:30_procesamiento/31_leer_normalizar.R:1` y `1c2babe:30_procesamiento/34_historico_pct_adecuado_costa_central.R:1`
(l) lo que afirma el comentario nuevo de `34_*`: columnas de `40_salidas/intermedios/simce_rbd.parquet`, con `Rscript "${TMPDIR:-${TEMP:?}}/simce_s36q_ncol.R"` (imprime solo `ncol <n>`) (R-11)
esperado: ncol 17
(m) las cifras, con otro par de motores que T1: `50_sonda_json_igual.R` entre `"${TMPDIR:-${TEMP:?}}/simce_s36q_motor_f0.html"` y el motor de `<BUILD r>` (R-14)
esperado: igual TRUE
(n) las copias de T1: `bash -c 'test -f "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html"; echo "motor_T1 $?"; test -f "${TMPDIR:-${TEMP:?}}/simce_s36q_tray_T1.html"; echo "tray_T1 $?"'` (R-15)
esperado: motor_T1 0 / tray_T1 0

**Paso 3, invariantes** (comandos de §3 del encargo)
🔒1 `bash -c 'cmp -s docs/index.html "${TMPDIR:-${TEMP:?}}/simce_s36q_motor_T1.html" && cmp -s docs/trayectorias.html "${TMPDIR:-${TEMP:?}}/simce_s36q_tray_T1.html" && echo identicos || echo distintos'`
esperado: identicos
🔒2 `<ATRIB>`
esperado: 0 0
🔒3 `bash -c 'git -c core.quotePath=false diff --name-only 1c2babe HEAD | command grep -v "^50_documentacion/encargos/" | LC_ALL=C sort | paste -sd " " -'`
esperado: `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R docs/index.html`
🔒4 `<RED>`; `bash -c 'git status --porcelain -- 20_insumos | wc -l | tr -d " "'`
esperado: 0 0 0 0 y 0

**Paso 4, alcance global** `bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v -e "^?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_log.md$" -e "^?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/anexos/" | wc -l | tr -d " "'` y `<MD5 50_encargo.md>`
esperado: 0 y `1c45082697df0a4abfd3f4f1e8d54626`

**Paso 6, control positivo**
`bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R docs/index.html 40_salidas/motor_comparacion.html plantar 2>&1 | tr -d "\r" | command grep -E "^igual "'`
esperado: igual FALSE
`bash -c 'git diff --quiet 1c2babe -- docs/index.html; echo "diff $?"'`
esperado: diff 1

dato: inventario `anexos/50_R_inventario.txt`: md5 `4f5665be53fa479597cd6819f2615b54`, 29 líneas, 28 afirmaciones (`command grep -c "^R-"`).
obtenido: BUILD r `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 12 segundos ===` → PASA
obtenido: TAGREG r `rc 0` / `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.` → PASA
obtenido: VMOTOR r `rc 0` / `Resultado: 12 pruebas, 12 pasan, 0 fallan (en 98 segundos)` → PASA
obtenido: M12 r `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` → PASA (igual a M12 f0 y a M12 T1)
obtenido: VTRAY r `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
obtenido: `igual TRUE` → PASA (lo publicado tiene las cifras de lo que construye FASE R)
dato: [ locale ] 1 líneas (build r)
obtenido: (a) `1e6e707 deploy(pages): D36-13 y D36-15, modal de simbologia con resultados sin directorio` / `1223816 fix(motor): el pie del modal cita la base de la Agencia como fuente de nombres (D36-15)` / `76863d3 docs(encargo): pie_y_publicacion_reemision`; `1c2babe`; `2eb0483` → PASA
obtenido: (b) `50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_encargo.md` / `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_motor_template.html` y `30_procesamiento/34_historico_pct_adecuado_costa_central.R` / `docs/index.html` → PASA
obtenido: (c) `1	1	30_procesamiento/31_leer_normalizar.R` / `1	1	30_procesamiento/33_motor_template.html` / `1	1	30_procesamiento/34_historico_pct_adecuado_costa_central.R` → PASA
obtenido: (d) `1c45082697df0a4abfd3f4f1e8d54626` / `d30362ed33555966894685414e36a06f` → PASA
obtenido: (e) `40e250a046b855abe98eead84664482b` / `d59e4e3ed75d00968b9e905c54eb66bc` / `0bcc8b665d24fe5497c9adf8ac98695e` → PASA (los tres archivos de T1 siguen byte a byte como en H2: esta sesión no los editó)
obtenido: (f) `3734a83573e3e22b2f51edde3d65462d` / `3734a83573e3e22b2f51edde3d65462d` → PASA
obtenido: (g) `e0681b9e486428a6ab3cc38e2c531cfc` / `e0681b9e486428a6ab3cc38e2c531cfc` → PASA (la vista publicada no cambió y la que construye FASE R es la misma)
obtenido: (h) `HEAD:30_procesamiento/33_motor_template.html:1` / `HEAD:docs/index.html:1` → PASA
obtenido: (i) `1` / `1` → PASA (el texto aprobado en D36-15 está íntegro, una vez, en la plantilla commiteada y en el motor publicado)
obtenido: (j) sin salida, `rc 1` / `1c2babe:docs/index.html:1` → PASA (el pie anterior no está en lo publicado; el mismo patrón sí lo encuentra en la versión de partida)
obtenido: (k) `HEAD:30_procesamiento/31_leer_normalizar.R:1` / `HEAD:30_procesamiento/34_historico_pct_adecuado_costa_central.R:1` / sin salida, `rc 1` / `1c2babe:30_procesamiento/31_leer_normalizar.R:1` y `1c2babe:30_procesamiento/34_historico_pct_adecuado_costa_central.R:1` → PASA
obtenido: (l) `ncol 17` → PASA (el parquet que escribe el build tiene las 17 columnas que dice el comentario nuevo)
obtenido: (m) `igual TRUE` → PASA
obtenido: (n) `motor_T1 0` / `tray_T1 0` → PASA (las dos copias existen)
obtenido: 🔒1 `identicos` → PASA
obtenido: 🔒2 `0 0` → PASA
obtenido: 🔒3 `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R docs/index.html` → PASA
obtenido: 🔒4 `0 0 0 0` y `0` → PASA
obtenido: alcance global `0` y `1c45082697df0a4abfd3f4f1e8d54626` → PASA
obtenido: `igual FALSE` → PASA (el instrumento distingue una cifra alterada; sin `plantar`, el mismo par dio `igual TRUE` en la regresión)
obtenido: `diff 1` → PASA (lo publicado difiere de lo de antes de este encargo)
dato: `bash -c 'git rev-list --count origin/main..HEAD'` → `9` (commits locales sin push al cerrar FASE R: los 6 de partida que declara §1 más los 3 de este encargo; falta `docs(log)`).
dato: la regresión corrió en `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_R_regresion.sh"` y todo lo demás en `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_R_rederivar.sh"`, en una misma llamada con el tiempo máximo de la herramienta; en ese guion el md5 de R se toma de la salida estándar con `command grep -oE "[0-9a-f]{32}" | tail -n 1` y con el error estándar descartado, para que los avisos de arranque de R no entren en la comparación.

**Paso 7, hallazgos**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01, R-20 | punto de partida y commits del encargo; sin push | `git log --format="%h %s" 1c2babe..HEAD`, `git rev-parse --short 76863d3~1` y `origin/main` | 3 commits sobre `1c2babe`; `origin/main` en `2eb0483` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-02, R-09, R-16, R-19 | archivos de cada commit; T1 con una línea por archivo | `git show --name-only --format=` y `git show --numstat --format= 1223816` | el encargo; las 3 rutas de T1 con `1 1`; `docs/index.html` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-03, R-08, R-22 | md5 de la sonda y del encargo | `tools::md5sum` | los de §0 y `encargo_md5` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-04 | las tres ediciones heredadas no se tocaron en esta sesión | `tools::md5sum` de los tres archivos al cierre | los md5 de H2 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-05, R-07, R-17 | `docs/index.html` es la copia de T1; la vista no cambió | `tools::md5sum` de `docs/` y de la vista de `<BUILD r>`; `md5sum` de la copia de T1 | index igual a la copia; vista con el md5 de partida | iguales | ninguna | ninguna | no aplica | no aplica |
| R-06, R-12 | build y baterías | regresión completa (pasos 2 y 5) | rc 0, 9/9, 12/12, M12 de la línea base, 35/35 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-10, R-13 | el pie nuevo, íntegro, en la plantilla y en lo publicado; el anterior ausente | `git grep -c` sobre `HEAD`; `git show HEAD:<ruta>` con `command grep -c -F` del texto íntegro; control positivo sobre `1c2babe` | 1 y 1; 1 y 1; sin salida con control en 1 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-11 | los dos comentarios nuevos; el parquet tiene 17 columnas | `git grep -c -F` sobre `HEAD` y `1c2babe`; conteo de columnas con R | 1 y 1; anteriores ausentes con control en 1 y 1; `ncol 17` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-14 | las cifras no cambian | `50_sonda_json_igual.R` entre la línea base y el motor de `<BUILD r>`, y entre lo publicado y ese motor | `igual TRUE` las dos | iguales | ninguna | ninguna | no aplica | no aplica |
| R-15 | copias de T1 guardadas | `test -f` de las dos copias | 0 y 0 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-18, R-26 | sin cargas por red; `20_insumos/` sin cambios | invariante 4 (paso 3) | `0 0 0 0` y `0` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-21, R-25 | alcance global | paso 4 e invariante 3 | `0`; las 3 rutas de T1 y `docs/index.html` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-23 | invariante 1 | paso 3 | `identicos` | `identicos` | ninguna | ninguna | no aplica | no aplica |
| R-24 | invariante 2 | paso 3 | `0 0` | `0 0` | ninguna | ninguna | no aplica | no aplica |
| R-27 | lecturas previas al testigo | sección FASE 0 y archivo de lecturas | declaradas | `CLAUDE.md` y el estado de git, cargados por el entorno; ninguna lectura ni comando propio antes del testigo | ADVIERTE | registradas; ninguna decidió nada | no aplica | no aplica |
| R-28 | errores propios de forma | sección T1 | ninguno | 1 registrado (una cifra del log escrita antes de contarla, corregida con una línea nueva) | ADVIERTE | registrado; no cambió ningún resultado | no aplica | no aplica |

**Paso 8, ciclo de reparación:** no se abrió (0 hallazgos por reparar).
**Paso 9, prohibiciones:** ningún criterio, tolerancia ni esperado se ajustó en esta fase; ningún ALCANCE ampliado; ningún 🔒 tocado; ninguna evidencia editada (la corrección de T1 es una línea nueva que cita a la anterior).
**Paso 10, veredicto global:** `APROBADO CON ADVERTENCIAS` (0 que bloqueen, 0 por reparar, 2 advertencias: R-27 y R-28), con los dos controles positivos del paso 6 disparando.

- **Estado:** completada.
- **Commits:** ninguno.
- **Cambios sustantivos:** ninguno (fase de solo lectura sobre el repo; escribió `anexos/50_R_inventario.txt`; el build de la regresión reescribió `40_salidas/`, ignorado).
- **Verificación:** las de arriba (regresión, re-derivación, invariantes, alcance global y control positivo), todas en PASA.
- **Alcance:** el log y `anexos/50_R_inventario.txt`, más archivos `simce_s36q_` del temporal ⊆ ALCANCE de FASE R; md5 del encargo igual al de la ficha.
- **Regresión:** BUILD r rc 0; TAGREG r 9/9; VMOTOR r 12/12; M12 r igual a la línea base; VTRAY r 35/35; lo publicado contra lo construido `igual TRUE`.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** (1) sumar a la re-derivación cuatro chequeos que el encargo no lista: el texto íntegro de D36-15 en la plantilla y en lo publicado, la ausencia del pie y de los comentarios anteriores con su control positivo sobre `1c2babe`, el md5 al cierre de los tres archivos de T1 y el conteo de columnas del parquet (alternativa descartada: solo los de §6 paso 2; reversible, son lecturas). (2) El conteo de columnas lee `40_salidas/intermedios/simce_rbd.parquet`, salida del build, con un guion de R del temporal que imprime solo el número (alternativa descartada: dar por bueno el «17» del comentario sin medirlo; reversible).
- **Errores propios:** ninguno nuevo.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** ninguna.

## Cierre

(escrito después: FASE L)

**FASE L, paso 1** `<ARBOL>` (escrito después: FASE L)
esperado: 0
obtenido: 0 → PASA
dato: `hash_final` `git rev-parse --short HEAD` → `1e6e707`; `fin` `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-11T20:07:22+00:00`; `git log 76863d3..HEAD --oneline` → `1e6e707` y `1223816`; `git log --oneline --first-parent 76863d3..1e6e707 | wc -l` → `2`, de los cuales `fix(auditoria)` `0` (escrito después: FASE L)
dato: lecturas de FASE R que su sección no registró, hechas para preparar el conteo de columnas: `git grep -n -E "read_parquet|write_parquet" -- 30_procesamiento 10_utils` (con qué paquete se lee el parquet), `git ls-files 40_salidas` y un `ls` no recursivo de `40_salidas/intermedios/` (nombres de las salidas del build; ningún contenido leído ni volcado) (escrito después: FASE L)

1. **Resumen:** entró la reemisión del encargo del pie del modal y de la publicación (D36-15 y D36-16). Cuatro fases con sección (FASE 0, T1, T2, FASE R) más FASE L. FASE 0 completada (`76863d3`). T1 completada (`1223816`): sin editar, verificó y commiteó las tres ediciones que el ORIGEN dejó hechas; la verificación del pie sobre el motor construido, con el patrón corregido de esta reemisión, dio `1` y `0`. T2 completada (`1e6e707`): `docs/index.html` es copia byte a byte del motor que T1 construyó y probó; la vista no cambió. FASE R: `APROBADO CON ADVERTENCIAS`. Todo local, sin push.
2. **Commits** (`git log 76863d3..HEAD --oneline`, más el punto de retorno):
   - `76863d3` docs(encargo): pie_y_publicacion_reemision (FASE 0, hash_inicial)
   - `1223816` fix(motor): el pie del modal cita la base de la Agencia como fuente de nombres (D36-15) (T1)
   - `1e6e707` deploy(pages): D36-13 y D36-15, modal de simbologia con resultados sin directorio (T2)
   - Ningún `fix(auditoria)`.
   - El commit `docs(log)` de este log se anota en el reporte.
3. **Auditoría (FASE R):** tabla en la sección de FASE R (pasos 7 y 10), referenciada y no copiada; veredicto `APROBADO CON ADVERTENCIAS`; BLOQUEA 0, REPARA 0, ADVIERTE 2 (R-27, R-28); reparados 0; abiertos por reparar 0; los dos controles positivos del paso 6 dispararon.
4. Verificación de invariantes (FASE R):
   - 🔒1 lo publicado es lo construido y probado en T1: PASA (`identicos`, en T2 antes de su commit y en FASE R)
   - 🔒2 sin atribución: PASA (`0 0`)
   - 🔒3 solo cambian los archivos de T1 y T2, el expediente y el índice: PASA (las 3 rutas de T1 y `docs/index.html`)
   - 🔒4 sin cargas por red ni datos en lo publicado: PASA (`0 0 0 0` y `0`)
5. **Decisiones del usuario:** D36-15 (texto del pie aprobado por el titular): commiteada en `1223816`. D36-16 (publicación en `docs/` sin push): ejecutada en `1e6e707`; el push queda al titular. Ningún gate nuevo durante la sesión.
6. **Cifras críticas:** intactas. M12 da la misma línea en FASE 0, T1 y FASE R (`casos=2946 difieren=0`, 25 de 25); VMOTOR 12/12 y VTRAY 35/35 las tres veces; TAGREG 9/9 en FASE 0 y FASE R. `50_sonda_json_igual.R` da `igual TRUE` entre la línea base y el motor de T1, entre la línea base y el de FASE R, y entre lo publicado y el de FASE R; con `plantar` da `igual FALSE`. `docs/trayectorias.html` conserva su md5 de partida (`e0681b9e486428a6ab3cc38e2c531cfc`); `20_insumos/` sin cambios.
dato: como la línea base de FASE 0 ya traía las ediciones heredadas, se comparó además lo publicado antes del encargo con lo publicado ahora: `bash -c 'git show 1c2babe:docs/index.html > "${TMPDIR:-${TEMP:?}}/simce_s36q_index_partida.html"; echo "show $?"; md5sum "${TMPDIR:-${TEMP:?}}/simce_s36q_index_partida.html" | cut -d" " -f1'` → `show 0` / `6017a43e10068dacbf998ff69fcca0b3` (el md5 de partida), y `50_sonda_json_igual.R` entre esa copia y `docs/index.html` → `igual TRUE`: la publicación cambia el catálogo `simbologia`, el pie y la fecha, no las cifras (escrito después: FASE L)
7. **Dudas y pendientes:** ninguna duda abierta y ningún pendiente dentro del encargo (el push es del titular, punto 10).
8. **Errores propios:**
- error propio: T1, una cifra del log escrita antes de contarla («15 comparaciones» del guion de pruebas; el recuento con `command grep -c` da 14), corregida con una línea nueva que cita a la anterior; costo: una línea, ningún resultado cambia.
9. **Notas para el revisor:** (a) El pie en el navegador: esta sesión midió el texto íntegro en la plantilla commiteada y en el motor publicado, no lo miró en pantalla; ninguna prueba de la batería lo cita. (b) En el motor publicado la «ó» y la «é» del pie van como escapes `\xF3` y `\xE9` dentro de una cadena de JavaScript, igual que el resto del texto acentuado del bloque transpilado. (c) Tras el push, Pages debe servir `docs/index.html` con md5 `3734a83573e3e22b2f51edde3d65462d` (validación posterior de `publicacion_github_pages.md`, punto 6). (d) Los archivos `simce_s36q_` quedan en el temporal (el encargo no autoriza borrarlos); 🔒1 se mide contra las copias `simce_s36q_motor_T1.html` y `simce_s36q_tray_T1.html` mientras existan. (e) La línea base de FASE 0 se tomó con las ediciones heredadas ya en el árbol, así que «las cifras no cambian» de T1 compara dos builds del mismo código; la comparación contra lo publicado antes del encargo es el `dato:` del punto 6. (f) FASE R sumó chequeos que el encargo no lista (texto íntegro, controles positivos sobre `1c2babe`, md5 al cierre de los tres archivos de T1 y conteo de columnas del parquet); son lecturas y están declarados como decisión autónoma.
10. **Estado de cierre:** commiteado `76863d3` (el encargo), `1223816` (T1) y `1e6e707` (T2), más `docs(log)` (su hash va en el reporte), todo local. No se publica: sin push, la URL pública sigue sirviendo la versión anterior. Queda al titular el push (todos los commits desde `2eb0483`) y, después, verificar la URL pública.
11. **Calidad del encargo:**

| tipo | cita del encargo | que_ocurrio | que_debio_decir | escapo_a |
|---|---|---|---|---|

ninguno

12. **Fricciones de entorno:** ninguna (el offset `+00:00` de `date` es la fricción conocida del encargo, registrada como `dato:`).
13. **Intervenciones y tiempos:** ninguna denegación ni mensaje del titular durante la ejecución (los diálogos aprobados no son observables: `no_medible`; hubo avisos automáticos del entorno pidiendo estado, que no son del titular y se respondieron con una línea, y la lista de tareas de la aplicación, que el entorno exige mantener; sin efecto sobre archivos); inicio `2026-11-11T19:48:20+00:00`, fin `2026-11-11T20:07:22+00:00`, duración 00:19 (19 minutos, calculados con `date -d`); compactaciones de contexto 0.

**FASE L, paso 5** `bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision/50_log.md; echo "rc $?"'`
esperado: rc 0
obtenido: `valida 50_documentacion/encargos/202611/20261111_pie_y_publicacion_reemision` / `rc 0` → PASA (primer intento, sin reintento)
dato: el validador imprime además el aviso `[ locale ]` de LANG y LC_CTYPE exportados, 3 líneas.

**FASE L, paso 6** `<PRIVACIDAD>`
esperado: rc 1 y rc 1
obtenido: `rc 1` / `rc 1` → PASA (sin rutas personales, raya larga ni RUT)
dato: el log y `anexos/50_R_inventario.txt` no llevan filas de datos, RBD ni nombres de personas o establecimientos (los escribió esta sesión con conteos, hashes, rutas y nombres de columnas).

**FASE L, paso 7** (exento de pre-registro; medido después de anexar el `obtenido:` del paso 6 y antes de este bloque)
dato: permisos `-rw-r--r--`; `wc -l` 428; `head -1` `---`; termina en salto de línea `1`; `^### FASE` 4 (FASE 0, T1, T2, FASE R); `^esperado:` 62 más `^- faltante: esperado de` 0, igual a `^obtenido:` 62; `^## J` 1. Sin faltantes.

**FASE L, paso 8** `git add --` del log y de `anexos/50_R_inventario.txt`; `98_indexar_encargos.R --repo=. --escribir`; `git add --` del índice si cambió; `<STAGED>`; `git commit -m "docs(log): pie_y_publicacion_reemision" -- <lista>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36q_L_commit.sh"`, que repite `<PRIVACIDAD>` sobre el log ya completo y commitea solo si da `rc 1` dos veces y `<STAGED>` es esa lista). Sus mediciones van solo al reporte.
