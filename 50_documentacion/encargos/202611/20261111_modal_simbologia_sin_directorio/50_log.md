---
expediente: 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio
repo: slep_simce_adecuado
encargo_md5: "37a4967706ee3a32b1a37238e529b803"
origen: ninguno
inicio: 2026-11-11T17:52:07+00:00
fin: 2026-11-11T18:15:03+00:00
hash_inicial: "3c405e9"
hash_final: "248ff75"
auditoria_redaccion: {nivel: 2, puntaje: 3, rondas: 3, bloquea: 2, corregir: 25, menor: 28, menor_abiertos: 0, completa: "si"}
resultado_meta: cumplida
tareas: {completadas: 2, congeladas: 0, no_ejecutadas: 0}
fase_r: {veredicto: "APROBADO CON ADVERTENCIAS", bloquea: 0, repara: 0, advierte: 3, reparados: 0}
invariantes: {pasa: 4, total: 4}
errores_propios: 3
defectos_encargo: 0
fricciones_entorno: 0
dudas_abiertas: 1
intervenciones_humanas: 0
compactaciones_contexto: {n: 0, fases: []}
subagentes: {opus: 0, intermedios: 0}
push: "no"
---

# Log · modal_simbologia_sin_directorio

- **Meta:** que el modal «Resultados excluidos del cálculo» del motor liste exactamente los establecimientos que cuenta el «‡» de cada territorio, también los que ya no están en el directorio vigente, ubicándolos con la comuna y la dependencia de la fila Simce y nombrándolos con el `nom_rbd` de la base de la Agencia cuando el directorio no los trae (D36-13, opción A del titular); commits locales, sin push y sin copiar a `docs/`.
- **Fecha:** 2026-11-11.
- **Repo y rama:** `slep_simce_adecuado`, `main` (declarados por el encargo; se miden en H1).
- **EXPEDIENTE:** `50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio` · **ORIGEN:** `ninguno`.
- **ENTORNO:** Claude Code en la estación Windows del titular (`estacion_windows`), Git Bash, lanzado en la raíz del repo; titular presente de punta a punta, sin FASE −1; sin red (ningún `fetch`, `pull` ni `push`).
- **EJECUCIÓN:** declarada esfuerzo `high`, orquestador el modelo de la sesión, subagentes 0, total Opus 0; modo real de la sesión: el que fijó el titular al lanzarla (no observable desde dentro de la sesión), sin subagentes.
- **AUDITORÍA DE REDACCIÓN:** nivel 2 (puntaje 3: C1 y C8); 3 rondas; anexo del encargo.
- **Grafo:** T1 → T2 (T2 lee el catálogo que T1 agrega). FASE R y FASE L fuera del grafo.
- **Concurrencia:** sin subagentes.
- **Topes:** 3 intentos por bug; 1 ciclo de reparación en FASE R; 1 reintento por comando con falla transitoria.

## J. Juicio
- Meta y resultado: que el modal de simbología liste exactamente los establecimientos que cuenta el «‡» de cada territorio, también los que ya no están en el directorio vigente, ubicados con la comuna y la dependencia de la fila Simce y nombrados con la base de la Agencia; commits locales sin push ni `docs/` → cumplida.
- Estado por tarea: T1 completada (d32d433) · T2 completada (248ff75).
- Commits: 2 en 3c405e9..248ff75 (`git log --oneline --first-parent`; sin contar `docs(encargo)`, que es hash_inicial, ni `docs(log)`), de los cuales 0 fix(auditoria).
- Auditoría (FASE R): APROBADO CON ADVERTENCIAS; hallazgos B/R/A = 0/0/3; reparados 0; abiertos 0 (ninguno).
- Auditoría de redacción: nivel 2 (puntaje 3); rondas 3; BLOQUEA/CORREGIR/MENOR = 2/25/28; MENOR abiertos 0.
- Invariantes: 4/4 PASA; FALLA: ninguno.
- Cifras críticas: intactas (evidencia: `50_sonda_json_igual.R` da `igual TRUE` entre el motor de FASE 0 y el final, sin el catálogo `simbologia`; VTRAY 35/35 igual a su línea base).
- Decisiones autónomas de mayor riesgo: (1) el índice del directorio se arma dentro de `filasSimbologia` en cada llamada (alternativa: un índice de nivel superior, más rápido en M12); (2) nombre y comuna con respaldo encadenado, de modo que un nombre vacío del directorio cae al de la base (alternativa: condicional solo por presencia en el directorio); (3) el control de M12 exige que `difieren` suba sobre su valor previo y vuelva al restituir (alternativa: solo «mayor que 0»). Las tres son reversibles.
- Desviaciones respecto del encargo: un `cat` no listado en §0.2; el md5 del paso 3 de FASE 0 medido antes de anotar su rótulo; FASE R sumó una re-derivación de M12 en R que el encargo no pedía.
- Calidad del encargo: 0 defectos; escapo_a: ninguno.
- Dudas abiertas: 1; ¿se cambia el pie del modal para citar también la base de la Agencia como fuente de nombres (sí/no)?
- Errores propios: 3 registrados (4.1); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: la lectura visual del modal (casilla marcada, un territorio por comuna, un año antiguo: nombres y comuna de los resultados sin directorio) y el pie del modal.
- No publicado / queda al usuario: push retenido y copia a `docs/` pendiente; revisión visual del modal; decisión sobre la duda del pie.
- Ejecución: modo de sesión high; subagentes 0, por contrato; duración 00:22 (ficha); compactaciones de contexto 0.

## Registro por fase

### FASE 0: log, punto de retorno y línea base

dato: testigo `bash -c 'test "$(pwd -P)" = "$(cd "$(git rev-parse --show-toplevel)" && pwd -P)" && test -f 00_build.R && printf "testigo s36r\n" > "${TMPDIR:-${TEMP:?}}/simce_s36r_testigo.txt" && echo raiz_ok'` → `raiz_ok` (escrito después: paso 0)
dato: llamada de las rutas corrida (`cygpath -w` de la raíz, del temporal y del kit); salida solo a la terminal (escrito después: paso 0)
dato: herramientas de lectura, edición (`testigo s36r` → `testigo s36r editado`) y escritura ejercidas sobre `"${TMPDIR:-${TEMP:?}}/simce_s36r_testigo.txt"` y `"${TMPDIR:-${TEMP:?}}/simce_s36r_lecturas.txt"` sin denegación (escrito después: paso 0)
dato: lecturas previas al testigo: solo el encargo (no se lista); ninguna otra (`"${TMPDIR:-${TEMP:?}}/simce_s36r_lecturas.txt"`) (escrito después: paso 0)
dato: lecturas entre el testigo y la creación del log: `<PROT>` (encabezados, L818-1027 y L1585-1924) y el log de `20261109_inclusion_resultados_simbologia` (modelo de forma); `ls` de `50_documentacion/encargos/202611/` y `wc -l` de sus logs (escrito después: paso 0)
dato: inicio `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-11T17:52:07+00:00` (offset `+00:00`: fricción conocida del encargo, registrada tal cual)
- error propio: la llamada que comprobó el testigo editado y listó los encabezados de `<PROT>` usó `cat` sobre el testigo, comando que §0.2 punto 0 no lista entre los de solo lectura; lectura sin efecto (costo: ninguno).

**H1** `bash -c 'basename "$(git remote get-url origin)" .git'`; `git rev-parse --short HEAD`; `git rev-parse --short origin/main`; `git symbolic-ref --short HEAD`; `bash -c 'git stash list | wc -l | tr -d " "'`; `bash -c 'git diff --cached --name-only | wc -l | tr -d " "'`
esperado: slep_simce_adecuado / 2eb0483 / 2eb0483 / main / 0 / 0

**Árbol** `bash -c 'git -c core.quotePath=false status --porcelain --untracked-files=all | LC_ALL=C sort'` (comparado con `diff` contra `"${TMPDIR:-${TEMP:?}}/simce_s36r_arbol_esperado.txt"`, que lleva las 5 líneas de §4 paso 2)
esperado: exactamente 5 líneas `??` del expediente (`50_encargo.md`, `50_log.md`, `anexos/50_sonda_catalogo.R`, `anexos/50_sonda_catalogo_alt.R`, `anexos/50_sonda_json_igual.R`); diff rc 0

**H3** `<MD5>` de `anexos/50_sonda_catalogo.R`, `anexos/50_sonda_catalogo_alt.R` y `anexos/50_sonda_json_igual.R`
esperado: b0c4609c4a91e2c1bd910a7837805142 / 33d1cee79d6afe9248df70a881397fff / d30362ed33555966894685414e36a06f

**H2** `bash -c 'for f in 20_insumos/simce/*/*.xlsx; do unzip -p "$f" xl/sharedStrings.xml | command grep -c "<t>nom_rbd</t>"; done | awk "{n[\$1]++} END{for (k in n) print n[k], k}"'`
esperado: 18 1
obtenido: H1 `slep_simce_adecuado` / `2eb0483` / `2eb0483` / `main` / `0` / `0` → PASA
obtenido: árbol, las 5 líneas `??` esperadas; diff `rc 0` → PASA
obtenido: H3 `b0c4609c4a91e2c1bd910a7837805142` / `33d1cee79d6afe9248df70a881397fff` / `d30362ed33555966894685414e36a06f` → PASA
obtenido: H2 `18 1` → PASA
dato: las cuatro mediciones anteriores corrieron juntas en `bash "${TMPDIR:-${TEMP:?}}/simce_s36r_f0_h.sh"`, con los comandos transcritos.
dato: `bash -c 'command -v Rscript >/dev/null && test -n "${HERRAMIENTAS_DEV_PATH:-}" && test -f "$HERRAMIENTAS_DEV_PATH/plantillas/98_indexar_encargos.R"; echo $?'` → `0` (no detiene)

**Línea base**
`<BUILD f0>`
esperado: rc 0
`<TAGREG f0>`
esperado: rc 0 y `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.`
`<CAT f0>`
esperado: `cat: rows=2008 com=ausente depe=ausente grupo=ausente nom=ausente largos_iguales=TRUE sin_directorio=25`
`<VMOTOR f0>` (no detiene; línea base)
esperado: rc 0 y `Resultado: 11 pruebas, 11 pasan, 0 fallan` (la duración no se compara)
`<VTRAY f0>` (no detiene; su línea `Resultado:` es la línea base de 🔒1)
esperado: rc 0
obtenido: BUILD f0 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 17 segundos ===` → PASA
obtenido: TAGREG f0 `rc 0` / `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.` → PASA
obtenido: CAT f0 `cat: rows=2008 com=ausente depe=ausente grupo=ausente nom=ausente largos_iguales=TRUE sin_directorio=25` → PASA (copia `"${TMPDIR:-${TEMP:?}}/simce_s36r_motor_f0.html"` hecha)
obtenido: VMOTOR f0 `rc 0` / `Resultado: 11 pruebas, 11 pasan, 0 fallan (en 96 segundos)` → PASA
obtenido: VTRAY f0 `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
dato: línea base de 🔒1 (VTRAY f0): `Resultado: 35 pruebas, 35 pasan, 0 fallan`

**Paso 3** `bash -c 'md5sum "50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_encargo.md" | cut -d" " -f1'` → `encargo_md5`
dato: encargo_md5 `37a4967706ee3a32b1a37238e529b803`; `auditoria_redaccion` copiada del anexo a la ficha (nivel 2, puntaje 3, rondas 3; BLOQUEA 0+2+0 = 2, CORREGIR 10+14+1 = 25, MENOR 12+13+3 = 28; MENOR abiertos 0; condición completa).

**Paso 4** `git add --` de las 4 rutas (encargo y tres sondas), `<STAGED>`, `git commit -m "docs(encargo): modal_simbologia_sin_directorio" -- <las 4 rutas>`, `hash_inicial`, `<ARBOL>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36r_f0_commit.sh"`, que commitea solo si `<STAGED>` es igual a las 4 rutas)
esperado: STAGED = las 4 rutas (`50_encargo.md`, `anexos/50_sonda_catalogo.R`, `anexos/50_sonda_catalogo_alt.R`, `anexos/50_sonda_json_igual.R`); commit rc 0; ARBOL 0
obtenido: STAGED = las 4 rutas (`staged_ok`); commit rc 0, `[main 3c405e9] docs(encargo): modal_simbologia_sin_directorio`, 4 archivos; `hash_inicial` `3c405e9`; ARBOL `0` → PASA
dato: [ locale ] 1 líneas (build f0)

- **Estado:** completada.
- **Commits:** `3c405e9` docs(encargo): modal_simbologia_sin_directorio.
- **Cambios sustantivos:** ninguno sobre código; el log creado, la línea base tomada y el punto de retorno fijado.
- **Alcance:** el log y archivos `simce_s36r_` del temporal; el build escribió en `40_salidas/` (ignorado; `<ARBOL>` `0`). ⊆ ALCANCE de FASE 0. md5 del encargo `37a4967706ee3a32b1a37238e529b803` (ficha).
- **Regresión:** línea base tomada (BUILD rc 0, TAGREG 9/9, CAT con 25 sin directorio, VMOTOR 11/11, VTRAY 35/35).
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** el commit de FASE 0 va dentro de un `.sh` que compara `<STAGED>` con las 4 rutas esperadas y commitea solo si coinciden (alternativa descartada: dos llamadas separadas; reversible).
- **Errores propios:** el `cat` sobre el testigo (arriba); además el md5 del encargo del paso 3 se midió en la misma llamada que el `wc -l` de los archivos de los ALCANCE, antes de anotar el rótulo del paso en el log (medición sin esperado, `dato:`; sin costo).
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna nueva (el offset `+00:00` de `date` es la fricción conocida que el encargo manda registrar como `dato:`).
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** ninguna.

### FASE T1: el catálogo de simbología lleva comuna, dependencia y nombre de la base

**Paso 0** `bash -c 'git status --porcelain -- 30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_generar_html.R README.md | wc -l | tr -d " "'`
esperado: 0

**Verificación T1** (partidas de FASE 0: BUILD f0 rc 0; TAGREG f0 9/9; CAT f0 `com=ausente depe=ausente grupo=ausente nom=ausente`)
`<BUILD T1>`
esperado: rc 0
`<TAGREG T1>`
esperado: rc 0 y `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.`
`<CAT T1>`
esperado: `cat: rows=2008 com=2008 depe=2008 grupo=2008 nom=2008 largos_iguales=TRUE sin_directorio=25`

**Alcance T1** `<PRECOMMIT>` y `<MD5 50_encargo.md>`
esperado: `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_generar_html.R README.md`; `37a4967706ee3a32b1a37238e529b803`

**Commit T1** `git add -- <3 rutas>`, `<STAGED>`, `git commit -m "feat(pipeline): catalogo de simbologia con comuna, dependencia y nombre de la base (D36-13)" -- 30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_generar_html.R README.md`, `<ARBOL>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36r_T1_commit.sh"`, que commitea solo si `<PRECOMMIT>`, el md5 y `<STAGED>` son los esperados)
esperado: STAGED = las 3 rutas; commit rc 0; ARBOL 0
obtenido: Paso 0 `0` → PASA
obtenido: BUILD T1 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 13 segundos ===` → PASA
obtenido: TAGREG T1 `rc 0` / `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.` → PASA
obtenido: CAT T1 `cat: rows=2008 com=2008 depe=2008 grupo=2008 nom=2008 largos_iguales=TRUE sin_directorio=25` → PASA (partida `ausente` en los cuatro)
dato: [ locale ] 1 líneas (build T1)
dato: `git diff --stat` antes del commit: 3 archivos, 14 inserciones y 7 eliminaciones (`31_leer_normalizar.R` 10 líneas, `33_generar_html.R` 10, `README.md` 1).
obtenido: Alcance T1 `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_generar_html.R README.md`; `37a4967706ee3a32b1a37238e529b803` → PASA
obtenido: Commit T1 STAGED = las 3 rutas; commit rc 0, `[main d32d433]`, 3 archivos, 14 inserciones y 7 eliminaciones; ARBOL `0` → PASA
dato: adelanto de 🔒1 (no es su medición, que es de FASE R): `50_sonda_json_igual.R` entre `"${TMPDIR:-${TEMP:?}}/simce_s36r_motor_f0.html"` y `"${TMPDIR:-${TEMP:?}}/simce_s36r_motor_T1.html"` → `igual TRUE`.

- **Estado:** completada.
- **Commits:** `d32d433` feat(pipeline): catalogo de simbologia con comuna, dependencia y nombre de la base (D36-13).
- **Cambios sustantivos:** `31_leer_normalizar.R` lee `nom_rbd` de cada xlsx (entra a `cols_base`, así que un xlsx sin la columna detiene el build con el mensaje existente), la suma en `extraer_prueba()` después de `rbd` y en el orden final de columnas; encabezado y mensaje final pasan de 16 a 17 columnas. `33_generar_html.R` suma al catálogo `simbologia` los vectores `com`, `depe`, `grupo` y `nom` después de `rbd`, desde la fila Simce, y actualiza el comentario del bloque. `README.md` suma la fila `nom_rbd` al esquema de `simce_rbd.parquet`. Causa raíz que atiende: el catálogo solo traía el RBD y el modal tenía que ubicarlo con el directorio vigente.
- **Alcance:** las 3 rutas tocadas ⊆ ALCANCE de T1; md5 del encargo igual al de la ficha.
- **Regresión:** BUILD T1 rc 0; TAGREG T1 9/9; CAT T1 con los cuatro vectores completos.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** (1) los cuatro vectores nuevos van envueltos en `as.character()` aunque el parquet ya los trae como texto, para dejar el tipo explícito en el punto donde se serializan (alternativa descartada: asignarlos sin conversión; reversible). (2) La fila del README se alineó con el ancho de las dos primeras columnas de la tabla; el contenido es el literal del encargo (reversible).
- **Errores propios:** ninguno.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** ninguna.
- nota: quedan fuera del ALCANCE y sin tocar dos textos que describen el esquema anterior: el comentario «Extrae las 7 columnas base» de `31_leer_normalizar.R` (ya era inexacto antes de T1) y el «14 columnas» del encabezado de `34_historico_pct_adecuado_costa_central.R`.

### FASE T2: el modal ubica cada resultado como las cifras, y la batería lo prueba (M12)

**Paso 0** `bash -c 'git status --porcelain -- 30_procesamiento/33_motor_template.html 30_procesamiento/33_verificar_motor.R | wc -l | tr -d " "'`
esperado: 0

**Verificación T2** (partidas de FASE 0: BUILD f0 rc 0; VMOTOR f0 11/11; M12 no existía)
`<BUILD T2>`
esperado: rc 0
`<VMOTOR T2>`
esperado: rc 0 y `Resultado: 12 pruebas, 12 pasan, 0 fallan` (la duración no se compara)
`<M12 T2>`
esperado: `M12 PASA m12: casos=<n> difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` (`casos` es `dato:`; `nacional_difieren` distinto de 0 es duda sin congelar)

**Alcance T2** `<PRECOMMIT>` y `<MD5 50_encargo.md>`
esperado: `30_procesamiento/33_motor_template.html 30_procesamiento/33_verificar_motor.R`; `37a4967706ee3a32b1a37238e529b803`

**Commit T2** `git add -- <2 rutas>`, `<STAGED>`, `git commit -m "fix(motor): el modal de simbologia ubica cada resultado como las cifras (D36-13, M12)" -- 30_procesamiento/33_motor_template.html 30_procesamiento/33_verificar_motor.R`, `<ARBOL>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36r_T2_commit.sh"`, que commitea solo si `<PRECOMMIT>`, el md5 y `<STAGED>` son los esperados)
esperado: STAGED = las 2 rutas; commit rc 0; ARBOL 0
obtenido: Paso 0 `0` → PASA
obtenido: BUILD T2 `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 14 segundos ===` → PASA
obtenido: VMOTOR T2 `rc 0` / `Resultado: 12 pruebas, 12 pasan, 0 fallan (en 100 segundos)` → PASA (partida 11/11)
obtenido: M12 T2 `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` → PASA
dato: `casos` 2946 (igual a la simulación de la auditoría de redacción, 2946); `nacional_difieren` 0, sin duda que registrar.
dato: [ locale ] 1 líneas (build T2)
dato: primera corrida de la batería tras editar; ningún reintento.
obtenido: Alcance T2 `30_procesamiento/33_motor_template.html 30_procesamiento/33_verificar_motor.R`; `37a4967706ee3a32b1a37238e529b803` → PASA
obtenido: Commit T2 STAGED = las 2 rutas; commit rc 0, `[main 248ff75]`, 2 archivos, 180 inserciones y 55 eliminaciones; ARBOL `0` → PASA
dato: M10 en VMOTOR T2: PASA; año activo 2025 con 1 fila (esperado 1), en territorio y con su motivo; 0 signos «‡» con la casilla marcada; control con una fila de otro territorio plantada, detectado.

- **Estado:** completada.
- **Commits:** `248ff75` fix(motor): el modal de simbologia ubica cada resultado como las cifras (D36-13, M12).
- **Cambios sustantivos:** en `33_motor_template.html`, `rbdsDeTerritorio` (que ubicaba cada RBD con el directorio vigente) se reemplaza por `filasSimbologia(entities, nivelCod, pruebasCod)`, función de nivel superior que recorre `DATA.simbologia` y ubica cada fila con la regla de D36-13: SLEP por su lista de RBD, establecimiento por su RBD y los demás por la comuna, el GSE no nulo y, si el territorio la filtra, la dependencia de la fila Simce; el nombre sale del directorio y, si el RBD no está, de `nom` del catálogo; la comuna, de `DATA.comunas` por el código de la fila. `ModalSimbologia` la usa en lugar de su bucle y conserva la conversión de prueba y motivo y el orden; el respaldo de nombre y comuna pasa al guion corto. En `33_verificar_motor.R`, M10 coteja el territorio con la comuna y la dependencia de la fila de `DATA.simbologia` y su control planta el RBD de una fila del catálogo de otra comuna; M12 nueva (medición por comuna con y sin dependencia, nacional y control en llamadas separadas); encabezado y comentario de cierre pasan a «M4 a M12». Causa raíz: el modal y el «‡» usaban fuentes distintas para ubicar un resultado (directorio vigente contra fila Simce).
- **Alcance:** las 2 rutas tocadas ⊆ ALCANCE de T2; md5 del encargo igual al de la ficha.
- **Regresión:** BUILD T2 rc 0; VMOTOR T2 12/12; M12 con `difieren=0` y control detectado.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** (1) el índice del directorio por RBD se arma dentro de `filasSimbologia`, en cada llamada y solo cuando la primera fila calza (alternativa descartada: un índice de nivel superior, más rápido en M12 pero con estado fuera de la función; reversible). (2) El nombre y la comuna usan cadenas de respaldo: un nombre vacío en el directorio también cae al de la base (alternativa descartada: `e ? e.nom_rbd : ...`, que dejaría un nombre nulo si el directorio lo trae vacío; reversible). (3) El control de M12 cuenta como detectado solo si `difieren` plantado es mayor que 0, mayor que su valor previo y si tras restituir vuelve al previo (más estricto que el «mayor que 0» del encargo, equivalente cuando la medición real da 0; reversible). (4) El control de M10 devuelve falso si no hay fila de otra comuna y, en ese caso, no cuenta como detectado (reversible). (5) M12 define tres funciones auxiliares en `window` en una llamada previa; la medición, el nacional y el control van después en tres llamadas `js()` separadas, como pide el encargo (reversible).
- **Errores propios:** ninguno.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** ninguna.
- nota: el pie del modal sigue diciendo «nombres: directorio oficial MINEDUC»; con D36-13 los nombres de los RBD sin directorio salen de la base de la Agencia. No se tocó porque el encargo limita los cambios visibles al respaldo de nombre y comuna; queda para el revisor.

### FASE R: auditoría y reparación

**Paso 1, inventario** (25 afirmaciones, R-01 a R-25, escrito antes de auditar): `anexos/50_R_inventario.txt` (R-01 a R-08 FASE 0; R-09 a R-12 T1; R-13 a R-16 T2; R-17 commits; R-18 alcance global; R-19 md5 del encargo; R-20 a R-23 los cuatro invariantes; R-24 contrato de arranque; R-25 errores propios de forma).

**Pasos 2 y 5, regresión completa** (va primero: las re-derivaciones leen sus salidas)
`<BUILD r>`
esperado: rc 0
`<TAGREG r>`
esperado: rc 0 y `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.`
`<CAT r>`
esperado: `cat: rows=2008 com=2008 depe=2008 grupo=2008 nom=2008 largos_iguales=TRUE sin_directorio=25`
`<VMOTOR r>`
esperado: rc 0 y `Resultado: 12 pruebas, 12 pasan, 0 fallan` (la duración no se compara)
`<M12 r>`
esperado: `M12 PASA m12: casos=<n> difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` (`casos` es `dato:`; en T2 fue 2946)
`<VTRAY r>`
esperado: rc 0 y `Resultado: 35 pruebas, 35 pasan, 0 fallan` (la línea base de FASE 0)

**Paso 2, re-derivación independiente** `bash "${TMPDIR:-${TEMP:?}}/simce_s36r_R_rederivar.sh"` (comandos distintos de los que produjeron cada afirmación)
`50_sonda_catalogo_alt.R` sobre `"${TMPDIR:-${TEMP:?}}/simce_s36r_motor_r.html"` (R-10) y sobre `"${TMPDIR:-${TEMP:?}}/simce_s36r_motor_f0.html"` (R-06)
esperado: `cat: rows=2008 com=2008 depe=2008 grupo=2008 nom=2008 largos_iguales=TRUE sin_directorio=25` y `cat: rows=2008 com=ausente depe=ausente grupo=ausente nom=ausente largos_iguales=TRUE sin_directorio=25`
`Rscript "${TMPDIR:-${TEMP:?}}/simce_s36r_R_m12_alt.R" "${TMPDIR:-${TEMP:?}}/simce_s36r_motor_r.html"` (R-14: recuento en R sobre el JSON, sin navegador ni código del motor; suma de `n_estab_simb` de `datos` contra RBD distintos de `simbologia` por comuna, dependencia y GSE no nulo)
esperado: `m12_alt: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0`
md5 con `Rscript -e "cat(unname(tools::md5sum(\"<ruta>\")))"` del encargo y de las tres sondas (R-03, R-07, R-19)
esperado: 37a4967706ee3a32b1a37238e529b803 / b0c4609c4a91e2c1bd910a7837805142 / 33d1cee79d6afe9248df70a881397fff / d30362ed33555966894685414e36a06f
`git log --format="%h %s" 2eb0483..HEAD`; `git rev-parse --short 3c405e9~1`; `git rev-parse --short origin/main`; `git show --name-only --format= <hash>` de los tres commits (R-01, R-02, R-08, R-11, R-15, R-17)
esperado: 3 commits (`248ff75` fix(motor), `d32d433` feat(pipeline), `3c405e9` docs(encargo)); `2eb0483` y `2eb0483`; `3c405e9` con las 4 rutas del expediente, `d32d433` con las 3 de T1, `248ff75` con las 2 de T2
conteos de texto con `git grep -c` (R-12, R-16): «17 columnas» y «16 columnas» en `31_leer_normalizar.R`; «D36-13» en los cinco archivos de T1 y T2; `rbdsDeTerritorio` en la plantilla; «M4 a M12» y «M4 a M11» en `33_verificar_motor.R`
esperado: «17 columnas» 2 y «16 columnas» sin coincidencias; «D36-13» `31_leer_normalizar.R` 1, `33_generar_html.R` 1, `33_motor_template.html` 2, `33_verificar_motor.R` 2, `README.md` 1; `rbdsDeTerritorio` sin coincidencias; «M4 a M12» 2 y «M4 a M11» sin coincidencias
H2 por otra vía (R-04): `command grep -c "OK: 18 archivos detectados" "${TMPDIR:-${TEMP:?}}/simce_s36r_build_r.txt"` (con T1, `nom_rbd` es columna requerida de cada xlsx: si faltara en uno, el build se detendría)
esperado: 1

**Paso 3, invariantes** (comandos de §3 del encargo)
🔒1 `50_sonda_json_igual.R` entre el motor de FASE 0 y el de FASE R; línea `Resultado:` de `<VTRAY r>`
esperado: `igual TRUE`; `Resultado: 35 pruebas, 35 pasan, 0 fallan`
🔒2 `<ATRIB>`
esperado: 0 0
🔒3 `bash -c 'git -c core.quotePath=false diff --name-only 2eb0483 HEAD | command grep -v "^50_documentacion/encargos/" | LC_ALL=C sort | paste -sd " " -'`
esperado: 30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_generar_html.R 30_procesamiento/33_motor_template.html 30_procesamiento/33_verificar_motor.R README.md
🔒4 `bash -c 'git diff --name-only 2eb0483 HEAD -- docs 20_insumos | wc -l | tr -d " "; git status --porcelain -- 20_insumos docs | wc -l | tr -d " "'`
esperado: 0 y 0

**Paso 4, alcance global** `bash -c 'git -c core.quotePath=false status --porcelain --no-renames --untracked-files=all | command grep -v -e "^?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_log.md$" -e "^?? 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/anexos/" | wc -l | tr -d " "'` y `<MD5 50_encargo.md>`
esperado: 0 y `37a4967706ee3a32b1a37238e529b803`

**Paso 6, control positivo** (el de M12 corre dentro de la batería, paso 2)
🔒1 con `plantar` (suma 1 al primer `n_estab` de `datos` del segundo motor, en memoria)
esperado: igual FALSE
`50_sonda_catalogo.R` con `plantar` sobre el motor de FASE R (quita el último elemento de `nom`, en memoria)
esperado: largos_iguales=FALSE

dato: inventario `anexos/50_R_inventario.txt`: md5 `db3b8d587f79a44e9c0701e6265e2c74`, 28 líneas.
obtenido: BUILD r `rc 0`; últimas 5 líneas: `DATA: 9 años, 74 entidades, 25197 filas en datos, 21504 en nube, 180 comunas (2.1 MB)` / `[36] Insertando datos en la plantilla...` / `[36] Escrito 40_salidas/trayectorias_traspasos.html (2.26 MB)` / `` / `=== 00_build.R: OK en 14 segundos ===` → PASA
obtenido: TAGREG r `rc 0` / `OK: 9/9 casos de .tests_agregar_ponderado() pasaron.` → PASA
obtenido: CAT r `cat: rows=2008 com=2008 depe=2008 grupo=2008 nom=2008 largos_iguales=TRUE sin_directorio=25` → PASA (copia `"${TMPDIR:-${TEMP:?}}/simce_s36r_motor_r.html"` hecha)
obtenido: VMOTOR r `rc 0` / `Resultado: 12 pruebas, 12 pasan, 0 fallan (en 98 segundos)` → PASA
obtenido: M12 r `M12 PASA m12: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado` → PASA (igual a M12 T2)
obtenido: VTRAY r `rc 0` / `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA (igual a VTRAY f0)
dato: [ locale ] 1 líneas (build r)
obtenido: sonda alt, motor r `cat: rows=2008 com=2008 depe=2008 grupo=2008 nom=2008 largos_iguales=TRUE sin_directorio=25`; motor f0 `cat: rows=2008 com=ausente depe=ausente grupo=ausente nom=ausente largos_iguales=TRUE sin_directorio=25` → PASA (iguales a CAT r y a CAT f0)
obtenido: `m12_alt: casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0` → PASA (el recuento en R reproduce las cinco cifras de M12)
obtenido: `37a4967706ee3a32b1a37238e529b803` / `b0c4609c4a91e2c1bd910a7837805142` / `33d1cee79d6afe9248df70a881397fff` / `d30362ed33555966894685414e36a06f` → PASA
obtenido: `248ff75 fix(motor): el modal de simbologia ubica cada resultado como las cifras (D36-13, M12)` / `d32d433 feat(pipeline): catalogo de simbologia con comuna, dependencia y nombre de la base (D36-13)` / `3c405e9 docs(encargo): modal_simbologia_sin_directorio`; `2eb0483` y `2eb0483`; `3c405e9` con las 4 rutas del expediente, `d32d433` con las 3 de T1, `248ff75` con las 2 de T2 → PASA
obtenido: «17 columnas» `30_procesamiento/31_leer_normalizar.R:2` y «16 columnas» sin salida; «D36-13» `31_leer_normalizar.R:1`, `33_generar_html.R:1`, `33_motor_template.html:2`, `33_verificar_motor.R:2`, `README.md:1`; `rbdsDeTerritorio` sin salida; «M4 a M12» `30_procesamiento/33_verificar_motor.R:2` y «M4 a M11» sin salida → PASA
obtenido: H2 por otra vía `1` → PASA (el build de FASE R leyó los 18 xlsx con `nom_rbd` como columna requerida y terminó con rc 0)
obtenido: 🔒1 `igual TRUE`; `Resultado: 35 pruebas, 35 pasan, 0 fallan` → PASA
obtenido: 🔒2 `0 0` → PASA
obtenido: 🔒3 `30_procesamiento/31_leer_normalizar.R 30_procesamiento/33_generar_html.R 30_procesamiento/33_motor_template.html 30_procesamiento/33_verificar_motor.R README.md` → PASA
obtenido: 🔒4 `0` y `0` → PASA
obtenido: alcance global `0` y `37a4967706ee3a32b1a37238e529b803` → PASA
obtenido: control de 🔒1 `igual FALSE` → PASA (el instrumento distingue un JSON con una cifra cambiada)
obtenido: control del catálogo `largos_iguales=FALSE` → PASA (la sonda distingue un catálogo mal formado)
dato: control positivo de M12, dentro de la batería (VMOTOR r): `control=detectado` (una fila del catálogo movida a otra comuna hace subir `difieren` en esas dos comunas, y vuelve a su valor al restituirla).

**Paso 7, hallazgos**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01, R-08, R-17 | punto de partida y commits del encargo | `git log --format="%h %s" 2eb0483..HEAD`, `git rev-parse --short 3c405e9~1` y `origin/main` | 3 commits sobre `2eb0483` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-02, R-11, R-15 | archivos de cada commit | `git show --name-only --format=` | 4, 3 y 2 rutas | iguales | ninguna | ninguna | no aplica | no aplica |
| R-03, R-07, R-19 | md5 de las sondas y del encargo | `tools::md5sum` | los de §10 y `encargo_md5` | iguales | ninguna | ninguna | no aplica | no aplica |
| R-04 | los 18 xlsx traen `nom_rbd` | línea «OK: 18 archivos detectados» del build con la columna requerida | 1 | 1 | ninguna | ninguna | no aplica | no aplica |
| R-05, R-09, R-13 | build y baterías | regresión completa (pasos 2 y 5) | rc 0, 9/9, 12/12, 35/35 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-06, R-10 | catálogo antes y después de T1 | `50_sonda_catalogo_alt.R` | líneas de CAT f0 y CAT T1 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-12, R-16 | textos de T1 y T2 | `git grep -c` | conteos pre-registrados | iguales | ninguna | ninguna | no aplica | no aplica |
| R-14 | M12: el modal lista lo que cuenta el «‡» | `simce_s36r_R_m12_alt.R` (R sobre el JSON) y `<M12 r>` | casos 2946, difieren 0, 25 de 25, nacional 0 | iguales | ninguna | ninguna | no aplica | no aplica |
| R-18 | alcance global | paso 4 y 🔒3 | 0 y las 5 rutas | iguales | ninguna | ninguna | no aplica | no aplica |
| R-20 a R-23 | invariantes 1 a 4 | paso 3 | §3 del encargo | PASA los cuatro | ninguna | ninguna | no aplica | no aplica |
| R-24 | lecturas previas al testigo | sección FASE 0 y archivo de lecturas | declaradas | 0 lecturas además del encargo | ninguna | ninguna | no aplica | no aplica |
| R-25 | errores propios de forma | sección FASE 0 | ninguno | 2 registrados (`cat` no listado; md5 medido antes de anotar su rótulo) | ADVIERTE | registrados; ninguno cambió un resultado | no aplica | no aplica |
| R-26 | pie del modal «nombres: directorio oficial MINEDUC» | lectura de la plantilla en `248ff75` | fuente de nombres completa | los 25 resultados sin directorio se nombran con la base de la Agencia y el pie no lo dice | ADVIERTE | no se toca (el encargo limita los cambios visibles); duda al titular | no aplica | no aplica |
| R-27 | textos que describen el esquema anterior de `simce_rbd.parquet` | `git grep -n "columnas"` de FASE T1 | sin textos desfasados | «7 columnas base» en `31_leer_normalizar.R` (ya inexacto antes) y «14 columnas» en `34_historico_pct_adecuado_costa_central.R` (fuera del ALCANCE) | ADVIERTE | no se tocan; nota para el revisor | no aplica | no aplica |

**Paso 8, ciclo de reparación:** no se abrió (0 hallazgos para reparar).
**Paso 9, prohibiciones:** ningún criterio, tolerancia ni esperado se ajustó en esta fase; ningún ALCANCE ampliado; ningún 🔒 tocado; ninguna evidencia editada.
**Paso 10, veredicto global:** `APROBADO CON ADVERTENCIAS` (0 que bloqueen, 0 por reparar, 3 advertencias: R-25, R-26, R-27), con los controles positivos del paso 6 y el de M12 disparando.

- **Estado:** completada.
- **Commits:** ninguno.
- **Cambios sustantivos:** ninguno (fase de solo lectura; escribió `anexos/50_R_inventario.txt`).
- **Alcance:** el log y `anexos/50_R_inventario.txt`, más archivos `simce_s36r_` del temporal ⊆ ALCANCE de FASE R; md5 del encargo igual al de la ficha.
- **Regresión:** BUILD r rc 0; TAGREG r 9/9; CAT r completo; VMOTOR r 12/12; M12 r igual a T2; VTRAY r 35/35.
- **Subagentes:** sin subagentes.
- **Bugs:** ninguno.
- **Decisiones autónomas:** sumar a la re-derivación un recuento de M12 hecho en R sobre el JSON (`simce_s36r_R_m12_alt.R`, en el temporal), porque `<M12 r>` repite el comando que produjo la cifra (alternativa descartada: dar la regresión por re-derivación; reversible).
- **Errores propios:** ninguno nuevo.
- **Defectos del encargo:** ninguno.
- **Fricciones de entorno:** ninguna.
- **Intervenciones humanas:** ninguna observable.
- **Dudas:** la del pie del modal (R-26), consolidada en `## Cierre`.

## Cierre

(escrito después: FASE L)

**FASE L, paso 1** `<ARBOL>` (escrito después: FASE L)
esperado: 0
obtenido: 0 → PASA
dato: `hash_final` `git rev-parse --short HEAD` → `248ff75`; `fin` `bash -c 'TZ=America/Santiago date -Iseconds'` → `2026-11-11T18:15:03+00:00` (escrito después: FASE L)

1. **Resumen:** entró el encargo de R-30 (el modal de simbología ubicaba cada resultado con el directorio vigente y dejaba fuera 25 de las 2.008 filas del catálogo). Cuatro fases con sección (FASE 0, T1, T2, FASE R) más FASE L. T1 completada (`d32d433`): el catálogo `simbologia` del JSON lleva comuna, dependencia, GSE y nombre de la fila Simce, y `simce_rbd.parquet` suma `nom_rbd` (17 columnas). T2 completada (`248ff75`): `filasSimbologia` ubica cada resultado con la regla de D36-13 y la batería gana M12. FASE R: `APROBADO CON ADVERTENCIAS`.
2. **Commits** (`git log 3c405e9..HEAD --oneline`, más el punto de retorno):
   - `3c405e9` docs(encargo): modal_simbologia_sin_directorio (FASE 0, hash_inicial)
   - `d32d433` feat(pipeline): catalogo de simbologia con comuna, dependencia y nombre de la base (D36-13) (T1)
   - `248ff75` fix(motor): el modal de simbologia ubica cada resultado como las cifras (D36-13, M12) (T2)
   - El commit `docs(log)` de este log se anota en el reporte.
3. **Auditoría (FASE R):** tabla en la sección de FASE R (pasos 7 y 10), referenciada y no copiada; veredicto `APROBADO CON ADVERTENCIAS`; BLOQUEA 0, REPARA 0, ADVIERTE 3 (R-25, R-26, R-27); reparados 0; abiertos 0; los controles positivos de 🔒1, del catálogo y de M12 dispararon.
4. Verificación de invariantes (FASE R):
   - 🔒1 las cifras no cambian: PASA (`igual TRUE`; VTRAY `Resultado: 35 pruebas, 35 pasan, 0 fallan`, igual a su línea base)
   - 🔒2 sin atribución: PASA (`0 0`)
   - 🔒3 solo cambian los archivos de T1 y T2, el expediente y el índice: PASA (las 5 rutas de T1 y T2)
   - 🔒4 `docs/` y `20_insumos/` intactos: PASA (`0` y `0`)
5. **Decisiones del usuario:** D36-13 (opción A del titular: el modal ubica cada resultado con la comuna, la dependencia y el GSE de su fila Simce y lo nombra con el directorio o, si no está, con la base de la Agencia), aplicada en T1 y T2; D36-14 (el popup «ver establecimientos» sigue con el directorio vigente), fuera del encargo. Ningún gate nuevo durante la sesión.
6. **Cifras críticas:** intactas. El JSON del motor final es igual al de la línea base salvo el catálogo `simbologia` y la fecha (`50_sonda_json_igual.R`: `igual TRUE`); la batería de trayectorias da 35/35 como en FASE 0. Lo que cambia es la lista del modal: en las 2.946 combinaciones de comuna, dependencia, nivel, prueba y año con simbología, los establecimientos del modal igualan el `n_simb` de la serie (M12 `difieren=0`; recuento en R `m12_alt` igual), y las 25 filas sin directorio vigente quedan ubicadas (25 de 25).
7. **Dudas y pendientes:**
- duda: el pie del modal dice «nombres: directorio oficial MINEDUC», pero con D36-13 los 25 resultados sin directorio vigente se nombran con la base de la Agencia. ¿Se cambia el pie para citar también la base de la Agencia como fuente de nombres (sí: un cambio de una línea en la plantilla, en otro encargo; no: queda como está)? No bloquea nada de este encargo.
8. **Errores propios:**
- error propio: FASE 0, un `cat` sobre el testigo, comando que §0.2 punto 0 no lista entre los de solo lectura; lectura sin efecto; costo: ninguno.
- error propio: FASE 0, el md5 del encargo del paso 3 se midió antes de anotar su rótulo en el log (medición sin esperado, `dato:`); costo: ninguno.
- error propio: FASE R, la fila R-27 de la tabla cita su comando en forma abreviada; el que se corrió en FASE T1 fue `git grep -n -E` con el patrón de «16 columnas», «17 columnas», `ncol(` y `simce_rbd.parquet`, y «7 columnas base» se vio al leer `31_leer_normalizar.R`; se corrige con esta línea; costo: ninguno.
9. **Notas para el revisor:** (a) falta la revisión visual del modal en `40_salidas/motor_comparacion.html` (casilla marcada, un territorio por comuna, un año antiguo): esta sesión midió la lista con la batería, no la miró. (b) El pie del modal (duda de arriba). (c) Según la premisa de §1 del encargo, 3 filas del catálogo tienen en el directorio una comuna distinta de la de su fila Simce; el modal las muestra ahora en la comuna de la fila, y esta sesión no recontó ese 3. (d) El control de M12 exige más que el «mayor que 0» del encargo (sube sobre su valor previo y vuelve al restituir). (e) `filasSimbologia` arma el índice del directorio en cada llamada que encuentra filas; la batería pasó de 96 a 98 y 100 segundos. (f) Quedan textos que describen el esquema anterior fuera del ALCANCE (R-27). (g) `simce_rbd.parquet` lleva ahora el nombre del establecimiento de las bases públicas por establecimiento de la Agencia; el parquet sigue en `40_salidas/intermedios/`, que git ignora.
10. **Estado de cierre:** commiteados `3c405e9`, `d32d433` y `248ff75`, más `docs(log)` (su hash va en el reporte), todo local. No se publica: sin push y sin copia a `docs/`. Queda al titular la revisión visual del modal, la copia a `docs/`, el push y la decisión sobre la duda del pie.
11. **Calidad del encargo:**

| tipo | cita del encargo | que_ocurrio | que_debio_decir | escapo_a |
|---|---|---|---|---|
ninguno

12. **Fricciones de entorno:** ninguna (el offset `+00:00` de `date` es la fricción conocida del encargo, registrada como `dato:`).
13. **Intervenciones y tiempos:** ninguna denegación ni mensaje del titular durante la ejecución (los diálogos aprobados no son observables: `no_medible`; hubo avisos automáticos del entorno pidiendo estado, que no son del titular); inicio `2026-11-11T17:52:07+00:00`, fin `2026-11-11T18:15:03+00:00`, duración 00:22; compactaciones de contexto 0.

**FASE L, paso 5** `bash -c 'Rscript --no-init-file "${HERRAMIENTAS_DEV_PATH:?}/plantillas/98_indexar_encargos.R" --repo=. --validar=50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio/50_log.md; echo "rc $?"'` (escrito después: FASE L)
esperado: rc 0
obtenido: `valida 50_documentacion/encargos/202611/20261111_modal_simbologia_sin_directorio` / `rc 0` → PASA (primer intento, sin reintento)
dato: el validador imprime además el aviso `[ locale ]` de LANG y LC_CTYPE exportados, 3 líneas (escrito después: FASE L)

**FASE L, paso 6** `<PRIVACIDAD>` (escrito después: FASE L)
esperado: rc 1 y rc 1
obtenido: `rc 1` / `rc 1` → PASA (sin rutas personales, raya larga ni RUT)
dato: lectura del log y de `anexos/50_R_inventario.txt`: sin filas de datos, RBD ni nombres de personas o establecimientos (escrito después: FASE L)

**FASE L, paso 7** (exento de pre-registro; medido después de anexar el `obtenido:` del paso 6 y antes de este bloque)
dato: permisos `-rw-r--r--`; `wc -l` 371; `head -1` `---`; termina en salto de línea `1`; `^### FASE` 4 (FASE 0, T1, T2, FASE R); `^esperado:` 44 más `^- faltante: esperado de` 0, igual a `^obtenido:` 44; `^## J` 1. Sin faltantes.

**FASE L, paso 8** `git add --` del log y de `anexos/50_R_inventario.txt`; `98_indexar_encargos.R --repo=. --escribir`; `git add --` del índice si cambió; `<STAGED>`; `git commit -m "docs(log): modal_simbologia_sin_directorio" -- <lista>` (en `bash "${TMPDIR:-${TEMP:?}}/simce_s36r_L_commit.sh"`, que commitea solo si `<STAGED>` es esa lista); sus mediciones van solo al reporte.
