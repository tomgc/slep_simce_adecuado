---
expediente: 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia
repo: slep_simce_adecuado
encargo_md5: "5a0afe4d2c5e1685c0044abcf56621f9"
origen: ninguno
inicio: 2026-11-09T15:11:36+00:00
fin: 2026-11-09T15:44:43+00:00
hash_inicial: "eee2b50"
hash_final: "e4652b6"
auditoria_redaccion: {nivel: 3, puntaje: 4, rondas: 4, bloquea: 8, corregir: 33, menor: 44, menor_abiertos: 0, completa: "si"}
resultado_meta: cumplida
tareas: {completadas: 4, congeladas: 0, no_ejecutadas: 0}
fase_r: {veredicto: "APROBADO CON ADVERTENCIAS", bloquea: 0, repara: 0, advierte: 4, reparados: 0}
invariantes: {pasa: 9, total: 9}
errores_propios: 7
defectos_encargo: 1
fricciones_entorno: 1
dudas_abiertas: 1
intervenciones_humanas: 0
compactaciones_contexto: {n: 0, fases: []}
subagentes: {opus: 0, intermedios: 0}
push: "no"
---

# Log · inclusion_resultados_simbologia

- **Meta:** que el motor y la vista de trayectorias incluyan todo resultado por estándar que publica la Agencia, también los que trae con simbología adicional (marca), señalados con «‡» en el motor, con casilla de exclusión y modal de motivos por año (D36-1); commits locales, sin push y sin copiar a `docs/`.
- **Fecha:** 2026-11-09.
- **Repo y rama:** `slep_simce_adecuado`, `main`.
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia` · **ORIGEN:** `ninguno`.
- **ENTORNO:** Claude Code en la estación Windows del titular (`estacion_windows`), shell Git Bash, directorio de trabajo en la raíz del repo; titular presente de punta a punta; sin red.
- **EJECUCIÓN:** declarada esfuerzo `high`, orquestador el modelo de la sesión, subagentes 0, total Opus 0; modo real de la sesión: `high`, sin subagentes.
- **AUDITORÍA DE REDACCIÓN:** nivel 3 (puntaje 4: C1, C6, C8); 4 rondas; anexo del encargo.
- **Grafo:** T1 raíz; T2 requiere T1; T3 requiere T1; T4 requiere T1, T2 y T3. Orden T1, T2, T3, T4; luego FASE R y FASE L.
- **Concurrencia:** sin subagentes.
- **Topes:** 3 intentos por bug; 1 ciclo de reparación en FASE R; 1 reintento por comando con falla transitoria.

## J. Juicio
- Meta y resultado: motor y vista con todos los resultados por estándar publicados, «‡», casilla, modal, CSV y nota de D36-1, commits locales sin push ni `docs/` → cumplida.
- Estado por tarea: T1 completada (9d190b0) · T2 completada (c36ae35) · T3 completada (f0b8ba5) · T4 completada (e4652b6).
- Commits: 4 en eee2b50..e4652b6 (`git log --oneline --first-parent`; sin contar `docs(encargo)`, que es hash_inicial, ni `docs(log)`), de los cuales 0 fix(auditoria).
- Auditoría (FASE R): APROBADO CON ADVERTENCIAS; hallazgos B/R/A = 0/0/4; reparados 0; abiertos 0 (ninguno).
- Auditoría de redacción: nivel 3 (puntaje 4); rondas 4; BLOQUEA/CORREGIR/MENOR = 8/33/44; MENOR abiertos 0.
- Invariantes: 9/9 PASA; FALLA: ninguno.
- Cifras críticas: alteradas por diseño (D36-1): Costa Central 4° básico 2025 Lectura 55/1.194 y Matemática 53/1.187, `simce_rbd` 142.353 con 2.008 con simbología (sondas S1 y S2); directorio, `20_insumos/` y `docs/` intactos (md5 y conteos).
- Decisiones autónomas de mayor riesgo: (1) constantes del referente de R1, R3, R5 y R6 por un recuento que lee también el catálogo de Servicios Locales y el de olas (alternativa: dejar esas pruebas en FALLA y congelar T2 y T4); (2) retirar `excluir_marcadas` de la vista (alternativa: conservarlo como parámetro muerto); (3) el modal del panorama lista las dos pruebas del nivel (alternativa: solo la prueba de la comparación).
- Desviaciones respecto del encargo: recuento de la regla 9 con dos insumos que la regla no enumera; Paso 0 de T3 medido después de editar; README con columnas de esquema no pedidas; un `git add -N` y un heredoc vacío no autorizados.
- Calidad del encargo: 1 defectos (ambiguedad_interpretada); escapo_a: simulacion.
- Dudas abiertas: 1; ¿acepta el titular el recuento del referente con el listado de Servicios Locales y el catálogo de olas como recuento independiente de la regla 9 (sí/no)?
- Errores propios: 7 registrados (4.1); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: la lectura visual del motor y la vista (signo en franjas angostas, leyenda, modal en el panorama) y el recuento independiente del referente (R-13).
- No publicado / queda al usuario: push retenido y copia a `docs/` pendiente (D36-3); decisión sobre la duda de la regla 9.
- Ejecución: modo de sesión high; subagentes 0, por contrato; duración 00:33 (ficha); compactaciones de contexto 0.

## Registro por fase

### FASE 0: log, punto de retorno, línea base e hipótesis

dato: testigo `bash -c 'test "$(pwd -P)" = ... && printf "testigo s36\n" > "${TMPDIR:-${TEMP:?}}/simce_s36_testigo.txt" && echo raiz_ok'` → `raiz_ok` (escrito después: paso 0)
dato: llamada de las rutas corrida; salida solo a la terminal (escrito después: paso 0)
dato: herramientas de lectura, edición y escritura ejercidas sobre `"${TMPDIR:-${TEMP:?}}/simce_s36_testigo.txt"` y `"${TMPDIR:-${TEMP:?}}/simce_s36_lecturas.txt"` sin denegación (escrito después: paso 0)
dato: lectura previa: `50_encargo.md` (ls del expediente y cat del encargo)
dato: lectura previa: `anexos/` (ls -la)
dato: lectura previa: `anexos/50_insumo_decision_d36_1.md.txt`
dato: lectura previa: `<PROT>` (wc -l, encabezados, L661-1000 y L1585-1924)
dato: lectura previa: `wc -l` de los archivos de los ALCANCE y de `00_build.R`
dato: inicio `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-09T15:11:36+00:00`
- friccion: `TZ=America/Santiago date -Iseconds` en Git Bash devuelve offset `+00:00` (sin base de zonas horarias), no la hora de Santiago → se registra el valor tal cual; `fin` se mide con la misma forma, así que la duración es comparable.
dato: archivo de toleradas creado con la centinela; `wc -l` → `1`

**H1** `bash -c 'basename "$(git remote get-url origin)" .git'`; `git rev-parse --short HEAD`; `git rev-parse --short origin/main`; `git symbolic-ref --short HEAD`; `bash -c 'git stash list | wc -l | tr -d " "'`; `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'`
esperado: slep_simce_adecuado / d32ad14 / d32ad14 / main / 0 / 0

**Árbol** `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort | diff "${TMPDIR:-${TEMP:?}}/simce_s36_arbol_esperado.txt" -; echo "rc $?"'`
esperado: rc 0

**H2** `bash -c 'test -n "${TMPDIR:-${TEMP:-}}" && command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'`
esperado: 0

**H3** `<MD5>` de los cuatro archivos de `<A>`, del directorio y de `CLAUDE.md`
esperado: 2b89f14e2fd4498e379cb5941699f3d7 / d7b79d59153081df784ac0fcf31843ec / 62c88269ebdf2deed1d7f34624ce93e2 / b3b9b224901a8365f92bc140657ebcfb / 80be2b37bf1879dd47875422641bd297 / 2f2b69acbad905f94946dff865eb575b

obtenido (H1): slep_simce_adecuado / d32ad14 / d32ad14 / main / 0 / 0
obtenido (árbol): rc 0
obtenido (H2): 0
obtenido (H3): 2b89f14e2fd4498e379cb5941699f3d7 / d7b79d59153081df784ac0fcf31843ec / 62c88269ebdf2deed1d7f34624ce93e2 / b3b9b224901a8365f92bc140657ebcfb / 80be2b37bf1879dd47875422641bd297 / 2f2b69acbad905f94946dff865eb575b
- error propio: las cuatro líneas anteriores `obtenido (Hn):` no empiezan con `obtenido:` y no cuentan para la paridad de FASE L; se reponen abajo con la forma legal, mismo contenido (costo: 1 edición).
obtenido: H1 slep_simce_adecuado / d32ad14 / d32ad14 / main / 0 / 0 → PASA
obtenido: árbol rc 0 → PASA
obtenido: H2 0 → PASA
obtenido: H3 seis md5 iguales a los esperados → PASA

**H4 (línea base, regla vieja)**
`<BUILD f0>`
esperado: rc 0
`<TAGREG f0>`
esperado: rc 0 y `OK: 7/7 casos de .tests_agregar_ponderado() pasaron.`
`<VMOTOR f0>` (regla 2: no detiene; línea base)
esperado: rc 0 y `Resultado:` sin fallas
`<VTRAY f0>` (regla 2: no detiene; línea base)
esperado: rc 0 y `Resultado:` sin fallas
obtenido: BUILD f0 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 24745 filas en datos, 20948 en nube, 180 comunas (2.0 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.21 MB)` / `` / `=== 00_build.R: OK en 17 segundos ===` → PASA
obtenido: TAGREG f0 `rc 0` / `OK: 7/7 casos de .tests_agregar_ponderado() pasaron.` → PASA
obtenido: VMOTOR f0 `rc 0` / `Resultado: 8 pruebas, 8 pasan, 0 fallan (en 78 segundos)` → PASA
obtenido: VTRAY f0 `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
dato: [ locale ] 1 líneas (build f0)
dato: forma de PASA/FALLA por prueba: `<id> +PASA  <descripción>` al inicio de línea en las dos baterías (p. ej. `M3     PASA  ...`, `R4     PASA  ...`); el grep de 🔒8 sobre la línea base da `2` (motor) y `1` (vista), así que FASE R lo usa tal cual.
dato: línea base de la batería del motor: M1 a M8; de la vista: D1 a D14c, C1 a C6, R1 a R7, FC1 y FC2 (35).

**Grep «supresión»** `bash -c 'git grep -n -i -E "marcas? de supresi" -- 10_utils 30_procesamiento README.md | wc -l | tr -d " "'`
esperado: 5

**SONDA2 f0** (`<SONDA2 f0>`)
esperado: `cc_4b_lect_2025 54 1184` / `cc_4b_mate_2025 52 1175` / `simce_rbd 140345` / `simb ausente` / `catalogo ausente` / `ceros_json 0`

**H5** (`<SONDA1>`)
esperado: `validas 142353` / `simb 2008` / `ceros 8216` / `cc_4b_lect_2025 55 1194 54 1184` / `cc_4b_mate_2025 53 1187 52 1175` / `codigos 1 | 2 | 3 | 4 | Ajenas a la Agencia: Resultados no representativos | Ajenas al Establecimiento: Resultados no representativos | Alumnos insuficientes`
obtenido: grep «supresión» `5` → PASA
obtenido: SONDA2 f0 `cc_4b_lect_2025 54 1184` / `cc_4b_mate_2025 52 1175` / `simce_rbd 140345` / `simb ausente` / `catalogo ausente` / `ceros_json 0` → PASA (igual a la fila S2 de partida)
obtenido: H5 `validas 142353` / `simb 2008` / `ceros 8216` / `cc_4b_lect_2025 55 1194 54 1184` / `cc_4b_mate_2025 53 1187 52 1175` / `codigos 1 | 2 | 3 | 4 | Ajenas a la Agencia: Resultados no representativos | Ajenas al Establecimiento: Resultados no representativos | Alumnos insuficientes` → PASA (igual a la fila S1)

**Paso 3** `bash -c 'md5sum 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia/50_encargo.md | cut -d" " -f1'` → `encargo_md5`
dato: encargo_md5 `5a0afe4d2c5e1685c0044abcf56621f9`; `auditoria_redaccion` copiada a la ficha (BLOQUEA 6+1+1+0 = 8, CORREGIR 23+2+7+1 = 33, MENOR 28+6+6+4 = 44, abiertos 0).

**Paso 4** `git add --` de las 5 rutas (`"${TMPDIR:-${TEMP:?}}/simce_s36_commit_encargo.sh"`), `<STAGED>`, commit, `hash_inicial`, `<ARBOL>`, `<LOGVIVO>`
esperado: STAGED = las 5 rutas (encargo, dos insumos, dos sondas); commit rc 0; ARBOL 0; LOGVIVO 1
obtenido: STAGED = `50_encargo.md`, `anexos/50_insumo_decision_d36_1.md.txt`, `anexos/50_insumo_errores_s36.md.txt`, `anexos/50_sonda_json.R`, `anexos/50_sonda_simbologia.R`; commit rc 0; `hash_inicial` `eee2b50`; ARBOL `0`; LOGVIVO `1` → PASA

- **Estado:** completada.
- **Commits:** `eee2b50` docs(encargo): inclusion_resultados_simbologia.
- **Alcance:** solo el log, el archivo de toleradas y archivos `simce_s36_` en `<TMP>`; el build escribió en `40_salidas/` (ignorado).
- **Regresión:** línea base H4 tomada (build, TAGREG, VMOTOR 8/8, VTRAY 35/35).
- **Subagentes:** sin subagentes.
- **Errores propios:** el de las líneas `obtenido (Hn):` (arriba). Además, antes del testigo usé `cat` (no listado entre los comandos de solo lectura de §0.2 punto 0) para leer el encargo y el insumo: lectura sin efecto, declarada aquí.
- **Defectos del encargo:** ninguno.
- **Dudas:** ninguna.

### FASE T1: regla de inclusión en el pipeline

**Paso 0** `bash -c 'git status --porcelain -- <5 rutas del ALCANCE de T1> | wc -l | tr -d " "'`
esperado: 0
obtenido: 0 → PASA

**Verificación T1** (partidas de H4: BUILD f0 rc 0; TAGREG f0 `OK: 7/7`; SONDA2 f0 `54 1184` / `52 1175` / `140345` / `ausente` / `ausente` / `0`; grep «supresión» en los 4 archivos de T1 `4`)
`<BUILD T1>`
esperado: rc 0
`<TAGREG T1>`
esperado: rc 0 y `OK: <n>/<n>` con n > 7
`<SONDA2 T1>`
esperado: `cc_4b_lect_2025 55 1194` / `cc_4b_mate_2025 53 1187` / `simce_rbd 142353` / `simb 2008` / `catalogo 2008` / `ceros_json 0`
`bash -c 'git grep -n -i -E "marcas? de supresi" -- 10_utils 30_procesamiento/31_leer_normalizar.R 30_procesamiento/32_agregar_comunal.R 30_procesamiento/33_generar_html.R | wc -l | tr -d " "'`
esperado: 0
obtenido: BUILD T1 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 24745 filas en datos, 20948 en nube, 180 comunas (2.0 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.21 MB)` / `` / `=== 00_build.R: OK en 10 segundos ===` → PASA
obtenido: TAGREG T1 `rc 0` / `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.` → PASA (partida 7/7)
obtenido: SONDA2 T1 `cc_4b_lect_2025 55 1194` / `cc_4b_mate_2025 53 1187` / `simce_rbd 142353` / `simb 2008` / `catalogo 2008` / `ceros_json 0` → PASA
obtenido: grep «supresión» T1 `0` → PASA (partida 4)
dato: el build T1 imprime `simce_rbd: 142353 filas` y `Simbología: 2008 filas con simbología adicional (D36-1)`.
dato: control positivo de la aserción del umbral: los casos C4 y C6 de `.tests_agregar_ponderado()` plantan una fila con resultado y nalu < 10 y exigen el `stop()`; C8 planta una fila en ceros con marca y exige que quede fuera.

**Alcance** `<PRECOMMIT>` y `<MD5 50_encargo.md>`
esperado: las 5 rutas del ALCANCE de T1; `5a0afe4d2c5e1685c0044abcf56621f9`
obtenido: `10_utils/10_configuracion.R`, `10_utils/10_utils.R`, `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/32_agregar_comunal.R`, `30_procesamiento/33_generar_html.R`; `5a0afe4d2c5e1685c0044abcf56621f9` → PASA

**Commit** `git add -- <5 rutas>`, `<STAGED>`, `git commit -m "fix(pipeline): ..." -- <5 rutas>`, `<ARBOL>`, `<LOGVIVO>`
esperado: STAGED = las 5 rutas; commit rc 0; ARBOL 0; LOGVIVO 1
obtenido: STAGED = las 5 rutas; commit rc 0 `9d190b0`; ARBOL `0`; LOGVIVO `1` → PASA

- **Estado:** completada.
- **Commits:** `9d190b0` fix(pipeline): incluye los resultados con simbologia adicional de la Agencia (D36-1).
- **Cambios sustantivos:** `10_configuracion.R` recibe `SUMA_NIVELES_MIN/MAX`, `UMBRAL_EVALUADOS`, `MOTIVOS_SIMBOLOGIA` (textos con escapes `\u`) y `CODIGOS_LITERALES_SIMBOLOGIA`. `10_utils.R` suma `fila_con_resultado()`, `marca_presente()` y `afirmar_umbral_evaluados()`; `agregar_ponderado()` aplica la regla de D36-1 (ya no filtra por marca ni por umbral; el umbral es `stop()`), pasa a exigir `palu_eda_ele` y `palu_eda_ins`, agrega con `.by=` y suma `n_estab_simb`, `n_evaluados_simb`, `num_{ade,ele,ins}_simb`; los tests pasan a 9 casos. `31` agrega `simbologia` y `cod_simbologia` (código numérico `"2.0"` → `"2"`, literal → código; código sin motivo detiene), esquema 16 columnas. `32` propaga las cinco columnas (19 columnas) y corrige el comentario de filtros. `33` reemplaza los tres filtros por `leer_simce_con_resultado()` (lee el parquet una vez), suma las cinco columnas a `datos`, `simb` a `simce_rbd`, el catálogo `simbologia` (rbd, anio, nivel, prueba, nalu, cod) y `meta$motivos_simbologia`.
- **Regresión:** BUILD T1 rc 0; TAGREG T1 9/9.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** (1) la definición de fila con resultado vive en una función de `10_utils.R` que usan `agregar_ponderado()`, el paso 31 y el paso 33 (alternativa descartada: repetir la expresión en cada paso; reversible). (2) `agregar_ponderado()` exige ahora las tres columnas de porcentaje (la regla las necesita; la alternativa de mantenerlas opcionales dejaría la regla sin evaluar; reversible). (3) Una fila con resultado y `nalu` NA también detiene, igual que `nalu < 10` (reversible). (4) Se suma el caso 9 (todas las filas sin resultado → tibble vacío con esquema), que conserva la cobertura del antiguo caso 6 (reversible). (5) Tras el build T1 se editó solo el encabezado de comentario de `10_configuracion.R` (sin código), antes del commit.
- **Errores propios:** ninguno.
- **Defectos del encargo:** ninguno.
- **Dudas:** ninguna.

### FASE T2: vista de trayectorias

**Paso 0** `bash -c 'git status --porcelain -- <3 rutas del ALCANCE de T2> | wc -l | tr -d " "'`
esperado: 0
obtenido: 0 → PASA

**Verificación T2** (partidas de H4: BUILD f0 rc 0; VTRAY f0 rc 0, 35/35)
`<BUILD T2>`
esperado: rc 0
`<VTRAY T2>`
esperado: rc 0 y `Resultado: 35 pruebas, 35 pasan, 0 fallan` (o no peor que H4 en las pruebas que D36-1 no cambia; los esperados que cambian por D36-1 siguen la regla 9)
obtenido: BUILD T2 (primera corrida) `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 10 segundos ===` → PASA
obtenido: VTRAY T2 (primera corrida) `rc 1` / `R1 FALLA` / `R3 FALLA` / `R5 FALLA` / `R6 FALLA` / `Resultado: 35 pruebas, 31 pasan, 4 fallan` → FALLA en cuatro pruebas cuyos esperados (constantes `ESPERADO_REF_CAT`, `ESPERADO_REF_VIG`, `ESPERADO_REF_OLAS`) cambian por D36-1: el referente gana los establecimientos cuyo único resultado de 2014 traía marca. Se aplica la regla 9.

**Regla 9, recuento independiente** `bash -c 'Rscript "${TMPDIR:-${TEMP:?}}/simce_s36_recuento_R1_R3_R5_R6.R" 2>&1 | tr -d "\r" | command grep -E "^regla_"'` (lee los 18 xlsx, el directorio, `listado_slep_2026.xlsx` y `dim_slep_comunas.csv`; nunca `simce_rbd.parquet`, `10_utils/`, `36_funciones_trayectorias.R` ni la base de la batería; imprime el recuento con la regla vieja como calibración y con D36-1)
esperado: la línea `regla_vieja` reproduce los esperados vigentes (cat 1299, vig 1282, olas 475/406/401, siguen 807); la línea `regla_d36_1` da los nuevos
obtenido: `regla_vieja cat 1299 vig 1282 cerrados 17 olas 2027=475 2028=406 2029=401 siguen_tras_2027 807` / `regla_d36_1 cat 1333 vig 1316 cerrados 17 olas 2027=491 2028=417 2029=408 siguen_tras_2027 825` → PASA (calibrado: la regla vieja reproduce los esperados vigentes)
dato: esperado R1: ESPERADO_REF_CAT 1299 -> 1333 (fuente: `"${TMPDIR:-${TEMP:?}}/simce_s36_recuento_R1_R3_R5_R6.R"`)
dato: esperado R3: ESPERADO_REF_OLAS 2027=475 2028=406 2029=401 -> 2027=491 2028=417 2029=408 (fuente: `"${TMPDIR:-${TEMP:?}}/simce_s36_recuento_R1_R3_R5_R6.R"`)
dato: esperado R5: ESPERADO_REF_VIG 1282 -> 1316 y ESPERADO_REF_OLAS como R3 (fuente: `"${TMPDIR:-${TEMP:?}}/simce_s36_recuento_R1_R3_R5_R6.R"`)
dato: esperado R6: rótulo «1.299 ... 1.282 ... 807 de 1.282» -> «1.333 ... 1.316 ... 825 de 1.316» (derivado de las mismas constantes; fuente: `"${TMPDIR:-${TEMP:?}}/simce_s36_recuento_R1_R3_R5_R6.R"`)
dato: esperado D14: regla vieja «sin marca ni nalu < 10, excluye exactamente esas» -> «sin filas en ceros, 142353 filas y 2008 con simbología» (fuente: `<SONDA1>` en H5, líneas `validas` y `simb`)
dato: esperado D11: texto «y <n> filas con marca de la Agencia» -> «entre ellas <n> resultados con simbología adicional de la Agencia», con <n> recontado por la batería sobre el parquet (la prueba coteja la nota contra su propio recuento; no es una constante)
- error propio: la primera versión del recuento tomó como última cohorte el máximo año del listado completo (incluye las olas 2027 a 2029) y no imprimió nada; se corrigió a la última cohorte del catálogo (año de datos vigente + 1) con `sed -i` sobre el archivo de `<TMP>` (costo: 3 llamadas de diagnóstico).

`<BUILD T2>` (segunda corrida, tras actualizar las constantes)
esperado: rc 0
`<VTRAY T2>` (segunda corrida)
esperado: rc 0 y `Resultado: 35 pruebas, 35 pasan, 0 fallan`
obtenido: BUILD T2 (segunda) `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 10 segundos ===` → PASA
obtenido: VTRAY T2 (segunda) `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA (partida H4 35/35)
dato: D14 en la segunda corrida: filas en ceros 0; filas 142353; con simbología 2008 (sonda, recuento de la batería y columna `simbologia` coinciden); D14c: poner en ceros una fila válida saca exactamente 1.
dato: la nota de filas de la vista escrita cita 610 resultados con simbología adicional incluidos (2,1% de los evaluados) y lleva la primera oración de la nota de D36-1.

**Alcance** `<PRECOMMIT>` y `<MD5 50_encargo.md>`
esperado: las 3 rutas del ALCANCE de T2; `5a0afe4d2c5e1685c0044abcf56621f9`
obtenido: `30_procesamiento/36_funciones_trayectorias.R`, `30_procesamiento/36_trayectorias_template.html`, `30_procesamiento/36_verificar_trayectorias.R`; `5a0afe4d2c5e1685c0044abcf56621f9` → PASA

**Commit** `git add -- <3 rutas>`, `<STAGED>`, `git commit -m "fix(vista): ..." -- <3 rutas>`, `<ARBOL>`, `<LOGVIVO>`
esperado: STAGED = las 3 rutas; commit rc 0; ARBOL 0; LOGVIVO 1
obtenido: STAGED = las 3 rutas; commit rc 0 `c36ae35`; ARBOL `0`; LOGVIVO `1` → PASA

- **Estado:** completada.
- **Commits:** `c36ae35` fix(vista): regla de inclusion D36-1 en la vista de trayectorias.
- **Cambios sustantivos:** `36_funciones_trayectorias.R` deja de definir las tres constantes (vienen de `10_configuracion.R`); `base_valida()` aplica la regla de D36-1 (sin filtro de marca, umbral como `stop()`); `leer_insumos_trayectorias()` exige la columna `simbologia`; `cifras_notas()` cuenta los resultados con simbología incluidos (`FILAS_SIMB`, `PCT_SIMB`; `FILAS_VALIDAS` pasa a todas las filas coherentes; se retiran `FILAS_MARCADAS`, `PCT_MARCADAS` y `UMBRAL`). La plantilla cambia la nota de filas y suma la primera oración de la nota de D36-1. La batería: base independiente (L104-108) con la regla nueva, cabecera, D10 sin `excluir_marcadas`, D11 con el texto nuevo, D14 y D14c nuevos, y las constantes del referente de R1, R3, R5 y R6 por la regla 9.
- **Regresión:** BUILD T2 rc 0; VTRAY T2 35/35.
- **Subagentes:** sin subagentes.
- **Bugs:** el del recuento (error propio arriba), intento 2 de 3.
- **Decisiones autónomas:** (1) `excluir_marcadas` se retira: D10 ya no lo necesita, porque la regla del mockup (incluía las filas marcadas) coincide con D36-1 (la aserción del umbral no saca filas), y D14 se reescribió sin él (alternativa descartada: conservarlo como parámetro muerto; reversible). (2) `cifras_notas()` lee la columna `simbologia` del parquet en lugar de recalcularla desde `marca` (una sola definición, la del paso 31; reversible). (3) El recuento independiente de la regla 9 para R1, R3, R5 y R6 lee además `listado_slep_2026.xlsx` y `dim_slep_comunas.csv`, que el referente y sus olas necesitan y que la regla 9 no enumera (ver defecto del encargo; reversible: el titular puede rechazar el cambio de constantes).
- **Errores propios:** el del recuento (arriba).
- **Defectos del encargo:** `ambiguedad_interpretada`: la regla 9 dice «un script ... que lee solo los xlsx, la glosa y el directorio», pero los esperados de R1, R3, R5 y R6 dependen también del catálogo de Servicios Locales (`listado_slep_2026.xlsx`) y del de olas (`dim_slep_comunas.csv`); se leyó «los xlsx» como los insumos de `20_insumos/` que no son salidas del pipeline, y se sumó el catálogo de olas, manteniendo la independencia que la regla busca (nada del pipeline ni del parquet). Debió decir qué insumos admite el recuento del referente o declarar que R1 a R6 cambiaban.
- **Dudas:** (la duda de abajo se consolida en `## Cierre`) ¿acepta el titular el recuento del referente que lee `listado_slep_2026.xlsx` y `dim_slep_comunas.csv` como recuento independiente de la regla 9 (sí: queda el commit `c36ae35`; no: revertir las constantes de R1 a R6 y dejar esas pruebas en FALLA)? Bloquea solo la aceptación de T2.
- error propio: la línea «Dudas» de arriba se editó después de escrita (se cambió «- duda:» por un texto que remite a `## Cierre`), contra la regla 4 de `<PROT>` §4.3; el contenido de la duda no cambió (costo: 1 edición).

### FASE T3: motor, signo, casilla, modal, CSV y nota

**Paso 0** (medido después de editar; ver error propio) `bash -c 'git -c core.quotePath=false diff --name-only c36ae35 -- 30_procesamiento/33_motor_template.html 30_procesamiento/33_verificar_motor.R | wc -l | tr -d " "'`
esperado: 2 (las dos rutas del ALCANCE de T3 modificadas solo por T3; al cerrar T2, `<ARBOL>` dio 0, así que estaban limpias antes de editar)
obtenido: 2 → PASA
- error propio: el Paso 0 de T3 (`git status --porcelain` del ALCANCE, esperado 0) no se corrió antes de editar; la limpieza previa queda probada por `<ARBOL>` = 0 al cerrar T2 (`c36ae35`), sin otra escritura entre ambos (costo: ninguno sobre el trabajo; desviación de forma).
- error propio: una llamada de shell usó un heredoc vacío sobre el log (`cat >> 50_log.md <<'EOF'` sin contenido), prohibido por el ENTORNO; no agregó bytes (costo: ninguno sobre el archivo).

dato: sondeo exploratorio previo a escribir las pruebas, `"${TMPDIR:-${TEMP:?}}/simce_s36_probar_motor.R"` (chromote sobre el motor del build T3): serie del panorama de Costa Central, 4° básico Lectura 2025, `[55,1194,1]` desmarcada y `[54,1184,1]` marcada; casilla presente; al marcarla, modal con 1 fila y año activo 2025; «‡» en SVG pasa de 4 a 0; Escape cierra; 0 errores de consola.

**Verificación T3** (partidas de H4: BUILD f0 rc 0; VMOTOR f0 rc 0, 8/8; M9 a M11 no existían)
`<BUILD T3>`
esperado: rc 0
`<VMOTOR T3>`
esperado: rc 0 y `Resultado: 11 pruebas, 11 pasan, 0 fallan`, con M9, M10 y M11 en PASA y `m9_ctl_detecta: TRUE` en el detalle de M9
obtenido: BUILD T3 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 10 segundos ===` → PASA
obtenido: VMOTOR T3 `rc 0` / `Resultado: 11 pruebas, 11 pasan, 0 fallan (en 92 segundos)` → PASA (partida H4 8/8)
dato: M9 PASA: desmarcada 55 y 1194 (con simbología 1); marcada 54 y 1184; `m9_ctl_detecta: TRUE`.
dato: M10 PASA: año activo 2025, filas 1 (esperado 1), en territorio y con su motivo; 0 signos «‡» con la casilla marcada; control con una fila de otro territorio plantada detectado.
dato: M11 PASA: comparación y panorama a 375 px, documento 375/375, casilla de 40,0 a 335,0 px; control con la etiqueta sin envolver y de 600 px detectado (documento 640/375).
dato: 🔒8 sobre la salida T3: `command grep -cE "^ *(M3|M8) .*PASA"` → `2`.

**Alcance** `<PRECOMMIT>` y `<MD5 50_encargo.md>`
esperado: las 2 rutas del ALCANCE de T3; `5a0afe4d2c5e1685c0044abcf56621f9`
obtenido: `30_procesamiento/33_motor_template.html`, `30_procesamiento/33_verificar_motor.R`; `5a0afe4d2c5e1685c0044abcf56621f9` → PASA

**Commit** `git add -- <2 rutas>`, `<STAGED>`, `git commit -m "feat(motor): ..." -- <2 rutas>`, `<ARBOL>`, `<LOGVIVO>`
esperado: STAGED = las 2 rutas; commit rc 0; ARBOL 0; LOGVIVO 1
obtenido: STAGED = las 2 rutas; commit rc 0 `f0b8ba5`; ARBOL `0`; LOGVIVO `1` → PASA

- **Estado:** completada.
- **Commits:** `f0b8ba5` feat(motor): signo, casilla de exclusion y modal de simbologia adicional (D36-1).
- **Cambios sustantivos:** `SimceData` gana el estado `EXCLUIR_SIMB` (`setExcluirSimb`, `getExcluirSimb`), `aporteDatos()`/`sumarAporte()` (restan los subtotales `_simb` de `datos`) y `esSimbRbd()` (salta `simb == 1` de `simce_rbd`) en los cinco generadores; cada punto trae `n_simb` (establecimientos con simbología del agregado, incluidos o excluidos). «‡» (`ASTERISCO_SIMB`, `conMarcaSimb()` tras `conMarcaUnico()`, familia `FONT_SIGNO`) en sparkline, barras, tabla, panorama y tooltip (con la línea «‡ Incluye <n> establecimiento(s) ...»), y en la leyenda de la comparación. `CasillaSimb` después de «Exportar PNG» en comparación y panorama, con `title`/`aria-label` literales y el enlace «ver lista». `ModalSimbologia` (clases del modal «Agregar territorio»; × , Escape y clic fuera). Los dos CSV suman `n_estab_simbologia` y `excluye_simbologia`. Nota «Resultados con simbología adicional» con el texto literal de D36-1 punto 6 (la nota de fórmula no menciona filtros: sin cambio). Los gráficos se redibujan con un contexto de React (`SimbCtx`) en las dependencias de sus efectos. Batería: M9, M10 y M11.
- **Regresión:** BUILD T3 rc 0; VMOTOR T3 11/11.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** (1) En el panorama, que no tiene selector de prueba, el modal lista las dos pruebas del nivel activo y su subtítulo dice «Lectura y Matemática» (alternativa: solo la prueba de la comparación, que el panorama no muestra; reversible). (2) Los territorios por comuna se filtran con `DATA.establecimientos` (directorio de establecimientos operativos), como pide el catálogo sin comuna; un establecimiento con simbología que ya no está en el directorio no aparece en la lista de un territorio por comuna, aunque cuente en `n_simb` (ver nota para el revisor; reversible). (3) La leyenda de la comparación suma el ítem «‡ Incluye simbología adicional de la Agencia» cuando la casilla está desmarcada, junto al de «†» (alternativa: solo tooltip y nota; reversible). (4) El tooltip pluraliza «establecimiento/establecimientos» en lugar del literal «establecimiento(s)» (reversible).
- **Errores propios:** los dos de arriba (Paso 0 tardío y heredoc vacío).
- **Defectos del encargo:** ninguno.
- **Dudas:** ninguna.

### FASE T4: documentación

**Paso 0** `bash -c 'git status --porcelain -- README.md 50_documentacion/activa/referencia_glosas_simce.md 50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md | wc -l | tr -d " "'`
esperado: 0
obtenido: 0 → PASA

dato: copia del insumo de decisión con `bash -c 'cp .../anexos/50_insumo_decision_d36_1.md.txt 50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md; echo $?'` → `0`.
- error propio: tras la copia corrí `git add -N` sobre el archivo nuevo (intención de agregar), un comando que §0.2 no autoriza; no cambia el contenido y el archivo entra igual en el commit de T4 con `git add --` (costo: ninguno sobre el resultado).

**Verificación T4** (partidas: grep «supresión» en README `1`; archivos con «D36-1» `0`)
`bash -c 'git grep -n -i -E "marcas? de supresi" -- README.md | wc -l | tr -d " "'`
esperado: 0
`bash -c 'git grep -c "D36-1" -- README.md 50_documentacion/activa/referencia_glosas_simce.md | wc -l | tr -d " "'`
esperado: 2
`bash -c 'test -f 50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md; echo $?'`
esperado: 0
`<MD5>` de la decisión copiada
esperado: `2b89f14e2fd4498e379cb5941699f3d7` (el del insumo)
obtenido: `0` → PASA (partida 1)
obtenido: `2` → PASA (partida 0)
obtenido: `0` → PASA
obtenido: `2b89f14e2fd4498e379cb5941699f3d7` → PASA

**Alcance** `<PRECOMMIT>` y `<MD5 50_encargo.md>`
esperado: las 3 rutas del ALCANCE de T4; `5a0afe4d2c5e1685c0044abcf56621f9`
obtenido: `50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md`, `50_documentacion/activa/referencia_glosas_simce.md`, `README.md`; `5a0afe4d2c5e1685c0044abcf56621f9` → PASA

**Commit** `git add -- <3 rutas>`, `<STAGED>`, `git commit -m "docs(d36-1): decision, README y glosas" -- <3 rutas>`, `<ARBOL>`, `<LOGVIVO>`
esperado: STAGED = las 3 rutas; commit rc 0; ARBOL 0; LOGVIVO 1
obtenido: STAGED = las 3 rutas; commit rc 0 `e4652b6`; ARBOL `0`; LOGVIVO `1` → PASA

- **Estado:** completada.
- **Commits:** `e4652b6` docs(d36-1): decision, README y glosas.
- **Cambios sustantivos:** decisión copiada desde el insumo (md5 idéntico). README: «Reglas de cálculo» pasa de «Filtros de exclusión» a la regla de inclusión de D36-1 con su enlace; la columna `marca` deja de ser «Marca de supresión»; los esquemas suman `simbologia`, `cod_simbologia` y las columnas `_simb` de `simce_comunal.parquet`, y `n_evaluados` deja de decir «tras filtros MINEDUC». Glosas, A2: «Resuelta por D36-1 (2026-11-09): deroga la opción a».
- **Regresión:** no tocó código; regresión «no aplica».
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** sumar a los esquemas del README las columnas nuevas de T1 (el encargo pide solo L138-140 y L214; sin ellas el README describiría un parquet que ya no existe; reversible).
- **Errores propios:** el `git add -N` de arriba.
- **Defectos del encargo:** ninguno.
- **Dudas:** ninguna.

### FASE R: auditoría y reparación

**Paso 1, inventario** (29 afirmaciones, R-01 a R-29, escrito antes de auditar): `anexos/50_R_inventario.txt`, md5 `b6197c334a481c8461f7f4b867d82c02`, 31 líneas (R-01 a R-07 FASE 0; R-08 a R-11 T1; R-12 a R-15 T2; R-16 T3; R-17 T4; R-18 commits; R-19 alcance global; R-20 md5 del encargo; R-21 a R-29 los nueve invariantes).

**Paso 5, regresión completa** (va primero porque las re-derivaciones del paso 2 leen sus salidas)
`<BUILD r>`
esperado: rc 0
`<TAGREG r>`
esperado: rc 0 y `OK: 9/9 ...`
`<VMOTOR r>`
esperado: rc 0 y `Resultado: 11 pruebas, 11 pasan, 0 fallan`
`<VTRAY r>`
esperado: rc 0 y `Resultado: 35 pruebas, 35 pasan, 0 fallan`
`<SONDA1>`
esperado: la fila S1
`<SONDA2 r>`
esperado: `cc_4b_lect_2025 55 1194` / `cc_4b_mate_2025 53 1187` / `simce_rbd 142353` / `simb 2008` / `catalogo 2008` / `ceros_json 0`
obtenido: BUILD r `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 11 segundos ===` → PASA
obtenido: TAGREG r `rc 0` / `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.` → PASA
obtenido: VMOTOR r `rc 0` / `Resultado: 11 pruebas, 11 pasan, 0 fallan (en 92 segundos)` → PASA
obtenido: VTRAY r `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
obtenido: SONDA1 `validas 142353` / `simb 2008` / `ceros 8216` / `cc_4b_lect_2025 55 1194 54 1184` / `cc_4b_mate_2025 53 1187 52 1175` / `codigos 1 | 2 | 3 | 4 | Ajenas a la Agencia: Resultados no representativos | Ajenas al Establecimiento: Resultados no representativos | Alumnos insuficientes` → PASA
obtenido: SONDA2 r `cc_4b_lect_2025 55 1194` / `cc_4b_mate_2025 53 1187` / `simce_rbd 142353` / `simb 2008` / `catalogo 2008` / `ceros_json 0` → PASA

**Paso 2, re-derivación independiente** `bash "${TMPDIR:-${TEMP:?}}/simce_s36_R_rederivar.sh"` (md5 con `Rscript -e "cat(unname(tools::md5sum(...)))"`, conteos con `git grep -c`, commits con `git log`); las cifras del JSON con `<SONDA2 r>` (arriba)
esperado: md5 del encargo `5a0afe4d...`, de los cuatro insumos y del directorio iguales a H3, de la decisión copiada `2b89f14e...`; `git grep -c` «supresión» en 10_utils, 30_procesamiento y README: 0 archivos; «D36-1»: README y glosas; `git log` con los 5 commits del encargo sobre `d32ad14`
obtenido: `5a0afe4d2c5e1685c0044abcf56621f9` / `2b89f14e2fd4498e379cb5941699f3d7` / `d7b79d59153081df784ac0fcf31843ec` / `62c88269ebdf2deed1d7f34624ce93e2` / `b3b9b224901a8365f92bc140657ebcfb` / `80be2b37bf1879dd47875422641bd297` / `2b89f14e2fd4498e379cb5941699f3d7`; «supresión» `0`; «D36-1» `referencia_glosas_simce.md:1`, `README.md:5`; `e4652b6`, `f0b8ba5`, `c36ae35`, `9d190b0`, `eee2b50` sobre `d32ad14` → PASA

**Paso 3, invariantes** `bash "${TMPDIR:-${TEMP:?}}/simce_s36_R_invariantes.sh"` (los comandos de §0.4; 🔒7 sale de `<SONDA2 r>` y `<SONDA1>` de arriba)
esperado: 🔒1 `28` y `0`; 🔒2 `0`; 🔒3 `d32ad14`; 🔒4 `0`; 🔒5 `0 0`; 🔒6 `0`; 🔒7 `0` y `8216`; 🔒8 `2` y `1`; 🔒9 `80be2b37bf1879dd47875422641bd297` y `0`
obtenido: 🔒1 `28` / `0`; 🔒2 `0`; 🔒3 `d32ad14`; 🔒4 `0`; 🔒5 `0 0`; 🔒6 `0`; 🔒7 `ceros_json 0` / `ceros 8216`; 🔒8 `2` / `1`; 🔒9 `80be2b37bf1879dd47875422641bd297` / `0` → PASA los nueve

**Paso 4, alcance global** (comando de §6 paso 4 y md5 del encargo; 🔒4 arriba)
esperado: `0` y `5a0afe4d2c5e1685c0044abcf56621f9`
obtenido: `0` y `5a0afe4d2c5e1685c0044abcf56621f9` → PASA

**Paso 6, control positivo** `<TMP>/simce_s36_sonda_json_plantada.R` (copia de la sonda S2 con `d$cod_depe2 == "5"` cambiado por `d$cod_depe2 == "1"` con la herramienta de edición), sobre `"${TMPDIR:-${TEMP:?}}/simce_s36_motor_r.html"`
esperado: una línea `cc_4b_lect_2025` distinta de `cc_4b_lect_2025 55 1194`
obtenido: `cc_4b_lect_2025 0 0` → PASA (el instrumento distingue)

dato: medición para el hallazgo R-30, `"${TMPDIR:-${TEMP:?}}/simce_s36_catalogo_sin_directorio.R"` sobre el motor final: `catalogo 2008 sin_directorio 25 anio_2025_sin_directorio 0`.

**Paso 7, hallazgos**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1 y árbol de FASE 0 | `git rev-parse --short eee2b50~1` | `d32ad14` | `d32ad14` | ninguna | ninguna | no aplica | no aplica |
| R-02 | md5 de H3 | `tools::md5sum` | los de H3 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-03 | hash_inicial `eee2b50` | `git log --format="%h %s"` | docs(encargo) | `eee2b50 docs(encargo): ...` | ninguna | ninguna | no aplica | no aplica |
| R-05, R-06, R-10 | cifras de las sondas y del JSON | `<SONDA1>`, `<SONDA2 r>` | filas S1 y T1 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-04, R-08, R-09, R-12, R-16 | baterías y build | regresión completa (paso 5) | rc 0, 9/9, 11/11, 35/35 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-07, R-11, R-17 | conteos de texto | `git grep -c` | 0 y 2 archivos | 0 y 2 | ninguna | ninguna | no aplica | no aplica |
| R-13 | esperados del referente por regla 9 | `simce_s36_recuento_R1_R3_R5_R6.R` (T2) y VTRAY r | 1333/1316/491-417-408 | VTRAY r 35/35 | ADVIERTE | el recuento lee `listado_slep_2026.xlsx` y `dim_slep_comunas.csv`, fuera de la lista literal de la regla 9; duda al titular | no aplica | no aplica |
| R-14, R-15 | D14 y nota de la vista | VTRAY r | PASA | PASA | ninguna | ninguna | no aplica | no aplica |
| R-18 | commits del encargo | `git log` | 4 de tarea + docs(encargo) | 5 | ninguna | ninguna | no aplica | no aplica |
| R-19, R-20 | alcance global y md5 del encargo | paso 4 | 0 y `5a0afe4d...` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-21 a R-29 | invariantes 1 a 9 | paso 3 | §3 | PASA los nueve | ninguna | ninguna | no aplica | no aplica |
| R-30 | modal de simbología en territorios por comuna | `simce_s36_catalogo_sin_directorio.R` | 0 filas sin directorio | 25 de 2008 (0 en 2025) | ADVIERTE | esas filas cuentan en el «‡» y en `n_simb`, pero el modal no las ubica en un territorio por comuna (no están en `establecimientos`); sin efecto en 2025 ni en M9 a M11 | no aplica | no aplica |
| R-31 | lecturas previas al testigo | sección FASE 0 | declaradas | 5 lecturas declaradas | ADVIERTE | registradas (contrato de arranque) | no aplica | no aplica |
| R-32 | errores propios de forma | secciones FASE 0, T2, T3, T4 | ninguno | 7 registrados | ADVIERTE | registrados; ninguno cambió un resultado | no aplica | no aplica |

**Paso 8, ciclo de reparación:** no se abrió (0 REPARA).
**Paso 9, prohibiciones:** ningún criterio, tolerancia ni esperado se ajustó en esta fase; ningún ALCANCE ampliado; ningún 🔒 tocado.
**Paso 10, veredicto global:** `APROBADO CON ADVERTENCIAS` (BLOQUEA 0, REPARA 0, ADVIERTE 4: R-13, R-30, R-31, R-32).

- **Estado:** completada.
- **Commits:** ninguno.
- **Subagentes:** sin subagentes.
- **Errores propios:** ninguno nuevo.

## Cierre

(escrito después: FASE L)

1. Resumen de la sesión: entró el encargo D36-1 (inclusión de todos los resultados por estándar publicados, también los que traen simbología adicional, con «‡», casilla de exclusión y modal en el motor). Siete fases: FASE 0, T1 a T4, FASE R y FASE L. T1 completada (`9d190b0`), T2 completada (`c36ae35`), T3 completada (`f0b8ba5`), T4 completada (`e4652b6`). FASE R: `APROBADO CON ADVERTENCIAS`.
2. Inventario de commits (`git log eee2b50..HEAD --oneline`; `eee2b50` docs(encargo) es `hash_inicial`):
   - `e4652b6` docs(d36-1): decision, README y glosas · T4
   - `f0b8ba5` feat(motor): signo, casilla de exclusion y modal de simbologia adicional (D36-1) · T3
   - `c36ae35` fix(vista): regla de inclusion D36-1 en la vista de trayectorias · T2
   - `9d190b0` fix(pipeline): incluye los resultados con simbologia adicional de la Agencia (D36-1) · T1
   - El commit `docs(log)` de este log se anota en el reporte.
3. Tabla de auditoría: la de `### FASE R: auditoría y reparación` (pasos 7 y 10), referenciada y no copiada. Veredicto `APROBADO CON ADVERTENCIAS`; BLOQUEA 0, REPARA 0, ADVIERTE 4 (R-13, R-30, R-31, R-32); reparados 0; abiertos 0 REPARA.
4. Verificación de invariantes (FASE R paso 3, salida literal en esa sección):
   - 🔒1 datos: PASA (`28` y `0`)
   - 🔒2 `docs/` intacto: PASA (`0`)
   - 🔒3 sin push ni fetch: PASA (`d32ad14`)
   - 🔒4 alcance: PASA (`0`)
   - 🔒5 sin atribución: PASA (`0 0`)
   - 🔒6 encargo, insumos y sondas intactos: PASA (`0`)
   - 🔒7 filas en ceros fuera: PASA (`ceros_json 0`, `ceros 8216`)
   - 🔒8 reglas de v34 y v35 (M3, M8, R4): PASA (`2` y `1`)
   - 🔒9 directorio y `20_insumos/` intactos: PASA (`80be2b37bf1879dd47875422641bd297` y `0`)
5. Decisiones del usuario registradas: D36-1, D36-1a, D36-2 y D36-3 (tabla de §2 del encargo); la decisión quedó en `50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md` (T4). Ningún gate nuevo durante la sesión.
6. Estado de cifras: cambian por diseño las cifras publicadas del motor y la vista (D36-1). Costa Central 4° básico 2025: Lectura 55 y 1.194 (54 y 1.184 con la casilla), Matemática 53 y 1.187; `simce_rbd` 142.353 filas con 2.008 con simbología; 0 filas en ceros (sondas S1 y S2 en FASE R). Intactos: directorio (md5 `80be2b37...`), `20_insumos/` y `docs/`.
7. Dudas y pendientes:
- duda: el recuento independiente de la regla 9 para R1, R3, R5 y R6 leyó también `listado_slep_2026.xlsx` y `dim_slep_comunas.csv`, que la regla no enumera. ¿Lo acepta el titular como recuento independiente (sí: quedan las constantes 1.333, 1.316 y 491/417/408 de `c36ae35`; no: se revierten esas constantes y R1, R3, R5 y R6 quedan en FALLA)? Bloquea solo la aceptación de T2.
8. Errores propios:
- error propio: FASE 0, cuatro líneas `obtenido (Hn):` que no cuentan para la paridad; repuestas con la forma legal (1 edición).
- error propio: FASE 0, `cat` para leer el encargo y el insumo antes del testigo, comando no listado en §0.2 punto 0 (lectura sin efecto).
- error propio: T2, la primera versión del recuento de la regla 9 tomó mal la última cohorte y no imprimió nada (3 llamadas de diagnóstico).
- error propio: T2, la línea «Dudas» de la sección se editó después de escrita, contra `<PROT>` §4.3 regla 4 (1 edición; contenido igual).
- error propio: T3, el Paso 0 se midió después de editar (la limpieza previa la prueba `<ARBOL>` = 0 al cerrar T2).
- error propio: T3, un heredoc vacío sobre el log, prohibido por el ENTORNO (0 bytes agregados).
- error propio: T4, `git add -N` sobre la decisión copiada, no autorizado por §0.2 (sin efecto sobre el resultado).
9. Notas para el revisor: (a) mirar el motor generado con la casilla marcada y desmarcada en comparación y panorama, en especial el «‡» dentro de las franjas angostas del panorama y el ítem nuevo de la leyenda; (b) el modal en el panorama lista las dos pruebas del nivel (decisión autónoma de T3); (c) R-30: 25 de las 2.008 filas del catálogo (ninguna de 2025) son de establecimientos que ya no están en el directorio de operativos y el modal no las ubica en territorios por comuna, aunque cuentan en «‡»; (d) el README suma a los esquemas las columnas nuevas de T1, algo que el encargo no pedía; (e) la nota de filas de la vista dice ahora «entran ... entre ellas 610 resultados con simbología adicional».
10. Estado de cierre: commiteados `eee2b50`, `9d190b0`, `c36ae35`, `f0b8ba5`, `e4652b6` y el `docs(log)` de este log, todo local. No se publica: sin push y sin copia a `docs/` (D36-3). Queda al titular revisar `40_salidas/motor_comparacion.html` y `40_salidas/trayectorias_traspasos.html` y, si los aprueba, copiarlos a `docs/`, commitear y hacer push.
11. Calidad del encargo:

| tipo | cita del encargo | que_ocurrio | que_debio_decir | escapo_a |
|---|---|---|---|---|
| ambiguedad_interpretada | «un script `<TMP>/simce_s36_recuento_<prueba>.R` que lee solo los xlsx, la glosa y el directorio» (regla 9) | R1, R3, R5 y R6 cambian por D36-1 y su esperado depende del catálogo de Servicios Locales y del de olas; se leyó «los xlsx» como los insumos de `20_insumos/` que no son salidas del pipeline y se sumó `dim_slep_comunas.csv` | nombrar los insumos admitidos para el recuento del referente, o anticipar que R1 a R6 cambiaban | simulacion |

12. Fricciones de entorno:
- friccion: FASE 0, `TZ=America/Santiago date -Iseconds` en Git Bash devuelve `+00:00` (sin base de zonas horarias) → `inicio` y `fin` se registran con ese offset, comparables entre sí.
13. Intervenciones y tiempos: ninguna intervención registrada (los diálogos de permisos aprobados no son observables: `no_medible`). Inicio `2026-11-09T15:11:36+00:00`, fin `2026-11-09T15:44:43+00:00`, duración 00:33. Compactaciones de contexto: 0.

**FASE L, paso 1** (comando del paso 4 de FASE R) (escrito después: FASE L)
esperado: 0
obtenido: 0 → PASA

**FASE L, paso 5** `bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=<log>; echo "rc $?"'` (escrito después: FASE L)
esperado: rc 0
obtenido: `valida 50_documentacion/encargos/202611/20261109_inclusion_resultados_simbologia` / `rc 0` → PASA (sin reintento)

**FASE L, paso 6** `<PRIVACIDAD>` (escrito después: FASE L)
esperado: rc 1 y rc 1
obtenido: `rc 1` / `rc 1` → PASA (sin rutas personales, raya larga ni RUT; el log no nombra establecimientos)

dato: FASE L paso 7 (comando de §0.4), antes de estas líneas: permisos `-rw-r--r--`; 442 líneas; `head -1` = `---`; termina en salto de línea `1`; `^### FASE` 6 (FASE 0, T1 a T4, FASE R); `^esperado:` 52 más `^- faltante: esperado de` 0 igual a `^obtenido:` 52; `^## J` 1. Sin faltantes.
