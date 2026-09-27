# Log: enlaces del README, `.Renviron.example` y columna COD_DEPE (s35q) (slep_simce_adecuado)

- Meta: el README publicado sin enlaces rotos, `.Renviron.example` sin lo que el proyecto no usa y el paso 30 validando todas las columnas del directorio que lee; las salidas no cambian.
- Fecha: 2026-09-26 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: el commit de T0; su hash se mide y se anota en FASE 0, H4 (este encabezado se escribe antes de T0 y no se edita después). `HEAD` al empezar: `8f10463` (`git log --oneline -3` del primer comando de la sesión; se mide otra vez en H3).
- Encargo: `50_documentacion/activa/encargos/encargo_enlaces_renviron_s35q.md`, md5 `8c2d00f38048e7c05ddc70ade905e0cb` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega; se mide otra vez en H4). Kit: `herramientas_dev/prompts/encargo_autonomo_claude_code_v1.md` (v1.6, md5 f82913d7a35baaaa6983ebddf23116f6), solo lectura.
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`); modo de sesión: ultracode; subagentes usados: 0, por contrato (kit v1.6, §2.12 regla 1): sin subagentes ni Workflow, todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, Q1, Q2, Q3, FASE R, FASE L con el push. Plan de concurrencia: sin subagentes.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Carpetas de trabajo: `$TMPDIR/s35q/` (instantáneas de I-1 e I-4), `$TMPDIR/cal_s35q/` (lecturas, instrumentos, calibración, copias, controles y parches) y `$TMPDIR/base_s35q/` (las dos salidas del build de H5). `$TMPDIR` = `/var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/`.
- Plantilla (Apéndice del encargo): después de este encabezado y del slot J, se anexan en orden una sección por fase (FASE 0, FASE Q1, FASE Q2, FASE Q3 y FASE R) y el Cierre con sus diez puntos (resumen, inventario de commits, tabla de auditoría, invariantes, decisiones del usuario, estado de cifras, dudas y pendientes, errores propios, notas para el revisor y estado de cierre). Cada sección por fase lleva Estado, Commits, Cambios sustantivos, Verificación con `esperado:` y `obtenido:`, Alcance, Regresión, Subagentes, Bugs, Decisiones autónomas, Errores propios y Dudas.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: D35-26 (Q-95 a Q-98) &rarr; cumplida: el README sin enlaces rotos (6 de 6 destinos relativos existen y están versionados), `.Renviron.example` sin la raíz de datos (0 líneas; fija solo `LANG`, como antes) y el paso 30 validando las 11 columnas del directorio que usa; las salidas no cambian (42ab9300…/883f76bc…).
- Estado por tarea: T0 completa (f7e966a) · Q-96 medida (0 aciertos como palabra completa) · Q1 completa (d8ba99d) · Q2 completa (43aede2) · Q3 completa (a238458) · FASE R y FASE L completas.
- Commits: 5, de f7e966a al `docs(log)` de este archivo (T0, Q1, Q2, Q3 y el log; hash en el reporte final), de los cuales 0 `fix(auditoria)`.
- Auditoría (FASE R): APROBADO CON ADVERTENCIAS; hallazgos B/R/A = 0/0/5; reparados 0; abiertos 0 (ADVIERTE R-18 a R-22); 17 de 17 afirmaciones confirmadas con otros instrumentos; 12 controles positivos disparan.
- Invariantes: 4/4 PASA (R.3, y I-1, I-2 e I-4 otra vez en FASE L); FALLA: ninguno.
- Cifras críticas: intactas: `docs/` 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…), `40_salidas/` igual a la base por I-3 y `cmp`, `renv.lock` e6323bf2…; el directorio oficial sin tocar (3778137 B; el control de Q3 usó una copia, borrada al terminar).
- Decisiones autónomas de mayor riesgo: D2-b, editar `.Renviron.example` aunque §6.2 del protocolo de la cartera pide las opciones A y B (descartada: congelar Q2 contra D35-26; registrada en Q-99); D3-c, borrar las dos copias del CSV, que traen MRUN, tras el control (descartada: dejarlas en `$TMPDIR`); D0-a, las viñetas de D35-26 tal cual, con su negrita (descartada: pasarlas al formato `- Q-NN: …`).
- Desviaciones respecto del encargo: ninguna en tareas, criterios, tolerancias ni ALCANCE; dos valores que el orquestador agregó al criterio de Q2 no coincidieron con lo medido (7 por 5; L1-26 por L1-27), sin efecto sobre lo que miden.
- Dudas abiertas: 2: Q-99 (¿se anota en el protocolo de la cartera que §6.2 y §12 paso 3 aplican solo a los proyectos de Rama B?) y Q-100 (¿se deja `50_locale_utf8.md` como registro fechado, con su cita a `.Renviron.example:29`?), las dos sí / no.
- Errores propios: 7 registrados (§8 y paso 5): tres valores escritos antes de medirlos (dos del criterio de Q2 y el intervalo de R.2, corregido con una línea nueva), tres de instrumento (una prueba contra una raíz equivocada, el `awk` de R-09 y dos códigos leídos detrás de una tubería) y uno de formato (tres rótulos «obtenido (», anexados en el paso 5); ninguno costó más de un turno.
- Qué debe verificar el revisor por sí mismo: el README («Documentación») y `.Renviron.example` publicados en GitHub; la respuesta a Q-99; la identidad de `docs/` con `40_salidas/` (`git hash-object`, un comando).
- No publicado / queda al usuario: el push de `main` va en el reporte final (condiciones de la autorización 6); el traspaso de cierre, Q-70, Q-71, Q-99 y Q-100.
- Ejecución: modo de sesión ultracode; subagentes 0, por contrato (sin Workflow); orquestador Opus 5.5 en serie, esfuerzo xhigh declarado; git 2.54.0, R 4.5.2 con `renv`, Python 3.14.7, Chrome sin interfaz vía `chromote`; desde las 23:05:54 hasta el paso 5 de FASE L (su `date`; el commit del log y el push, en el reporte final).

### FASE 0: log, punto de retorno y premisas

Inicio de FASE 0: 2026-09-26 23:05:54 (`date` del comando que creó las carpetas de trabajo). Antes, lectura de los insumos, sin ningún comando de escritura en el árbol: este encargo (md5 verificado); `CLAUDE.md` (70 líneas por `wc -l`, md5 b3fd118cbecd3edac1a2458a75dd513d); el log de s35p entero (§7, Q-95 a Q-98, P1 y P5, R-19 a R-24); el kit v1.6 (§2.7, §2.8, §2.12 y §4); `README.md` (328 líneas por `wc -l`; `sed -n 225,262p`); `.Renviron.example` (34 líneas por `wc -l`; `cat -n`); `10_utils/10_validar_portabilidad.R` (388 líneas; L1-12 y L240-290); `30_procesamiento/30_construir_auxiliares.R` (460 líneas; L140-182, L322-345 y `grep -n 'COD_DEPE\|cols_csv_esperadas\|Faltan columnas'`); el archivo de decisiones (306 líneas); el `git diff` del registro de errores (11 líneas agregadas: ERR-35-29). Lo que esas lecturas dicen de las premisas se mide otra vez abajo o en cada tarea, con su `esperado:` escrito antes.

**Paso 1.** Log creado antes de H1, con el encabezado, el slot J vacío y la plantilla; por eso H1 muestra también la línea del propio log. Cada `esperado:` se escribe en el log antes de correr su comando (regla de pre-registro). Las correcciones se anexan como línea nueva que cita a la anterior (kit, §4.3 regla 4).

**H1.** `git status --porcelain` (salida en `$TMPDIR/cal_s35q/f0/h1.txt`)
esperado: exactamente ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md` y `?? 50_documentacion/activa/encargos/encargo_enlaces_renviron_s35q.md`, más el log
obtenido: status_codigo=0, las dos líneas esperadas más el log (3 líneas):
```text
 M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_enlaces_renviron_s35q.md
?? 50_documentacion/andamios/logs/20260926_enlaces_renviron_s35q_log.md
```
**Cumple.**

**H2.** `git stash list | wc -l` y `git worktree list`
esperado: 0; solo el árbol principal
obtenido: stash_codigo=0, 0 líneas; `/Users/tomgc/Projects/slep_simce_adecuado 8f10463 [main]` (wt_codigo=0). **Cumple.**

**H3.** `git fetch origin`; después `git rev-parse --short HEAD` y `git rev-parse --short origin/main`, en dos comandos. Instantáneas: I-1 (`git for-each-ref --format='%(refname) %(objectname)'`, `$TMPDIR/s35q/i1_fase0.txt`) e I-4 (`md5 -q renv.lock renv/settings.json`, `$TMPDIR/s35q/i4_fase0.txt`)
esperado: fetch sin error; 8f10463 y 8f10463
obtenido: fetch_codigo=0 (sin salida); `8f10463` (c1=0) y `8f10463` (c2=0). `git ls-remote --heads origin` (lsr=0): `feat/contrato-contexto` 31befa2c… y `main` 8f104631…. I-1 de partida (`i1_fase0.txt`, i1_codigo=0):
```text
refs/heads/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/heads/main 8f104631166b99e62f4090513e3dc3c6be52691d
refs/remotes/origin/HEAD 8f104631166b99e62f4090513e3dc3c6be52691d
refs/remotes/origin/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/remotes/origin/main 8f104631166b99e62f4090513e3dc3c6be52691d
```
I-4 de partida (`i4_fase0.txt`, i4_codigo=0): `renv.lock` e6323bf2d0fb341589c4ce8a19b74636 y `renv/settings.json` d0bcb98db909870724e9b0fc5eff1700, los mismos de s35p (23:06:32). **Cumple.**

**H4.** `md5 -q` del encargo y de `docs/`; después, la sección `### D35-26` en el archivo de decisiones, `git add` de las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decimoseptima ola y decision D35-26"` (el `git add` y el commit solo corren si los tres md5 son los esperados: la cadena compara con `test` antes de seguir)
esperado: 8c2d00f38048e7c05ddc70ade905e0cb (mensaje de entrega); 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3; un commit con las tres rutas (M del registro de errores, M del archivo de decisiones y A del encargo), padre 8f10463; después, `git status --porcelain` = solo este log
obtenido: encargo 8c2d00f38048e7c05ddc70ade905e0cb (m1=0); `docs/index.html` 42ab93003e722f9bb6c725fec2d348bd y `docs/trayectorias.html` 883f76bcefc89d93f2d1e753fc4d75c3 (m2=0); comparación con `test`, md5_iguales=0. La comparación corrió primero en un comando propio y se repitió con `test` al inicio de la cadena que edita y commitea. El archivo de decisiones (md5 de partida bd3a93c4e5109a412244ce28c72be19e, 306 líneas) recibe al final un encabezado `## Decisiones del titular tras el encargo `encargo_documentacion_s35p.md` (sesión 35, 2026-09-26)` y la sección `### D35-26. Enlaces del README, `.Renviron.example`, `json_motor` y `COD_DEPE`` con las cuatro viñetas del Contexto del encargo, en su orden (Q-97, Q-95, Q-96 y Q-98), copiadas tal cual con sus líneas unidas (dec_codigo=0; `--numstat` 9 0; md5 nuevo 606f5606e5f5ad6ebce23a8185d668fa). T0: commit_codigo=0, `f7e966a docs(sesion 35): encargo de la decimoseptima ola y decision D35-26`, padre `8f10463`, «3 files changed, 346 insertions(+)» (9 + 326 + 11); `git show --name-status` = `M …/20260924_decision_referente_traspasos.md`, `A …/encargo_enlaces_renviron_s35q.md` y `M …/20260924_sesion35_errores_asistente.md`; `git status --porcelain` = solo este log (23:07:16). **Punto de retorno: f7e966a** (f7e966a11b77a98d9dca12e9560e449a87bd4658). **Cumple.**

**H5.** `cd "$RAIZ" && Rscript 00_build.R` (salida en `$TMPDIR/cal_s35q/f0/h5_build.txt`); después, copia de `40_salidas/motor_comparacion.html` y `40_salidas/trayectorias_traspasos.html` a `$TMPDIR/base_s35q/`; lo que dice el validador de portabilidad sobre `.Renviron.example`
esperado: código 0; «Fallas criticas: 0»; las dos salidas escritas y copiadas; `git status --porcelain` = solo este log
obtenido: **build_codigo=0** (23:07:29 a 23:07:37; «=== 00_build.R: OK en 6 segundos ===»; 286 líneas de salida). Validación de portabilidad al inicio: «Archivos escaneados: 33», «Fallas criticas: 0 | Advertencias: 7» (seis `separador_manual` y un `system_shell`: `00_escanear_proyecto.R` L101 y L184, `10_html.R` L175, `10_locale.R` L27, `36_generar_trayectorias.R` L88 y L165, `36_verificar_trayectorias.R` L955, los de s35p); los ocho checks de entorno en OK, con `data_root_resuelto` «Resuelto por ruta_insumos()». Pasos: 30 OK (directorio con 16768 filas leídas, AGNO 2025; slep_cc_establecimientos 73, comunas_chile 345, sleps_chile 2337 y establecimientos_chile 10945 filas); 31 «18 archivos detectados (9 por nivel)», 185378 filas; 32 44975 filas (14 columnas); 33 escribe `motor_comparacion.html` (2866 KB); 36 escribe `trayectorias_traspasos.html` (2.21 MB). Copia a `$TMPDIR/base_s35q/`: cp_codigo=0; md5 de la base **42ab93003e722f9bb6c725fec2d348bd** (motor) y **883f76bcefc89d93f2d1e753fc4d75c3** (vista), iguales a los de `docs/` (el `meta$fecha_generacion` del motor es el día, 2026-09-26, el de lo publicado; A34-1). `git status --porcelain` = solo este log. **Cumple.**

**Lo que dice el validador sobre `.Renviron.example`** (anotado para Q2): un solo check, `renviron_example` en **OK** (L248-249 de `10_validar_portabilidad.R`: `file.exists(file.path(raiz, ".Renviron.example"))`; «.Renviron.example ausente en la raiz del repo» es su mensaje de falla, que no aplica). El escaneo estático no lo lee: `.vp_extensiones` (L26) es `\\.(R|r|Rmd|rmd|qmd|ya?ml)$` y `.Renviron.example` termina en `.example`. La sección «Checks de entorno» completa de H5 queda guardada como referencia de Q2 (`$TMPDIR/cal_s35q/f0/h5_entorno.txt`, 19 líneas, md5 190b17a15a28d0721165d12a3194ea2c, 8 checks en OK).

**Paso 6b. Instrumento de I-3, calibrado antes de editar** (`$TMPDIR/cal_s35q/instrumentos/`: `i3_salidas.R`, copia del `i4.R` de s35p con las dos líneas de cabecera cambiadas y el cuerpo idéntico, `diff` código 0; `plantar_i3.R`, copia de `plantar_i4.R` con los nombres de carpeta cambiados, arma las copias de control)
- `i3_salidas.R <dir_base> <dir_actual>`: la vista con `identical()` de los bytes; el motor, con el JSON decodificado sin `meta$fecha_generacion` y el resto del HTML con el bloque base64 reemplazado por un marcador (A34-1); código 0 si las tres comparaciones dan TRUE.
esperado: código 0 con la base contra sí misma, contra `40_salidas/` y contra una copia que solo cambia la fecha; código 1 con un dato del JSON, un byte fuera del bloque o un byte de la vista
obtenido: calibración en `$TMPDIR/cal_s35q/calibracion/` (salida en `calibracion.txt`; fecha del JSON «2026-09-26»; plantar=0): base contra base, TRUE/TRUE/TRUE, c=0; contra `40_salidas/`, c=0; solo la fecha cambiada a 1999-01-01 (JSON recodificado), c=0; un campo `"control":1` en `meta`, «motor JSON sin fecha: FALSE», **c=1**; un espacio antes de `</title>`, «motor resto del HTML: FALSE», **c=1**; un byte agregado a la vista, «vista byte a byte: FALSE», **c=1** (23:08:40). Las cuatro copias de control difieren de verdad de la base (`cmp -s`, código 1 en las cuatro), también la de la fecha, que el instrumento debe tolerar.
**Cumple:** el instrumento distingue lo que debe.

**Paso 7. Q-96.** `git grep -nw 'json_motor' -- ':!50_documentacion'` (salida completa, sin `head`, en `$TMPDIR/cal_s35q/f0/q96.txt`)
esperado: 0 aciertos (código 1 de `git grep`)
obtenido: **0 aciertos** (gitgrep_codigo=1, A34-3; `q96.txt` con 0 líneas). Contraste, sin `-w` (`q96_subcadena.txt`, código 0): 2 aciertos, los de s35p, `30_procesamiento/33_verificar_motor.R:269:extraer_json_motor <- function(texto) {` y `…:281:meta_motor <- intentar(extraer_json_motor(html)$meta)`; el patrón existe como subcadena y la búsqueda como palabra completa lo descarta (23:08:53). **Cumple:** el criterio de P4 de s35p sobre `json_motor`, medido como palabra completa (D35-26, Q-96), queda cumplido.

**Estado:** completa (23:05:54 a 23:08:53). **Commits:** `f7e966a` (T0). **Cambios sustantivos:** la sección D35-26 en el archivo de decisiones y el commit de T0 (encargo, registro de errores con ERR-35-29 y decisiones); nada en el producto. **Alcance:** las tres rutas de T0 (commit); todo lo demás, en `$TMPDIR`. **Regresión:** el build de H5 es la base de I-3. **Subagentes:** 0 (sin subagentes, por contrato). **Bugs:** ninguno.

**Decisiones autónomas:**
- D0-a (riesgo bajo, reversible): la sección de D35-26 lleva, como las anteriores del archivo, un encabezado `## Decisiones del titular tras el encargo …` (el de s35p, que dejó las cuatro dudas) y un título propio, que el encargo no fija; las cuatro viñetas son las del Contexto, copiadas tal cual (con su negrita y en su orden: Q-97, Q-95, Q-96 y Q-98), y no pasadas al formato `- Q-NN: …` de las secciones anteriores. Alternativa descartada: reescribirlas en ese formato, que cambia el texto que el titular aprobó.
- D0-b (riesgo bajo): I-3 se mide con el instrumento de s35p (su I-4), copiado y recalibrado aquí.

**Errores propios:** ninguno. **Dudas:** ninguna en FASE 0.

### FASE Q1: el README sin enlaces a los documentos archivados (Q-97)

Inicio: 23:09:03 (`date` del comando que cerró FASE 0). ALCANCE: `README.md`. Copias de partida (de `f7e966a`, el árbol sin cambios) en `$TMPDIR/cal_s35q/antes/`: `README.md`, `Renviron.example` y `30_construir_auxiliares.R`.

**Paso 1. Línea base, antes de editar** (salidas en `$TMPDIR/cal_s35q/q1/`). El `git grep -l` de §2: `git grep -lE 'documentacion_proyecto_slep_simce_adecuado\.(md|html)|activa/arquitectura_slep_simce_adecuado' -- ':!50_documentacion/andamios' ':!50_documentacion/traspasos' ':!50_documentacion/activa/encargos' ':!50_documentacion/estructura'` (salida completa, sin `head`); y `grep -n` del mismo patrón sobre el README
esperado: solo `README.md`; en el README, L246, L249 y L252 (la entrada del `.md`, que nombra también el `.html`, y la de `arquitectura_…html`)
obtenido: `git grep -l`, gitgrep_codigo=0, **una sola ruta: `README.md`** (`base_gitgrep.txt`, 1 línea; 23:09:30). En el README (`base_readme.txt`, grep_codigo=0): **L246, L249 y L252**, las de la premisa. **Cumple** (la premisa de §2 Q-97 se confirma).

**Paso 2. Edición.** Se quitan L246-256 (11 líneas): la entrada de `documentacion_proyecto_slep_simce_adecuado.md` (L246-251, que nombra también el `.html` en L249) y la de `arquitectura_slep_simce_adecuado.html` (L252-256). Ninguna otra línea del README los nombra (paso 1). La entrada de la suite (L240-243) queda como está: ya dice que la suite trae la documentación del proyecto y la arquitectura. Herramienta: una sola sustitución exacta del bloque (Edit), sin líneas nuevas.

**Criterio pre-registrado** (§7 Q1.2; salidas en `$TMPDIR/cal_s35q/q1/`). Instrumento de enlaces: `enlaces.py <raíz> <readme>` extrae los enlaces con tres patrones (inline `[..](..)`, de referencia `[..]: ..` y `href`/`src`), aparta los externos (`http`, `https`, `mailto`, `#`) y por cada relativo mide si el destino existe en el árbol, si está versionado (`git ls-files`) y si `.gitignore` lo ignora (`git check-ignore`); código 1 si alguno falla. Se calibra con la copia de partida del README, que tiene los dos enlaces rotos.
esperado: el `git grep -l` del paso 1 → vacío (código 1); `grep -c 'documentacion_proyecto_slep\|arquitectura_slep'` sobre el README → 0; `enlaces.py` sobre la copia de partida → 8 relativos y 2 fallas (L246 y L252), código 1; sobre el README editado → 6 relativos (gobernanza de datos, suite, publicación, backlog, `LICENSE` y `NOTICE`), 0 fallas, código 0; `git diff -U0 README.md` → un solo trozo, `@@ -246,11 +245,0 @@`, `--numstat` 0 11, y las 11 líneas `-` son las de L246-256 de la copia de partida
obtenido (23:10:15):
- `git grep -l` del paso 1 → **vacío** (gitgrep_codigo=1, A34-3; `gitgrep.txt`, 0 líneas).
- `grep -c 'documentacion_proyecto_slep\|arquitectura_slep' README.md` → **0** (código 1, A34-3).
- `enlaces.py` sobre la copia de partida (`enlaces_antes.txt`): 10 enlaces, **8 relativos y 2 fallas**, L246 (`documentacion_proyecto_slep_simce_adecuado.md`) y L252 (`arquitectura_slep_simce_adecuado.html`), los dos con existe=False y versionado=False, **código 1**: el instrumento dispara.
- `enlaces.py` sobre el README editado (`enlaces_despues.txt`): 8 enlaces, 2 externos (L81 y L262) y **6 relativos, 0 fallas, código 0**; cotejo completo:
```text
L90	relativo	50_documentacion/activa/gobernanza_datos.md	existe=True	versionado=True(1 archivos)	ignorado=False	OK
L240	relativo	50_documentacion/suite/	existe=True	versionado=True(6 archivos)	ignorado=False	OK
L244	relativo	50_documentacion/activa/publicacion_github_pages.md	existe=True	versionado=True(1 archivos)	ignorado=False	OK
L246	relativo	50_documentacion/activa/backlog_acumulativo.md	existe=True	versionado=True(1 archivos)	ignorado=False	OK
L256	relativo	LICENSE	existe=True	versionado=True(1 archivos)	ignorado=False	OK
L263	relativo	NOTICE	existe=True	versionado=True(1 archivos)	ignorado=False	OK
```
- `git diff -U0 README.md` (`diff.txt`, diff_codigo=0): **un solo trozo, `@@ -246,11 +245,0 @@`**, `--numstat` **0 11**; las 11 líneas `-` son idénticas a L246-256 de la copia de partida (`cmp`, código 0). El README pasa de 328 a 317 líneas (md5 9272c291… → e3a554ad9f2bb2cc8abea6f40265500f).
**Cumple.**

**Commit** `docs(readme): quita los enlaces a la documentacion de junio archivada (Q-97)`: `d8ba99d`, padre `f7e966a`; `--numstat` `README.md` 0 11; `git status --porcelain` = solo este log (23:10:27).

**Estado:** completa, en el primer intento (23:09:03 a 23:10:27). **Commits:** `d8ba99d`. **Cambios sustantivos:** la sección «Documentación» del README deja de enlazar los dos documentos que s35p archivó (P5); la causa del defecto fue el archivado sin tocar el README (ERR-35-29), y la entrada de la suite ya cubre lo que decían. **Alcance:** `README.md` ⊆ ALCANCE de Q1. **Regresión:** no tocó código (un texto del README); la completa va en FASE R. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D1-a (riesgo bajo, reversible): el cotejo de enlaces exige, además de que el destino exista en el árbol, que esté versionado y que `.gitignore` no lo ignore, porque el README se lee en GitHub, donde un archivo solo local también es un enlace roto. Alternativa descartada: solo `test -e`, que no ve ese caso.
- D1-b (riesgo bajo): la entrada de la suite (L240-243) no se reescribe para recoger lo que decían las dos entradas quitadas; §7 Q1.2 pide que el diff solo quite.

**Errores propios:** una prueba de sintaxis de `enlaces.py` se corrió contra una raíz equivocada (`$TMPDIR/cal_s35q/antes/..`), dio código 1 y no midió nada; la comprobación válida fue `py_compile` (código 0) y la calibración de arriba. Sin costo. **Dudas:** ninguna.

### FASE Q2: `.Renviron.example` sin la raíz de datos (Q-95)

Inicio: 23:10:27 (`date` del commit de Q1). ALCANCE: `.Renviron.example`.

**Paso 1. Lectura** (copia de partida en `$TMPDIR/cal_s35q/antes/Renviron.example`, md5 cb80f9c08091700de69754e61bd25199, 34 líneas): L1-8, cabecera («Plantilla de configuracion de la raiz de datos»; copiar la línea que corresponda a `~/.Renviron`; se versiona; contrato del protocolo de portabilidad); L10-15, opción A (`WORKSPACE_DATA_ROOT`); L17-21, opción B (`SLEP_SIMCE_ADECUADO_DATA_ROOT`); L23-26, validación con `obtener_data_root_proyecto()` y `validar_portabilidad()`; L28-34, sección de locale con `LANG=es_ES.UTF-8`. D35-26 (Q-95): las dos líneas del validador que nombran esas variables (L262 y L280) no cuentan como uso, así que la regla de congelamiento de P1 de s35p no se repite aquí.

Lecturas de contexto (solo lectura, 23:11 a 23:13): `ruta_insumos()` es `here::here("20_insumos", ...)` (`10_configuracion.R` L23), sin variables de entorno. `git grep -n 'Renviron.example'` fuera de andamios, traspasos, encargos y estructura: además del propio archivo, el validador (L248-249, existencia), `10_locale.R` L204 y L217 (dos mensajes que remiten a la línea `LANG` de `.Renviron.example`, que se queda), el README L276 y L295 (ya dicen que no hay variable que declarar y que se copia la línea `LANG`), el archivo de decisiones y `50_documentacion/activa/50_locale_utf8.md` L58 y L73, que cita `.Renviron.example:29` (la glosa de la sección de locale) en una constancia fechada el 2026-08-27 («las secciones 1 a 4 son el estado del 2026-08-27»). Protocolo de la cartera (`herramientas_dev/gobernanza/protocolo_portabilidad_cross_os.md`, solo lectura): §6.2 dice que `.Renviron.example` es «Plantilla obligatoria en la raíz del repo, con ejemplos por sistema operativo y ambas formas de resolución» (opciones A y B), y §12 paso 3, «Copiar .Renviron.example → ~/.Renviron y declarar WORKSPACE_DATA_ROOT». Q2 ejecuta D35-26 (Q-95), que el titular tomó sabiendo que el proyecto no usa esas variables; que el archivo se aparte de §6.2 del protocolo no está enumerado en el encargo: se registra como duda (Q-99) y se sigue.

**Paso 2. Diseño de la edición** (texto nuevo sin guiones largos; ASCII sin tildes, como el resto del archivo):
- L1-8, cabecera: dice para qué sirve el archivo (que R arranque con locale UTF-8), que la línea `LANG` se copia a `~/.Renviron` y se reinicia R, que el archivo de ejemplo se versiona y `~/.Renviron` no, y que no hay raíz de datos que declarar porque los insumos viven en el repositorio (`ruta_insumos()`); sale la línea «Contrato: protocolo_portabilidad_cross_os.md 4.2 y 6.2», que remite a las secciones de la raíz de datos.
- L10-26 (opciones A y B y su validación): se quitan.
- L28-34 (sección de locale con `LANG=es_ES.UTF-8`): no cambia.
- Efecto sobre `~/.Renviron`: ninguno. En la versión de partida, las opciones A y B y la validación están comentadas, así que `readRenviron()` del archivo viejo y del nuevo fija solo `LANG`; se mide.

**Criterio pre-registrado** (§7 Q2.2; salidas en `$TMPDIR/cal_s35q/q2/`)
esperado: `grep -c 'DATA_ROOT\|obtener_data_root' .Renviron.example` → 0 (código 1) y sobre la copia de partida → 7 (control: el patrón dispara); `grep -c '^LANG=es_ES.UTF-8$'` → 1; `readRenviron()` en un R con `--vanilla` y `LANG` vacía, sobre la copia de partida y sobre el archivo nuevo, cambia en los dos casos solo `LANG`, a `es_ES.UTF-8`; el validador da para `.Renviron.example` el mismo resultado que en H5: `Rscript 00_build.R` con código 0, `renviron_example` en OK y la sección «Checks de entorno» idéntica a `h5_entorno.txt` (`diff`, código 0); `git diff -U0` solo toca L1-26, la sección de locale (7 líneas) queda byte a byte igual a L28-34 de la copia de partida, y las líneas `+` no traen guiones largos ni semirrayas
obtenido (23:11:52 a 23:12:41; el primer `grep -c` sobre la copia de partida corrió en el mismo comando que escribió el `esperado:`, después de escribirlo):
- `grep -c 'DATA_ROOT\|obtener_data_root' .Renviron.example` → **0** (código 1, A34-3). Sobre la copia de partida → **5, no 7** (código 0): las líneas L13, L15, L19, L21 y L25, las que s35p ya había medido (5). El control dispara (5 > 0), pero el valor escrito en el `esperado:` (7) no se midió antes de escribirlo: error propio de pre-registro (abajo). No se ajusta.
- `grep -c '^LANG=es_ES.UTF-8$' .Renviron.example` → **1** (código 0).
- `readRenviron()` (`q2/renviron.R`, `Rscript --vanilla`, `LANG` vaciada dentro del proceso): copia de partida, «readRenviron: TRUE | nuevas: LANG | cambiadas:  | LANG=es_ES.UTF-8», código 0; archivo nuevo, **la misma línea**, código 0. Copiado a `~/.Renviron`, el archivo nuevo fija exactamente lo mismo que el viejo: solo `LANG`.
- Validador: `Rscript 00_build.R`, **build_codigo=0** (23:12:33 a 23:12:41), «Fallas criticas: 0 | Advertencias: 7», **`renviron_example` en OK**; la sección «Checks de entorno» (`q2/entorno.txt`) es idéntica a la de H5 (`diff`, código 0; md5 190b17a15a28d0721165d12a3194ea2c en las dos). Además, I-3 sobre ese build: «vista byte a byte: TRUE; motor JSON sin fecha: TRUE; motor resto del HTML: TRUE», código 0.
- `git diff -U0 .Renviron.example` (`q2/diff.txt`; `--numstat` 6 23): tres trozos, `@@ -2 +2 @@`, `@@ -4,4 +4,5 @@` y `@@ -10,18 +10,0 @@`. Toca **L1-27, no L1-26**: el tercer trozo quita L10-26 y también L27, la línea en blanco que separaba la validación de la sección de locale (el `esperado:` contó el bloque sin su separador). La sección de locale, 7 líneas, queda **byte a byte igual** a L28-34 de la copia de partida (`cmp`, código 0). Las 6 líneas `+`: **0 guiones largos o semirrayas** (código 1), anchos 64, 74, 70, 78, 74 y 62. El archivo pasa de 34 a 17 líneas (md5 cb80f9c0… → 9706173a59cae092a24ce95fa3af4a23).
**Cumple lo que pide §7 Q2.2** (`grep -c` → 0, `LANG` presente y el validador con el mismo resultado de H5). De lo que el orquestador agregó al criterio, dos valores escritos no coinciden con lo medido, sin efecto sobre lo que miden: el control de la copia de partida da 5 y no 7 (dispara igual) y el diff toca L27, una línea en blanco, además de L1-26 (la sección de locale no cambia).

**Commit** `docs(entorno): .Renviron.example sin la raiz de datos que el proyecto no usa (Q-95)`: `43aede2`, padre `d8ba99d`; `--numstat` `.Renviron.example` 6 23; `git status --porcelain` = solo este log (23:12:56).

**Estado:** completa, en el primer intento (23:10:27 a 23:12:56). **Commits:** `43aede2`. **Cambios sustantivos:** `.Renviron.example` deja de documentar la raíz de datos (opciones A y B) y su validación con `obtener_data_root_proyecto()`, que el proyecto no usa (los insumos viven en el repositorio); queda la sección de locale con `LANG=es_ES.UTF-8` y una cabecera que dice para qué sirve y que se copia a `~/.Renviron`. Lo que el archivo fija al copiarse no cambia (solo `LANG`). Cierra Q-90 (D35-25) por la vía de Q-95 (D35-26). **Alcance:** `.Renviron.example` ⊆ ALCANCE de Q2. **Regresión:** el build del criterio (código 0, 0 fallas críticas, I-3 TRUE); la completa va en FASE R. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D2-a (riesgo bajo, reversible): la cabecera dice por qué no hay raíz de datos que declarar (los insumos en el repositorio, `ruta_insumos()`) sin nombrar las variables, porque el criterio exige 0 aciertos de `DATA_ROOT`; y sale la línea «Contrato: protocolo_portabilidad_cross_os.md 4.2 y 6.2», porque remite a las secciones de la raíz de datos que el archivo ya no sigue. Alternativa descartada: conservarla, que citaría como contrato una plantilla (§6.2) de la que el archivo se aparta.
- D2-b (riesgo bajo): se sigue con la edición aunque §6.2 del protocolo de la cartera pide las opciones A y B, porque D35-26 (Q-95) es una decisión explícita del titular; la tensión se registra (Q-99).

**Errores propios:** dos valores del criterio escritos sin medir: «7» para el `grep -c` de la copia de partida (dio 5, la cifra de s35p) y «L1-26» para el diff (toca también L27, una línea en blanco). Es el patrón de ERR-35-29: una cifra escrita antes de contarla. Costo: ninguno sobre el trabajo; los dos quedan registrados como obtenidos y no se ajustaron. **Dudas:** Q-99 (abajo, en el consolidado).

### FASE Q3: el paso 30 valida `COD_DEPE` (Q-98)

Inicio: 23:12:56 (`date` del commit de Q2). ALCANCE: `30_procesamiento/30_construir_auxiliares.R`.

**Paso 1. Lectura** (copia de partida en `$TMPDIR/cal_s35q/antes/30_construir_auxiliares.R`, md5 28eac6ca6f0472e3427737a37d84a98c, 460 líneas): L161, el comentario «Validación de columnas requeridas para los parquets aguas abajo.»; L162-168, `cols_csv_esperadas` con 10 columnas (`AGNO`, `RBD`, `NOM_RBD`, `COD_COM_RBD`, `NOM_COM_RBD`, `COD_REG_RBD`, `NOM_REG_RBD_A`, `COD_DEPE2`, `MATRICULA` y `ESTADO_ESTAB`), agrupadas por línea (identificación, comuna, región, dependencia, estado); L169-172, `setdiff` y `stopifnot` con el mensaje «Faltan columnas en directorio_oficial_ee.csv»; L334-335, el filtro del bloque 4 con `.data$COD_DEPE == 6` y `.data$COD_DEPE %in% c(1, 2)`. El comentario de L161 ya explica la lista («columnas requeridas para los parquets aguas abajo»), y `COD_DEPE` es una de ellas: se usa para armar `sleps_chile.parquet`.

Lectura de las columnas del directorio que el paso 30 usa (`grep -n` de `df_dir_raw` y lectura de los bloques 2 a 5): bloque 2, `AGNO` (L177); bloque 3, `ESTADO_ESTAB`, `MATRICULA`, `COD_COM_RBD`, `NOM_COM_RBD`, `COD_REG_RBD` y `NOM_REG_RBD_A` (L207-219); bloque 4, `ESTADO_ESTAB`, `MATRICULA`, `COD_COM_RBD`, `COD_DEPE`, `RBD` y `NOM_RBD` (L327-340); bloque 5, `ESTADO_ESTAB`, `MATRICULA`, `RBD`, `NOM_RBD`, `COD_COM_RBD`, `NOM_COM_RBD` y `COD_DEPE2` (L424-433). Son 11 columnas; la lista valida 10, y la que falta es solo `COD_DEPE`. Se mide abajo con otro instrumento.

**Paso 2. Diseño de la edición:** `"COD_DEPE"` entra en la línea de la dependencia, antes de `"COD_DEPE2"` (`"COD_DEPE", "COD_DEPE2",`), bajo el comentario de L161, que ya explica la lista y no cambia. Nada más del archivo cambia.

**Criterio pre-registrado** (§7 Q3.2; salidas en `$TMPDIR/cal_s35q/q3/`). Instrumento de columnas: `columnas.R <archivo> <csv>` lee con `getParseData()` los `SYMBOL` del archivo que son nombres de columna del directorio (la primera línea del CSV, solo los nombres) y los `STR_CONST` de la asignación a `cols_csv_esperadas`, e imprime las columnas usadas sin validar; código 1 si hay alguna.
esperado:
- `git diff -U0` del paso 30: un solo trozo en L166, 1 línea `-` y 1 `+` (`"COD_DEPE2",` → `"COD_DEPE", "COD_DEPE2",`);
- `columnas.R` sobre la copia de partida: 11 columnas usadas, 10 validadas, sin validar `COD_DEPE`, código 1; sobre el archivo editado: 11 y 11, ninguna sin validar, código 0;
- I-3: `Rscript 00_build.R` con código 0 y 0 fallas críticas, y `i3_salidas.R` de la base de H5 contra `40_salidas/` con código 0;
- control positivo, en una copia del repositorio en `$TMPDIR/cal_s35q/q3/copia/` (sin `.git`; `renv/library` con sus enlaces simbólicos) con la columna `COD_DEPE` quitada del directorio (las demás columnas y filas iguales): con el código nuevo, `Rscript 00_build.R` termina con código distinto de 0, la salida trae «Faltan columnas en directorio_oficial_ee.csv», y el último paso anunciado es «[2] Leyendo directorio_oficial_ee.csv...» (no aparece «[3]»); con el paso 30 de antes en esa misma copia, la salida no trae ese mensaje (se anota dónde falla o si pasa);
- `Rscript 30_procesamiento/33_verificar_motor.R` y `Rscript 30_procesamiento/36_verificar_trayectorias.R` con código 0.
obtenido (23:14:34 a 23:17:26):
- `git diff -U0` (`q3/diff.txt`, diff_codigo=0): **un solo trozo, `@@ -166 +166 @@`**, `-  "COD_DEPE2",` y `+  "COD_DEPE", "COD_DEPE2",`; `--numstat` **1 1**.
- `columnas.R` (`Rscript --vanilla`): copia de partida, «nombres en el CSV: 58 | usadas: 11 (AGNO,COD_COM_RBD,COD_DEPE,COD_DEPE2,COD_REG_RBD,ESTADO_ESTAB,MATRICULA,NOM_COM_RBD,NOM_RBD,NOM_REG_RBD_A,RBD) | validadas: 10 | sin validar: COD_DEPE», **código 1**; archivo editado, la misma lista de usadas, «validadas: 11 | sin validar: (ninguna)», **código 0**. Coincide con la lectura del paso 1.
- I-3: `Rscript 00_build.R`, **build_codigo=0** (23:14:40 a 23:14:48), «Fallas criticas: 0 | Advertencias: 7», «OK: 16768 filas leídas», `sleps_chile.parquet` 2337 filas; `i3_salidas.R` base contra `40_salidas/`: «vista byte a byte: TRUE; motor JSON sin fecha: TRUE; motor resto del HTML: TRUE», **código 0**; además `cmp` da 0 en la vista y 0 en el motor (el mismo día y la misma plataforma).
- Control positivo. Preparación de la copia: `rsync -a` del árbol a `$TMPDIR/cal_s35q/q3/copia/` sin `.git/`, `_archivo/` ni `.claude/` (rsync_codigo=0; 56 enlaces simbólicos en `renv/library`, los mismos 56 del árbol). El CSV (metadatos, sin imprimir filas): BOM, fin de línea CRLF, 0 comillas, 58 campos en cada una de las 16768 filas y `COD_DEPE` en la posición 15. La columna se quitó con Python (`split(";")` y `del`) y, por separado, con `awk` sobre el original: los dos resultados son **idénticos** (`cmp`, código 0). La copia queda con 57 columnas, `COD_DEPE` 0 veces, `COD_DEPE2` 1 vez y 16768 filas; su paso 30 es el nuevo (`cmp`, código 0).
  - Con el código nuevo (`q3/copia_nuevo.txt`, 60 líneas; 23:15:30 a 23:15:32): el validador de la copia da «Fallas criticas: 0»; **build_copia_nuevo=1**; el último paso anunciado es «[2] Leyendo directorio_oficial_ee.csv...» (L58, sin «[3]») y L59 es **«Error: Faltan columnas en directorio_oficial_ee.csv»**, seguida de «Ejecución interrumpida». Se detiene en la validación del paso 30.
  - Con el paso 30 de antes en esa misma copia (md5 28eac6ca…, copiado de `$TMPDIR/cal_s35q/antes/`; `q3/copia_antes.txt`, 88 líneas; 23:15:38 a 23:15:40): **build_copia_antes=1**; «Faltan columnas» **no aparece** (grep, código 1). **No se detiene ahí:** el bloque 2 lee el CSV («OK: 16768 filas leídas»), el bloque 3 escribe `comunas_chile.parquet` en la copia (345 comunas) y el bloque 4 falla en «[4] Construyendo sleps_chile.parquet...», después de leer el listado SLEP (70 SLEP, 346 combinaciones), con «Error in `dplyr::filter()`» y «Column `COD_DEPE` not found in `.data`» (el filtro de L334-335), y un traceback de 18 marcos de `rlang`.
  - Al terminar, las dos copias del CSV (la de la copia y la salida de `awk`) se borraron con `rm` de dos archivos, sin recursión (rm_codigo=0; autorización 4), porque el directorio trae la columna MRUN; el original sigue en `20_insumos/auxiliares/` con 3778137 B.
- Baterías: `Rscript 30_procesamiento/33_verificar_motor.R`, **motor_codigo=0**, «Resultado: 8 pruebas, 8 pasan, 0 fallan (en 70 segundos)» (23:15:58 a 23:17:09); `Rscript 30_procesamiento/36_verificar_trayectorias.R`, **vista_codigo=0**, «Resultado: 35 pruebas, 35 pasan, 0 fallan» (23:17:09 a 23:17:26).
**Cumple.**

**Commit** `fix(pipeline): el paso 30 valida la columna COD_DEPE del directorio (Q-98)`: `a238458`, padre `43aede2`; `--numstat` 1 1; el paso 30 sigue en 460 líneas (md5 28eac6ca… → c7d0c207a323c0c3a91e71f755331f4f); `git status --porcelain` = solo este log (23:17:50).

**Estado:** completa, en el primer intento (23:12:56 a 23:17:50). **Commits:** `a238458`. **Cambios sustantivos:** `cols_csv_esperadas` incluye `COD_DEPE`, que el bloque 4 usa para filtrar (L334-335) y no se validaba: si el directorio llega sin esa columna, el build se detiene en la validación con el mensaje de las columnas faltantes, en vez de fallar en el bloque 4 con un error de `dplyr` y después de escribir `comunas_chile.parquet`. Con eso, el paso 30 valida las 11 columnas del directorio que usa. Las salidas no cambian (I-3). **Alcance:** `30_procesamiento/30_construir_auxiliares.R` ⊆ ALCANCE de Q3; la copia del repositorio, en `$TMPDIR`. **Regresión:** build con código 0 y 0 fallas críticas, I-3 TRUE, motor 8 de 8 y vista 35 de 35. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D3-a (riesgo bajo, reversible): `"COD_DEPE"` va en la misma línea que `"COD_DEPE2"`, porque la lista agrupa por línea (identificación, comuna, región, dependencia, estado), y sin comentario nuevo: el de L161 ya explica la lista (§7 Q3.1). Alternativa descartada: una línea propia con un comentario que diga que la usa el bloque 4, que la lista no hace con ninguna otra columna.
- D3-b (riesgo bajo): la copia del control se hizo sin `.git/`, `_archivo/` ni `.claude/` (el build no los usa: `here::here()` se ancla en el `.Rproj` y el validador no corre git), para que ningún comando en la copia pudiera tocar el repositorio.
- D3-c (riesgo bajo, reversible por regeneración): las dos copias del directorio con la columna quitada se borraron al terminar el control (`rm` de dos archivos), porque el CSV trae MRUN (Ley 21.719); el resto de la copia queda en `$TMPDIR`.

**Errores propios:** ninguno. **Dudas:** ninguna.

### FASE R: auditoría y reparación

Inicio: 23:17:50 (`date` del commit de Q3).

**R.1 Inventario de afirmaciones auditables** (armado desde las secciones anteriores de este log, antes de auditar; cada una se re-deriva en R.2 con un comando distinto del que la produjo; scripts y salidas en `$TMPDIR/cal_s35q/fase_r/`)

| id | afirmación (fase) |
|---|---|
| R-01 | H1: el árbol con el registro de errores modificado, el encargo sin versionar y el log (FASE 0) |
| R-02 | H2: stash 0; un solo worktree (FASE 0) |
| R-03 | H3: `HEAD` y `origin/main` en 8f10463; instantáneas de I-1 e I-4 (lock e6323bf2…, settings d0bcb98d…) (FASE 0) |
| R-04 | H4: md5 del encargo 8c2d00f3…; `docs/` 42ab9300… y 883f76bc…; T0 = f7e966a, padre 8f10463, tres rutas (M, A y M), 346 inserciones; D35-26 trae las cuatro viñetas del Contexto tal cual (FASE 0) |
| R-05 | H5: build con código 0, 0 fallas críticas y 7 advertencias; 16768 filas del directorio; cuatro parquet del paso 30 (73, 345, 2337 y 10945 filas); la base tiene los md5 de `docs/`; el validador ve `.Renviron.example` solo por su existencia (`renviron_example`, OK) y su escaneo no lo lee (FASE 0) |
| R-06 | Calibración de `i3_salidas.R` (FASE 0) |
| R-07 | Q-96: `git grep -nw 'json_motor'` fuera de `50_documentacion/` da 0; sin `-w`, 2 (FASE 0) |
| R-08 | Q1, línea base: el `git grep -l` de §2 da solo `README.md`; en el README, L246, L249 y L252 (Q1) |
| R-09 | Q1, criterio: el `git grep -l` vacío; 0 menciones en el README; 6 enlaces relativos, todos existentes, versionados y no ignorados (8 y 2 rotos en la copia de partida); diff de un trozo que solo quita L246-256; README 317 líneas (e3a554ad…); commit d8ba99d, padre f7e966a (Q1) |
| R-10 | Q2: `DATA_ROOT`/`obtener_data_root` 0 (5 en la copia de partida); `LANG` 1; el archivo nuevo y el viejo fijan solo `LANG`; el validador da lo mismo que en H5; diff en L1-27 con la sección de locale igual; 0 guiones largos; 17 líneas (9706173a…); commit 43aede2, padre d8ba99d; §6.2 del protocolo pide las opciones A y B (Q2) |
| R-11 | Q3: diff de un trozo en L166, 1 y 1; 11 columnas usadas y 10 validadas antes, 11 y 11 después; build 0 e I-3 TRUE; control: sin `COD_DEPE`, el código nuevo se detiene en el paso 30 con «Faltan columnas…» y el de antes falla en el bloque 4 con «Column `COD_DEPE` not found»; motor 8 de 8 y vista 35 de 35; commit a238458, padre 43aede2 (Q3) |
| R-12 a R-15 | I-1 a I-4 (§4) |
| R-16 | Alcance global: `git diff --name-only f7e966a..HEAD` dentro de la unión de los ALCANCE más el log; `git status` |
| R-17 | Identidad de lo publicado (`git hash-object` sobre `docs/` y `40_salidas/`) y ausencia de red en lo publicado (`grep -c 'http'`, revisado a mano) |

**R.2 Re-derivación independiente** (sin subagentes; el orquestador, con otros comandos; scripts y salidas en `$TMPDIR/cal_s35q/fase_r/`)
esperado: cada afirmación del inventario se confirma o se refuta con un instrumento distinto del original
obtenido: **17 de 17 confirmadas** (R-12 a R-15 en R.3 y R-16 en R.4), 0 refutadas (23:19 a 23:24):
- R-01 (`rd_git.txt`): `git diff-tree --name-status -r f7e966a` = M del archivo de decisiones, A del encargo y M del registro de errores; el encargo no existía en 8f10463 (`cat-file -e`, código 128) y el registro de errores sí (código 0); el log no está en ningún commit (`git log --all`, 0).
- R-02: `git rev-parse -q --verify refs/stash`, código 1; `.git/worktrees` no existe (código 1).
- R-03: `git cat-file -p f7e966a` → `parent 8f104631…`; el reflog pone `origin/main` en 8f10463 desde las 22:57:01 (el push de s35p) y sin movimiento después.
- R-04: `openssl dgst -md5`: el encargo, 8c2d00f3…, en el árbol y en `git show f7e966a:`; `docs/` 42ab9300… y 883f76bc…; `git diff-tree --numstat`: 346 insertados, 0 borrados. Python sobre el texto crudo (`rd_py.txt`): 4 viñetas de D35-26 en el encargo y 4 en el archivo de decisiones, **iguales** (espacios normalizados).
- R-05 (`rd_r.txt`, `rd_git.txt`): `arrow` sin armar `data.frame` (`num_rows`): 73, 345, 2337 y 10945 filas (8, 4, 7 y 5 columnas); el directorio, por `wc -l` menos la cabecera, 16768 filas; `.vp_listar_archivos()`: 33 archivos, sin `.Renviron.example`; `.vp_validar_entorno()`: los ocho checks en OK, `renviron_example` incluido.
- R-06: los controles de la calibración se repiten con defectos distintos en R.6.
- R-07 (`rd_git.txt`): `grep -rnw json_motor` sobre el árbol de trabajo (no `git grep`), sin `.git/`, `_archivo/`, `50_documentacion/`, `renv/` ni `40_salidas/`: 0 (código 1); sin `-w`, las mismas 2 líneas de `33_verificar_motor.R`.
- R-08 (`rd_py.txt`): Python sobre los blobs de `f7e966a` (`git ls-tree` y `git show`), con las exclusiones de §2: solo `README.md` cita los documentos, en L246, L249 y L252.
- R-09 (`rd_git.txt`, `rd_py.txt`): `grep -rlE` del patrón sobre el árbol de trabajo, con las exclusiones y sin `_archivo/`: 0 archivos (código 1). Enlaces del README por otra vía (`grep -o` y `git cat-file -t HEAD:<ruta>`): 6 relativos, 5 `blob` y 1 `tree`, 0 faltan; los del README de `f7e966a`: 8, faltan los 2 archivados. Diff de `d8ba99d` con Python: 1 trozo, 0 `+`, 11 `-`, iguales a L246-256 de `f7e966a`. Una primera cuenta con `awk` dio «menos 9»: el patrón `^-[^-]` excluía las dos líneas que empiezan con «- [» (en el diff, «-- [»); se corrigió el instrumento, no el dato, y la primera salida quedó guardada (`rd_git.txt`). `git cat-file -p d8ba99d` → `parent f7e966a…`; `git show d8ba99d:README.md | wc -l` = 317; `openssl` e3a554ad….
- R-10 (`rd_py.txt`, `rd_renviron.txt`, `rd_git.txt`): Python: `DATA_ROOT`/`obtener_data_root` 0 en el nuevo y 5 en el de `f7e966a`; `LANG` 1; 17 líneas; 0 guiones largos o semirrayas; 0 líneas no ASCII; la única línea activa (no comentario) es `LANG=es_ES.UTF-8` en los dos. Por otro mecanismo que `readRenviron()`: R arrancado con `env -i` y `R_ENVIRON_USER` apuntando a cada archivo (como si fuera `~/.Renviron`): con el viejo y con el nuevo, `LANG=[es_ES.UTF-8]` y las dos variables de la raíz de datos vacías; control con `R_ENVIRON_USER=/dev/null`: `LANG=[]` (el archivo es lo que fija `LANG`). La sección de locale de `f7e966a` y la de `HEAD`, `diff` código 0. `git cat-file -p 43aede2` → `parent d8ba99d…`. `grep -rnE` de las variables y de `obtener_data_root` sobre el árbol: además de las dos líneas del validador (L262 y L280) y de la decisión Q-90, aparecen `POLITICA_PROYECTO.md` L758, L767 y L775 y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` L780, dos documentos no versionados (`.gitignore:50` y `:51`). Leídos: POLITICA §8.3 es la «Rama B» (proyectos con datos privados) y §8.2, la «Rama A — Proyecto 100% público», dice «rutas vía `here::here()` exclusivamente; sin variable de entorno ni data root externo», que es lo que hace este proyecto; SETTINGS L780 es un ejemplo genérico (`slep_x`) de la llave `ventana_insumos`. Nada de eso contradice Q2 (R-20).
- R-11 (`rd_r.txt`, `rd_git.txt`): `all.names()` sobre `parse()` (no `getParseData()`) y la lista validada evaluando la asignación: en `43aede2`, 11 usadas, 10 validadas, sin validar `COD_DEPE`; en `HEAD`, 11 y 11. La validación del paso 30 (las tres expresiones: la asignación, `setdiff` y `stopifnot`) evaluada sobre cabeceras sintéticas de 0 filas: con el código de antes, «sin error» con la cabecera completa y **«sin error» sin `COD_DEPE`**; con el nuevo, «sin error» con la completa y **«Faltan columnas en directorio_oficial_ee.csv»** sin `COD_DEPE`. Diff de `a238458` (`git diff-tree -p`): 1 trozo, 1 `+` y 1 `-`; `parent 43aede2…`. Las baterías, otra vez en R.5.
- R-17 (`rd_identidad.txt`, `rd_urls.txt`, `rd_fetch.txt`): `git hash-object`: `docs/index.html` = `40_salidas/motor_comparacion.html` = la base de H5 = `HEAD:` = `origin/main:` = **2554f9a2…**; la vista, en los cinco lugares, **7cbbdb75…**; `git diff --quiet f7e966a HEAD -- docs/`, código 0. Red: `grep -c 'http'` = 17 y 2 líneas; URL distintas revisadas a mano (9 en el motor y 1 en la vista, con su contexto): espacios de nombres de w3.org (MathML, xhtml, xlink, svg, xmlns y XML), el texto de error de React y los comentarios de D3 y pako. `src`/`href` con http, `url(http`, `@import` y `XMLHttpRequest`: 0 en las dos. `fetch(`: 4 en el motor, en las posiciones 407268, 527996, 528506 y 556240, todas dentro del bloque de D3 (306266 a 586079), y 0 en la vista; llamadas de carga (`d3.json(` y afines, `window.fetch`, `new Worker(`, `new WebSocket(`, `import(`, `sendBeacon`, `new EventSource(`): 0. **0 cargas por red**, lo mismo que s35p (R-26 de ese log).
Corrección de la línea `obtenido:` de R.2: el intervalo «23:19 a 23:24» se escribió antes de medirlo; el `date` que cerró la sección dio 23:21:34, así que R.2 corrió de 23:18:51 a 23:21:34. Además, en `rd_renviron.txt` el «c=0» que sigue a cada `Rscript` es el código del `grep` de la tubería, no el de R; la evidencia son los valores impresos y el control con `/dev/null`, no ese código (errores propios).

**R.3 Invariantes 🔒** (comandos de §4; salida literal en `$TMPDIR/cal_s35q/fase_r/invariantes.txt`)

I-1 `git for-each-ref --format='%(refname) %(objectname)'` contra `i1_fase0.txt`, fuera de `refs/heads/main`, `refs/remotes/origin/main` y `refs/remotes/origin/HEAD`
esperado: iguales

I-2 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3

I-3 `i3_salidas.R` entre la base de H5 y `40_salidas/` (el build de Q3, sobre el código final; R.5 lo repite con un build nuevo), y `cmp` de la vista
esperado: código 0 (vista byte a byte, motor por contenido sin `meta$fecha_generacion`); `cmp` 0

I-4 md5 de `renv.lock` y `renv/settings.json` contra `i4_fase0.txt`
esperado: idénticos
Los cuatro `esperado:` se escribieron juntos antes del comando único que mide los cuatro (23:21:53); cada `obtenido:` nombra su invariante:
obtenido: I-1 `diff` fuera de las tres refs de `main`, **código 0**; `refs/heads/main` a2384586…; `refs/remotes/origin/main` y `origin/HEAD` 8f104631… (sin cambio); `feat/contrato-contexto`, local y remota, 31befa2c… &rarr; **PASA**
obtenido: I-2 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 &rarr; **PASA**
obtenido: I-3 «vista byte a byte: TRUE; motor JSON sin fecha: TRUE; motor resto del HTML: TRUE», código 0; `cmp` de la vista, 0 &rarr; **PASA**
obtenido: I-4 e6323bf2d0fb341589c4ce8a19b74636 y d0bcb98db909870724e9b0fc5eff1700; `diff` contra FASE 0, código 0 &rarr; **PASA**

**R.4 Alcance global** (`fase_r/alcance.py`, con los ALCANCE de §5 más el log, sobre `git diff --name-only`; y `git status --porcelain`)
esperado: dentro de la unión de los ALCANCE más el log (0 fuera), con `f7e966a..HEAD` y con `f7e966a^..HEAD` (T0 incluida); `status` solo con el log
obtenido: `f7e966a..HEAD`: «rutas: 3 | por tarea: {'T0': 0, 'Q1': 1, 'Q2': 1, 'Q3': 1, 'LOG': 0} | fuera: (ninguna)», código 0; con T0 (`f7e966a^..HEAD`): «rutas: 6 | … 'T0': 3 … | fuera: (ninguna)», código 0. `git status --porcelain` = `?? …/20260926_enlaces_renviron_s35q_log.md` (23:22:08) &rarr; **PASA**

**R.5 Regresión completa** (estado final, códigos leídos sin tubería)
esperado: `Rscript 00_build.R` código 0 con 0 fallas críticas; `Rscript 30_procesamiento/33_verificar_motor.R` y `Rscript 30_procesamiento/36_verificar_trayectorias.R` código 0; I-3 sobre el build final, código 0
obtenido: **build_codigo=0** (23:22:19 a 23:22:27), «Fallas criticas: 0 | Advertencias: 7», «OK en 6 segundos», `renviron_example` en OK; I-3 sobre ese build, «vista byte a byte: TRUE; motor JSON sin fecha: TRUE; motor resto del HTML: TRUE», código 0, y `cmp` 0 en la vista y 0 en el motor; **motor_codigo=0**, «Resultado: 8 pruebas, 8 pasan, 0 fallan (en 70 segundos)» (hasta 23:23:40); **vista_codigo=0**, «Resultado: 35 pruebas, 35 pasan, 0 fallan» (hasta 23:23:58); `git status --porcelain` = solo este log &rarr; **PASA**

**R.6 Control positivo de la propia auditoría** (`fase_r/control_positivo.sh` y su salida `control_positivo.txt`; copias en `fase_r/ctl/`, fuera del árbol)
esperado: cada instrumento dispara con su caso plantado: (1) identidad, un byte agregado a una copia del motor publicado; (2) alcance, una lista simulada con `docs/index.html`, `renv.lock` y el validador; (3) enlaces, un enlace a un archivo inexistente en una copia del README, por las dos vías (`enlaces.py` y `git cat-file`); (4) columnas, una columna más del directorio usada en una copia del paso 30 (`all.names()`); (5) raíz de datos, una línea `WORKSPACE_DATA_ROOT=` activa en una copia de `.Renviron.example` (Python y `R_ENVIRON_USER`); (6) I-1 e I-4, un hash alterado en una copia de cada instantánea; (7) I-2, un byte agregado a una copia de la vista publicada; (8) `json_motor` como palabra, plantado en una copia de `10_utils.R`; (9) red, un `<script src="https://…">` y un `url(http://…)` en una copia de la vista; (10) viñetas de D35-26, una palabra cambiada en una copia del archivo de decisiones; (11) privacidad, un RUT de prueba en una copia de este log; (12) I-3, un byte cambiado en medio de una copia de la vista (no agregado al final)
obtenido: **disparan los doce** (`control_positivo.txt`, 23:24:44):
1. identidad: la copia del motor con un byte agregado da el blob 55fb0e14… ≠ 2554f9a2…;
2. alcance, con `README.md`, `docs/index.html`, `renv.lock` y el validador en la lista simulada: «fuera: ['docs/index.html', 'renv.lock', '10_utils/10_validar_portabilidad.R']», código 1;
3. enlaces: `enlaces.py` marca «L319 … no_existe_s35q.md … FALLA» y «fallas: 1», y por `git cat-file`, «relativos=7 faltan=1». El «c=0» de ese bloque es el de `tail`, detrás de una tubería; corrido otra vez sin tubería (`control_3_sin_tuberia.txt`, 23:24:50), `enlaces.py` da código 1;
4. columnas: con `.data$DGV_RBD` plantada (una de las 47 columnas del directorio que el paso 30 no usa), «usadas 12 sin validar: DGV_RBD», código 1;
5. raíz de datos: con `WORKSPACE_DATA_ROOT=/tmp/control_s35q` plantada, Python cuenta 1 línea y R con `R_ENVIRON_USER` imprime `WORKSPACE_DATA_ROOT=[/tmp/control_s35q]`;
6. I-1 e I-4, con un hash alterado en una copia de cada instantánea: `diff`, código 1 y 1;
7. I-2, con un salto de línea agregado a una copia de la vista publicada: md5 e56d9a29… ≠ 883f76bc…;
8. `json_motor <- NULL` plantado en una copia de `10_utils.R`: `grep -rnw` halla 1 (código 0);
9. red, con `<script src="https://…">` y `url(http://…)` plantados en una copia de la vista: 1 y 1;
10. viñetas de D35-26, con «las entradas» cambiado por «una entrada» en una copia del archivo de decisiones: «iguales: False»;
11. privacidad, con un RUT de prueba en una copia de este log: 1 (código 0);
12. I-3, con un byte cambiado a la mitad de una copia de la vista: «vista byte a byte: FALSE», código 1.

**R.7 Veredicto por hallazgo.** Un dato que se cita abajo, medido antes:
`grep -n 'Locale UTF-8 obligatoria' .Renviron.example` y `grep -n 'Renviron.example:29' 50_documentacion/activa/50_locale_utf8.md`
esperado: la glosa de la sección de locale en L12 de `.Renviron.example` (antes, L29); la constancia la cita como `.Renviron.example:29` en L58 y L73
obtenido: `.Renviron.example` L12, «# Locale UTF-8 obligatoria (guarda asegurar_locale_utf8, POLITICA 5.2bis)» (g1=0); en `f7e966a` estaba en L29; `50_locale_utf8.md` L58 y L73 citan `.Renviron.example:29` (g2=0) (23:25:17).

- BLOQUEA: ninguno.
- REPARA: ninguno. Las 17 afirmaciones se confirmaron, los cuatro 🔒 están en PASA, el alcance no tiene rutas fuera y la regresión pasa. Ningún defecto del propio trabajo quedó dentro del ALCANCE.
- ADVIERTE: R-18 a R-22 (tabla R.10).
«0 hallazgos que reparar» se declara junto con los doce controles positivos de R.6.

**R.8 Ciclo de reparación:** no aplica (0 REPARA).

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado, meta ni ALCANCE, y no se tocó ningún 🔒: los dos valores del criterio de Q2 que no coincidieron (7 y L1-26) quedaron como se escribieron, con su obtenido al lado. Se corrigieron instrumentos, no criterios: el conteo de `awk` de R-09 (`^-[^-]`), con la primera salida guardada, y el código de salida del control 3, leído otra vez sin tubería. La evidencia ya escrita no se editó: la única corrección (el intervalo de R.2) se anexó como línea nueva que cita a la anterior (kit, §4.3 regla 4). No hubo subagentes.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1 | `diff-tree f7e966a`; `cat-file -e 8f10463:`; `git log --all` del log | 3 rutas; encargo nuevo; log sin commit | así | no | ninguna | no | no |
| R-02 | H2 | `rev-parse -q --verify refs/stash`; `test -d .git/worktrees` | sin stash ni worktrees | así | no | ninguna | no | no |
| R-03 | H3 e instantáneas | `cat-file -p f7e966a`; reflog de `origin/main`; R.3 | 8f10463; sin movimiento | así | no | ninguna | no | no |
| R-04 | H4 y T0 | `openssl dgst -md5`; `git show f7e966a:`; `diff-tree --numstat`; Python sobre las viñetas | 8c2d00f3…; 42ab…/883f…; 346; 4 iguales | así | no | ninguna | no | no |
| R-05 | H5 y validador | `arrow` `num_rows`; `wc -l`; `.vp_listar_archivos()` y `.vp_validar_entorno()` | 4 parquet; 16768; `.Renviron.example` no escaneado; OK | así | no | ninguna | no | no |
| R-06 | calibración de I-3 | controles 1, 7 y 12 de R.6 (otros defectos) | disparan | disparan | no | ninguna | no | no |
| R-07 | Q-96 | `grep -rnw` y `grep -rn` sobre el árbol | 0 y 2 | 0 y 2 | no | ninguna | no | no |
| R-08 | Q1, línea base | Python sobre los blobs de `f7e966a` | solo README; L246, L249, L252 | así | no | ninguna | no | no |
| R-09 | Q1, criterio | `grep -rlE` sobre el árbol; `grep -o` + `git cat-file -t HEAD:`; Python sobre `diff-tree -p` | 0; 6 sin faltantes; 1 trozo, 0 y 11 | así (tras corregir el `awk`) | no | ninguna | no | no |
| R-10 | Q2 | Python sobre el texto; `env -i` + `R_ENVIRON_USER`; `diff` de la sección de locale entre blobs; `grep -rnE` sobre el árbol | 0 y 5; solo `LANG`; igual; solo el validador | así; más POLITICA y SETTINGS (R-20) | no | ninguna | no | no |
| R-11 | Q3 | `all.names()` y `eval` de la lista; validación sobre cabeceras sintéticas; `diff-tree -p` | 11/10 y 11/11; el código viejo no se detiene y el nuevo sí; 1 y 1 | así | no | ninguna | no | no |
| R-12 a R-15 | I-1 a I-4 | R.3 | PASA | PASA | no | ninguna | no | no |
| R-16 | alcance | `alcance.py` | 0 fuera | 0 fuera | no | ninguna | no | no |
| R-17 | identidad y red | `git hash-object`; `grep -c http`, lista de URL, `fetch(` y llamadas de carga revisados a mano | iguales; 0 cargas | así | no | ninguna | no | no |
| R-18 | Q2 aparta `.Renviron.example` de §6.2 del protocolo de la cartera («Plantilla obligatoria … con … ambas formas de resolución») y de su §12 paso 3 (declarar `WORKSPACE_DATA_ROOT`). Lo decidió el titular (D35-26, Q-95) y coincide con POLITICA §8.2 (Rama A: «sin variable de entorno ni data root externo»); el protocolo de la cartera está fuera del repositorio y del ALCANCE | lectura del protocolo y de POLITICA | no aplica | tensión entre documentos | ADVIERTE | registrar (Q-99) | no | no |
| R-19 | `50_documentacion/activa/50_locale_utf8.md` L58 y L73 citan `.Renviron.example:29`; tras Q2 la glosa de locale está en L12. La constancia dice que sus secciones 1 a 4 son el estado del 2026-08-27, así que la cita es de esa fecha; está fuera del ALCANCE | `grep -n` (R.7) | no aplica | cita de línea desfasada | ADVIERTE | registrar (Q-100) | no | no |
| R-20 | la raíz de datos aparece en dos documentos no versionados: POLITICA §8.3 (Rama B, proyectos con datos privados) y SETTINGS L780 (ejemplo genérico `slep_x`); ninguno contradice Q2 | `grep -rnE` (R-10) | no aplica | sin efecto | ADVIERTE | registrar | no | no |
| R-21 | el validador, plantilla de la cartera excluida por §11, conserva L262 (sondeo de `obtener_data_root_proyecto`) y L280 (mensaje que remite a `WORKSPACE_DATA_ROOT` en `~/.Renviron` si la raíz no resuelve); por D35-26 no cuentan como uso, y el check está en OK | `grep -rnE` (R-10); `.vp_validar_entorno()` (R-05) | no aplica | sin efecto hoy | ADVIERTE | registrar | no | no |
| R-22 | errores propios, sin efecto sobre el trabajo: dos valores del criterio de Q2 escritos sin medir (7 por 5; L1-26 por L1-27) y el intervalo de R.2 escrito antes del `date`; de instrumento, una prueba de `enlaces.py` contra una raíz equivocada, el `awk` de R-09 y dos códigos leídos detrás de una tubería (`rd_renviron.txt` y el control 3) | no aplica | no aplica | registrados | ADVIERTE | registrar | no | no |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA y ningún REPARA. Las 17 afirmaciones del inventario quedaron confirmadas con otros instrumentos: git de bajo nivel, `openssl` y `git hash-object` en vez de `status` y `md5`; `grep -r` sobre el árbol en vez de `git grep`; Python sobre los blobs y el texto crudo; R con `all.names()`, `arrow` sin `data.frame`, las funciones internas del validador, la validación del paso 30 evaluada sobre cabeceras sintéticas y un R arrancado con `env -i` y `R_ENVIRON_USER`. Los doce controles positivos de la auditoría dispararon. Los cuatro 🔒 están en PASA y la regresión completa pasa (build 0; motor 8 de 8; vista 35 de 35; I-3 TRUE). Hay 5 ADVIERTE (R-18 a R-22), ninguno sobre datos, invariantes ni alcance; los que más pesan son R-18 (el archivo se aparta de la plantilla de la cartera, por decisión del titular) y R-19 (una cita de línea desfasada en una constancia fechada).

## Cierre

**Paso 1. Estado del árbol** (`git status --porcelain`, antes del commit de este log)
esperado: vacío o solo el log
obtenido: `?? 50_documentacion/andamios/logs/20260926_enlaces_renviron_s35q_log.md`, status_codigo=0 (23:26:08). Nada que limpiar. `CLAUDE.md` está ignorado (`git check-ignore -v`: `.gitignore:49`). Autorización 5: se agregó al comienzo de «Últimos cambios» la línea de s35q y se quitó la de s35l, la más antigua; la lista queda con 5 entradas, de s35q a s35m (`grep -c '^- s35'` = 5; 68 líneas; md5 8c3f5c3e6e95368b0a35439dbbe8d375; 23:26:25).

### 1. Resumen

Entraron tres tareas (Q1 a Q3) y la medición de Q-96, de D35-26, más T0. Las tres se completaron en su primer intento; ninguna se congeló. Las cuatro premisas de §2 se confirmaron al medirlas (H1 a H4, el `git grep` de Q-97, las líneas de `.Renviron.example`, del validador y del paso 30). El producto no cambió: `docs/` y `40_salidas/` siguen en 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…).
- **Q-96.** `git grep -nw 'json_motor'` fuera de `50_documentacion/` da 0: el criterio de P4 de s35p queda cumplido como palabra completa (sin `-w`, las 2 líneas de `extraer_json_motor()` de la batería).
- **Q1 (Q-97).** El README deja de enlazar los dos documentos de junio que s35p archivó (11 líneas, L246-256, solo quitadas). El `git grep -l` de §2 queda vacío y los 6 enlaces relativos del README apuntan a destinos que existen, están versionados y no están ignorados (en la copia de partida, 2 de 8 estaban rotos).
- **Q2 (Q-95).** `.Renviron.example` pasa de 34 a 17 líneas: sin las opciones A y B ni su validación, con una cabecera que dice para qué sirve y que se copia a `~/.Renviron`, y con la sección de locale (`LANG=es_ES.UTF-8`) byte a byte igual. El validador da lo mismo que en H5, y el archivo nuevo, copiado a `~/.Renviron`, fija lo mismo que el viejo: solo `LANG`. Se aparta de §6.2 del protocolo de la cartera, por decisión del titular y de acuerdo con POLITICA §8.2 (Q-99).
- **Q3 (Q-98).** `cols_csv_esperadas` incluye `COD_DEPE`: el paso 30 valida las 11 columnas del directorio que usa. En una copia sin esa columna, el build se detiene en la validación del paso 30 con «Faltan columnas en directorio_oficial_ee.csv»; con el código de antes, la misma copia pasaba la validación y fallaba en el bloque 4 («Column `COD_DEPE` not found in `.data`»). Las salidas no cambian.

FASE R: 17 de 17 afirmaciones confirmadas con otros instrumentos; 12 controles positivos disparan; los 4 🔒 en PASA; regresión completa en PASA; 0 BLOQUEA, 0 REPARA y 5 ADVIERTE. Veredicto: **APROBADO CON ADVERTENCIAS**.

### 2. Inventario de commits (`git log f7e966a..HEAD --oneline`, antes del commit de este log; 23:26:25)

```text
a238458 fix(pipeline): el paso 30 valida la columna COD_DEPE del directorio (Q-98)
43aede2 docs(entorno): .Renviron.example sin la raiz de datos que el proyecto no usa (Q-95)
d8ba99d docs(readme): quita los enlaces a la documentacion de junio archivada (Q-97)
```

Q1 `d8ba99d`, Q2 `43aede2` y Q3 `a238458`. Más el punto de retorno, `f7e966a docs(sesion 35): encargo de la decimoseptima ola y decision D35-26` (T0), y el commit de este log, `docs(log): enlaces del README, Renviron y COD_DEPE (s35q)`, cuyo hash va en el reporte final (un archivo no puede llevar el hash de su propio commit). No hubo `fix(auditoria)`. `git diff --stat f7e966a HEAD`: 3 archivos, 7 inserciones y 35 borrados; con T0 (`f7e966a^`): 6 archivos, 353 inserciones y 35 borrados.

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-22).

### 4. Invariantes

I-1 a I-4 en PASA en el estado final (FASE R, R.3), con re-derivación por otra vía (R.2) y controles positivos que disparan (R.6); I-3, además, sobre el build final de R.5. En FASE L se miden otra vez I-1, I-2 e I-4 contra las instantáneas de FASE 0:
esperado: I-1, `diff` fuera de las tres refs de `main`, código 0; I-2, 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3; I-4, `diff`, código 0
obtenido: I-1, `diff` código 0 (`$TMPDIR/s35q/i1_fase_l.txt`); `main` a2384586…, `origin/main` 8f104631…; I-2, 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3; I-4, `diff i4_fase0.txt i4_fase_l.txt`, código 0 (23:26:45). I-3 no cambia después de R.5: ningún comando posterior tocó el código ni las salidas. En ninguna fase un 🔒 dio FALLA. Antes del push se miden las condiciones de la autorización 6 (reporte final).

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 (8c2d00f38048e7c05ddc70ade905e0cb, verificado, igual).
- En el encargo: D35-26 (Q-95 a Q-98; commiteada en T0) y las autorizaciones. Se usaron la 1 (T0, Q1, Q2 y Q3), la 4 (todo lo de `$TMPDIR`, incluidas la copia del repositorio del control de Q3 y el borrado de las dos copias del CSV) y la 5 (la línea de s35q en `CLAUDE.md` y el recorte a 5, que sacó s35l); la 6 va en el reporte final. La 3 no se usó: ningún intento se descartó. Además, este `docs(log)`, implícito en el patrón; no hubo `fix(auditoria)`.
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión; git 2.54.0, R 4.5.2 con `renv`, Python 3.14.7, Chrome sin interfaz vía `chromote`)

- Q-96: `git grep -nw 'json_motor'` fuera de `50_documentacion/`, 0; sin `-w`, 2.
- Q1: `README.md` 328 → 317 líneas (md5 9272c291… → e3a554ad9f2bb2cc8abea6f40265500f), `--numstat` 0 11, 1 trozo; enlaces relativos 8 con 2 rotos → 6 con 0; el `git grep -l` de §2, 1 archivo → 0.
- Q2: `.Renviron.example` 34 → 17 líneas (md5 cb80f9c0… → 9706173a59cae092a24ce95fa3af4a23), `--numstat` 6 23, 3 trozos; líneas con `DATA_ROOT`/`obtener_data_root` 5 → 0; `LANG` 1; la sección de locale pasa de L28-34 a L11-17, igual byte a byte.
- Q3: `30_construir_auxiliares.R` 460 líneas antes y después (md5 28eac6ca… → c7d0c207a323c0c3a91e71f755331f4f), `--numstat` 1 1; columnas del directorio usadas 11, validadas 10 → 11; el directorio tiene 58 columnas y 16768 filas (la copia del control, 57 y 16768).
- T0: archivo de decisiones con 9 líneas agregadas (md5 bd3a93c4… → 606f5606e5f5ad6ebce23a8185d668fa); 346 inserciones en el commit.
- Build: código 0, 0 fallas críticas y 7 advertencias (H5, Q2, Q3 y R.5); paso 30 con 73, 345, 2337 y 10945 filas en sus cuatro parquet. Baterías: motor 8 de 8 (70 s, dos veces), vista 35 de 35 (dos veces).
- `docs/` y `40_salidas/`: 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…), sin cambio; `renv.lock` e6323bf2… y `renv/settings.json` d0bcb98d…, sin cambio. `CLAUDE.md` (ignorado) 70 → 68 líneas.

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno. Este encargo cierra Q-95 (y con ella Q-90 de D35-25), Q-96, Q-97 y Q-98.

Dudas nuevas (se responden con una palabra):
- Q-99 (Q2, R-18). `.Renviron.example` ya no trae las opciones A y B que §6.2 del protocolo de la cartera (`herramientas_dev/gobernanza/protocolo_portabilidad_cross_os.md`) declara obligatorias, ni lo que pide su §12 paso 3; POLITICA §8.2 (Rama A) dice que un proyecto público va «sin variable de entorno ni data root externo», que es el caso de este proyecto. ¿Se anota en el protocolo de la cartera que §6.2 y §12 paso 3 aplican solo a los proyectos de Rama B? (sí / no). Bloqueó: nada.
- Q-100 (Q2, R-19). `50_documentacion/activa/50_locale_utf8.md` (L58 y L73) cita `.Renviron.example:29`, la línea de la glosa de locale al 2026-08-27; desde Q2 está en L12. ¿Se deja la constancia como registro fechado, sin tocar? (sí / no). Bloqueó: nada.

Pendientes que quedan al titular: las respuestas a Q-99 y Q-100; la lectura del README publicado (sección «Documentación») y de `.Renviron.example`; el traspaso de cierre; siguen Q-70 y Q-71. Excluidos por §11 y sin tocar: `docs/`, la suite, `10_validar_portabilidad.R`, `renv`, `feat/contrato-contexto`, Museo Sans (D35-7), Q-70 y Q-71.

`# REVISAR`: ninguno nuevo (se mide en el paso 4).

### 8. Errores propios consolidados

- De pre-registro, sin efecto sobre el trabajo: en el criterio de Q2, dos valores escritos sin medir: «7» para el `grep -c` de la copia de partida (dio 5, la cifra que s35p ya había medido) y «L1-26» para el diff (tocó también L27, una línea en blanco); quedaron como se escribieron, con su obtenido. En R.2, el intervalo «23:19 a 23:24» se escribió antes del `date` (23:21:34) y se corrigió con una línea nueva que cita a la anterior. Es el patrón de ERR-35-29: una cifra escrita antes de contarla. Costo: ninguno sobre datos, producto ni criterios; unos minutos.
- De instrumento, corregidos antes de registrar: una prueba de sintaxis de `enlaces.py` contra una raíz equivocada (Q1; no midió nada; valió `py_compile` y la calibración); el conteo de `awk` de R-09, con `^-[^-]`, excluía las dos líneas que empiezan con «- [» y dio 9 en vez de 11 (se contó con Python; la primera salida quedó guardada); dos códigos de salida leídos detrás de una tubería (`rd_renviron.txt`, donde la evidencia son los valores impresos, y el control 3 de R.6, que se corrió otra vez sin tubería y dio 1).
- Ninguno tocó los datos ni el contenido publicado, y ninguno costó más de un turno.

### 9. Notas para el revisor

- Qué leer primero: Q-99. Q2 hace lo que decidió el titular (D35-26) y lo que dice POLITICA §8.2 para un proyecto público, pero deja a `.Renviron.example` fuera de la plantilla de §6.2 del protocolo de la cartera.
- Q2 no cambia lo que el archivo hace: las opciones A y B y su validación estaban comentadas, así que el viejo y el nuevo, copiados a `~/.Renviron`, fijan solo `LANG` (medido con `readRenviron()` y con `R_ENVIRON_USER`).
- Q3: el control positivo se hizo en una copia del repositorio en `$TMPDIR`, sin `.git/`; las dos copias del directorio sin `COD_DEPE` se borraron al terminar, porque el CSV trae MRUN.
- El producto no cambió: `docs/` = `40_salidas/` = base de H5, byte a byte (`git hash-object`, `cmp`).
- Tras el push, conviene mirar en GitHub la sección «Documentación» del README.
- Verificación del archivo (FASE L, paso 5): se mide después de este párrafo y va en el paso 5.

### 10. Estado de cierre

- **Commiteado:** T0 (`f7e966a`), Q1 (`d8ba99d`), Q2 (`43aede2`), Q3 (`a238458`) y, al cerrar esta sección, este log (`docs(log)`), en `main`.
- **Local, sin versionar:** `CLAUDE.md`, con esta línea agregada al comienzo de «Últimos cambios» y la lista recortada a las 5 más recientes, que sacó s35l (autorización 5; D35-22 y D35-24): «- s35q (2026-09-26): el README ya no enlaza los documentos de junio archivados (Q-97); `.Renviron.example` sin la raíz de datos, solo con la sección de locale y `LANG` (Q-95); el paso 30 valida la columna `COD_DEPE` del directorio (Q-98); el criterio de `json_motor` de s35p se mide como palabra completa y queda cumplido (Q-96).» En `$TMPDIR` quedan las carpetas de trabajo de §1 del encabezado y la copia del repositorio del control de Q3, sin el directorio oficial.
- **Condiciones de publicación** (autorización 6), medidas después del commit del log, en el mismo turno: veredicto de FASE R `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío (`CLAUDE.md`, ignorado, no cuenta); `git fetch origin` y `git merge-base --is-ancestor origin/main HEAD` con código 0; md5 de `docs/` sin cambio (I-2). Si se cumplen, `git push origin main` una sola vez; si no, se declara en el reporte final. El resultado y el hash de este commit van en el reporte final.
- **Queda al titular:** Q-99 y Q-100, la lectura del README y de `.Renviron.example` publicados, el traspaso de cierre, Q-70 y Q-71.

**Paso 4. Privacidad** (23:28:05). `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]'` sobre este log: vacío, código 1 (`$TMPDIR/cal_s35q/privacidad.txt`, 0 líneas). Un `grep -niE` de nombres de establecimientos, comunas y personas (`liceo`, `escuela`, `colegio`, `rbd <número>`, seis nombres de comunas de la región y el nombre del titular) y de rutas de OneDrive (`onedrive-`, `cloudstorage`): 0 líneas, código 1 (leído sin tubería; `privacidad_nombres.txt`). La lectura lo confirma: no hay filas de datos ni nombres de personas o de establecimientos; las cifras son conteos, md5, hashes, posiciones y números de línea; los nombres de columna del directorio (`COD_DEPE`, `DGV_RBD` y afines) no son datos. Los identificadores que aparecen son la ruta de la estación que exige la plantilla (ENTORNO) y la de `$TMPDIR`. Guiones largos en este log: 1 línea (L237), la cita del título de POLITICA §8.2 («Rama A — Proyecto 100% público»); 0 en texto nuevo. `# REVISAR` en el diff total `f7e966a..HEAD` (`$TMPDIR/cal_s35q/diff_total.txt`): 0 (código 1, 23:27:31).

**Paso 5. Verificación del archivo** (23:28:30, antes de este párrafo): `ls -l` = `-rw-r--r--  1 tomgc  staff  73953 26 Sep 23:28 50_documentacion/andamios/logs/20260926_enlaces_renviron_s35q_log.md`; `wc -l` = 411. `grep -c '^### FASE'` = **5**, igual a las fases con sección propia (FASE 0, Q1, Q2, Q3 y FASE R; FASE L es este Cierre). `grep -c '^## J'` = **1**, con el bloque relleno (13 campos, una línea cada uno). `grep -c '^esperado:'` = **22** y `grep -c '^obtenido:'` = **19**: no son iguales. La diferencia son tres líneas de formato: los resultados de los criterios de Q1 (L103), Q2 (L145) y Q3 (L180) empiezan con «obtenido (» y la hora, no con «obtenido:». Cada `esperado:` tiene su resultado; como pide el paso 5, las tres líneas faltantes se anexan aquí con su estado real, y el conteo se mide otra vez:
obtenido: (línea faltante del criterio de Q1, anexada en FASE L; el resultado está en L103 y siguientes) **Cumple**: `git grep -l` vacío, 0 menciones en el README, 6 enlaces relativos sin fallas, un trozo que solo quita L246-256.
obtenido: (línea faltante del criterio de Q2, anexada en FASE L; el resultado está en L145 y siguientes) **Cumple lo que pide §7 Q2.2**; dos valores agregados por el orquestador no coincidieron (5 por 7; L1-27 por L1-26).
obtenido: (línea faltante del criterio de Q3, anexada en FASE L; el resultado está en L180 y siguientes) **Cumple**: diff de un trozo, 11 de 11 columnas validadas, I-3 TRUE, el control dispara con el código nuevo y no con el de antes, baterías 8 de 8 y 35 de 35.

Recuento tras anexar (23:28:41): `grep -c '^esperado:'` = **22** y `grep -c '^obtenido:'` = **22**; `grep -c '^### FASE'` = 5; `grep -c '^## J'` = 1; `wc -l` = 416 antes de este párrafo. Error propio de formato, que se suma a los seis de §8 (son 7): los tres rótulos «obtenido (» con la hora, el mismo caso de s35p; costo, estas tres líneas. El bloque J se ajusta a esa cifra (es el único texto ya escrito que FASE L puede editar).
