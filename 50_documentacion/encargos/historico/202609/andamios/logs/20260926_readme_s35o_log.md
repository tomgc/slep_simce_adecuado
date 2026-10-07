# Log: README y comentarios al día (s35o) (slep_simce_adecuado)

- Meta: que el `README.md` y los comentarios de los pasos 31 y 32 no afirmen nada que el código contradiga; el producto no cambia.
- Fecha: 2026-09-26 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: `93f22ec` (commit de T0, H4; 93f22ec44242c49db083531fa6b62a136fcb6951)
- Encargo: `50_documentacion/activa/encargos/encargo_readme_s35o.md`, md5 `ab876f2f57455c257d8d08c4f8abfd59` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega; se mide otra vez en H4)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`). El harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y prevalece: sin subagentes ni Workflow, todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, R1, FASE R, FASE L con el push.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Carpetas de trabajo: `$TMPDIR/s35o/` (instantáneas de I-1 e I-5), `$TMPDIR/cal_s35o/` (lecturas, calibración, copias, controles y parches) y `$TMPDIR/base_s35o/` (las dos salidas del build de H5). `$TMPDIR` = `/var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/`.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: meta cumplida. El `README.md` y los comentarios de §2 de los pasos 31 y 32 ya no afirman nada que el código contradiga: el inventario de 67 afirmaciones (34 vigentes, 18 desactualizadas y 15 falsas) guio la edición; `00_run_all` fuera de `50_documentacion/` pasa a 0, las 81 rutas que nombra el README existen (o están declaradas fuera del repositorio o ausentes por diseño) y los 5 pasos de `00_build.R` están en «Estructura». El producto no cambia (42ab9300…/883f76bc…).
- Estado por tarea: FASE 0 completa · T0 completa · R1 completa (intento 1) · FASE R: 0 BLOQUEA, 0 REPARA, 9 ADVIERTE (R-18 a R-26) · FASE L en el Cierre.
- Commits: 93f22ec (T0, punto de retorno), 60ba5e2 (R1) y el `docs(log)` de este archivo (hash en el reporte final).
- Auditoría (FASE R): sin subagentes. 17 de 17 afirmaciones confirmadas con otros instrumentos: git de bajo nivel, `openssl` y `git hash-object`, Python sobre el XML crudo de los 18 xlsx, R con `Sys.setenv()`, `parse()`, `getParseData()` y `list.files()`, `ls` y `cmp`, conteos sobre lo publicado y `curl`. 13 controles positivos disparan. Veredicto: APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-5 en PASA en el estado final (R.3); I-1, I-2 e I-5, otra vez en FASE L contra FASE 0; las condiciones del push se miden antes de publicar (reporte final).
- Cifras críticas: inventario 67 (34/18/15; 12 falsas más que las de §2); README 254 &rarr; 328 líneas, 121/47, 129 líneas `+` con 0 guiones largos; comentarios 6/6 y 2/2, todos comentarios, I-3 TRUE; rutas 81 y 0 inexistentes; pasos 5 de 5; A3 en 3 de 18 archivos; build 0 con 0 fallas críticas; baterías 8/8 y 35/35; `docs/` 2554f9a2…/7cbbdb75….
- Decisiones autónomas de mayor riesgo: D1-a («Segmentación por GSE» acotada a la vista de comparación del motor, porque el panorama y la vista combinan los grupos); D1-c (el bloque de portabilidad, marcado como generado, se edita a mano más allá de L239); D1-b (el separador de dos listas pasa a «: » también en viñetas vigentes).
- Desviaciones respecto del encargo: ninguna en criterios, tolerancias ni ALCANCE. En los `.R` se tocaron las líneas de §2 y, para que cupiera la lista de A3, las dos que completan cada párrafo (L50-51 y L316-317), solo comentario (I-3). Además de lo pedido: A3 re-derivado del XML crudo de los 18 xlsx, `cmp` e I-4 con un instrumento propio que compara también el resto del HTML del motor.
- Dudas abiertas: Q-90 (`.Renviron.example`), Q-91 (marca del bloque de portabilidad), Q-92 (`publicacion_github_pages.md`: regla del GSE y baterías), Q-93 (comentarios de `10_utils.R` y del paso 30), Q-94 (documentos de junio de `activa/`); siguen Q-70 y Q-71.
- Errores propios: dos horas y un rango de ids escritos antes de medir; un borrador del paso 8 sin respaldo versionado; en instrumentos, el cotejo sin expandir `~`, dos códigos leídos por tubería y dos variables de entorno mal pasadas. Todos corregidos antes de registrar; ninguno tocó los datos ni lo publicado. De formato, sin ajustar: dos líneas «obtenido (…)», por las que el conteo del paso 5 da 17 y 15.
- Qué debe verificar el revisor por sí mismo: la lectura del README en GitHub («Reglas de cálculo» y el bloque de portabilidad); la identidad de `docs/` con `40_salidas/` (`git hash-object`, un comando); las respuestas a Q-90 a Q-94.
- No publicado / queda al usuario: el push de `main` va en el reporte final; el traspaso de cierre, Q-70, Q-71 y Q-90 a Q-94.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite, aunque el harness tenía «ultracode» activo); git 2.54.0, R 4.5.2 con `renv`, Python 3.14.7, Chrome sin interfaz vía `chromote`; de 21:37:24 a 22:07 (el commit del log y el push, en el reporte final).

### FASE 0: log, punto de retorno y premisas

Inicio de FASE 0: 2026-09-26 21:37:24 (`date`). Antes, lectura de los insumos, sin ningún comando de escritura en el árbol: este encargo; `CLAUDE.md` (70 líneas, md5 dce735831003a38f73bde0add6185cf6); el log de s35n entero (inventario H-01 a H-58, R-30 y §7, Q-87); el archivo de decisiones modificado que commitea T0 (D35-24); `README.md` (254 líneas); `00_build.R`; los encabezados de `10_configuracion.R`, `10_utils.R`, `10_html.R`, `10_locale.R`, `10_validar_portabilidad.R` (y sus checks de entorno), de los pasos 30 a 36, de las dos baterías y de `00_escanear_proyecto.R`; las líneas de §2 en los pasos 31 y 32 y el código que describen; `.Renviron.example`, `.Rprofile`, `.gitignore`, `NOTICE`, `renv.lock` (con Python), `publicacion_github_pages.md` y los esquemas de los dos parquet (con `arrow`, solo lectura). Del repositorio hermano `herramientas_dev`, solo lectura: dónde está hoy el protocolo de portabilidad y de dónde viene el `00_run_all.R` del README.

**Paso 1.** Log creado antes de H1, con el encabezado, el slot J vacío y la plantilla; por eso H1 muestra también la línea del propio log. Cada `esperado:` se escribe en el log antes de correr su comando (regla de pre-registro).

**H1.** `git status --porcelain`
esperado: exactamente ` M …/20260924_decision_referente_traspasos.md`, ` M …/20260924_sesion35_errores_asistente.md` y `?? …/encargo_readme_s35o.md`, más el log
obtenido: status_codigo=0, las tres líneas esperadas más el log (salida en `$TMPDIR/cal_s35o/f0/h1.txt`):
```text
 M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
 M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_readme_s35o.md
?? 50_documentacion/andamios/logs/20260926_readme_s35o_log.md
```
**Cumple.**

**H2.** `git stash list | wc -l` y `git worktree list`
esperado: 0; solo el árbol principal
obtenido: stash_codigo=0, 0 líneas; `/Users/tomgc/Projects/slep_simce_adecuado a79242c [main]` (wt_codigo=0). **Cumple.**

**H3.** `git fetch origin`; después `git rev-parse --short HEAD` y `git rev-parse --short origin/main`, en dos comandos. Instantáneas: I-1 (`git for-each-ref --format='%(refname) %(objectname)'`, `$TMPDIR/s35o/i1_fase0.txt`) e I-5 (`md5 -q renv.lock renv/settings.json`, `$TMPDIR/s35o/i5_fase0.txt`)
esperado: fetch sin error; a79242c y a79242c
obtenido: fetch_codigo=0 (sin salida); `a79242c` (c1=0) y `a79242c` (c2=0). `git ls-remote --heads origin`: `feat/contrato-contexto` 31befa2c… y `main` a79242ce…. I-1 de partida (`i1_fase0.txt`, i1_codigo=0):
```text
refs/heads/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/heads/main a79242cea52b33b754c42fcc1a9840172b7dc598
refs/remotes/origin/HEAD a79242cea52b33b754c42fcc1a9840172b7dc598
refs/remotes/origin/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/remotes/origin/main a79242cea52b33b754c42fcc1a9840172b7dc598
```
I-5 de partida (`i5_fase0.txt`, i5_codigo=0): `renv.lock` e6323bf2d0fb341589c4ce8a19b74636 y `renv/settings.json` d0bcb98db909870724e9b0fc5eff1700, los mismos de s35n. **Cumple.**

**H4.** `md5 -q` del encargo y de `docs/`; después `git add` de las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decimoquinta ola y decision D35-24"`
esperado: ab876f2f57455c257d8d08c4f8abfd59 (mensaje de entrega); 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3; un commit con las tres rutas, padre a79242c
obtenido: encargo ab876f2f57455c257d8d08c4f8abfd59 (m1=0); `docs/index.html` 42ab93003e722f9bb6c725fec2d348bd y `docs/trayectorias.html` 883f76bcefc89d93f2d1e753fc4d75c3 (m2=0). T0: commit_codigo=0, `93f22ec docs(sesion 35): encargo de la decimoquinta ola y decision D35-24`, padre `a79242c`, «3 files changed, 329 insertions(+)»; `git show --name-status` = `M …/20260924_decision_referente_traspasos.md`, `A …/encargo_readme_s35o.md`, `M …/20260924_sesion35_errores_asistente.md`; `git status --porcelain` = solo este log. **Punto de retorno: 93f22ec** (93f22ec44242c49db083531fa6b62a136fcb6951).

**H5.** `cd "$RAIZ" && Rscript 00_build.R` (salida en `$TMPDIR/cal_s35o/f0/h5_build.txt`); después, copia de `40_salidas/motor_comparacion.html` y `40_salidas/trayectorias_traspasos.html` a `$TMPDIR/base_s35o/`
esperado: código 0; «Fallas criticas: 0»; las dos salidas escritas y copiadas; `git status --porcelain` = solo este log
obtenido: **build_codigo=0** (21:38:35 a 21:38:43; «=== 00_build.R: OK en 6 segundos ===»; 286 líneas de salida). Validación de portabilidad al inicio: «Archivos escaneados: 33», «Fallas criticas: 0 | Advertencias: 7» (seis `separador_manual` y un `system_shell`, las mismas clases de siempre, ninguna en los pasos 31 y 32); los ocho checks de entorno en OK, con `data_root_resuelto` «Resuelto por ruta_insumos()». Pasos: 30 OK; 31 «18 archivos detectados (9 por nivel), años 2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025», **A3 en `simce2m2015_rbd_final.xlsx`, `simce4b2015_rbd_final.xlsx` y `simce4b2017_rbd_final.xlsx`** (100% con menos de 4 dígitos en los tres; se usa en R1), A4 en seis archivos, 185378 filas; 32 44975 filas (14 columnas); 33 escribe `motor_comparacion.html` (2866 KB); 36 escribe `trayectorias_traspasos.html` (2.21 MB). Copia a `$TMPDIR/base_s35o/`: cp_codigo=0; md5 de la base **42ab93003e722f9bb6c725fec2d348bd** (motor) y **883f76bcefc89d93f2d1e753fc4d75c3** (vista), iguales a los de `docs/`: el `meta$fecha_generacion` del motor es el día (2026-09-26), el mismo de lo publicado (A34-1). `git status --porcelain` = solo este log. **Cumple.**

**Paso 6b. Instrumentos de I-3 e I-4, calibrados antes de editar** (`$TMPDIR/cal_s35o/instrumentos/`; copias de partida desde `git show 93f22ec:` en `$TMPDIR/cal_s35o/antes/`: `31_leer_normalizar.R` c1b25e4b…, `32_agregar_comunal.R` 88fd8cee…, `README.md` ef8a3241…)
- `i3.R <antes> <después>`: `parse(file =, keep.source = FALSE)` de los dos y `identical()` de las expresiones; código 0 si son idénticas.
- `i4.R <dir_base> <dir_actual>`: la vista con `identical()` de los bytes; el motor, con el JSON decodificado sin `meta$fecha_generacion` y el resto del HTML con el bloque base64 reemplazado por un marcador (A34-1); código 0 si las tres comparaciones dan TRUE.
esperado: `i3.R` da 0 con el mismo archivo y con un cambio solo de comentario, y 1 con un cambio de código; `i4.R` da 0 con la base contra sí misma, contra `40_salidas/` y contra una copia que solo cambia la fecha, y 1 con un dato del JSON, un byte fuera del bloque o un byte de la vista
obtenido (calibración, `$TMPDIR/cal_s35o/calibracion/`):
- `i3.R` sobre `32_agregar_comunal.R`: contra sí mismo, «45 y 45; identical: TRUE», c=0; con L9 cambiada solo en el comentario, TRUE, c=0; sin `"cod_depe2"` en `group_vars` (L102, código), FALSE, **c=1**. `31_leer_normalizar.R` de `93f22ec` contra el del árbol: «46 y 46», TRUE, c=0.
- `i4.R` (copias de control con `plantar_i4.R`): base contra base, TRUE/TRUE/TRUE, c=0; contra `40_salidas/`, c=0; solo la fecha cambiada a 1999-01-01 (JSON recodificado), c=0; un campo `"control":1` en `meta`, «JSON sin fecha: FALSE», **c=1**; un espacio antes de `</title>`, «resto del HTML: FALSE», **c=1**; un byte agregado a la vista, «vista byte a byte: FALSE», **c=1**.
**Cumple:** los dos instrumentos distinguen lo que deben.

**Estado:** completa (21:37:24 a 21:40:14, `date` de este cierre; la hora se escribió primero sin medir, 21:40:10, y se corrigió enseguida: ver errores propios). **Commits:** `93f22ec` (T0). **Cambios sustantivos:** ninguno en el producto ni en el README. **Alcance:** las tres rutas de T0 (commit); todo lo demás, en `$TMPDIR`. **Regresión:** el build de H5 es la base de I-4. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D0-a (riesgo bajo): I-4 del motor se mide con un instrumento propio (`i4.R`) que compara el JSON sin la fecha, como `verificar_contenido_motor.R`, y además el resto del HTML, que ese medidor local no compara (A34-1 de `CLAUDE.md` pide las dos cosas).

**Errores propios:** la hora de cierre de esta sección se escribió en el log antes de correr `date` (21:40:10; el `date` dio 21:40:14), el mismo patrón de s35l, s35m y s35n; se corrigió enseguida, antes de seguir. Desde aquí, cada hora sale de un `date` ya impreso. **Dudas:** ninguna.

### FASE R1: README y comentarios al día

Inicio: 21:46:13 (`date` del comando que abrió esta sección). ALCANCE: `README.md`, `30_procesamiento/31_leer_normalizar.R` (solo comentarios) y `30_procesamiento/32_agregar_comunal.R` (solo comentarios).

**Paso 1. Inventario** (antes de editar; las líneas del README son las de `93f22ec`, 254 líneas; «L» sin archivo es del README). Estado: **vigente** (cierto hoy), **desactualizada** (incompleta o atada a un estado anterior, sin ser contraria al código) o **falsa** (contraria al código, a los insumos o al propio repositorio). Verificado con `grep`, `sed`, `ls`, `git ls-files`, `git grep`, `git log`, `du`, `arrow` (esquemas), `readxl` (tres xlsx de A3 y uno de control), Python (`renv.lock`), `gh repo view` (solo lectura) y la salida del build de H5 (`$TMPDIR/cal_s35o/f0/h5_build.txt`). Se reutiliza el inventario de s35n (H-nn) donde la afirmación es la misma.

| id | líneas | afirmación (resumen) | estado | respaldo | acción |
|---|---|---|---|---|---|
| A-01 | L3-5 | motor Simce por estándares, foco en el % ponderado en Adecuado, desglose en tres estándares | vigente | `10_utils.R` L56-84; `33_motor_template.html` L1453-1470 (`mkPunto`) | se completa con la vista (A-02) |
| A-02 | L7-8 | «Producto final: un único archivo `motor_comparacion.html` standalone (JSON embebido)» | falsa | `00_build.R` L11-13 y L44-46: dos salidas; `publicacion_github_pages.md` L9-14; s35n H-04 y H-44 | cambia |
| A-03 | L8-9 | compara comunas, SLEPs, regiones, establecimientos y el nivel nacional | vigente | `33_motor_template.html` L4497-4502 (pestañas Establecimiento, Comuna, SLEP, Región, Nacional y Grupo personalizado) | — |
| A-04 | L13 | R (Positron como entorno) | vigente | `renv.lock` (R 4.5.2); ningún archivo contradice Positron | — |
| A-05 | L14-17 | `readxl`, `arrow`, `dplyr`/`tidyr`/`purrr`, `here` | vigente | `git grep`: `readxl` en 30 y 31, `tidyr` en 32, `purrr` en 31, `here` en todos | — |
| A-06 | L11-17 (omisión) | no nombra `renv`, `jsonlite`, `V8` y `openssl` (build), las bibliotecas JS vendorizadas, `chromote` y Chrome (baterías) ni gobCL | desactualizada | `renv.lock` (V8 8.2.0, openssl 2.4.2, chromote 0.5.1); `33_generar_html.R` L44-60, L73-78, L86-122; cabeceras de `10_utils/*.js` (D3 v7.9.0, pako 2.1.0, React y ReactDOM 18.3.1; Babel 7.29.0 por su URL con sha384); `NOTICE` | agrega |
| A-07 | L22-25 | `00_build.R`, `00_escanear_proyecto.R`, `10_utils/10_utils.R` y `10_utils/d3.min.js`, con su comentario | vigente | `ls`; cabeceras | — |
| A-08 | L21-39 (omisión) | faltan `10_configuracion.R`, `10_locale.R`, `10_html.R`, `10_validar_portabilidad.R`, las otras cuatro bibliotecas JS y `fuentes/` | desactualizada | `git ls-files 10_utils` (13 archivos); `00_build.R` L20 y L31 | agrega |
| A-09 | L26-29 | `20_insumos/` con `simce/4b/`, `simce/2m/` y `auxiliares/` | vigente | `ls` | — |
| A-10 | L31 | 30: «xlsx auxiliares -> parquets de catálogo» | desactualizada | `30_construir_auxiliares.R` L9-21 y L218-433: también lee `directorio_oficial_ee.csv` (comunas, SLEP y establecimientos) | cambia |
| A-11 | L32 | 31: «xlsx Simce -> simce_rbd.parquet» | vigente | `31_leer_normalizar.R` L9-13 | — |
| A-12 | L33 | 32: «Agregación comuna × GSE × prueba × año» | falsa | `32_agregar_comunal.R` L100-102: `group_vars` incluye `nivel` y `cod_depe2`; s35n H-17 | cambia |
| A-13 | L34 | 33: «JSON + HTML final» | desactualizada | el HTML del paso 33 es una de las dos salidas (`00_build.R` L11-13) | cambia |
| A-14 | L35 | `33_motor_template.html`: «Plantilla React/D3 del motor» | vigente | `33_generar_html.R` L13-19 | — |
| A-15 | L30-35 (omisión) | faltan `33_fragmento_sitio.html`, `33_verificar_motor.R`, `34_historico_pct_adecuado_costa_central.R`, los tres archivos del paso 36 y `36_verificar_trayectorias.R` | desactualizada | `git ls-files 30_procesamiento` (12 archivos); `00_build.R` L46 | agrega |
| A-16 | L36-38 | `intermedios/` (no versionados) y `motor_comparacion.html` (no versionado) | vigente | `.gitignore` L10 y L13 | — |
| A-17 | L36-38 (omisión) | faltan `trayectorias_traspasos.html` (no versionado) e `historico_pct_adecuado_costa_central.xlsx` (versionado) | desactualizada | `.gitignore` L14; `git ls-files 40_salidas` | agrega |
| A-18 | L39 | `50_documentacion/` | vigente | `ls` | — |
| A-19 | L21-39 (omisión) | falta `docs/`, lo publicado | desactualizada | `git ls-files docs` (2); `publicacion_github_pages.md` L9-14 | agrega |
| A-20 | L44-46 | xlsx Simce del portal `informacionestadistica.agenciaeducacion.cl`, versionados, públicos, < 25 MB | vigente | `git ls-files` (18 xlsx); `du -ch`: 17 MB; `decisiones/20260611_decision_nombres_establecimientos.md` L21 | — |
| A-21 | L47 | no se requiere configuración adicional de rutas | vigente | `10_configuracion.R` L7-8 y L19-23 (`ruta_insumos()`) | — |
| A-22 | L49-54 | directorio oficial no versionado; MRUN (Ley 21.719) que el pipeline no usa; se descarga de MINEDUC; `gobernanza_datos.md` | vigente | `.gitignore` L44; `git grep MRUN` en `30_procesamiento/` y `10_utils/`: 0; `gobernanza_datos.md` L22 y L64-66 | — |
| A-23 | L58-62 | clonar el repositorio | vigente | — | — |
| A-24 | L63-64 | abrir `slep_simce_adecuado.Rproj` en Positron ancla `here::here()` | vigente | el `.Rproj` es el ancla (`10_validar_portabilidad.R` L221-224; build: «here() starts at …»); qué hace Positron con él no se prueba en un archivo | — |
| A-25 | L65-67 | sin el directorio, fallan los pasos 30 y 31 | vigente | `30_construir_auxiliares.R` L16-21; `31_leer_normalizar.R` L55-60 | — |
| A-26 | L68-72 | instalar con `install.packages(c(…))` | falsa | contradice `renv.lock` y la propia L223 («No instalar con install.packages() a mano»); la lista no trae `V8` ni `openssl`, sin los que el paso 33 se detiene (`33_generar_html.R` L73-78), ni `chromote` | cambia |
| A-27 | L73-76 | `source("00_build.R")` | vigente | `00_build.R` L15-16 | — |
| A-28 | L77 | el producto final queda en `40_salidas/motor_comparacion.html` | desactualizada | `00_build.R` L11-13 | cambia |
| A-29 | L56-77 (omisión) | no dice cómo verificar ni publicar: las dos baterías y la regla de `docs/` | desactualizada | `33_verificar_motor.R` L709 y `36_verificar_trayectorias.R` L1287 (`quit(status = 1)` si falla una prueba); D35-21, Q-82 (`decisiones/20260924_decision_referente_traspasos.md` L275); `publicacion_github_pages.md` | agrega |
| A-30 | L81-89 | indicador; desglose con toggle, misma ponderación, normalización a 100 en el apilado; fórmula | vigente | `10_utils.R` L29-30 y L56-84; `33_motor_template.html` L1453-1470 | — |
| A-31 | L90-94 | filtros `nalu < 10` y marca; gobiernan las filas de los tres niveles | vigente | `10_utils.R` L64-70; `31_leer_normalizar.R` L237 y L254; la vista usa la misma regla (`36_funciones_trayectorias.R` L92 y L228-246) | — |
| A-32 | L95-96 | «Segmentación inviolable: todo resultado se reporta por GSE» | falsa | vigente en la vista de comparación del motor; el panorama territorial del motor combina los cinco GSE (`33_motor_template.html` L1614-1637, L3599, L4098 «Panorama territorial · GSE combinado», L4115-4118) y la vista publica «Todos los grupos» (`36_funciones_trayectorias.R` L111 y L281-287; `36_trayectorias_template.html` L379) | cambia |
| A-33 | L97-98 | no se mezclan pruebas ni niveles | falsa (en la vista) | vigente en el motor (el panorama pone las dos pruebas lado a lado, L3599-3601); la vista publica una serie que combina los dos niveles y las dos pruebas (`36_funciones_trayectorias.R` L108 y L276-278; `36_trayectorias_template.html` L374 «Todas las pruebas y niveles») | cambia |
| A-34 | L99-105 | dependencia vigente aplicada a toda la serie; aviso del motor donde se elige SLEP | vigente | `31_leer_normalizar.R` L66-74 (directorio 2025); `33_motor_template.html` L4307-4320, L4588, L4623, L4644 y L4690 | — |
| A-35 | L109-110 | `00_build.R` carga `10_utils.R` e invoca los pasos de `30_procesamiento/` en orden numérico | desactualizada | `00_build.R` L20-32 y L38-46: antes carga `10_configuracion.R` y corre `validar_portabilidad(detener_si_falla = TRUE)`; invoca 30, 31, 32, 33 y 36 (no el 34 ni las baterías) | cambia |
| A-36 | L111-112 | `00_escanear_proyecto.R`: snapshot, poda, retiene 2 | vigente | `00_escanear_proyecto.R` L12-17 y L49 | — |
| A-37 | L113-116 | `agregar_ponderado()` | vigente | `10_utils.R` L41-95 | — |
| A-38 | L117-118 | 30: «xlsx auxiliares → parquets de catálogo (comunas, establecimientos, SLEPs)» | desactualizada | como A-10 | cambia |
| A-39 | L119-121 | 31 lee, normaliza, valida y emite `simce_rbd.parquet` en formato largo | vigente | `31_leer_normalizar.R` L9-13 | — |
| A-40 | L122-124 | 32 agrega a `comuna × GSE × prueba × nivel × año` | falsa | como A-12; s35n H-17, H-25 y R-08 | cambia |
| A-41 | L125-126 | 33 construye el JSON y lo embebe en la plantilla | vigente | `33_generar_html.R` L9-25 | — |
| A-42 | L107-126 (omisión) | faltan el paso 36, las baterías y `10_configuracion.R` | desactualizada | `00_build.R` L20 y L46 | agrega |
| A-43 | L130-147 | esquema de `simce_rbd.parquet` (14 columnas, tipos y dominios) | vigente | esquema con `arrow` (FASE 0): 14 columnas y tipos iguales; años 2014-2018 y 2022-2025, `cod_depe2` y `cod_grupo` 1 a 5, 0 filas con `preliminar` | — |
| A-44 | L149-166 | esquema de `simce_comunal.parquet` (14 columnas) | vigente | esquema con `arrow`: iguales | — |
| A-45 | L170 | `POLITICA_PROYECTO.md`: política y convenciones canónicas | falsa (en el repositorio) | no está en la raíz (`ls`, código 1) ni en git: `.gitignore` L46-50 («viven en la knowledge base del Project, no en el repositorio») | cambia |
| A-46 | L171-174 | `documentacion_proyecto_slep_simce_adecuado.md` y `.html` de `activa/` | desactualizada | existen, pero son de 2026-06-11 (`git log`) y no nombran la vista (`grep -c -i trayectoria` = 0); la suite de `50_documentacion/suite/` es la versión al día (s35n) | cambia |
| A-47 | L175-178 | `arquitectura_slep_simce_adecuado.html`: insumos → 30 → 31 → 32 → 33 → motor; Pages solo sirve `docs/` | desactualizada | existe; de 2026-06-11, sin el paso 36 (0 aciertos de `36_`); `publicacion_github_pages.md` L9 y L24 | cambia |
| A-48 | L179-180 | `backlog_acumulativo.md` | vigente | `ls`; `git log` 2026-09-24 | — |
| A-49 | L181-183 | `estructura_actual.md` vía `00_escanear_proyecto.R` | vigente | `ls`; `00_escanear_proyecto.R` L12-17 | — |
| A-50 | L168-183 (omisión) | no nombra la suite (`50_documentacion/suite/`) ni `publicacion_github_pages.md` | desactualizada | `git ls-files 50_documentacion/suite` (6); s35n | agrega |
| A-51 | L187-197 | licencia Apache 2.0 del código; datos de la Agencia; `NOTICE` | vigente | `LICENSE`; `NOTICE` | — |
| A-52 | L203 | contrato en `herramientas_dev/gobernanza/portabilidad_os/protocolo_portabilidad_cross_os.md` | falsa | esa carpeta no existe (`ls`, código 1; se archivó en `_archivo/20260901/`); el protocolo está en `gobernanza/protocolo_portabilidad_cross_os.md` de `herramientas_dev`, repositorio privado (`gh repo view`: PRIVATE) | cambia |
| A-53 | L207-208 | instalar Git, R y Positron; clonar fuera de OneDrive | vigente | protocolo de `herramientas_dev` | — |
| A-54 | L209-215 | `~/.Renviron` con `WORKSPACE_DATA_ROOT`; el proyecto se resuelve como `<WORKSPACE_DATA_ROOT>/slep_simce_adecuado`; `SLEP_SIMCE_ADECUADO_DATA_ROOT` gana | falsa | ningún código lee esas variables (`git grep`: solo `.Renviron.example`, comentado, y el mensaje genérico del validador); `ruta_insumos()` = `here::here("20_insumos")` (`10_configuracion.R` L7-8 y L19-23); el validador la resuelve por `ruta_insumos()` (build de H5) | cambia |
| A-55 | L216 | verificar que la raíz de datos esté sincronizada y accesible | falsa | no hay raíz de datos externa (como A-54) | cambia |
| A-56 | L217-223 | `renv::restore()`; `renv.lock`, única fuente de verdad; no `install.packages()` | vigente | `renv.lock`; `.Rprofile` activa `renv` | — |
| A-57 | L227-234 | `validar_portabilidad()` y lo que comprueba; `validar_portabilidad_autotest()` | vigente | `10_validar_portabilidad.R` L218-297 y L360 | — |
| A-58 | L225-234 (omisión) | no dice que `00_build.R` corre la validación y se detiene con una falla crítica | desactualizada | `00_build.R` L25-32 | agrega |
| A-59 | L239 | `source(here::here("00_run_all.R"))` | falsa | `ls 00_*.R`: `00_build.R` y `00_escanear_proyecto.R`; viene de la plantilla de la cartera (`prompt_portabilidad_cross_os.md` L269, archivado en `herramientas_dev/_archivo/20260901/`) | cambia |
| A-60 | L244, L253 | lo que `renv` no resuelve se instala antes; declarar los binarios externos | vigente | — | — |
| A-61 | L248, L250 | Git necesario; Positron recomendado | vigente | — | — |
| A-62 | L249 | «R (4.2 o superior)» | desactualizada | `renv.lock` registra R 4.5.2 | cambia |
| A-63 | L251 | OneDrive institucional necesario (raíz de datos) | falsa | como A-54 | cambia |
| A-64 | L246-251 (omisión) | falta Google Chrome, que las dos baterías necesitan | desactualizada | `33_verificar_motor.R` L41; `36_verificar_trayectorias.R` L48 | agrega |
| C-01 | `32_agregar_comunal.R` L9-10 | «agregación a nivel comuna × GSE × prueba × nivel × año» | falsa | `32_agregar_comunal.R` L100-102; s35n H-17 y R-08 (44975 filas con la dependencia en la clave, 32134 sin ella) | cambia |
| C-02 | `31_leer_normalizar.R` L49 | A3 «(2015/2m, 2017/4b)» | falsa | build de H5: A3 en `simce2m2015`, `simce4b2015` y `simce4b2017`; s35n H-16 y R-08 | cambia |
| C-03 | `31_leer_normalizar.R` L315 | A3 «En 2015/2m y 2017/4b» | falsa | como C-02 | cambia |

Quedan fuera por no describir el proyecto: el título, el marcador HTML del bloque de portabilidad (L199), los enlaces de licencia y la frase «se clona, configura y ejecuta igual en macOS y en Windows» (L203), que no se puede comprobar en esta estación y no se toca. En los comentarios de §2, lo que no es A3 ni la clave se comprobó y es cierto: los tres xlsx de A3 traen códigos de 1 y 2 dígitos (`readxl`: 931/1945, 2475/5083 y 5654/1790; el control `simce4b2016` trae 4 y 5) y el directorio es de 2025 (build: «Año(s) en AGNO: 2025»).

Fuera del ALCANCE, el inventario halló comentarios y documentos que repiten afirmaciones corregidas aquí; no se tocan (§11) y pasan a FASE R: `10_utils.R` L9-10 y L228-231 (`json_motor()` «pendiente», que no existe), `30_construir_auxiliares.R` L9-21 (tres parquet; escribe cuatro, L124-433), `.Renviron.example` L10-25 (raíz de datos y `obtener_data_root_proyecto()`, que no existe) y `publicacion_github_pages.md` L33 («La segmentación por GSE es inviolable») y L46-57 (solo corre la batería de la vista).

Resumen del inventario: **67 filas (64 del README y 3 de comentarios); 34 vigentes, 18 desactualizadas y 15 falsas** (contadas con Python sobre la columna de estado de esta tabla, después de escribirla; A-32, A-33 y A-45 cuentan como falsas). Las tres afirmaciones de §2 del encargo están en A-02, A-12/A-15 y A-59; el inventario halló 12 falsas más.

**Paso 2. Diseño de la edición** (una línea por cambio; todo texto nuevo o cambiado sin guiones largos, con rangos escritos con «a»):
- Producto (A-02): dos archivos, con su nombre publicado en `docs/` y la dirección de Pages (`publicacion_github_pages.md` L21).
- Stack (A-06): `renv`, `jsonlite`, las bibliotecas vendorizadas con su versión, la transpilación con Babel en `V8`, el sha384 con `openssl`, gobCL en las dos páginas y `chromote` con Chrome.
- Estructura (A-08, A-10, A-12, A-13, A-15, A-17, A-19): `10_utils/` como carpeta con sus 13 archivos, los 12 de `30_procesamiento/`, las dos salidas y el xlsx del paso 34, y `docs/`.
- Cómo correr (A-26, A-28, A-29): `renv::restore()` en vez de `install.packages()`, las dos salidas, las dos baterías y la regla de `docs/` (D35-21).
- Reglas (A-32, A-33): se dice dónde valen. La vista de comparación del motor reporta todo por GSE; el panorama del motor y la vista combinan los grupos, y la vista combina además pruebas y niveles; una línea nueva con las reglas de filas de la vista.
- Responsabilidades (A-35, A-38, A-40, A-42): `00_build.R` completo; 30 y 32 corregidos; entradas nuevas para `10_configuracion.R`, el paso 36 y las dos baterías.
- Documentación (A-45 a A-47, A-50): la política no se nombra como archivo (no está en el repositorio); la suite y `publicacion_github_pages.md`; los dos documentos de junio, con su fecha y sin el paso 36.
- Portabilidad (A-52, A-54, A-55, A-58, A-59, A-62 a A-64): la ruta real del protocolo, en un repositorio privado; sin raíz de datos que declarar y con la línea `LANG` de `.Renviron.example`; el paso 4 comprueba el directorio oficial; la validación la corre también `00_build.R`; `00_build.R` en vez de `00_run_all.R`; R 4.5; sin la fila de OneDrive; Google Chrome.
- Formato: en «Responsabilidades por archivo» y «Documentación», el separador « — » de cada viñeta pasa a «: » en todas las viñetas (las nuevas no pueden llevar guion largo y así la lista queda con un solo formato).
- Comentarios: `32_agregar_comunal.R` L9-10 con la dependencia (L11 sin cambio); `31_leer_normalizar.R` L49-51 y L315-317 con los tres archivos, con el párrafo vuelto a cortar (L49 pierde su guion largo; el ancho queda en 79 o menos, dentro del rango del archivo).

**Criterio pre-registrado** (§7 R1.3; se mide al final de esta sección; scripts y salidas en `$TMPDIR/cal_s35o/r1/`)
esperado: `git grep -n '00_run_all' -- ':!50_documentacion'` → 0 aciertos; cada archivo o carpeta que nombra el README existe (cotejo anotado: en el árbol, solo en disco por estar ignorado, o fuera del repositorio); cada `source()` de `30_procesamiento/` en `00_build.R` aparece en el bloque «Estructura»; I-3 con código 0 en los dos `.R` y cada línea `-`/`+` de su diff es un comentario; `grep -c '—'` sobre las líneas `+` del `git diff -U0 93f22ec` de las tres rutas → 0; `Rscript 00_build.R` con código 0 y «Fallas criticas: 0»; I-4 con código 0 contra `$TMPDIR/base_s35o/`; las dos baterías con código 0
obtenido (criterio, entre 21:49:28 y 21:55:58, el último `date` antes del criterio y el `date` del cierre de la medición; la hora de inicio se escribió primero sin medir, 21:51:10, y se corrigió enseguida: ver errores propios; scripts y salidas en `$TMPDIR/cal_s35o/r1/`):
- `git grep -n '00_run_all' -- ':!50_documentacion'`: **0 aciertos** (gitgrep_codigo=1). En todo el repositorio quedan 5, todos en `50_documentacion/`: 3 en este encargo y 2 en el log de s35n.
- Cotejo de rutas (`cotejo_rutas.py`: el bloque «Estructura» con su carpeta madre, los tokens entre comillas invertidas con forma de ruta, los enlaces no web y las rutas de los bloques de código; salida en `cotejo_rutas.txt`): **81 rutas, 0 inexistentes** (cotejo_codigo=0): 69 versionadas en git; 7 solo en disco e ignoradas, que el propio README declara generadas o no versionadas (las dos salidas de `40_salidas/`, nombradas dos veces, los dos parquet y el directorio oficial); 4 fuera del repositorio (`herramientas_dev` y `gobernanza/protocolo_portabilidad_cross_os.md` en el repositorio hermano, `~/.Renviron`, que crea el paso 3, y `~/Projects/slep_simce_adecuado`, la ubicación de ejemplo, que en esta estación existe); y `.Renviron`, ausente por diseño (L305 pide que no esté en el repositorio; check `renviron_no_en_repo` en OK en H5). La primera corrida del instrumento dio 2 «NO EXISTE» falsos, esos dos últimos: el script no expandía `~` y trataba `.Renviron` como una ruta que debía existir. Se corrigió el instrumento, no el criterio; la primera corrida queda en `cotejo_rutas_v1.txt` (ver errores propios).
- Cotejo de pasos (`cotejo_pasos.R`: los `source(here::here(…))` de `00_build.R` leídos con `parse()` y buscados en el árbol de «Estructura»): pasos_codigo=0; **8 `source()`, 5 de ellos pasos de `30_procesamiento/` (30, 31, 32, 33 y 36), todos en «Estructura»**; los otros tres, `10_configuracion.R`, `10_utils.R` y `10_validar_portabilidad.R`, también. Control: el mismo guion sobre el README de `93f22ec` da «faltan en Estructura: 10_utils/10_configuracion.R, 10_utils/10_validar_portabilidad.R, 30_procesamiento/36_generar_trayectorias.R», código 1.
- I-3 (`i3.R`): `31_leer_normalizar.R` «46 y 46; identical: TRUE» (i3_31=0) y `32_agregar_comunal.R` «45 y 45; identical: TRUE» (i3_32=0). El `git diff -U0 93f22ec` de los dos `.R` tiene 16 líneas (8 `+` y 8 `-`), **todas comentarios** (0 que no empiecen con `#` tras la sangría); ancho de las 8 líneas `+`: 73, 77, 79, 72, 74, 50, 75 y 73.
- Guiones largos: 129 líneas `+` en el `git diff -U0 93f22ec` de las tres rutas; `grep -c '—'` → **0** (grep_codigo=1, A34-3). Además, 0 semirrayas («–») en esas líneas, y el README entero queda con 0 guiones largos (antes, en las viñetas de «Responsabilidades» y «Documentación»).
- Build (21:53:47 a 21:53:54, `r1/build.txt`): **build_codigo=0**, «Fallas criticas: 0 | Advertencias: 7» (las mismas de H5), A3 en los mismos tres archivos, «OK en 6 segundos».
- I-4 (`i4.R` contra `$TMPDIR/base_s35o/`): «vista byte a byte: TRUE; motor JSON sin fecha: TRUE; motor resto del HTML: TRUE», **i4_codigo=0**. Los md5 de `40_salidas/` son, además, los mismos de `docs/` (42ab9300… y 883f76bc…).
- Batería de la vista (21:54:07 a 21:54:24): **vista_codigo=0**, «Resultado: 35 pruebas, 35 pasan, 0 fallan».
- Batería del motor (21:54:28 a 21:55:43): **motor_codigo=0**, M1 a M8 en PASA, «Resultado: 8 pruebas, 8 pasan, 0 fallan (en 73 segundos)».
Además: `README.md` pasa de 254 a 328 líneas (md5 2da0d3386a40e7b793e2d168e2d0e9d7; `--numstat` 121 47); `31_leer_normalizar.R` 6 6 (md5 6d8f9b7bba3e50600bb4e25819bbef0c) y `32_agregar_comunal.R` 2 2 (md5 47f3df7a486adaedbd7a1f15b4dab0af). `git status --porcelain` = las tres rutas de R1 y este log.
**Cumple.**

**Commit** `docs(readme): README y comentarios al dia con el pipeline (Q-87)`: `60ba5e2`, padre `93f22ec`; `--numstat` `31_leer_normalizar.R` 6 6, `32_agregar_comunal.R` 2 2, `README.md` 121 47; `git status --porcelain` = solo este log (21:56:26).

**Estado:** completa, en el primer intento (21:46:13 a 21:56:26). **Alcance:** las tres rutas de R1. **Regresión:** build, I-4 y las dos baterías, arriba. **Subagentes:** 0. **Bugs:** ninguno en el producto.

**Decisiones autónomas:**
- D1-a (riesgo medio): «Segmentación inviolable: todo resultado se reporta por GSE» pasa a «Segmentación por GSE», acotada a la vista de comparación del motor, y el README dice que el panorama territorial del motor («GSE combinado») y la vista de trayectorias («Todos los grupos») combinan los grupos, como indican las dos pantallas. La afirmación absoluta es contraria al código en dos pantallas (A-32). No se revisa la regla metodológica ni esas pantallas: se describe lo que hace el código (duda Q-92). La política del proyecto no menciona el GSE (`grep`).
- D1-b (riesgo bajo): en «Responsabilidades por archivo» y «Documentación», el separador « — » pasa a «: » en todas las viñetas, también en las de texto vigente (A-36, A-37, A-39, A-41, A-48, A-49), para que cada lista tenga un solo formato sin guiones largos. En la de `10_utils.R`, «`agregar_ponderado(df, group_vars)`: aplica» pasa a «… `agregar_ponderado(df, group_vars)` aplica», para no encadenar dos veces los dos puntos.
- D1-c (riesgo bajo): el bloque de portabilidad lleva la marca «bloque generado, no editar a mano» (L199 de `93f22ec`); se edita a mano más allá de L239 (A-52, A-54, A-55, A-58, A-62 a A-64) porque el encargo pide corregir todo lo falso del README. La marca se conserva (duda Q-91).
- D1-d (riesgo bajo): «Estructura» muestra `10_utils/` como carpeta con sus entradas sangradas (antes, dos líneas planas); el comentario de `d3.min.js` pasa de «incrustado en el HTML» a «incrustado en el motor», porque ahora hay dos HTML y D3 solo va en el motor: es un cambio de una línea que el inventario dio por vigente (A-07), como consecuencia de A-02. La línea de `motor_comparacion.html` («Producto final (no versionado)», A-16) no cambia.
- D1-e (riesgo bajo): en `31_leer_normalizar.R`, la lista de tres archivos no cabe en el ancho de L49 ni de L315, y cada párrafo se volvió a cortar en sus tres líneas (L49-51 y L315-317). L49 cambia además su guion largo por dos puntos (criterio). L51 queda en 79 caracteres; el archivo ya tenía 11 comentarios de más de 78 (el mayor, 88). En `32_agregar_comunal.R`, «a nivel comuna» pasa a «comuna» para que la dependencia quepa sin tocar L11.
- D1-f (riesgo bajo): el paso 8 («Publicar») dice lo que dice D35-21 («correr antes las dos baterías») y la definición de su código de salida va en el paso 7. El primer borrador decía «solo con las dos baterías en código 0», y eso solo lo dicen `CLAUDE.md` (local, sin versionar) y, para la vista, `publicacion_github_pages.md`: se cambió antes del criterio (ver errores propios).
- D1-g (riesgo bajo): el README llama «privado» al repositorio `herramientas_dev` (`gh repo view`: PRIVATE), porque quien lea el repositorio público no puede abrir el protocolo.

**Errores propios:**
- De redacción: la hora de inicio del criterio se escribió sin medir (21:51:10); se corrigió enseguida con las dos horas medidas que lo acotan. Es el mismo error de FASE 0. El primer borrador del paso 8 del README afirmaba una condición («solo con las dos baterías en código 0») que ningún archivo versionado dice; se halló al releer el README y se corrigió antes de medir (D1-f).
- De instrumento: la primera corrida de `cotejo_rutas.py` dio 2 «NO EXISTE» falsos (no expandía `~` y trataba `.Renviron` como una ruta que debía existir). Se corrigió el instrumento, no el criterio, y la primera corrida quedó guardada; el control positivo del cotejo va en FASE R.

**Dudas:** las de fuera del ALCANCE que halló el inventario pasan a FASE R y al consolidado (Q-90 a Q-93).

### FASE R: auditoría y reparación

Inicio: 21:56:44 (`date` del comando que cerró R1).

**R.1 Inventario de afirmaciones auditables** (armado desde las secciones anteriores de este log, antes de auditar; cada una se re-deriva en R.2 con un comando distinto del que la produjo; scripts y salidas en `$TMPDIR/cal_s35o/fase_r/`)

| id | afirmación (fase) |
|---|---|
| R-01 | H1: el árbol con las tres rutas de T0 más el log (FASE 0) |
| R-02 | H2: stash 0; un solo worktree (FASE 0) |
| R-03 | H3: `HEAD` y `origin/main` en a79242c; instantáneas de I-1 e I-5 (lock e6323bf2…, settings d0bcb98d…) (FASE 0) |
| R-04 | H4: md5 del encargo ab876f2f…; `docs/` 42ab9300… y 883f76bc…; T0 = 93f22ec, padre a79242c, tres rutas (M, A, M), 329 inserciones (FASE 0) |
| R-05 | H5: build con código 0 y 0 fallas críticas; A3 en `simce2m2015`, `simce4b2015` y `simce4b2017`; la base tiene los md5 de `docs/` (FASE 0) |
| R-06 | Calibración de `i3.R` e `i4.R`: distinguen comentario de código, y fecha de dato, resto y vista (FASE 0) |
| R-07 | Inventario de R1: 67 filas (34 vigentes, 18 desactualizadas, 15 falsas) y los respaldos de las 15 falsas (A-02, A-12, A-26, A-32, A-33, A-40, A-45, A-52, A-54, A-55, A-59, A-63, C-01, C-02, C-03) (R1) |
| R-08 | Lo nuevo del README es cierto: versiones y sha384 de las bibliotecas, D3 y React solo en el motor, gobCL en las dos páginas, la dirección de Pages, Chrome en las baterías y su código de salida, el paso 36 y sus insumos, D35-21, la suite, las fechas de los documentos de junio, `herramientas_dev` privado, la línea `LANG` y la guarda de locale, R 4.5.2, los rótulos del panorama y de la vista, las reglas de filas de la vista, `10_configuracion.R` en cada paso, el paso 34 fuera del build (R1) |
| R-09 | Criterio de R1: 0 `00_run_all`; 81 rutas y 0 inexistentes; 8 `source()` y 5 pasos en «Estructura»; I-3 TRUE y diff solo de comentarios; 0 guiones largos en 129 líneas `+`; build 0; I-4 0; baterías 35/35 y 8/8 (R1) |
| R-10 | Commit de R1: 60ba5e2, padre 93f22ec, 6/6, 2/2 y 121/47 (R1) |
| R-11 a R-15 | I-1 a I-5 (§4) |
| R-16 | Alcance global: `git diff --name-only 93f22ec..HEAD` dentro de la unión de los ALCANCE más el log; `git status` |
| R-17 | Identidad de lo publicado (`git hash-object` sobre `docs/` y `40_salidas/`) y ausencia de red en lo publicado (`grep -c 'http'`, revisado a mano) |

**R.2 Re-derivación independiente** (sin subagentes; el orquestador, con otros comandos; scripts y salidas en `$TMPDIR/cal_s35o/fase_r/`: `rd_git.txt`, `rd_a3.py` con `rd_a3.txt`, `rd_falsas_a.txt`, `rd_r.R` con `rd_r.txt`, `rd_nuevo.txt`, `rd_criterio.R` con `rd_criterio.txt`, `rd_criterio2.txt`, `rd_identidad.txt`, `rd_urls.txt` y `rd_ls_cmp.txt`)
esperado: cada afirmación del inventario se confirma o se refuta con un instrumento distinto del original
obtenido: **17 de 17 confirmadas** (R-11 a R-15 en R.3 y R-16 en R.4), 0 refutadas:
- R-01 (`rd_git.txt`): `git diff-tree --name-status -r 93f22ec` = M, A, M en las tres rutas de H1; el encargo no existía en a79242c (`cat-file -e`, código 128); el log no está en ningún commit (`git log --all`, 0).
- R-02: `git rev-parse -q --verify refs/stash`, código 1; `.git/worktrees` no existe (código 1).
- R-03: `git cat-file -p 93f22ec` &rarr; `parent a79242ce…`; el reflog pone `origin/main` en a79242c desde las 21:20:59 (el push de s35n) y sin movimiento después.
- R-04: `openssl dgst -md5`: el encargo, ab876f2f…, en el árbol y en `git show 93f22ec:`; `docs/` 42ab9300… y 883f76bc…; `git diff-tree --numstat`: 9 + 309 + 11 = 329 inserciones.
- R-05 y C-02/C-03 (`rd_a3.py`: Python abre cada xlsx como zip, lee `sharedStrings` y la primera hoja, ubica `cod_com_rbd` por su encabezado y aplica la regla del paso 31, más del 50% con menos de 4 dígitos): **A3 en 3 de 18 archivos, `simce2m2015`, `simce4b2015` y `simce4b2017`**, con 931/1945, 2475/5083 y 5654/1790 códigos de 1 y 2 dígitos (los conteos de `readxl` de R1 y las filas del mensaje del build); los otros 15, 0% (control negativo). La base tiene los blobs de `docs/` (R-17).
- R-06: los controles de la calibración se repiten con defectos distintos en R.6 (un literal de código; otra copia de la vista) y disparan.
- R-07 (`rd_falsas_a.txt`, `rd_r.txt`): 2 HTML en `40_salidas/` y 5 pasos en `00_build.R` (A-02); la lista de `install.packages()` de `93f22ec` tiene 10 paquetes, sin `V8`, `openssl` ni `chromote` (A-26); en lo publicado, «GSE combinado» 5 veces en el motor y «Todos los grupos» 2 y «Todas las pruebas y niveles» 1 en la vista (A-32, A-33); `git ls-files` con «politica_proyecto»: 0, y `git check-ignore` lo atribuye a `.gitignore:47` (A-45); en `herramientas_dev`, `git ls-files` trae `gobernanza/protocolo_portabilidad_cross_os.md` y 0 archivos bajo `gobernanza/portabilidad_os/`, y `gh api` da `private: true` (A-52); con `WORKSPACE_DATA_ROOT` y `SLEP_SIMCE_ADECUADO_DATA_ROOT` fijadas con `Sys.setenv()` a rutas inexistentes, `ruta_insumos()` sigue siendo `here::here("20_insumos")` y `obtener_data_root_proyecto` no existe (A-54, A-55, A-63); `git ls-files '00_*'` = `00_build.R` y `00_escanear_proyecto.R`, y `00_run_all.R` no existe (A-59); `simce_comunal.parquet`: 44975 filas, 44975 claves con `cod_depe2` y 32134 sin ella (A-12, A-40, C-01). El conteo del inventario, repetido: 34, 18 y 15.
- R-08 (`rd_nuevo.txt`, `rd_criterio.txt`): sha384 con `openssl dgst -sha384 -binary | openssl base64 -A` de React, ReactDOM y Babel = los tres `sri` de `33_generar_html.R`; «18.3.1» en React y ReactDOM, «d3js.org v7.9.0», «pako 2.1.0», `standalone@7.29.0`; en lo publicado, `React.createElement` 397 en el motor y 0 en la vista, `d3js.org` 1 y 0, `pako.inflate` 1 y 0, `@babel/standalone` 0 y 0, `gobCL-sitio` 14 y 9, `@font-face` 7 y 3; las dos direcciones de Pages, HTTP 200 (`curl`); `chromote::` 3 veces en cada batería y `quit(status = 1)` si falla una prueba (L709 y L1287); `ARCHIVO_OLAS <- "dim_slep_comunas.csv"` (L147); la suite, 4 `*_standalone.html`, `documentar.R` y `suite_estilos.css` en git; los tres documentos de junio, 2026-06-11 (`git log`), 0 «trayector» y 0 «36_» (Python); `LANG=es_ES.UTF-8` en `.Renviron.example` L34 y el remedio de `10_locale.R` L217 («agregar LANG (ver .Renviron.example) a ~/.Renviron»); `SUMA_NIVELES_MIN <- 99`, `SUMA_NIVELES_MAX <- 101`, `UMBRAL_EVALUADOS <- 10`, y `construir_datos_trayectorias()` llama a `base_valida()` con `excluir_marcadas = TRUE` por omisión (L492-499; el generador no lo cambia, L102); `validar_portabilidad(detener_si_falla = TRUE)` (L32); `34_` 0 veces en `00_build.R`; `10_html.R` lo cargan los pasos 33 y 36 (y la batería del motor); con `parse()`, `10_configuracion.R` lo cargan los seis pasos y las dos baterías (el auxiliar `36_funciones_trayectorias.R`, no); R 4.5.2 en `renv.lock` (`jsonlite`).
- R-09 (`rd_criterio.txt`, `rd_criterio2.txt`, `rd_ls_cmp.txt`): `grep -rln` sobre todo el árbol (sin `.git`, `renv` ni `50_documentacion`, e incluidas las carpetas ignoradas) no halla `00_run_all` (código 1); R con `list.files()`: 56 cadenas con forma de archivo en el README, 0 inexistentes; `ls -d` de las 61 rutas del repositorio que resolvió el cotejo: 0 fallas; los cinco pasos de `00_build.R` en el bloque con `awk` y `grep`, 1 vez cada uno; `getParseData()` sin comentarios: 2073 y 2073 tokens en el paso 31, 778 y 778 en el 32, idénticos; Python sobre `git diff -U0 93f22ec HEAD`: 129 líneas `+`, 0 guiones largos y 0 líneas de `.R` que no sean comentario. Build, I-4 y baterías: R.5.
- R-10: `git cat-file -p 60ba5e2` &rarr; `parent 93f22ec…`; `git diff-tree --numstat`: 6/6, 2/2 y 121/47.
- R-17 (`rd_identidad.txt`, `rd_urls.txt`): `git hash-object`: `docs/index.html` = `40_salidas/motor_comparacion.html` = la base de H5 = `HEAD:` = `origin/main:` = **2554f9a2…**; la vista, en los cinco lugares, **7cbbdb75…**; `git diff --quiet 93f22ec HEAD -- docs/`, código 0. Red en lo publicado: `grep -c 'http'` = 17 y 2 líneas; revisadas a mano todas las URL distintas (Python, 9 en el motor y 1 en la vista, con su contexto): espacios de nombres de w3.org (svg, xhtml, xlink, XML, MathML, xmlns), el texto de error de React (`reactjs.org/docs/error-decoder.html`) y los comentarios de licencia de D3 y pako. `src`/`href` con http, `url(http`, `@import` y `fetch(`: 0 en las dos. **0 cargas por red.**

**R.3 Invariantes 🔒** (comandos de §4; salida literal en `$TMPDIR/cal_s35o/fase_r/invariantes.txt`, 22:00:00)

I-1 `git for-each-ref --format='%(refname) %(objectname)'` contra `i1_fase0.txt`, fuera de `refs/heads/main` y `refs/remotes/origin/main`
esperado: iguales
obtenido: `diff`, código 0. `refs/heads/main` 60ba5e29…; `refs/remotes/origin/main` y `origin/HEAD` a79242ce… (sin cambio); `feat/contrato-contexto`, local y remota, 31befa2c… &rarr; **PASA**

I-2 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 42ab9300… y 883f76bc…
obtenido: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 &rarr; **PASA**

I-3 `i3.R` (parse sin srcref e `identical()`) por archivo tocado, contra `git show 93f22ec:`
esperado: TRUE
obtenido: `31_leer_normalizar.R` «46 y 46; identical: TRUE» (código 0); `32_agregar_comunal.R` «45 y 45; identical: TRUE» (código 0) &rarr; **PASA**

I-4 `i4.R` entre la base de H5 y `40_salidas/`
esperado: iguales
obtenido: «vista byte a byte: TRUE; motor JSON sin fecha: TRUE; motor resto del HTML: TRUE», código 0 (el build final, en R.5, da lo mismo; `cmp`: 0 en la vista y 0 en el motor) &rarr; **PASA**

I-5 md5 de `renv.lock` y `renv/settings.json` contra `i5_fase0.txt`
esperado: idénticos
obtenido: `diff`, código 0; e6323bf2d0fb341589c4ce8a19b74636 y d0bcb98db909870724e9b0fc5eff1700 &rarr; **PASA**

**R.4 Alcance global** (`fase_r/alcance.py`, con los ALCANCE de §5 más el log, sobre `git diff --name-only`; y `git status --porcelain`)
esperado: dentro de la unión de los ALCANCE más el log; `status` solo con el log
obtenido: `93f22ec..HEAD`: «rutas: 3 | por tarea: T0 0, R1 3, LOG 0 | fuera: (ninguna)», código 0; con T0 (`93f22ec^..HEAD`): 6 rutas (T0 3, R1 3), fuera ninguna, código 0. `git status --porcelain` = `?? …/20260926_readme_s35o_log.md` &rarr; **PASA**

**R.5 Regresión completa** (estado final, códigos leídos sin tubería; 22:00:18 a 22:02:06)
esperado: `Rscript 00_build.R` código 0 con 0 fallas críticas; `Rscript 30_procesamiento/33_verificar_motor.R` y `Rscript 30_procesamiento/36_verificar_trayectorias.R` código 0
obtenido: build_codigo=0, «Fallas criticas: 0 | Advertencias: 7», «OK en 6 segundos» (22:00:18 a 22:00:26), e I-4 contra la base, código 0; motor_codigo=0, «8 pruebas, 8 pasan, 0 fallan (en 73 segundos)» (22:00:34 a 22:01:48); vista_codigo=0, «35 pruebas, 35 pasan, 0 fallan» (22:01:48 a 22:02:06); `git status --porcelain` = solo este log &rarr; **PASA**

**R.6 Control positivo de la propia auditoría** (`control_positivo.txt`, `control_positivo_2.txt` y `control_positivo_3.txt`; copias en `fase_r/ctl/`)
esperado: cada instrumento dispara con una cifra alterada y con una ruta fuera de alcance
obtenido: **disparan los trece:**
1. identidad, con la fecha de una copia de `docs/index.html` cambiada en un dígito: md5 7245f99a… ≠ 42ab9300… y `git hash-object` db9ce9e8… ≠ 2554f9a2…;
2. alcance, con `docs/index.html`, `renv.lock` y `30_procesamiento/33_generar_html.R` en una lista simulada: «fuera: …las tres…», código 1;
3. cotejo de rutas, con `35_inexistente.R` plantado en una copia del README: «no existen: 1», código 1;
4. cotejo de pasos, con un `source()` de `37_nuevo.R` plantado en una copia de `00_build.R`: «FALTA», código 1;
5. guion largo, con uno plantado en una copia de las líneas `+`: 1;
6. solo comentarios, con una línea de código plantada en una copia del diff de los `.R`: «no comentario: 1»;
7. I-1 e I-5, con un hash alterado en una copia de cada instantánea: `diff`, código 1 y 1;
8. I-2, con un byte agregado a una copia de `docs/trayectorias.html`: md5 b7c81a50… ≠ 883f76bc…;
9. I-3, con un literal de `message()` cambiado en una copia del paso 32: `i3.R` «identical: FALSE», código 1, y `getParseData()` «tokens iguales: FALSE»;
10. `00_run_all`, plantado en una copia: `grep -rl` halla 1 archivo;
11. red, con un `<script src="https://…">` y un `url(http://…)` plantados en una copia de la vista: 1 y 1;
12. raíz de datos, con una copia de `10_configuracion.R` cuya `ruta_insumos()` sí lee `WORKSPACE_DATA_ROOT`: «igual a here(20_insumos): FALSE»;
13. conteo del inventario, con A-01 cambiada a «falsa» en una copia del log: 33, 18 y 16 en vez de 34, 18 y 15.
Los controles 3, 4, 9 y 12 se corrieron dos veces: en la primera, el código de 3 y 4 se leyó a través de `tail` (una tubería) y en 9 y 12 las variables de entorno se pasaron como argumentos de `Rscript`, que no las fija («Ejecución interrumpida»). Se repitieron sin tubería y con `env` (ver errores propios); las salidas de la primera corrida ya mostraban el disparo de 3 y 4. En el control 12, R arrancó con el `WORKSPACE_DATA_ROOT` que declara el `~/.Renviron` de la estación y no con el que fijó `env`: la copia devolvió una carpeta de OneDrive de la cartera. El control dispara igual, y R.2 no se ve afectado porque allí las variables se fijaron con `Sys.setenv()`, con R ya iniciado (R-24).

**R.7 Veredicto por hallazgo**
- BLOQUEA: ninguno.
- REPARA: ninguno. Las 17 afirmaciones se confirmaron, los cinco 🔒 están en PASA y la regresión pasa; no hay un defecto del propio trabajo con una verificación que falle.
- ADVIERTE: R-18 a R-26 (tabla R.10; aquí se escribió primero «R-18 a R-25», antes de que la tabla sumara R-26, y se corrigió al cerrar la tabla: ver errores propios).
«0 hallazgos que reparar» se declara junto con los trece controles positivos de R.6.

**R.8 Ciclo de reparación:** no aplica (0 REPARA).

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado, meta ni ALCANCE, y no se tocó ningún 🔒. En R1 se corrigió un instrumento (`cotejo_rutas.py`), no el criterio, y la primera corrida quedó guardada. La evidencia ya escrita no se editó; las dos correcciones de hora (FASE 0 y R1) se hicieron en su sección antes de seguir y están declaradas. No hubo subagentes.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1 | `diff-tree 93f22ec`; `cat-file -e a79242c:`; `git log --all` del log | 3 rutas; encargo nuevo; log sin commit | así | — | ninguna | — | — |
| R-02 | H2 | `rev-parse -q --verify refs/stash`; `test -d .git/worktrees` | sin stash ni worktrees | así | — | ninguna | — | — |
| R-03 | H3 e instantáneas | `cat-file -p 93f22ec`; reflog de `origin/main`; R.3 | a79242c; sin movimiento | así | — | ninguna | — | — |
| R-04 | H4 y T0 | `openssl dgst -md5`; `git show 93f22ec:`; `diff-tree --numstat` | ab876f2f…; 42ab…/883f…; 329 | así | — | ninguna | — | — |
| R-05 | H5 y A3 | Python sobre el XML de los 18 xlsx; `git hash-object` de la base | A3 en 3; base = `docs/` | 3 de 18; blobs iguales | — | ninguna | — | — |
| R-06 | calibración de I-3 e I-4 | controles con otros defectos (R.6) | disparan | disparan | — | ninguna | — | — |
| R-07 | inventario y respaldos de las 15 falsas | `git show` + Python; `gh api`; `Sys.setenv()` + `sys.source()`; `unique()` sobre el parquet; conteos en lo publicado | respaldos ciertos; 34/18/15 | así | — | ninguna | — | — |
| R-08 | lo nuevo del README | `openssl` sha384; versiones en los archivos; Python sobre lo publicado; `curl`; `parse()`; `git log` | cierto | así | — | ninguna | — | — |
| R-09 | criterio de R1 | `grep -r`; R con `list.files()`; `ls -d`; `awk`; `getParseData()`; Python sobre el diff | 0; 0; 5/5; iguales; 0; 0 | así | — | ninguna | — | — |
| R-10 | commit de R1 | `cat-file -p`; `diff-tree --numstat` | padre 93f22ec; 6/6, 2/2, 121/47 | así | — | ninguna | — | — |
| R-11 a R-15 | I-1 a I-5 | R.3 | PASA | PASA | — | ninguna | — | — |
| R-16 | alcance | `alcance.py` | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-17 | identidad y red | `git hash-object`; `grep -c http` y lista de URL revisada a mano | iguales; 0 cargas | así | — | ninguna | — | — |
| R-18 | fuera del ALCANCE, `.Renviron.example` L10-25 documenta la raíz de datos (opciones A y B) y `obtener_data_root_proyecto()`, que el código no usa; solo su línea `LANG` aplica, y el README ya lo dice | `git grep`; R.2 (R-07) | — | desactualizado | ADVIERTE | registrar; no se toca (§11, ALCANCE) (Q-90) | — | — |
| R-19 | el bloque de portabilidad del README conserva la marca «bloque generado, no editar a mano», pero se editó a mano (D1-c); regenerarlo desde la plantilla de la cartera (archivada en `herramientas_dev/_archivo/20260901/`, `prompt_portabilidad_cross_os.md` L266-269) devolvería `00_run_all.R` y `WORKSPACE_DATA_ROOT` | lectura; `grep` en `herramientas_dev` | — | riesgo de regresión | ADVIERTE | registrar (Q-91) | — | — |
| R-20 | fuera del ALCANCE, `publicacion_github_pages.md` L33 dice «La segmentación por GSE es inviolable» (el panorama y la vista combinan los grupos) y su procedimiento (L46-57) solo corre la batería de la vista (D35-21 pide las dos); el documento de junio dice lo mismo en su §4.2 | `grep -n` | — | desactualizado | ADVIERTE | registrar; no se toca (Q-92) | — | — |
| R-21 | fuera de §2, otros comentarios de código desactualizados: `10_utils.R` L9-10 y L228-231 (`json_motor()` «pendiente», que no existe) y `30_construir_auxiliares.R` L9-21 (tres parquet; escribe cuatro) | `git grep`; `grep -n write_parquet` | — | desactualizados | ADVIERTE | registrar; no se tocan (§7 R1.2: solo los comentarios de §2) (Q-93) | — | — |
| R-22 | los tres documentos de junio de `activa/` (`documentacion_proyecto…` .md y .html, `arquitectura…` .html) no cubren la vista; el README ya lo dice y remite a la suite | `git log`; conteo | — | desactualizados | ADVIERTE | registrar (Q-94) | — | — |
| R-23 | literales atados a los datos y versiones de hoy en el README: D3 v7.9.0, React 18.3.1, pako 2.1.0, Babel 7.29.0, R 4.5.2 y los años del esquema. Hoy son ciertos; cambian con una biblioteca o una base Simce nueva | R.2 (R-08) | — | ciertos hoy | ADVIERTE | registrar | — | — |
| R-24 | el `~/.Renviron` de la estación declara `WORKSPACE_DATA_ROOT` (visto en el control 12). No afecta a este proyecto, cuyo código no la lee (R-07); la variable sirve a otros proyectos de la cartera | control 12 | — | sin efecto | ADVIERTE | registrar | — | — |
| R-25 | afirmaciones del README que esta sesión no puede medir y que no se tocaron: «se clona, configura y ejecuta igual en macOS y en Windows» (sin Windows a mano) y lo que hace Positron con el `.Rproj` (A-24) | — | — | no medible | ADVIERTE | registrar | — | — |
| R-26 | errores propios de redacción e instrumento, corregidos antes de registrar: dos horas escritas sin medir (FASE 0 y R1), un borrador del paso 8 sin respaldo versionado, el cotejo sin expandir `~`, dos códigos leídos por tubería y dos variables de entorno pasadas como argumentos (R.6) | — | — | corregidos | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA y ningún REPARA. Las 17 afirmaciones del inventario quedaron confirmadas con otros instrumentos: git de bajo nivel, `openssl` y `git hash-object` en vez de `status` y `md5`, Python sobre el XML crudo de los 18 xlsx, R con `Sys.setenv()`, `parse()`, `getParseData()` y `list.files()`, `ls` y `cmp`, conteos sobre lo publicado y `curl`. Los trece controles positivos de la auditoría dispararon. Los cinco 🔒 están en PASA, y la regresión completa pasa (build 0; motor 8 de 8; vista 35 de 35). Hay 9 ADVIERTE (R-18 a R-26), ninguno sobre datos, invariantes ni alcance. Los que más pesan son R-19 (el bloque de portabilidad puede volver a su texto genérico si se regenera) y R-20 (`publicacion_github_pages.md` repite la regla del GSE y omite la batería del motor).

## Cierre

**Paso 1. Estado del árbol** (`git status --porcelain`, 22:05:56, antes del commit de este log)
esperado: vacío o solo el log
obtenido: `?? 50_documentacion/andamios/logs/20260926_readme_s35o_log.md`, status_codigo=0. `CLAUDE.md`, con la línea de s35o y la lista recortada a 5 (autorización 5), está ignorado (`git check-ignore -v`: `.gitignore:49`). Nada que limpiar.

### 1. Resumen

La única tarea, R1, se ejecutó sin congelarse, y el producto no cambió: `docs/` y `40_salidas/` siguen en 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…).
- **R1 (Q-87, D35-24).** El inventario del README y de los tres comentarios de §2 (67 afirmaciones: 34 vigentes, 18 desactualizadas y 15 falsas) guio la edición. El README dice ahora que hay dos salidas y dónde se publican; completa el stack; su «Estructura» nombra los 13 archivos de `10_utils/`, los 12 de `30_procesamiento/` (con el paso 36 y las dos baterías), las dos salidas y `docs/`; «Cómo correr» usa `renv::restore()` y agrega las baterías y la publicación; las reglas de GSE y de pruebas y niveles dicen dónde valen; «Responsabilidades» completa `00_build.R` y agrega `10_configuracion.R`, el paso 36 y las baterías; «Documentación» no nombra como archivo la política, que no está en el repositorio, y agrega la suite; el bloque de portabilidad nombra la ruta real del protocolo, dice que no hay raíz de datos que declarar, cambia `00_run_all.R` por `00_build.R` y pone al día la matriz (R 4.5, Chrome, sin OneDrive). Los comentarios del paso 32 nombran la dependencia en la clave y los del paso 31 nombran los tres archivos de A3. Además de las tres afirmaciones falsas que nombraba el encargo, el inventario halló 12 más, todas corregidas con su respaldo.

FASE R: 17 de 17 afirmaciones confirmadas con otros instrumentos; 13 controles positivos disparan; los 5 🔒 en PASA; regresión completa en PASA; 0 BLOQUEA, 0 REPARA y 9 ADVIERTE. Veredicto: **APROBADO CON ADVERTENCIAS**.

### 2. Inventario de commits (`git log 93f22ec..HEAD --oneline`, antes del commit de este log)

```text
60ba5e2 docs(readme): README y comentarios al dia con el pipeline (Q-87)
```

Más el punto de retorno, `93f22ec docs(sesion 35): encargo de la decimoquinta ola y decision D35-24` (T0), y el commit de este log, `docs(log): README y comentarios al dia (s35o)`, cuyo hash va en el reporte final (un archivo no puede llevar el hash de su propio commit). `git diff --stat 93f22ec HEAD`: 3 archivos, 129 inserciones y 55 borrados.

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-26).

### 4. Invariantes

I-1 a I-5 en PASA en el estado final (FASE R, R.3), con re-derivación por otra vía (R.2) y controles positivos que disparan (R.6). En FASE L (22:06:17) se midieron otra vez contra las instantáneas de FASE 0:
- I-1: `diff` fuera de `refs/heads/main` y `refs/remotes/origin/main`, código 0 (`$TMPDIR/s35o/i1_fase_l.txt`); `main` 60ba5e29…, `origin/main` a79242ce…;
- I-2: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3;
- I-5: `diff i5_fase0.txt i5_fase_l.txt`, código 0.
I-3 e I-4 no cambian después de R.3 y R.5: ningún comando posterior tocó los `.R` ni las salidas. En ninguna fase un 🔒 dio FALLA. Antes del push se miden las condiciones de la autorización 6 (reporte final).

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 (ab876f2f57455c257d8d08c4f8abfd59, verificado, igual).
- En el encargo: D35-24 (Q-87, y Q-88 para el recorte de «Últimos cambios»; commiteada en T0) y las autorizaciones. Se usaron la 1 (T0 y R1), la 4 (todo lo de `$TMPDIR`) y la 5 (la línea de s35o en `CLAUDE.md` y el recorte a 5, que sacó s35i); la 6 va en el reporte final. La 3 no se usó: ningún intento se descartó. La 2 no tiene uso en este encargo. Además, este `docs(log)`, implícito en el patrón; no hubo `fix(auditoria)`.
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión; git 2.54.0, R 4.5.2 con `renv`, Python 3.14.7, Chrome sin interfaz vía `chromote`)

- Inventario de R1: 67 afirmaciones (64 del README y 3 de comentarios); 34 vigentes, 18 desactualizadas, 15 falsas; 12 falsas más que las tres de §2.
- `README.md`: 254 &rarr; 328 líneas (md5 final 2da0d3386a40e7b793e2d168e2d0e9d7); `--numstat` 121 47; 129 líneas `+` en las tres rutas con 0 guiones largos; el README entero, con 0 guiones largos (antes, en las viñetas de dos listas).
- Comentarios: `31_leer_normalizar.R` 6/6 (md5 6d8f9b7b…), `32_agregar_comunal.R` 2/2 (md5 47f3df7a…); 16 líneas `+`/`-`, todas comentarios; I-3 TRUE en los dos (46 y 45 expresiones; 2073 y 778 tokens sin comentarios).
- Cotejos: 81 rutas nombradas, 0 inexistentes (69 en git, 7 solo en disco e ignoradas, 4 fuera del repositorio, `.Renviron` ausente por diseño); 8 `source()` de `00_build.R`, 5 pasos, todos en «Estructura»; `00_run_all` fuera de `50_documentacion/`: 0.
- A3: 3 de 18 archivos (`simce2m2015`, `simce4b2015`, `simce4b2017`), con dos instrumentos (`readxl` y el XML crudo). `simce_comunal.parquet`: 44975 filas, 32134 sin la dependencia en la clave.
- Build: código 0, 0 fallas críticas y 7 advertencias (las mismas en H5, R1 y R.5). Baterías: motor 8 de 8 (73 s), vista 35 de 35.
- `docs/` y `40_salidas/`: 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…), sin cambio; `renv.lock` e6323bf2… y `renv/settings.json` d0bcb98d…, sin cambio.

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno. Este encargo cierra Q-87 (D35-24).

Dudas nuevas (se responden con una palabra):
- Q-90 (R-18). `.Renviron.example` documenta todavía la raíz de datos (opciones A y B) y `obtener_data_root_proyecto()`, que el código no usa; solo su línea `LANG` aplica. ¿Se pone al día en un encargo corto? (sí / no)
- Q-91 (R-19). El bloque de portabilidad del README conserva la marca «bloque generado, no editar a mano», pero ya no es el texto de la plantilla de la cartera; regenerarlo devolvería `00_run_all.R` y `WORKSPACE_DATA_ROOT`. ¿Se quita la marca? (sí / no)
- Q-92 (R-20, D1-a). `publicacion_github_pages.md` dice que «La segmentación por GSE es inviolable» (el panorama y la vista combinan los grupos) y su procedimiento solo corre la batería de la vista. ¿Se pone al día en un encargo corto, con la regla del GSE como la dice ahora el README y las dos baterías? (sí / no)
- Q-93 (R-21). Los comentarios de `10_utils.R` (L9-10 y L228-231: `json_motor()` «pendiente», que no existe) y de `30_construir_auxiliares.R` (L9-21: tres parquet; escribe cuatro) están desactualizados. ¿Se ponen al día en un encargo corto? (sí / no)
- Q-94 (R-22). Los tres documentos de junio de `activa/` (`documentacion_proyecto…` .md y .html, `arquitectura…` .html) no cubren la vista y la suite los reemplaza. ¿Se retiran de `activa/`? (sí / no)

Pendientes que quedan al titular: la lectura del README publicado (en particular, «Segmentación por GSE», D1-a, y el bloque de portabilidad, D1-c); el traspaso de cierre; Q-70, Q-71 y Q-90 a Q-94. Excluidos por §11 y sin tocar: el código (solo comentarios de §2), `docs/`, la suite (Q-89), `renv`, `feat/contrato-contexto`, Museo Sans (D35-7), Q-70 y Q-71.

`# REVISAR`: ninguno nuevo (`git diff 93f22ec HEAD` guardado en `$TMPDIR/cal_s35o/diff_total.txt`; `grep -c 'REVISAR'` = 0, código 1, 22:07).

### 8. Errores propios consolidados

- De redacción, corregidos en su sección antes de seguir: la hora de cierre de FASE 0 (21:40:10 por 21:40:14) y la de inicio del criterio de R1 (21:51:10, sin `date`; se reemplazó por las dos horas medidas que lo acotan), escritas sin medir; «R-18 a R-25» en R.7, escrito antes de que la tabla R.10 sumara R-26. Es el patrón de s35l, s35m y s35n: una cifra escrita antes de medirla.
- Del trabajo, corregido antes de medir el criterio: el primer borrador del paso 8 del README afirmaba «solo con las dos baterías en código 0», que ningún archivo versionado dice (D1-f).
- De instrumento, corregidos antes de registrar: `cotejo_rutas.py` no expandía `~` y trataba `.Renviron` como una ruta que debía existir (2 «NO EXISTE» falsos; la primera corrida quedó guardada); en R.6, dos códigos leídos a través de `tail` (controles 3 y 4, el error que `CLAUDE.md` ya advierte) y dos variables de entorno pasadas como argumentos de `Rscript` (controles 9 y 12). Se repitieron sin tubería y con `env`.
- De formato, sin ajustar: dos líneas llevan el rótulo seguido de un paréntesis y no de los dos puntos («obtenido (calibración, …)» en FASE 0 y «obtenido (criterio, …)» en R1); por eso el conteo del paso 5 no empareja (17 y 15). Es el mismo caso de s35l, s35m y s35n.
- Ninguno tocó los datos ni el contenido publicado.

### 9. Notas para el revisor

- Qué leer primero: el README en GitHub. Sobre todo, «Reglas de cálculo» (D1-a: la segmentación por GSE se dice acotada a la vista de comparación del motor, porque el panorama del motor y la vista muestran también los grupos combinados) y el bloque de portabilidad (D1-c: editado a mano pese a su marca, Q-91).
- El inventario halló 12 afirmaciones falsas fuera de la lista de §2; las más visibles para quien clona: instalar con `install.packages()` (sin `V8` ni `openssl`, el build se detenía en el paso 33), declarar una raíz de datos en OneDrive que ningún código lee y una ruta del protocolo que ya no existe.
- El producto no cambió: `docs/` = `40_salidas/` = base de H5, byte a byte (`git hash-object`, `cmp`).
- Verificación del archivo (FASE L, paso 5): se mide después de este párrafo y va en el paso 5.

### 10. Estado de cierre

- **Commiteado:** T0 (`93f22ec`), R1 (`60ba5e2`) y, al cerrar esta sección, este log (`docs(log)`), en `main`.
- **Local, sin versionar:** `CLAUDE.md`, con esta línea agregada al comienzo de «Últimos cambios» y la lista recortada a las 5 más recientes, que sacó s35i (autorización 5; D35-24, Q-88): «- s35o (2026-09-26): el `README.md` describe el pipeline actual (dos salidas, `00_build.R`, `renv::restore()`, sin raíz de datos externa, GSE combinado en el panorama y la vista) y los comentarios de A3 (paso 31) y de la clave (paso 32) quedan al día (Q-87).»
- **Condiciones de publicación** (autorización 6), medidas después del commit del log, en el mismo turno: veredicto de FASE R `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío (`CLAUDE.md`, ignorado, no cuenta); `git fetch origin` y `git merge-base --is-ancestor origin/main HEAD` con código 0; md5 de `docs/` sin cambio (I-2). Si se cumplen, `git push origin main` una sola vez; si no, se declara en el reporte final. El resultado y el hash de este commit van en el reporte final.
- **Queda al titular:** la lectura del README publicado, el traspaso de cierre, Q-70, Q-71 y las dudas Q-90 a Q-94.

**Paso 4. Privacidad** (22:07:37). `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]'` sobre este log: vacío, código 1. Un `grep -niE` de nombres de establecimientos, comunas y personas (`liceo`, `escuela`, `colegio`, `rbd <número>`, las cuatro comunas del territorio, el nombre del titular) y de la ruta de OneDrive de la estación (`onedrive-`, `cloudstorage`): 0 líneas, código 1 (leído sin tubería; salida en `$TMPDIR/cal_s35o/privacidad.txt`). La lectura lo confirma: no hay filas de datos ni nombres de personas o de establecimientos; las cifras son conteos, md5 y hashes, y los únicos identificadores personales son la ruta de la estación que exige la plantilla (ENTORNO) y el usuario de GitHub dentro de la dirección pública de Pages. La carpeta de OneDrive que apareció en el control 12 se describe sin su ruta.

**Paso 5. Verificación del archivo** (22:07:57, antes de este párrafo): `ls -l` = `-rw-r--r--  1 tomgc  staff  71459 26 Sep 22:07 50_documentacion/andamios/logs/20260926_readme_s35o_log.md`; `wc -l` = 425. `grep -c '^### FASE'` = **3**, igual a las fases con sección propia (FASE 0, FASE R1 y FASE R; FASE L es este Cierre). `grep -c '^## J'` = **1**, con el bloque relleno (13 campos). `grep -c '^esperado:'` = **17** y `grep -c '^obtenido:'` = **15**: no son iguales. La diferencia está en dos líneas de formato: el `esperado:` de la calibración de FASE 0 (paso 6b) tiene su resultado en «obtenido (calibración, …)» (L75) y el del criterio de R1, en «obtenido (criterio, …)» (L183). Cada `esperado` tiene su `obtenido`. Se deja el conteo como está (§9.5) y se suma a los errores propios de formato (§8 y J).

Además (22:08): `grep -c '—'` sobre este log da 59 líneas; clasificadas con Python, 55 usan el guion largo solo como marca de celda vacía en las tablas (el formato de s35n) y 4 lo citan como carácter (el separador viejo del README y el comando `grep -c '—'`); **0 en prosa**.
