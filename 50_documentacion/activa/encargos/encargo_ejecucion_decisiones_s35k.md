# Encargo autónomo: ejecución de las decisiones D35-17 a D35-19 (sesión 35, undécima ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-26. Ejecución: Claude Code en la estación macOS del titular, tras `/clear`.

**Contexto.** El encargo `encargo_ramas_bloqueos_s35j.md` diagnosticó los pendientes 8, 10, 12 y 13 del
traspaso v34 (log `50_documentacion/andamios/logs/20260926_ramas_bloqueos_s35j_log.md`, publicado en
`2db6266`). El titular decidió (D35-17 a D35-19, en
`50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`):

- **Ramas (D35-17).** Borrar `respaldo_prerebase_20260824` y `respaldo_normativos_20260824`. Rescatar a
  `main` el log `20260711_contrato_contexto_simce_log.md` y la suite standalone regenerada de `gobernanza/v16`, y
  después borrar esa rama. `feat/contrato-contexto` **no se toca**.
- **`suitedoc` fuera del lock (D35-18).** Registrar en `renv.lock` los paquetes de CRAN que faltan y dejar
  `suitedoc` fuera de forma duradera.
- **Simce 2026 (D35-19).** Sigue bloqueado por insumo. Mientras, los años esperados y los 5 literales de rango
  se derivan de los archivos, para que la llegada de 2026 no exija editar código. Además, el manifiesto de
  insumos corrige la frase sobre el versionado de los xlsx (Q-72).

**Meta en una línea:** tres ramas menos sin perder nada, un lock que restaura el pipeline en otra estación, un
build que acepta un año nuevo sin editar código y un manifiesto que dice la verdad; el sitio publicado no
cambia de contenido.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** cuatro tareas en serie sobre un
repositorio, dos de ellas irreversibles en local (borrar ramas).

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 o H6 (batería o build) fallan → **detén la sesión**.
- Si una tarea no cumple su criterio tras 3 intentos → congela esa tarea, revierte sus cambios sin commitear
  (autorización 3) y sigue con la siguiente. El resto se commitea igual.
- K1: si el respaldo de las ramas (paso 1 de K1) no se puede verificar, **no se borra ninguna rama**.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. **K1:** `git show 667e5ad:<ruta>` hacia las dos rutas del rescate; un respaldo de las tres ramas en
   `_archivo/20260926_respaldo_ramas_s35k/` (ignorado), con `git bundle` y la lista de sus hashes; y, solo
   con el respaldo verificado, `git branch -D` de `respaldo_prerebase_20260824`,
   `respaldo_normativos_20260824` y `gobernanza/v16`. Ninguna otra rama.
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE de la tarea en curso,
   después de guardar el intento como parche en `$TMPDIR/cal_s35k/` y anotar su md5 en el log.
4. **K2:** `renv::settings$ignored.packages("suitedoc")` (escribe `renv/settings.json`) y `renv::snapshot()`
   (escribe `renv.lock`), una vez cada uno, después de probar la vía con copias de respaldo de los dos archivos
   en `$TMPDIR/cal_s35k/`. **No** se autoriza `renv::restore()`, `renv::install()`, `install.packages()` ni
   `renv::update()`.
5. Crear, sobrescribir y borrar `verificar_*.R` en la raíz y archivos en `$TMPDIR`. Crear copias del
   repositorio en `$TMPDIR` para plantar insumos faltantes o sobrantes (K3), sin tocar el árbol.
6. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío;
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` sin cambio (I-2).

   Solo se empuja `main`. El borrado de ramas es local: ninguna de las tres existe en `origin`.

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.** R es el único lenguaje de los entregables. Los commits van en español. Toda
medida nueva va en una constante nombrada. `docs/` solo cambia por copia íntegra, y este encargo no la copia.
Un código de salida se lee sin tubería. `grep -c` sale con código 1 cuando cuenta 0 (A34-3).

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:**
   - el log de s35j: R1 (clasificación de archivos por rama), R2 (los 18 paquetes fuera del lock, los 5 usos
     directos, la hipótesis de `snapshot`) y R3 (años, `anios_esperados` y los literales de rango);
   - D35-17 a D35-19;
   - `50_documentacion/andamios/logs/20260827_entorno_y_suite_standalone_log.md` L166-235 (por qué aborta
     `renv::snapshot()` y las cuatro vías).
3. **POSICIÓN:**
   - rutas completas;
   - `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`;
   - R con `cd "$RAIZ" && Rscript ...` (con `renv` activo, salvo que se diga otra cosa);
   - `rev-parse` con un argumento por comando;
   - `fetch` antes de operar contra el remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260926_ejecucion_decisiones_s35k_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0, con 0 fallas críticas;
   - `Rscript 30_procesamiento/36_verificar_trayectorias.R` → código 0, con 35 pruebas o más;
   - `Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base».
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Medidas en la sesión 35 con git de solo lectura (`GIT_OPTIONAL_LOCKS=0`), `grep`, `sed` y `md5sum` sobre la
estación, salvo donde se cita el log de s35j.

- `HEAD` y `origin/main` están en `2db6266`. El árbol tiene dos archivos modificados sin commit, que T0
  commitea: el de decisiones (D35-17 a D35-19) y el registro de errores (ERR-35-23) (fuente: `git log`,
  `git rev-parse` y `git status --porcelain`).
- `docs/index.html` = `42ab93003e722f9bb6c725fec2d348bd`, `docs/trayectorias.html` =
  `883f76bcefc89d93f2d1e753fc4d75c3` (fuente: `md5sum`).
- Ramas locales: `feat/contrato-contexto 31befa2`, `gobernanza/v16 667e5ad`,
  `respaldo_normativos_20260824 b9426c2`, `respaldo_prerebase_20260824 e86b0d2` (fuente: `git branch`). El
  remoto solo tiene `main` y `feat/contrato-contexto` (fuente: log s35j, `ls-remote`).
- `667e5ad` toca 9 archivos, entre ellos `50_documentacion/andamios/logs/20260711_contrato_contexto_simce_log.md`
  (ausente en `main`) y `50_documentacion/suite/documentacion_proyecto_slep_simce_adecuado_standalone.html`
  (fuente: `git show --name-only`). Según R1 de s35j, esos dos son la clase (c), «único y vigente»; el log dice
  «No commitear» en su encabezado, escrito cuando era andamio de una rama sin push.
- **Lock.** `renv.lock` tiene 40 paquetes; la biblioteca de `renv`, 58; faltan en el lock 18: AsioHeaders,
  askpass, chromote, curl, fastmap, later, openssl, openxlsx, otel, processx, promises, ps, Rcpp, suitedoc, sys,
  V8, websocket, zip. `renv/settings.json` tiene `"ignored.packages": []` y `"snapshot.type": "implicit"`
  (fuente: log s35j R2.2, y `cat renv/settings.json` en esta sesión). `renv::snapshot()` aborta entero por
  `suitedoc` («installed from an unknown source», log del 2026-08-27 L166-187).
- Hipótesis (se mide en K2): con `suitedoc` en `ignored.packages`, `renv::snapshot()` deja de abortar y
  registra los 17 restantes. Tras K2, el lock tendría 57 paquetes.
- **Años.** `31_leer_normalizar.R` L124: `anios_esperados <- c(2014:2018, 2022:2025)`; L126 el patrón
  `^simce(2m|4b)(\d{4})_rbd_(final|preliminar)\.xlsx$`; L156-168 detiene el build si en un nivel faltan años
  esperados o sobran años (fuente: `sed -n 110,170p`). Cada nivel tiene hoy 9 archivos `_final`, de 2014 a 2018
  y de 2022 a 2025 (fuente: log s35j R3.1).
- **Literales de rango** (fuente: `grep -n`):
  - `33_fragmento_sitio.html` L85: «Datos 2014–2025» (el fragmento va en las dos páginas);
  - `33_motor_template.html` L2592: `d3.scaleLinear().domain([2014, 2025])`; L4139: «en el periodo
    2014–2025»; L5074: «Bases Simce 2014–2025»;
  - `36_trayectorias_template.html` L475: «2014 a 2025».
  Los generadores ya sustituyen marcadores con la forma `__NOMBRE__` (por ejemplo `__JSON_DATA__` en
  `33_generar_html.R` L487-497).
- **Manifiesto.** `50_documentacion/activa/manifiesto_insumos.md` L87 «## Política de versionado» y L89: «Los
  xlsx SIMCE crudos **no** se versionan (`.gitignore`)». Los 18 están versionados y autorizados (fuente: log
  s35j R3.1; `50_datos_versionados_autorizados.md` L25 y L26).

---

## 3. Contexto mínimo

K1 y K2 cambian el repositorio, no el producto. K3 cambia el código, pero con los insumos de hoy el contenido
publicado debe ser el mismo: por eso no hay copia a `docs/`. K4 es una frase. El riesgo mayor es borrar algo
que no se rescató: por eso el respaldo va antes que el borrado y se verifica.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | `feat/contrato-contexto` y `main` remoto no cambian por el encargo | `git rev-parse feat/contrato-contexto` y `git ls-remote --heads origin` antes del push | `31befa2…`; remoto sin ramas nuevas |
| I-2 | `docs/` no cambia | `md5 -q docs/index.html docs/trayectorias.html` | `42ab9300…` y `883f76bc…` |
| I-3 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-4 | El contenido de las salidas no cambia | vista: md5 de `40_salidas/trayectorias_traspasos.html` igual a `docs/trayectorias.html`; motor: igual a `docs/index.html` fuera de `meta$fecha_generacion` (HTML sin el bloque de datos byte a byte, y JSON sin ese campo con `identical()`) | iguales |
| I-5 | Las fuentes no cambian | `md5 -q 10_utils/fuentes/*.otf` | `a7407ed6…` (Bold) y `0257bb4b…` (Regular) |
| I-6 | Se agrega por `cod_com_rbd` | `grep -nE '(\.by\|\bgroup_by\|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R \| grep -v cod_com_rbd` | vacío |
| I-7 | No se agregan archivos de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, K1, K2, K3, K4, FASE R, FASE L con el push.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`, `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md` |
| K1 | `50_documentacion/andamios/logs/20260711_contrato_contexto_simce_log.md`, `50_documentacion/suite/documentacion_proyecto_slep_simce_adecuado_standalone.html`, `_archivo/20260926_respaldo_ramas_s35k/`, las tres ramas locales nombradas |
| K2 | `renv.lock`, `renv/settings.json` |
| K3 | `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_generar_html.R`, `30_procesamiento/36_generar_trayectorias.R`, `10_utils/10_html.R`, `30_procesamiento/33_fragmento_sitio.html`, `30_procesamiento/33_motor_template.html`, `30_procesamiento/36_trayectorias_template.html`, `40_salidas/*.html` |
| K4 | `50_documentacion/activa/manifiesto_insumos.md` |

---

## 6. FASE 0

1. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado, exactamente estas tres líneas, más el log:
   - ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
   - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`
   - `?? 50_documentacion/activa/encargos/encargo_ejecucion_decisiones_s35k.md`
3. **H2.** `git stash list | wc -l` → `0`; `git worktree list` → solo el árbol principal.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `2db6266` y `rev-parse --short origin/main` →
   `2db6266`. Las cuatro ramas locales con los hashes de §2.
5. **H4.** md5 de este encargo → esperado: el del mensaje de entrega. md5 de `docs/` → los de I-2. Después,
   `git add` de las tres rutas de T0 y
   `git commit -m "docs(sesion 35): encargo de la undecima ola y decisiones D35-17 a D35-19"`. El hash
   resultante es el punto de retorno.
6. **H5.** Batería → 35 en PASA, código 0.
7. **H6.** `Rscript 00_build.R` → código 0, e I-4 sobre sus salidas. Copia las dos a `$TMPDIR/base_s35k/` y
   calibra `verificar_contenido_motor.R` («idéntico» sobre la base, «difiere» con un número alterado).
8. **Calibraciones.**
   - K2: guarda `renv.lock` y `renv/settings.json` en `$TMPDIR/cal_s35k/`, con su md5. Registra la salida de
     `renv::status()` de hoy (esperado: lista paquetes usados y no registrados).
   - K3: en una copia del repositorio en `$TMPDIR`, quita `simce2m2024_rbd_final.xlsx` y corre el paso 31.
     Esperado: se detiene con «Nivel 2m: faltan años 2024». En otra copia, agrega una copia de un xlsx con el
     nombre `simce2m2019_rbd_final.xlsx`. Esperado: se detiene con «años inesperados 2019».
9. Anexa `### FASE 0`.

---

## 7. Tareas

### K1. Rescate y borrado de ramas (D35-17)

1. **Respaldo.** En `_archivo/20260926_respaldo_ramas_s35k/`: un bundle con las tres ramas y un archivo con
   `nombre hash` de cada una. **Verificación:** el bundle se valida (`git bundle verify`) y lista las tres
   refs con los hashes de §2. Sin esto, no se borra nada.
2. **Rescate.** Escribe en `main`, desde `667e5ad`:
   - `50_documentacion/andamios/logs/20260711_contrato_contexto_simce_log.md`, con una sola línea agregada al
     inicio que diga que se rescató de `gobernanza/v16` (`667e5ad`) por D35-17 y que el «No commitear» de su
     encabezado quedó obsoleto. El resto, byte a byte;
   - `50_documentacion/suite/documentacion_proyecto_slep_simce_adecuado_standalone.html`, tal cual.
   **Verificación:** `diff` entre cada archivo de `main` y `git show 667e5ad:<ruta>`: el log difiere solo en
   la línea agregada; la suite, en nada.
3. Commit: `docs(ramas): rescata el log del contrato y la suite standalone de gobernanza/v16 (D35-17)`.
4. **Re-verificación antes de borrar.** Para cada una de las tres ramas, repite la clasificación de s35j con
   `main` ya actualizado: cada archivo tocado por sus commits no presentes en `main` es (a) ya en `main` o (b)
   superado. Esperado: 0 archivos (c). Si queda alguno, no borres esa rama y regístralo como duda.
5. **Borrado** (autorización 2): `git branch -D` de las tres. **Verificación:** `git branch` muestra solo
   `feat/contrato-contexto` y `main`; I-1.
6. Sin commit adicional (el borrado de ramas no es un cambio del árbol).

### K2. `suitedoc` fuera del lock (D35-18)

1. `renv::settings$ignored.packages("suitedoc")`. **Verificación:** `renv/settings.json` tiene
   `"ignored.packages": ["suitedoc"]` y ningún otro cambio (`git diff`).
2. `renv::snapshot()` (autorización 4; si pide confirmación, en modo no interactivo se acepta con el argumento
   que lo haga explícito y se anota cuál).
3. **Criterio.**
   - El lock registra `V8`, `openssl`, `chromote` y `openxlsx` con su versión instalada y `Repository: CRAN`,
     y no registra `suitedoc`.
   - Los 17 paquetes de §2 (sin `suitedoc`) están en el lock; ningún paquete que ya estaba cambió de versión
     (compáralo contra la copia de `$TMPDIR/cal_s35k/`). Si el campo de versión de R del lock cambia (hoy
     4.5.1, instalado 4.5.2), anótalo.
   - `renv::status()` no reporta paquetes usados y no registrados, salvo `suitedoc` como ignorado.
   - Build y batería en PASA; I-3 e I-4.
   - **Calibración:** FASE 0, paso 8 (K2).
   - Si `snapshot()` aborta igual, restaura los dos archivos desde `$TMPDIR/cal_s35k/`, congela K2 y registra
     la salida literal.
4. Commit: `chore(renv): registra los paquetes de CRAN que faltaban y deja suitedoc fuera del lock (D35-18)`.

### K3. Los años y los rangos salen de los archivos (D35-19)

1. **Paso 31.** `anios_esperados` deja de ser un literal. Se derivan los años de los nombres de archivo de cada
   nivel, y el build se detiene (con un mensaje que nombra el nivel y los años) si:
   - un nivel tiene un año que el otro no tiene;
   - aparece un año de `ANIOS_SIN_SIMCE` (constante nueva: 2019, 2020 y 2021, los años sin aplicación), o un
     año anterior a `ANIO_INICIO` (constante nueva: 2014);
   - un año, fuera de `ANIOS_SIN_SIMCE`, falta entre el primero y el último (un hueco);
   - un año tiene más de un archivo en un nivel.
   Los mensajes de hoy («faltan años», «años inesperados») se conservan donde apliquen.
2. **Literales.** Los 5 literales de §2 pasan a marcadores (por ejemplo `__ANIO_MIN__` y `__ANIO_MAX__`), que
   el build sustituye con el primer y el último año de los datos (los de `meta$anios` del motor y de
   `DATA$anios` de la vista). El fragmento compartido se sustituye donde se inserta (`10_utils/10_html.R` o el
   generador de cada página). Un marcador sin sustituir detiene el build (como `__JSON_DATA__`).
3. **Criterio.**
   - I-4: con los insumos de hoy, las dos salidas tienen el mismo contenido que `docs/`.
   - `grep` de `2025` en las plantillas y el fragmento, fuera de comentarios: 0 aciertos en esos 5 lugares
     (anota el comando).
   - En copias del repositorio (autorización 5): sin `simce2m2024_rbd_final.xlsx` → se detiene; con un
     `simce2m2019_rbd_final.xlsx` plantado → se detiene; con `simce2m2014_rbd_final.xlsx` quitado solo de 2m →
     se detiene (niveles distintos); con los insumos completos → pasa.
   - **Calibración:** FASE 0, paso 8 (K3), con el código de antes.
   - Batería en PASA; I-3.
4. Commit: `refactor(pipeline): los anos y los rangos se derivan de los insumos (D35-19)`.

### K4. El manifiesto dice que los xlsx se versionan (Q-72, D35-19)

1. En `manifiesto_insumos.md`, «Política de versionado»: la frase dice que los 18 xlsx Simce se versionan, que
   están autorizados en `50_datos_versionados_autorizados.md` (L25 y L26) y que los años se derivan de sus
   nombres desde K3.
2. **Verificación:** `git diff` de K4 solo toca esa sección.
3. Commit: `docs(insumos): el manifiesto dice que los xlsx Simce se versionan (Q-72)`.

---

## 8. FASE R: auditoría propia y reparación (penúltima y obligatoria; corre aunque haya tareas congeladas)

La regla de oro: **la reparación cambia el trabajo, nunca el criterio, la tolerancia, el valor esperado ni
la meta**.

1. **Inventario de afirmaciones auditables.** Se arma desde el log, no desde la memoria: cada línea
   `Verificación:`, cada cifra de las secciones por fase, cada 🔒 de §4 con su comando y el alcance global. Se
   numeran `R-01`, `R-02`, etc., y el inventario se anexa al log **antes** de auditar.
2. **Re-derivación independiente.** Sin subagentes: el orquestador re-deriva cada afirmación con un comando
   distinto del que la produjo. La identidad de lo publicado se comprueba con `git hash-object` sobre `docs/` y
   sobre `40_salidas/`, en vez de `md5`. La ausencia de red se comprueba con un segundo patrón, `grep -c 'http'`,
   y cada acierto se revisa a mano: los enlaces `<a href>` a sitios oficiales en el texto son esperables.
3. **Invariantes 🔒.** Corre el comando de cada uno y anota PASA o FALLA con la salida literal.
4. **Chequeo global de alcance.** `git diff --name-only <punto_de_retorno>..HEAD` debe quedar dentro de la
   unión de los ALCANCE, más el log. Corre también `git status --porcelain`: lo que no esté commiteado es un
   hallazgo, no se limpia.
5. **Regresión completa.** Los tres comandos de PRUEBAS sobre el estado final.
6. **Control positivo de la propia auditoría.** Al menos una cifra alterada en una copia temporal fuera del
   árbol y un archivo fuera de alcance simulado en un diff de prueba. El instrumento debe disparar en los dos
   casos.
7. **Veredicto por hallazgo:**
   - **BLOQUEA:** gobernanza de datos, un 🔒 en FALLA, datos alterados, alcance violado o historia divergente.
     No se repara: se congela la tarea de origen y se registra como duda con pregunta cerrada. Si compromete el
     repositorio, se detiene la sesión y se pasa a FASE L.
   - **REPARA:** un defecto del propio trabajo, dentro del ALCANCE, que no toca un 🔒 y tiene una verificación
     calibrada. Se corrige en el ciclo del paso 8.
   - **ADVIERTE:** una discrepancia sin efecto sobre la meta ni los invariantes, o un riesgo que esta sesión no
     puede medir. Se registra, no se corrige.

   «0 hallazgos» solo se declara junto con el control positivo del paso 6.
8. **Ciclo de reparación (máximo 2 ciclos).** Por cada REPARA:
   - (a) causa raíz;
   - (b) fix quirúrgico dentro del ALCANCE;
   - (c) re-verificación con el mismo chequeo **y** con uno distinto;
   - (d) regresión;
   - (e) commit `fix(auditoria): R-NN <hallazgo>`;
   - (f) fila en la tabla.

   Luego se repiten los pasos 2 a 5 sobre lo tocado. Un hallazgo que sobrevive al segundo ciclo, o que destapa
   otro, se congela y se registra como pendiente.
9. **Prohibido:** ajustar un criterio, una tolerancia o un valor esperado; ampliar un ALCANCE; tocar un 🔒;
   editar evidencia ya escrita; reparar un BLOQUEA; aceptar una reparación de un subagente sin verificarla.
10. **Salida.** Una tabla con las columnas `id | afirmación | comando de re-derivación | esperado | obtenido |
    severidad | acción | commit | re-verificación` y un veredicto global: `APROBADO`,
    `APROBADO CON ADVERTENCIAS`, `OBSERVADO` o `BLOQUEADO`. El veredicto va al bloque J.

---

## 9. FASE L: cierre del log (última y obligatoria; corre siempre)

1. **Estado del árbol.** `git status --porcelain` → esperado: vacío o solo el log. Cualquier otra cosa es un
   hallazgo y no se limpia.
2. **Cierre del log.** Se completan las secciones de la plantilla: resumen, inventario de commits (desde
   `git log <punto_de_retorno>..HEAD --oneline`), tabla de auditoría, invariantes, cifras, dudas y
   pendientes, errores propios y notas para el revisor. Las secciones por fase no se reescriben.
3. **Bloque J.** Se rellena copiando del detalle, nunca de memoria.
4. **Privacidad.** `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' <LOG>` → esperado: vacío. Una lectura
   confirma que no hay filas de datos ni nombres de personas o de establecimientos: se usan RBD o conteos.
5. **Verificación del archivo.**
   - `ls -l <LOG> && wc -l <LOG>`;
   - `grep -c '^### FASE' <LOG>` igual al número de fases ejecutadas;
   - `grep -c '^esperado:' <LOG>` igual a `grep -c '^obtenido:' <LOG>`;
   - `grep -c '^## J' <LOG>` igual a 1, con el bloque relleno.

   Si algo falta, se anexa con su estado real, sin ajustar el conteo.
6. **Commit.** `git add 50_documentacion/andamios/logs/20260926_ejecucion_decisiones_s35k_log.md` y
   `git commit -m "docs(log): ejecucion de las decisiones D35-17 a D35-19 (s35k)"`. Después, `git push origin main`, solo
   si se cumple la autorización 6. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   el traspaso de cierre (Q-71: «`suitedoc` en remoto privado»). Incluye el hash de `docs(log)`.

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - K1: la ruta y la verificación del respaldo, el `diff` del rescate, la re-verificación por rama y `git branch` final;
   - K2: el `diff` de `renv/settings.json`, los paquetes agregados al lock con su versión y la salida de `renv::status()` antes y después;
   - K3: el resultado de cada copia con insumos plantados o quitados, antes y después, y el `grep` de los literales;
   - I-4 con su evidencia y los md5 de `docs/` (sin cambio);
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

`feat/contrato-contexto` (D35-17: se deja), la regeneración de la suite con `documentar.R` (su configuración no
describe el pipeline actual), `docs/` y Pages, Museo Sans en la suite (D35-7), CLAUDE.md (D2), la corrección de
Q-71 (va en el traspaso de cierre) y el proceso R huérfano de otro proyecto (Q-70, lo detiene el titular).

---

## Apéndice: plantilla del log

```markdown
# Log: ejecución de las decisiones D35-17 a D35-19 (s35k) (slep_simce_adecuado)

- Meta: <una línea>
- Fecha: <AAAA-MM-DD> · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: <hash de T0>
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: <...>
- Grafo y olas: <copiados de §5>
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando

## J. Juicio (lo rellena FASE L)

<!-- trece campos, una línea cada uno:
- Meta y resultado:
- Estado por tarea:
- Commits:
- Auditoría (FASE R):
- Invariantes:
- Cifras críticas:
- Decisiones autónomas de mayor riesgo:
- Desviaciones respecto del encargo:
- Dudas abiertas:
- Errores propios:
- Qué debe verificar el revisor por sí mismo:
- No publicado / queda al usuario:
- Ejecución:
-->

### FASE 0: log, punto de retorno y premisas
(Estado, Commits, Cambios sustantivos, Verificación con esperado/obtenido, Alcance, Regresión, Subagentes,
Bugs, Decisiones autónomas, Errores propios, Dudas)

### FASE K1 ... ### FASE K4 (una sección por tarea, en el orden en que cierran)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
