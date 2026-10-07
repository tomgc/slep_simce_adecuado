# Encargo autónomo: verificaciones pendientes, batería del motor y CLAUDE.md (sesión 35, duodécima ola, segunda emisión)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-26. Ejecución: Claude Code en la estación macOS del titular, tras `/clear`.

**Segunda emisión.** Reemplaza la primera (md5 `0dc9589bcee4d25c42c52735ad40c0e6`), que se detuvo en H1 sin
ejecutar tareas (log `50_documentacion/andamios/logs/20260926_verificaciones_s35l_log.md`, commit local
`349f22d`, sin push). Cambios: H1 acota la búsqueda de baterías a `30_procesamiento/` (Q-76); H3 espera el
commit local del log; L1 enlaza el directorio oficial en el clon y retira el paquete de la calibración con `mv`
(Q-78); L3 declara las nueve coincidencias fuera de alcance e incluye la L305 de `documentar.R` (Q-77); L4 cubre
también el texto de años sin Simce de la vista (L425); M2 toma sus marcadores de las fuentes. Todo sale de las
notas del Cierre §9 de ese log.

**Contexto.** El encargo `encargo_ejecucion_decisiones_s35k.md` quedó en `main` (`10672ea`, log
`50_documentacion/andamios/logs/20260926_ejecucion_decisiones_s35k_log.md`). Dejó tres dudas que el titular
aprobó resolver (Q-73 a Q-75) y un detalle (R-41). El titular pidió además incluir todo lo que deja inseguro al
asistente de la sesión 35, y decidió crear CLAUDE.md local, sin versionar (D35-20, abajo). Lo que este encargo
cierra:

- **Q-73.** El lock nuevo (57 paquetes, `suitedoc` ignorado) nunca se restauró en una biblioteca vacía; dos
  paquetes (`stringi`, `sys`) quedaron registrados desde Posit Package Manager.
- **Q-74.** Si faltan los archivos de 2014 en los dos niveles, el build pasa y el rango dice 2015–2025: la
  constante `ANIO_INICIO` no funciona como piso.
- **Q-75.** `ANIOS_SIN_SIMCE` está escrito en dos lugares, y varios textos citan el rango fijo.
- **R-41.** La vista trae «2014» escrito a mano como valor inicial del año (L433).
- **Inseguridad del asistente: el motor no tiene batería versionada.** Todo lo que s35f a s35i midieron en el
  motor (desborde a 375 px, modal, supergrid, tooltip, centrado, PNG con gobCL) se midió con scripts
  `verificar_*.R` que git ignora. Una regresión futura no la detectaría ninguna prueba del repositorio.
- **CLAUDE.md (D35-20).** Los logs de s35 a s35k repiten que no se crea.

**Meta en una línea:** que el lock se restaure desde cero, que el build exija la serie completa desde 2014,
que los años sin Simce vivan en un solo lugar, que el motor tenga una batería versionada con control positivo
y que exista un CLAUDE.md local. El contenido publicado no cambia.

**D35-20 (decisión del titular, 2026-09-26, ya escrita en el archivo de decisiones; T0 la commitea).**
CLAUDE.md se crea en la raíz, local y sin versionar (el `.gitignore` lo excluye en la L49). El log de s35j, con
referencias generales a dos repositorios privados, se deja como está.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** tareas en serie que comparten
build y batería.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 o H6 (batería o build) fallan → **detén la sesión**.
- Si una tarea no cumple su criterio tras 3 intentos → congela esa tarea, revierte sus cambios sin commitear
  (autorización 3) y sigue con la siguiente. El resto se commitea igual.
- L1: si la restauración necesitara tocar `renv.lock`, `renv/settings.json` o la biblioteca del árbol
  principal → no lo hagas; congela L1.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. **L1:** `git clone` local del repositorio a `$TMPDIR/s35l/clon` y, **dentro del clon**, `renv::restore()`
   con descarga desde la red, en una biblioteca y un caché de `renv` que vivan en `$TMPDIR/s35l/` (nunca el
   caché global ni la biblioteca del árbol principal). Enlazar en el clon, con `ln -s`,
   `20_insumos/auxiliares/directorio_oficial_ee.csv` del árbol principal (git lo ignora y lo leen los pasos 30
   y 31). Correr en el clon el build y las baterías. Para la calibración, retirar un paquete de la biblioteca del
   clon con `mv` a `$TMPDIR/s35l/retirado/` (nunca `rm`).
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE de la tarea en curso,
   después de guardar el intento como parche en `$TMPDIR/cal_s35l/` y anotar su md5 en el log.
4. Crear, sobrescribir y borrar `verificar_*.R` en la raíz y archivos en `$TMPDIR`. Crear copias del
   repositorio en `$TMPDIR` para plantar o quitar insumos (L2).
5. **L6:** crear `CLAUDE.md` en la raíz, sin `git add`.
6. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío (CLAUDE.md queda ignorado, no cuenta);
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` sin cambio (I-2).

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más. No se autoriza
`renv::snapshot()`, `renv::install()` ni `install.packages()` en el árbol principal.

**Reglas canónicas heredadas.** R es el único lenguaje de los entregables (la batería nueva, en R). Los commits
van en español. Toda medida nueva va en una constante nombrada. `docs/` solo cambia por copia íntegra, y este
encargo no la copia. Un código de salida se lee sin tubería. `grep -c` sale con código 1 cuando cuenta 0
(A34-3). El motor admite como máximo 5 territorios (D35-14). En R, `!` tiene menor precedencia que `+`: se
escribe `a + (!b)` (lección de R-32 de s35i).

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:**
   - el log de s35k (K2, K3, R-40 a R-46, Q-73 a Q-75);
   - los logs de s35f a s35i: los criterios y medidores del motor que L5 convierte en pruebas (s35f TT y TB;
     s35g G1 y G3; s35h M1, M2, M4; s35i M5);
   - `30_procesamiento/36_verificar_trayectorias.R`, como modelo de estructura (`comprobar()`, familias,
     control positivo dentro de la prueba);
   - `50_documentacion/activa/POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`, para L6.
3. **POSICIÓN:**
   - rutas completas;
   - `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado` (la shell es zsh: `PIPESTATUS` no
     existe);
   - R con `cd "$RAIZ" && Rscript ...` (con `renv` activo, salvo en el clon de L1);
   - `rev-parse` con un argumento por comando;
   - `fetch` antes de operar contra el remoto.
4. **LOG:** `50_documentacion/andamios/logs/20260926_verificaciones_s35l2_log.md` (el de la primera emisión no
   se toca).
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0, con 0 fallas críticas;
   - `Rscript 30_procesamiento/36_verificar_trayectorias.R` → código 0, con 35 pruebas o más;
   - `Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base»;
   - tras L5, además, `Rscript 30_procesamiento/33_verificar_motor.R` → código 0.
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Medidas en la sesión 35 con git de solo lectura (`GIT_OPTIONAL_LOCKS=0`), `grep` y `md5sum` sobre la estación,
salvo donde se cita el log de s35k.

- `origin/main` está en `10672ea` y `HEAD` en `349f22d` (el log de la primera emisión, commit local sin push;
  sale con el push de este encargo). El árbol tiene dos archivos modificados, el registro de errores
  (ERR-35-24) y el de decisiones (D35-20), que T0 commitea (fuente: `git rev-parse` y `git status --porcelain`). Solo existen las ramas
  `main` y `feat/contrato-contexto` (fuente: `git branch`).
- `docs/index.html` = `42ab93003e722f9bb6c725fec2d348bd` y `docs/trayectorias.html` =
  `883f76bcefc89d93f2d1e753fc4d75c3` (fuente: `md5sum`). El build de hoy los reproduce byte a byte (fuente:
  log s35k, H6).
- `renv/settings.json` ignora `suitedoc` (fuente: `grep`). El lock tiene 57 paquetes; `stringi` y `sys` con
  `Repository` de Posit Package Manager (fuente: log s35k, K2 y R-40).
- `31_leer_normalizar.R`: `ANIO_INICIO <- 2014L` (L130) y `ANIOS_SIN_SIMCE <- c(2019L, 2020L, 2021L)` (L131);
  el hueco se mide entre el primer y el último año presentes (L163-190). `33_generar_html.R` L206 repite
  `anios_sin_simce = c(2019L, 2020L, 2021L)` en `meta` (fuente: `grep -n`). `10_utils/10_configuracion.R` define
  `ruta_insumos()` (L22) y lo cargan los scripts ejecutables (fuente: `grep`).
- `10_utils/10_html.R` define `MARCADOR_ANIO_MIN` y `MARCADOR_ANIO_MAX` (L23-24) y `sustituir_anios()` (L82);
  `33_generar_html.R` la llama en la L432 (fuente: `grep -n`). La vista tiene
  `<div class="yr" id="yr">2014</div>` en la L433 (fuente: `grep -n`).
- Textos con el rango fijo (fuente: `grep -n` y log s35k R-44): `README.md` L134 (`2014–2018, 2022–2025`);
  `50_documentacion/activa/manifiesto_insumos.md` L10 («hoy, todos los años 2014–2025») y sus tablas por año
  (L33, L47 y vecinas); `50_datos_versionados_autorizados.md` L24-26; `50_documentacion/suite/documentar.R`
  L58, L98, L100, L275 y L324.
- El motor no tiene batería versionada: `git ls-files 30_procesamiento | grep verificar` lista solo
  `30_procesamiento/36_verificar_trayectorias.R`. Fuera de esa carpeta está además
  `50_documentacion/andamios/verificar_trayectorias.R`, la batería congelada de la vista de la sesión 30 (fuente:
  log de la primera emisión, H1).
- `50_documentacion/suite/documentar.R` tiene también un literal de rango en la L305, y la plantilla de la vista
  trae el texto fijo «2019, 2020 y 2021 no tienen medición Simce» en la L425 (fuente: log de la primera
  emisión, §9).
- La salida del motor contiene `__PURE__` (397 veces) y `__REACT_DEVTOOLS_GLOBAL_HOOK__` (2), que no son
  marcadores del proyecto. Los marcadores propios son 12 en la plantilla y el fragmento, más `PATRON_ANIO_RESTO`
  y `PATRON_SITIO_RESTO` de `10_utils/10_html.R` (fuente: log de la primera emisión, §9).
- `.gitignore` L49 excluye `CLAUDE.md`, y no existe en la raíz (fuente: `grep -n` y `ls`).

---

## 3. Contexto mínimo

Ninguna tarea cambia el contenido publicado: L2 y L3 cambian reglas del build con los mismos insumos, L4
sustituye un literal por el mismo valor, L5 agrega pruebas y L6 escribe un archivo que git ignora. L1 trabaja
en un clon. Por eso I-4 exige salidas iguales a `docs/` al final.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | Las refs no cambian, salvo `main` | `git for-each-ref --format='%(refname) %(objectname)'` en FASE 0 y en FASE L | iguales fuera de `refs/heads/main` y `refs/remotes/origin/main` |
| I-2 | `docs/` no cambia | `md5 -q docs/index.html docs/trayectorias.html` | `42ab9300…` y `883f76bc…` |
| I-3 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-4 | El contenido de las salidas no cambia | vista: md5 igual a `docs/trayectorias.html`; motor: igual a `docs/index.html` fuera de `meta$fecha_generacion` | iguales |
| I-5 | El entorno del árbol no cambia | md5 de `renv.lock` y de `renv/settings.json`, y la lista de la biblioteca de `renv` con versiones, en FASE 0 y en FASE L | idénticos |
| I-6 | Se agrega por `cod_com_rbd` | `grep -nE '(\.by\|\bgroup_by\|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R \| grep -v cod_com_rbd` | vacío |
| I-7 | No se agregan archivos de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |
| I-8 | Las fuentes no cambian | `md5 -q 10_utils/fuentes/*.otf` | `a7407ed6…` (Bold) y `0257bb4b…` (Regular) |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, L1, L2, L3, L4, L5, L6, FASE R, FASE L con el push.

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` |
| L1 | ninguna ruta del árbol (solo `$TMPDIR/s35l/`) |
| L2 | `30_procesamiento/31_leer_normalizar.R` |
| L3 | `10_utils/10_configuracion.R`, `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_generar_html.R`, `README.md`, `50_documentacion/activa/manifiesto_insumos.md`, `50_documentacion/activa/50_datos_versionados_autorizados.md`, `50_documentacion/suite/documentar.R` |
| L4 | `30_procesamiento/36_trayectorias_template.html`, `30_procesamiento/36_generar_trayectorias.R`, `10_utils/10_html.R` |
| L5 | `30_procesamiento/33_verificar_motor.R` (nuevo) |
| L6 | `CLAUDE.md` (ignorado; sin commit) |

---

## 6. FASE 0

1. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado, exactamente estas tres líneas, más el log:
   - ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
   - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`
   - `?? 50_documentacion/activa/encargos/encargo_verificaciones_s35l.md`

   Además, `git ls-files 30_procesamiento | grep verificar` → esperado: solo
   `30_procesamiento/36_verificar_trayectorias.R`.
3. **H2.** `git stash list | wc -l` → `0`; `git worktree list` → solo el árbol principal.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `349f22d` y `rev-parse --short origin/main` →
   `10672ea`. Guarda las salidas de I-1 e I-5 en `$TMPDIR/s35l/`.
5. **H4.** md5 de este encargo → esperado: el del mensaje de entrega. md5 de `docs/` → los de I-2. Después, `git add`
   de las tres rutas de T0 y
   `git commit -m "docs(sesion 35): encargo de la duodecima ola y decision D35-20"`. El hash resultante es el
   punto de retorno.
6. **H5.** Batería de la vista → 35 en PASA, código 0.
7. **H6.** `Rscript 00_build.R` → código 0, e I-4. Copia las dos salidas a `$TMPDIR/base_s35l/` y calibra
   `verificar_contenido_motor.R` («idéntico» sobre la base, «difiere» con un número alterado).
8. **Calibración de L2.** En una copia del repositorio, quita los dos archivos de 2014 (`2m` y `4b`) y corre
   el paso 31. Esperado: **pasa** (el defecto de Q-74).
9. Anexa `### FASE 0`.

---

## 7. Tareas

### L1. El lock se restaura desde cero (Q-73)

1. Clona el repositorio a `$TMPDIR/s35l/clon` (autorización 2). En el clon, con el caché y la biblioteca de
   `renv` en `$TMPDIR/s35l/` (registra cómo lo configuraste), comprueba primero que la biblioteca está vacía y
   después corre `renv::restore()`.
2. **Criterio.**
   - `renv::restore()` termina sin error y restaura los 57 paquetes, `stringi` y `sys` incluidos (anota de
     dónde bajó cada uno de los dos);
   - `renv::status()` en el clon: «No issues found» (o equivalente), con `suitedoc` ignorado;
   - en el clon, `Rscript 00_build.R` da código 0 y sus dos salidas cumplen I-4 contra `docs/`;
   - en el clon, la batería de la vista da 35 de 35;
   - I-5 en el árbol principal: sin cambio.
   - **Calibración:** la biblioteca del clon está vacía antes de `restore()` (conteo 0), y un paquete del lock
     retirado con `mv` de esa biblioteca tras la restauración hace que `renv::status()` lo reporte (después se
     devuelve con `mv` y `renv::status()` vuelve a quedar sin problemas).
3. Sin commit (no cambia el árbol). Si `restore()` falla, registra la salida literal y el paquete que falla,
   congela L1 y sigue.

### L2. La serie debe empezar en `ANIO_INICIO` (Q-74)

1. En el paso 31, además de las reglas de hoy, el build se detiene si el primer año presente de un nivel no es
   `ANIO_INICIO`, con un mensaje que nombra el nivel y los años que faltan desde `ANIO_INICIO`.
2. **Criterio.**
   - Copia sin 2014 en los dos niveles → se detiene (antes pasaba: FASE 0, paso 8);
   - insumos completos → pasa; los casos de K3 de s35k (sin 2m 2024; con 2m 2019; sin 2014 solo en 2m; 2026 en
     los dos niveles; 2025 repetido en 2m) dan el mismo resultado que en s35k;
   - I-4 con los insumos de hoy.
3. Commit: `fix(pipeline): la serie Simce debe empezar en ANIO_INICIO (Q-74)`.

### L3. Los años sin Simce en un solo lugar y los textos sin rango fijo (Q-75)

1. `ANIO_INICIO` y `ANIOS_SIN_SIMCE` pasan a `10_utils/10_configuracion.R` (con su comentario de origen). El
   paso 31 y `33_generar_html.R` (el campo `meta$anios_sin_simce`) los usan desde ahí; no queda otro literal
   `2019L, 2020L, 2021L` en el código (anota el `grep`).
2. Textos:
   - las frases que describen la serie («2014–2025», «2014 a 2025», «hoy, todos los años 2014–2025») se
     reescriben sin año final fijo: «desde 2014, sin 2019 a 2021, hasta el último año cargado en
     `20_insumos/simce/`», o equivalente;
   - las **tablas por año** del manifiesto y los datos del `README.md` que describen lo que hay hoy se dejan
     como inventario: se actualizan cuando llegue un archivo, no se reescriben;
   - en `documentar.R`, solo los literales de rango, incluida la L305 (sin correrlo: su configuración no describe el pipeline
     actual). Verificación: `Rscript -e 'invisible(parse("50_documentacion/suite/documentar.R"))'` con
     código 0.
3. **Criterio.**
   - `meta$anios_sin_simce` sigue siendo 2019, 2020 y 2021 (I-4 lo cubre);
   - `git grep -n '2014–2025\|2014 a 2025\|2014-2025'` fuera de logs, traspasos, encargos y decisiones: solo
     las filas de inventario que declares, una por una, más estas nueve, que quedan fuera de alcance y se
     declaran así: `docs/index.html:1370`, `docs/trayectorias.html:431` y `:565` (se actualizan con la próxima
     publicación), `50_documentacion/andamios/mockup_trayectoria_traspasos.html:288` (congelado),
     `20_insumos/auxiliares/prototipo_design/app.jsx:52` y `main.jsx:200` (prototipo),
     `50_documentacion/suite/documentacion_general_slep_simce_adecuado_standalone.html:367` (lo regenera
     `documentar.R`), `50_documentacion/andamios/20260924_contexto_referente_trayectorias.html:60` (andamio) y
     `50_documentacion/activa/50_revision_safari_trayectorias.md:38` (guía de revisión). Si el número o las
     líneas no coinciden, se registra, sin editar esos archivos;
   - build y batería en PASA.
4. Commit: `refactor(config): años sin Simce en un solo lugar y textos sin rango fijo (Q-75)`.

### L4. El año inicial de la vista sale de los datos (R-41)

1. El `2014` de `<div class="yr" id="yr">` pasa al marcador `__ANIO_MIN__`, sustituido en el build con el
   mismo mecanismo de K3 (`sustituir_anios()`), también en el generador de la vista si todavía no lo llama.
   El texto «2019, 2020 y 2021 no tienen medición Simce» (L425) pasa a un marcador que el build llena desde
   `ANIOS_SIN_SIMCE` (de L3), con la misma forma («2019, 2020 y 2021»).
2. **Criterio.** I-4 (la vista sale idéntica a `docs/`); `grep -n '>2014<'` y `grep -n '2019, 2020 y 2021'`
   en la plantilla → 0; un marcador
   sin sustituir detiene el build (control: plántalo mal escrito en una copia).
3. Commit: `fix(trayectorias): el año inicial de la vista sale de los datos (R-41)`.

### L5. Batería versionada del motor

1. `30_procesamiento/33_verificar_motor.R`, con la misma estructura que la batería de la vista
   (`comprobar(id, descripcion, condicion, detalle)`, informe por consola, código 1 si algo falla, guarda de
   locale, `here::here()`, sin rutas absolutas ni archivos escritos en el árbol). Lee
   `40_salidas/motor_comparacion.html`; las pruebas de navegador usan chromote.
2. Pruebas mínimas (id con prefijo `M`), cada una con control positivo dentro de la misma prueba (un HTML de
   control en `tempdir()` o un valor plantado):
   - **M1** sin carga por red (el patrón de I-2 de s35h);
   - **M2** ningún marcador del proyecto sin sustituir: la lista se arma leyendo las fuentes (los 12 de la
     plantilla y el fragmento, más `PATRON_ANIO_RESTO` y `PATRON_SITIO_RESTO` de `10_html.R`), no con un patrón
     genérico, porque la salida trae `__PURE__` y `__REACT_DEVTOOLS_GLOBAL_HOOK__`;
   - **M3** `meta$anios` igual a los años de los nombres de archivo en `20_insumos/simce/`, sin
     `ANIOS_SIN_SIMCE`;
   - **M4** sin desborde horizontal en `#comparacion` y `#panorama` a 375, 768 y 1280 px;
   - **M5** el modal «Agregar territorio» cabe en la ventana a 375 px en sus 6 pestañas (Q-55);
   - **M6** con 5 territorios, ningún texto del supergrid sale de su celda a 375, 641, 670 y 700 px (Q-34,
     Q-66);
   - **M7** a 375 px, el tooltip no tapa el punto en los casos de G3 de s35g (Q-54);
   - **M8** el PNG exportado del supergrid usa `gobCL-sitio` (ancho de tinta de un texto de referencia, como M4
     de s35h) (Q-31).
3. **Criterio.**
   - Las 8 pruebas en PASA sobre el build actual, código 0;
   - **calibración:** cada control positivo da FALLA (anota la salida literal); y, además, la batería completa
     contra una salida saboteada por prueba (por ejemplo, el `min-width: 540px` del modal devuelto en una copia
     para M5) da FALLA en la prueba que corresponde;
   - el tiempo total de la batería queda anotado.
4. Commit: `test(motor): bateria versionada del motor con control positivo`.

### L6. CLAUDE.md local (D35-20)

1. `CLAUDE.md` en la raíz, 80 líneas como máximo, en español, con: qué es el proyecto; dónde viven las reglas
   (POLITICA, SETTINGS, el instrumento de encargos) y que mandan sobre este archivo; R como único lenguaje de
   los entregables, R moderno, `here::here()`, nunca rutas absolutas; `docs/` solo por copia íntegra; los
   comandos de PRUEBAS (con las dos baterías); A34-1 (el md5 del motor cambia con la fecha) y A34-3; la regla
   de `!` en R; el tope de 5 territorios.
2. **Verificación:** `git check-ignore -v CLAUDE.md` lo muestra ignorado por la L49; `git status --porcelain`
   no lo lista; `wc -l` ≤ 80.
3. Sin commit.

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
6. **Commit.** `git add 50_documentacion/andamios/logs/20260926_verificaciones_s35l2_log.md` y
   `git commit -m "docs(log): verificaciones pendientes, bateria del motor y CLAUDE.md (s35l, segunda emision)"`. Después, `git push origin main`, solo
   si se cumple la autorización 6. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   la revisión en Safari y en un teléfono de s35h y s35i, y el traspaso de cierre. Incluye el hash de `docs(log)`.

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` y el hash de `docs(log)`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - L1: cómo se aisló el caché, el conteo de la biblioteca antes y después, el origen de `stringi` y `sys`, y el build y la batería en el clon;
   - L2: la tabla de casos de copias (antes y después);
   - L3: el `grep` de literales de años y de rango, con las filas de inventario declaradas;
   - L5: las 8 pruebas con su control positivo y el resultado contra cada salida saboteada, y el tiempo total;
   - L6: `wc -l` y `git check-ignore -v` de CLAUDE.md;
   - I-4 con su evidencia y los md5 de `docs/` (sin cambio);
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

`docs/` y Pages (el contenido no cambia), `feat/contrato-contexto`, la regeneración de la suite con
`documentar.R`, Museo Sans en la suite (D35-7), la corrección de Q-71 (va en el traspaso de cierre), Q-70 (el
proceso R de otro proyecto, lo detiene el titular) y la revisión en Safari y en un teléfono (del titular).

---

## Apéndice: plantilla del log

```markdown
# Log: verificaciones pendientes, batería del motor y CLAUDE.md (s35l, segunda emisión) (slep_simce_adecuado)

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

### FASE L1 ... ### FASE L6 (una sección por tarea, en el orden en que cierran)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
