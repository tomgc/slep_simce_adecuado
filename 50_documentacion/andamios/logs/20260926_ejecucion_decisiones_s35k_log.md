# Log: ejecución de las decisiones D35-17 a D35-19 (s35k) (slep_simce_adecuado)

- Meta: tres ramas menos sin perder nada, un lock que restaura el pipeline en otra estación, un build que acepta un año nuevo sin editar código y un manifiesto que dice la verdad; el sitio publicado no cambia de contenido.
- Fecha: 2026-09-26 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: `602ea3b` (commit de T0, H4; 602ea3b6c9f1efc0d27eabba6830ef70bafeaaf2)
- Encargo: `50_documentacion/activa/encargos/encargo_ejecucion_decisiones_s35k.md`, md5 `fc77f18139732fb001d8855811a99217` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`); el harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y prevalece: sin subagentes ni Workflow; todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, K1, K2, K3, K4, FASE R, FASE L con el push.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Carpeta de trabajo: `$TMPDIR/cal_s35k/` y `$TMPDIR/base_s35k/` (`$TMPDIR` = `/var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/`).

## J. Juicio (lo rellena FASE L)

- Meta y resultado: meta cumplida. Tres ramas menos sin perder nada (respaldo verificado, 0 archivos de clase c); un lock que registra los 17 paquetes de CRAN que faltaban, con `suitedoc` fuera y `renv::status()` consistente; un build que acepta un año nuevo sin editar código (con 2026 plantado, pasa y los 5 rangos dicen 2014–2026); y un manifiesto que dice que los xlsx se versionan. `docs/` sin cambio, y el build de hoy lo reproduce byte a byte.
- Estado por tarea: FASE 0 completa · T0 completa · K1 completa · K2 completa · K3 completa · K4 completa · FASE R: 0 BLOQUEA, 0 REPARA, 10 ADVIERTE (R-40 a R-49) · FASE L en el Cierre.
- Commits: 602ea3b (T0, punto de retorno), 1c1cd18 (K1), 03c8c6a (K2), 184208a (K3), 4ac0433 (K4) y el `docs(log)` de este archivo (hash en el reporte final); sin `fix(auditoria)`.
- Auditoría (FASE R): sin subagentes. 39 de 39 afirmaciones confirmadas con otros instrumentos: Python sobre git y bytes, `fetch` desde el bundle a un repositorio nuevo, `--cherry-mark` en el restaurado, un predictor de las reglas del paso 31 (18 de 18), una prueba unitaria de `sustituir_anios()` (8 de 8) y el build con 2026 repetido con el código final. 9 controles positivos disparan. Veredicto: APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-7 en PASA en el estado final (R.3); I-1 e I-2 se miden otra vez antes del push (reporte final).
- Cifras críticas: ramas 4 → 2; bundle 3 refs y 114 commits; lock 40 → 57, 0 versiones cambiadas, R 4.5.1 → 4.5.2; `renv::status()` 18 → 0; paso 31: 18 archivos, 9 años por nivel; plantillas con 0 «2025» y 5 líneas con marcadores; batería 35 de 35; validador 0 críticas y 7 advertencias; `docs/` 42ab9300…/883f76bc… sin cambio (blobs 2554f9a2…/7cbbdb75…); I-7 28.
- Decisiones autónomas de mayor riesgo: D2-b (no congelar K2 por el `Repository` de Posit Package Manager en `stringi` y `sys`); D3-a (el hueco se mide entre los años presentes, no desde `ANIO_INICIO`); D3-c (patrón de resto por prefijo `__ANIO_`); D2-a (probar la vía de K2 en una copia completa del árbol).
- Desviaciones respecto del encargo: ninguna en criterios, tolerancias ni ALCANCE. Además de lo pedido: comprobaciones adicionales en copias (cinco casos más, el build con 2026 y tres controles de marcadores) y dos mensajes de conteo del paso 31 que dejan de decir «18». CLAUDE.md sin crear (§11, D2).
- Dudas abiertas: Q-73 (probar `renv::restore()` en una biblioteca vacía), Q-74 (fijar el inicio de la serie en `ANIO_INICIO`), Q-75 (unificar `ANIOS_SIN_SIMCE` y poner al día los textos con el rango fijo); siguen Q-70 y Q-71.
- Errores propios: solo de instrumento y de redacción, todos corregidos o declarados antes de cerrar (`PIPESTATUS` en zsh, `rev-parse` sin `--verify`, `grep` del guion de Babel, `print()` de `status`, control de I-5 sin efecto, un `rm -rf` que no llegó a correr, `.gitignore:18` escrito sin medir, dos «R-ADV» adelantadas). Ninguno tocó el producto.
- Qué debe verificar el revisor por sí mismo: la restauración del lock en otra estación (R-40, Q-73); si acepta la lectura D3-a (R-42, Q-74); que el bundle de `_archivo/` es la única copia de 667e5ad (R-46).
- No publicado / queda al usuario: el traspaso de cierre (Q-71: «`suitedoc` en remoto privado»), Q-73 a Q-75 y Q-70. El push de `main` va en el reporte final; el borrado de las tres ramas es local y ninguna existía en `origin`.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite, aunque el harness tenía «ultracode» activo); git 2.54.0, R 4.5.2 con `renv` 1.1.4 activo, Python 3; 17:17 a 17:45.

### FASE 0: log, punto de retorno y premisas

**Estado:** completa. **Commits:** `602ea3b` (T0). **Cambios sustantivos:** ninguno en el producto. Inicio: 2026-09-26 17:17.

**Paso 1.** Log creado antes de H1, con el encabezado, el slot J vacío y la plantilla del Apéndice; por eso H1 muestra también la línea del propio log.

**H1.** `git status --porcelain` (salida en `$TMPDIR/cal_s35k/h1.txt`)
esperado: exactamente ` M …/20260924_decision_referente_traspasos.md`, ` M …/20260924_sesion35_errores_asistente.md` y `?? …/encargo_ejecucion_decisiones_s35k.md`, más el log
obtenido: status_codigo=0
```text
 M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
 M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_ejecucion_decisiones_s35k.md
?? 50_documentacion/andamios/logs/20260926_ejecucion_decisiones_s35k_log.md
```

**H2.** `git stash list | wc -l` y `git worktree list`
esperado: 0; solo el árbol principal
obtenido: 0; `/Users/tomgc/Projects/slep_simce_adecuado 2db6266 [main]`

**H3.** `git fetch origin` (fetch_codigo=0, sin salida), luego `git rev-parse --short HEAD` y `git rev-parse --short origin/main` en dos comandos; `git for-each-ref` (en `$TMPDIR/cal_s35k/i1_fase0.txt`) y `git ls-remote --heads origin`
esperado: 2db6266 y 2db6266; `feat/contrato-contexto 31befa2`, `gobernanza/v16 667e5ad`, `respaldo_normativos_20260824 b9426c2`, `respaldo_prerebase_20260824 e86b0d2`; el remoto solo con `main` y `feat/contrato-contexto`
obtenido: 2db6266 y 2db6266; las cuatro ramas con esos hashes; `ls-remote` = `refs/heads/feat/contrato-contexto 31befa2c…` y `refs/heads/main 2db62662…`
```text
refs/heads/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/heads/gobernanza/v16 667e5adaaadcf35ee1a41518d352aa6836178eae
refs/heads/main 2db62662386cde90d04cd540432e7bfa1dc841a2
refs/heads/respaldo_normativos_20260824 b9426c22d45ed9b37832cb20a53bcf89bb13bf0c
refs/heads/respaldo_prerebase_20260824 e86b0d250d52d161725cef7d224a7c6c718d3b71
refs/remotes/origin/HEAD 2db62662386cde90d04cd540432e7bfa1dc841a2
refs/remotes/origin/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/remotes/origin/main 2db62662386cde90d04cd540432e7bfa1dc841a2
```

**H4.** `md5 -q` del encargo y de `docs/`; I-5 e I-7 de partida
esperado: fc77f18139732fb001d8855811a99217 (mensaje de entrega); 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3
obtenido: fc77f18139732fb001d8855811a99217; 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3. I-5: `gobCL_Bold.otf` a7407ed6a70160cdb96021f83808a94c y `gobCL_Regular.otf` 0257bb4b62d5ec557627aa0136f1e1dc. I-7: 28.

**T0.** `git add` de las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la undecima ola y decisiones D35-17 a D35-19"`
esperado: un commit con el encargo, el archivo de decisiones y el registro de errores
obtenido: `602ea3b docs(sesion 35): encargo de la undecima ola y decisiones D35-17 a D35-19`, padre `2db6266`; `git show --name-status` = `M …/20260924_decision_referente_traspasos.md`, `A …/encargo_ejecucion_decisiones_s35k.md`, `M …/20260924_sesion35_errores_asistente.md`; `git status --porcelain` = solo este log. **Punto de retorno: 602ea3b** (602ea3b6c9f1efc0d27eabba6830ef70bafeaaf2).

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R` (salida en `$TMPDIR/cal_s35k/h5.txt`; código leído sin tubería)
esperado: 35 en PASA, código 0
obtenido: codigo_bateria=0; «Resultado: 35 pruebas, 35 pasan, 0 fallan» (17:18:03 a 17:18:21)

**H6.** `cd "$RAIZ" && Rscript 00_build.R` (salida en `$TMPDIR/cal_s35k/h6.txt`)
esperado: código 0; I-4: la vista con md5 igual a `docs/trayectorias.html`; el motor igual a `docs/index.html` fuera de `meta$fecha_generacion`
obtenido: codigo_build=0; «Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 6 segundos». Motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3, **iguales byte a byte a `docs/`** (el build y lo publicado son del mismo día). `simce_comunal.parquet` 468099a9c63bb3c0ddb74e67e2c7c19f. `git status --porcelain` = solo este log.

Comparación del motor sin la fecha (`$TMPDIR/cal_s35k/h6_diff.R`, copia del de s35h)
esperado: fuera del bloque idéntico; JSON sin `fecha_generacion` idéntico
obtenido: codigo_h6diff=0; «fuera del bloque de datos, idéntico: TRUE | largo 837548 837548»; «fecha_generacion hoy: 2026-09-26 | docs: 2026-09-26»; «JSON sin fecha_generacion, identical: TRUE»; «texto JSON: largo 13597248 13597248 | caracteres distintos: 0». **I-4 cumple.**

Las dos salidas se copiaron a `$TMPDIR/base_s35k/` (md5 42ab9300… y 883f76bc…): es la base de H6. `verificar_contenido_motor.R` (raíz, ignorado) apuntaba a `$TMPDIR/base_s35i/`; se apuntó a `$TMPDIR/base_s35k/` (línea 24 y comentarios de las líneas 3 y 12). El comparador del `DATA` de la vista se copió a `$TMPDIR/cal_s35k/i4_data_vista.R` con la base en `base_s35k` (codigo_i4v=0, «identical: TRUE»).

Calibración de `verificar_contenido_motor.R` (autorización 5)
esperado: «idéntico» sobre la base; «difiere» con un número alterado
obtenido: `Rscript verificar_contenido_motor.R` → codigo_i3_base=0, «JSON idéntico a la línea base». Con `$TMPDIR/cal_s35k/alterar_json_motor.R` (copia del de s35h: el primer número decimal del JSON, 3.5 → 3.6) sobre la base, `Rscript verificar_contenido_motor.R $TMPDIR/cal_s35k/motor_alterado.html` → codigo_i3_alt=1, «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)». **Dispara.**

**Paso 8. Calibraciones.**

*K2.* `cp renv.lock` y `cp renv/settings.json` a `$TMPDIR/cal_s35k/renv.lock.orig` y `settings.json.orig`; `md5 -q` de los cuatro; `Rscript -e 'invisible(renv::status())'` (salida en `status_antes.txt`)
esperado: copias con el mismo md5; `renv::status()` lista paquetes usados y no registrados
obtenido: `renv.lock` f5e8225e6456614c6c86bc550e449e7b = copia; `renv/settings.json` dfcbdef1ab29789ffa0f30c2eeb4fa17 = copia (`"ignored.packages": []`, `"snapshot.type": "implicit"`). Lock: R 4.5.1, 40 paquetes; `renv` 1.1.4; R instalado 4.5.2 (2025-10-31). codigo_status=0; «The following package(s) are in an inconsistent state», 18 filas `installed y / recorded n / used y`: AsioHeaders, askpass, chromote, curl, fastmap, later, openssl, openxlsx, otel, processx, promises, ps, Rcpp, suitedoc, sys, V8, websocket, zip. Son los 18 de §2.

*K3* (código de antes; autorización 5). `$TMPDIR/cal_s35k/k3_casos.sh antes <casos>`: cada caso es una copia del árbol hecha con `copia.sh` (`rsync -a` sin `.git`, `_archivo`, `.claude`, `.DS_Store`, `Claude outputs`, `renv/library` ni el directorio oficial, que trae MRUN y no se copia; enlaces simbólicos a esos dos; sin borrados), con un insumo quitado (`mv` fuera de la copia) o plantado (`cp` de otro xlsx con el nombre nuevo), y `Rscript 30_procesamiento/31_leer_normalizar.R` en la copia. Salidas en `$TMPDIR/cal_s35k/k3_antes/<caso>.txt` y `.cod`
esperado: sin `simce2m2024_rbd_final.xlsx` → «Nivel 2m: faltan años 2024»; con `simce2m2019_rbd_final.xlsx` → «años inesperados 2019»
obtenido: las dos **disparan** como se esperaba. Se corrieron además, para tener el «antes» de K3, los otros casos:

| caso | xlsx 2m / 4b | código | mensaje |
|---|---|---|---|
| `sin2m2024` | 8 / 9 | 1 | «Error: Nivel 2m: faltan años 2024» |
| `con2m2019` | 10 / 9 | 1 | «Error: Nivel 2m: años inesperados 2019» |
| `sin2m2014` | 8 / 9 | 1 | «Error: Nivel 2m: faltan años 2014» |
| `completo` | 9 / 9 | 0 | «OK: 18 archivos detectados (9 por nivel).» y «31_leer_normalizar.R: OK. Total 185378 filas» |
| `con2026ambos` (`simce{2m,4b}2026_rbd_preliminar.xlsx`, copias de 2025) | 10 / 10 | 1 | «Error: Nivel 2m: años inesperados 2026» |
| `con2013ambos` | 10 / 10 | 1 | «Error: Nivel 2m: años inesperados 2013» |
| `sin2016ambos` | 8 / 8 | 1 | «Error: Nivel 2m: faltan años 2016» |
| `dup2m2025` (`simce2m2025_rbd_preliminar.xlsx` junto al `_final`) | 10 / 9 | 1 | «Error en sprintf("    OK: %d archivos detectados (%d por nivel)." … invalid format '%d'» |
| `con2028ambos` | 10 / 10 | 1 | «Error: Nivel 2m: años inesperados 2028» |

Lectura: hoy un año nuevo en los dos niveles (`con2026ambos`) detiene el build: es lo que K3 cambia. El año repetido (`dup2m2025`) se detiene solo por accidente: 19 archivos / 2 = 9,5 no cabe en `%d`. Con un año repetido en cada nivel (20 archivos) pasaría y leería los dos archivos del año.

**Alcance:** las tres rutas de T0; `verificar_contenido_motor.R` (ignorado, autorización 5). **Regresión:** H5 y H6. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D0-a: `copia.sh` no borra: cada caso va a un directorio nuevo y el script se niega a escribir sobre uno existente. La regla global exige aprobación individual para `rm -rf`, y la autorización 5 permite crear copias pero no pide borrarlas.
- D0-b: además de los dos casos del paso 8, se corrieron en el «antes» los casos de K3 (sin 2014 en 2m, completo) y otros cinco (2026, 2013 y 2028 en ambos niveles, 2016 quitado de ambos, 2025 repetido en 2m), para comparar cada regla nueva con el código de antes.

**Errores propios:** `copia.sh` se escribió primero con un `rm -rf "$DEST"` antes de la comprobación de la ruta. Se corrigió antes de usarlo (primero se movió la comprobación y después se reemplazó el borrado por la negativa a escribir sobre un destino existente, D0-a). No llegó a ejecutarse. Un primer `renv::status()` con `print()` volcó el valor devuelto (275 KB); se repitió con `invisible()`.

**Dudas:** ninguna.

### FASE K1: rescate y borrado de ramas (D35-17)

**Estado:** completa. **Commits:** `1c1cd18` (rescate). **Cambios sustantivos:** el log del contrato de contexto entra a `main` con una línea de procedencia; la suite standalone de `documentacion_proyecto` pasa a la regenerada de `667e5ad` (1 línea); tres ramas locales menos. Salidas en `$TMPDIR/cal_s35k/k1_*`.

**Paso 1. Respaldo** (autorización 2). `git bundle create _archivo/20260926_respaldo_ramas_s35k/ramas_s35k.bundle respaldo_prerebase_20260824 respaldo_normativos_20260824 gobernanza/v16` y `ramas_hashes.txt` (`nombre hash` por rama, con `git rev-parse refs/heads/<rama>`). La carpeta está ignorada (`.gitignore:31:_archivo/`, `check-ignore -q` código 0)
esperado: `git bundle verify` válido, con las tres refs y los hashes de §2
obtenido: bundle de 29.637.862 bytes (md5 cbac7ec05309c153812fbdba2b19bb80); `ramas_hashes.txt` (md5 68390f3b7a1223c4a012ce495dd7b9a6):
```text
respaldo_prerebase_20260824 e86b0d250d52d161725cef7d224a7c6c718d3b71
respaldo_normativos_20260824 b9426c22d45ed9b37832cb20a53bcf89bb13bf0c
gobernanza/v16 667e5adaaadcf35ee1a41518d352aa6836178eae
```
verify_codigo=0: «…/ramas_s35k.bundle is okay», «The bundle contains these 3 refs:» `e86b0d25… refs/heads/respaldo_prerebase_20260824`, `b9426c22… refs/heads/respaldo_normativos_20260824`, `667e5ada… refs/heads/gobernanza/v16`; «The bundle records a complete history.» **Verificado.**

Segunda verificación (restauración): `git clone --bare` del bundle a `$TMPDIR/cal_s35k/k1_restaurado.git` (clone_codigo=0): las tres refs con los mismos hashes; `git fsck --full`, código 0; 114 commits, igual que `git rev-list --count` de las tres ramas en el repositorio; el log del contrato leído del clon tiene el mismo md5 que el de `667e5ad` (9f0b6aa36ccd482c2623888ddb5436b7).

**Paso 2. Rescate.** Log: una línea de procedencia más `git show 667e5ad:<ruta>`; suite: `git show 667e5ad:<ruta> > <ruta>`. Antes, `test ! -e` confirmó que el log no existía en `main`. Se leyó el log completo antes de publicarlo: 165 líneas con conteos agregados, esquemas y decisiones; sin RBD, filas ni nombres de personas o establecimientos (`grep` del patrón de RUT, código 1)
esperado: el log difiere de `667e5ad` solo en la línea agregada; la suite, en nada
obtenido: `diff <(git show 667e5ad:<log>) <log>` = `0a1` y una sola línea `> > Rescatado a `main` desde `gobernanza/v16` (`667e5ad`) por D35-17 (encargo s35k, 2026-09-26): el «No commitear» del encabezado (y de la línea final) quedó obsoleto; el resto del archivo es el original, byte a byte.`; `tail -n +2` del log contra el original, `cmp` código 0. Suite: `diff` código 0 y `cmp` código 0. Frente al `main` anterior, la suite cambia 1 línea (`--numstat` 1 1): «distintas <strong>entidades</strong>» → «distintos <strong>territorios</strong>». **Cumple.**

**Paso 3. Commit** `docs(ramas): rescata el log del contrato y la suite standalone de gobernanza/v16 (D35-17)`
obtenido: `1c1cd18`, padre `602ea3b`; `A …/logs/20260711_contrato_contexto_simce_log.md`, `M …/suite/documentacion_proyecto_slep_simce_adecuado_standalone.html`; `git status` = solo este log.

**Paso 4. Re-verificación antes de borrar** (`$TMPDIR/cal_s35k/k1_reclasificar.sh`: `git cherry -v main <rama>` y, por archivo de cada commit «+», el blob en el commit, en `main` y en la copia local de los ignorados; salida en `k1_reclasificar.txt`)
esperado: 0 archivos (c) por rama
obtenido: **0 archivos (c) en las tres ramas.**
- `respaldo_prerebase_20260824`: 1 commit «−» (e86b0d2), 0 «+» → 0 archivos. Su contenido está en `main`: `git diff --quiet e86b0d2 5dde691` sobre POLITICA y SETTINGS, código 0, y 5dde691 es ancestro de `main` (código 0).
- `respaldo_normativos_20260824`: 6 «−» y 1 «+» (98c3f6a) → 1 archivo, `ESTADO.md`: (b), la rama dice `sesion_actual: v26`, `ultima_actividad: 2026-07-01`; `main`, `v34` y `2026-09-24`. Además, la rama es ancestro de `feat/contrato-contexto` y de `origin/feat/contrato-contexto` (código 0 las dos): sus 7 commits siguen en el remoto.
- `gobernanza/v16`: 1 «−» (e86b0d2) y 1 «+» (667e5ad) → 9 archivos: (a) 4, (b) 5, (c) 0.

| archivo de 667e5ad | blob commit | `main` | clase |
|---|---|---|---|
| `activa/POLITICA_PROYECTO.md` | 5e47821a | ausente (ignorado, `.gitignore:50`) | (a): igual a la copia local vigente (D1-a de s35j) |
| `activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md` | aebc01d8 | ausente (ignorado, `.gitignore:51`) | (b): «Versión 34.» contra «Versión 38.» de la copia local |
| `andamios/logs/20260711_contrato_contexto_simce_log.md` | b535e56b | 544b5e28 | (a): `main` sin su línea 1 da el blob b535e56b (`git hash-object --stdin`) |
| `estructura/20260701_145817_estructura.md` y `.txt` | 8cde8df2, 7ec56a93 | ausentes | (b): `main` retiene `20260924_141324` y `20260924_163130` |
| `estructura/20260710_224110_estructura.md` y `.txt` | 539419b6, 4605b205 | ausentes | (b): ídem |
| `suite/documentacion_proyecto_…_standalone.html` | 1eda3da2 | 1eda3da2 | (a) |
| `suite/documentar.R` | 6bf8c1d9 | 6bf8c1d9 | (a) |

**Paso 5. Borrado** (autorización 2, con el respaldo verificado): `git branch -D respaldo_prerebase_20260824 respaldo_normativos_20260824 gobernanza/v16`
esperado: `git branch` = solo `feat/contrato-contexto` y `main`; I-1
obtenido: branch_D_codigo=0; «Deleted branch respaldo_prerebase_20260824 (was e86b0d2).», «Deleted branch respaldo_normativos_20260824 (was b9426c2).», «Deleted branch gobernanza/v16 (was 667e5ad).». `git branch` = `feat/contrato-contexto` y `* main`. I-1: `git rev-parse feat/contrato-contexto` = 31befa2c17efdf7d241699364846d69051c2a326; `git ls-remote --heads origin` = `feat/contrato-contexto` 31befa2c… y `main` 2db62662… (sin ramas nuevas). `for-each-ref` contra FASE 0: solo faltan las tres ramas y cambia `refs/heads/main` (2db6266 → 1c1cd18). `git config --get-regexp '^branch\.'` ya no tiene la sección de `gobernanza/v16`. Tras el borrado, `git bundle verify` del respaldo sigue en «is okay». **Cumple.**

**Paso 6.** Sin commit adicional.

**Alcance:** las dos rutas del rescate (commit), `_archivo/20260926_respaldo_ramas_s35k/` (ignorado) y las tres ramas. **Regresión:** no aplica al producto (K1 no toca código ni datos); `git status` = solo este log. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D1-a: la línea de procedencia va como cita de Markdown (`> …`) antes del título, sin línea en blanco, para que sea una sola línea agregada. También nombra el «No commitear» de la línea final, que repite el del encabezado.
- D1-b: además de `git bundle verify`, se restauró el bundle en un clon desnudo de `$TMPDIR` y se corrió `fsck`. Es más fuerte que el criterio y no cambia nada del repositorio.
- D1-c: en el paso 4, el log rescatado cuenta como (a) porque su contenido está en `main` salvo la línea de procedencia.

**Errores propios:** (1) en `git bundle create … | tail -3; echo ${PIPESTATUS[0]}` el código salió vacío: la shell es zsh y `PIPESTATUS` es de bash. El bundle se validó igual con `verify` y con la restauración. (2) La primera versión de `k1_reclasificar.sh` usaba `git rev-parse main:<ruta> 2>/dev/null || echo ausente`, y con la ruta ausente imprimía `main:<ruta>` en vez de «ausente». Se corrigió con `--verify -q` antes de registrar; la clasificación no cambió.

**Dudas:** ninguna.

### FASE K2: `suitedoc` fuera del lock (D35-18)

**Estado:** completa. **Commits:** `03c8c6a`. **Cambios sustantivos:** `renv/settings.json` ignora `suitedoc`; `renv.lock` pasa de 40 a 57 paquetes y registra R 4.5.2. Salidas en `$TMPDIR/cal_s35k/k2_*`.

**Prueba de la vía antes de tocar el árbol** (D35-18: «La vía se prueba antes en una copia del lock»; autorización 4). Copia del árbol en `$TMPDIR/cal_s35k/k2_prueba/repo` (`copia.sh`; el lock y `settings.json` de la copia con los md5 de FASE 0, f5e8225e… y dfcbdef1…). En la copia, `Rscript -e 'renv::settings$ignored.packages("suitedoc")'` y `Rscript -e 'renv::snapshot()'`, con una marca de tiempo antes para detectar escrituras en la biblioteca real (la copia la enlaza)
esperado: la hipótesis de §2: `snapshot()` deja de abortar y registra los 17 restantes
obtenido: settings_codigo=0; `diff` contra la copia de FASE 0: solo `"ignored.packages": ["suitedoc"]` (3 líneas en vez de 1). snapshot_codigo=0: «The following package(s) will be updated in the lockfile:», los 17 (16 bajo «# CRAN» y `sys` bajo «# https://packagemanager.posit.co/cran/latest»), «The version of R recorded in the lockfile will be updated: R [4.5.1 -> 4.5.2]», «Lockfile written to …/k2_prueba/repo/renv.lock». Sin pedir confirmación (Rscript no es interactivo): no hubo que agregar argumentos. `find -newer <marca>` sobre `renv/library` real: vacío. En la copia, `renv::status()` = «No issues found -- the project is in a consistent state.». **La hipótesis se confirma.** Una diferencia no prevista por §2: el registro de `stringi` (ya en el lock) cambia su campo `Repository` (ver criterio).

**Paso 1.** `Rscript -e 'renv::settings$ignored.packages("suitedoc")'` en el árbol (una vez)
esperado: `renv/settings.json` con `"ignored.packages": ["suitedoc"]` y ningún otro cambio (`git diff`)
obtenido: settings_codigo=0. `git diff renv/settings.json` = un solo bloque: `-  "ignored.packages": [],` → `+  "ignored.packages": [` / `+    "suitedoc"` / `+  ],` (`--numstat` 3 1); igual byte a byte al de la prueba (`cmp`, código 0). md5 d0bcb98db909870724e9b0fc5eff1700. **Cumple.**

**Paso 2.** `Rscript -e 'renv::snapshot()'` en el árbol (una vez; salida en `k2_snapshot.txt`)
esperado: no aborta
obtenido: snapshot_codigo=0, la misma salida que en la prueba; «Lockfile written to "~/Projects/slep_simce_adecuado/renv.lock"». No pidió confirmación (sin argumento extra). El lock resultante es **igual byte a byte** al de la prueba (`cmp`, código 0); md5 e6323bf2d0fb341589c4ce8a19b74636. `find -newer` sobre `renv/library`: vacío.

**Paso 3. Criterio** (`$TMPDIR/cal_s35k/k2_comparar.py renv.lock`: lee el lock nuevo y la copia de FASE 0 con `json`; salida en `k2_comparar.txt`)
esperado: `V8`, `openssl`, `chromote` y `openxlsx` con su versión instalada y `Repository: CRAN`; sin `suitedoc`; los 17 de §2 en el lock; ningún paquete previo con otra versión; el cambio de versión de R, anotado
obtenido: comparar_codigo=0.
- Paquetes: 40 → **57**; agregados 17, «agregados == 17 de §2 sin suitedoc: True»; quitados 0; «suitedoc en el lock: False».
- `V8` 8.2.0, `openssl` 2.4.2, `chromote` 0.5.1 y `openxlsx` 4.2.8.1, los cuatro `Source=Repository`, `Repository=CRAN`. Son las versiones instaladas (s35j R2.2: `V8` 8.2.0 y `openssl` 2.4.2; `DESCRIPTION` de `V8`: `Repository: CRAN`).
- Los otros 13: AsioHeaders 1.30.2-1, askpass 1.2.1, curl 8.0.0, fastmap 1.2.0, later 1.4.8, otel 0.2.0, processx 3.9.0, promises 1.5.0, ps 1.9.3, Rcpp 1.1.2, websocket 1.4.4 y zip 3.0.2 con `Repository=CRAN`; **`sys` 3.4.3 con `Repository=https://packagemanager.posit.co/cran/latest`**.
- «versiones cambiadas en registros previos (0)». Un registro previo cambia **otro** campo: `stringi` (1.8.7) `Repository` `CRAN` → `https://packagemanager.posit.co/cran/latest`. `git diff -U0 renv.lock` borra solo 2 líneas: `"Version": "4.5.1"` de R y el `"Repository": "CRAN"` de `stringi` (`--numstat` 589 2).
- **Versión de R del lock: 4.5.1 → 4.5.2** (anotado; R instalado 4.5.2). `Repositories` del lock sin cambio (CRAN, `https://cloud.r-project.org`); ninguna otra clave de primer nivel cambió.
- Origen de `stringi` y `sys`: sus `DESCRIPTION` instalados dicen `Repository: RSPM`, `RemoteRepos: https://packagemanager.posit.co/cran/latest`, `RemoteReposName: CRAN`, construidos el 2026-06-17 (R 4.5.0). El lock anterior (`22e0ed9`, 2026-08-19) registraba `stringi` como `CRAN`; `snapshot()` rehace cada registro desde el `DESCRIPTION` instalado. Ver D2-b y R-ADV.

`renv::status()` después (`status_despues.txt`)
esperado: sin paquetes usados y no registrados, salvo `suitedoc` como ignorado
obtenido: status_codigo=0; «No issues found -- the project is in a consistent state.»; `renv::settings$ignored.packages()` = «suitedoc». Antes (FASE 0): 18 filas `installed y / recorded n / used y`. El aviso «The project is out-of-sync» que abría cada `Rscript` ya no aparece. **Cumple.**

Build, batería, I-3 e I-4 (códigos leídos sin tubería)
esperado: build código 0 con 0 críticas; batería 35 en PASA; I-3 «idéntico»; I-4
obtenido: codigo_build=0, «Fallas criticas: 0 | Advertencias: 7», «OK en 6 segundos»; motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3 (= `docs/`); codigo_bateria=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan»; codigo_i3=0, «JSON idéntico a la línea base»; codigo_i4=0, «fuera del bloque de datos, idéntico: TRUE», «JSON sin fecha_generacion, identical: TRUE». **Cumple.**

**Paso 4. Commit** `chore(renv): registra los paquetes de CRAN que faltaban y deja suitedoc fuera del lock (D35-18)`
obtenido: `03c8c6a`, padre `1c1cd18`; `M renv.lock`, `M renv/settings.json`; `git status` = solo este log.

**Alcance:** `renv.lock` y `renv/settings.json`. **Regresión:** build, batería, I-3 e I-4 (arriba). **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D2-a: la vía se probó en una copia del árbol (`copia.sh`), no solo en una copia del lock: `ignored.packages()` y `snapshot()` escriben en el proyecto activo, y en la copia el proyecto es la copia. Así se corrieron las mismas dos llamadas que después en el árbol, cada una una sola vez en el árbol (autorización 4).
- D2-b: el cambio del campo `Repository` de `stringi` (misma versión) y el registro de `sys` desde Posit Package Manager no congelan K2. El criterio pide `Repository: CRAN` solo para `V8`, `openssl`, `chromote` y `openxlsx`, y «ningún paquete que ya estaba cambió de versión», y los dos se cumplen. El campo nuevo dice el origen real de lo instalado. `packagemanager.posit.co/cran/latest` es un espejo público de CRAN, así que restaurar no pide credencial. No se probó `renv::restore()` en otra estación (no autorizado): queda como ADVIERTE en FASE R.

**Errores propios:** ninguno.

**Dudas:** ninguna nueva (el origen de `stringi` y `sys` se registra como advertencia, no como pregunta).

### FASE K3: los años y los rangos salen de los archivos (D35-19)

**Estado:** completa. **Commits:** `184208a`. **Cambios sustantivos:** el paso 31 deriva los años de los nombres de archivo y valida la serie con dos constantes nuevas (`ANIO_INICIO`, `ANIOS_SIN_SIMCE`); los 5 literales de rango pasan a `__ANIO_MIN__` y `__ANIO_MAX__`, que sustituye `sustituir_anios()` (nueva, en `10_utils/10_html.R`) en cada generador. Con los insumos de hoy, las salidas son byte a byte las de `docs/`. Salidas en `$TMPDIR/cal_s35k/k3_*`.

**Paso 1. Paso 31** (`30_procesamiento/31_leer_normalizar.R`). `anios_esperados` desaparece. Constantes nuevas: `ANIO_INICIO <- 2014L` y `ANIOS_SIN_SIMCE <- c(2019L, 2020L, 2021L)`. `anios_por_nivel` sale de `manifiesto$anio` por nivel. Detiene el build con un mensaje que nombra el nivel y los años, en este orden:
- ningún xlsx en los dos niveles: «No hay xlsx Simce en 20_insumos/simce/{2m,4b}/»;
- en cada nivel, primero: un año con más de un archivo → «Nivel %s: más de un archivo para los años %s (<archivos>)»;
- un año anterior a `ANIO_INICIO` o de `ANIOS_SIN_SIMCE` → «Nivel %s: años inesperados %s» (mensaje de hoy);
- un hueco entre el primer y el último año del nivel, fuera de `ANIOS_SIN_SIMCE` → «Nivel %s: faltan años %s» (mensaje de hoy);
- después, entre niveles: un año que tiene el otro nivel → «Nivel %s: faltan años %s, que tiene el nivel %s».
- El mensaje de conteo agrega los años («OK: 18 archivos detectados (9 por nivel), años 2014, …, 2025.»); «Procesando 18 xlsx» pasa a `sprintf` con `nrow(manifiesto)`; los comentarios del encabezado que decían «18 xlsx» y «2014-2018, 2022-2025» dicen «hoy».

**Paso 2. Literales** (los 5 de §2)
- `33_fragmento_sitio.html` L85: «Datos 2014–2025» → «Datos \_\_ANIO_MIN\_\_–\_\_ANIO_MAX\_\_».
- `33_motor_template.html` L2592: `domain([2014, 2025])` → `domain([__ANIO_MIN__, __ANIO_MAX__])`.
- L4139: «periodo 2014–2025» → «periodo \_\_ANIO_MIN\_\_–\_\_ANIO_MAX\_\_».
- L5074: «Bases Simce 2014–2025» → «Bases Simce \_\_ANIO_MIN\_\_–\_\_ANIO_MAX\_\_».
- `36_trayectorias_template.html` L475: «2014 a 2025» → «\_\_ANIO_MIN\_\_ a \_\_ANIO_MAX\_\_».

Cómo se sustituyen:
- `10_utils/10_html.R` define `MARCADOR_ANIO_MIN`, `MARCADOR_ANIO_MAX` y `PATRON_ANIO_RESTO` (`"__ANIO_[A-Za-z_]*"`), y la función `sustituir_anios(texto, anios)`. Reemplaza todas las apariciones por `min(anios)` y `max(anios)` y se detiene en tres casos: si no hay años, si un marcador no aparece («La página no trae el marcador …») o si queda texto con el prefijo `__ANIO_` («Quedaron marcadores de años sin sustituir: …»).
- `33_generar_html.R` la llama con `meta$anios` justo después de `insertar_sitio()` y **antes de transpilar** el JSX: Babel recibe el mismo texto que antes. `36_generar_trayectorias.R` la llama con `DATA_TRAY$anios` justo después de `insertar_sitio()`. El fragmento, insertado en las dos páginas, se sustituye en el generador de cada una.
- Ninguna biblioteca de `10_utils/*.js` contiene `__ANIO_` (`grep -c`, 0 en las cinco).

**Paso 3. Criterio**

I-4 con los insumos de hoy (`Rscript 00_build.R`, salida en `k3_build2.txt`; `h6_diff.R`; `cmp`)
esperado: las dos salidas con el mismo contenido que `docs/`
obtenido: codigo_build=0, «Fallas criticas: 0 | Advertencias: 7» (sin cambio: el validador no marca el código nuevo), «OK en 6 segundos»; motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3; `cmp` contra `docs/index.html` y `docs/trayectorias.html`, código 0 y 0 (**iguales byte a byte**); `h6_diff.R` codigo_i4=0, «fuera del bloque de datos, idéntico: TRUE», «JSON sin fecha_generacion, identical: TRUE». Salida del paso 31: «OK: 18 archivos detectados (9 por nivel), años 2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025.» y «[2] Procesando 18 xlsx...». **Cumple.** (Los HTML de `40_salidas/` están ignorados, `.gitignore:13` y `:14`; no hay nada que commitear de ellos.)

`grep` de los literales. Comando: `grep -n "2025" 30_procesamiento/33_fragmento_sitio.html 30_procesamiento/33_motor_template.html 30_procesamiento/36_trayectorias_template.html`
esperado: 0 aciertos en esos 5 lugares
obtenido: grep_codigo=1, **0 aciertos** en los tres archivos (ni fuera ni dentro de comentarios). `grep -n "__ANIO_"` = las 5 líneas de arriba. `grep -n "2014"` en los tres = 2 aciertos, fuera de los 5 lugares: la vista L433 `<div class="yr" id="yr">2014</div>`, un valor inicial que el script reemplaza al dibujar (L1066, `document.getElementById('yr').textContent=yr`, con `yr = anioAct()`), y L974, un comentario de JavaScript. Ver R-ADV (L433). En las salidas, `grep -c "__ANIO_"` = 0 y 0.

Copias con insumos plantados o quitados (autorización 5; `k3_casos.sh despues`, las mismas nueve de FASE 0 con el código nuevo; salidas en `$TMPDIR/cal_s35k/k3_despues/`)
esperado: sin `simce2m2024` → se detiene; con `simce2m2019` → se detiene; sin `simce2m2014` solo en 2m → se detiene (niveles distintos); completos → pasa
obtenido: **las cuatro como se esperaba.** Antes y después:

| caso | antes (FASE 0) | después (K3) |
|---|---|---|
| `sin2m2024` | 1: «Nivel 2m: faltan años 2024» | 1: «Nivel 2m: faltan años 2024» (hueco) |
| `con2m2019` | 1: «Nivel 2m: años inesperados 2019» | 1: «Nivel 2m: años inesperados 2019» |
| `sin2m2014` | 1: «Nivel 2m: faltan años 2014» | 1: «Nivel 2m: faltan años 2014, que tiene el nivel 4b» (niveles distintos) |
| `completo` | 0: «OK: 18 archivos detectados (9 por nivel).» | 0: «OK: 18 archivos detectados (9 por nivel), años 2014, …, 2025.»; 185378 filas |
| `con2026ambos` | 1: «años inesperados 2026» | **0**: «OK: 20 archivos detectados (10 por nivel), años 2014, …, 2025, 2026.»; 205668 filas |
| `con2013ambos` | 1: «años inesperados 2013» | 1: «Nivel 2m: años inesperados 2013» (anterior a `ANIO_INICIO`) |
| `sin2016ambos` | 1: «faltan años 2016» | 1: «Nivel 2m: faltan años 2016» (hueco) |
| `dup2m2025` | 1, por accidente: «invalid format '%d'» | 1: «Nivel 2m: más de un archivo para los años 2025 (simce2m2025_rbd_final.xlsx, simce2m2025_rbd_preliminar.xlsx)» |
| `con2028ambos` | 1: «años inesperados 2028» | 1: «Nivel 2m: faltan años 2026, 2027» (hueco) |

Comprobación adicional (no es criterio): `Rscript 00_build.R` completo en la copia `con2026ambos` (2026 plantado en los dos niveles como `_preliminar`, copias de 2025)
esperado: el build pasa y los 5 rangos dicen 2014–2026 sin editar código
obtenido: codigo_build_copia=0, «Fallas criticas: 0 | Advertencias: 7»; dos avisos esperables del paso 31, «simce{2m,4b}2026_rbd_preliminar.xlsx: año interno (2025) difiere del nombre (2026)» (las copias son de 2025). En las salidas de la copia: «Datos 2014–2026» en el motor y en la vista; `domain([2014, 2026])`; «periodo 2014–2026» y «Bases Simce 2014–2026» (Babel escribe el guion largo del JSX como `–`; `docs/` tiene «2014–2025» en esos dos lugares); «Educación, 2014 a 2026»; `grep -c "__ANIO_"` = 0 y 0. **La llegada de un año nuevo no exige editar código.**

Controles de los marcadores (autorización 5; `k3_controles.sh despues`: copia, un cambio con `perl -pi` y `00_build.R` completo; salidas en `$TMPDIR/cal_s35k/k3ctl_despues/`)
esperado: un marcador sin sustituir, o ausente, detiene el build
obtenido: **disparan los tres**, código 1:
- `extra` (`__ANIO_OTRO__` agregado al fragmento): «Error en sustituir_anios(plantilla, meta$anios): Quedaron marcadores de años sin sustituir: __ANIO_OTRO__» (se detiene en el motor);
- `malescrito` (`__ANIO_MIN_` en la plantilla de la vista): «Error en sustituir_anios(html_tray, DATA_TRAY$anios): Quedaron marcadores de años sin sustituir: __ANIO_MIN_»;
- `sinmin` (`__ANIO_MIN__` quitado del fragmento y de la vista): «Error en sustituir_anios(html_tray, DATA_TRAY$anios): La página no trae el marcador __ANIO_MIN__».

Batería e I-3 (sobre el código final de K3)
esperado: batería en PASA; I-3 «idéntico»
obtenido: codigo_bateria=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan»; codigo_i3=0, «JSON idéntico a la línea base». **Cumple.**

**Calibración** (FASE 0, paso 8, con el código de antes): `sin2m2024` y `con2m2019` dispararon con los mensajes esperados (tabla, columna «antes»).

**Paso 4. Commit** `refactor(pipeline): los anos y los rangos se derivan de los insumos (D35-19)`
obtenido: `184208a`, padre `03c8c6a`; 7 archivos `M` (`10_utils/10_html.R`, `31_leer_normalizar.R`, `33_fragmento_sitio.html`, `33_generar_html.R`, `33_motor_template.html`, `36_generar_trayectorias.R`, `36_trayectorias_template.html`); `git status` = solo este log.

**Alcance:** los 7 archivos, dentro del ALCANCE de K3; `40_salidas/*.html` se reescribieron idénticos (ignorados). **Regresión:** build, batería, I-3 e I-4 (arriba). **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D3-a: «entre el primero y el último» se leyó como el primer y el último año **presentes** en el nivel, no como `ANIO_INICIO`. Consecuencia: si se quita 2014 de los dos niveles, la serie empieza en 2015 y el rango dice 2015–2025 sin detenerse. Se registra como ADVIERTE.
- D3-b: el hueco se evalúa antes que la diferencia entre niveles, para que un año faltante en medio de la serie conserve el mensaje de hoy («Nivel 2m: faltan años 2024»). La diferencia entre niveles se evalúa después de validar los dos niveles, para que un año inválido del otro nivel no se informe como «falta» en este.
- D3-c: `PATRON_ANIO_RESTO` usa el prefijo (`__ANIO_[A-Za-z_]*`) y no la forma completa (`__ANIO_[A-Z]+__`, la primera versión, con la que se hizo la comprobación de 2026). Así se detiene también un marcador mal escrito (control `malescrito`). Con el prefijo, el build de hoy dio las mismas salidas byte a byte.
- D3-d: la sustitución del motor va antes de transpilar (el JSX usa tres de los cuatro marcadores de esa página): el texto que recibe Babel es el mismo de antes, y por eso la salida es byte a byte igual.
- D3-e: se ajustaron dos mensajes y tres comentarios de `31_leer_normalizar.R` que decían «18» o el rango fijo, para que con otra cantidad de archivos no mientan. No cambian datos ni salidas.

**Errores propios:** ninguno de código. En la comprobación de 2026, el primer `grep -o "periodo [0-9]{4}–[0-9]{4}"` no halló los dos textos del JSX porque Babel escribe el guion como `–`; se repitió con `.{0,8}` entre los años. En esta sección escribí primero «`.gitignore:18`» sin medirlo; `git check-ignore -v` dio 13 (motor) y 14 (vista), y se corrigió antes de cerrar K3.

**Dudas:** ninguna.

### FASE K4: el manifiesto dice que los xlsx se versionan (Q-72, D35-19)

**Estado:** completa. **Commits:** `4ac0433`. **Cambios sustantivos:** una viñeta de `manifiesto_insumos.md`.

**Paso 1.** En «## Política de versionado» (L87), la primera viñeta pasa de «Los xlsx SIMCE crudos **no** se versionan (`.gitignore`). Se mantienen localmente.» a: «Los 18 xlsx SIMCE crudos (`20_insumos/simce/{2m,4b}/`) **sí** se versionan: están autorizados en `50_datos_versionados_autorizados.md` (L25 y L26). Desde el encargo s35k (D35-19), el paso 31 deriva los años de sus nombres: un año nuevo entra con sus dos xlsx (uno por nivel), sin editar código.»

Hechos de la frase, medidos: `git ls-files 20_insumos/simce | grep -c xlsx` = 18; `git check-ignore -q` sobre un xlsx, código 1 (no ignorado); `50_datos_versionados_autorizados.md` L25 y L26 = `20_insumos/simce/2m/*.xlsx` y `20_insumos/simce/4b/*.xlsx`; la derivación de años es la de K3 (`184208a`).

**Paso 2. Verificación.** `git diff -U0 50_documentacion/activa/manifiesto_insumos.md`
esperado: solo toca la sección «Política de versionado»
obtenido: un solo bloque, `@@ -89,2 +89,4 @@` (`--numstat` 4 2), dentro de la sección que abre en L87 y llega al final del archivo. **Cumple.**

**Paso 3. Commit** `docs(insumos): el manifiesto dice que los xlsx Simce se versionan (Q-72)`
obtenido: `4ac0433`, padre `184208a`; `M 50_documentacion/activa/manifiesto_insumos.md`; `git status` = solo este log.

**Alcance:** `manifiesto_insumos.md`. **Regresión:** no aplica (un documento). **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:** D4-a: la frase nombra el encargo y la decisión («encargo s35k (D35-19)») en vez de «K3», que solo existe dentro del encargo. No se tocó L10 («hoy, todos los años 2014–2025»), fuera de la sección; sigue siendo cierta.

**Errores propios:** ninguno.

**Dudas:** ninguna.

### FASE R: auditoría y reparación

**R.1 Inventario de afirmaciones auditables** (armado desde las secciones anteriores de este log, antes de auditar; cada una se re-deriva en R.2 con un comando distinto del que la produjo)

| id | afirmación (fase) |
|---|---|
| R-01 | H1-H3: árbol con las tres rutas de T0 más el log; stash 0; un worktree; `HEAD` = `origin/main` = 2db6266; las cuatro ramas con los hashes de §2; el remoto solo con `main` y `feat/contrato-contexto` (FASE 0) |
| R-02 | H4: md5 del encargo fc77f181…; `docs/` 42ab9300… y 883f76bc…; fuentes a7407ed6… y 0257bb4b…; I-7 = 28 (FASE 0) |
| R-03 | T0 = 602ea3b, padre 2db6266, 3 rutas (M decisiones, A encargo, M errores) (FASE 0) |
| R-04 | H5: batería 35 de 35, código 0 (FASE 0) |
| R-05 | H6: build código 0, 0 críticas y 7 advertencias; salidas iguales byte a byte a `docs/`; JSON sin la fecha idéntico (FASE 0) |
| R-06 | Calibración de `verificar_contenido_motor.R`: «idéntico» sobre la base, «difiere» con 3.5 → 3.6 (FASE 0) |
| R-07 | Calibración K2: copias de respaldo con el md5 del lock (f5e8225e…) y de `settings.json` (dfcbdef1…); `renv::status()` con los 18 paquetes usados y no registrados (FASE 0) |
| R-08 | Calibración K3 con el código de antes: los 9 casos de la tabla (FASE 0) |
| R-09 | Respaldo: bundle válido con las 3 refs y los hashes de §2, historia completa; restauración con `fsck` sin errores y 114 commits (K1) |
| R-10 | Rescate: el log difiere de 667e5ad solo en la línea agregada; la suite es igual a la de 667e5ad y difiere en 1 línea de la anterior de `main`; el log no tiene datos personales (K1) |
| R-11 | Commit 1c1cd18, padre 602ea3b, A log y M suite (K1) |
| R-12 | Re-verificación: 0 archivos (c) en las tres ramas (prerebase 0 archivos; normativos 1 b; gobernanza a 4, b 5) (K1) |
| R-13 | Borrado: solo quedan `feat/contrato-contexto` y `main`; I-1; sin la sección de config de `gobernanza/v16`; el bundle sigue válido (K1) |
| R-14 | Prueba de K2 en la copia: `settings.json` solo con `ignored.packages`; `snapshot()` sin abortar; sin escrituras en la biblioteca real; `status` consistente (K2) |
| R-15 | `renv/settings.json` en el árbol: solo cambia `ignored.packages` (3 1); md5 d0bcb98d… (K2) |
| R-16 | `renv.lock`: 40 → 57; los 17 de §2 sin `suitedoc`; `V8`, `openssl`, `chromote` y `openxlsx` en CRAN con su versión; 0 versiones cambiadas; `stringi` cambia `Repository`; `sys` desde Posit Package Manager; R 4.5.1 → 4.5.2; igual al lock de la prueba; md5 e6323bf2… (K2) |
| R-17 | `renv::status()` después: consistente; `suitedoc` ignorado (K2) |
| R-18 | Build, batería, I-3 e I-4 en PASA tras K2 (K2) |
| R-19 | Commit 03c8c6a, padre 1c1cd18, M lock y M settings (K2) |
| R-20 | Paso 31: sin `anios_esperados`; `ANIO_INICIO` 2014L y `ANIOS_SIN_SIMCE` 2019-2021; las cuatro condiciones de detención y el caso sin archivos (K3) |
| R-21 | Los 5 literales son marcadores; `sustituir_anios()` en `10_html.R`, llamada en 33 antes de transpilar y en 36 tras `insertar_sitio()` (K3) |
| R-22 | I-4 tras K3: salidas iguales byte a byte a `docs/`; 0 críticas y 7 advertencias (K3) |
| R-23 | `grep "2025"` en las plantillas y el fragmento: 0; `2014` solo en la vista L433 y L974; 0 marcadores en las salidas (K3) |
| R-24 | Copias con el código nuevo: los 9 casos de la tabla, con los cuatro del criterio como se esperaba (K3) |
| R-25 | Build completo con 2026 en los dos niveles: pasa y los 5 rangos dicen 2014–2026 (K3) |
| R-26 | Controles de los marcadores: `extra`, `malescrito` y `sinmin` detienen el build (K3) |
| R-27 | Batería 35 de 35 e I-3 tras K3 (K3) |
| R-28 | Commit 184208a, padre 03c8c6a, 7 archivos M (K3) |
| R-29 | Manifiesto: un bloque en «Política de versionado»; 18 xlsx versionados, no ignorados, autorizados en L25 y L26 (K4) |
| R-30 | Commit 4ac0433, padre 184208a (K4) |
| R-31 a R-37 | I-1 a I-7 (§4) |
| R-38 | Alcance global: `git diff --name-only 602ea3b..HEAD` dentro de la unión de los ALCANCE más el log; `git status` |
| R-39 | Identidad de lo publicado (`git hash-object` sobre `docs/` y `40_salidas/`) y ausencia de red (`grep -c 'http'`, revisado) |

**R.2 Re-derivación independiente** (sin subagentes; el orquestador, con otros comandos; scripts y salidas en `$TMPDIR/cal_s35k/fase_r/`: `rd_a.sh`, `rd_b.sh`, `rd_c.py`, `rd_d_predictor.py`, `rd_d_unidad.R`, `rd_d_scan.py`)
esperado: cada afirmación del inventario se confirma o se refuta con un instrumento distinto del original
obtenido: **39 de 39 confirmadas**, 0 refutadas:
- R-01: `git rev-parse 602ea3b^` = `origin/main` = 2db62662…; `cat-file -e refs/stash`, código 128; `.git/worktrees` no existe (código 1). Cabezas del bundle leídas en Python desde su encabezado («# v2 git bundle»): los tres hashes de §2. `git ls-remote origin` sin `--heads`: `HEAD` y `main` 2db6266, `feat/contrato-contexto` 31befa2 y además `refs/pull/1/head` 19a3c40 y `refs/pull/2/head` e86b0d2 (refs de pull request de GitHub, no ramas; ver R-45).
- R-02: `openssl dgst -md5`: encargo fc77f181…, `docs/` 42ab9300… y 883f76bc…, fuentes a7407ed6… y 0257bb4b…; los mismos md5 para `git show HEAD:docs/…`; I-7 en Python sobre `git ls-files -z` = 28.
- R-03, R-11, R-19, R-28, R-30: `git cat-file -p` y `git diff-tree --name-status`. Cadena de padres 2db6266 → 602ea3b → 1c1cd18 → 03c8c6a → 184208a → 4ac0433, con las rutas declaradas en cada commit.
- R-04, R-18, R-22, R-27: los tres comandos de PRUEBAS sobre el estado final (R.5), más la identidad por `git hash-object` (R-39).
- R-05: `git hash-object` de `40_salidas/` = blob de `docs/` en `HEAD` y en `origin/main` (R-39).
- R-06: otra alteración (el **segundo** número decimal del JSON, 16.54 → 16.59, hecha en R sobre `docs/index.html`): `verificar_contenido_motor.R` da «JSON difiere: $datos$pct[[2]] (16.59 vs 16.54)», código 1.
- R-07: en Python, las copias de respaldo son byte a byte los blobs `602ea3b:renv.lock` y `602ea3b:renv/settings.json` (True, True).
- R-08 y R-24: `rd_d_predictor.py` reimplementa en Python la validación de antes y la nueva sobre el listado real (`os.listdir`) de cada copia y compara con el código y el mensaje registrados: **18 de 18 coinciden**. Además, el md5 del paso 31 de las nueve copias del «antes» es el de `602ea3b` (f64a0744…) y el de las nueve del «después», el de `HEAD` (b1840bdf…): cada caso corrió el código que dice.
- R-09: repositorio desnudo nuevo con `git fetch` desde el bundle (no `clone`): las tres ramas con los hashes de §2; 114 commits; `fsck --connectivity-only`, código 0; sha256 del bundle 0371254c47d88458….
- R-10: en Python, sobre los bytes: la primera línea del log es la de procedencia y el resto es igual al original de `gobernanza/v16` (leído del repositorio restaurado); 166 contra 165 líneas; la suite es igual a la de 667e5ad y difiere del `main` anterior en 1 línea; 0 patrones de RUT y 0 «@» en el log.
- R-12: `git log --cherry-mark --right-only main...<rama>` en el repositorio restaurado (con `main` traído por `fetch`): prerebase `=e86b0d2`; normativos 6 `=` y `>98c3f6a`; gobernanza `>667e5ad` y `=e86b0d2`. Python, por archivo de los commits `>`: `documentar.R` y la suite tienen su blob en `main`; POLITICA, igual a la copia local; el log, rescatado (`main` sin su línea 1 = blob original); ESTADO, SETTINGS y los 4 snapshots, sin blob en `main` (clase b por versión, como en K1). **0 (c).**
- R-13: `for-each-ref refs/heads` = `feat/contrato-contexto` y `main`; `.git/refs/heads/` = `feat` y `main`; no hay `packed-refs`; `git config --list` con `gobernanza` o `respaldo`: 0; `feat/contrato-contexto` 31befa2c….
- R-14: la biblioteca de `renv`, leída en Python (nombre, `Version` del `DESCRIPTION` y destino del enlace), es igual a la lista de s35j (`$TMPDIR/s35j/i5_fase0.txt`): 58 paquetes con los mismos nombres y versiones; 56 enlaces al mismo destino en el caché y 2 directorios (`renv` y `suitedoc`, «(directorio)» en s35j); `find -newer` sobre esos dos desde H1: vacío. **La sesión no instaló ni cambió paquetes.**
- R-15, R-16: Python con `json` sobre `git show 602ea3b:` y `HEAD:` (no sobre las copias): `settings.json` cambia solo `ignored.packages` ([] → ["suitedoc"]); lock 40 → 57, R 4.5.1 → 4.5.2; nuevos = los 17; `suitedoc` ausente; 0 quitados; 0 versiones previas cambiadas; único campo previo distinto: `stringi.Repository`; los 17 nuevos con la versión de su `DESCRIPTION` instalado; `V8` 8.2.0, `openssl` 2.4.2, `chromote` 0.5.1 y `openxlsx` 4.2.8.1, CRAN en el lock y en el `DESCRIPTION`; los únicos `Repository` distintos de CRAN: `stringi` y `sys` (Posit Package Manager).
- R-17: `renv::status()` al abrir cada `Rscript` ya no avisa «out-of-sync» (R.5 y las salidas de R.3 no lo traen); `status_despues.txt` = «No issues found»; `ignored.packages()` = suitedoc.
- R-20: `git grep anios_esperados HEAD` fuera de los logs: solo el encargo (3 citas del estado de partida); en el código, 0.
- R-21: `rd_d_scan.py`: en `33_generar_html.R`, `meta <- list(` L201, `insertar_sitio(` L429, `sustituir_anios(` L432 y `transpilar_jsx(app_jsx` L465 (la sustitución va después de `meta` y de insertar el sitio, y antes de transpilar); en `36_generar_trayectorias.R`, `DATA_TRAY <-` L101, `insertar_sitio(` L121 y `sustituir_anios(` L123. Prueba unitaria de `sustituir_anios()` en R (`rd_d_unidad.R`, textos sintéticos): 8 de 8 como se esperaba (sustituye con años desordenados y con lista; se detiene si falta `__ANIO_MAX__`, con `__ANIO_X` y `__ANIO_MAX_` de resto, sin años, con un NA y sin marcadores).
- R-23: Python, por línea: «2025» en ninguna línea de los tres archivos; «2014» solo en la vista L433 y L974; `__ANIO_` en fragmento L85, motor L2592, L4139 y L5074, vista L475.
- R-25: **build completo otra vez**, en una copia nueva con el código final (`k3_final/con2026ambos`: `10_html.R` con el md5 de `HEAD`, c171ed7c…; la copia de K3 tenía la primera versión del patrón): codigo_build_copia_final=0, «Fallas criticas: 0 | Advertencias: 7». En Python, con `–` decodificado, los 6 lugares (fragmento en las dos páginas, d3, periodo, Bases Simce, vista) dicen (2014, 2026) en la copia y (2014, 2025) en `docs/` y en `40_salidas/`; `__ANIO_` 0 en las seis salidas.
- R-26: la prueba unitaria de R-21 cubre los tres modos de falla con otro instrumento (función aislada, no build completo).
- R-29: `git diff -U0 602ea3b HEAD -- manifiesto_insumos.md`, un bloque en L89 (sección desde L87); `git ls-files 20_insumos/simce`, 18 xlsx; `check-ignore`, código 1.
- R-31 a R-37: R.3.
- R-38: R.4.
- R-39: `git hash-object`: `docs/index.html` = `40_salidas/motor_comparacion.html` = base de H6 = `HEAD:docs/index.html` = `origin/main:docs/index.html` = 2554f9a2f5645f5c8acf043bf8b8f69ead0f2cec; `docs/trayectorias.html` = `40_salidas/trayectorias_traspasos.html` = base = `HEAD` = `origin/main` = 7cbbdb7592da0fce09fd739b5d40d4e669a98ed6. `git diff --quiet 602ea3b HEAD -- docs/`, código 0. Red: `grep -c 'http'` = 17 líneas en el motor y 2 en la vista; clasificador en Python con el contexto de cada URL: 23 y 2 `www.w3.org` (espacios de nombres SVG), 1 `reactjs.org` (la cadena de error de ReactDOM), 1 `d3js.org` y 1 `github.com/nodeca/pako` (comentarios de licencia), revisados a mano; `src=`/`href=` con `http` 0, `<a href` externos 0, `fetch`/`import` a `http` 0. **0 cargas por red.**

**R.3 Invariantes 🔒** (`$TMPDIR/cal_s35k/fase_r/invariantes.sh`, salida literal en `invariantes.txt`; comandos de §4 con `|` en vez del `\|` de la tabla)

I-1 `git rev-parse feat/contrato-contexto` y `git ls-remote --heads origin`
esperado: 31befa2…; remoto sin ramas nuevas
obtenido: 31befa2c17efdf7d241699364846d69051c2a326; `ls-remote --heads` = `feat/contrato-contexto` 31befa2c… y `main` 2db62662… → **PASA**

I-2 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 42ab9300… y 883f76bc…
obtenido: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 → **PASA**

I-3 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base», codigo_i3=0 → **PASA**

I-4 md5 de la vista contra `docs/`; motor fuera de `meta$fecha_generacion` (`h6_diff.R`)
esperado: iguales
obtenido: vista 883f76bc… = 883f76bc…; motor «fuera del bloque de datos, idéntico: TRUE», «JSON sin fecha_generacion, identical: TRUE», codigo_i4=0 (y además iguales byte a byte, R-39) → **PASA**

I-5 `md5 -q 10_utils/fuentes/*.otf`
esperado: a7407ed6… (Bold) y 0257bb4b… (Regular)
obtenido: a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc → **PASA**

I-6 `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`
esperado: vacío
obtenido: vacío (código del último `grep`, 1). El primer `grep` solo halla `32_agregar_comunal.R:210` (`.by = c(cod_com_rbd, nom_com_rbd, cod_grupo, anio)`), que agrega por código → **PASA**

I-7 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 → **PASA**

**R.4 Alcance global** (`$TMPDIR/cal_s35k/fase_r/alcance.py` con los ALCANCE de §5 y `fnmatch`, sobre `git diff --name-only`; más `git status --porcelain`)
esperado: dentro de la unión de los ALCANCE más el log; `status` solo con el log
obtenido: `602ea3b..HEAD`: «rutas: 12 | por tarea: K1 2, K2 2, K3 7, K4 1 | fuera: (ninguna)», código 0; con T0 (`602ea3b^..HEAD`): 15 rutas, T0 3, fuera ninguna, código 0. `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260926_ejecucion_decisiones_s35k_log.md` (se commitea en FASE L). Las ramas borradas y `_archivo/20260926_respaldo_ramas_s35k/` (ignorado) están en el ALCANCE de K1 → **PASA**

**R.5 Regresión completa** (estado final, códigos leídos sin tubería)
esperado: build código 0 con 0 críticas; batería código 0 con 35 o más; «JSON idéntico a la línea base»
obtenido: codigo_build=0, «Fallas criticas: 0 | Advertencias: 7», «OK en 6 segundos»; codigo_bateria=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan»; codigo_i3=0, «JSON idéntico a la línea base» → **PASA**

**R.6 Control positivo de la propia auditoría** (`control_positivo.sh`, copias en `$TMPDIR/cal_s35k/fase_r/ctl/`)
esperado: cada instrumento dispara con una cifra alterada y con una ruta fuera de alcance
obtenido: **disparan todos:**
- identidad de lo publicado, con el último año de `DATA$anios` de la vista (2025 → 2026) en una copia: md5 b749c8b1… distinto; `git hash-object` distinto del blob de `HEAD` (código 1); `i4_data_vista.R`, «identical: FALSE», código 1;
- I-3 con el segundo decimal alterado (16.54 → 16.59): «JSON difiere», código 1;
- I-7 con un `.csv` simulado en la lista: 29;
- I-6 con un script simulado `x <- dplyr::group_by(df, nom_com_rbd)` en una copia de `30_procesamiento/`: lo halla (código 0);
- I-5 con un byte de la Bold invertido (XOR 0xFF en el byte 100): 2835e4633b7fb9e42b49c7e24c08abd2 ≠ a7407ed6…. El primer intento escribía `\x00` en ese byte, que ya valía 0: la copia quedó igual y no disparó; se rehízo con XOR (ver errores propios);
- I-1 con el hash de `feat` alterado en una copia de la lista de refs: `diff`, código 1;
- alcance con un diff simulado que agrega `30_procesamiento/32_agregar_comunal.R` y `docs/index.html`: «fuera: […32_agregar_comunal.R', 'docs/index.html']», código 1;
- comparador del lock con `arrow` 24.0.0 → 24.0.1 en una copia: «versiones cambiadas en registros previos (1): arrow»;
- predictor de K3 con el mensaje registrado de `sin2m2024` alterado («faltan años 2023») en una copia: «coincide=False», «coinciden 0 de 1».

**R.7 Veredicto por hallazgo.**
- BLOQUEA: ninguno.
- REPARA: ninguno. Ninguna afirmación se refutó y ningún criterio quedó sin cumplir.
- ADVIERTE: R-40 a R-49 (tabla R.10).

**R.8 Ciclo de reparación.** No hubo (0 REPARA).

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado ni ALCANCE, y no se tocó ningún 🔒. Evidencia ya escrita: dos referencias adelantadas («R-ADV» en K2 y en K3) quedan como están y se resuelven en R-47. En K3 se corrigió un dato (`.gitignore:18` → `:13` y `:14`) antes de cerrar esa sección, con la corrección declarada en sus errores propios. Ninguna otra sección se reescribió. No hubo subagentes.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1-H3 | `rev-parse 602ea3b^`, `cat-file -e refs/stash`, encabezado del bundle en Python, `ls-remote` sin `--heads` | 2db6266; 0; 1; §2 | así, más 2 refs de PR | ADVIERTE (R-45) | registrar | — | — |
| R-02 | md5 e I-7 de partida | `openssl dgst -md5`, `git show HEAD:docs/…`, Python | fc77f181…; 42ab…/883f…; a740…/0257…; 28 | así | — | ninguna | — | — |
| R-03 | T0 | `cat-file -p`, `diff-tree` | padre 2db6266; 3 rutas | así | — | ninguna | — | — |
| R-04 | H5 | R.5 | 35/35 | 35/35 | — | ninguna | — | — |
| R-05 | H6 | `hash-object` | = `docs/` | = `docs/` | — | ninguna | — | — |
| R-06 | calibración I-3 | otro decimal alterado | difiere | difiere | — | ninguna | — | — |
| R-07 | respaldo de K2 | Python contra los blobs de 602ea3b | iguales | iguales | — | ninguna | — | — |
| R-08 | K3 antes | predictor en Python | 9 coinciden | 9 de 9 | — | ninguna | — | — |
| R-09 | bundle | `init --bare` + `fetch`, `fsck --connectivity-only`, `shasum` | 3 refs; 114 | así | ADVIERTE (R-46) | registrar | — | — |
| R-10 | rescate | Python sobre bytes | 1 línea; igual | así | — | ninguna | — | — |
| R-11 | commit K1 | `cat-file`, `diff-tree` | padre 602ea3b | así | — | ninguna | — | — |
| R-12 | 0 (c) | `log --cherry-mark` en el restaurado; Python por blob | 0 | 0 | — | ninguna | — | — |
| R-13 | borrado | `for-each-ref`, `.git/refs/heads`, `config --list` | feat y main | así | — | ninguna | — | — |
| R-14 | prueba de K2 sin tocar la biblioteca | lista de la biblioteca en Python contra s35j | igual | 58 = 58 | — | ninguna | — | — |
| R-15 | settings | Python (`json`) sobre git | solo `ignored.packages` | así | — | ninguna | — | — |
| R-16 | lock | Python (`json`) sobre git y `DESCRIPTION` | 57; 17; 0 versiones | así; `stringi` y `sys` con PPM | ADVIERTE (R-40) | registrar | — | — |
| R-17 | status | ausencia del aviso en R.5; `status_despues.txt` | consistente | así | — | ninguna | — | — |
| R-18 | regresión K2 | R.5 | PASA | PASA | — | ninguna | — | — |
| R-19 | commit K2 | `cat-file` | padre 1c1cd18 | así | — | ninguna | — | — |
| R-20 | paso 31 | `git grep anios_esperados HEAD` | 0 en código | 0 | ADVIERTE (R-42, R-43) | registrar | — | — |
| R-21 | marcadores y llamadas | Python por línea; prueba unitaria en R | orden; 8 casos | así | — | ninguna | — | — |
| R-22 | I-4 tras K3 | `hash-object` | = `docs/` | = `docs/` | — | ninguna | — | — |
| R-23 | `grep` de literales | Python por línea | 0 × 2025 | 0; 2014 en L433 y L974 | ADVIERTE (R-41) | registrar | — | — |
| R-24 | K3 después | predictor en Python | 9 coinciden | 9 de 9 | — | ninguna | — | — |
| R-25 | 2026 sin editar código | build en copia nueva con el código final; Python | 2014–2026 en 6 lugares | así | ADVIERTE (R-44) | registrar | — | — |
| R-26 | controles de marcadores | prueba unitaria | 3 modos de falla | así | — | ninguna | — | — |
| R-27 | batería e I-3 tras K3 | R.5 | PASA | PASA | — | ninguna | — | — |
| R-28 | commit K3 | `cat-file`, `diff-tree` | 7 M | así | — | ninguna | — | — |
| R-29 | manifiesto | `diff -U0 602ea3b HEAD`, `ls-files` | 1 bloque; 18 | así | — | ninguna | — | — |
| R-30 | commit K4 | `cat-file` | padre 184208a | así | — | ninguna | — | — |
| R-31 a R-37 | I-1 a I-7 | R.3 | PASA | PASA | — | ninguna | — | — |
| R-38 | alcance | `alcance.py` | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-39 | identidad y red | `hash-object`; `grep -c http` + Python y revisión | iguales; 0 cargas | iguales; 0 cargas | — | ninguna | — | — |
| R-40 | `renv.lock` registra `stringi` (registro previo, misma versión 1.8.7) y `sys` (nuevo) con `Repository` = `https://packagemanager.posit.co/cran/latest`, porque así se instalaron (`DESCRIPTION`: `Repository: RSPM`, 2026-06-17). Es un espejo público de CRAN y los dos paquetes están en CRAN, pero `renv::restore()` en otra estación no se probó (no autorizado) | `rd_c.py` | — | 2 con PPM | ADVIERTE | registrar (D2-b) | — | — |
| R-41 | la vista trae `<div class="yr" id="yr">2014</div>` (L433), un valor inicial que el script reemplaza al dibujar (L1066). No es uno de los 5 literales de rango, pero si la serie empezara en otro año, ese texto se vería un instante antes del primer dibujo, o siempre si no corre el script | `rd_d_scan.py`, lectura | — | 1 | ADVIERTE | registrar | — | — |
| R-42 | D3-a: el hueco se mide entre el primer y el último año presentes. Si se quita 2014 de los dos niveles, el build pasa y el rango dice 2015–2025. La regla «un año anterior a `ANIO_INICIO`» no fija el inicio | predictor | — | por diseño | ADVIERTE | registrar | — | — |
| R-43 | `ANIOS_SIN_SIMCE` (paso 31) repite el literal `anios_sin_simce = c(2019L, 2020L, 2021L)` de `meta` en `33_generar_html.R` L204: el mismo hecho en dos lugares. Unificarlo pide un lugar común (`10_configuracion.R`, fuera del ALCANCE) | `grep` | — | 2 fuentes | ADVIERTE | registrar | — | — |
| R-44 | un año nuevo ya no exige editar código del build, pero sí revisar `ANIO_DATOS_VIGENTE <- 2025L` (paso 30, por diseño: depende del directorio de MINEDUC) y actualizar textos fuera del ALCANCE que citan el rango fijo: `README.md` L134, `documentar.R` (L58, L98, L100, L275, L324), `50_datos_versionados_autorizados.md` L24-26 y las tablas del manifiesto | `git grep` | — | 5 archivos | ADVIERTE | registrar | — | — |
| R-45 | el remoto tiene `refs/pull/1/head` (19a3c40) y `refs/pull/2/head` (e86b0d2), refs de pull request de GitHub anteriores a la sesión; no son ramas y no cambian I-1. e86b0d2 (la de `respaldo_prerebase_20260824`) sigue en GitHub por esa ref | `ls-remote origin` | — | 2 refs | ADVIERTE | registrar | — | — |
| R-46 | tras el borrado, 667e5ad ya no es alcanzable desde ninguna ref local (`for-each-ref --contains`, 0) ni remota conocida: su única copia es el bundle de `_archivo/` (ignorado, solo en esta estación) más los objetos sueltos hasta el próximo `git gc`. Su contenido único ya está en `main` (log y suite) o superado | `for-each-ref --contains`, `cat-file -t` | — | solo el bundle | ADVIERTE | registrar | — | — |
| R-47 | las secciones K2 («Ver D2-b y R-ADV») y K3 («Ver R-ADV (L433)») citan «R-ADV» porque se escribieron antes de numerar esta auditoría: la de K2 es R-40 y la de K3, R-41. No se editan | lectura del log | — | 2 citas | ADVIERTE | registrar | — | — |
| R-48 | errores propios de instrumento, todos corregidos antes de registrar: `PIPESTATUS` de bash en zsh (K1); `rev-parse main:<ruta>` sin `--verify` (K1); `grep -o` sin el guion escapado de Babel (K3); `print()` de `renv::status()` (FASE 0); control de I-5 con un byte que ya valía 0 (R.6); `.gitignore:18` escrito sin medir (K3, corregido en la sección); `rm -rf` en `copia.sh` (quitado antes de ejecutarse) | — | — | corregidos | ADVIERTE | registrar | — | — |
| R-49 | no se creó CLAUDE.md: la regla global lo pide, pero §11 lo excluye (D2), como en s35 a s35j | — | — | D2 | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA ni REPARA. Las 39 afirmaciones del inventario quedaron confirmadas con instrumentos distintos: Python en vez de `md5`, `grep` y R; `fetch` a un repositorio nuevo en vez de `clone`; `--cherry-mark` en el repositorio restaurado; un predictor de las reglas; una prueba unitaria; y un build completo otra vez con el código final. Los controles positivos dispararon los nueve, uno tras corregir su propia alteración. Los siete 🔒 están en PASA. Hay 10 ADVIERTE (R-40 a R-49), ninguno sobre datos, invariantes ni alcance. Los que más pesan: R-40 (dos paquetes registrados desde Posit Package Manager; la restauración en otra estación no se probó), R-42 (un inicio de serie faltante en los dos niveles pasa) y R-46 (667e5ad queda solo en el bundle local).

## Cierre

### 1. Resumen

Las tres decisiones se ejecutaron sin tareas congeladas, y el sitio publicado no cambió: `docs/` no se tocó, y el build de hoy reproduce `docs/` byte a byte.
- **K1 (D35-17).** Tres ramas locales menos (`respaldo_prerebase_20260824`, `respaldo_normativos_20260824` y `gobernanza/v16`), borradas después de:
  - un respaldo verificado dos veces (`git bundle verify` y una restauración con `fsck`);
  - rescatar a `main` el log del contrato de contexto (con una línea de procedencia) y la suite standalone de 667e5ad;
  - comprobar que no quedaba ningún archivo único y vigente (0 de clase c).
  `feat/contrato-contexto` no se tocó.
- **K2 (D35-18).** `suitedoc` queda fuera del lock (`ignored.packages`). `renv::snapshot()` ya no aborta: registró los 17 paquetes de CRAN que faltaban (entre ellos `V8`, `openssl`, `chromote` y `openxlsx`) y pasó el lock de 40 a 57 paquetes, sin cambiar ninguna versión. `renv::status()` queda consistente. El lock registra ahora R 4.5.2. `stringi` y `sys` quedan registrados desde Posit Package Manager, su origen real (R-40).
- **K3 (D35-19).**
  - El paso 31 deriva los años de los nombres de archivo. Se detiene si hay un año repetido en un nivel, uno anterior a `ANIO_INICIO` o de `ANIOS_SIN_SIMCE`, un hueco, o un año que un nivel tiene y el otro no.
  - Los 5 literales de rango son marcadores que `sustituir_anios()` reemplaza con los años de los datos; un marcador sin sustituir o ausente detiene el build.
  - Con los insumos de hoy, las salidas son iguales a `docs/`. Con 2026 plantado en los dos niveles, el build pasa sin editar código y los rangos dicen 2014–2026.
- **K4 (Q-72).** El manifiesto dice que los 18 xlsx Simce se versionan y están autorizados.

FASE R: 39 de 39 afirmaciones confirmadas con otros instrumentos; 9 controles positivos disparan; los 7 🔒 en PASA; 0 BLOQUEA, 0 REPARA, 10 ADVIERTE. Veredicto: **APROBADO CON ADVERTENCIAS**.

### 2. Inventario de commits (`git log 602ea3b..HEAD --oneline`, antes del commit de este log)

```text
4ac0433 docs(insumos): el manifiesto dice que los xlsx Simce se versionan (Q-72)
184208a refactor(pipeline): los anos y los rangos se derivan de los insumos (D35-19)
03c8c6a chore(renv): registra los paquetes de CRAN que faltaban y deja suitedoc fuera del lock (D35-18)
1c1cd18 docs(ramas): rescata el log del contrato y la suite standalone de gobernanza/v16 (D35-17)
```

Más el punto de retorno, `602ea3b docs(sesion 35): encargo de la undecima ola y decisiones D35-17 a D35-19` (T0), y el commit de este log, `docs(log): ejecucion de las decisiones D35-17 a D35-19 (s35k)`, cuyo hash va en el reporte final (un archivo no puede llevar el hash de su propio commit). Sin commits `fix(auditoria)`: no hubo REPARA.

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-49).

### 4. Invariantes

I-1 a I-7 en PASA en el estado final (FASE R, R.3), con re-derivación por otra vía (R.2, R-39) y controles positivos que disparan (R.6). En ninguna tarea un 🔒 dio FALLA. Antes del push se miden otra vez I-1 e I-2 (condiciones de la autorización 6; reporte final).

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 del encargo (fc77f18139732fb001d8855811a99217, verificado).
- En el encargo: D35-17, D35-18 y D35-19 (commiteadas en T0), y las autorizaciones 1 a 6.
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión; git 2.54.0, R 4.5.2, `renv` 1.1.4, Python 3)

- Ramas locales: 4 → 2 (`feat/contrato-contexto` 31befa2, `main`). Bundle: 3 refs, 114 commits, 29.637.862 bytes (md5 cbac7ec0…). Archivos de clase (c) antes de borrar: 0 (gobernanza: a 4, b 5; normativos: b 1; prerebase: ninguno).
- Rescate: el log pasa de 165 a 166 líneas (1 agregada) y la suite cambia 1 línea respecto del `main` anterior.
- Lock: 40 → 57 paquetes; 17 agregados; 0 versiones cambiadas; 1 campo previo cambiado (`stringi.Repository`); R 4.5.1 → 4.5.2. `renv::status()`: 18 paquetes usados y no registrados → 0. Biblioteca: 58 paquetes, sin cambios en la sesión.
- Paso 31: 18 archivos, 9 por nivel, años 2014-2018 y 2022-2025; 185.378 filas (205.668 en la copia con 2026). Copias: 9 casos × 2 (antes y después) + 1 build con 2026 + 3 controles de marcadores; el predictor en Python coincide en 18 de 18.
- Plantillas: 0 «2025»; 5 líneas con marcadores; 2 «2014» fuera de los 5 lugares (vista L433 y L974).
- `docs/` y `40_salidas/`: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 (blobs 2554f9a2… y 7cbbdb75…), sin cambio; 0 cargas por red. Validador del build: 0 críticas y 7 advertencias. Batería: 35 de 35. I-7: 28.

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno.

Dudas nuevas (una por advertencia que pide una decisión; se responden con una palabra):
- Q-73 (R-40). `renv.lock` registra `stringi` y `sys` desde Posit Package Manager (así se instalaron), y `renv::restore()` no se probó en otra estación. ¿Se prueba la restauración en una biblioteca vacía en un encargo propio? (sí / no)
- Q-74 (R-42). Si faltara 2014 en los dos niveles, el build pasaría con el rango 2015–2025. ¿Se fija el inicio de la serie en `ANIO_INICIO`, de modo que el build se detenga? (fijar / dejar)
- Q-75 (R-43, R-44). `ANIOS_SIN_SIMCE` repite un literal del paso 33, y cinco documentos citan el rango fijo (README, `documentar.R`, lista de autorizados, tablas del manifiesto). ¿Se unifica la constante en `10_configuracion.R` y se ponen al día esos textos en un encargo corto? (sí / no)

Pendientes que quedan al titular: el traspaso de cierre (Q-71: describir `suitedoc` como «en remoto privado», no «sin remoto») y Q-70 (el R huérfano de `slep-central-datos`, que detiene el titular). Excluidos por §11 y sin tocar: la regeneración de la suite con `documentar.R`, Museo Sans en la suite (D35-7) y CLAUDE.md (D2).

`# REVISAR` nuevos: ninguno (`grep -rn "# REVISAR"` sobre los archivos cambiados, código 1; `git diff 602ea3b HEAD | grep -c REVISAR` = 0).

### 8. Errores propios consolidados

- De instrumento, corregidos antes de registrar resultados:
  - `PIPESTATUS` de bash en zsh (K1);
  - `rev-parse main:<ruta>` sin `--verify` (K1);
  - `grep -o` sin prever el `–` de Babel (K3);
  - `print()` del valor de `renv::status()` (FASE 0);
  - el control de I-5 con un byte que ya valía 0 (R.6);
  - un `rm -rf` en `copia.sh`, quitado antes de ejecutarse (FASE 0).
- De redacción:
  - «`.gitignore:18`» en K3, escrito sin medir; corregido en la misma sección antes de cerrarla y declarado allí;
  - dos referencias «R-ADV» adelantadas en K2 y K3, resueltas en R-47 sin editarlas.
- Ninguno tocó el producto ni los datos.

### 9. Notas para el revisor

- El riesgo que esta sesión no pudo medir es la restauración del lock en otra estación (R-40, Q-73): `renv::restore()` no estaba autorizado. Lo que sí se midió: el lock nuevo es igual al de la prueba en la copia, cada versión registrada es la instalada y `renv::status()` queda consistente.
- D3-a (R-42) es una lectura de «entre el primero y el último» del encargo: se midió entre los años presentes. Si el titular prefería `ANIO_INICIO` como primer año obligatorio, es un cambio de una línea (Q-74).
- 667e5ad queda solo en el bundle de `_archivo/20260926_respaldo_ramas_s35k/` (ignorado, local). Su contenido único ya está en `main` o superado (R-46).
- La sustitución del motor va antes de transpilar el JSX. Por eso el motor sale byte a byte igual: Babel recibe el mismo texto que antes.
- Verificación del archivo (FASE L, paso 5): `^esperado:` cuenta 39 y `^obtenido:` 43. Las 4 líneas `obtenido:` sin su `esperado:` son los registros de commit de K1 (L145), K2 (L216), K3 (L296) y K4 (L324), con la numeración del archivo cerrado. Su esperado implícito es un commit con el mensaje del encargo y las rutas del ALCANCE de la tarea, y los cuatro lo cumplen (R-11, R-19, R-28, R-30). Se deja el conteo como está.

### 10. Estado de cierre

- **Commiteado:** T0 (`602ea3b`), K1 (`1c1cd18`), K2 (`03c8c6a`), K3 (`184208a`), K4 (`4ac0433`) y, al cerrar esta sección, este log (`docs(log)`), en `main`.
- **Borrado local:** `respaldo_prerebase_20260824`, `respaldo_normativos_20260824` y `gobernanza/v16`, respaldadas en `_archivo/20260926_respaldo_ramas_s35k/`.
- **Condiciones de publicación** (autorización 6), medidas después del commit del log, en el mismo turno: veredicto de FASE R `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío; `git fetch origin` y `git merge-base --is-ancestor origin/main HEAD` con código 0; md5 de `docs/` sin cambio (I-2); I-1 antes del push. Si se cumplen, `git push origin main` una sola vez; si no, se declara en el reporte final. El resultado del push y el hash de este commit van en el reporte final.
- **Queda al titular:** el traspaso de cierre (Q-71), Q-73 a Q-75 y Q-70.
- **Verificación del archivo** (antes del commit): `^### FASE` cuenta 6 (FASE 0, K1, K2, K3, K4 y R; FASE L es este «Cierre»); `^## J` cuenta 1; `^esperado:` 39 y `^obtenido:` 43 (ver §9); `ls -l` y `wc -l` en el reporte final.
