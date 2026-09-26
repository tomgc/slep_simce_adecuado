# Log: verificaciones pendientes, batería del motor y CLAUDE.md (s35l, segunda emisión) (slep_simce_adecuado)

- Meta: que el lock se restaure desde cero, que el build exija la serie completa desde 2014, que los años sin Simce vivan en un solo lugar, que el motor tenga una batería versionada con control positivo y que exista un CLAUDE.md local; el contenido publicado no cambia.
- Fecha: 2026-09-26 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: `b452b0a` (commit de T0, H4; b452b0a6baf683f5126de619026c34d4c402675f)
- Encargo: `50_documentacion/activa/encargos/encargo_verificaciones_s35l.md` (segunda emisión), md5 `55b3d232f4591718d93c3ae3cf661890` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`). El harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y prevalece: sin subagentes ni Workflow, todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, L1, L2, L3, L4, L5, L6, FASE R, FASE L con el push.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Carpetas de trabajo: `$TMPDIR/s35l/` (instantáneas de I-1 e I-5 y L1: clon, biblioteca, caché y `retirado/`), `$TMPDIR/cal_s35l/` (calibraciones, copias y parches; esta emisión escribe en subcarpetas nuevas y no toca `h1.txt` ni `h1_lsfiles.txt` de la primera) y `$TMPDIR/base_s35l/` (salidas de H6). `$TMPDIR` = `/var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/`.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: meta cumplida. El lock se restaura desde cero: 57 paquetes en una biblioteca vacía y aislada, con build y batería del clon iguales a `docs/`. El build exige la serie desde 2014: sin 2014 en los dos niveles, antes pasaba y ahora se detiene. Los años sin Simce viven solo en `10_configuracion.R`. El motor tiene una batería versionada de 8 pruebas con control positivo: 8 de 8, y cada salida saboteada falla solo en su prueba. Existe un CLAUDE.md local de 69 líneas. `docs/` sin cambio; el build de hoy lo reproduce byte a byte.
- Estado por tarea: FASE 0 completa · T0 completa · L1 completa · L2 completa · L3 completa · L4 completa · L5 completa (intento 2) · L6 completa · FASE R: 0 BLOQUEA, 1 REPARA (R-42, reparado en `7ceccdb`), 9 ADVIERTE (R-43 a R-51) · FASE L en el Cierre.
- Commits: b452b0a (T0, punto de retorno), 29947ce (L2), 6efefc5 (L3), e41ee1e (L4), 611852a (L5), 7ceccdb (`fix(auditoria)` R-42) y el `docs(log)` de este archivo (hash en el reporte final); L1 y L6 sin commit.
- Auditoría (FASE R): sin subagentes. 41 de 41 afirmaciones confirmadas con otros instrumentos: git de bajo nivel, `openssl` y `git hash-object`, Python, un predictor de las reglas del paso 31 (21 de 21), otra prueba unitaria (5 de 5) y otra salida con dos sabotajes distintos. 9 controles positivos disparan. Veredicto: APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-8 en PASA en el estado final (R.3); I-1 e I-5, otra vez en FASE L contra FASE 0 (`diff`, 0 y 0); las condiciones del push se miden antes de publicar (reporte final).
- Cifras críticas: `restore()` con 57 paquetes (34 de CRAN y 22 de Posit Package Manager); L2 con 11 casos y el predictor en 21 de 21; `git grep` de rango 16 → 12 (1 de inventario y 11 fuera del ALCANCE); 1 literal `2019L` (la definición); plantilla de la vista con 0 y 0; batería del motor 8 de 8 en unos 70 s, más 9 salidas saboteadas; validador con 0 críticas y 7 advertencias; batería de la vista 35 de 35; `docs/` 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…); I-7 28; CLAUDE.md de 69 líneas.
- Decisiones autónomas de mayor riesgo: D1-a (no congelar L1 por los 22 paquetes de Posit Package Manager); D2-a (la regla de inicio va después de la comparación entre niveles); D5-a (M5 sin el `scrollWidth` del documento, que mide M4); D4-c (L462 y L1032 de la vista quedan sin tocar).
- Desviaciones respecto del encargo: ninguna en criterios, tolerancias ni ALCANCE. El `git grep` de L3 halló 11 coincidencias fuera del ALCANCE en vez de 9; se registraron sin editar, como prevé el criterio (R-44). Además de lo pedido: los 9 casos de K3 en el paso 8, el caso `sin2014a2018ambos`, tres controles de marcador en L4 (se pedía uno) y una prueba unitaria de 9 casos.
- Dudas abiertas: Q-79 (lock y Posit Package Manager), Q-80 (L462 y L1032 de la vista), Q-81 (el 2025 «preliminar» en `documentar.R`), Q-82 (conectar las baterías); siguen Q-70 y Q-71.
- Errores propios: tres horas escritas sin medir, corregidas en su sección; instrumentos corregidos antes de registrar (exclusión de traspasos, `bash -c` con comillas, `Rscript -e`, el caso `barra_abajo_ult` de M7, el orden del predictor, la cabecera zlib, `pipestatus`); R-42 reparado; los conteos de §9 del Cierre, escritos por cálculo antes del `grep` que los confirmó. Ninguno tocó los datos ni el contenido publicado.
- Qué debe verificar el revisor por sí mismo: la restauración del lock en otra máquina (R-43, Q-79); una corrida de `Rscript 30_procesamiento/33_verificar_motor.R` en su estación; la revisión en Safari y en un teléfono de s35h y s35i.
- No publicado / queda al usuario: el push de `main` va en el reporte final (sale también 349f22d, el log de la primera emisión); CLAUDE.md queda local; el traspaso de cierre (Q-71), Q-70 y Q-79 a Q-82.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite, aunque el harness tenía «ultracode» activo); git 2.54.0, R 4.5.2 con `renv` 1.1.4, `chromote` 0.5.1, Python 3; de 18:37 a 19:33.

### FASE 0: log, punto de retorno y premisas

Inicio de FASE 0: 2026-09-26 18:37. Antes, lectura de los insumos (este encargo; los logs de s35k y de la primera emisión; los logs de s35f a s35i en sus fases TT, TB, G1, G3, M1, M2, M4 y M5; `36_verificar_trayectorias.R`; los pasos 31, 33 y 36; `10_utils/10_html.R` y `10_configuracion.R`; los medidores de `$TMPDIR/cal_s35{g,h,i}/` y `verificar_navegador.R`; `verificar_contenido_motor.R`), sin ningún comando de escritura en el árbol.

**Paso 1.** Log creado antes de H1, con el encabezado, el slot J vacío y la plantilla; por eso H1 muestra también la línea del propio log. Cada `esperado:` se escribe en el log antes de correr su comando (regla de pre-registro; error de la primera emisión).

**H1.** `git status --porcelain` (salida en `$TMPDIR/cal_s35l/f0/h1.txt`) y `git ls-files 30_procesamiento | grep verificar` (`h1_lsfiles.txt`), en dos comandos, sin tubería para el código
esperado: exactamente ` M …/20260924_decision_referente_traspasos.md`, ` M …/20260924_sesion35_errores_asistente.md` y `?? …/encargo_verificaciones_s35l.md`, más el log; y `git ls-files 30_procesamiento | grep verificar` = solo `30_procesamiento/36_verificar_trayectorias.R`
obtenido: status_codigo=0, las tres líneas esperadas más el log:
```text
 M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
 M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_verificaciones_s35l.md
?? 50_documentacion/andamios/logs/20260926_verificaciones_s35l2_log.md
```
`git ls-files 30_procesamiento` (ls_codigo=0) y `grep verificar` sobre su salida (grep_codigo=0): **una línea**, `30_procesamiento/36_verificar_trayectorias.R`. **Cumple.**

**H2.** `git stash list | wc -l` y `git worktree list`
esperado: 0; solo el árbol principal
obtenido: stash_codigo=0, 0 líneas; `/Users/tomgc/Projects/slep_simce_adecuado 349f22d [main]` (wt_codigo=0). **Cumple.**

**H3.** `git fetch origin`; después `git rev-parse --short HEAD` y `git rev-parse --short origin/main`, en dos comandos. Instantáneas: I-1 (`git for-each-ref --format="%(refname) %(objectname)"`, `$TMPDIR/s35l/i1_fase0.txt`) e I-5 (md5 de `renv.lock` y `renv/settings.json`, y la biblioteca de `renv` con nombre, `Version` de cada `DESCRIPTION` y destino del enlace, `$TMPDIR/s35l/i5_fase0.txt`)
esperado: fetch sin error; 349f22d y 10672ea
obtenido: fetch_codigo=0 (sin salida); `349f22d` (c1=0) y `10672ea` (c2=0). `git ls-remote --heads origin`: `feat/contrato-contexto` 31befa2c… y `main` 10672ea8…. I-1 de partida (`i1_fase0.txt`):
```text
refs/heads/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/heads/main 349f22de0c596ed3d447f698801d59bb8fa53aad
refs/remotes/origin/HEAD 10672ea86f9e0303c5310f15da1ce10f55d8f2c2
refs/remotes/origin/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/remotes/origin/main 10672ea86f9e0303c5310f15da1ce10f55d8f2c2
```
I-5 de partida (`i5_fase0.txt`): `renv.lock` e6323bf2d0fb341589c4ce8a19b74636, `renv/settings.json` d0bcb98db909870724e9b0fc5eff1700; biblioteca `renv/library/macos/R-4.5/aarch64-apple-darwin20` con 58 paquetes (56 enlaces al caché y 2 directorios, `renv` 1.1.4 y `suitedoc` 0.5.1); nombre y versión, ordenados, iguales a la lista de s35j (`diff`, código 0). **Cumple.**

**H4.** `md5 -q` del encargo y de `docs/`; después `git add` de las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la duodecima ola y decision D35-20"`
esperado: 55b3d232f4591718d93c3ae3cf661890 (mensaje de entrega); 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3; un commit con las tres rutas, padre 349f22d
obtenido: encargo 55b3d232f4591718d93c3ae3cf661890; `docs/index.html` 42ab93003e722f9bb6c725fec2d348bd y `docs/trayectorias.html` 883f76bcefc89d93f2d1e753fc4d75c3. T0: `b452b0a docs(sesion 35): encargo de la duodecima ola y decision D35-20`, padre `349f22d`; `git show --name-status` = `M …/20260924_decision_referente_traspasos.md`, `A …/encargo_verificaciones_s35l.md`, `M …/20260924_sesion35_errores_asistente.md`; `git status --porcelain` = solo este log. **Punto de retorno: b452b0a** (b452b0a6baf683f5126de619026c34d4c402675f).

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R` (salida en `$TMPDIR/cal_s35l/f0/h5.txt`; código leído sin tubería)
esperado: 35 en PASA, código 0
obtenido: codigo_bateria=0; «Resultado: 35 pruebas, 35 pasan, 0 fallan» (18:38:13 a 18:38:31). **Cumple.**

**H6.** `cd "$RAIZ" && Rscript 00_build.R` (salida en `$TMPDIR/cal_s35l/f0/h6.txt`); I-4 con `md5 -q`, `cmp` contra `docs/` y `h6_diff.R` (copia del de s35k en `cal_s35l/f0/`)
esperado: código 0 con 0 fallas críticas; la vista con el md5 de `docs/trayectorias.html`; el motor igual a `docs/index.html` fuera de `meta$fecha_generacion`
obtenido: codigo_build=0; «Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 6 segundos». Motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3; `cmp` contra `docs/index.html` y `docs/trayectorias.html`, código 0 y 0: **iguales byte a byte** (mismo día). `h6_diff.R`, codigo_h6diff=0: «fuera del bloque de datos, idéntico: TRUE | largo 837548 837548»; «fecha_generacion hoy: 2026-09-26 | docs: 2026-09-26»; «JSON sin fecha_generacion, identical: TRUE»; «caracteres distintos: 0». `git status --porcelain` = solo este log. **I-4 cumple.**

Las dos salidas se copiaron a `$TMPDIR/base_s35l/` (md5 42ab9300… y 883f76bc…): es la base de H6. `verificar_contenido_motor.R` (raíz, ignorado; autorización 4) apuntaba a `$TMPDIR/base_s35k/`; se apuntó a `base_s35l` (L24 y comentarios de L3 y L12). La copia del comparador del `DATA` de la vista (`cal_s35l/f0/i4_data_vista.R`) apunta también a `base_s35l`.

Calibración de `verificar_contenido_motor.R`
esperado: «idéntico» sobre la base; «difiere» con un número alterado
obtenido: `Rscript verificar_contenido_motor.R` → codigo_i3_base=0, «JSON idéntico a la línea base». `alterar_json_motor.R` (copia del de s35k) sobre la base: «fragmento original: 3.5 -> alterado: 3.6»; `Rscript verificar_contenido_motor.R $TMPDIR/cal_s35l/f0/motor_alterado.html` → codigo_i3_alt=1, «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)». **Dispara.** El comparador del `DATA` de la vista sobre `40_salidas/`: codigo_i4v=0, «identical: TRUE».

**Paso 8. Calibración de L2** (código de hoy; autorización 4). `$TMPDIR/cal_s35l/copia.sh` (copia del de s35k, limitada a `cal_s35l`: `rsync -a` sin `.git`, `_archivo`, `.claude`, `.DS_Store`, `Claude outputs`, `renv/library` ni el directorio oficial, con enlaces simbólicos a esos dos; sin borrados) y `l2_casos.sh antes <casos>` (copia de `k3_casos.sh` de s35k más el caso `sin2014ambos`: `mv` de `simce2m2014_rbd_final.xlsx` y `simce4b2014_rbd_final.xlsx` fuera de la copia). En cada copia, `Rscript 30_procesamiento/31_leer_normalizar.R`. Salidas en `$TMPDIR/cal_s35l/l2_antes/<caso>.txt` y `.cod`. Corren además los 9 casos de K3 de s35k, como «antes» de L2
esperado: `sin2014ambos` **pasa** (código 0: el defecto de Q-74); los 9 casos de K3, lo de la columna «después» de s35k (código 1 salvo `completo` y `con2026ambos`, con sus mensajes)
obtenido: **`sin2014ambos` pasa** (código 0): «OK: 16 archivos detectados (8 por nivel), años 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025.» y «31_leer_normalizar.R: OK. Total 164540 filas». **El defecto de Q-74 se reproduce: la calibración dispara.** Los 9 casos de K3, iguales a la columna «después» de s35k (18:39:43 a 18:40:01):

| caso | xlsx 2m / 4b | código | mensaje |
|---|---|---|---|
| `sin2014ambos` | 8 / 8 | 0 | «OK: 16 archivos detectados (8 por nivel), años 2015, …, 2025.»; 164540 filas |
| `sin2m2024` | 8 / 9 | 1 | «Error: Nivel 2m: faltan años 2024» |
| `con2m2019` | 10 / 9 | 1 | «Error: Nivel 2m: años inesperados 2019» |
| `sin2m2014` | 8 / 9 | 1 | «Error: Nivel 2m: faltan años 2014, que tiene el nivel 4b» |
| `completo` | 9 / 9 | 0 | «OK: 18 archivos detectados (9 por nivel), años 2014, …, 2025.»; 185378 filas |
| `con2026ambos` | 10 / 10 | 0 | «OK: 20 archivos detectados (10 por nivel), años 2014, …, 2026.»; 205668 filas |
| `con2013ambos` | 10 / 10 | 1 | «Error: Nivel 2m: años inesperados 2013» |
| `sin2016ambos` | 8 / 8 | 1 | «Error: Nivel 2m: faltan años 2016» |
| `dup2m2025` | 10 / 9 | 1 | «Error: Nivel 2m: más de un archivo para los años 2025 (simce2m2025_rbd_final.xlsx, simce2m2025_rbd_preliminar.xlsx)» |
| `con2028ambos` | 10 / 10 | 1 | «Error: Nivel 2m: faltan años 2026, 2027» |

**Estado:** completa. **Commits:** `b452b0a` (T0). **Cambios sustantivos:** ninguno en el producto. **Alcance:** las tres rutas de T0 (commit); `verificar_contenido_motor.R` (ignorado, autorización 4). **Regresión:** H5 y H6. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D0-a (riesgo bajo): el paso 8 corre, además del caso pedido, los 9 casos de K3 de s35k con el código de hoy, para tener el «antes» de L2 medido en esta sesión y no solo citado de s35k.
- D0-b (riesgo bajo): las carpetas de esta emisión en `$TMPDIR/cal_s35l/` son subcarpetas nuevas (`f0/`, `l2_antes/`…); los dos archivos de la primera emisión (`h1.txt`, `h1_lsfiles.txt`) no se tocan.

**Errores propios:** ninguno. **Dudas:** ninguna.

### FASE L1: el lock se restaura desde cero (Q-73)

Inicio: 18:41. Autorización 2. Todo ocurre en `$TMPDIR/s35l/`; ninguna ruta del árbol cambia. Antes del clon: marca de tiempo `$TMPDIR/s35l/marca_l1` para detectar escrituras en la biblioteca del árbol y en el caché global de `renv` (`~/Library/Caches/org.R-project.R/R/renv`). Archivos ignorados que el build necesita y el clon no trae (`git status --ignored`): solo `20_insumos/auxiliares/directorio_oficial_ee.csv` (los intermedios de `40_salidas/` los produce el propio build).

**Aislamiento.** `$TMPDIR/s35l/l1_en_clon.sh <comando>` corre el comando en el clon con `RENV_PATHS_ROOT=$TMPDIR/s35l/renv_root`, `RENV_PATHS_CACHE=$TMPDIR/s35l/renv_cache` y `RENV_PATHS_SANDBOX=$TMPDIR/s35l/renv_sandbox`. La biblioteca es la del proyecto clonado, `$TMPDIR/s35l/clon/renv/library/` (ignorada por `renv/.gitignore`, así que el clon la trae vacía). Cada `Rscript` del clon pasa por ese guion.

**Paso 1.** `git clone /Users/tomgc/Projects/slep_simce_adecuado $TMPDIR/s35l/clon`; `ln -s` del directorio oficial del árbol en el clon; conteo de la biblioteca del clon antes de abrir R en él (`find clon/renv/library -mindepth 1 -maxdepth 4`)
esperado: clon en `b452b0a`; biblioteca inexistente o vacía: conteo 0
obtenido: clone_codigo=0; `b452b0a docs(sesion 35): encargo de la duodecima ola y decision D35-20`; `git status --porcelain` del clon vacío; `renv/library` no existe («No such file or directory»), **conteo 0**; en `renv/` solo `activate.R` y `settings.json`. `ln -s` del directorio oficial, ln_codigo=0; el clon sigue sin cambios para git (el archivo está ignorado).

**Paso 2.** `l1_en_clon.sh Rscript -e <...>`: en una sola sesión de R, las rutas de `renv` (`paths$library()`, `paths$cache()`, `paths$root()`), el conteo de la biblioteca, `renv::restore(prompt = FALSE)` con `options(renv.download.trace = TRUE)` (para ver cada URL) y el conteo final (salida en `$TMPDIR/s35l/l1_restore.txt`)
esperado: rutas dentro de `$TMPDIR/s35l/`; `restore()` sin error; 57 paquetes en la biblioteca, `stringi` y `sys` incluidos; se anota de dónde bajó cada uno de los dos
obtenido: codigo_restore=0 (18:41:17 a 18:42:34). Rutas: biblioteca `/private/var/folders/…/T/s35l/clon/renv/library/macos/R-4.5/aarch64-apple-darwin20`, caché `…/T/s35l/renv_cache/v5/macos/R-4.5/aarch64-apple-darwin20`, raíz `…/T/s35l/renv_root`: **las tres en `$TMPDIR/s35l/`**. Al abrir R, `activate.R` arrancó `renv` 1.1.4 («Bootstrapping renv 1.1.4», «Downloading renv ... OK», «Installing renv ... OK»), así que dentro de la sesión el conteo previo a `restore()` es 1 (`renv`); antes de abrir R era 0 (paso 1). `restore()` listó 55 paquetes bajo «# CRAN» y 2 bajo «# https://packagemanager.posit.co/cran/latest» (`stringi` 1.8.7 y `sys` 3.4.3); 56 descargas y 56 instalaciones, todas «OK [installed binary and cached…]»; ningún «FAILED», «Error» ni «Warning message» (`grep`, código 1). **Biblioteca después: 57 paquetes** (los 57 del lock; `ls`), `stringi` y `sys` incluidos. Origen de cada descarga (URL de la traza):
- 34 de CRAN, `https://cloud.r-project.org/bin/macosx/big-sur-arm64/contrib/4.5/…`;
- **`sys` 3.4.3: `https://packagemanager.posit.co/cran/latest/bin/macosx/big-sur-arm64/contrib/4.5/sys_3.4.3.tgz`** (el repositorio que registra el lock);
- **`stringi` 1.8.7: `https://packagemanager.posit.co/cran/2026-08-04/bin/macosx/big-sur-arm64/contrib/4.5/stringi_1.8.7.tgz`**: `renv` lo rotula «from P3M» y usa una instantánea fechada de Posit Package Manager, no `latest`;
- otros 20 también «from P3M», cada uno de la instantánea en que su versión del lock era la vigente: `arrow` 24.0.0 (2026-07-16), `bit64` (2026-04-21), `glue` (2026-04-17), `purrr` (2025-07-10), `magrittr` (2025-09-12), `vctrs` (2026-03-21), `withr` (2026-06-19), `cpp11` (2026-01-20), `tibble` (2026-01-11), `pillar` (2025-07-04), `clipr` (2026-05-25), `dplyr` (2026-04-03), `here` (2025-09-15), `hms` (2025-10-17), `openxlsx` (2026-08-24), `readr` (2025-11-16), `vroom` (2025-09-19), `readxl` (2026-05-16), `stringr` (2025-09-08) y `tidyr` (2025-12-19).
En la biblioteca, `stringi` y `sys` dicen `Repository: RSPM` y `Built: R 4.5.0; aarch64-apple-darwin20; 2026-09-25`, y enlazan al caché de `$TMPDIR/s35l/renv_cache/`. **Cumple.** Ver D1-a sobre los 22 binarios de Posit Package Manager.

**Paso 3.** En el clon: `renv::status()` y `renv::settings$ignored.packages()` (`l1_status.txt`)
esperado: «No issues found» (o equivalente), con `suitedoc` ignorado
obtenido: codigo_status=0; «No issues found -- the project is in a consistent state.»; «ignorados: suitedoc». **Cumple.**

**Paso 4.** En el clon: `Rscript 00_build.R` (`l1_build.txt`), I-4 de sus dos salidas contra `docs/` del árbol (`md5 -q`, `cmp` y `h6_diff.R` adaptado a las rutas del clon, `l1_h6_diff.R`), y la batería de la vista (`l1_bateria.txt`)
esperado: build código 0 con 0 críticas; la vista con el md5 de `docs/trayectorias.html` y el motor igual a `docs/index.html` fuera de `meta$fecha_generacion`; batería 35 de 35, código 0
obtenido: codigo_build_clon=0, «Fallas criticas: 0 | Advertencias: 7», «OK en 11 segundos» (18:43:30). Salidas del clon: motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3; `cmp` contra `docs/index.html` y `docs/trayectorias.html` del árbol, código 0 y 0 (**iguales byte a byte**); `l1_h6_diff.R`, codigo_h6diff_clon=0, «fuera del bloque de datos, idéntico: TRUE», «JSON sin fecha_generacion, identical: TRUE». Batería en el clon: codigo_bateria_clon=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan» (18:43:46 a 18:44:04). En el clon, `.libPaths()` = la biblioteca del clon y un sandbox en `$TMPDIR/s35l/renv_sandbox/`; `find.package("arrow")` y `find.package("chromote")` resuelven en la biblioteca del clon (`l1_libpaths.txt`). **Cumple.**

**Paso 5. I-5 en el árbol** (lista de FASE 0 contra la de ahora, `i5_l1.txt`; `find -newer marca_l1` sobre `renv/library` del árbol y sobre el caché global de `renv`)
esperado: md5 del lock y de `settings.json` y lista de la biblioteca idénticos; sin escrituras nuevas
obtenido: `diff i5_fase0.txt i5_l1.txt`, código 0 (lock e6323bf2…, settings d0bcb98d…, 58 paquetes con los mismos nombres, versiones y destinos); `find -newer` vacío en los dos. **Cumple.**

**Paso 6. Calibración** (autorización 2: `mv`, nunca `rm`). Paquete del lock elegido: `openxlsx` (4.2.8.1, lo usa el paso 31). `mv` de su entrada en la biblioteca del clon (un enlace al caché de `$TMPDIR/s35l/renv_cache/`) a `$TMPDIR/s35l/retirado/`; `renv::status()`; `mv` de vuelta; `renv::status()` otra vez (`l1_cal_retirado.txt`, `l1_cal_devuelto.txt`)
esperado: la biblioteca estaba vacía antes de `restore()` (conteo 0, paso 1); con `openxlsx` retirado, `status()` lo reporta; devuelto, «No issues found»
obtenido: conteo antes de `restore()` = 0 (paso 1, antes de abrir R). Biblioteca del clon con 57 entradas; `mv` de `openxlsx` a `retirado/` (mv_fuera=0): 56. `renv::status()` (código 0): «One or more packages recorded in the lockfile are not installed.» y «The following package(s) are used in this project, but are not installed: - openxlsx». **Dispara.** `mv` de vuelta (mv_vuelta=0): 57, el enlace con el mismo destino en el caché; `retirado/` queda vacío; `renv::status()`: «No issues found -- the project is in a consistent state.». **La calibración cumple.**

**Estado:** completa (18:41 a 18:45). **Commits:** ninguno (L1 no cambia el árbol). **Cambios sustantivos:** ninguno en el árbol; en `$TMPDIR/s35l/`: el clon (`clon/`), su biblioteca, `renv_root/`, `renv_cache/`, `renv_sandbox/`, `retirado/` (vacío) y los guiones y salidas `l1_*`. **Alcance:** solo `$TMPDIR/s35l/`; `git status --porcelain` del árbol = solo este log. **Regresión:** build y batería en el clon (paso 4). **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D1-a (riesgo medio): 22 de las 56 descargas no vinieron de CRAN sino de Posit Package Manager: `sys` desde `latest`, como registra el lock, y otros 21, entre ellos `stringi`, `arrow`, `dplyr` y `openxlsx`, desde instantáneas fechadas («from P3M»). Son paquetes cuya versión del lock ya no es la vigente en CRAN, y `renv` 1.1.4 busca su binario en la instantánea en que lo era. No congela L1: el criterio pide que `restore()` termine sin error y restaure los 57, y se cumple. Pero la restauración depende hoy de ese servicio público, y sin él esos 22 se compilarían desde el archivo de fuentes de CRAN. Va como ADVIERTE en FASE R.
- D1-b (riesgo bajo): la biblioteca vacía se contó antes de abrir R en el clon (0). Al abrir R, `activate.R` instala `renv` en ella (es su arranque), así que dentro de la sesión el conteo previo a `restore()` es 1. Los dos conteos quedan anotados.
- D1-c (riesgo bajo): el paquete retirado fue `openxlsx`: está en el lock y lo usa el pipeline, y su entrada en la biblioteca es un enlace, así que `mv` lo mueve sin tocar el caché.

**Errores propios:** ninguno. **Dudas:** ninguna.

### FASE L2: la serie debe empezar en `ANIO_INICIO` (Q-74)

Inicio: 18:45. ALCANCE: `30_procesamiento/31_leer_normalizar.R`.

**Criterio pre-registrado** (se mide al final de esta sección, con `l2_casos.sh despues` y el build de hoy)
esperado: copia sin 2014 en los dos niveles (`sin2014ambos`) → se detiene, con un mensaje que nombra el nivel y los años que faltan desde `ANIO_INICIO`; insumos completos → pasa; los casos de K3 de s35k (`sin2m2024`, `con2m2019`, `sin2m2014`, `con2026ambos`, `dup2m2025`) y los otros cuatro de FASE 0 (`completo`, `con2013ambos`, `sin2016ambos`, `con2028ambos`), el mismo código y el mismo mensaje que en FASE 0 (la columna «después» de s35k); I-4 con los insumos de hoy

**Cambio** (`31_leer_normalizar.R`, +15/−1): después de la comparación entre niveles, un bucle por nivel calcula `faltan <- setdiff(seq(ANIO_INICIO, min(anios_nv)), c(anios_nv, ANIOS_SIN_SIMCE))` y, si no está vacío, detiene el build con «Nivel %s: la serie empieza en %d y no en ANIO_INICIO (%d); faltan años %s». El comentario del bloque de validación suma la regla («Por último, la serie de cada nivel empieza en ANIO_INICIO (Q-74)»), y un comentario propio explica por qué va al final. Llegado ese bucle, cada nivel tiene al menos un año: sin ninguno en los dos se detiene antes («No hay xlsx…»), y con uno vacío y otro no, la regla entre niveles. md5 del paso 31: 0ce68bfe4936ee98f4b889f4ebcd8e2b.

obtenido (criterio; `l2_casos.sh despues`, 18:45:33 a 18:45:49; las diez copias con el paso 31 de md5 0ce68bfe…, `sort | uniq -c` = 10):

| caso | antes (FASE 0, paso 8) | después (L2) |
|---|---|---|
| `sin2014ambos` | 0: «OK: 16 archivos detectados (8 por nivel), años 2015, …, 2025.» | **1: «Error: Nivel 2m: la serie empieza en 2015 y no en ANIO_INICIO (2014); faltan años 2014»** |
| `sin2m2024` | 1: «Nivel 2m: faltan años 2024» | igual |
| `con2m2019` | 1: «Nivel 2m: años inesperados 2019» | igual |
| `sin2m2014` | 1: «Nivel 2m: faltan años 2014, que tiene el nivel 4b» | igual |
| `completo` | 0: «OK: 18 archivos detectados (9 por nivel), años 2014, …, 2025.»; 185378 filas | igual |
| `con2026ambos` | 0: «OK: 20 archivos detectados (10 por nivel), años 2014, …, 2026.»; 205668 filas | igual |
| `con2013ambos` | 1: «Nivel 2m: años inesperados 2013» | igual |
| `sin2016ambos` | 1: «Nivel 2m: faltan años 2016» | igual |
| `dup2m2025` | 1: «Nivel 2m: más de un archivo para los años 2025 (…)» | igual |
| `con2028ambos` | 1: «Nivel 2m: faltan años 2026, 2027» | igual |

«igual»: la línea de `Error` o de `OK: … archivos` y el código de salida, comparados por guion entre `l2_antes/` y `l2_despues/`. Caso adicional, `sin2014a2018ambos` (sin 2014 a 2018 en los dos niveles): código 1, «Error: Nivel 2m: la serie empieza en 2022 y no en ANIO_INICIO (2014); faltan años 2014, 2015, 2016, 2017, 2018». Los años sin Simce no se cuentan como faltantes.

I-4 con los insumos de hoy (`Rscript 00_build.R`, `l2_build.txt`): codigo_build=0, «Fallas criticas: 0 | Advertencias: 7», «OK: 18 archivos detectados (9 por nivel), años 2014, …, 2025.»; motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3, `cmp` contra `docs/` 0 y 0; `h6_diff.R`: «idéntico: TRUE», «identical: TRUE». I-3: codigo_i3=0, «JSON idéntico a la línea base». Batería: codigo_bateria=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan». **Cumple.**

**Commit** `fix(pipeline): la serie Simce debe empezar en ANIO_INICIO (Q-74)`: `29947ce`, padre `b452b0a`; `30_procesamiento/31_leer_normalizar.R` (`--numstat` 15 1); `git status --porcelain` = solo este log.

**Estado:** completa, en el primer intento. **Alcance:** `31_leer_normalizar.R`, dentro del ALCANCE. **Regresión:** build, I-3, I-4 y batería (arriba). **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D2-a (riesgo bajo): la regla de inicio va después de la comparación entre niveles, no dentro del bucle por nivel. Así `sin2m2014` (falta 2014 solo en 2m) conserva el mensaje de s35k («faltan años 2014, que tiene el nivel 4b»), como pide el criterio («el mismo resultado que en s35k»), y la regla nueva solo dispara cuando los dos niveles empiezan tarde.
- D2-b (riesgo bajo): los años faltantes se cuentan desde `ANIO_INICIO` hasta el primer año presente, sin `ANIOS_SIN_SIMCE` (misma forma que la regla del hueco). El caso adicional `sin2014a2018ambos` lo muestra.

**Errores propios:** la hora de inicio de esta sección se escribió primero como 18:46 sin medirla; el reloj dio 18:45:33 al correr los casos, y se corrigió a 18:45 antes de cerrar la sección.

**Dudas:** ninguna.

### FASE L3: los años sin Simce en un solo lugar y los textos sin rango fijo (Q-75)

Inicio: 18:48. ALCANCE: `10_utils/10_configuracion.R`, `30_procesamiento/31_leer_normalizar.R`, `30_procesamiento/33_generar_html.R`, `README.md`, `50_documentacion/activa/manifiesto_insumos.md`, `50_documentacion/activa/50_datos_versionados_autorizados.md`, `50_documentacion/suite/documentar.R`.

**Medición previa** (`git grep -n "2014–2025\|2014 a 2025\|2014-2025"` con las exclusiones del criterio; `$TMPDIR/cal_s35l/l3_grep_antes.txt`). Un primer intento excluyó `50_documentacion/activa/traspasos`, que no existe: los traspasos están en `50_documentacion/traspasos/` (ver errores propios). Con la ruta correcta: **16 coincidencias**. Dentro del ALCANCE, 5: `50_datos_versionados_autorizados.md:24`, `manifiesto_insumos.md:10` y `documentar.R:58`, `:275` y `:324`. Fuera del ALCANCE, **11, no 9**: las nueve que declara el encargo más dos que no lista, `50_documentacion/suite/arquitectura_general_slep_simce_adecuado_standalone.html:349` y `50_documentacion/suite/arquitectura_slep_simce_adecuado_standalone.html:342`. Las dos son HTML standalone de la suite que regenera `documentar.R` (§11 excluye regenerarla); la segunda trae «Cobertura 2014–2025 (sin 2019–2021)», el texto de `documentar.R:58`. Como pide el criterio, la diferencia se registra y esos archivos no se editan.

**Criterio pre-registrado**
esperado: `ANIO_INICIO` y `ANIOS_SIN_SIMCE` definidos solo en `10_utils/10_configuracion.R`; ningún otro literal `2019L, 2020L, 2021L` en el código (`grep`); `meta$anios_sin_simce` sigue en 2019, 2020 y 2021 (I-4); el `git grep` de rango, fuera de logs, traspasos, encargos y decisiones, con solo las filas de inventario declaradas más las once de fuera del ALCANCE; `parse()` de `documentar.R` con código 0; build y batería en PASA
**Cambios:**
- `10_utils/10_configuracion.R`: `ANIO_INICIO <- 2014L` y `ANIOS_SIN_SIMCE <- c(2019L, 2020L, 2021L)` (L32-33), con su comentario de origen (D35-19; los motivos de 2019 a 2021 del manifiesto; quién las usa; desde cuándo viven ahí). El encabezado del archivo las nombra.
- `31_leer_normalizar.R`: sin las dos definiciones; el comentario dice que son «las dos constantes de 10_utils/10_configuracion.R». El paso las recibe porque carga `10_configuracion.R` en su L42, antes de usarlas.
- `33_generar_html.R`: `anios_sin_simce = ANIOS_SIN_SIMCE` (con un comentario de origen) en vez del literal; el paso también carga `10_configuracion.R` (L31).
- `manifiesto_insumos.md` L10: «(hoy, todos los años 2014–2025)» → «(hoy, todos los años de la serie: desde 2014, sin 2019 a 2021, hasta el último año cargado en `20_insumos/simce/`)».
- `50_datos_versionados_autorizados.md` L25 y L26: «publicados por la Agencia, 2014-2018 y 2022-2025» → «publicados por la Agencia, desde 2014, sin 2019 a 2021, hasta el ultimo anio cargado» (el archivo se escribe sin tildes).
- `documentar.R`, solo los seis literales de rango: L58 «Cobertura» → «desde 2014 (sin 2019–2021) hasta el último año cargado»; L98 y L100 «2014–2018, 2022–2025» → «desde 2014, sin 2019–2021, hasta el último año cargado»; L275 «Entra: planillas Simce 2014–2025» → «Entra: planillas Simce desde 2014»; L305 «(2014–2018 y 2022–2025)» → «(desde 2014, sin 2019 a 2021, hasta el último año cargado)»; L324 «2014 a 2025, sin 2019, 2020 ni 2021 (años sin Simce).» → «Desde 2014, sin 2019, 2020 ni 2021 (años sin Simce), hasta el último año cargado en 20_insumos/simce/.». No se corrió.

obtenido:
- Literales: `git grep -n "2019L"` sobre `*.R`, `*.Rmd`, `*.qmd`, `*.html`, `*.js` y `*.jsx`: **una línea**, `10_utils/10_configuracion.R:33` (la definición). `git grep -n "c(2019" -- "*.R"`: la misma. `grep -rn 2019L --include=*.R` sobre el árbol (sin `_archivo` ni `renv`): la misma. Definiciones (`git grep "ANIO_INICIO *<-\|ANIOS_SIN_SIMCE *<-"`): solo `10_configuracion.R:32` y `:33` en el código; las otras dos coincidencias son citas en el encargo y en el log de s35k.
- `Rscript -e 'invisible(parse("50_documentacion/suite/documentar.R"))'`: codigo_parse=0.
- `git grep` de rango (`l3_grep_despues.txt`): **12 líneas**, 16 antes. Las cinco del ALCANCE bajan a una, que queda como **fila de inventario declarada**: `50_documentacion/activa/50_datos_versionados_autorizados.md:24` («tabla comparativa de variables 2014-2025»), que describe los dos CSV de glosas, cuyo nombre lleva `2014_2025` (`glosas_simce_resumen_cambios_simce_rbd_2014_2025.csv` y `glosas_simce_tabla_comparativa_simce_rbd_2014_2025.csv`). Las otras 11 son las de fuera del ALCANCE de la medición previa, sin editar: las nueve del encargo (`docs/index.html:1370`, `docs/trayectorias.html:431` y `:565`, `mockup_trayectoria_traspasos.html:288`, `prototipo_design/app.jsx:52` y `main.jsx:200`, `documentacion_general_slep_simce_adecuado_standalone.html:367`, `20260924_contexto_referente_trayectorias.html:60`, `50_revision_safari_trayectorias.md:38`) y las dos que no lista (`arquitectura_general_slep_simce_adecuado_standalone.html:349`, `arquitectura_slep_simce_adecuado_standalone.html:342`).
- Otras filas de inventario del ALCANCE, que el `git grep` no ve y no se reescriben (describen lo que hay hoy): `README.md:134` (columna `anio` del esquema de `simce_rbd.parquet`, «2014–2018, 2022–2025») y las tablas por año de `manifiesto_insumos.md` (L25-34, 2° medio, y L39-48, 4° básico).
- Build (`l3_build.txt`, 18:49:09): codigo_build=0, «Fallas criticas: 0 | Advertencias: 7», «OK: 18 archivos detectados (9 por nivel), años 2014, …, 2025.». Motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3, `cmp` contra `docs/` 0 y 0; `h6_diff.R`: «idéntico: TRUE», «identical: TRUE». `meta$anios_sin_simce` (`l3_meta.R`): «2019 2020 2021», texto JSON `"anios_sin_simce":[2019,2020,2021]`, igual al de `docs/index.html`. I-3: codigo_i3=0, «JSON idéntico a la línea base». Batería: codigo_bateria=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan» (a las 18:49:40). **Cumple.**

Un intento de leer `meta$anios_sin_simce` con `Rscript -e` falló por el escapado de la expresión regular en la línea de comandos («'\.' is an unrecognized escape»); se repitió con el guion `l3_meta.R`. No es del producto.

**Commit** `refactor(config): años sin Simce en un solo lugar y textos sin rango fijo (Q-75)`: `6efefc5`, padre `29947ce`; `--numstat`: `10_configuracion.R` 14 3, `31_leer_normalizar.R` 4 5, `33_generar_html.R` 2 1, `50_datos_versionados_autorizados.md` 2 2, `manifiesto_insumos.md` 2 1, `documentar.R` 6 6; `git status --porcelain` = solo este log. `README.md` está en el ALCANCE, pero no cambia: su única línea con el rango es de inventario.

**Estado:** completa, en el primer intento. **Alcance:** 6 de los 7 archivos del ALCANCE. **Regresión:** build, I-3, I-4 y batería (arriba). **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D3-a (riesgo bajo): `README.md:134` y las tablas por año del manifiesto quedan como inventario, como pide el encargo («se actualizan cuando llegue un archivo»). `50_datos_versionados_autorizados.md:24` también, porque el rango es parte del nombre de los dos CSV que describe.
- D3-b (riesgo bajo): `50_datos_versionados_autorizados.md` L25 y L26 («2014-2018 y 2022-2025») se reescriben. §2 las lista entre los textos con el rango fijo, y describen la serie de los xlsx, no un archivo con nombre fijo. El `git grep` del criterio no las ve, porque su forma es otra.
- D3-c (riesgo bajo): en `documentar.R` se cambiaron solo los seis literales de rango. Quedan cuatro textos que llaman «preliminar» al 2025 (L100, L240, L305 y L324), cuando la base de 2025 es final desde v22025 (manifiesto L14-16). No son literales de rango y el encargo no los incluye: van como ADVIERTE en FASE R.

**Errores propios:**
- Hora de inicio escrita sin medir, otra vez (18:49; el reloj daba 18:48:20). Se corrigió antes de cerrar la sección. Desde ahí, cada hora sale de `date` en el mismo comando.
- El primer `git grep` de la medición previa excluyó `50_documentacion/activa/traspasos`, que no existe (los traspasos están en `50_documentacion/traspasos/`), y listó siete líneas de traspasos archivados. Se repitió con la ruta correcta antes de contar. El conteo registrado (16) es el de la ruta correcta.
- Un bloque `bash -c '…'` con comillas simples dentro del texto del log no corrió: zsh lo rechazó entero («bad pattern») y no escribió nada (se comprobó con `tail` y `git status`). Se repitió con un heredoc directo.
- Un `Rscript -e` con una expresión regular escapada falló («'\.' is an unrecognized escape»); se pasó a un guion.

**Dudas:** ninguna.

### FASE L4: el año inicial de la vista sale de los datos (R-41)

Inicio: 18:50:59 (`date` del comando que cerró L3). ALCANCE: `30_procesamiento/36_trayectorias_template.html`, `30_procesamiento/36_generar_trayectorias.R`, `10_utils/10_html.R`.

Medición previa (`grep -n` en la plantilla): L425 `<div class="gapb" id="gapb">2019, 2020 y 2021 no tienen medición Simce</div>`; L433 `<div class="yr" id="yr">2014</div>`. El script de la vista solo alterna la clase `on` de `#gapb` (L652) y reescribe `#yr` al dibujar (L1066). Otros textos de la plantilla con años sin Simce, fuera de lo que pide L4: L462 («No existe Simce 2019, 2020 ni 2021.», en las notas) y L1032 (`'2019 a 2021, sin medición'`, en el script de la pista). Se registran en FASE R y no se tocan.

**Criterio pre-registrado**
esperado: I-4 (la vista con el md5 de `docs/trayectorias.html`, 883f76bc…; el motor igual a `docs/index.html`); en la plantilla, `grep -n '>2014<'` y `grep -n '2019, 2020 y 2021'` con 0 líneas; un marcador sin sustituir detiene el build (control: el marcador nuevo mal escrito en una copia, con `00_build.R` completo, código 1 y el nombre del marcador en el mensaje)
**Cambios:**
- `36_trayectorias_template.html`: L433 `<div class="yr" id="yr">2014</div>` → `__ANIO_MIN__`; L425 `2019, 2020 y 2021 no tienen medición Simce` → `__ANIO_SIN_SIMCE__ no tienen medición Simce`.
- `10_utils/10_html.R`: constante `MARCADOR_ANIOS_SIN_SIMCE <- "__ANIO_SIN_SIMCE__"`, con el prefijo `__ANIO_` para que `PATRON_ANIO_RESTO` detenga también una versión mal escrita; función `enumerar_anios()` («2019», «2019 y 2020», «2019, 2020 y 2021»); `sustituir_anios(texto, anios, anios_sin_simce = NULL)`: con el tercer argumento, exige el marcador y lo reemplaza con los años enumerados. Sin él (el motor), el comportamiento es el de K3, y el patrón de resto detiene el marcador si apareciera. El encabezado del archivo lo nombra.
- `36_generar_trayectorias.R`: `sustituir_anios(html_tray, DATA_TRAY$anios, ANIOS_SIN_SIMCE)`. El `2014` de la pista lo cubre la misma llamada, que ya existía desde K3 y reemplaza todas las apariciones de `__ANIO_MIN__`. Comentarios del flujo (paso 3) y del `source()` de `10_configuracion.R` puestos al día.

obtenido:
- Build (`cal_s35l/l4/build.txt`, 18:52:23): codigo_build=0, «Fallas criticas: 0 | Advertencias: 7». Motor 42ab93003e722f9bb6c725fec2d348bd y **vista 883f76bcefc89d93f2d1e753fc4d75c3**; `cmp` contra `docs/`, 0 y 0 (**I-4: iguales byte a byte**). En la vista escrita: `<div class="gapb" id="gapb">2019, 2020 y 2021 no tienen medición Simce</div>` y `<div class="yr" id="yr">2014</div>`; `grep -c '__ANIO_'` = 0 en las dos salidas.
- Plantilla: `grep -n '>2014<'`, código 1 y **0 líneas**; `grep -n '2019, 2020 y 2021'`, código 1 y **0 líneas**.
- Prueba unitaria (`cal_s35l/l4/unidad.R`): **9 de 9** (enumeración de 1, 2 y 3 años; la vista con los tres marcadores; el motor sin el argumento, igual que antes; el marcador en una página sin el argumento → «Quedaron marcadores de años sin sustituir: __ANIO_SIN_SIMCE__»; el argumento sin el marcador → «La página no trae el marcador __ANIO_SIN_SIMCE__»; mal escrito → «… __ANIO_SIN_SIMCE_»; sin años → «No hay años sin Simce para sustituir __ANIO_SIN_SIMCE__»).
- **Controles con el build completo** en copias (`cal_s35l/l4_controles.sh`; copia, un cambio de una línea con `perl`, `Rscript 00_build.R`; salidas en `cal_s35l/l4ctl/`; 18:53:11 a 18:53:35). **Disparan los tres**, código 1:
  - `yr_malescrito` (`id="yr">__ANIO_MN__<`): «Error en sustituir_anios(html_tray, DATA_TRAY$anios, ANIOS_SIN_SIMCE): Quedaron marcadores de años sin sustituir: __ANIO_MN__»;
  - `sinsimce_malescrito` (`__ANIO_SIN_SIMCE_ no tienen`): «… La página no trae el marcador __ANIO_SIN_SIMCE__»;
  - `sinsimce_extra` (el correcto más un `__ANIO_SIN_SIMCE` de sobra): «… Quedaron marcadores de años sin sustituir: __ANIO_SIN_SIMCE».
  En las tres copias, la vista de `40_salidas/` conserva la hora de la copia (18:52:31): el build detenido no la reescribió. Las salidas del árbol siguen en 42ab9300… y 883f76bc….
- I-3: codigo_i3=0, «JSON idéntico a la línea base». Batería: codigo_bateria=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan» (18:52:51). **Cumple.**

**Commit** `fix(trayectorias): el año inicial de la vista sale de los datos (R-41)`: `e41ee1e`, padre `6efefc5`; `--numstat`: `10_html.R` 30 7, `36_generar_trayectorias.R` 8 5, `36_trayectorias_template.html` 2 2; `git status --porcelain` = solo este log (18:54:00).

**Estado:** completa, en el primer intento. **Alcance:** los tres archivos del ALCANCE. **Regresión:** build, I-3, I-4 y batería (arriba). **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D4-a (riesgo bajo): el marcador de años sin Simce se llama `__ANIO_SIN_SIMCE__`, con el prefijo de K3, y lo sustituye la misma `sustituir_anios()` con un argumento opcional, en vez de otra función. Así un marcador mal escrito lo detiene el mismo patrón de resto (`__ANIO_[A-Za-z_]*`), y el motor, que no pasa el argumento, sigue igual.
- D4-b (riesgo bajo): la enumeración («a, b y c») es una función propia (`enumerar_anios()`) y no un literal, así que un cambio de `ANIOS_SIN_SIMCE` cambia el texto sin editar la plantilla. Con un solo año, el texto diría «2019 no tienen medición Simce»: la concordancia del verbo queda en la plantilla, fuera de lo que se pidió.
- D4-c (riesgo bajo): L462 (notas: «No existe Simce 2019, 2020 ni 2021.») y L1032 (script de la pista: `'2019 a 2021, sin medición'`) también traen los años sin Simce como texto, pero L4 pide solo L425 y el `grep` del criterio no los ve. No se tocan: van como ADVIERTE en FASE R.

**Errores propios:** ninguno. **Dudas:** ninguna.

### FASE L5: batería versionada del motor

Inicio: 18:58:17 (`date` del comando que abrió esta sección). ALCANCE: `30_procesamiento/33_verificar_motor.R` (nuevo).

**Diseño** (antes de escribirla). Estructura de `36_verificar_trayectorias.R`: `comprobar(id, descripcion, condicion, detalle)`, una línea por prueba, «Resultado: N pruebas…» y código 1 si alguna falla; guarda de locale (`10_configuracion.R`), `here::here()`, sin rutas absolutas y sin escribir en el árbol. Lee `40_salidas/motor_comparacion.html`, o la ruta que reciba como primer argumento; ese argumento sirve para las salidas saboteadas de la calibración. Cada prueba pasa solo si el motor cumple su regla **y** su control positivo, medido con el mismo instrumento, da FALLA. El detalle de la línea muestra las dos cosas. Los controles son un valor plantado (M1 a M3), un defecto plantado en la página abierta (M4 a M6) o un HTML de control en `tempdir()`, que se borra al leerlo (M7 y M8). Criterios y medidores, de los logs:
- M1: el patrón de I-2 de s35h (`src=["']?(https?:)?//` y `url(http`), 0 en la salida;
- M2: los marcadores `__…__` de `33_motor_template.html` y `33_fragmento_sitio.html` (hoy 12) y `PATRON_ANIO_RESTO` y `PATRON_SITIO_RESTO` de `10_html.R`, leídos de las fuentes, 0 en la salida;
- M3: `meta$anios` del JSON = años de los nombres de `20_insumos/simce/{2m,4b}/*.xlsx`, sin `ANIOS_SIN_SIMCE`;
- M4: `scrollWidth` del documento = ancho de la ventana (barras ocultas, como `verificar_navegador.R`) en `#comparacion` y `#panorama` a 375, 768 y 1280 px (I-8 de s35h);
- M5: el medidor de M1 de s35h a 375 × 740: por pestaña, clic real en su centro tras `scrollIntoView`, 0 elementos del modal con su caja visible fuera de la ventana, la pestaña activa y el pie («Cancelar» y «Agregar…») dentro del modal y de la ventana;
- M6: el medidor de M5 de s35i: 5 territorios (los 4 iniciales más el primero habilitado de la pestaña «SLEP»), una carga a 375 px y cambios de ancho a 641, 670 y 700; 0 textos del supergrid con una caja de línea fuera de su celda (tolerancia 0,01 px);
- M7: el medidor de G3 de s35g a 375 × 740: los 12 casos (6 elementos, en hover y en clic); el tooltip dentro de la ventana (margen de `TOOLTIP_DIMS`, leído de la salida) y el punto fuera del tooltip agrandado 4 px;
- M8: el medidor de M4 de s35h en `#comparacion` a 1280 × 900: exportación PNG del supergrid; la tinta del nombre más largo y la del título, medidas en el PNG, coinciden con gobCL-sitio (±2 px de PNG) y no con `system-ui`.

**Criterio pre-registrado**
esperado: las 8 pruebas en PASA sobre el build actual, código 0; cada control positivo da FALLA (salida literal en el detalle); la batería completa contra una salida saboteada por prueba (en `$TMPDIR/cal_s35l/l5/`) da FALLA en la prueba que corresponde; el tiempo total queda anotado. Sabotajes previstos: M1, una regla CSS con `url(http://…)`; M2, `__ANIO_MAX__` en el subtítulo; M3, `meta$anios` sin su último año; M4, sin `.supergrid { overflow-x: auto; }`; M5, sin `min-width: 0; width: 100%` en el `.modal` del `@media (max-width: 640px)`, que devuelve el `min-width: 540px` (el ejemplo del encargo); M6, el corte de 670 px devuelto a 640 (Q-66); M7, `if (!cabeDer && !cabeIzq) {` → `if (false) {` (sin la regla de G3); M8, `new Blob([svgConFuenteSitio(svgStr)]` → `new Blob([svgStr]` (sin la fuente incrustada)
**Intento 1** (`corrida1.txt`, 19:01:32 a 19:02:43): codigo_motor=1; 7 de 8 en PASA, **M7 en FALLA**: «12 casos, con acierto 10, tooltip visible 10 … tapan 0». Diagnóstico (`cal_s35l/l5/diag_m7.R`, las funciones de la batería más una tabla por caso): los dos casos sin acierto son `barra_abajo_ult` (hover y clic), con el elemento en x = 488,7 en una ventana de 375 px y `elementFromPoint` nulo. Desde M2 de s35h, bajo 670 px el supergrid se desplaza en horizontal dentro de sí mismo (`scrollLeft` 0 de 484/295). El modo «abajo» de G3 solo desplazaba la página en vertical, así que la última columna quedaba fuera de la vista. En s35g el supergrid no se desplazaba y el caso era alcanzable. Es un defecto del instrumento, no del motor. Intento 1 guardado en `cal_s35l/l5/intento1_33_verificar_motor.R` (md5 0d0b4ccf586f6ed8caedc9b97aadf434). **Intento 2:** en el modo «abajo», `celda.scrollIntoView({ block: 'nearest', inline: 'nearest' })` antes del desplazamiento vertical (el modo «centro» ya lo hacía con su `scrollIntoView`), con un comentario que dice por qué.

obtenido (criterio, intento 2; `Rscript 30_procesamiento/33_verificar_motor.R`, `corrida2.txt`, 19:03:36 a 19:04:46): codigo_motor=0; «**Resultado: 8 pruebas, 8 pasan, 0 fallan (en 70 segundos)**». Líneas literales, con el control positivo de cada una:
```text
M1     PASA  El motor no carga nada por red (src=//: 0, url(http: 0; control con un <script src="https://…"> y un url(http://…) plantados: 1 y 1, FALLA, detectado)
M2     PASA  Ningún marcador del proyecto queda sin sustituir (lista leída de la plantilla, el fragmento y 10_html.R) (12 marcadores de las fuentes y 2 patrones de resto; en el motor: ninguno; control con __JSON_DATA__, __ANIO_MIN_ y __HREF_X__ plantados: FALLA, detectados __JSON_DATA__, PATRON_ANIO_RESTO, PATRON_SITIO_RESTO; ajenos presentes, fuera de la lista: __PURE__ 397, __REACT_DEVTOOLS_GLOBAL_HOOK__ 2)
M3     PASA  meta$anios es la lista de años de los nombres de archivo de 20_insumos/simce/, sin ANIOS_SIN_SIMCE (18 xlsx, años 2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025; meta$anios 2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025; control con 2019 agregado y con el último quitado: FALLA, detectado)
M4     PASA  Sin desborde horizontal en #comparacion y #panorama a 375, 768 y 1280 px (scrollWidth del documento = ancho de la ventana) (comparacion 375: 375/375; comparacion 768: 768/768; comparacion 1280: 1280/1280; panorama 375: 375/375; panorama 768: 768/768; panorama 1280: 1280/1280; control con un bloque de 3000 px plantado (comparacion 375): 3000/375, FALLA, detectado)
M5     PASA  El modal «Agregar territorio» cabe en la ventana a 375 px en sus 6 pestañas (pestañas activas tras el clic 6/6; elementos fuera de la ventana 0/0/0/0/0/0; pie visible 6/6; modal de 20.00 a 355.00 px; control con min-width 540px plantado: 48 elementos fuera, FALLA, detectado)
M6     PASA  Con 5 territorios, ningún texto del supergrid sale de su celda a 375, 641, 670 y 700 px (375 px: 5 territorios, 0 de 82 textos fuera; 641 px: 5 territorios, 0 de 82 textos fuera; 670 px: 5 territorios, 0 de 82 textos fuera; 700 px: 5 territorios, 0 de 82 textos fuera; territorios CONCÓN | PUCHUNCAVÍ | QUINTERO | VIÑA DEL MAR | SLEP Aconcagua; control sin ancho mínimo de columna a 641 px: 1 textos fuera (PUCHUNCAVÍ (+5.06)), FALLA, detectado)
M7     PASA  A 375 px, el tooltip no tapa el punto en los 12 casos de G3 y queda dentro de la ventana (margen de TOOLTIP_DIMS 8; 12 casos, con acierto 12, tooltip visible 12, desfijado tras el clic 12, dentro 12, tapan 0; control sin la regla de G3 (if (!cabeDer && !cabeIzq) { → if (false) {), barra_pri: tapan 2 de 2, FALLA, detectado)
M8     PASA  El PNG exportado del supergrid usa gobCL-sitio (tinta del nombre más largo y del título) (nombre «VIÑA DEL MAR»: PNG 177, gobCL-sitio 177, system-ui 205; titulo «Motor Simce — Adecuado · Lectura · 4° Básico»: PNG 705, gobCL-sitio 705, system-ui 801; control sin la fuente incrustada (new Blob([svgStr]): nombre «VIÑA DEL MAR»: PNG 205, gobCL-sitio 177, system-ui 205; titulo «Motor Simce — Adecuado · Lectura · 4° Básico»: PNG 801, gobCL-sitio 705, system-ui 801, FALLA, detectado)
```
Coincidencias con los logs de origen: los anchos de tinta de M8 son los de M4 de s35h (177/177/205 y 705/705/801); el modal de 20 a 355 px, el de M1 de s35h; PUCHUNCAVÍ es el nombre que salía de su celda en M5 de s35i; el control de M7 tapa en `barra_pri` hover y clic, los dos casos de la calibración de G3 de s35g.

**Calibración contra salidas saboteadas** (`cal_s35l/l5/sabotear.R`: ocho copias de `40_salidas/motor_comparacion.html` en `cal_s35l/l5/sabotaje/`, cada una con un fragmento que aparecía una sola vez cambiado; `diff` contra la salida: **una línea distinta en cada una**; en M3, `verificar_contenido_motor.R` sobre la copia da «JSON difiere: $meta$anios (largo 8 vs 9)»). La batería completa contra cada copia (19:05:39 a 19:14:58):

| sabotaje | cambio | código | pruebas en FALLA | línea en FALLA (extracto literal) |
|---|---|---|---|---|
| M1 | `<style>…url(http://example.invalid/x.png)…</style>` antes de `</head>` | 1 | **solo M1** (7 pasan) | «src=//: 0, url(http: 1» |
| M2 | «Datos 2014–2025» → «Datos 2014–\_\_ANIO_MAX\_\_» | 1 | **solo M2** | «en el motor: \_\_ANIO_MAX\_\_, PATRON_ANIO_RESTO» |
| M3 | `meta$anios` sin 2025 (JSON recomprimido) | 1 | **solo M3** | «meta$anios 2014, …, 2024» |
| M4 | `.supergrid { overflow-x: auto; }` → `.supergrid { }` | 1 | **solo M4** | «comparacion 375: 524/375» |
| M5 | `.modal { min-width: 0; width: 100%; }` → `.modal { }` (vuelve el `min-width: 540px`) | 1 | **solo M5** | «pestañas activas tras el clic 5/6; elementos fuera de la ventana 19/26/50/51/22/22; pie visible 0/6; modal de -82.50 a 457.50 px» |
| M6 | `@media (max-width: 670px)` → `640px` | 1 | **solo M6** | «641 px: 5 territorios, 1 de 82 textos fuera [PUCHUNCAVÍ (+5.06)]» |
| M7 | `if (!cabeDer && !cabeIzq) {` → `if (false) {` | 1 | **solo M7** | «tapan 4 [spark_pri hover, spark_pri clic, barra_pri hover, barra_pri clic]» |
| M8 | `new Blob([svgConFuenteSitio(svgStr)]` → `new Blob([svgStr]` | 1 | **solo M8** | «nombre «VIÑA DEL MAR»: PNG 205, gobCL-sitio 177, system-ui 205; titulo …: PNG 801, gobCL-sitio 705, system-ui 801» |

En M7 y M8 saboteadas, el control de la propia prueba da «error: el fragmento a cambiar no aparece una sola vez en el motor», porque el sabotaje ya quitó ese fragmento. La prueba falla antes por la medición real, que es lo que se calibra. Los tiempos de las ocho corridas: 70, 70, 70, 70, 69, 70, 63 y 67 s.

Otras comprobaciones: `grep -n "/Users\|/var/folders\|/private"` en la batería, código 1 (sin rutas absolutas); su única escritura es `writeBin` del HTML de control en `tempfile()` (L149), que `con_control()` borra al terminar; `git status --porcelain` tras las diez corridas = la batería nueva y este log. `parse()` de la batería, sin error. 709 líneas; md5 a9846770f79ebedec18df03181b6c870. **Tiempo total de la batería sobre el build actual: 70 segundos.** **Cumple.**

**Commit** `test(motor): bateria versionada del motor con control positivo`: `611852a`, padre `e41ee1e`; `A 30_procesamiento/33_verificar_motor.R` (`--numstat` 709 0); `git status --porcelain` = solo este log (19:15:44).

**Estado:** completa, en el segundo de 3 intentos. **Alcance:** la batería nueva. **Regresión:** la batería de la vista no se corrió de nuevo en L5, porque L5 no cambia código del pipeline; corre en FASE R. **Subagentes:** 0. **Bugs:** 1, del instrumento (el caso `barra_abajo_ult` fuera de la vista), corregido en el intento 2.

**Decisiones autónomas:**
- D5-a (riesgo bajo): M5 mide el modal y no el `scrollWidth` del documento, que el criterio de M1 de s35h también incluía: el desborde del documento a 375 px ya lo mide M4. Así cada sabotaje hace fallar solo su prueba, y la tabla lo muestra.
- D5-b (riesgo bajo): M6 carga una vez a 375 px y cambia el ancho a 641, 670 y 700. Es el modo «barrido» de M5 de s35i, que allí se validó contra cargas nuevas (mismos valores en 11 anchos). M4, en cambio, carga una página por ancho, como `i8.R` de s35h.
- D5-c (riesgo bajo): los controles de M4 a M6 se plantan en la página ya abierta (un bloque de 3000 px, el `min-width` de 540 px, `--supergrid-col-min: 0px`); los de M7 y M8 necesitan otro código, así que son HTML de control en `tempdir()`. El encargo admite las dos formas («un HTML de control en `tempdir()` o un valor plantado»).
- D5-d (riesgo bajo): el margen del tooltip se lee de `TOOLTIP_DIMS` en la salida y no se copia como literal. Si el motor lo cambia, la prueba lo sigue; si no lo encuentra, M7 falla.
- D5-e (riesgo bajo): M8 mide el PNG del supergrid en `#comparacion` (lo que pide el encargo), con las dos referencias de M4 de s35h (nombre y título); el PNG del panorama no se incluye.
- D5-f (riesgo bajo): M1 es estático (los dos patrones de I-2 sobre el texto), como pide el encargo; no registra las solicitudes de red del navegador.

**Errores propios:** la hora de inicio de esta sección se escribió antes de leer `date` (18:55; el reloj dio 18:58:17) y se corrigió antes de seguir. Es la tercera vez en la sesión (ver L2 y L3).

**Dudas:** ninguna.

### FASE L6: CLAUDE.md local (D35-20)

ALCANCE: `CLAUDE.md` (ignorado; sin commit; autorización 5). Antes: `ls CLAUDE.md`, «No such file or directory»; `git check-ignore -v CLAUDE.md` = `.gitignore:49:CLAUDE.md`. Contenido pedido por el encargo (§7, L6.1), más la estructura mínima que la regla global del titular pide a todo CLAUDE.md (descripción, stack, estructura, convenciones, últimos cambios, máximo 5). Cada afirmación se comprobó antes de escribirla (`00_build.R`, `git log`, `ls 30_procesamiento/`, las decisiones A34-1, A34-3 y D35-14 en el archivo de decisiones y en logs anteriores).

**Criterio pre-registrado**
esperado: `git check-ignore -v CLAUDE.md` lo muestra ignorado por `.gitignore:49`; `git status --porcelain` no lo lista; `wc -l` ≤ 80
obtenido: `git check-ignore -v CLAUDE.md` = `.gitignore:49:CLAUDE.md	CLAUDE.md` (ci_codigo=0); `git status --porcelain` = solo `?? …/20260926_verificaciones_s35l2_log.md` (CLAUDE.md no aparece; con `--ignored`, `!! CLAUDE.md`); `wc -l` = **69**; md5 1f36ec57acd5f4460ca69c8a262fcf54. Secciones: qué es; dónde viven las reglas y que mandan sobre él (POLITICA, SETTINGS, el instrumento `encargo_autonomo_claude_code_v1.md`, decisiones y logs); stack; estructura; convenciones (R único lenguaje de los entregables, R moderno, `here::here()`, nunca rutas absolutas, constantes nombradas, `docs/` solo por copia íntegra, agregación por `cod_com_rbd`, tope de 5 territorios (D35-14), la regla de `!`); pruebas (build y las dos baterías, más `verificar_contenido_motor.R`); trampas (A34-1, A34-3, zsh sin `PIPESTATUS`); últimos cambios (5, de s35g a s35l). **Cumple.**

**Estado:** completa, en el primer intento. **Commits:** ninguno (el archivo está ignorado). **Alcance:** `CLAUDE.md`. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:** D6-a (riesgo bajo): además de lo que pide el encargo, CLAUDE.md sigue la estructura mínima de la regla global del titular (stack, estructura, últimos cambios). Los «últimos cambios» salen de los mensajes de commit de `git log` de s35g a s35l. El instrumento se nombra sin ruta, porque vive en el kit de gobernanza y no en el repositorio (`find` en el árbol: no está). D6-b (riesgo bajo): el orden fijo del encargo pone L6 al final, aunque la regla global pide crear CLAUDE.md «antes de empezar cualquier tarea»; manda el encargo, que D35-20 decidió así.

**Errores propios:** ninguno. **Dudas:** ninguna.

### FASE R: auditoría y reparación

**R.1 Inventario de afirmaciones auditables** (armado desde las secciones anteriores de este log, antes de auditar; cada una se re-deriva en R.2 con un comando distinto del que la produjo)

| id | afirmación (fase) |
|---|---|
| R-01 | H1: el árbol con las tres rutas de T0 más el log; `git ls-files 30_procesamiento \| grep verificar` = solo `36_verificar_trayectorias.R` (FASE 0) |
| R-02 | H2: stash 0; un solo worktree (FASE 0) |
| R-03 | H3: `HEAD` 349f22d y `origin/main` 10672ea; I-1 de partida; I-5 de partida (lock e6323bf2…, settings d0bcb98d…, 58 paquetes iguales a s35j) (FASE 0) |
| R-04 | H4: md5 del encargo 55b3d232…; `docs/` 42ab9300… y 883f76bc…; T0 = b452b0a, padre 349f22d, con las tres rutas (FASE 0) |
| R-05 | H5: batería de la vista 35 de 35 (FASE 0) |
| R-06 | H6: build con 0 críticas y 7 advertencias; salidas iguales byte a byte a `docs/`; JSON sin la fecha idéntico (FASE 0) |
| R-07 | Calibración de `verificar_contenido_motor.R` sobre `base_s35l`: «idéntico» y, con 3.5 → 3.6, «difiere» (FASE 0) |
| R-08 | Paso 8: `sin2014ambos` pasa con el código de T0; los 9 casos de K3 como la columna «después» de s35k (FASE 0) |
| R-09 | L1: clon en b452b0a; biblioteca con 0 paquetes antes de abrir R (L1) |
| R-10 | L1: `restore()` código 0; 57 paquetes; 34 descargas de CRAN y 22 de Posit Package Manager, `sys` de `latest` y `stringi` de la instantánea 2026-08-04; rutas de `renv` en `$TMPDIR/s35l/` (L1) |
| R-11 | L1: `renv::status()` en el clon, «No issues found», `suitedoc` ignorado (L1) |
| R-12 | L1: build del clon con 0 críticas y salidas iguales byte a byte a `docs/`; batería 35 de 35 en el clon; el clon usa su propia biblioteca (L1) |
| R-13 | L1: I-5 del árbol sin cambio; sin escrituras en la biblioteca del árbol ni en el caché global (L1) |
| R-14 | L1: calibración: `openxlsx` retirado con `mv` → `status()` lo reporta; devuelto → «No issues found» (L1) |
| R-15 | L2: la regla de inicio va después de la comparación entre niveles; paso 31 con md5 0ce68bfe… (L2) |
| R-16 | L2: `sin2014ambos` se detiene con el nivel y el año que falta; los otros 9 casos, iguales a FASE 0; `sin2014a2018ambos` nombra 2014 a 2018 (L2) |
| R-17 | L2: I-4, I-3 y batería en PASA (L2) |
| R-18 | L2: commit 29947ce, padre b452b0a, un archivo 15/1 (L2) |
| R-19 | L3: `ANIO_INICIO` y `ANIOS_SIN_SIMCE` definidos solo en `10_configuracion.R` L32-33; ningún otro `2019L` en el código (L3) |
| R-20 | L3: `documentar.R` se analiza sin error (L3) |
| R-21 | L3: `git grep` de rango 16 → 12: 1 fila de inventario más 11 fuera del ALCANCE (las 9 del encargo más 2 standalone de la suite) (L3) |
| R-22 | L3: `meta$anios_sin_simce` = [2019,2020,2021]; I-4; I-3; batería (L3) |
| R-23 | L3: commit 6efefc5, padre 29947ce, 6 archivos (L3) |
| R-24 | L4: en la plantilla, 0 `>2014<` y 0 «2019, 2020 y 2021»; en la vista escrita, «2014» y «2019, 2020 y 2021 no tienen medición Simce»; 0 `__ANIO_` en las salidas; I-4 byte a byte (L4) |
| R-25 | L4: prueba unitaria 9 de 9; los tres controles con build completo se detienen y nombran el marcador (L4) |
| R-26 | L4: commit e41ee1e, padre 6efefc5, 3 archivos (L4) |
| R-27 | L5: batería del motor 8 de 8, código 0, 70 s; cada control positivo da FALLA (L5) |
| R-28 | L5: ocho salidas saboteadas, una línea distinta en cada una; la batería da FALLA solo en la prueba que corresponde (L5) |
| R-29 | L5: la batería no tiene rutas absolutas y solo escribe su HTML de control en `tempfile()` (L5) |
| R-30 | L5: commit 611852a, padre e41ee1e, 709 líneas (L5) |
| R-31 | L6: CLAUDE.md ignorado por `.gitignore:49`, fuera de `git status`, 69 líneas (L6) |
| R-32 a R-39 | I-1 a I-8 (§4) |
| R-40 | Alcance global: `git diff --name-only b452b0a..HEAD` dentro de la unión de los ALCANCE más el log; `git status` |
| R-41 | Identidad de lo publicado (`git hash-object` sobre `docs/` y `40_salidas/`) y ausencia de red (`grep -c 'http'`, revisado a mano) |

**R.2 Re-derivación independiente** (sin subagentes; el orquestador, con otros comandos; scripts y salidas en `$TMPDIR/cal_s35l/fase_r/`: `rd_a.txt`, `rd_b_predictor.py`, `rd_c_l1.py`, `rd_d.py`, `rd_e_unidad.R`, `sabotear_r28.R`, `rd_red.py`)
esperado: cada afirmación del inventario se confirma o se refuta con un instrumento distinto del original
obtenido: **41 de 41 confirmadas**, 0 refutadas:
- R-01: `git ls-tree -r --name-only b452b0a -- 30_procesamiento` con `verificar`: 1 línea (`36_verificar_trayectorias.R`); `git diff-tree` de b452b0a = las tres rutas de H1 (M, A, M); el encargo no existía en 349f22d (`cat-file -e`, código 128).
- R-02: `git rev-parse -q --verify refs/stash`, código 1; `.git/worktrees` no existe (código 1).
- R-03: `git rev-parse b452b0a^` = 349f22de…; 10672ea es ancestro de 349f22d y su padre (`merge-base --is-ancestor`, 0). I-5 de partida: `rd_c_l1.py` lee la biblioteca en Python (nombre, `Version`, destino): igual a `i5_fase0.txt`.
- R-04: `openssl dgst -md5`: encargo 55b3d232…, también desde `git show b452b0a:` (el commit guarda el encargo verificado); `docs/` 42ab9300… y 883f76bc…. Commits por `git diff-tree --numstat` y padres (abajo).
- R-05, R-17, R-22, R-27: regresión de R.5.
- R-06, R-12, R-41: `git hash-object`: `docs/index.html` = `40_salidas/motor_comparacion.html` = base de H6 = salida del clon = `HEAD:docs/index.html` = `origin/main:docs/index.html` = 2554f9a2…; la vista, en los cinco lugares, 7cbbdb75…. `git diff --quiet b452b0a HEAD -- docs/`, código 0.
- R-07: R.6 (otra cifra alterada).
- R-08, R-16: `rd_b_predictor.py` reimplementa en Python las reglas del paso 31 de T0 y de L2 sobre el listado real de cada copia: **21 de 21 coinciden** en código y mensaje, y cada copia corrió el paso 31 que dice (md5 del de b452b0a, b1840bdf…, en las «antes», y del de 29947ce, 0ce68bfe…, en las «después»). El primer intento dio 19 de 21: `os.listdir` no ordena y el paso 31 (`fs::dir_ls`) sí, lo que cambiaba el orden de los archivos en el mensaje de `dup2m2025`; se ordenó y se repitió (error del instrumento).
- R-09 a R-14 (`rd_c_l1.py`, en Python, sin R ni `renv`): `HEAD` del clon b452b0a6…; lock 57 y biblioteca del clon 57, sin ausentes, sin sobrantes ni versiones distintas; `Repository` de cada `DESCRIPTION`: **RSPM 22** (arrow, bit64, clipr, cpp11, dplyr, glue, here, hms, magrittr, openxlsx, pillar, purrr, readr, readxl, stringi, stringr, sys, tibble, tidyr, vctrs, vroom, withr) y CRAN 35, igual a las 22 descargas de la traza que no son de CRAN; `stringi` y `sys` enlazan al caché de `$TMPDIR/s35l/renv_cache/`; la biblioteca del árbol, igual a FASE 0 en nombre, versión y destino; la batería del clon, 35 líneas PASA y 0 FALLA; la calibración, «- openxlsx» en el `status()` con el paquete retirado, «No issues found» con el paquete devuelto y `retirado/` vacío. Escrituras por `mtime` (`os.walk`) desde `marca_l1`: biblioteca del árbol 0; caché global de `renv` 4, todas **posteriores al fin de L1** (18:44:34): el registro `projects` a las 18:53:27 (los builds de las copias de control de L4, que activan `renv` en otra ruta) y el sandbox global a las 19:13:51 y 19:14:58 (corridas de R en el árbol durante la calibración de L5). Es la mantención normal de `renv` al activarse; el `find -newer` de L1 (0) se midió al cerrar L1. Ver R-51.
- R-15: `git show 29947ce` (una sola adición de bloque, después del bucle entre niveles); el predictor reproduce el orden de las reglas.
- R-18, R-23, R-26, R-30: `git diff-tree --numstat`: 29947ce (padre b452b0a) 15/1 en el paso 31; 6efefc5 (padre 29947ce) 14/3, 4/5, 2/1, 2/2, 2/1 y 6/6 en sus 6 archivos; e41ee1e (padre 6efefc5) 30/7, 8/5 y 2/2; 611852a (padre e41ee1e) 709/0.
- R-19 (`rd_d.py`, sobre `git ls-files`): `\b2019L\b` en `.R` versionados, solo `10_configuracion.R:33`; definiciones de `ANIO_INICIO` y `ANIOS_SIN_SIMCE`, solo L32 y L33 de ese archivo.
- R-20: `str2expression()` sobre el texto de `documentar.R`: 3 expresiones de nivel superior, sin error.
- R-21 (`rd_d.py`, Python sobre `git ls-files` con las exclusiones del criterio): **12 coincidencias**, las mismas 12 líneas.
- R-22 (`rd_d.py`, `zlib` sobre el JSON del motor): `meta.anios_sin_simce` [2019, 2020, 2021]; `meta.anios` 2014-2018 y 2022-2025. El primer intento usó la cabecera gzip; `memCompress(type = "gzip")` de R escribe zlib, y se repitió con detección automática.
- R-24 (`rd_d.py`): plantilla con 0 «>2014<», 0 «2019, 2020 y 2021», 1 `__ANIO_SIN_SIMCE__` y 1 `id="yr">__ANIO_MIN__`; vista escrita con `#yr` «2014» y `#gapb` «2019, 2020 y 2021 no tienen medición Simce»; `__ANIO_` 0 en la vista y 0 en el motor.
- R-25 (`rd_e_unidad.R`, entradas distintas de las de L4): **5 de 5** (cuatro años con uno aislado, «2019, 2020, 2021 y 2023»; años desordenados y en lista; dos apariciones del marcador; una variante `__ANIO_SIN_SIMCEX__`, detenida; un NA en los años sin Simce, detenido).
- R-28 (`sabotear_r28.R`: otra salida con **dos sabotajes distintos de los de L5**, un `<img … src="https://…">` para M1 y `--supergrid-col-min` en 100 px para M6; `diff`, 2 líneas): la batería da código 1, «**Resultado: 8 pruebas, 6 pasan, 2 fallan**», con FALLA solo en M1 («src=//: 1, url(http: 0») y M6 («375 px: … 1 de 82 textos fuera [PUCHUNCAVÍ (+7.66)]; 641 px: … [PUCHUNCAVÍ (+5.06)]»).
- R-29 (`rd_d.py`): sin rutas absolutas entre comillas (`/Users`, `/var/`, `/private`, `/tmp`, `~/`); la única escritura es `writeBin`, con un `tempfile(` y un `unlink(`.
- R-31 (`rd_d.py`): CLAUDE.md, 69 líneas, no versionado; `git ls-files --others --ignored --exclude-standard` lo lista como ignorado.
- R-32 a R-39: R.3. R-40: R.4.
- R-41 (red): `grep -c 'http'` = 17 líneas en el motor y 2 en la vista. `rd_red.py` lista cada URL con su contexto, y se revisaron a mano: en el motor, 26 apariciones de 9 URL, todas espacios de nombres XML de `www.w3.org` (svg, xhtml, xlink, XML, MathML, xmlns), la cadena de error de ReactDOM (`reactjs.org/docs/error-decoder.html`) y los comentarios de licencia de D3 (`d3js.org`) y pako (`github.com/nodeca/pako`); en la vista, 2 del espacio de nombres SVG. `src=`/`href=` con http, 0; `url(http`, 0; `@import`, 0; `fetch`/`XMLHttpRequest` a http, 0. Ningún enlace `<a href>` externo. **0 cargas por red.** (El `grep -o` con contexto no corrió: el `grep` del sistema, ugrep, rechazó el patrón por complejidad; se usó Python.)

**R.3 Invariantes 🔒** (comandos de §4; salida literal en `$TMPDIR/cal_s35l/fase_r/invariantes.txt`; `|` en vez del `\|` de la tabla)

I-1 `git for-each-ref --format='%(refname) %(objectname)'` contra `i1_fase0.txt`, fuera de `refs/heads/main` y `refs/remotes/origin/main` (y de `origin/HEAD`, que tampoco cambió)
esperado: iguales
obtenido: `diff`, código 0. `refs/heads/main` 611852a6…; `refs/remotes/origin/main` y `origin/HEAD` 10672ea8… (sin cambio); `feat/contrato-contexto`, local y remota, 31befa2c… → **PASA**

I-2 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 42ab9300… y 883f76bc…
obtenido: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 → **PASA**

I-3 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base» → **PASA**

I-4 md5 de la vista contra `docs/`; motor fuera de `meta$fecha_generacion` (`h6_diff.R`)
esperado: iguales
obtenido: vista 883f76bcefc89d93f2d1e753fc4d75c3; motor «fuera del bloque de datos, idéntico: TRUE», «JSON sin fecha_generacion, identical: TRUE» (y, por R-41, iguales byte a byte) → **PASA**

I-5 md5 de `renv.lock` y `renv/settings.json` y lista de la biblioteca con versiones y destinos (`i5_fase_r.txt`) contra `i5_fase0.txt`
esperado: idénticos
obtenido: `diff`, código 0; e6323bf2d0fb341589c4ce8a19b74636 y d0bcb98db909870724e9b0fc5eff1700; 58 paquetes → **PASA**

I-6 `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd` (en dos pasos)
esperado: vacío
obtenido: el primer `grep` halla solo `32_agregar_comunal.R:210` (`.by = c(cod_com_rbd, nom_com_rbd, cod_grupo, anio)`); el segundo, vacío, código 1 → **PASA**

I-7 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 → **PASA**

I-8 `md5 -q 10_utils/fuentes/*.otf`
esperado: a7407ed6… (Bold) y 0257bb4b… (Regular)
obtenido: a7407ed6a70160cdb96021f83808a94c (`gobCL_Bold.otf`) y 0257bb4b62d5ec557627aa0136f1e1dc (`gobCL_Regular.otf`) → **PASA**

**R.4 Alcance global** (`fase_r/alcance.py`, con los ALCANCE de §5, sobre `git diff --name-only`; y `git status --porcelain`)
esperado: dentro de la unión de los ALCANCE más el log; `status` solo con el log
obtenido: `b452b0a..HEAD`: «rutas: 10 | por tarea: L2 1, L3 6, L4 3, L5 1 | fuera: (ninguna)», código 0; con T0 (`b452b0a^..HEAD`): 13 rutas, T0 3, fuera ninguna, código 0. `git status --porcelain` = `?? …/20260926_verificaciones_s35l2_log.md`. CLAUDE.md (L6) está ignorado y no aparece → **PASA**

**R.5 Regresión completa** (estado final, códigos leídos sin tubería; 19:22:33 a 19:24:10)
esperado: build código 0 con 0 críticas; batería de la vista código 0 con 35 o más; «JSON idéntico a la línea base»; batería del motor código 0
obtenido: codigo_build=0, «Fallas criticas: 0 | **Advertencias: 8**», «OK en 6 segundos»; codigo_bateria_vista=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan»; codigo_i3=0, «JSON idéntico a la línea base»; codigo_bateria_motor=0, «Resultado: 8 pruebas, 8 pasan, 0 fallan (en 69 segundos)»; salidas 42ab9300… y 883f76bc… → **PASA**. Las advertencias del validador pasan de 7 a 8: la nueva es `30_procesamiento/33_verificar_motor.R:408 separador_manual` (hallazgo R-42).

**R.6 Control positivo de la propia auditoría** (`control_positivo.txt`, copias en `fase_r/ctl/`)
esperado: cada instrumento dispara con una cifra alterada y con una ruta fuera de alcance
obtenido: **disparan todos:**
- identidad de lo publicado, con el último año de `DATA.anios` de la vista cambiado (2025 → 2026) en una copia: `git hash-object` 42eb5152… ≠ blob de `docs/` 7cbbdb75…; `i4_data_vista.R`, «identical: FALSE», código 1;
- I-3 con otra cifra (el **segundo** decimal del JSON, 16.54 → 16.55, recomprimido en Python): «JSON difiere: $datos$pct[[2]] (16.55 vs 16.54)», codigo_i3_alt=1. El primer registro de este código se leyó con `pipestatus` en una tubería; se repitió sin tubería, como pide la regla canónica, con el mismo resultado;
- alcance con un diff simulado que agrega `30_procesamiento/32_agregar_comunal.R` y `docs/index.html`: «fuera: ['30_procesamiento/32_agregar_comunal.R', 'docs/index.html']», código 1;
- I-7 con un `.csv` simulado en la lista: 29;
- I-6 con un script simulado (`summarise(df, .by = nom_com_rbd, …)`) en una copia de `30_procesamiento/`: lo halla (código 0);
- I-5 con `arrow` 24.0.0 → 24.0.1 en una copia de la lista: `diff`, código 1;
- I-8 con el byte 100 de la Bold invertido (XOR 0xFF): 2835e4633b7fb9e42b49c7e24c08abd2 ≠ a7407ed6…;
- I-1 con el hash de `feat/contrato-contexto` alterado en una copia de la lista: `diff`, código 1;
- el predictor de L2, con el mensaje registrado de `sin2m2024` alterado («faltan años 2023»): «coincide con el predicho: False».

**R.7 Veredicto por hallazgo**
- BLOQUEA: ninguno.
- REPARA: **R-42** (una advertencia nueva del validador, causada por la batería del motor). Se corrige en R.8.
- ADVIERTE: R-43 a R-51 (tabla R.10).

**R.8 Ciclo de reparación** (un ciclo; R-42)
- (a) Causa raíz: la regla `separador_manual` de `10_utils/10_validar_portabilidad.R` (L114-116, regex `paste0?\s*\([^)]*["'][/\\]`) marca cualquier `paste(` cuyos argumentos, hasta el primer `)`, traen una cadena que empieza por `/`. La L408 de la batería usaba `paste(m5$fuera, collapse = "/")` solo para mostrar los seis conteos del modal. Es un falso positivo de la misma clase que el de `36_verificar_trayectorias.R:955`, pero sumaba una advertencia al build (7 → 8).
- (b) Arreglo quirúrgico, dentro del ALCANCE de L5: `collapse = "/"` → `collapse = ", "` (una línea; el detalle de M5 dice «0, 0, 0, 0, 0, 0»).
- (c) Re-verificación con el mismo chequeo: `Rscript 00_build.R` (`fase_r/r8_build.txt`, 19:26:50), codigo_build=0, «Fallas criticas: 0 | **Advertencias: 7**»; la lista de hallazgos estáticos vuelve a ser la de H6 y L4 (7 líneas, ninguna de `33_verificar_motor.R`). Con otro chequeo: la misma regex en Python sobre todo el archivo, antes `[(408, …)]` y después `[]`.
- (d) Regresión (19:27:07 a 19:28:37): batería del motor codigo=0, «8 pruebas, 8 pasan, 0 fallan (en 70 segundos)»; batería de la vista codigo=0, «35 pruebas, 35 pasan, 0 fallan»; I-3 codigo=0, «JSON idéntico a la línea base»; salidas con los blobs de `docs/` (2554f9a2…, 7cbbdb75…).
- (e) Commit `fix(auditoria): R-42 la bateria del motor no suma una advertencia al validador`: `7ceccdb`, padre `611852a`, `33_verificar_motor.R` 1/1.
- (f) Fila R-42 de R.10.
- Pasos 2 a 5 sobre lo tocado: la batería con el cambio contra la salida saboteada de M5 (19:28:50 a 19:30:01): código 1, «8 pruebas, 7 pasan, 1 fallan», FALLA solo en M5 («elementos fuera de la ventana 19, 26, 50, 51, 22, 22; pie visible 0/6; modal de -82.50 a 457.50 px»); R-29 igual (sin rutas absolutas; una escritura, `writeBin`, a `tempfile()`); alcance con `b452b0a^..HEAD`, 13 rutas, ninguna fuera, código 0; I-1 (`diff`, 0), I-2 (42ab9300…, 883f76bc…) e I-7 (28) sin cambio. El hallazgo no sobrevive y no destapó otro.

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado, meta ni ALCANCE, y no se tocó ningún 🔒. La reparación cambió el trabajo (una línea de la batería), no la regla del validador. La evidencia ya escrita no se editó; las correcciones de hora de L2, L3 y L5 se hicieron en su propia sección antes de cerrarla, y están declaradas en sus errores propios. No hubo subagentes.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1 | `ls-tree b452b0a`, `diff-tree b452b0a`, `cat-file -e 349f22d:` | 1 batería; 3 rutas | así | — | ninguna | — | — |
| R-02 | H2 | `rev-parse -q --verify refs/stash`; `test -d .git/worktrees` | sin stash; sin worktrees | así | — | ninguna | — | — |
| R-03 | H3 e instantáneas | `rev-parse b452b0a^`, `merge-base --is-ancestor`; Python sobre la biblioteca | 349f22d; 10672ea; igual | así | — | ninguna | — | — |
| R-04 | H4 y T0 | `openssl dgst -md5`, `git show b452b0a:`, `diff-tree` | 55b3d232…; 42ab…/883f… | así | — | ninguna | — | — |
| R-05 | H5 | R.5 | 35/35 | 35/35 | — | ninguna | — | — |
| R-06 | H6 | `git hash-object` | = `docs/` | = `docs/` | — | ninguna | — | — |
| R-07 | calibración de I-3 | R.6, otro decimal | difiere | difiere | — | ninguna | — | — |
| R-08 | paso 8 | predictor en Python | 10 coinciden | 10 de 10 | — | ninguna | — | — |
| R-09 | clon y biblioteca vacía | `git -C clon rev-parse`; `ls` del paso 1 | b452b0a; 0 | así | — | ninguna | — | — |
| R-10 | `restore()` y origen | Python: `DESCRIPTION` contra lock y traza | 57; RSPM = no CRAN | 57; 22 = 22 | ADVIERTE (R-43) | registrar | — | — |
| R-11 | `status()` en el clon | Python: lock contra biblioteca | sin diferencias | 0 ausentes, 0 versiones | — | ninguna | — | — |
| R-12 | build y batería en el clon | `hash-object`; Python sobre `l1_bateria.txt` | = `docs/`; 35 PASA | así | — | ninguna | — | — |
| R-13 | I-5 y aislamiento | Python (`os.walk`, `mtime`) | 0 escrituras en L1 | 0 en L1; 4 después, de `renv` | ADVIERTE (R-51) | registrar | — | — |
| R-14 | calibración con `mv` | Python sobre las salidas de `status()` | dispara y se limpia | así | — | ninguna | — | — |
| R-15 | posición de la regla | `git show 29947ce`; predictor | después de entre niveles | así | — | ninguna | — | — |
| R-16 | casos de L2 | predictor en Python | 11 coinciden | 11 de 11 | — | ninguna | — | — |
| R-17 | regresión L2 | R.5 | PASA | PASA | — | ninguna | — | — |
| R-18 | commit L2 | `diff-tree --numstat` | padre b452b0a; 15/1 | así | — | ninguna | — | — |
| R-19 | constantes en un lugar | Python sobre `git ls-files` | solo L32-33 | así | — | ninguna | — | — |
| R-20 | `documentar.R` analizable | `str2expression()` | sin error | 3 expresiones | ADVIERTE (R-45) | registrar | — | — |
| R-21 | `git grep` de rango | Python sobre `git ls-files` | 1 inventario + 11 | 12 | ADVIERTE (R-44) | registrar | — | — |
| R-22 | `anios_sin_simce` | Python (`zlib`) | [2019,2020,2021] | así | — | ninguna | — | — |
| R-23 | commit L3 | `diff-tree --numstat` | padre 29947ce; 6 | así | — | ninguna | — | — |
| R-24 | plantilla y vista | Python | 0 y 0; textos iguales | así | ADVIERTE (R-46, R-47) | registrar | — | — |
| R-25 | unidad y controles | `rd_e_unidad.R` (otras entradas) | 5 de 5 | 5 de 5 | — | ninguna | — | — |
| R-26 | commit L4 | `diff-tree --numstat` | padre 6efefc5; 3 | así | — | ninguna | — | — |
| R-27 | batería 8/8 | R.5 y R.8 | 8/8 | 8/8 | ADVIERTE (R-48, R-49) | registrar | — | — |
| R-28 | sabotajes | otra salida con dos sabotajes distintos | FALLA en M1 y M6 | solo M1 y M6 | — | ninguna | — | — |
| R-29 | sin rutas ni escrituras | Python sobre el archivo | ninguna; `tempfile` | así | — | ninguna | — | — |
| R-30 | commit L5 | `diff-tree --numstat` | padre e41ee1e; 709 | así | — | ninguna | — | — |
| R-31 | CLAUDE.md | Python; `ls-files --ignored` | ignorado; ≤ 80 | 69 | — | ninguna | — | — |
| R-32 a R-39 | I-1 a I-8 | R.3 | PASA | PASA | — | ninguna | — | — |
| R-40 | alcance | `alcance.py` | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-41 | identidad y red | `hash-object`; `grep -c http` y revisión en Python | iguales; 0 cargas | iguales; 0 cargas | — | ninguna | — | — |
| R-42 | la batería del motor suma una advertencia al validador del build (`33_verificar_motor.R:408 separador_manual`, falso positivo de `paste(…, collapse = "/")`): 7 → 8 | lista de hallazgos del validador en R.5 | 7 advertencias | 8 | REPARA | `collapse = ", "` | `7ceccdb` | validador 7 y regex en Python 0; batería 8/8; sabotaje M5, FALLA solo en M5 |
| R-43 | la restauración del lock depende de Posit Package Manager: 22 de las 56 descargas vienen de allí (`sys` de `latest` y 21 de instantáneas fechadas, entre ellas `stringi`, `arrow` y `dplyr`), porque sus versiones del lock ya no son las vigentes en CRAN. Sin ese servicio, `renv` tendría que compilarlas desde el archivo de fuentes de CRAN (no medido) | `rd_c_l1.py` | — | 22 RSPM | ADVIERTE | registrar (D1-a) | — | — |
| R-44 | el `git grep` de rango halla 11 coincidencias fuera del ALCANCE de L3, no las 9 del encargo: también `arquitectura_general_slep_simce_adecuado_standalone.html:349` y `arquitectura_slep_simce_adecuado_standalone.html:342`, HTML de la suite que regenera `documentar.R` (§11 excluye regenerarla). Se registran sin editar, como pide el criterio | `rd_d.py` | 9 | 11 | ADVIERTE | registrar | — | — |
| R-45 | `documentar.R` sigue llamando «preliminar» al 2025 en L100, L240, L305 y L324, aunque la base de 2025 es final desde v22025 (manifiesto L14-16). No son literales de rango y L3 no los incluye | lectura | — | 4 textos | ADVIERTE | registrar (D3-c) | — | — |
| R-46 | la plantilla de la vista trae los años sin Simce como texto fijo en L462 (notas: «No existe Simce 2019, 2020 ni 2021.») y L1032 (pista: `'2019 a 2021, sin medición'`), fuera de lo que pedía L4 y del `grep` de su criterio; no siguen a `ANIOS_SIN_SIMCE` | `grep -n` | — | 2 textos | ADVIERTE | registrar (D4-c) | — | — |
| R-47 | con un solo año en `ANIOS_SIN_SIMCE`, el aviso diría «2019 no tienen medición Simce»: el verbo en plural está en la plantilla. Latente; con los años de hoy no ocurre | `rd_e_unidad.R` (caso de un año) | — | latente | ADVIERTE | registrar (D4-b) | — | — |
| R-48 | M7 adapta el modo «abajo» de G3 de s35g: trae la celda a la vista en horizontal antes de ubicarla en vertical, porque desde Q-34 el supergrid se desplaza en sí mismo bajo 670 px. Los 12 casos y los criterios son los de G3; el procedimiento de ese caso no es literalmente el de `tt_g3.R` | diagnóstico de L5 | — | 1 caso adaptado | ADVIERTE | registrar | — | — |
| R-49 | las dos baterías no las corre `00_build.R`: una regresión del motor solo se detecta si alguien corre `33_verificar_motor.R` (CLAUDE.md la lista en «Pruebas»). Conectarla al build no estaba pedido | lectura de `00_build.R` | — | manual | ADVIERTE | registrar | — | — |
| R-50 | errores propios de instrumento y de redacción, todos corregidos antes de registrar resultados: tres horas escritas sin medir (L2, L3 y L5); la ruta de exclusión inexistente del primer `git grep` (L3); un `bash -c '…'` roto por comillas simples, que no corrió (L3); un `Rscript -e` con escapado inválido (L3); el orden de `os.listdir` en el predictor y la cabecera gzip en lugar de zlib (FASE R); un código leído con `pipestatus` en tubería, repetido sin ella (R.6) | — | — | corregidos | ADVIERTE | registrar | — | — |
| R-51 | las copias de `$TMPDIR/cal_s35l/` activan `renv` desde otra ruta y quedan anotadas en el registro global `projects` de `renv`, y cada activación en el árbol refresca el sandbox global (4 entradas del caché global con `mtime` posterior a L1). No viene de L1, que usó su propia raíz, y no cambia paquetes ni la biblioteca (I-5 en PASA) | `rd_c_l1.py`, `stat` | — | 4 entradas | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA. Un REPARA (R-42), corregido en el primer ciclo (`7ceccdb`) y re-verificado con el validador, con otro instrumento y con la regresión. Las 41 afirmaciones del inventario quedaron confirmadas con otros instrumentos: git de bajo nivel en vez de `status`, `openssl` y `git hash-object` en vez de `md5`, Python en vez de R y `grep`, un predictor independiente de las reglas del paso 31 (21 de 21), otra prueba unitaria (5 de 5) y otra salida saboteada, con sabotajes distintos. Los nueve controles positivos de la auditoría dispararon. Los ocho 🔒 están en PASA. Hay 9 ADVIERTE (R-43 a R-51), ninguno sobre datos, invariantes ni alcance. Los que más pesan son R-43 (la restauración depende de Posit Package Manager), R-46 (dos textos de la vista con los años sin Simce fijos) y R-49 (la batería del motor es manual).

## Cierre

**Paso 1. Estado del árbol** (`git status --porcelain`, 19:31:19, antes del commit de este log)
esperado: vacío o solo el log
obtenido: `?? 50_documentacion/andamios/logs/20260926_verificaciones_s35l2_log.md`, status_codigo=0. CLAUDE.md está ignorado y no aparece. Nada que limpiar.

### 1. Resumen

Las seis tareas se ejecutaron sin tareas congeladas, y el contenido publicado no cambió: `docs/` no se tocó, y el build de hoy reproduce `docs/` byte a byte.
- **L1 (Q-73).** El lock se restaura desde cero. En un clon, con biblioteca, caché y raíz de `renv` aislados en `$TMPDIR/s35l/`, `renv::restore()` instaló los 57 paquetes en una biblioteca vacía: 34 binarios de CRAN y 22 de Posit Package Manager, `stringi` y `sys` entre ellos. En el clon, `status()` queda consistente, el build reproduce `docs/` byte a byte y la batería de la vista da 35 de 35. El árbol principal y el caché global no cambiaron durante L1. La calibración con `mv` dispara y se limpia.
- **L2 (Q-74).** El build se detiene si la serie de un nivel no empieza en `ANIO_INICIO`, con un mensaje que nombra el nivel y los años que faltan. Sin 2014 en los dos niveles, antes pasaba y ahora se detiene; los otros nueve casos de K3 dan lo mismo que antes.
- **L3 (Q-75).** `ANIO_INICIO` y `ANIOS_SIN_SIMCE` viven solo en `10_utils/10_configuracion.R`; el paso 33 publica `meta$anios_sin_simce` desde ahí. Los textos del ALCANCE que describían la serie con un año final fijo dicen ahora «desde 2014, sin 2019 a 2021, hasta el último año cargado». Las filas de inventario quedan como están. Fuera del ALCANCE hay 11 coincidencias, no 9 (R-44).
- **L4 (R-41).** El año inicial de la pista y los años sin Simce del aviso del plano salen del build (`__ANIO_MIN__` y `__ANIO_SIN_SIMCE__`, con `sustituir_anios()`). Un marcador mal escrito o ausente detiene el build.
- **L5.** `30_procesamiento/33_verificar_motor.R`: 8 pruebas (M1 a M8), cada una con su control positivo, 8 de 8 en unos 70 s. Cada una de las ocho salidas saboteadas hace fallar solo su prueba.
- **L6 (D35-20).** CLAUDE.md local de 69 líneas, ignorado por `.gitignore:49`.

FASE R: 41 de 41 afirmaciones confirmadas con otros instrumentos; 9 controles positivos de la auditoría disparan; los 8 🔒 en PASA; 0 BLOQUEA, 1 REPARA (R-42, una advertencia nueva del validador, corregida en `7ceccdb`) y 9 ADVIERTE. Veredicto: **APROBADO CON ADVERTENCIAS**.

### 2. Inventario de commits (`git log b452b0a..HEAD --oneline`, antes del commit de este log)

```text
7ceccdb fix(auditoria): R-42 la bateria del motor no suma una advertencia al validador
611852a test(motor): bateria versionada del motor con control positivo
e41ee1e fix(trayectorias): el año inicial de la vista sale de los datos (R-41)
6efefc5 refactor(config): años sin Simce en un solo lugar y textos sin rango fijo (Q-75)
29947ce fix(pipeline): la serie Simce debe empezar en ANIO_INICIO (Q-74)
```

Más el punto de retorno, `b452b0a docs(sesion 35): encargo de la duodecima ola y decision D35-20` (T0), y el commit de este log, `docs(log): verificaciones pendientes, bateria del motor y CLAUDE.md (s35l, segunda emision)`, cuyo hash va en el reporte final (un archivo no puede llevar el hash de su propio commit). Con el push sale también `349f22d`, el log de la primera emisión, que quedó local (§2 del encargo).

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-51).

### 4. Invariantes

I-1 a I-8 en PASA en el estado final (FASE R, R.3), con re-derivación por otra vía (R.2) y controles positivos que disparan (R.6). En FASE L se midieron otra vez I-1 e I-5 contra las instantáneas de FASE 0 (19:31:19):
- I-1: `diff` fuera de `refs/heads/main` y `refs/remotes/origin/main`, código 0; `main` 7ceccdbd…, `origin/main` 10672ea8…, `feat/contrato-contexto` 31befa2c… local y remota;
- I-5: `diff i5_fase0.txt i5_fase_l2.txt`, código 0 (lock e6323bf2…, settings d0bcb98d…, 58 paquetes con los mismos nombres, versiones y destinos).
En ninguna tarea un 🔒 dio FALLA. Antes del push se miden las condiciones de la autorización 6 (reporte final).

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo (segunda emisión) completo en este turno, previa verificación del md5 (55b3d232f4591718d93c3ae3cf661890, verificado, igual).
- En el encargo: D35-20 (commiteada en T0) y las autorizaciones 1 a 6. Se usaron la 1 (commits por tarea), la 2 (L1), la 4 (`verificar_contenido_motor.R` y archivos y copias en `$TMPDIR`) y la 5 (CLAUDE.md). La 3 no se usó: ningún intento se descartó con `git checkout`. El intento 1 de L5 se guardó igual en `$TMPDIR` antes de corregirlo. La 6 va en el reporte final.
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión; git 2.54.0, R 4.5.2, `renv` 1.1.4, Chrome sin interfaz vía `chromote` 0.5.1, Python 3)

- L1: biblioteca del clon 0 → 57 paquetes (el arranque de `renv` más 56 instalados, todos binarios); 34 de CRAN y 22 de Posit Package Manager (21 de instantáneas fechadas y `sys` de `latest`; `stringi` de la del 2026-08-04); `restore()` en 77 s (18:41:17 a 18:42:34); build del clon en 11 s.
- L2: 11 casos en copias (10 antes y 11 después, con `sin2014a2018ambos`); predictor independiente 21 de 21.
- L3: `git grep` de rango 16 → 12 (1 inventario + 11 fuera del ALCANCE); 1 literal `2019L` en el código (la definición).
- L4: plantilla con 0 `>2014<` y 0 «2019, 2020 y 2021»; prueba unitaria 9 de 9 (y 5 de 5 en FASE R); 3 controles con build completo.
- L5: batería de 709 líneas, 8 pruebas, 8 de 8 en 69 a 70 s; 8 salidas saboteadas + 1 con dos sabotajes, cada una con FALLA solo en su prueba; M8: tinta 177/177/205 y 705/705/801 (la de s35h).
- L6: CLAUDE.md de 69 líneas.
- Validador del build: 0 críticas y 7 advertencias (8 entre L5 y R.8; R-42). Batería de la vista: 35 de 35. `docs/` y `40_salidas/`: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 (blobs 2554f9a2… y 7cbbdb75…), sin cambio; 0 cargas por red. I-7: 28.

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno. Este encargo cierra Q-73 (L1), Q-74 (L2), Q-75 (L3) y R-41 (L4), y crea CLAUDE.md (D35-20).

Dudas nuevas (se responden con una palabra):
- Q-79 (R-43). La restauración funciona, pero 22 paquetes bajan de instantáneas de Posit Package Manager porque sus versiones del lock ya no son las vigentes en CRAN. ¿Se actualiza el lock a versiones vigentes en un encargo propio, o se acepta esa dependencia? (actualizar / aceptar)
- Q-80 (R-46). La plantilla de la vista trae aún los años sin Simce como texto fijo en L462 (notas) y L1032 (pista). ¿Se pasan también a `ANIOS_SIN_SIMCE` en un encargo corto? (sí / no)
- Q-81 (R-45). `documentar.R` llama «preliminar» al 2025 en cuatro textos. ¿Se corrigen con la próxima regeneración de la suite? (sí / no)
- Q-82 (R-49). ¿Se conecta la batería del motor (y la de la vista) al build o a la publicación, o siguen manuales? (conectar / manual)

Pendientes que quedan al titular: la revisión en Safari y en un teléfono de s35h y s35i; el traspaso de cierre (con Q-71: `suitedoc` «en remoto privado»); Q-70 (el proceso R de otro proyecto, que detiene el titular). Excluidos por §11 y sin tocar: `docs/` y Pages, `feat/contrato-contexto`, la regeneración de la suite con `documentar.R` y Museo Sans en la suite (D35-7).

`# REVISAR` nuevos: ninguno (`git diff b452b0a HEAD | grep -c REVISAR` = 0; `grep -rn "# REVISAR"` sobre los seis archivos de código tocados, código 1).

### 8. Errores propios consolidados

- De redacción, corregidos en su sección antes de cerrarla: tres horas de inicio escritas sin medir (L2: 18:46 por 18:45; L3: 18:49 por 18:48; L5: 18:55 por 18:58). Desde L5, cada hora del log sale de una salida de `date` ya impresa.
- De instrumento, corregidos antes de registrar resultados:
  - la ruta de exclusión inexistente (`activa/traspasos`) en el primer `git grep` de L3;
  - un `bash -c '…'` con comillas simples en el texto, que zsh rechazó sin escribir nada (L3);
  - un `Rscript -e` con escapado inválido (L3);
  - el caso `barra_abajo_ult` de M7 fuera de la vista (intento 1 de L5, bug del instrumento);
  - el orden de `os.listdir` en el predictor y la cabecera gzip en lugar de zlib (FASE R);
  - un código leído con `pipestatus` en una tubería, repetido sin ella (R.6).
- Del trabajo, reparado en FASE R: R-42 (la batería sumaba una advertencia al validador).
- De redacción, en este Cierre: los conteos de §9 (32 y 30) se escribieron por cálculo antes de correr el `grep` que los mide; el `grep`, corrido enseguida, dio 32 y 30.
- Ninguno tocó los datos ni el contenido publicado.

### 9. Notas para el revisor

- L1 prueba la restauración en esta estación con una biblioteca vacía y cachés aislados, no en otra máquina. Lo que depende de la red quedó medido: 22 paquetes vienen de Posit Package Manager (R-43, Q-79).
- La regla nueva de L2 va después de la comparación entre niveles, para que «sin 2014 solo en 2m» conserve su mensaje de s35k (D2-a). Si falta 2014 solo en un nivel, el mensaje sigue siendo «faltan años 2014, que tiene el nivel 4b».
- La batería del motor pasa solo si su control positivo detecta el defecto plantado. Una FALLA puede venir del motor o del instrumento, y el detalle dice cuál de las dos partes falló. En las salidas saboteadas de M7 y M8, el control da «error» porque el sabotaje ya quitó el fragmento que el control cambia; la prueba falla antes por la medición real.
- M6 cambia el ancho sin recargar (el «barrido» de s35i) y M7 adapta un caso de G3 (R-48). Si una prueba de navegador falla sin cambios en el motor, conviene repetirla antes de buscar una regresión: las esperas son las de los medidores de s35h y s35i.
- Verificación del archivo (FASE L, paso 5): `^esperado:` cuenta 32 y `^obtenido:` 30. Las dos líneas `obtenido` sin los dos puntos al comienzo son las de criterio de L2 («obtenido (criterio; `l2_casos.sh despues`…)») y de L5 («obtenido (criterio, intento 2; …)»), cada una con su `esperado:` pre-registrado. Se deja el conteo como está (instrumento, §9.5: no se ajusta).

### 10. Estado de cierre

- **Commiteado:** T0 (`b452b0a`), L2 (`29947ce`), L3 (`6efefc5`), L4 (`e41ee1e`), L5 (`611852a`), R-42 (`7ceccdb`) y, al cerrar esta sección, este log (`docs(log)`), en `main`. L1 y L6 no cambian archivos versionados.
- **Local, sin versionar:** CLAUDE.md (69 líneas) y `verificar_contenido_motor.R`, apuntado a `$TMPDIR/base_s35l/`.
- **Condiciones de publicación** (autorización 6), medidas después del commit del log, en el mismo turno: veredicto de FASE R `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío (CLAUDE.md, ignorado, no cuenta); `git fetch origin` y `git merge-base --is-ancestor origin/main HEAD` con código 0; md5 de `docs/` sin cambio (I-2). Si se cumplen, `git push origin main` una sola vez; si no, se declara en el reporte final. El resultado y el hash de este commit van en el reporte final.
- **Queda al titular:** la revisión en Safari y en un teléfono de s35h y s35i, el traspaso de cierre (con Q-71), Q-70 y las dudas Q-79 a Q-82.
