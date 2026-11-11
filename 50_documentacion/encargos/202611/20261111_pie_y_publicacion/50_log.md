---
expediente: 50_documentacion/encargos/202611/20261111_pie_y_publicacion
repo: slep_simce_adecuado
encargo_md5: "2d7187981dad394d6cf8dada53e5ac88"
origen: ninguno
inicio: 2026-11-11T19:09:53+00:00
fin: 2026-11-11T19:26:35+00:00
hash_inicial: "0b922c4"
hash_final: "0b922c4"
auditoria_redaccion: {nivel: 2, puntaje: 3, rondas: 2, bloquea: 0, corregir: 13, menor: 17, menor_abiertos: 0, completa: "si"}
resultado_meta: no_cumplida
tareas: {completadas: 0, congeladas: 1, no_ejecutadas: 1}
fase_r: {veredicto: "APROBADO CON ADVERTENCIAS", bloquea: 0, repara: 0, advierte: 3, reparados: 0}
invariantes: {pasa: 3, total: 4}
errores_propios: 2
defectos_encargo: 1
fricciones_entorno: 0
dudas_abiertas: 1
intervenciones_humanas: 0
compactaciones_contexto: {n: 0, fases: []}
subagentes: {opus: 0, intermedios: 0}
push: "no"
---

# Log · pie_y_publicacion

- **Meta:** (T1) que el pie del modal «Resultados excluidos del cálculo» diga de dónde salen los nombres de los establecimientos que ya no están en el directorio, con el texto que aprobó el titular (D36-15), y que dos comentarios de código dejen de describir el esquema anterior de `simce_rbd.parquet`; (T2) publicar en `docs/` el motor y la vista con el procedimiento de `50_documentacion/activa/publicacion_github_pages.md` (D36-16); commits locales, sin push.
- **Fecha:** 2026-11-11.
- **Repo y rama:** `slep_simce_adecuado`, `main` (declarados por el encargo; se miden en H1).
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261111_pie_y_publicacion` · **ORIGEN:** `ninguno`.
- **ENTORNO:** Claude Code en la estación Windows del titular (`estacion_windows`), Git Bash, lanzado en la raíz del repo; titular presente de punta a punta, sin FASE −1; sin red (ningún `fetch`, `pull` ni `push`).
- **EJECUCIÓN:** declarada esfuerzo `high`, orquestador el modelo de la sesión, subagentes 0, total Opus 0; modo real de la sesión: el que fijó el titular al lanzarla (no observable desde dentro de la sesión), sin subagentes.
- **AUDITORÍA DE REDACCIÓN:** nivel 2 (puntaje 3: C1 y C8); 2 rondas de 3; anexo del encargo.
- **Grafo:** T1 → T2 (T2 publica la salida que T1 construye y prueba). FASE R y FASE L fuera del grafo.
- **Concurrencia:** sin subagentes.
- **Topes:** 3 intentos por bug; 1 ciclo de reparación en FASE R; 1 reintento por comando con falla transitoria.

## J. Juicio
- Meta y resultado: que el pie del modal cite también la base de la Agencia como fuente de nombres (D36-15) y dos comentarios describan el esquema vigente (T1), y publicar el motor y la vista en `docs/` (T2), con commits locales y sin push → no cumplida (las tres ediciones de T1 están hechas y probadas pero sin commit; nada publicado).
- Estado por tarea: T1 congelada (regla de detención 2: la verificación del pie sobre el motor construido dio `0`, esperado `1`) · T2 no ejecutada (depende de T1).
- Commits: 0 en 0b922c4..0b922c4 (`git log --oneline --first-parent`; sin contar `docs(encargo)`, que es hash_inicial, ni `docs(log)`), de los cuales 0 fix(auditoria).
- Auditoría (FASE R): APROBADO CON ADVERTENCIAS; hallazgos B/R/A = 0/0/3; reparados 0; abiertos 0 (ninguno por reparar; R-14 queda como duda).
- Auditoría de redacción: nivel 2 (puntaje 3); rondas 2; BLOQUEA/CORREGIR/MENOR = 0/13/17; MENOR abiertos 0.
- Invariantes: 3/4 PASA; FALLA: ninguno; `no_medible`: el 1 (no se publicó).
- Cifras críticas: intactas (evidencia: `50_sonda_json_igual.R` da `igual TRUE` entre la línea base, el motor de T1, el de FASE R y lo publicado; md5 de `docs/` iguales a los de partida; M12 y VTRAY iguales a su línea base).
- Decisiones autónomas de mayor riesgo: (1) aplicar la regla de detención 2 al pie de la letra y no publicar (alternativa: dar por buena la verificación con un patrón propio y seguir a T2); (2) clasificar R-14 como advertencia sin abrir ciclo de reparación (alternativa: cambiar el patrón del chequeo, prohibido); (3) el commit de FASE 0 dentro de un `.sh` con compuerta de staging (alternativa: llamadas separadas). Las tres son reversibles.
- Desviaciones respecto del encargo: dos listados con las herramientas de búsqueda propias de la herramienta; el validador consultado en FASE R y no en FASE L; FASE R sumó como `dato:` la sonda sin `plantar` entre lo publicado y lo construido, que el encargo reserva a «con T2 commiteada».
- Calidad del encargo: 1 defecto (premisa_refutada); escapo_a: simulacion.
- Dudas abiertas: 1; ¿se reemite el encargo con la verificación del pie sobre el motor construido corregida (un patrón sin `</span>`), para commitear T1 y publicar T2 sobre las tres ediciones ya hechas (sí/no)?
- Errores propios: 2 registrados (4.1); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: la lectura del pie en el navegador (modal «Resultados excluidos del cálculo» de `40_salidas/motor_comparacion.html`), que esta sesión no miró; y el patrón corregido que propone «Calidad del encargo».
- No publicado / queda al usuario: tres ediciones de T1 sin commit en el árbol de trabajo; `docs/` sin tocar; push retenido; decisión sobre la duda.
- Ejecución: modo de sesión high; subagentes 0, por contrato; duración 00:16 (ficha); compactaciones de contexto 0.

## Registro por fase

### FASE 0: log, punto de retorno y línea base

dato: testigo `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36p\n" > "${TMPDIR:-${TEMP:?}}/simce_s36p_testigo.txt" && echo raiz_ok'` → `raiz_ok` (escrito después: paso 0)
dato: llamada de las rutas corrida (`cygpath -w` de la raíz, del temporal y del kit); salida solo a la terminal (escrito después: paso 0)
dato: herramientas de lectura, edición (`testigo s36p` → `testigo s36p editado`) y escritura ejercidas sobre `"${TMPDIR:-${TEMP:?}}/simce_s36p_testigo.txt"` y `"${TMPDIR:-${TEMP:?}}/simce_s36p_lecturas.txt"` sin denegación (escrito después: paso 0)
dato: lecturas previas al testigo (`"${TMPDIR:-${TEMP:?}}/simce_s36p_lecturas.txt"`): el encargo (no se lista); `CLAUDE.md` del repo y el estado de git del arranque, que el entorno carga en el contexto sin llamada propia; un listado de la carpeta del expediente (1 resultado, el encargo) (escrito después: paso 0)
dato: lecturas entre el testigo y la creación del log: `<PROT>` (encabezados, L394-599, L818-1027 y L1585-1924); `50_documentacion/activa/publicacion_github_pages.md`; el log de `20261111_modal_simbologia_sin_directorio` (modelo de forma) con su `wc -l` y el `ls` de sus anexos; `command grep -n` de las tres líneas que edita T1 (L5037, L237 y L25, como dice §1) (escrito después: paso 0)
dato: inicio `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-11T19:09:53+00:00` (offset `+00:00`: fricción conocida del encargo, registrada tal cual)
- error propio: el listado de la carpeta del expediente previo al testigo y el listado de encabezados de `<PROT>` posterior se hicieron con las herramientas de búsqueda propias de la herramienta (patrón de archivos y búsqueda de texto), no con `ls`, `git grep` ni `command grep` como fija §0.3; lecturas sin efecto, sobre el expediente y sobre `<PROT>`, sin recorrer carpetas ignoradas ni datos (costo: ninguno).

**H1** `bash -c 'basename "$(git remote get-url origin)" .git'`; `git rev-parse --short HEAD`; `git rev-parse --short origin/main`; `git symbolic-ref --short HEAD`; `bash -c 'git stash list | wc -l | tr -d " "'`; `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'`
esperado: slep_simce_adecuado / 02de98e / 2eb0483 / main / 0 / 0

**Árbol** `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'`
esperado: exactamente 2 líneas, `?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion/50_encargo.md` y `?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion/50_log.md`

**H2** `<MD5 <SONDA_IGUAL>>`; `bash -c 'command grep -c "nombres: directorio oficial MINEDUC</span>" 30_procesamiento/33_motor_template.html'`; `bash -c 'command grep -c -F "# Extrae las 7 columnas base + asigna prueba=" 30_procesamiento/31_leer_normalizar.R; command grep -c -F "simce_rbd.parquet (14 columnas, ver" 30_procesamiento/34_historico_pct_adecuado_costa_central.R'`; `<MD5 docs/index.html>`; `<MD5 docs/trayectorias.html>`
esperado: d30362ed33555966894685414e36a06f / 1 / 1 y 1 / 6017a43e10068dacbf998ff69fcca0b3 / e0681b9e486428a6ab3cc38e2c531cfc
obtenido: H1 `slep_simce_adecuado` / `02de98e` / `2eb0483` / `main` / `0` / `0` → PASA
obtenido: árbol, las 2 líneas `??` esperadas (el encargo y el log), nada más → PASA
obtenido: H2 `d30362ed33555966894685414e36a06f` / `1` / `1` y `1` / `6017a43e10068dacbf998ff69fcca0b3` / `e0681b9e486428a6ab3cc38e2c531cfc` → PASA
dato: las tres mediciones anteriores corrieron juntas en `bash "${TMPDIR:-${TEMP:?}}/simce_s36p_f0_h.sh"`, con los comandos transcritos.
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
`bash -c 'cp 40_salidas/motor_comparacion.html "${TMPDIR:-${TEMP:?}}/simce_s36p_motor_f0.html"; echo $?'`
esperado: 0
obtenido: BUILD f0 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 11 segundos ===` → PASA
obtenido: TAGREG f0 `rc 0` / `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.` → PASA
obtenido: VMOTOR f0 `rc 0` / `Resultado: 12 pruebas, 12 pasan, 0 fallan (en 97 segundos)` → PASA
obtenido: M12 f0 `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` → PASA
obtenido: VTRAY f0 `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
obtenido: `cmp 0` → PASA (la vista construida es byte a byte la publicada; T2 espera cambio solo en `docs/index.html`)
obtenido: `0` → PASA (copia `"${TMPDIR:-${TEMP:?}}/simce_s36p_motor_f0.html"` hecha)
dato: [ locale ] 1 líneas (build f0)

**Paso 3** `bash -c 'md5sum "50_documentacion/encargos/202611/20261111_pie_y_publicacion/50_encargo.md" | cut -d" " -f1'` → `encargo_md5`

dato: encargo_md5 `2d7187981dad394d6cf8dada53e5ac88`; `auditoria_redaccion` copiada del anexo a la ficha (nivel 2, puntaje 3, rondas 2 de 3; BLOQUEA 0+0 = 0, CORREGIR 10+3 = 13, MENOR 14+3 = 17; MENOR abiertos 0; condición completa).

**Paso 4** `git add -- 50_documentacion/encargos/202611/20261111_pie_y_publicacion/50_encargo.md`, `<STAGED>`, `git commit -m "docs(encargo): pie_y_publicacion" -- 50_documentacion/encargos/202611/20261111_pie_y_publicacion/50_encargo.md`, `hash_inicial` (`git rev-parse --short HEAD`), `<ARBOL>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36p_f0_commit.sh"`, que commitea solo si `<STAGED>` es igual a esa ruta)
esperado: STAGED = `50_documentacion/encargos/202611/20261111_pie_y_publicacion/50_encargo.md`; commit rc 0; ARBOL 0
obtenido: STAGED = esa ruta (`staged_ok`); commit rc 0, `[main 0b922c4] docs(encargo): pie_y_publicacion`, 1 archivo, 548 inserciones; `hash_inicial` `0b922c4`; ARBOL `0` → PASA

- **Estado:** completada.
- **Commits:** `0b922c4` docs(encargo): pie_y_publicacion.
- **Cambios sustantivos:** ninguno sobre código; el log creado, la línea base tomada y el punto de retorno fijado.
- **Verificación:** las de arriba (H1, árbol, H2, línea base, pasos 3 y 4), todas en PASA.
- **Alcance:** el log y archivos `simce_s36p_` del temporal; el build escribió en `40_salidas/` (ignorado; `<ARBOL>` `0`). ⊆ ALCANCE de FASE 0. md5 del encargo `2d7187981dad394d6cf8dada53e5ac88` (ficha).
- **Regresión:** línea base tomada (BUILD rc 0, TAGREG 9/9, VMOTOR 12/12, M12 con `difieren=0` y 25 de 25, VTRAY 35/35).
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** el commit de FASE 0 va dentro de un `.sh` que compara `<STAGED>` con la ruta esperada y commitea solo si coinciden (alternativa descartada: llamadas separadas; reversible).
- **Errores propios:** el uso de las herramientas de búsqueda propias de la herramienta para dos listados (arriba).
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna nueva (el offset `+00:00` de `date` es la fricción conocida que el encargo manda registrar como `dato:`).
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** ninguna.

### FASE T1: pie del modal y comentarios del esquema

**Paso 0** `bash -c 'git status --porcelain -- 30_procesamiento/33_motor_template.html 30_procesamiento/31_leer_normalizar.R 30_procesamiento/34_historico_pct_adecuado_costa_central.R | wc -l | tr -d " "'`
esperado: 0

**Verificación T1** (partidas de FASE 0: pie viejo 1 vez; comentarios viejos 1 y 1; BUILD f0 rc 0; VMOTOR f0 12/12; VTRAY f0 35/35)
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
`bash -c 'command grep -c "base de la Agencia</span>" 40_salidas/motor_comparacion.html'`
esperado: 1
`bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R "${TMPDIR:-${TEMP:?}}/simce_s36p_motor_f0.html" 40_salidas/motor_comparacion.html 2>&1 | tr -d "\r" | command grep -E "^igual "'`
esperado: igual TRUE
`bash -c 'cp 40_salidas/motor_comparacion.html "${TMPDIR:-${TEMP:?}}/simce_s36p_motor_T1.html"; echo $?; cp 40_salidas/trayectorias_traspasos.html "${TMPDIR:-${TEMP:?}}/simce_s36p_tray_T1.html"; echo $?'` (solo con todo lo anterior en PASA)
esperado: 0 y 0

**Alcance T1** `<PRECOMMIT>` y `<MD5 50_encargo.md>`
esperado: `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R`; `2d7187981dad394d6cf8dada53e5ac88`

**Commit T1** `git add -- <3 rutas>`, `<STAGED>`, `git commit -m "fix(motor): el pie del modal cita la base de la Agencia como fuente de nombres (D36-15)" -- 30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R`, `<ARBOL>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36p_T1_commit.sh"`, que commitea solo si `<PRECOMMIT>`, el md5 y `<STAGED>` son los esperados)
esperado: STAGED = las 3 rutas; commit rc 0; ARBOL 0
obtenido: Paso 0 `0` → PASA
obtenido: `1` y `0` → PASA (la plantilla trae el pie nuevo una vez y el anterior ninguna)
obtenido: `1	1	30_procesamiento/31_leer_normalizar.R` / `1	1	30_procesamiento/33_motor_template.html` / `1	1	30_procesamiento/34_historico_pct_adecuado_costa_central.R` → PASA
obtenido: BUILD T1 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 11 segundos ===` → PASA
obtenido: VMOTOR T1 `rc 0` / `Resultado: 12 pruebas, 12 pasan, 0 fallan (en 97 segundos)` → PASA
obtenido: M12 T1 `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` → PASA (igual a M12 f0)
obtenido: VTRAY T1 `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
obtenido: `1` y `1` → PASA (los dos comentarios nuevos)
obtenido: `0` → FALLA (esperado `1`): el patrón `base de la Agencia</span>` no aparece en `40_salidas/motor_comparacion.html`. Dispara la regla de detención 2.
obtenido: `igual TRUE` → PASA (corrió en la misma llamada que las dos mediciones anteriores; las cifras del motor de T1 son las de la línea base)
obtenido: no ejecutado (el guardado exige todo lo anterior en PASA; T1 congelada, detención 2). Las copias `simce_s36p_motor_T1.html` y `simce_s36p_tray_T1.html` no existen.
obtenido: Alcance T1 `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_motor_template.html 30_procesamiento/34_historico_pct_adecuado_costa_central.R`; `2d7187981dad394d6cf8dada53e5ac88` → PASA (es el residuo de la tarea congelada: las 3 rutas editadas y sin commit; staging vacío, `git diff --cached --name-only | wc -l` = `0`)
obtenido: Commit T1 no ejecutado (T1 congelada sin commit, detención 2); sin `git add`, sin commit.
dato: [ locale ] 1 líneas (build T1)
dato: diagnóstico de la FALLA, con comandos de solo lectura sobre el motor construido y sobre la copia de la línea base: `command grep -c "base de la Agencia" 40_salidas/motor_comparacion.html` → `1`; `command grep -c -F "figuran en \\xE9l, base de la Agencia\"" 40_salidas/motor_comparacion.html` → `1`; `command grep -c "nombres: directorio oficial MINEDUC</span>" "${TMPDIR:-${TEMP:?}}/simce_s36p_motor_f0.html"` → `0`; `command grep -c -F "Educaci\\xF3n, bases por establecimiento; nombres: directorio oficial MINEDUC\"" "${TMPDIR:-${TEMP:?}}/simce_s36p_motor_f0.html"` → `1`; `command grep -c "</span>" 40_salidas/motor_comparacion.html` → `2` (igual en la copia de la línea base).
dato: lectura del diagnóstico: el motor construido sí trae el pie nuevo, una vez, pero como cadena de JavaScript (`... base de la Agencia"`, con la «é» escrita como escape `\xE9`), sin etiqueta de cierre: `33_generar_html.R` transpila el bloque JSX de la plantilla con Babel (`git grep -n -i "jsx" -- 30_procesamiento/33_generar_html.R`, L102 a L117). El texto anterior tampoco llevaba `</span>` en el motor de la línea base. El esperado `1` del encargo no puede darse con ese patrón, con el pie correcto o sin él.
dato: una de las llamadas de diagnóstico terminó con código 1 porque dos `command grep -o` no tuvieron coincidencias (el patrón de contexto cruzaba un carácter no ASCII); se repitió con `LC_ALL=C command grep -a -o`, de solo lectura.

- **Estado:** congelada (regla de detención 2: la verificación `command grep -c "base de la Agencia</span>" 40_salidas/motor_comparacion.html` dio `0`, esperado `1`).
- **Commits:** ninguno.
- **Cambios sustantivos:** los tres cambios de §5 T1, hechos con la herramienta de edición y sin commitear: en `33_motor_template.html` L5037 el `<span>` del pie lleva el texto de D36-15; en `31_leer_normalizar.R` L237 el comentario describe las columnas base y las de la prueba; en `34_historico_pct_adecuado_costa_central.R` L25 «14 columnas» pasa a «17 columnas». Una línea por archivo. Causa raíz que atienden: el pie nombraba una sola fuente de nombres y dos comentarios describían el esquema anterior del parquet.
- **Verificación:** las de arriba; 10 en PASA, 1 en FALLA (el pie en el motor construido), 2 no ejecutadas (guardado y commit).
- **Alcance:** las 3 rutas tocadas ⊆ ALCANCE de T1; el build escribió en `40_salidas/` (ignorado); md5 del encargo igual al de la ficha.
- **Regresión:** BUILD T1 rc 0; VMOTOR T1 12/12; M12 T1 igual a f0; VTRAY T1 35/35; sonda `igual TRUE`.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno propio. La FALLA no es un bug del cambio: la edición es la que pide el encargo y el motor construido trae el texto; no hay arreglo dentro del ALCANCE que haga calzar el patrón (0 intentos de reparación).
- **Decisiones autónomas:** aplicar la regla de detención 2 al pie de la letra en vez de dar por buena la verificación con un patrón propio (alternativa descartada: medir el texto sin la etiqueta y seguir a T2; sería ajustar un esperado, y lo que sigue es una publicación). Reversible: los tres archivos quedan editados y sin commit, a disposición del titular.
- **Errores propios:** ninguno.
- **Defectos del encargo:** §5 T1 paso 4, cita: «`bash -c 'command grep -c "base de la Agencia</span>" 40_salidas/motor_comparacion.html'` esperado `1` (el motor construido trae el pie nuevo)». Qué ocurrió: dio `0`, porque el build entrega el JSX transpilado y el pie queda como cadena de JavaScript sin `</span>`. Qué debió decir: un patrón que sobreviva a la transpilación, por ejemplo `command grep -c -F "base de la Agencia\"" 40_salidas/motor_comparacion.html`, o medir el pie en el navegador con la batería. Tipo: `premisa_refutada`. El mismo patrón está en §6 paso 2 (`git grep -c "base de la Agencia</span>" HEAD -- ... docs/index.html`, esperado `HEAD:docs/index.html:1`), que tampoco puede darse sobre el motor publicado.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** el pie nuevo está en la plantilla y en el motor construido, pero la verificación del encargo que debía confirmarlo usa un patrón que no existe en el motor construido. ¿Se reemite el encargo con esa verificación corregida (sí: T1 se commitea y T2 publica en un expediente nuevo con ORIGEN, sobre los tres archivos ya editados; no: el titular decide qué hacer con las tres ediciones sin commit)? Bloquea el commit de T1 y toda T2.
- pendiente: `30_procesamiento/33_motor_template.html`, editado y sin commit (pie de D36-15).
- pendiente: `30_procesamiento/31_leer_normalizar.R`, editado y sin commit (comentario de L237).
- pendiente: `30_procesamiento/34_historico_pct_adecuado_costa_central.R`, editado y sin commit (comentario de L25).

### FASE T2: publicación en `docs/`

- **Estado:** no ejecutada (dependencia congelada: T1, regla de detención 2).
- **Commits:** ninguno.
- **Cambios sustantivos:** ninguno; no se copió nada a `docs/`.
- **Verificación:** ninguna corrida; 🔒1 queda `no_medible` (no se publicó).
- **Alcance:** nada tocado.
- **Regresión:** no tocó código.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** ninguna.
- **Errores propios:** ninguno.
- **Defectos del encargo:** ninguno nuevo (el de T1 alcanza también a §6 paso 2).
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** la de T1.

### FASE R: auditoría y reparación

**Paso 1, inventario** (26 afirmaciones, R-01 a R-26, escrito antes de auditar): `anexos/50_R_inventario.txt` (R-01 a R-09 FASE 0; R-10 a R-16 T1; R-17 T2; R-18 commits; R-19 alcance global; R-20 md5 del encargo; R-21 a R-24 los cuatro invariantes; R-25 contrato de arranque; R-26 errores propios de forma).

**Pasos 2 y 5, regresión completa** (sobre el árbol de trabajo, con las tres ediciones de T1 sin commit)
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
dato: la comparación de lo publicado con lo que construye FASE R (`50_sonda_json_igual.R docs/index.html 40_salidas/motor_comparacion.html`, esperado `igual TRUE`) rige «con T2 commiteada»; T2 no se ejecutó y no se mide como verificación.

**Paso 2, re-derivación independiente** `bash "${TMPDIR:-${TEMP:?}}/simce_s36p_R_rederivar.sh"` (comandos distintos de los que produjeron cada afirmación)
`git log --format="%h %s" 02de98e..HEAD`; `git rev-parse --short 0b922c4~1`; `git rev-parse --short origin/main`; `git show --name-only --format= 0b922c4` (R-01, R-02, R-09, R-18)
esperado: 1 commit (`0b922c4 docs(encargo): pie_y_publicacion`); `02de98e`; `2eb0483`; 1 ruta, el encargo
md5 con `Rscript -e "cat(unname(tools::md5sum(\"<ruta>\")))"` del encargo y de `<SONDA_IGUAL>` (R-03, R-08, R-20)
esperado: 2d7187981dad394d6cf8dada53e5ac88 / d30362ed33555966894685414e36a06f
md5 con el mismo comando de R de `docs/index.html` y `docs/trayectorias.html`; `bash -c 'git diff --name-only 02de98e HEAD -- docs | wc -l | tr -d " "'`; `bash -c 'git status --porcelain -- docs | wc -l | tr -d " "'` (R-05, R-17: `docs/` sigue como en la partida)
esperado: 6017a43e10068dacbf998ff69fcca0b3 / e0681b9e486428a6ab3cc38e2c531cfc / 0 / 0
md5 con el mismo comando de R de `40_salidas/trayectorias_traspasos.html`, construido por `<BUILD r>` (R-07: la vista construida es la publicada)
esperado: e0681b9e486428a6ab3cc38e2c531cfc
`git grep -c` sobre `02de98e` de los tres textos de partida (R-04)
esperado: `02de98e:30_procesamiento/33_motor_template.html:1` / `02de98e:30_procesamiento/31_leer_normalizar.R:1` / `02de98e:30_procesamiento/34_historico_pct_adecuado_costa_central.R:1`
`bash -c 'git diff --stat -- 30_procesamiento | tail -n 1'` y, sobre las líneas agregadas de `git diff -U0`, el conteo con `command grep -c -F` de las tres líneas nuevas completas (el `<span>` con el texto íntegro de D36-15, el comentario de L237 y el de L25) (R-10, R-11, R-13)
esperado: `3 files changed, 3 insertions(+), 3 deletions(-)` / 1 / 1 / 1
el pie sobre lo commiteado, `git grep -c "base de la Agencia</span>" HEAD -- 30_procesamiento/33_motor_template.html docs/index.html` (§6 paso 2; con T1 sin commit, ninguna)
esperado: sin salida, rc 1
el pie en el motor que construye FASE R (R-14): `command grep -c "base de la Agencia</span>" 40_salidas/motor_comparacion.html` y `command grep -c -F "figuran en \\xE9l, base de la Agencia\"" 40_salidas/motor_comparacion.html`
esperado: 0 y 1 (reproduce lo que el log afirma en T1: el patrón del encargo no calza y el texto está una vez como cadena; el esperado del encargo para el primero sigue siendo `1` y sigue en FALLA)
las cifras (R-15), por otra vía que la sonda de T1: `50_sonda_json_igual.R` entre `"${TMPDIR:-${TEMP:?}}/simce_s36p_motor_f0.html"` y el motor que construye FASE R
esperado: igual TRUE
las copias de T1 (R-16): `bash -c 'test -e "${TMPDIR:-${TEMP:?}}/simce_s36p_motor_T1.html"; echo "motor_T1 $?"; test -e "${TMPDIR:-${TEMP:?}}/simce_s36p_tray_T1.html"; echo "tray_T1 $?"'`
esperado: motor_T1 1 / tray_T1 1 (no existen: el guardado no se ejecutó)
dato: del paso 2 del encargo quedan `no_medible` el md5 de `docs/index.html` contra el de `simce_s36p_motor_T1.html` (T1 y T2 sin commit; la copia no existe) y el `git show --numstat --format=` del commit de T1 (no hay commit de T1).

**Paso 3, invariantes** (comandos de §3 del encargo)
dato: 🔒1 `no_medible` (T1 y T2 sin commit: no se publicó; su comando no se corre, las copias de T1 no existen).
🔒2 `<ATRIB>`
esperado: 0 0
🔒3 `bash -c 'git -c core.quotePath=false diff --name-only 02de98e HEAD | command grep -v "^50_documentacion/encargos/" | LC_ALL=C sort | paste -sd " " -'`
esperado: vacío (con T1 sin commit)
🔒4 `<RED>`; `bash -c 'git status --porcelain -- 20_insumos | wc -l | tr -d " "'`
esperado: 0 0 0 0 y 0

**Paso 4, alcance global** `bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v -e "^?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion/50_log.md$" -e "^?? 50_documentacion/encargos/202611/20261111_pie_y_publicacion/anexos/" | wc -l | tr -d " "'` y `<MD5 50_encargo.md>`
esperado: 3 (las rutas declaradas `- pendiente:` de T1 congelada) y `2d7187981dad394d6cf8dada53e5ac88`

**Paso 6, control positivo**
`bash -c 'Rscript 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/50_sonda_json_igual.R docs/index.html 40_salidas/motor_comparacion.html plantar 2>&1 | tr -d "\r" | command grep -E "^igual "'`
esperado: igual FALSE
`bash -c 'cmp -s docs/index.html "${TMPDIR:-${TEMP:?}}/simce_s36p_motor_f0.html"; echo "cmp $?"'`
esperado: cmp 1

dato: inventario `anexos/50_R_inventario.txt`: md5 `dfe73c309254d66a741889050b9493cb`, 28 líneas.
obtenido: BUILD r `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 10 segundos ===` → PASA
obtenido: TAGREG r `rc 0` / `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.` → PASA
obtenido: VMOTOR r `rc 0` / `Resultado: 12 pruebas, 12 pasan, 0 fallan (en 96 segundos)` → PASA
obtenido: M12 r `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` → PASA (igual a M12 f0 y a M12 T1)
obtenido: VTRAY r `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
dato: [ locale ] 1 líneas (build r)
obtenido: `0b922c4 docs(encargo): pie_y_publicacion`; `02de98e`; `2eb0483`; `50_documentacion/encargos/202611/20261111_pie_y_publicacion/50_encargo.md` → PASA
obtenido: `2d7187981dad394d6cf8dada53e5ac88` / `d30362ed33555966894685414e36a06f` → PASA
obtenido: `6017a43e10068dacbf998ff69fcca0b3` / `e0681b9e486428a6ab3cc38e2c531cfc` / `0` / `0` → PASA (`docs/` sin cambios, commiteados o no)
obtenido: `e0681b9e486428a6ab3cc38e2c531cfc` → PASA (la vista que construye FASE R tiene el md5 de la publicada)
obtenido: `02de98e:30_procesamiento/33_motor_template.html:1` / `02de98e:30_procesamiento/31_leer_normalizar.R:1` / `02de98e:30_procesamiento/34_historico_pct_adecuado_costa_central.R:1` → PASA
obtenido: ` 3 files changed, 3 insertions(+), 3 deletions(-)` / `1` / `1` / `1` → PASA (las tres líneas agregadas son, completas, las de §5 T1; el `<span>` trae el texto íntegro de D36-15)
obtenido: sin salida, `rc 1` → PASA (nada commiteado trae el pie nuevo: T1 sin commit)
obtenido: `0` y `1` → PASA como re-derivación de lo que el log afirma; contra el esperado del encargo (`1` con su patrón) sigue en FALLA, y es el hallazgo R-14.
obtenido: `igual TRUE` → PASA
obtenido: `motor_T1 1` / `tray_T1 1` → PASA (las copias de T1 no existen)
obtenido: 🔒2 `0 0` → PASA
obtenido: 🔒3 vacío → PASA (ningún archivo fuera del expediente cambió en lo commiteado)
obtenido: 🔒4 `0 0 0 0` y `0` → PASA
obtenido: alcance global `3` y `2d7187981dad394d6cf8dada53e5ac88` → PASA (las 3 rutas pendientes de T1, nada más)
obtenido: `igual FALSE` → PASA (el instrumento distingue una cifra alterada)
obtenido: `cmp 1` → PASA (el instrumento de 🔒1 distingue un motor distinto del publicado)
dato: la misma sonda sin `plantar` entre `docs/index.html` y el motor que construye FASE R da `igual TRUE`: el control dispara por la cifra plantada y no por una diferencia previa; las cifras de lo publicado son las del motor actual (sin el catálogo `simbologia` ni la fecha).
dato: todo lo anterior, salvo la regresión, corrió en `bash "${TMPDIR:-${TEMP:?}}/simce_s36p_R_rederivar.sh"`, con los comandos transcritos.

**Paso 7, hallazgos**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01, R-02, R-09, R-18 | punto de partida y commits del encargo | `git log --format="%h %s" 02de98e..HEAD`, `git rev-parse --short 0b922c4~1` y `origin/main`, `git show --name-only --format= 0b922c4` | 1 commit sobre `02de98e`, con 1 ruta | iguales | ninguna | ninguna | no aplica | no aplica |
| R-03, R-08, R-20 | md5 de la sonda y del encargo | `tools::md5sum` | los de §0 y `encargo_md5` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-04 | textos de partida, una vez cada uno | `git grep -c` sobre `02de98e` | 1, 1 y 1 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-05, R-17 | `docs/` como en la partida; T2 no ejecutada | `tools::md5sum`; `git diff --name-only` y `git status --porcelain` sobre `docs` | md5 de la partida; 0 y 0 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-06, R-12 | build y baterías | regresión completa (pasos 2 y 5) | rc 0, 9/9, 12/12, M12 de la línea base, 35/35 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-07 | la vista construida es la publicada | `tools::md5sum` de la vista de `<BUILD r>` | md5 de `docs/trayectorias.html` | igual | ninguna | ninguna | no aplica | no aplica |
| R-10, R-11, R-13 | las tres ediciones de T1 | `git diff --stat` y `command grep -c -F` de las líneas agregadas completas | 3 archivos, 3 y 3; 1, 1 y 1 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-14 | el motor construido trae el pie nuevo (§5 T1 paso 4, esperado `1`) | el patrón del encargo y `command grep -c -F` del texto como cadena, sobre el motor de `<BUILD r>` | 1 con el patrón del encargo | 0 con el patrón del encargo; 1 con el texto como cadena de JavaScript | ADVIERTE | no se corrige: el cambio es el pedido y el texto está en el motor; hacer calzar el chequeo exigiría cambiar su patrón, que es el criterio (paso 9). T1 congelada por la detención 2; duda al titular | no aplica | no aplica |
| R-15 | las cifras no cambian | `50_sonda_json_igual.R` entre el motor de la línea base y el de `<BUILD r>` | `igual TRUE` | igual | ninguna | ninguna | no aplica | no aplica |
| R-16 | T1 congelada sin commit y sin copias guardadas | `test -e` de las dos copias; paso 4 | no existen; 3 rutas | iguales | ninguna | ninguna | no aplica | no aplica |
| R-19 | alcance global | paso 4 y 🔒3 | 3 pendientes y vacío | iguales | ninguna | ninguna | no aplica | no aplica |
| R-21 | invariante 1 | no se corre (no se publicó) | `no_medible` | `no_medible` | ninguna | ninguna | no aplica | no aplica |
| R-22 a R-24 | invariantes 2 a 4 | paso 3 | §3 del encargo | los tres como en §3 | ninguna | ninguna | no aplica | no aplica |
| R-25 | lecturas previas al testigo | sección FASE 0 y archivo de lecturas | declaradas | `CLAUDE.md` y el estado de git, cargados por el entorno; un listado del expediente | ADVIERTE | registradas; ninguna decidió nada | no aplica | no aplica |
| R-26 | errores propios de forma | sección FASE 0 | ninguno | 1 registrado (dos listados con las herramientas de búsqueda propias de la herramienta) | ADVIERTE | registrado; no cambió ningún resultado | no aplica | no aplica |

**Paso 8, ciclo de reparación:** no se abrió (0 hallazgos por reparar: R-14 no es un defecto del trabajo y no tiene arreglo dentro del ALCANCE).
**Paso 9, prohibiciones:** ningún criterio, tolerancia ni esperado se ajustó en esta fase; ningún ALCANCE ampliado; ningún 🔒 tocado; ninguna evidencia editada.
**Paso 10, veredicto global:** `APROBADO CON ADVERTENCIAS` (0 que bloqueen, 0 por reparar, 3 advertencias: R-14, R-25, R-26), con los dos controles positivos del paso 6 disparando. El veredicto audita lo ejecutado y lo afirmado en el log; no dice que la meta se cumplió: T1 quedó congelada y T2 no se ejecutó.

- **Estado:** completada.
- **Commits:** ninguno.
- **Cambios sustantivos:** ninguno (fase de solo lectura; escribió `anexos/50_R_inventario.txt`).
- **Verificación:** las de arriba (regresión, re-derivación, invariantes, alcance global y control positivo).
- **Alcance:** el log y `anexos/50_R_inventario.txt`, más archivos `simce_s36p_` del temporal ⊆ ALCANCE de FASE R; md5 del encargo igual al de la ficha.
- **Regresión:** BUILD r rc 0; TAGREG r 9/9; VMOTOR r 12/12; M12 r igual a la línea base; VTRAY r 35/35.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** (1) sumar a la re-derivación la sonda sin `plantar` entre lo publicado y lo construido, como `dato:`, para que el control positivo sea informativo (alternativa descartada: solo el control con `plantar`; reversible). (2) Clasificar R-14 como advertencia y no abrir el ciclo de reparación (alternativa descartada: tratarlo como defecto reparable y cambiar el patrón del chequeo, prohibido por el paso 9; reversible).
- **Errores propios:** ninguno nuevo.
- **Defectos del encargo:** el de T1 (el patrón con `</span>` sobre el motor construido), que alcanza a §6 paso 2.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** la de T1 (R-14), consolidada en `## Cierre`.

## Cierre

(escrito después: FASE L)

**FASE L, paso 1** `<ARBOL>` (escrito después: FASE L)
esperado: 3 (el `0` del encargo más el residuo declarado: las 3 rutas `- pendiente:` de T1 congelada)
obtenido: 3 → PASA
dato: `hash_final` `git rev-parse --short HEAD` → `0b922c4`; `fin` `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-11T19:26:35+00:00`; `git log 0b922c4..HEAD --oneline` sin salida (escrito después: FASE L)

1. **Resumen:** entró el encargo del pie del modal y de la publicación (D36-15 y D36-16). Cuatro fases con sección (FASE 0, T1, T2, FASE R) más FASE L. FASE 0 completada (`0b922c4`). T1 congelada por la regla de detención 2: las tres ediciones están hechas y el build y las baterías pasan, pero la verificación del pie sobre el motor construido dio `0` con el patrón del encargo (esperado `1`), porque el build transpila el JSX y la etiqueta `</span>` del patrón no existe en la salida; sin commit. T2 no ejecutada (depende de T1): nada se copió a `docs/`. FASE R: `APROBADO CON ADVERTENCIAS`.
2. **Commits** (`git log 0b922c4..HEAD --oneline`, más el punto de retorno):
   - `0b922c4` docs(encargo): pie_y_publicacion (FASE 0, hash_inicial)
   - Ningún commit de tarea ni `fix(auditoria)`: `git log 0b922c4..HEAD --oneline` no tiene salida.
   - El commit `docs(log)` de este log se anota en el reporte.
3. **Auditoría (FASE R):** tabla en la sección de FASE R (pasos 7 y 10), referenciada y no copiada; veredicto `APROBADO CON ADVERTENCIAS`; BLOQUEA 0, REPARA 0, ADVIERTE 3 (R-14, R-25, R-26); reparados 0; abiertos por reparar 0; los dos controles positivos del paso 6 dispararon. El veredicto audita lo ejecutado; la meta no se cumplió.
4. Verificación de invariantes (FASE R):
   - 🔒1 lo publicado es lo construido y probado en T1: no_medible (no se publicó; T1 y T2 sin commit)
   - 🔒2 sin atribución: PASA (`0 0`)
   - 🔒3 solo cambian los archivos de T1 y T2, el expediente y el índice: PASA (vacío, el esperado con T1 sin commit)
   - 🔒4 sin cargas por red ni datos en lo publicado: PASA (`0 0 0 0` y `0`)
5. **Decisiones del usuario:** D36-15 (texto del pie aprobado por el titular): aplicada en la plantilla del árbol de trabajo, sin commit. D36-16 (publicación en `docs/` sin push): no ejecutada. Ningún gate nuevo durante la sesión.
6. **Cifras críticas:** intactas. `50_sonda_json_igual.R` da `igual TRUE` entre el motor de la línea base y el de T1, entre el de la línea base y el de FASE R, y entre lo publicado y el de FASE R; M12 da la misma línea en FASE 0, T1 y FASE R (`casos=2946 difieren=0`, 25 de 25); VTRAY 35/35 las tres veces. `docs/index.html` y `docs/trayectorias.html` conservan sus md5 de partida (`6017a43e10068dacbf998ff69fcca0b3` y `e0681b9e486428a6ab3cc38e2c531cfc`); `20_insumos/` sin cambios.
7. **Dudas y pendientes:**
- duda: el pie nuevo está en la plantilla y en el motor construido (una vez, como cadena de JavaScript), pero la verificación de §5 T1 paso 4 lo busca con `</span>`, que el build transpilado no conserva, y dio `0` (esperado `1`). ¿Se reemite el encargo con esa verificación corregida (sí: T1 se commitea y T2 publica en un expediente nuevo con ORIGEN, sobre las tres ediciones ya hechas; no: el titular decide qué hacer con las tres ediciones sin commit)? Bloquea el commit de T1 y toda T2.
- pendiente: `30_procesamiento/33_motor_template.html`, editado y sin commit (pie de D36-15).
- pendiente: `30_procesamiento/31_leer_normalizar.R`, editado y sin commit (comentario de L237).
- pendiente: `30_procesamiento/34_historico_pct_adecuado_costa_central.R`, editado y sin commit (comentario de L25).
8. **Errores propios:**
- error propio: FASE 0, el listado de la carpeta del expediente (antes del testigo) y el de encabezados de `<PROT>` (después) se hicieron con las herramientas de búsqueda propias de la herramienta y no con `ls`, `git grep` ni `command grep` (§0.3); lecturas sin efecto; costo: ninguno.
- error propio: FASE R, el validador `98_indexar_encargos.R` se consultó (un `command grep -n` y la lectura de L286 a L375 y de L452 a L645) antes de escribir la tabla de auditoría, cuando el encargo lo lista como insumo de FASE L; sirvió para dar a la tabla y al cierre la forma que el validador cuenta, sin cambiar ningún resultado; costo: ninguno.
9. **Notas para el revisor:** (a) El pie en el navegador: esta sesión midió el texto en la plantilla y en el motor construido, no lo miró; ninguna prueba de la batería lo cita. (b) En el motor construido la «é» de «él» va como escape `\xE9` dentro de una cadena de JavaScript, igual que el resto del texto acentuado del bloque transpilado en la línea base (por ejemplo `Educaci\xF3n`). (c) La clasificación de R-14 como advertencia: no es un defecto del trabajo ni un invariante en FALLA, pero es lo que dejó la meta sin cumplir. (d) El mismo patrón con `</span>` está en §6 paso 2 del encargo sobre `docs/index.html`; una reemisión debe corregir los dos. (e) Las tres ediciones de T1 siguen en el árbol de trabajo: el encargo siguiente parte con 3 líneas ` M` y su FASE 0 debe preverlo. (f) El patrón sugerido en «Calidad del encargo» lo midió esta sesión sobre el motor de T1 y sobre el de FASE R (da `1`).
10. **Estado de cierre:** commiteado `0b922c4` (el encargo), más `docs(log)` (su hash va en el reporte), todo local. Sin commit: las tres ediciones de T1, en el árbol de trabajo. No se publica: `docs/` sin tocar y sin push. Queda al titular la decisión de la duda, las tres ediciones pendientes y el push (los cuatro commits del encargo anterior y los dos de este).
11. **Calidad del encargo:**

| tipo | cita del encargo | que_ocurrio | que_debio_decir | escapo_a |
|---|---|---|---|---|
| premisa_refutada | §5 T1 paso 4: «`bash -c 'command grep -c "base de la Agencia</span>" 40_salidas/motor_comparacion.html'` esperado `1` (el motor construido trae el pie nuevo)» | dio `0`: `33_generar_html.R` transpila el JSX de la plantilla y el pie queda en el motor construido como cadena de JavaScript, sin `</span>`; el texto anterior tampoco la llevaba en el motor de la línea base. Disparó la regla de detención 2 | un patrón que sobreviva a la transpilación, por ejemplo `command grep -c -F "base de la Agencia\"" 40_salidas/motor_comparacion.html` (da `1`), y lo mismo en §6 paso 2 para `docs/index.html` | simulacion (el anexo declara que los revisores no tienen el build; el patrón se probó sobre la plantilla y no sobre una salida construida) |

12. **Fricciones de entorno:** ninguna (el offset `+00:00` de `date` es la fricción conocida del encargo, registrada como `dato:`).
13. **Intervenciones y tiempos:** ninguna denegación ni mensaje del titular durante la ejecución (los diálogos aprobados no son observables: `no_medible`; hubo avisos automáticos del entorno pidiendo estado, que no son del titular, y un aviso del entorno tras editar la plantilla, sin efecto); inicio `2026-11-11T19:09:53+00:00`, fin `2026-11-11T19:26:35+00:00`, duración 00:16; compactaciones de contexto 0.

**FASE L, paso 5** `bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261111_pie_y_publicacion/50_log.md; echo "rc $?"'`
esperado: rc 0
obtenido: `valida 50_documentacion/encargos/202611/20261111_pie_y_publicacion` / `rc 0` → PASA (primer intento, sin reintento)
dato: el validador imprime además el aviso `[ locale ]` de LANG y LC_CTYPE exportados, 3 líneas.
dato: precisión a la nota (f) del punto 9: el comando sugerido, `command grep -c -F "base de la Agencia\"" 40_salidas/motor_comparacion.html`, se midió tal cual sobre el motor de FASE R en esta misma llamada y dio `1`; sobre el motor de T1 no se corrió ese comando exacto: lo medido ahí fue `1` para el texto sin la comilla y `1` para la cadena más larga que lo contiene.

**FASE L, paso 6** `<PRIVACIDAD>`
esperado: rc 1 y rc 1
obtenido: `rc 1` / `rc 1` → PASA (sin rutas personales, raya larga ni RUT)
dato: el log y `anexos/50_R_inventario.txt` no llevan filas de datos, RBD ni nombres de personas o establecimientos (los escribió esta sesión con conteos, hashes, rutas y nombres de columnas).

**FASE L, paso 7** (exento de pre-registro; medido después de anexar el `obtenido:` del paso 6 y antes de este bloque)
dato: permisos `-rw-r--r--`; `wc -l` 386; `head -1` `---`; termina en salto de línea `1`; `^### FASE` 4 (FASE 0, T1, T2, FASE R); `^esperado:` 48 más `^- faltante: esperado de` 0, igual a `^obtenido:` 48; `^## J` 1. Sin faltantes.

**FASE L, paso 8** `git add --` del log y de `anexos/50_R_inventario.txt`; `98_indexar_encargos.R --repo=. --escribir`; `git add --` del índice si cambió; `<STAGED>`; `git commit -m "docs(log): pie_y_publicacion" -- <lista>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36p_L_commit.sh"`, que commitea solo si `<STAGED>` es esa lista); las tres rutas `- pendiente:` de T1 no entran. Sus mediciones van solo al reporte.
