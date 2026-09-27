# Log: últimos textos de documentación al día (s35p) (slep_simce_adecuado)

- Meta: ningún texto de los cinco puntos de D35-25 (Q-90 a Q-94) afirma algo que el código contradiga; el producto no cambia.
- Fecha: 2026-09-26 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: `b80a6d5` (commit de T0, H4; b80a6d55daa607accda5c3ac80b3050f61307618)
- Encargo: `50_documentacion/activa/encargos/encargo_documentacion_s35p.md`, md5 `bd84f0fceb6cb82f52b1edf2eae99ea7` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega; se mide otra vez en H4)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`). El harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y prevalece: sin subagentes ni Workflow, todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, P1 a P5, FASE R, FASE L con el push.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Carpetas de trabajo: `$TMPDIR/s35p/` (instantáneas de I-1 e I-5), `$TMPDIR/cal_s35p/` (lecturas, instrumentos, calibración, copias, controles y parches) y `$TMPDIR/base_s35p/` (las dos salidas del build de H5). `$TMPDIR` = `/var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/`.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: D35-25 (Q-90 a Q-94) &rarr; parcial: Q-91, Q-92, Q-93 y Q-94 al día y el producto sin cambio (42ab9300…/883f76bc…); Q-90 no, porque P1 se congeló por su regla (el `git grep` dio 2 aciertos del validador), y P5 dejó tres enlaces rotos en el README, fuera del ALCANCE (Q-97).
- Estado por tarea: T0 completa (b80a6d5) · P1 congelada (§7 P1.1: `git grep` con 2 aciertos) · P2 completa (9d8aa9e) · P3 completa (8dc85dc) · P4 completa (00a1b4b; criterio de `json_motor` en 2 y no en 0, Q-96) · P5 completa (0836a50; cita del README registrada, Q-97) · FASE R y FASE L completas.
- Commits: 6, de b80a6d5 al `docs(log)` de este archivo (T0, P2 a P5 y el log; hash en el reporte final), de los cuales 0 `fix(auditoria)`.
- Auditoría (FASE R): APROBADO CON ADVERTENCIAS; hallazgos B/R/A = 0/0/10; reparados 0; abiertos 0 (ADVIERTE R-19 a R-28); 18 de 18 afirmaciones confirmadas con otros instrumentos; 16 controles positivos disparan.
- Invariantes: 5/5 PASA (R.3, y I-1, I-2 e I-5 otra vez en FASE L); FALLA: ninguno.
- Cifras críticas: intactas: `docs/` 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…), `40_salidas/` igual a la base por I-4 y `cmp`, `renv.lock` e6323bf2…; los tres archivados con sus md5 (89a17069…, de025e48…, ea91c914…), iguales a sus blobs de b80a6d5.
- Decisiones autónomas de mayor riesgo: D5-a, archivar pese a que el README los enlaza (descartada: congelar P5, contra §7 P5.2); P1 congelada con la regla literal aunque los aciertos no leen las variables (descartada: tenerlos por ajenos, decisión del titular, Q-95); D4-a, cinco comentarios más que los que nombra §7 P4.1 (descartada: solo los nombrados).
- Desviaciones respecto del encargo: P1 no se ejecutó (congelada por su propia regla); el criterio de P4 sobre `json_motor` no se cumple (2, no 0); la premisa de §2 Q-94 no se cumplió (el README cita los documentos). Ninguna en criterios, tolerancias ni ALCANCE.
- Dudas abiertas: 4 (Q-95 a Q-98); las más bloqueantes: Q-97 (¿se quitan del README las entradas de los documentos archivados?), Q-95 (¿se ejecuta P1 contando como ajenas las dos líneas del validador?) y Q-96 (¿vale el `grep` de `json_motor` como palabra completa?).
- Errores propios: 9 registrados (§8): cuatro cifras o referencias escritas antes de medirlas y corregidas en el lugar, no con línea nueva; las de §6, escritas antes de su medición; tres de instrumento (un escape, el conteo de tablas, un control sin efecto); dos rótulos «obtenido (» (conteo 23/21). Ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: el README y la guía publicados (Q-97; «Segmentación por GSE» en la guía); la identidad de `docs/` con `40_salidas/` (`git hash-object`, un comando); las respuestas a Q-95 a Q-98.
- No publicado / queda al usuario: el push de `main` va en el reporte final (condiciones de la autorización 6); el traspaso de cierre, Q-70, Q-71 y Q-95 a Q-98.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite, aunque el harness tenía «ultracode» activo); git 2.54.0, R 4.5.2 con `renv`, Python 3.14.7, Chrome sin interfaz vía `chromote`; de 22:34:11 a 22:56 (el commit del log y el push, en el reporte final).

### FASE 0: log, punto de retorno y premisas

Inicio de FASE 0: 2026-09-26 22:34:11 (`date` del comando que creó las carpetas de trabajo). Antes, lectura de los insumos, sin ningún comando de escritura en el árbol: este encargo; `CLAUDE.md` (70 líneas, md5 ab8c54a9260cb0d778c197505058522b); el log de s35o entero (§7, R-18 a R-22 y D1-a); `README.md` (328 líneas, `wc -l`; se escribió primero 327, leído del `cat -n` y no medido, y se corrigió enseguida: ver errores propios); `00_build.R`; `10_utils/10_configuracion.R`; `10_utils/10_validar_portabilidad.R` (encabezado y checks de entorno); `.Renviron.example`; `publicacion_github_pages.md`; `10_utils/10_utils.R` entero; `30_procesamiento/30_construir_auxiliares.R` (comentarios y escrituras); el archivo de decisiones (estructura y D35-20 a D35-24); POLITICA §1.5; `.gitignore`. Lecturas de solo lectura para preparar las tareas: `git grep` de las tres premisas (Q-90, Q-93 y Q-94; sus resultados se miden otra vez, con su `esperado:` escrito antes, en P1, P4 y P5), `gh api` de la configuración de Pages (GET) y los esquemas de `sleps_chile.parquet` (`arrow`). Del repositorio hermano `herramientas_dev`, solo lectura: `git grep 'portabilidad-cross-os:'` (0 aciertos; ninguna herramienta vigente usa la marca de P2).

**Paso 1.** Log creado antes de H1, con el encabezado, el slot J vacío y la plantilla; por eso H1 muestra también la línea del propio log. Cada `esperado:` se escribe en el log antes de correr su comando (regla de pre-registro). Los instrumentos de I-3 e I-4 son copias de los de s35o (`$TMPDIR/cal_s35p/instrumentos/`), recalibrados en el paso 6b.

**H1.** `git status --porcelain`
esperado: exactamente `?? 50_documentacion/activa/encargos/encargo_documentacion_s35p.md`, más el log
obtenido: status_codigo=0, la línea esperada más el log (salida en `$TMPDIR/cal_s35p/f0/h1.txt`):
```text
?? 50_documentacion/activa/encargos/encargo_documentacion_s35p.md
?? 50_documentacion/andamios/logs/20260926_documentacion_s35p_log.md
```
**Cumple.**

**H2.** `git stash list | wc -l` y `git worktree list`
esperado: 0; solo el árbol principal
obtenido: stash_codigo=0, 0 líneas; `/Users/tomgc/Projects/slep_simce_adecuado f8cadb2 [main]` (wt_codigo=0). **Cumple.**

**H3.** `git fetch origin`; después `git rev-parse --short HEAD` y `git rev-parse --short origin/main`, en dos comandos. Instantáneas: I-1 (`git for-each-ref --format='%(refname) %(objectname)'`, `$TMPDIR/s35p/i1_fase0.txt`) e I-5 (`md5 -q renv.lock renv/settings.json`, `$TMPDIR/s35p/i5_fase0.txt`)
esperado: fetch sin error; f8cadb2 y f8cadb2
obtenido: fetch_codigo=0 (sin salida); `f8cadb2` (c1=0) y `f8cadb2` (c2=0). `git ls-remote --heads origin`: `feat/contrato-contexto` 31befa2c… y `main` f8cadb2c…. I-1 de partida (`i1_fase0.txt`, i1_codigo=0):
```text
refs/heads/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/heads/main f8cadb2c3c90b82e2d3881b461a0859514793a94
refs/remotes/origin/HEAD f8cadb2c3c90b82e2d3881b461a0859514793a94
refs/remotes/origin/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/remotes/origin/main f8cadb2c3c90b82e2d3881b461a0859514793a94
```
I-5 de partida (`i5_fase0.txt`, i5_codigo=0): `renv.lock` e6323bf2d0fb341589c4ce8a19b74636 y `renv/settings.json` d0bcb98db909870724e9b0fc5eff1700, los mismos de s35o. **Cumple.**

**H4.** `md5 -q` del encargo y de `docs/`; después, la sección `### D35-25` en el archivo de decisiones, `git add` de las dos rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decimosexta ola y decision D35-25"`
esperado: bd84f0fceb6cb82f52b1edf2eae99ea7 (mensaje de entrega); 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3; un commit con las dos rutas, padre f8cadb2
obtenido: encargo bd84f0fceb6cb82f52b1edf2eae99ea7 (m1=0); `docs/index.html` 42ab93003e722f9bb6c725fec2d348bd y `docs/trayectorias.html` 883f76bcefc89d93f2d1e753fc4d75c3 (m2=0). El archivo de decisiones (md5 de partida ced0d23a510612ca18340c25d502a422) recibe al final un encabezado `## Decisiones del titular tras el encargo `encargo_readme_s35o.md` (sesión 35, 2026-09-26)` y la sección `### D35-25. Últimos textos de documentación` con las cinco viñetas del Contexto del encargo, copiadas tal cual (10 líneas agregadas). T0: commit_codigo=0, `b80a6d5 docs(sesion 35): encargo de la decimosexta ola y decision D35-25`, padre `f8cadb2`, «2 files changed, 364 insertions(+)»; `git show --name-status` = `M …/20260924_decision_referente_traspasos.md` y `A …/encargo_documentacion_s35p.md`; `git status --porcelain` = solo este log. **Punto de retorno: b80a6d5** (b80a6d55daa607accda5c3ac80b3050f61307618).

**H5.** `cd "$RAIZ" && Rscript 00_build.R` (salida en `$TMPDIR/cal_s35p/f0/h5_build.txt`); después, copia de `40_salidas/motor_comparacion.html` y `40_salidas/trayectorias_traspasos.html` a `$TMPDIR/base_s35p/`; lo que dice el validador de portabilidad sobre `.Renviron.example`
esperado: código 0; «Fallas criticas: 0»; las dos salidas escritas y copiadas; `git status --porcelain` = solo este log
obtenido: **build_codigo=0** (22:35:24 a 22:35:32; «=== 00_build.R: OK en 7 segundos ===»; 286 líneas de salida). Validación de portabilidad al inicio: «Archivos escaneados: 33», «Fallas criticas: 0 | Advertencias: 7» (seis `separador_manual` y un `system_shell`, las mismas clases de s35o: `00_escanear_proyecto.R` L101 y L184, `10_html.R` L175, `10_locale.R` L27, `36_generar_trayectorias.R` L88 y L165, `36_verificar_trayectorias.R` L955; se escribió primero «las mismas clases y archivos de s35o», pero el log de s35o no lista los archivos, y se corrigió enseguida: ver errores propios); los ocho checks de entorno en OK, con `data_root_resuelto` «Resuelto por ruta_insumos()». Pasos: 30 OK (slep_cc_establecimientos 73, comunas_chile 345, sleps_chile 2337 y establecimientos_chile 10945 filas, cuatro parquet); 31 «18 archivos detectados (9 por nivel)», A3 en los tres archivos de s35o, 185378 filas; 32 44975 filas (14 columnas); 33 escribe `motor_comparacion.html` (2866 KB); 36 escribe `trayectorias_traspasos.html` (2.21 MB). Copia a `$TMPDIR/base_s35p/`: cp_codigo=0; md5 de la base **42ab93003e722f9bb6c725fec2d348bd** (motor) y **883f76bcefc89d93f2d1e753fc4d75c3** (vista), iguales a los de `docs/` (el `meta$fecha_generacion` del motor es el día, 2026-09-26, el de lo publicado; A34-1). `git status --porcelain` = solo este log. **Cumple.**

**Lo que dice el validador sobre `.Renviron.example`** (anotado para P1): un solo check, `renviron_example` en **OK** («.Renviron.example ausente en la raiz del repo» es su mensaje de falla, que no aplica). El escaneo estático no lo lee: el patrón de extensiones del validador (`\.(R|r|Rmd|rmd|qmd|ya?ml)$`, leído con `sys.source()` en `$TMPDIR/cal_s35p/f0/ext.R`, ext_codigo=0) da FALSE para `.Renviron.example`. El resultado del validador depende, entonces, solo de que el archivo exista.

**Paso 6b. Instrumentos de I-3 e I-4, calibrados antes de editar** (`$TMPDIR/cal_s35p/instrumentos/`: `i3.R` e `i4.R`, copias de los de s35o con la cabecera cambiada; `plantar_i4.R`, el de s35o, arma las copias de control)
- `i3.R <antes> <después>`: `parse(file =, keep.source = FALSE)` de los dos y `identical()` de las expresiones; código 0 si son idénticas.
- `i4.R <dir_base> <dir_actual>`: la vista con `identical()` de los bytes; el motor, con el JSON decodificado sin `meta$fecha_generacion` y el resto del HTML con el bloque base64 reemplazado por un marcador (A34-1); código 0 si las tres comparaciones dan TRUE.
esperado: `i3.R` da 0 con el mismo archivo y con un cambio solo de comentario, y 1 con un cambio de código, en los dos `.R` de P4; `i4.R` da 0 con la base contra sí misma, contra `40_salidas/` y contra una copia que solo cambia la fecha, y 1 con un dato del JSON, un byte fuera del bloque o un byte de la vista
obtenido: calibración en `$TMPDIR/cal_s35p/calibracion/`, sobre copias de partida de `b80a6d5` (`$TMPDIR/cal_s35p/antes/`: `10_utils.R` 9fbb2e64…, `30_construir_auxiliares.R` bb7a3982…, `README.md` 2da0d338…, `Renviron.example` cb80f9c0…, `publicacion_github_pages.md` c5d2cc7a…):
- `i3.R` sobre `10_utils.R`: contra sí mismo, «expresiones: 2 y 2; identical: TRUE», c=0; con L3 cambiada solo en el comentario, TRUE, c=0; con el literal de `stopifnot` de L46 cambiado (código), FALSE, **c=1**. Sobre `30_construir_auxiliares.R`: contra sí mismo, «64 y 64», TRUE, c=0; L9 cambiada en el comentario, TRUE, c=0; `ANIO_DATOS_VIGENTE <- 2024L` en L43 (código), FALSE, **c=1**.
- `i4.R` (copias de control con `plantar_i4.R`, plantar=0; fecha del JSON «2026-09-26»): base contra base, TRUE/TRUE/TRUE, c=0; contra `40_salidas/`, c=0; solo la fecha cambiada a 1999-01-01 (JSON recodificado), c=0; un campo `"control":1` en `meta`, «motor JSON sin fecha: FALSE», **c=1**; un espacio antes de `</title>`, «motor resto del HTML: FALSE», **c=1**; un byte agregado a la vista, «vista byte a byte: FALSE», **c=1** (22:36:33).
**Cumple:** los dos instrumentos distinguen lo que deben.

**Estado:** completa (22:34:11 a 22:36:33, el `date` impreso por el último comando de la calibración). **Commits:** `b80a6d5` (T0). **Cambios sustantivos:** ninguno en el producto ni en los textos de P1 a P5. **Alcance:** las dos rutas de T0 (commit); todo lo demás, en `$TMPDIR`. **Regresión:** el build de H5 es la base de I-4. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D0-a (riesgo bajo): la sección de D35-25 lleva, como las anteriores del archivo, un encabezado `## Decisiones del titular tras el encargo …` (el de s35o, que dejó las cinco dudas) y un título propio, «Últimos textos de documentación», que el encargo no fija; las cinco viñetas son las del Contexto, sin cambios.
- D0-b (riesgo bajo): I-3 e I-4 se miden con los instrumentos de s35o, copiados y recalibrados aquí; I-4 compara, además del JSON sin la fecha, el resto del HTML del motor (A34-1).

**Errores propios:** la cifra de líneas del README (327) se escribió en el log leyendo el `cat -n`, sin `wc -l`; el `wc -l` dio 328 y se corrigió enseguida, antes de H1. En un instrumento: un `Rscript -e` con `\\.` dentro de comillas simples de la shell falló por el escape («'\.' is an unrecognized escape», código 1) y se repitió con un script en archivo (`ext.R`); no midió nada antes de fallar. **Dudas:** ninguna en FASE 0.

### FASE P1: `.Renviron.example` sin la raíz de datos (Q-90)

Inicio: 22:36:46 (`date` del comando que cerró FASE 0). ALCANCE: `.Renviron.example`.

**Paso 1.** `git grep -n 'WORKSPACE_DATA_ROOT\|SLEP_SIMCE_ADECUADO_DATA_ROOT\|obtener_data_root_proyecto' -- ':!50_documentacion' ':!.Renviron.example'` (salida en `$TMPDIR/cal_s35p/p1/grep.txt`). Regla del encargo (§7 P1.1): si da 0, se editan las opciones A y B y su validación; si da algo, se registra y se congela P1. Aviso: en la lectura de los insumos (FASE 0) este `git grep` ya se había corrido sin exclusión de `.Renviron.example` y mostró dos líneas del validador; el esperado es el del encargo y no se ajusta.
esperado: 0 aciertos (código 1 de `git grep`)
obtenido: **2 aciertos** (gitgrep_codigo=0; 22:36:56), los dos en `10_utils/10_validar_portabilidad.R`:
```text
10_utils/10_validar_portabilidad.R:262:      for (fn in c("obtener_data_root_proyecto", "obtener_root_resguardo",
10_utils/10_validar_portabilidad.R:280:        "Data root no resuelto o inaccesible; declarar <PROYECTO>_DATA_ROOT o WORKSPACE_DATA_ROOT en ~/.Renviron")
```
**No cumple la condición para editar: P1 se congela** (§7 P1.1: «Si da algo, se registra y se congela P1»). `.Renviron.example` no se toca.

**Registro de los dos aciertos** (lectura, sin editar):
- L262 es el sondeo de accesores de `.vp_validar_entorno()`: prueba, en orden, `obtener_data_root_proyecto`, `obtener_root_resguardo` y `ruta_insumos`, y usa el primero que exista en `10_configuracion.R`. Aquí no existe ninguna función con ese nombre (`git grep -n 'obtener_data_root_proyecto *<-\|obtener_data_root_proyecto *='`, código 1, 0 aciertos) y el check resuelve por `ruta_insumos()` (build de H5: «Resuelto por ruta_insumos()»).
- L280 es el mensaje de falla de `data_root_resuelto`, que solo se imprime si la raíz no resuelve; en H5 el check está en OK.
- Ninguna de las dos lee una variable de entorno: `git grep -n 'Sys.getenv' -- '*.R'` solo halla `10_utils/10_locale.R` (`LC_ALL`, `LC_CTYPE`, `LANG`) y `renv/activate.R` (variables de `renv`), código 0.
- El validador es la plantilla de la cartera: su cabecera (L4-5) dice «Copiar idéntico a cada proyecto en 10_utils/; nunca editar por proyecto». Esas dos líneas no se pueden quitar desde este proyecto.

**Criterio (§7 P1.2):** no se mide, porque P1 queda congelada antes de editar: `.Renviron.example` sigue con las opciones A y B y su validación (el `git grep` de P1 sobre `.Renviron.example` da 5 líneas, las de s35o: L13, L15, L19, L21 y L25), `LANG=es_ES.UTF-8` sigue en L34, y el validador no cambia su resultado (el archivo no cambió). Sin commit.

**Estado:** **congelada** en el paso 1, sin cambios en el árbol (22:36:46 a 22:36:56 el `git grep`; el registro, después). **Alcance:** nada tocado. **Regresión:** no aplica. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:** ninguna. Se aplicó la regla literal del encargo, aunque los dos aciertos no leen las variables ni definen la función: decidir si cuentan es del titular (duda Q-95).

**Errores propios:** ninguno. **Dudas:** Q-95 (abajo, en el consolidado).

### FASE P2: el bloque de portabilidad del README deja de decir «generado» (Q-91)

Inicio: 22:37:15 (`date` del comando que cerró P1). ALCANCE: `README.md`, solo la marca de L277.

**Paso 1. Lectura.** `grep -n 'portabilidad-cross-os\|<!--\|-->' README.md`: una sola línea, L277 `<!-- portabilidad-cross-os: bloque generado, no editar a mano -->`; el bloque no tiene marca de cierre. En `herramientas_dev`, `git grep 'portabilidad-cross-os:'` da 0 aciertos (FASE 0): ninguna herramienta vigente busca la marca para regenerar el bloque.

**Paso 2. Edición.** L277 pasa a `<!-- portabilidad-cross-os: bloque que se mantiene a mano desde s35o (2026-09-26) -->` (primera opción de §7 P2.1: una marca que dice que el bloque se mantiene a mano desde s35o).

**Criterio** (§7 P2.2; salidas en `$TMPDIR/cal_s35p/p2/`)
esperado: `grep -c 'no editar a mano' README.md` → 0; `git diff` del README solo toca L277 (1 línea `-` y 1 `+`); 0 guiones largos en la línea `+`
obtenido: sed_codigo=0. `grep -c 'no editar a mano' README.md` → **0** (grep_codigo=1, A34-3; `p2/grep.txt`). `git diff -U0 README.md` (`p2/diff.txt`): un solo trozo, `@@ -277 +277 @@`, **1 línea `-` y 1 `+`** (`--numstat` 1 1), la marca vieja y la nueva; 0 guiones largos en la línea `+`. `README.md` sigue en 328 líneas (md5 9272c291cd5826beb66ae49e10f2ffcf). **Cumple.**

**Commit** `docs(readme): el bloque de portabilidad se mantiene a mano (Q-91)`: `9d8aa9e`, padre `b80a6d5`; `--numstat` `README.md` 1 1; `git status --porcelain` = solo este log (22:37:35).

**Estado:** completa, en el primer intento (22:37:15 a 22:37:35). **Alcance:** `README.md`, L277. **Regresión:** no aplica (un comentario HTML del README; la regresión completa va en FASE R). **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D2-a (riesgo bajo): de las dos opciones de §7 P2.1 se toma la primera (la marca cambia de texto y no se quita) y se conserva el prefijo `portabilidad-cross-os:`, para que quien busque la marca de la cartera halle el bloque y lea que ya no se regenera. «s35o» va con su fecha porque el lector del README no conoce los códigos de sesión.

**Errores propios:** ninguno. **Dudas:** ninguna.

### FASE P3: la guía de publicación al día (Q-92)

Inicio: 22:37:41 (`date` del comando que cerró P2). ALCANCE: `50_documentacion/activa/publicacion_github_pages.md`.

**Paso 1. Inventario** (antes de editar; líneas de `b80a6d5`, 98 líneas; se coteja contra `CLAUDE.md`, el README y el código). Estado: **vigente** (cierto hoy), **desactualizada** (incompleta o atada a un estado anterior, sin ser contraria al código) o **falsa** (contraria al código o a lo publicado). Verificado con `grep`, `git ls-files`, `wc -c`, `gh api repos/tomgc/slep_simce_adecuado/pages` (GET: `source` `main` `/docs`, `build_type` legacy, `status` built), `gh repo view` (PUBLIC) y lecturas del código.

| id | líneas | afirmación (resumen) | estado | respaldo | acción |
|---|---|---|---|---|---|
| G-01 | L1-4 | documento activo; cómo se publican y actualizan el motor y la vista | vigente | `git ls-files docs` (2) | no |
| G-02 | L8-9 | dos archivos autocontenidos, copiados íntegros a `docs/`; Pages sirve `main`, carpeta `/docs` | vigente | `gh api …/pages`: `main`, `/docs` | no |
| G-03 | L11-14 | tabla salida, archivo publicado y paso que la genera | vigente | `00_build.R` L11-13; build de H5 (pasos 33 y 36 escriben las dos salidas) | no |
| G-04 | L16-19 | menú compartido: el motor enlaza a `trayectorias.html`; la vista vuelve a `index.html` o `index.html#panorama`; la vista no se incrusta; nada por red | vigente | `33_fragmento_sitio.html` L92-94; en lo publicado, `href="trayectorias.html"` en el motor y `href="index.html"` y `href="index.html#panorama"` en la vista (1 y 1); red: criterio de P3 | no |
| G-05 | L21-23 | URL pública, repositorio público con su decisión, URL de la vista | vigente | `gh api`: `html_url`; `gh repo view`: PUBLIC; `decisiones/20260611_decision_repo_publico.md` existe | no |
| G-06 | L24-26 | solo se exponen los dos archivos; el resto del repositorio es público; lo no versionado lo excluye `.gitignore` | vigente | `git ls-files docs` (2); `.gitignore` L44 | no |
| G-07 | L30-31 | datos agregados públicos «(SIMCE a nivel RBD, ponderado por GSE)» | falsa | la ponderación es por número de evaluados, no por GSE (`10_utils.R` L29-30 y L73-85, con `pct_adecuado` en L76-77; README «Fórmula de agregación») | cambia |
| G-08 | L32 | sin resultados individuales ni datos personales de menores | vigente | el pipeline no usa MRUN (s35o, A-22) | no |
| G-09 | L33 | «La segmentación por GSE es inviolable y se mantiene en el output publicado.» | falsa | el panorama del motor combina los cinco GSE (`33_motor_template.html` L1614, L3599, L3872 «GSE combinado») y la vista ofrece «Todos los grupos» (s35o, A-32 y D1-a) | cambia, con la redacción del README |
| G-10 | L34-35 | verificar que «el JSON embebido» sigue siendo solo agregado | desactualizada | hay dos JSON embebidos: motor (`33_generar_html.R` L372 y L496, `__JSON_DATA__`) y vista (`36_funciones_trayectorias.R` L611, `__DATA_TRAYECTORIAS__`) | cambia |
| G-11 | L36-38 | antes de republicar la vista, pasa la batería del paso 36 | desactualizada | D35-21 (Q-82) y D35-25 (Q-92): las dos baterías antes de cada copia a `docs/`; `CLAUDE.md` «Convenciones» | cambia |
| G-12 | L40-44 | configuración inicial ya hecha: «Deploy from a branch», `main`, `/docs` | vigente | `gh api …/pages`: `build_type` legacy (desde una rama), `main`, `/docs` | no |
| G-13 | L48 | el procedimiento se repite con cada build nuevo | vigente | no aplica | no |
| G-14 | L51 | `cd ~/Projects/slep_simce_adecuado` | vigente | la carpeta existe en la estación (criterio) | no |
| G-15 | L53-54 | regenerar los dos HTML con `Rscript 00_build.R` (el pipeline completo; los HTML salen de los pasos 33 y 36) | vigente | `00_build.R` L38-46; H5 | no |
| G-16 | L56-57 | paso 2: solo la batería de la vista | desactualizada | como G-11 | cambia |
| G-17 | L59-61 | `cp` de cada salida a `docs/` | vigente | las cuatro rutas existen; `40_salidas/` = `docs/` hoy (H5) | no |
| G-18 | L63-65 | dos `grep` de red, los dos en 0 | vigente | se corren en el criterio | no |
| G-19 | L67-73 | `git add`, `git status`, `git commit`, `git push` | vigente | comandos de git; `docs/` versionado | no |
| G-20 | L76 | Pages reconstruye en 1 a 2 minutos | vigente | no se mide aquí (no se publica `docs/`); L90 dice lo mismo | no |
| G-21 | L82 | validación 1: el motor carga completo | vigente | validación manual | no |
| G-22 | L83 | validación 2: «valparaiso» devuelve VALPARAÍSO primero | vigente | normalización NFD del buscador (`33_motor_template.html` L4368, L4877 y L4908); el orden no se mide aquí | no |
| G-23 | L84 | validación 3: el tooltip se voltea hacia adentro | vigente | `33_motor_template.html` L2112 | no |
| G-24 | L85 | validación 4: «Datos segmentados por GSE.» | falsa | como G-09: el panorama y la vista también muestran los grupos combinados | cambia |
| G-25 | L86-88 | validación 5: los rótulos del menú y adónde llevan | vigente | `33_fragmento_sitio.html` L92-94; enlaces de G-04 | no |
| G-26 | L89-90 | validación 6: `curl … \| md5` igual a `md5 -q docs/…` | vigente | se corre en el criterio | no |
| G-27 | L94 | el motor pesa 2.921.439 B y la vista 2.206.558 B (sesión 35) | desactualizada | `wc -c` hoy: `docs/index.html` 2934457 y `docs/trayectorias.html` 2212989 | cambia |
| G-28 | L94-98 | optimización pendiente: separar el JSON; tocaría `33_generar_html.R`; no abordada | vigente | propuesta; el ~200 KB no se mide | no |

Además, cotejado contra `CLAUDE.md`: «`docs/` solo cambia por copia íntegra de `40_salidas/`» coincide con G-02 y G-17; «Antes de cada copia a `docs/`, las dos baterías en PASA» es lo que falta en G-11 y G-16. Fuera del ALCANCE, nada nuevo: el README ya dice lo mismo que G-09 corregida (s35o).

**Paso 2. Diseño de la edición** (texto nuevo sin guiones largos):
- G-07: «(resultados SIMCE por RBD y sus agregados, ponderados por número de evaluados)».
- G-09: la viñeta «Segmentación por GSE» del README, copiada tal cual (D1-a de s35o).
- G-10: «el JSON embebido en cada página».
- G-11: las dos baterías, con sus comandos y el código 0, antes de cada copia a `docs/` (D35-21 y D35-25); leen `40_salidas/` y necesitan Google Chrome (cabeceras de las dos baterías: `33_verificar_motor.R` L36, L41 y L57; `36_verificar_trayectorias.R` L46, L48 y L68).
- G-16: el paso 2 del procedimiento corre las dos baterías.
- G-24: «La comparación entre territorios muestra los datos por GSE.»
- G-27: los pesos de hoy.

**Criterio pre-registrado** (§7 P3.2; salidas en `$TMPDIR/cal_s35p/p3/`)
esperado: `grep -n 'inviolable'` → 0 aciertos; `grep -n '33_verificar_motor.R'` → al menos 1; la viñeta «Segmentación por GSE» igual a la del README (texto normalizado en espacios); el `git diff -U0` solo toca las filas marcadas «cambia» (G-07, G-09, G-10, G-11, G-16, G-24 y G-27) y sus líneas `+` no traen guiones largos; cada comando del documento corre o existe (cotejo: la carpeta de `cd`; `Rscript 00_build.R`, en H5; las dos baterías, con código 0; los dos `cp`, hacia una copia en `$TMPDIR`, con `cmp` contra `docs/`; los dos `grep` de red, en 0; `git status`; `git add`, `git commit` y `git push`, que no se corren aquí para no tocar `docs/` ni el remoto; los dos `curl … | md5`, iguales a `md5 -q`)
obtenido (22:38:53 a 22:41:21, el `date` que cerró el inventario y el del último comando del cotejo):
- `grep -n 'inviolable'` → **0 aciertos** (código 1, A34-3; `p3/inviolable.txt`).
- `grep -n '33_verificar_motor.R'` → **2 aciertos** (código 0): L44, en «Gobernanza», y L65, en el paso 2 del procedimiento.
- Viñeta del GSE (`p3/gse.py`, Python, espacios normalizados): «iguales: True» con la del README (gse_codigo=0).
- `git diff -U0` (`p3/diff.txt`; `--numstat` 19 10): 5 trozos, en L31 (G-07), L33-38 (G-09, G-10 y G-11), L56 (G-16), L85 (G-24) y L94 (G-27), solo filas marcadas «cambia»; 19 líneas `+`, 0 guiones largos y 0 semirrayas. El documento pasa de 98 a 107 líneas (md5 510544bd7578edf1ea5dbdec946fd35f).
- Cotejo de comandos (salidas en `p3/`): `cd ~/Projects/slep_simce_adecuado`, la carpeta existe (`test -d`, código 0); `Rscript 00_build.R`, código 0 en H5; **`Rscript 30_procesamiento/33_verificar_motor.R`, motor_codigo=0**, «8 pruebas, 8 pasan, 0 fallan (en 70 segundos)» (22:39:45 a 22:40:55); **`Rscript 30_procesamiento/36_verificar_trayectorias.R`, vista_codigo=0**, «35 pruebas, 35 pasan, 0 fallan» (22:40:55 a 22:41:13); los dos `cp`, hacia `p3/docs_simulado/` (cp1=0, cp2=0), y `cmp` contra `docs/` sin diferencias (cmp1=0, cmp2=0); `grep -cE "src=[\"']?(https?:)?//" …` → 0 y 0, y `grep -c 'url(http' …` → 0 y 0 (código 1 los dos, A34-3); `git add` de las dos rutas no se corre (no hay cambio en `docs/` que agregar): `git ls-files --error-unmatch` las encuentra, código 0; `git status`, código 0; `git commit` y `git push` no se corren aquí (el push de `main` va en FASE L); `curl -s https://tomgc.github.io/slep_simce_adecuado/ | md5` = **42ab93003e722f9bb6c725fec2d348bd** = `md5 -q docs/index.html`, y la vista, por `curl` a archivo, **883f76bcefc89d93f2d1e753fc4d75c3** = `md5 -q docs/trayectorias.html` (curl1=0, curl2=0). La configuración de «Configuración inicial» coincide con `gh api …/pages` (FASE 0).
**Cumple.**

**Commit** `docs(publicacion): regla del GSE acotada y las dos baterias antes de publicar (Q-92)`: `8dc85dc`, padre `9d8aa9e`; `--numstat` 19 10; `git status --porcelain` = solo este log (22:41:36).

**Estado:** completa, en el primer intento (22:37:41 a 22:41:36). **Alcance:** `publicacion_github_pages.md`. **Regresión:** las dos baterías del cotejo, en código 0; la completa va en FASE R. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D3-a (riesgo bajo): «deben pasar completas, con código 0» se respalda en D35-25 (Q-92: «exige las dos baterías antes de publicar»), además de D35-21 y `CLAUDE.md`; por eso la viñeta cita las dos decisiones y el archivo donde están.
- D3-b (riesgo bajo): G-07 cambia «ponderado por GSE» por «ponderados por número de evaluados» y nombra los resultados por RBD, que el motor publica (pestaña Establecimiento); la viñeta no dice que todo vaya por GSE, porque la del GSE ya dice dónde vale.
- D3-c (riesgo bajo): las líneas vigentes no se tocan aunque traigan guiones largos o semirrayas (el título, L40 «(ya realizada — referencia)» y L76 «1–2 minutos»), ni la concordancia de L32 («No contiene», con sujeto plural); no son afirmaciones que el código contradiga.
- D3-d (riesgo bajo): el `cp` y el `git add` del procedimiento se cotejan sin tocar `docs/` (copia a `$TMPDIR` con `cmp`, y `git ls-files`), porque I-2 no admite cambios en `docs/`.

**Errores propios:** al escribir el inventario, el respaldo de G-07 citaba `10_utils.R` «L74-81», sin medir; `grep -n` dio `summarise` en L73-85 y `pct_adecuado` en L76-77, y se corrigió antes de editar la guía. En la misma revisión se halló en H5 (FASE 0) «las mismas clases y archivos de s35o»: el log de s35o no lista los archivos; se cambió por la lista medida en H5 y se declaró allí. Es el patrón de siempre: una cifra o una referencia escrita antes de medirla. **Dudas:** ninguna.

### FASE P4: comentarios de `10_utils.R` y del paso 30 (Q-93)

Inicio: 22:41:50 (`date` del comando que cerró P3). ALCANCE: `10_utils/10_utils.R` y `30_procesamiento/30_construir_auxiliares.R`, solo comentarios.

**Paso 1. Inventario de los comentarios** (antes de editar; líneas de `b80a6d5`; «U» es `10_utils.R` y «C», el paso 30). Estados como en P3. Verificado con `grep -n`, `git grep`, `arrow` (esquema de `sleps_chile.parquet`), `head -1` del directorio oficial (solo los nombres de columna, con un conteo de bytes no ASCII; ninguna fila de datos) y la salida del build de H5. D35-25 (Q-93) pide poner al día los comentarios de los dos archivos: además de lo que nombra §7 P4.1, se corrigen los comentarios falsos o desactualizados que halle el inventario, siempre solo comentarios (I-3).

| id | líneas | afirmación (resumen) | estado | respaldo | acción |
|---|---|---|---|---|---|
| U-01 | L1-3 | funciones utilitarias del proyecto | vigente | no aplica | no |
| U-02 | L6-8 | `agregar_ponderado()`: filtros y ponderación; «Devuelve tibble con n_estab, n_evaluados, pct_adecuado» | desactualizada | también devuelve `pct_elemental` y `pct_insuficiente` si `df` trae `palu_eda_ele` y `palu_eda_ins` (L60-61, L78-83 y L87-90) | cambia |
| U-03 | L9-10 | `json_motor(df, ...)`, «(pendiente)» | falsa | no existe: `grep -n '<- function'` da `agregar_ponderado` (L41) y `.tests_agregar_ponderado` (L102); el JSON del motor lo arma `33_generar_html.R` (L372) | se quita |
| U-04 | L5-10 (omisión) | la lista no trae `.tests_agregar_ponderado()`, que el archivo define | desactualizada | L102 | agrega |
| U-05 | L12 | paquetes prefijados (`dplyr::`, `tibble::`); sin `library()` | vigente | `dplyr::` 7 y `tibble::` 8 veces; 0 `library(` | no |
| U-06 | L16-30 | descripción, filtros en orden y fórmula | vigente | L63-70 y L76-77 | no |
| U-07 | L32-36 | `@param df` y `@param group_vars` | vigente | L43-53 | no |
| U-08 | L38-40 | `@return`: `n_estab`, `n_evaluados`, `pct_adecuado` | desactualizada | como U-02 | cambia |
| U-09 | L42, L55-59, L87-88 | comentarios internos de `agregar_ponderado()` | vigente | L60-90 | no |
| U-10 | L95-100 | cómo correr las pruebas; TRUE invisible si pasan los 7 casos | vigente | L222-223; se corren en el criterio | no |
| U-11 | L104-204 | comentarios de los casos 1 a 7 | vigente | se corren en el criterio | no |
| U-12 | L227-232 | bloque «json_motor(): pendiente» y su `TODO` | falsa | como U-03; son solo comentarios (el archivo termina en L232) | se quita |
| C-01 | L1-7 | licencia | vigente | `LICENSE` | no |
| C-02 | L9-10 | construye los parquet desde `20_insumos/auxiliares/`; salidas en `40_salidas/intermedios/` | vigente | L52-54, L79-80, L146-152, L253-261; L124, L218, L389, L431 | no |
| C-03 | L12-14 | 1: `slep_cc_establecimientos.parquet`, desde la caracterización y el anexo | vigente | L52-57, L79-126 | no |
| C-04 | L16-18 | 2: `comunas_chile.parquet`, del directorio, operativos con matrícula | vigente | L204 y L220 | no |
| C-05 | L20-21 | 3: `sleps_chile.parquet`, del listado SLEP y el directorio | vigente | L253-261, L322-356 y L391 | no |
| C-06 | L9-21 (omisión) | enumera tres parquet | desactualizada | el archivo escribe cuatro (`write_parquet` en L126, L220, L391 y L433; build de H5: cuatro filas en «=== Resumen ===»); falta `establecimientos_chile.parquet` | agrega |
| C-07 | L23-24 | uso con `source()` | vigente | `00_build.R` L38 | no |
| C-08 | L26-27 | prefijos `readxl::`, `readr::`, `dplyr::`, `arrow::`; solo `library(here)` | desactualizada | usa también `fs::` (L396); `library(here)` en L30, el único | cambia (agrega `fs::`) |
| C-09 | L36-42 | `ANIO_DATOS_VIGENTE`: último año Simce; las dos ramas; «se marcan en el motor» | vigente | build de H5: último año 2025; `slepEsProspectivo()` en `33_motor_template.html` L1767-1769 | no |
| C-10 | L47 y L59 | bloque 0: los 5 RBD esperados | vigente | L61-64 (`setequal`) | no |
| C-11 | L83-86 | columna con ñ; validación por posición | vigente | L87-104 (la posición 4 no se valida) | no |
| C-12 | L100, L106, L122 | renombre, coerciones, escritura | vigente | L101-126 | no |
| C-13 | L145 | separador `;`, decimal `,`, UTF-8 y BOM | vigente | L146-152; el CSV empieza con `ef bb bf` | no |
| C-14 | L154-155 | los nombres del CSV son ASCII puros | vigente | 58 nombres, 0 bytes no ASCII después del BOM | no |
| C-15 | L157 | validación de columnas requeridas aguas abajo | vigente | describe L158-168; que la lista no traiga `COD_DEPE`, que usa el bloque 4 (L329-330), es del código y no se toca (FASE R) | no |
| C-16 | L183 | tabla de nombres de región | vigente | L184-201 | no |
| C-17 | L231-234 | fuente del bloque 4 | vigente | L253-261 | no |
| C-18 | L236 | «Esquema del parquet resultante (8 columnas)» | falsa | el `select` de L351-355 deja 7 y el parquet tiene 7 (`arrow`: `cod_slep`, `nombre_slep`, `anio_traspaso`, `cod_com_rbd`, `nom_com_rbd`, `rbd`, `nom_rbd`); L244 ya dice 7 | cambia a 7 |
| C-19 | L237-244 | columnas y tipos del bloque 4 | vigente | L273-278 y L332-355 | no |
| C-20 | L246 | «Solo RBDs con COD_DEPE == 6 en directorio 2025.» | falsa | la rama prospectiva agrega los municipales, `COD_DEPE` 1 y 2 (L328-331; 4.2 b, L298-304) | cambia |
| C-21 | L246-248 | los mismos establecimientos «existian con COD_DEPE == 1 antes del traspaso» | no se mide | dato histórico que el código no guarda; 4.2 a (L295) dice «1/2» | no (FASE R) |
| C-22 | L252-397 | comentarios de 4.1 a 4.3 | vigente | L253-397 | no |
| C-23 | L403-406 | bloque 5: catálogo; fuente; todos los operativos con matrícula, de cualquier dependencia | vigente | L418-427 | no |
| C-24 | L406-407 | «Se usa en el popup "ver establecimientos" del motor» | desactualizada | lo usan también la vista (`36_funciones_trayectorias.R` L213) y su batería | cambia |
| C-25 | L409-414 | esquema de 5 columnas | vigente | L420-426 | no |
| C-26 | L444 | resumen final | vigente | L446-454 | no |

**Paso 2. Diseño de la edición** (solo comentarios; texto nuevo sin guiones largos; se respeta el estilo de cada bloque: el bloque 4 va sin tildes):
- U-02, U-03, U-04: la lista pasa a dos entradas, `agregar_ponderado()` con sus columnas opcionales y `.tests_agregar_ponderado()`; sale `json_motor()`.
- U-08: `@return` nombra las dos columnas opcionales.
- U-12: se quitan L225-232 (dos líneas en blanco, el bloque y su `TODO`); el archivo termina en la `}` de L224.
- C-06: entrada 4, `establecimientos_chile.parquet`.
- C-08: `fs::` en la lista de prefijos.
- C-18: «(7 columnas)».
- C-20: la primera oración nombra también los municipales de las comunas con traspaso prospectivo; el resto del párrafo no cambia.
- C-24: el bloque 5 nombra también la vista de trayectorias (paso 36).

**Criterio pre-registrado** (§7 P4.2; salidas en `$TMPDIR/cal_s35p/p4/`)
esperado: I-3 (`i3.R` contra `$TMPDIR/cal_s35p/antes/`) con código 0 en los dos archivos, y cada línea `-`/`+` de su `git diff -U0` es comentario o línea en blanco; `git grep -n 'json_motor' -- ':!50_documentacion'` → 0 aciertos (así lo fija el encargo; aviso: la lectura de FASE 0 ya había mostrado `extraer_json_motor` en `33_verificar_motor.R`, fuera del ALCANCE, y el esperado no se ajusta); parquet del encabezado del paso 30 = `write_parquet` del archivo; 0 guiones largos en las líneas `+`; además, `.tests_agregar_ponderado()` da «OK: 7/7» (respalda U-10 y U-11)
obtenido (22:43:29 a 22:44:36, el `date` que cerró el inventario y el del último comando del criterio):
- I-3 (`i3.R`): `10_utils.R` «expresiones: 2 y 2; identical: TRUE» (i3_utils=0) y `30_construir_auxiliares.R` «64 y 64; identical: TRUE» (i3_30=0). El `git diff -U0` de los dos (`p4/diff.txt`; `--numstat` 6 12 y 12 6) tiene 36 líneas `-`/`+`, **0 que no sean comentario o línea en blanco**; 0 guiones largos en las líneas `+`; ancho de las 18 líneas `+`: 78, 79, 78, 52, 68, 59, 37, 73, 47, 1, 79, 46, 74, 75, 74, 48, 78 y 37 (los archivos ya tenían líneas de 81 y 96).
- `git grep -n 'json_motor' -- ':!50_documentacion'` → **2 aciertos, no 0** (gitgrep_codigo=0; `p4/json_motor.txt`): `30_procesamiento/33_verificar_motor.R:269:extraer_json_motor <- function(texto) {` y `…:281:meta_motor <- intentar(extraer_json_motor(html)$meta)`. Son código de la batería del motor (una función propia, `extraer_json_motor()`, que decodifica el JSON del motor), fuera del ALCANCE, y no nombran la función pendiente de `10_utils.R`. En `10_utils.R` quedan 0. Como palabra completa (`git grep -nw`), 0 aciertos (código 1). **Esta parte del criterio no se cumple tal como está escrita**; no se ajusta ni se repara (tocaría código fuera del ALCANCE): se registra como duda (Q-96) y sigue.
- Parquet: el encabezado del paso 30 enumera **4** (`grep -cE '^#   [0-9]+\. [a-z_]+\.parquet$'` sobre L9-30) y el archivo tiene **4** `arrow::write_parquet(`. Iguales.
- `.tests_agregar_ponderado()`: «OK: 7/7 casos de .tests_agregar_ponderado() pasaron.» (tests_codigo=0).
**Cumple en tres de sus cuatro partes; la del `grep` de `json_motor` da 2 por un identificador de otro archivo (Q-96).**

**Commit** `docs(codigo): comentarios de 10_utils.R y del paso 30 al dia (Q-93)`: `00a1b4b`, padre `8dc85dc`; `--numstat` `10_utils.R` 6 12 y `30_construir_auxiliares.R` 12 6; md5 d695731d690b2959460fd0b3c71c97e1 y 28eac6ca6f0472e3427737a37d84a98c; `git status --porcelain` = solo este log (22:44:59).

**Estado:** completa, en el primer intento, con una parte del criterio sin cumplir por causa ajena al ALCANCE (`json_motor` en `33_verificar_motor.R`, Q-96) (22:41:50 a 22:44:59). **Alcance:** los dos `.R`, solo comentarios (I-3). **Regresión:** las pruebas inline de `agregar_ponderado()`; la completa va en FASE R. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D4-a (riesgo bajo): además de lo que nombra §7 P4.1 (la lista de funciones, el bloque de `json_motor()` y el encabezado del paso 30), se corrigen otros cinco comentarios que el inventario halló falsos o desactualizados en los mismos dos archivos (U-08, C-08, C-18, C-20 y C-24), porque D35-25 (Q-93) pide poner al día «los comentarios» de los dos archivos y la meta es que ningún texto afirme algo que el código contradiga. Todos son solo comentarios (I-3 TRUE).
- D4-b (riesgo bajo): en C-20 se cambia solo la primera oración; la segunda («existian con COD_DEPE == 1 antes del traspaso», C-21) no se toca, porque es un dato histórico que el código no guarda y no se puede medir aquí, aunque 4.2 a diga «1/2» (FASE R).
- D4-c (riesgo bajo): `.tests_agregar_ponderado()` entra en la lista de «Funciones expuestas» porque §7 P4.1 pide que la lista refleje las que el archivo define; la entrada dice que son pruebas que se corren a mano.

**Errores propios:** en el inventario, el respaldo de C-15 decía «L158-167»; la lectura de las líneas dio `stopifnot` hasta L168, y se corrigió antes de editar. **Dudas:** Q-96 (el criterio de `json_motor`).

### FASE P5: documentos de junio a `_archivo/` (Q-94)

Inicio: 22:45:09 (`date` del comando que cerró P4). ALCANCE: `50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.md`, `50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.html`, `50_documentacion/activa/arquitectura_slep_simce_adecuado.html` y `_archivo/20260926/50_documentacion/activa/` (ignorada).

**Paso 1. md5 de los tres antes de moverlos** (`md5 -q`, `$TMPDIR/cal_s35p/p5/md5_antes.txt`) y citas vigentes (§7 P5.2): `git grep -n` de los dos nombres base fuera de `50_documentacion/andamios/` (logs), `50_documentacion/traspasos/`, `50_documentacion/activa/encargos/` y `50_documentacion/estructura/` (salida en `p5/citas.txt`). Aviso: la lectura de FASE 0 ya había corrido este `git grep` y mostró citas en `README.md`; el esperado es la premisa del encargo (§2 Q-94) y no se ajusta.
esperado: tres md5 anotados; citas solo entre los tres documentos (premisa de §2: «Fuera de logs, traspasos, encargos e instantáneas de estructura, solo se citan entre sí»)
obtenido: md5_codigo=0; `documentacion_proyecto_slep_simce_adecuado.md` **89a17069fc5c089ec58cb1f9464d3cf4**, `documentacion_proyecto_slep_simce_adecuado.html` **de025e48e3b33c7225360cbe0328fc3c** y `arquitectura_slep_simce_adecuado.html` **ea91c9141cda19ba795ba0a3ef143ffe**. Citas (citas_codigo=0; 22:45:22): 15 líneas en 6 archivos. De ellas, 8 son de la suite (`documentar.R` 5, `arquitectura_general…_standalone.html` 2 y `documentacion_general…_standalone.html` 1) y nombran los archivos `*_standalone.html` de la propia suite, no los de junio (el patrón es subcadena de esos nombres; `grep -c '_standalone'` = 8); 4 son de los dos `documentacion_proyecto…` (.md y .html, 2 y 2), que citan `arquitectura_slep_simce_adecuado.html` y se mueven con él; y **3 son de `README.md`**, L246, L249 y L252 (la sección «Documentación» enlaza los tres documentos por su ruta en `activa/`). **La premisa de §2 no se cumple:** el README los cita. Los documentos ignorados por git que el proyecto tiene por vigentes (`CLAUDE.md`, `POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`) no los citan (`grep`, código 1, en FASE 0).

**Qué se hace con la cita del README** (§7 P5.2: «si no está en el ALCANCE, se registra»): el README está en el ALCANCE solo por P2 y solo en L277 («Nada más del README cambia», §7 P2.1); no está en el ALCANCE de P5. La cita se registra y no se edita: tras el movimiento, las tres entradas de L246-256 del README apuntan a archivos que ya no están en el repositorio (en GitHub, enlaces rotos). Pasa a FASE R y a la duda Q-97. El movimiento sigue, porque §7 P5.2 prevé este caso y no lo trata como condición de detención.

**Paso 2. Movimiento** (autorización 2): `mkdir -p _archivo/20260926/50_documentacion/activa/`, `mv` de los tres y `git rm --cached` de sus tres rutas (el `mv` las saca del árbol, pero no del índice)
esperado: `git status --porcelain` muestra las tres rutas como borradas (` D` tras el `mv`, `D ` tras `git rm --cached`); los tres existen en `_archivo/20260926/50_documentacion/activa/` con los md5 del paso 1; `git check-ignore` atribuye la carpeta nueva a `.gitignore:31`
obtenido: `mkdir` y `mv`, mv_codigo=0; tras el `mv`, `git status --porcelain` muestra las tres rutas como ` D` (`p5/status_tras_mv.txt`); `git rm --cached -q`, rm_codigo=0, y las tres pasan a `D ` (`p5/status_tras_rm.txt`), más el log. En `_archivo/20260926/50_documentacion/activa/`, los tres con **los mismos md5** del paso 1 (`diff md5_antes.txt md5_despues.txt`, código 0; tamaños 20425, 18485 y 10002 B, fechas de junio conservadas); `git check-ignore -v` → `.gitignore:31:_archivo/` (ci=0). **Cumple.**

**Commit** `docs(activa): retira la documentacion de junio que reemplaza la suite (Q-94)`: `0836a50`, padre `00a1b4b`; `git show --name-status` = `D` en las tres rutas; «3 files changed, 1093 deletions(-)» (22:46:17).

**Criterio** (§7 P5.3; salidas en `$TMPDIR/cal_s35p/p5/`)
esperado: `git ls-files` no lista las tres rutas; los tres existen en `_archivo/20260926/50_documentacion/activa/` con los md5 del paso 1; `git status --porcelain` tras el commit no los muestra (solo el log)
obtenido: `git ls-files` de las tres rutas → **0 líneas** (ls_codigo=0); `git ls-files | grep -c` de los tres nombres en todo el índice → 0 (los `*_standalone.html` de la suite no coinciden con el patrón anclado); los md5 de `_archivo/` contra `md5_antes.txt`, `diff` con código 0 (md5_iguales=0); `git status --porcelain` = solo `?? …/20260926_documentacion_s35p_log.md` (status_codigo=0). `50_documentacion/activa/` queda con 17 entradas (22:46:24). **Cumple.**

**Estado:** completa, en el primer intento (22:45:09 a 22:46:24), con la cita del README registrada y sin editar (§7 P5.2; Q-97). **Alcance:** las tres rutas de Q-94 (borradas del índice) y `_archivo/20260926/50_documentacion/activa/` (ignorada, fuera de git). **Regresión:** no tocó código ni salidas; la completa va en FASE R. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D5-a (riesgo medio, reversible con `git revert 0836a50` o copiando desde `_archivo/`): el movimiento se hace aunque el README los enlaza, porque §7 P5.2 prevé el caso («si no está en el ALCANCE, se registra») y no lo trata como detención. La alternativa descartada, congelar P5 hasta que el README se pueda editar, contradecía la instrucción de §7 P5.2. Efecto: si se publica, las tres entradas de «Documentación» del README quedan con enlaces rotos en GitHub hasta que un encargo las ponga al día (Q-97).

**Errores propios:** ninguno. **Dudas:** Q-97 (el README enlaza los tres documentos archivados).

### FASE R: auditoría y reparación

Inicio: 22:46:33 (`date` del comando que cerró P5).

**R.1 Inventario de afirmaciones auditables** (armado desde las secciones anteriores de este log, antes de auditar; cada una se re-deriva en R.2 con un comando distinto del que la produjo; scripts y salidas en `$TMPDIR/cal_s35p/fase_r/`)

| id | afirmación (fase) |
|---|---|
| R-01 | H1: el árbol con el encargo sin versionar más el log (FASE 0) |
| R-02 | H2: stash 0; un solo worktree (FASE 0) |
| R-03 | H3: `HEAD` y `origin/main` en f8cadb2; instantáneas de I-1 e I-5 (lock e6323bf2…, settings d0bcb98d…) (FASE 0) |
| R-04 | H4: md5 del encargo bd84f0fc…; `docs/` 42ab9300… y 883f76bc…; T0 = b80a6d5, padre f8cadb2, dos rutas (M y A), 364 inserciones; la sección D35-25 trae las cinco viñetas del Contexto tal cual (FASE 0) |
| R-05 | H5: build con código 0, 0 fallas críticas y 7 advertencias; cuatro parquet en el paso 30 (73, 345, 2337 y 10945 filas); la base tiene los md5 de `docs/`; el validador ve `.Renviron.example` solo por el check `renviron_example` (OK) y su escaneo no lo cubre (FASE 0) |
| R-06 | Calibración de `i3.R` e `i4.R` (FASE 0) |
| R-07 | P1: el `git grep` da 2 aciertos, L262 y L280 de `10_validar_portabilidad.R`; ningún código lee las dos variables; `obtener_data_root_proyecto` no está definida; el validador es plantilla de la cartera; P1 congelada y `.Renviron.example` sin cambio (5 líneas del patrón; `LANG` en L34) (P1) |
| R-08 | P2: L277 cambiada; `no editar a mano` 0; diff 1 y 1, solo L277; commit 9d8aa9e, padre b80a6d5 (P2) |
| R-09 | P3: inventario de 28 filas (3 falsas, 4 desactualizadas, 21 vigentes) y sus respaldos; `inviolable` 0; `33_verificar_motor.R` 2; viñeta del GSE igual a la del README; 5 trozos, solo filas «cambia»; pesos 2934457 y 2212989 B; cotejo de comandos (carpeta, baterías 8/8 y 35/35, `cmp`, `grep` de red 0/0, `curl` = `docs/`); commit 8dc85dc, padre 9d8aa9e, 19/10 (P3) |
| R-10 | P4: inventario de 38 filas y sus respaldos (U-03 y U-12: `json_motor()` no existe; U-02 y U-08: columnas opcionales; C-06: cuatro `write_parquet`; C-18: 7 columnas; C-20: rama prospectiva; C-24: la vista lee `establecimientos_chile`); I-3 TRUE; 36 líneas, todas comentario; `json_motor` 2 aciertos (`extraer_json_motor`) y 0 como palabra; parquet 4 = 4; pruebas 7/7; commit 00a1b4b, padre 8dc85dc, 6/12 y 12/6 (P4) |
| R-11 | P5: md5 de los tres; citas: 15 líneas en 6 archivos, 3 del README (L246, L249, L252), 8 de la suite con nombres `_standalone`, 4 entre los de junio; movimiento con los mismos md5; `_archivo/` ignorada por `.gitignore:31`; commit 0836a50, padre 00a1b4b, tres `D`, 1093 borrados; `ls-files` 0; `status` solo el log (P5) |
| R-12 a R-16 | I-1 a I-5 (§4) |
| R-17 | Alcance global: `git diff --name-only b80a6d5..HEAD` dentro de la unión de los ALCANCE más el log; `git status` |
| R-18 | Identidad de lo publicado (`git hash-object` sobre `docs/` y `40_salidas/`) y ausencia de red en lo publicado (`grep -c 'http'`, revisado a mano) |

**R.2 Re-derivación independiente** (sin subagentes; el orquestador, con otros comandos; scripts y salidas en `$TMPDIR/cal_s35p/fase_r/`: `rd_git.txt`, `rd_r.R` con `rd_r.txt`, `rd_py.py` con `rd_py.txt` y `rd_py_v2.txt`, `rd_shell.txt`, `rd_tokens.R`, `rd_urls.py` con `rd_urls.txt` y `rd_fetch.txt`)
esperado: cada afirmación del inventario se confirma o se refuta con un instrumento distinto del original
obtenido: **18 de 18 confirmadas** (R-12 a R-16 en R.3 y R-17 en R.4), 0 refutadas:
- R-01 (`rd_git.txt`): `git diff-tree --name-status -r b80a6d5` = M del archivo de decisiones y A del encargo; el encargo no existía en f8cadb2 (`cat-file -e`, código 128); el log no está en ningún commit (`git log --all`, 0).
- R-02: `git rev-parse -q --verify refs/stash`, código 1; `.git/worktrees` no existe (código 1).
- R-03: `git cat-file -p b80a6d5` &rarr; `parent f8cadb2c…`; el reflog pone `origin/main` en f8cadb2 desde las 22:08:51 (el push de s35o) y sin movimiento después.
- R-04: `openssl dgst -md5`: el encargo, bd84f0fc…, en el árbol y en `git show b80a6d5:`; `docs/` 42ab9300… y 883f76bc…; `git diff-tree --numstat`: 10 + 354 = 364. Python sobre el texto crudo: las 5 viñetas de D35-25 del encargo y del archivo de decisiones, iguales (`rd_py.txt`).
- R-05 (`rd_r.txt`): `arrow` sin armar `data.frame` (`num_rows`): 73, 345, 2337 y 10945 filas (8, 4, 7 y 5 columnas); `.vp_listar_archivos()` del validador: 33 archivos y `.Renviron.example` no está entre ellos; `.vp_validar_entorno()`: los ocho checks en OK, `renviron_example` incluido. La base tiene los blobs de `docs/` (R-18).
- R-06: los controles de la calibración se repiten con defectos distintos en R.6 (un literal de `message()`; otra copia de la vista) y disparan.
- R-07 (`rd_shell.txt`, `rd_r.txt`): `grep -rn` sobre el árbol de trabajo (no `git grep`), con las mismas exclusiones y sin `_archivo/`: las mismas 2 líneas del validador, L262 y L280; con `WORKSPACE_DATA_ROOT` y `SLEP_SIMCE_ADECUADO_DATA_ROOT` fijadas con `Sys.setenv()` a rutas inexistentes, `ruta_insumos()` sigue siendo `here::here("20_insumos")` y `obtener_data_root_proyecto` no existe en `10_configuracion.R`; el blob de `.Renviron.example` es el mismo en el árbol, en `b80a6d5` y en `HEAD` (6d809c63…).
- R-08 (`rd_py.txt`): Python sobre `git diff -U0 b80a6d5 9d8aa9e -- README.md`: 1 línea `+` y 1 `-`, un trozo `-277 +277`; en el README, «no editar a mano» 0 veces y la marca nueva 1; `git cat-file -p 9d8aa9e` &rarr; `parent b80a6d5…`.
- R-09 (`rd_py_v2.txt`, `rd_git.txt`): conteo de la tabla de P3 con Python: 28 filas, **21 vigentes, 3 falsas y 4 desactualizadas** (la primera corrida, `rd_py.txt`, contó 20 y una fila rota: partía las celdas en el `\|` escapado de G-26; se corrigió el instrumento, no la tabla, y la primera corrida quedó guardada); en la guía, «inviolable» 0, «33_verificar_motor.R» 2 y «36_verificar_trayectorias.R» 2; los pesos escritos, 2.934.457 y 2.212.989, iguales a `os.path.getsize` de `docs/`; los 12 comandos del bloque `bash`, extraídos con Python, con todas sus rutas existentes (la carpeta de `cd`, las dos baterías, las cuatro rutas de los `cp` y las dos de los `grep` y del `git add`); las baterías, otra vez en R.5; `git cat-file -p 8dc85dc` &rarr; `parent 9d8aa9e…`, `--numstat` 19 10. Los respaldos de las filas falsas: `33_motor_template.html` y `36_funciones_trayectorias.R`, releídos con `grep -n` en FASE 0 y P3; la fórmula, en R-10.
- R-10 (`rd_r.txt`, `rd_py_v2.txt`, `rd_shell.txt`): `agregar_ponderado()` llamada con `palu_eda_ele` y `palu_eda_ins` devuelve `pct_elemental` y `pct_insuficiente`; solo con `ele`, solo `pct_elemental`; sin las dos, ninguna (U-02, U-08); `ls()` del entorno donde se cargó `10_utils.R`: dos funciones, `.tests_agregar_ponderado` y `agregar_ponderado` (U-03, U-04); `getParseData()`: 4 llamadas a `write_parquet` en el paso 30 (C-06); `sleps_chile.parquet`, 7 columnas (C-18); sus RBD con `anio_traspaso` 2026 son 630, todos con `cod_depe2` 1 en `establecimientos_chile`, y los demás 1707, todos con 5 (C-20: la rama prospectiva sí agrega municipales); un `STR_CONST` con `establecimientos_chile.parquet` en `36_funciones_trayectorias.R` (C-24); I-3 por otra vía (`rd_tokens.R`, tokens de `getParseData()` sin comentarios): 1003 y 1003 en `10_utils.R` y 1335 y 1335 en el paso 30, iguales; `grep -rn json_motor` sobre el árbol de trabajo: las mismas 2 líneas de `33_verificar_motor.R`, y como palabra, 0; conteo de la tabla de P4: 38 filas, 27 vigentes, 6 desactualizadas, 4 falsas y 1 «no se mide»; `git cat-file -p 00a1b4b` &rarr; `parent 8dc85dc…`.
- R-11 (`rd_shell.txt`, `rd_py.txt`, `rd_git.txt`): `openssl dgst -md5` de cada archivado igual al de su blob en `b80a6d5` (`git show`), y `git hash-object` del archivado igual al `rev-parse` de ese blob, en los tres; `git ls-tree -r HEAD` ya no trae ninguno (0); `git diff-tree` de 0836a50: tres `D`, 551 + 333 + 209 = 1093 borrados; Python sobre el README: las citas están en L246, L249 y L252, y ninguno de sus tres destinos existe en el árbol ni en `HEAD` (enlaces rotos, R-21).
- R-18 (`rd_shell.txt`, `rd_urls.txt`, `rd_fetch.txt`): `git hash-object`: `docs/index.html` = `40_salidas/motor_comparacion.html` = la base de H5 = `HEAD:` = `origin/main:` = **2554f9a2…**; la vista, en los cinco lugares, **7cbbdb75…**; `git diff --quiet b80a6d5 HEAD -- docs/`, código 0. Red: `grep -c 'http'` = 17 y 2 líneas; revisadas a mano las URL distintas (Python, 9 en el motor y 1 en la vista, con su contexto): espacios de nombres de w3.org (svg, xhtml, xlink, XML, MathML, xmlns), el texto de error de React y los comentarios de licencia de D3 y pako. `src`/`href` con http, `url(http`, `@import` y `XMLHttpRequest`: 0 en las dos. `fetch(`: **4 en el motor** y 0 en la vista; las cuatro están dentro del bloque de D3 (posiciones 407268 a 556240, entre el inicio de D3 y el de pako) y son las definiciones de `d3.blob`, `d3.buffer`, `d3.json` y su auxiliar; el motor no llama a ninguna (`d3.json(` y afines, `window.fetch`, `new Worker(`, `new WebSocket(` e `import(`: 0). **0 cargas por red** (R-26).

**R.3 Invariantes 🔒** (comandos de §4; salida literal en `$TMPDIR/cal_s35p/fase_r/invariantes.txt`, 22:49:21)

I-1 `git for-each-ref --format='%(refname) %(objectname)'` contra `i1_fase0.txt`, fuera de `refs/heads/main` y `refs/remotes/origin/main`
esperado: iguales
obtenido: `diff`, código 0. `refs/heads/main` 0836a505…; `refs/remotes/origin/main` y `origin/HEAD` f8cadb2c… (sin cambio); `feat/contrato-contexto`, local y remota, 31befa2c… &rarr; **PASA**

I-2 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 42ab9300… y 883f76bc…
obtenido: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 &rarr; **PASA**

I-3 `i3.R` (parse sin srcref e `identical()`) por archivo `.R` tocado, contra `$TMPDIR/cal_s35p/antes/` (copias de `b80a6d5`)
esperado: TRUE
obtenido: `git diff --name-only b80a6d5 HEAD -- '*.R'` = los dos de P4; `10_utils.R` «2 y 2; identical: TRUE» (código 0); `30_construir_auxiliares.R` «64 y 64; identical: TRUE» (código 0) &rarr; **PASA**

I-4 `i4.R` entre la base de H5 y `40_salidas/`
esperado: iguales
obtenido: «vista byte a byte: TRUE; motor JSON sin fecha: TRUE; motor resto del HTML: TRUE», código 0 (el build final, en R.5, da lo mismo, y `cmp` da 0 en la vista y 0 en el motor) &rarr; **PASA**

I-5 md5 de `renv.lock` y `renv/settings.json` contra `i5_fase0.txt`
esperado: idénticos
obtenido: `diff`, código 0; e6323bf2d0fb341589c4ce8a19b74636 y d0bcb98db909870724e9b0fc5eff1700 &rarr; **PASA**

**R.4 Alcance global** (`fase_r/alcance.py`, con los ALCANCE de §5 más el log, sobre `git diff --name-only`; y `git status --porcelain`)
esperado: dentro de la unión de los ALCANCE más el log; `status` solo con el log
obtenido: `b80a6d5..HEAD`: «rutas: 7 | por tarea: T0 0, P1 0, P2 1, P3 1, P4 2, P5 3, LOG 0 | fuera: (ninguna)», código 0; con T0 (`b80a6d5^..HEAD`): 9 rutas, fuera ninguna, código 0. El README, cuyo ALCANCE es solo L277, cambia en un solo trozo, `@@ -277 +277 @@`. `git status --porcelain` = `?? …/20260926_documentacion_s35p_log.md` &rarr; **PASA**

**R.5 Regresión completa** (estado final, códigos leídos sin tubería; 22:49:45 a 22:51:23)
esperado: `Rscript 00_build.R` código 0 con 0 fallas críticas; `Rscript 30_procesamiento/33_verificar_motor.R` y `Rscript 30_procesamiento/36_verificar_trayectorias.R` código 0
obtenido: build_codigo=0, «Fallas criticas: 0 | Advertencias: 7», «OK en 6 segundos» (22:49:45 a 22:49:53), `renviron_example` en OK (el mismo resultado de H5: el validador no cambia), e I-4 contra la base, código 0, con `cmp` 0 y 0; motor_codigo=0, «8 pruebas, 8 pasan, 0 fallan (en 70 segundos)» (22:49:55 a 22:51:05); vista_codigo=0, «35 pruebas, 35 pasan, 0 fallan» (22:51:05 a 22:51:23); `git status --porcelain` = solo este log &rarr; **PASA**

**R.6 Control positivo de la propia auditoría** (`control_positivo.txt` y `control_positivo_2.txt`; copias en `fase_r/ctl/`)
esperado: cada instrumento dispara con una cifra alterada y con una ruta fuera de alcance
obtenido: **disparan los dieciséis**, el primero en su segundo intento:
1. identidad: el primer intento (`sed` de «2026-09-26» a «2026-09-27» en una copia de `docs/index.html`) no alteró nada: la fecha va dentro del JSON comprimido y no está en texto plano (`grep -c '2026-09-26' docs/index.html` = 0), y la copia dio el mismo md5 y el mismo blob; el control se rehízo con dos alteraciones reales: la copia de la calibración con la fecha del JSON cambiada (md5 0404b743… ≠ 42ab9300…; blob 2289d609… ≠ 2554f9a2…) y una copia con «pako 2.1.1» (`cmp` 1; md5 41435793…; blob e459a628…);
2. alcance, con `docs/index.html`, `renv.lock` y `10_utils/10_validar_portabilidad.R` en una lista simulada: «fuera: …las tres…», código 1;
3. I-3, con un literal de `message()` cambiado en una copia del paso 30: `i3.R` «identical: FALSE», código 1, y `rd_tokens.R` «iguales: FALSE», código 1;
4. solo comentarios, con una línea de código plantada en una copia del diff de P4: «no comentario: 1»;
5. guion largo, con uno plantado en una copia de las líneas `+` de P3: 1;
6. I-1 e I-5, con un hash alterado en una copia de cada instantánea: `diff`, código 1 y 1;
7. I-2, con un byte agregado a una copia de `docs/trayectorias.html`: md5 b915e704… ≠ 883f76bc…;
8. raíz de datos, con `Sys.getenv("WORKSPACE_DATA_ROOT")` plantado en una copia de `10_configuracion.R`: `grep -rn` halla 1;
9. `json_motor`, plantado en una copia de `10_utils.R`: `grep -rnw` halla 1;
10. parquet, con un quinto `write_parquet` en una copia del paso 30: «encabezado: 4 | write_parquet: 5»;
11. red, con un `<script src="https://…">` y un `url(http://…)` plantados en una copia de la vista: 1 y 1;
12. conteo del inventario, con G-01 cambiada a «falsa» en una copia del log: 20, 4 y 4 en vez de 21, 3 y 4;
13. viñeta del GSE, con una palabra cambiada en una copia de la guía: «iguales: False»;
14. md5 de un archivado, con un byte agregado a una copia: c8705885… ≠ ea91c914…;
15. «inviolable», plantado en una copia de la guía: 1;
16. existencia de destinos del README (R-11), con un destino que sí existe como control negativo: `test -e`, código 0.

**R.7 Veredicto por hallazgo**
- BLOQUEA: ninguno.
- REPARA: ninguno. Las 18 afirmaciones se confirmaron, los cinco 🔒 están en PASA y la regresión pasa. Los tres defectos que dejan textos sin poner al día (R-19, R-20 y R-21) no se pueden corregir dentro del ALCANCE: el primero es una tarea congelada por regla del encargo, el segundo pide tocar código de otro archivo y el tercero, el README fuera de L277.
- ADVIERTE: R-19 a R-28 (tabla R.10).
«0 hallazgos que reparar» se declara junto con los dieciséis controles positivos de R.6.

**R.8 Ciclo de reparación:** no aplica (0 REPARA).

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado, meta ni ALCANCE, y no se tocó ningún 🔒: P1 se congeló con la regla literal, y el criterio de `json_motor` de P4 se registró sin cumplir, en vez de acotarlo a palabra completa. Se corrigieron dos instrumentos, no sus criterios: el conteo de tablas de `rd_py.py` (el `\|` escapado) y el control 1 de R.6 (una alteración que no alteraba), con la primera corrida guardada. La evidencia ya escrita no se editó después de su sección; las cuatro correcciones de cifras o referencias (FASE 0, P3 y P4) se hicieron dentro de su sección, antes de seguir, y están declaradas (R-28). No hubo subagentes.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1 | `diff-tree b80a6d5`; `cat-file -e f8cadb2:`; `git log --all` del log | 2 rutas; encargo nuevo; log sin commit | así | no | ninguna | no | no |
| R-02 | H2 | `rev-parse -q --verify refs/stash`; `test -d .git/worktrees` | sin stash ni worktrees | así | no | ninguna | no | no |
| R-03 | H3 e instantáneas | `cat-file -p b80a6d5`; reflog de `origin/main`; R.3 | f8cadb2; sin movimiento | así | no | ninguna | no | no |
| R-04 | H4 y T0 | `openssl dgst -md5`; `git show b80a6d5:`; `diff-tree --numstat`; Python sobre las viñetas | bd84f0fc…; 42ab…/883f…; 364; 5 iguales | así | no | ninguna | no | no |
| R-05 | H5 y validador | `arrow` `num_rows`; `.vp_listar_archivos()` y `.vp_validar_entorno()` | 4 parquet; `.Renviron.example` no escaneado; OK | así | no | ninguna | no | no |
| R-06 | calibración de I-3 e I-4 | controles con otros defectos (R.6) | disparan | disparan | no | ninguna | no | no |
| R-07 | P1 congelada | `grep -rn` en el árbol; `Sys.setenv()` + `sys.source()`; `git hash-object` | 2 líneas; sin lectura de variables; archivo sin cambio | así | no | ninguna | no | no |
| R-08 | P2 | Python sobre el diff; `cat-file -p 9d8aa9e` | 1 y 1 en L277; 0 | así | no | ninguna | no | no |
| R-09 | P3 | Python sobre la tabla, la guía y su bloque `bash`; `getsize`; `cat-file -p 8dc85dc` | 21/3/4; 0; 2; pesos; rutas existen | así (tras corregir el instrumento) | no | ninguna | no | no |
| R-10 | P4 | llamada a `agregar_ponderado()`; `ls()`; `getParseData()`; `arrow` + cruce con `establecimientos_chile`; tokens sin comentarios; `grep -rn` | columnas opcionales; 2 funciones; 4; 7; 630 municipales; iguales; 2 y 0 | así | no | ninguna | no | no |
| R-11 | P5 | `openssl` y `hash-object` contra los blobs de `b80a6d5`; `ls-tree`; Python sobre el README | iguales; 0; citas en L246, L249 y L252 | así; destinos inexistentes | no | ninguna | no | no |
| R-12 a R-16 | I-1 a I-5 | R.3 | PASA | PASA | no | ninguna | no | no |
| R-17 | alcance | `alcance.py` | 0 fuera | 0 fuera | no | ninguna | no | no |
| R-18 | identidad y red | `git hash-object`; `grep -c http`, lista de URL y `fetch(` revisados a mano | iguales; 0 cargas | así | no | ninguna | no | no |
| R-19 | P1 congelada: `.Renviron.example` sigue documentando la raíz de datos (opciones A y B) y `obtener_data_root_proyecto()`, que el código no usa (R-07); Q-90 queda sin cumplir. Los dos aciertos que la congelaron son del validador, plantilla de la cartera que no se edita por proyecto; el de L280 es un mensaje que remite a `WORKSPACE_DATA_ROOT` si la raíz no resolviera | R-07 | no aplica | desactualizado; meta parcial | ADVIERTE | registrar (Q-95) | no | no |
| R-20 | el criterio de P4 `grep -n 'json_motor'` → 0 no se cumple: 2 aciertos en `33_verificar_motor.R` (`extraer_json_motor()`, código de la batería, fuera del ALCANCE); en `10_utils.R`, 0, y como palabra, 0 en todo el árbol | `git grep`; `grep -rn`; `grep -rnw` | 0 | 2 | ADVIERTE | registrar (Q-96) | no | no |
| R-21 | el README (L246-256, «Documentación») enlaza los tres documentos que P5 archivó; tras el push, tres enlaces rotos en GitHub y un texto que describe archivos que ya no están. El README está fuera del ALCANCE de P5 (§7 P5.2: se registra) | Python sobre el README; `ls-tree` | no aplica | 3 destinos inexistentes | ADVIERTE | registrar (Q-97) | no | no |
| R-22 | premisas del encargo que no se cumplieron: §2 Q-94 («solo se citan entre sí»: los cita el README); §7 P1.1 no previó que el `git grep` halla el validador (el log de s35o ya lo nombraba, A-54); §7 P4.2 no previó `extraer_json_motor` | P1, P4 y P5 | no aplica | premisas falsas | ADVIERTE | registrar (para el redactor) | no | no |
| R-23 | C-21: «existian con COD_DEPE == 1 antes del traspaso» (paso 30, bloque 4) no se puede medir y 4.2 a dice «1/2»; queda sin tocar | lectura | no aplica | no medible | ADVIERTE | registrar | no | no |
| R-24 | C-15: la validación de columnas del paso 30 (L158-168 de `b80a6d5`) no incluye `COD_DEPE`, que el bloque 4 usa (L329-330); es código, fuera de este encargo | `grep -n` | no aplica | brecha de código | ADVIERTE | registrar | no | no |
| R-25 | literales atados a los datos de hoy: los pesos de la guía (2.934.457 y 2.212.989 B) cambian con cada build; el comentario de `ANIO_DATOS_VIGENTE` («último año con datos») vale mientras el último Simce sea 2025 | R-09; H5 | no aplica | ciertos hoy | ADVIERTE | registrar | no | no |
| R-26 | el log de s35o (R-17) dijo «`fetch(`: 0 en las dos»; sobre el mismo blob del motor (2554f9a2…), `\bfetch\(` da 4, todas definiciones de D3 que el motor no llama; no hay carga por red | `rd_fetch.txt` | no aplica | 4 sin llamadas | ADVIERTE | registrar | no | no |
| R-27 | afirmaciones de la guía que esta sesión no mide y que no se tocaron: G-20 (Pages reconstruye en 1 a 2 minutos) y el orden de G-22 (VALPARAÍSO primero) | no aplica | no aplica | no medible | ADVIERTE | registrar | no | no |
| R-28 | errores propios, corregidos antes de seguir: cuatro cifras o referencias escritas antes de medirlas (327 líneas del README, «archivos de s35o» en H5, L74-81 en G-07 y L158-167 en C-15), corregidas en su sección y no con una línea nueva, como pide el kit (4.3 regla 4); en instrumentos, un `Rscript -e` con un escape inválido, el conteo de tablas que partía el `\|` escapado y un control positivo que no alteraba la copia | no aplica | no aplica | corregidos | ADVIERTE | registrar | no | no |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA y ningún REPARA. Las 18 afirmaciones del inventario quedaron confirmadas con otros instrumentos: git de bajo nivel, `openssl` y `git hash-object` en vez de `status` y `md5`, `grep -rn` sobre el árbol en vez de `git grep`, R con `Sys.setenv()`, `getParseData()`, `arrow` sin `data.frame` y una llamada real a `agregar_ponderado()`, y Python sobre el texto crudo, las tablas del log y lo publicado. Los dieciséis controles positivos de la auditoría dispararon (el primero, en su segundo intento). Los cinco 🔒 están en PASA y la regresión completa pasa (build 0; motor 8 de 8; vista 35 de 35). Hay 10 ADVIERTE (R-19 a R-28), ninguno sobre datos, invariantes ni alcance. Los que más pesan son R-21 (el README enlaza los tres documentos archivados: tres enlaces rotos si se publica) y R-19 (P1 congelada: Q-90 sigue sin cumplir).

## Cierre

**Paso 1. Estado del árbol** (`git status --porcelain`, 22:53:44, antes del commit de este log)
esperado: vacío o solo el log
obtenido: `?? 50_documentacion/andamios/logs/20260926_documentacion_s35p_log.md`, status_codigo=0. `CLAUDE.md`, con la línea de s35p y la lista recortada a 5 (autorización 5), está ignorado (`git check-ignore -v`: `.gitignore:49`). Nada que limpiar.

### 1. Resumen

Entraron cinco tareas (P1 a P5, D35-25), más T0. Cuatro se completaron en su primer intento y una se congeló por regla del encargo. El producto no cambió: `docs/` y `40_salidas/` siguen en 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…).
- **P1 (Q-90), congelada.** El `git grep` que la habilitaba dio 2 aciertos, no 0, los dos en `10_validar_portabilidad.R`, la plantilla de la cartera: el sondeo de accesores (L262) y un mensaje de falla (L280). Ninguno lee las variables ni define la función, pero la regla es literal («si da algo, se congela»). `.Renviron.example` no se tocó (Q-95).
- **P2 (Q-91).** La marca del bloque de portabilidad del README dice ahora que el bloque se mantiene a mano desde s35o; «no editar a mano», 0 veces; el README cambia solo en L277.
- **P3 (Q-92).** La guía de publicación usa la viñeta «Segmentación por GSE» del README, tal cual; exige las dos baterías, con sus comandos, antes de cada copia a `docs/`, y su procedimiento las corre; además corrige «ponderado por GSE» (la ponderación es por número de evaluados), «el JSON embebido» (son dos), la validación 4 y los pesos. Inventario de 28 afirmaciones (21 vigentes, 4 desactualizadas y 3 falsas); los 12 comandos del documento se cotejaron y los que no tocan `docs/` ni el remoto se corrieron.
- **P4 (Q-93).** Inventario de 38 comentarios (27 vigentes, 6 desactualizados, 4 falsos y 1 no medible): `10_utils.R` lista sus dos funciones, sin `json_motor()`, y su `@return` nombra las columnas opcionales; el paso 30 enumera sus cuatro parquet, corrige «8 columnas» y «Solo RBDs con COD_DEPE == 6», y nombra `fs::` y la vista. Solo comentarios (I-3 TRUE). El criterio de `json_motor` → 0 da 2, por `extraer_json_motor()` de la batería del motor, fuera del ALCANCE (Q-96).
- **P5 (Q-94).** Los tres documentos de junio pasaron a `_archivo/20260926/50_documentacion/activa/`, con los mismos md5, y salieron del índice. El README los enlaza (L246-256), contra la premisa del encargo; se registró sin editar (Q-97).

FASE R: 18 de 18 afirmaciones confirmadas con otros instrumentos; 16 controles positivos disparan; los 5 🔒 en PASA; regresión completa en PASA; 0 BLOQUEA, 0 REPARA y 10 ADVIERTE. Veredicto: **APROBADO CON ADVERTENCIAS**.

### 2. Inventario de commits (`git log b80a6d5..HEAD --oneline`, antes del commit de este log)

```text
0836a50 docs(activa): retira la documentacion de junio que reemplaza la suite (Q-94)
00a1b4b docs(codigo): comentarios de 10_utils.R y del paso 30 al dia (Q-93)
8dc85dc docs(publicacion): regla del GSE acotada y las dos baterias antes de publicar (Q-92)
9d8aa9e docs(readme): el bloque de portabilidad se mantiene a mano (Q-91)
```

P2 `9d8aa9e`, P3 `8dc85dc`, P4 `00a1b4b` y P5 `0836a50`; P1 no tiene commit (congelada). Más el punto de retorno, `b80a6d5 docs(sesion 35): encargo de la decimosexta ola y decision D35-25` (T0), y el commit de este log, `docs(log): ultimos textos de documentacion al dia (s35p)`, cuyo hash va en el reporte final (un archivo no puede llevar el hash de su propio commit). No hubo `fix(auditoria)`. `git diff --stat b80a6d5 HEAD`: 7 archivos, 38 inserciones y 1122 borrados (1093 de ellos, los tres documentos archivados).

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-28).

### 4. Invariantes

I-1 a I-5 en PASA en el estado final (FASE R, R.3), con re-derivación por otra vía (R.2) y controles positivos que disparan (R.6). En FASE L (22:54:12) se midieron otra vez contra las instantáneas de FASE 0:
- I-1: `diff` fuera de `refs/heads/main` y `refs/remotes/origin/main`, código 0 (`$TMPDIR/s35p/i1_fase_l.txt`); `main` 0836a505…, `origin/main` f8cadb2c…;
- I-2: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3;
- I-5: `diff i5_fase0.txt i5_fase_l.txt`, código 0.
I-3 e I-4 no cambian después de R.3 y R.5: ningún comando posterior tocó los `.R` ni las salidas. En ninguna fase un 🔒 dio FALLA. Antes del push se miden las condiciones de la autorización 6 (reporte final).

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 (bd84f0fceb6cb82f52b1edf2eae99ea7, verificado, igual).
- En el encargo: D35-25 (Q-90 a Q-94; commiteada en T0) y las autorizaciones. Se usaron la 1 (T0, P2, P3, P4 y P5), la 2 (P5: `mkdir -p`, `mv` y `git rm --cached`), la 4 (todo lo de `$TMPDIR`) y la 5 (la línea de s35p en `CLAUDE.md` y el recorte a 5, que sacó s35k); la 6 va en el reporte final. La 3 no se usó: ningún intento se descartó. Además, este `docs(log)`, implícito en el patrón; no hubo `fix(auditoria)`.
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión; git 2.54.0, R 4.5.2 con `renv`, Python 3.14.7, Chrome sin interfaz vía `chromote`)

- P1: `git grep` fuera de `50_documentacion/` y `.Renviron.example`: 2 aciertos (L262 y L280 del validador); en `.Renviron.example`, 5 líneas del patrón; `Sys.getenv` solo en `10_locale.R` y `renv/activate.R`.
- P2: `README.md` 328 líneas antes y después (md5 2da0d338… &rarr; 9272c291cd5826beb66ae49e10f2ffcf); `--numstat` 1 1.
- P3: inventario 28 (21/4/3); `publicacion_github_pages.md` 98 &rarr; 107 líneas (md5 c5d2cc7a… &rarr; 510544bd7578edf1ea5dbdec946fd35f), `--numstat` 19 10, 5 trozos; «inviolable» 0; «33_verificar_motor.R» 2; pesos de `docs/` 2934457 y 2212989 B.
- P4: inventario 38 (27/6/4/1); `10_utils.R` 232 &rarr; 226 líneas (md5 9fbb2e64… &rarr; d695731d690b2959460fd0b3c71c97e1), `--numstat` 6 12; `30_construir_auxiliares.R` 454 &rarr; 460 líneas (md5 bb7a3982… &rarr; 28eac6ca6f0472e3427737a37d84a98c), `--numstat` 12 6; I-3 TRUE (2 y 64 expresiones; 1003 y 1335 tokens sin comentarios); parquet 4 = 4; `json_motor` 2 (y 0 como palabra); pruebas inline 7/7.
- P5: md5 89a17069…, de025e48… y ea91c914…, iguales antes y después del movimiento y a los blobs de `b80a6d5`; 1093 líneas salen del índice; `50_documentacion/activa/` queda con 17 entradas; citas del README en L246, L249 y L252.
- Build: código 0, 0 fallas críticas y 7 advertencias (H5 y R.5). Baterías: motor 8 de 8 (70 s, dos veces), vista 35 de 35 (dos veces).
- `docs/` y `40_salidas/`: 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…), sin cambio; `renv.lock` e6323bf2… y `renv/settings.json` d0bcb98d…, sin cambio.

Verificación de §6 (22:54:53): `wc -l` da 226 y 460 líneas en los dos `.R`, 232 y 454 en sus copias de `b80a6d5`, 98 y 107 en la guía; `ls 50_documentacion/activa | wc -l` = 17; `git version 2.54.0`, `R version 4.5.2`, `Python 3.14.7`. Las 460 líneas del paso 30 y las tres versiones se escribieron en §6 antes de este comando, que las midió en el mismo bloque; coinciden (ver errores propios).

### 7. Dudas y pendientes consolidados

Tareas congeladas: **P1** (Q-90), por la condición de §7 P1.1 («Si da algo, se registra y se congela P1»): el `git grep` dio 2 aciertos en el validador de portabilidad. Hallazgos congelados: ninguno. Este encargo cierra Q-91, Q-92, Q-93 (con Q-96 abierta sobre su criterio) y Q-94 (con Q-97 abierta sobre el README); Q-90 sigue abierta (Q-95).

Dudas nuevas (se responden con una palabra):
- Q-95 (P1, R-19). `.Renviron.example` sigue documentando la raíz de datos (opciones A y B) y `obtener_data_root_proyecto()`. El `git grep` de P1 halla esos nombres solo en `10_validar_portabilidad.R`, la plantilla de la cartera que no se edita por proyecto: en el sondeo de accesores (L262, sin efecto aquí: el check resuelve por `ruta_insumos()`) y en un mensaje de falla (L280). Ninguno lee las variables. ¿Se ejecuta P1 en un encargo corto, contando esas dos líneas del validador como ajenas? (sí / no). Bloqueó: P1 entera.
- Q-96 (P4, R-20). El criterio de P4 «`grep -n 'json_motor'` fuera de `50_documentacion/` → 0» da 2, por `extraer_json_motor()` de `33_verificar_motor.R` (L269 y L281), una función de la batería que no tiene que ver con la pendiente de `10_utils.R`, que ya no se nombra. ¿Se da por cumplido el punto con el `grep` como palabra completa, que da 0? (sí / no). Bloqueó: nada (P4 se commiteó).
- Q-97 (P5, R-21). El README (L246-256, «Documentación») enlaza los tres documentos de junio que P5 archivó; si se publica, quedan tres enlaces rotos en GitHub. ¿Un encargo corto quita esas dos entradas del README (la suite, ya enlazada en L240, las reemplaza)? (sí / no). Bloqueó: nada; afecta al README publicado.
- Q-98 (R-24). La validación de columnas del directorio oficial en el paso 30 (`cols_csv_esperadas`, hoy L162) no incluye `COD_DEPE`, que el bloque 4 usa para filtrar (hoy L334-335); si el CSV no la trajera, el error sería menos claro. ¿Se agrega `COD_DEPE` a esa lista en un encargo de código? (sí / no). Bloqueó: nada.

Pendientes que quedan al titular: las respuestas a Q-95 a Q-98; la lectura de lo publicado (el README con los enlaces de Q-97 y la guía de publicación); el traspaso de cierre; siguen Q-70 y Q-71. Para el redactor (R-22): tres premisas del encargo no se cumplieron (§2 Q-94, §7 P1.1 y §7 P4.2). Excluidos por §11 y sin tocar: el código (solo comentarios de P4), `docs/`, la suite (Q-89), `renv`, `feat/contrato-contexto`, Museo Sans (D35-7), Q-70 y Q-71.

`# REVISAR`: ninguno nuevo (`git diff b80a6d5 HEAD` guardado en `$TMPDIR/cal_s35p/diff_total.txt`; `grep -c 'REVISAR'` = 0, código 1, 22:54).

### 8. Errores propios consolidados

- De redacción, corregidos dentro de su sección antes de seguir: cuatro cifras o referencias escritas antes de medirlas: 327 líneas del README (FASE 0; `wc -l` dio 328), «las mismas clases y archivos de s35o» en H5 (el log de s35o no lista archivos), «L74-81» en G-07 (P3; eran L73-85 y L76-77) y «L158-167» en C-15 (P4; era L168). Se corrigieron en el lugar, con la nota de lo que decía, y no con una línea nueva que la cite, como pide el kit (4.3 regla 4). Costo: ninguno sobre datos ni sobre lo publicado; unos minutos. Es el patrón de s35l a s35o: una cifra escrita antes de medirla.
- En §6 de este Cierre, las 460 líneas del paso 30 y las versiones de git, R y Python se escribieron antes del comando que las midió, en el mismo bloque; coinciden.
- De instrumento, corregidos antes de registrar: un `Rscript -e` con `\\.` entre comillas simples falló por el escape (FASE 0; se repitió con un archivo); el conteo de tablas de `rd_py.py` partía las celdas en el `\|` escapado de G-26 (R.2; se corrigió y la primera corrida quedó guardada); el primer control de identidad de R.6 no alteró la copia, porque la fecha va comprimida (se rehízo con dos alteraciones reales).
- De formato, sin ajustar: dos líneas llevan el rótulo seguido de un paréntesis y no de los dos puntos («obtenido (22:38:53 …» en P3 y «obtenido (22:43:29 …» en P4); por eso el conteo del paso 5 no empareja (23 y 21 al cierre, contando la línea del paso 1 de este Cierre). Es el mismo caso de s35l a s35o.
- Ninguno tocó los datos ni el contenido publicado.

### 9. Notas para el revisor

- Qué leer primero: R-21 y Q-97. Si se publica, el README enlaza tres documentos que ya no están en el repositorio; el encargo mandaba registrar y no editar (§7 P5.2), y así se hizo.
- P1 se congeló por una regla literal, con dos aciertos que no leen las variables (Q-95). Si la respuesta es «sí», la edición de `.Renviron.example` es corta: quitar L1-26 salvo la cabecera y dejar la sección de locale con `LANG`.
- En P4 se corrigieron cinco comentarios más de los que nombraba el encargo (D4-a), todos falsos o desactualizados según el inventario, y todos solo comentario (I-3 TRUE con dos instrumentos). C-20 se re-derivó con los datos: 630 RBD de la rama prospectiva, todos municipales.
- El producto no cambió: `docs/` = `40_salidas/` = base de H5, byte a byte (`git hash-object`, `cmp`).
- R-26 corrige un dato del log de s35o (`fetch(`: 4 en el motor, no 0), sin efecto: son definiciones de D3 que el motor no llama.
- Verificación del archivo (FASE L, paso 5): se mide después de este párrafo y va en el paso 5.

### 10. Estado de cierre

- **Commiteado:** T0 (`b80a6d5`), P2 (`9d8aa9e`), P3 (`8dc85dc`), P4 (`00a1b4b`), P5 (`0836a50`) y, al cerrar esta sección, este log (`docs(log)`), en `main`. P1: sin commit (congelada).
- **Local, sin versionar:** `CLAUDE.md`, con esta línea agregada al comienzo de «Últimos cambios» y la lista recortada a las 5 más recientes, que sacó s35k (autorización 5; D35-22 y D35-24): «- s35p (2026-09-26): `publicacion_github_pages.md` usa la regla del GSE del README y exige las dos baterías (Q-92); la marca del bloque de portabilidad del README dice que se mantiene a mano (Q-91); comentarios de `10_utils.R` y del paso 30 al día (Q-93); los tres documentos de junio de `activa/` pasan a `_archivo/` (Q-94). P1 (`.Renviron.example`, Q-90) quedó congelada (Q-95).» Los tres documentos archivados quedan en `_archivo/20260926/50_documentacion/activa/` (ignorada).
- **Condiciones de publicación** (autorización 6), medidas después del commit del log, en el mismo turno: veredicto de FASE R `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío (`CLAUDE.md`, ignorado, no cuenta); `git fetch origin` y `git merge-base --is-ancestor origin/main HEAD` con código 0; md5 de `docs/` sin cambio (I-2). Si se cumplen, `git push origin main` una sola vez; si no, se declara en el reporte final. El resultado y el hash de este commit van en el reporte final.
- **Queda al titular:** Q-95 a Q-98, la lectura del README publicado (Q-97), el traspaso de cierre, Q-70 y Q-71.

**Paso 4. Privacidad** (22:55:40). `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]'` sobre este log: vacío, código 1. Un `grep -niE` de nombres de establecimientos, comunas y personas (`liceo`, `escuela`, `colegio`, `rbd <número>`, las cuatro comunas del territorio, leídas de la salida del build sin copiarlas aquí, y el nombre del titular) y de rutas de OneDrive (`onedrive-`, `cloudstorage`): 0 líneas, código 1 (leído sin tubería; salida en `$TMPDIR/cal_s35p/privacidad.txt`). La lectura lo confirma: no hay filas de datos ni nombres de personas o de establecimientos; las cifras son conteos, md5, hashes y números de línea. Los identificadores que aparecen son la ruta de la estación que exige la plantilla (ENTORNO), el usuario de GitHub dentro de la dirección pública de Pages y «VALPARAÍSO», 2 veces (G-22 y R-27), como el ejemplo de búsqueda que la guía publicada ya trae; no es una comuna del territorio (`grep -ci`, 0) ni una fila de datos.

**Paso 5. Verificación del archivo** (22:56:37, antes de este párrafo): `ls -l` = `-rw-r--r--  1 tomgc  staff  85754 26 Sep 22:56 50_documentacion/andamios/logs/20260926_documentacion_s35p_log.md`; `wc -l` = 536. `grep -c '^### FASE'` = **7**, igual a las fases con sección propia (FASE 0, P1 a P5 y FASE R; FASE L es este Cierre). `grep -c '^## J'` = **1**, con el bloque relleno (13 campos, una línea cada uno). `grep -c '^esperado:'` = **23** y `grep -c '^obtenido:'` = **21**: no son iguales. La diferencia está en dos líneas de formato: el `esperado:` del criterio de P3 tiene su resultado en «obtenido (22:38:53 …» y el de P4, en «obtenido (22:43:29 …». Cada `esperado` tiene su `obtenido`. Se deja el conteo como está (§9.5) y va en los errores propios de formato (§8 y J). El «23 y 21» de §8 se escribió antes de este conteo, a partir del de las 22:55:26 (23 y 21), y coincide. Guiones largos en este log: 1 línea, la cita del texto viejo de L40 de la guía en D3-c; 0 en texto nuevo.
