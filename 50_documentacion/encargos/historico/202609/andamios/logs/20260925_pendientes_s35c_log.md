# Log: pendientes de la sesión 35, tercera ola (slep_simce_adecuado)

- Meta: aplicar D35-7 (NOTICE de gobCL), D35-8 (regla C de las cifras de la sparkline), D35-9 (Regular y Bold con la familia `gobCL-sitio`) y D35-10 (criterio y referencias de A3); corregir el tooltip del referente, el plano de la vista entre 680 y 800 px y el documento de datos autorizados; y publicar en `main` los commits de s35b y de este encargo, sin tocar `docs/`.
- Fecha: 2026-09-25 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: d1b6a43 (commit de T0)
- Encargo: `50_documentacion/activa/encargos/encargo_pendientes_s35c.md`, md5 `acea9ddba6db107ea7e80d8c675ed6e6` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo ultracode; orquestador Opus; subagentes tope 3 (≤ 3 Opus); total Opus ≤ 8
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; esfuerzo `ultracode` (orquestación con la herramienta Workflow); orquestador Opus 5.5 (`claude-opus-5-5[1m]`); subagentes lanzados con Workflow, una ola por invocación, con a lo más 3 agentes simultáneos, todos Opus 5.5 (heredado de la sesión) con esfuerzo `xhigh`.
- Grafo y olas (copiados de §5 del encargo):
  - T0 es la raíz. N1 y D1 requieren T0. F1 requiere T0. S1 requiere F1 (la regla se mide con la fuente final). V1 requiere F1. F2 requiere S1 y V1. FASE R y FASE L no dependen de ninguna tarea: corren siempre.
  - Olas: (orquestador) FASE 0, T0, N1, D1 · Ola 1: F1 (escritura Opus ×1) · Ola 2: S1 (motor), V1 (vista) (escritura Opus ×2) · Ola 3: F2 (escritura Opus ×1) · FASE R: panel adversarial (lectura Opus ×3). Total Opus declarado: 7 (tope 8).
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- I-7 se mide en forma absoluta (§1, reglas canónicas).

## J. Juicio (lo rellena FASE L)

- Meta y resultado: D35-7 (NOTICE declara gobCL fuera de Apache 2.0), D35-8 (regla C: 0 inversiones, 0 superposiciones, 0 cifras fuera y 0 ocultas en las 2.832 sparklines, frente a 627/893 inversiones), D35-9 (`gobCL-sitio` con Regular 400 y Bold 700) y D35-10 (sin desborde; 12 referencias y 6 capturas de revisión regeneradas) aplicadas; tooltip del referente desde `DATA` (R7), plano de 360 px entre 680 y 822 px y documento de datos corregidos; todo commiteado; push condicionado a la autorización 4, con las condiciones medidas antes del commit del log (resultado en el reporte final).
- Estado por tarea: FASE 0 completa · T0 completa · N1 completa · D1 completa · F1 completa (D-F1-a, D-F1-b) · S1 completa · V1 completa (dos commits) · F2 completa sin cambios (sin commit) · FASE R: 1 REPARA corregido (R-22), 11 ADVIERTE, 0 BLOQUEA.
- Commits: d1b6a43 (T0, punto de retorno), d900bb1 (N1), 276a447 (D1), 41de233 (F1), 674522d (S1), 28caa7f y 86319b6 (V1), 7273760 (R-22), más docs(log) (hash en el reporte final).
- Auditoría (FASE R): panel de 3 Opus; 40 afirmaciones CONFIRMADA y 0 REFUTADA; R-22 (H-F1-1, 342 pares de cifras rescatadas en barras apiladas desde F1) REPARA, corregido con `RECENT_DIMS.rescate` (342 → 0, dos instrumentos); R-42 a R-52 ADVIERTE; control positivo disparó; veredicto APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-11 PASA en el estado final `7273760` (I-7 absoluto vacío; I-5 idéntico; C3 PASA).
- Cifras críticas: barrido 627/893/1.079 → 0/0/0, laterales 1.366 → 0, ocultas 0; barras apiladas 0 → 342 (F1) → 0 (R-22); caras `gobCL-sitio` 400 y 700 cargadas, `measureText` −17,04 px (0 sin la cara); HTML −50.420 B y −50.464 B tras F1; plano 117-184 y 0-166 → 360 px; `scrollWidth` 18/18 y 21/21; batería 31 → 32; motor ebf7f46b…, vista 20f3214d…, parquet 468099a9…; `docs/` 8deb0459…/267857a2….
- Decisiones autónomas de mayor riesgo: D-F1-a (criterio (iii) de F1 en la forma con respaldo, porque la literal no discrimina); D-S1-a (salidas laterales resueltas corriendo la `x` de la cifra, sin ocultar); D-S1-b (posición inicial `cy − 6` sin la cota `max(8, ·)`); D-F1-b (Bold con modo 100755, sin `chmod`, fuera de la lista cerrada); reparación de R-22 hecha por el orquestador en serie.
- Desviaciones respecto del encargo: F2 sin commit (previsto por el encargo); criterio (iii) de F1 registrado en dos formas (D-F1-a); V1 separado en dos commits copiando al árbol la plantilla del paso 1 del subagente; no se creó CLAUDE.md (regla global frente a `.gitignore` y a un ALCANCE cerrado); el conteo `^esperado:`/`^obtenido:` del log difiere en 1 (punto 8 del cierre).
- Dudas abiertas: Q-40 a Q-49 (en «Cierre», punto 7), ninguna condiciona la publicación en `main`.
- Errores propios: 8 del orquestador (modo 100755 por `cp`; calibración de S1 sobre la base equivocada, corregida antes de lanzar; «36 comparaciones» en F2; contrato de auditores que prohibía leer su propio contrato, corregido antes de lanzar; dos imprecisiones del inventario; un tiempo agotado del instrumento; un código de salida de `tail`; una línea «obtenido (tabla…)»). Ninguno tocó el producto.
- Qué debe verificar el revisor por sí mismo: en Safari y en un equipo sin gobCL instalada, gobCL en las dos páginas, la sparkline de 5103 Medio bajo y las rachas con «†» (Q-42), el tooltip con «†», las barras apiladas con cifras rescatadas, el tooltip del referente y el plano a 680-822 px; la carrera de fuente de la sparkline (Q-48); NOTICE antes de publicar a `docs/`.
- No publicado / queda al usuario: `docs/` y Pages sin tocar (publicación excluida); revisión en Safari; Q-40 a Q-49. El push a `main` se informa en el reporte final.
- Ejecución: ultracode con Workflow; orquestador Opus 5.5; 7 agentes Opus 5.5 con esfuerzo xhigh (F1 · S1, V1 · F2 · 3 auditores), a lo más 3 simultáneos (máximo real 3, en FASE R); tope Opus 8 respetado (7 usados); reparación de FASE R hecha por el orquestador.

### FASE 0: log, punto de retorno y premisas

Paso 1: log creado antes de H1 (`50_documentacion/andamios/logs/` ya existía). Por eso H1 muestra también la línea del propio log, como prevé §6.2.

**H1.** `git -C "$RAIZ" status --porcelain`
esperado: las tres rutas de §2 (` M` decisión, ` M` errores, `??` encargo), más la línea del log recién creado
obtenido:
```text
 M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
 M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_pendientes_s35c.md
?? 50_documentacion/andamios/logs/20260925_pendientes_s35c_log.md
```

**H2.** `git -C "$RAIZ" stash list | wc -l`
esperado: 0
obtenido: 0

**H3.** `git -C "$RAIZ" fetch origin` (fetch_codigo=0, sin salida), luego `git -C "$RAIZ" rev-parse --short HEAD` y `git -C "$RAIZ" rev-parse --short origin/main` en dos comandos
esperado: 5e65bd3 y 9d612a3
obtenido: 5e65bd3 y 9d612a3 (14 commits sin publicar: `git log --oneline 9d612a3..HEAD | wc -l` = 14)

**H4.** `md5 -q docs/index.html docs/trayectorias.html 10_utils/10_locale.R`; `md5 -q` de las dos rutas modificadas y del encargo
esperado: 8deb04595510b0f15da8bb65813b7a38, 267857a2962602bd9e6c5cc56effcb47, dc900c1b0d2d252c9e5730875be5d632; f31780f85bdadd6e1c50c63903a38036 y 15e6fbb6860435c72e9e9b8665e7d221; encargo acea9ddba6db107ea7e80d8c675ed6e6 (mensaje de entrega)
obtenido: 8deb04595510b0f15da8bb65813b7a38, 267857a2962602bd9e6c5cc56effcb47, dc900c1b0d2d252c9e5730875be5d632; f31780f85bdadd6e1c50c63903a38036 y 15e6fbb6860435c72e9e9b8665e7d221; acea9ddba6db107ea7e80d8c675ed6e6

**T0.** `git add` de las tres rutas y `git commit -m "docs(sesion 35): decisiones D35-7 a D35-10, errores ERR-35-12 a ERR-35-15 y encargo de la tercera ola"`
esperado: un commit con esas tres rutas; el árbol queda solo con el log sin seguir
obtenido: `d1b6a43 docs(sesion 35): decisiones D35-7 a D35-10, errores ERR-35-12 a ERR-35-15 y encargo de la tercera ola`; `git show --name-only` = la decisión, el encargo y el log de errores; `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260925_pendientes_s35c_log.md`. **Punto de retorno: d1b6a43.**

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"` (salida en `$TMPDIR/cal_s35c/h5.txt`)
esperado: 31 pruebas en PASA y codigo=0
obtenido: «Resultado: 31 pruebas, 31 pasan, 0 fallan», codigo=0

**H6.** `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"` (salida en `$TMPDIR/cal_s35c/h6.txt`)
esperado: codigo=0
obtenido: codigo=0; «Fallas criticas: 0 | Advertencias: 7»; «DATA: 9 años, 74 entidades, 24745 filas en datos, 20948 en nube, 180 comunas (2.0 MB)»; «Escrito 40_salidas/trayectorias_traspasos.html (2.25 MB)»; «00_build.R: OK en 6 segundos»

Línea base en `$TMPDIR/base_s35c/` (`cp` de las dos salidas y `md5 -q` en origen y copia)
esperado: dos copias con el mismo md5 que el original
obtenido: motor_comparacion.html 99529ee31cf27e41e6417f76aa07d262 (2.954.547 B); trayectorias_traspasos.html 5897a6a361ecd03c4ff73b1eee1300a7 (2.252.447 B); iguales en origen y copia (y a los del estado final de s35b); parquet comunal 468099a9c63bb3c0ddb74e67e2c7c19f

`verificar_contenido_motor.R` comparaba contra `$TMPDIR/base_s35b/`: se apuntó a `$TMPDIR/base_s35c/` (línea 24 y comentario de la línea 12).

Calibración del comparador (`$TMPDIR/cal_s35c/alterar_json_motor.R`, copia del de s35b: motor base con el primer decimal del JSON alterado; luego `Rscript verificar_contenido_motor.R <copia>`)
esperado: «idéntico» sobre el build de H6 y sobre la base; «difiere» sobre la copia alterada
obtenido: «fragmento original: 3.5 -> alterado: 3.6»; build de H6 «JSON idéntico a la línea base» codigo_actual=0; base «JSON idéntico a la línea base» codigo_base=0; copia «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)» codigo_alterado=1

**H7 (fuente Bold).** `find "$HERRAMIENTAS_DEV_PATH" -iname "gobCL*"`, `ls ~/Library/Fonts | grep -i gobcl`, `ls renv/library/*/*/*/suitedoc/tema/fonts/` y `md5 -q` de cada candidata
esperado: al menos una `gobCL_Bold.otf` con md5 a7407ed6a70160cdb96021f83808a94c
obtenido: `$HERRAMIENTAS_DEV_PATH` (= /Users/tomgc/Projects/herramientas_dev) solo trae Regular, Heavy y Light en `suitedoc/inst/tema/fonts/`; `renv/library/*/*/*/suitedoc/tema/fonts/` trae las mismas tres más Museo Sans; **`~/Library/Fonts/gobCL_Bold.otf`: md5 a7407ed6a70160cdb96021f83808a94c, 44.716 B** (única Bold hallada)

Peso y copyright (`$TMPDIR/cal_s35c/leer_otf.R`: lector propio con `readBin` de las tablas `OS/2` y `name`; `systemfonts` no está en la biblioteca de renv del proyecto)
esperado: `usWeightClass` 700 en la Bold; copyright legible en la Bold y la Regular
obtenido: Bold `usWeightClass 700`, `fsType 4`, familia «gobCL», estilo «Bold», marca «Gobierno de Chile, 2010»; Regular `usWeightClass 400`, `fsType 4`; Heavy 900 (`fsType 0`); Light 300 (`fsType 0`). Copyright (registro 0), transcrito en NOTICE; aquí, por la regla de privacidad de FASE L, sin el nombre de persona: Bold «(c) 2010 by <autor> / www.frescotype.com»; Regular «©<autor>, frescotype.com». **H7 da lo esperado.**

**H8 (barrido de sparklines).** Medidor hallado: `$TMPDIR/cal_s35b/r48/amplio2.R` + `amplio2.js` (con el arnés `$TMPDIR/s35b_r2/h.R`), el del ciclo de R-48 de s35b. Resumen con `$TMPDIR/cal_s35c/resumir.R` (derivado de `resumir2.R` de s35b). Corrida: `Rscript $TMPDIR/cal_s35b/r48/amplio2.R $TMPDIR/base_s35c/motor_comparacion.html $TMPDIR/cal_s35c/amplio_base.rds`
esperado: 627 inversiones (métrica del auditor), 893 (estricta), 0 superposiciones y 1 cifra fuera
obtenido: «sparklines 2832 | barras 5664 | solapes 0 | fuera arriba 1 abajo 0 lados 7079 | subidas 1479 | bajadas 0 | invertidas (auditor) 627 | invertidas (todas) 893 | subida máx 31». **H8 da lo esperado** (la «1 fuera» es la de arriba, R-53).

Desglose de «lados» (información para S1; `$TMPDIR/cal_s35c/fuera_desglose.R base`)
esperado: (sin esperado previo; medición informativa)
obtenido: de las 7.079 salidas laterales, 5.664 son una cifra por gráfico de barras por la izquierda (2.832 + 2.832, fuera del ALCANCE de S1); en la sparkline, 1.366 cifras con «†» salen por los lados (535 por la izquierda y 831 por la derecha, mediana 2,3 px; 0 cifras sin «†»), más 49 rótulos «traspaso» por la derecha. El criterio de S1 («por los lados no más que las 5 cifras de 1,8 u de R-62») se escribió con la medición del estado por defecto, no con la del barrido amplio.

**Cierre de FASE 0.**
- Estado: completa. H1-H8 dan lo esperado.
- Commits: `d1b6a43` docs(sesion 35): decisiones D35-7 a D35-10, errores ERR-35-12 a ERR-35-15 y encargo de la tercera ola (T0, punto de retorno).
- Cambios sustantivos: ninguno sobre el producto. `verificar_contenido_motor.R` (ignorado) apunta a `$TMPDIR/base_s35c/`.
- Alcance: T0 tocó solo sus tres rutas.
- Regresión: H5 y H6 son la regresión de partida.
- Subagentes: ninguno. Cuenta Opus acumulada: 0.
- Bugs: ninguno.
- Decisiones autónomas: D0-a (riesgo bajo): la Bold se toma de `~/Library/Fonts`, única ubicación de las tres de H7 donde aparece, con el md5 del evaluador.
- Errores propios: ninguno en esta fase.
- Dudas: ninguna.

### FASE N1: NOTICE declara gobCL (D35-7) (orquestador)

- Estado: completa.
- Commits: `d900bb1` docs(licencia): NOTICE declara la tipografia gobCL fuera de Apache 2.0 (D35-7).
- Paso 0: `cat -n NOTICE` (40 líneas; secciones de licencia, alcance «solo código, no datos» y «COMPONENTES DE TERCEROS» con D3, pako y React; ninguna tipografía).
- Cambios sustantivos (+25 líneas): en «ALCANCE DE LA LICENCIA», un párrafo que excluye los activos tipográficos (archivos de fuente y su copia codificada en plantillas y páginas) de las «plantillas HTML/JS/CSS» y de todo componente cubierto; al final, la sección «TIPOGRAFÍA»: el sitio incrusta y el repositorio versiona gobCL, caras Regular y Bold (`10_utils/fuentes/gobCL_Regular.otf` y `gobCL_Bold.otf`), tipografía institucional del Gobierno de Chile; el copyright de la tabla `name` de cada cara, transcrito tal cual (H7); la marca registrada en la tabla (`Gobierno de Chile, 2010`); que Apache 2.0 **no** la cubre; que se usa por decisión del titular, como tipografía institucional de un servicio público del Estado (D35-7); y que quien reutilice el código debe obtenerla de su fuente oficial o reemplazarla. El párrafo del alcance dice «tipografía» en minúsculas para que `TIPOGRAF` aparezca en una sola línea.
- Verificación:

`grep -c 'gobCL' NOTICE` y `grep -n 'TIPOGRAF' NOTICE`
esperado: 2 o más; una línea
obtenido: 6; `48:TIPOGRAFÍA`

Transcripción literal del copyright (cadena del registro 0 leída con `leer_otf.R`, buscada con `grep -cF` en NOTICE)
esperado: 1 y 1
obtenido: «(c) 2010 by … / www.frescotype.com» → 1; «©…, frescotype.com» → 1

- PRUEBAS: no aplica (sin código).
- Alcance: `git show --name-only d900bb1` = `NOTICE`. Dentro del ALCANCE.
- Subagentes: ninguno. Cuenta Opus acumulada: 0.
- Bugs: ninguno.
- Decisiones autónomas: D-N1-a (riesgo bajo): NOTICE nombra las caras Regular y Bold antes de que F1 copie la Bold (el orden del grafo pone N1 antes de F1); si F1 se congelara, NOTICE describiría un estado futuro y quedaría como hallazgo.
- Errores propios: ninguno.
- Dudas: ninguna.

### FASE D1: documento de datos autorizados (Q-36) (orquestador)

- Estado: completa.
- Commits: `276a447` docs(gobernanza): datos autorizados precisa el alcance de sus globs (Q-36).
- Paso 0: `cat -n` del documento (110 líneas). Frases afectadas: L67-71 («No cubre a `directorio_oficial_ee.csv`… excluido por `.gitignore` (líneas 34-38)… Ninguna entrada… debe ampliarse de modo que lo alcance») y L78-80 («No cubre subcarpetas. `glob2rx()` ancla en ambos extremos y `*` no cruza `/`»).
- Medición previa (`Rscript --vanilla -e` con `glob2rx()` sobre las dos entradas de `auxiliares/` y tres rutas de prueba)
esperado: si R-54 es cierto, `*` pasa a `.*` y alcanza subcarpetas y `directorio_oficial_ee.csv`
obtenido: `20_insumos/auxiliares/*.xlsx -> ^20_insumos/auxiliares/.*\.xlsx$`, alcanza `20_insumos/auxiliares/algo/x.xlsx` (TRUE); `20_insumos/auxiliares/*.csv -> ^20_insumos/auxiliares/.*\.csv$`, alcanza `algo/x.csv` (TRUE) y `20_insumos/auxiliares/directorio_oficial_ee.csv` (TRUE)
- Cambios sustantivos (+17/−8): una línea «Corrección» en la cabecera; «No cubre a `directorio_oficial_ee.csv`» pasa a «No autoriza…, aunque el verificador lo alcanzaría»: la entrada `*.csv` sí lo alcanza en I8 y el archivo queda fuera solo porque lo ignora `.gitignore` (línea 44), que no debe relajarse; «No cubre subcarpetas» pasa a «No autoriza subcarpetas, aunque el verificador las alcanzaría», con la conversión real de `glob2rx()`; la cita de `.gitignore` para los intermedios queda en la línea 10 (ya era correcta). El bloque cercado de «Entradas» sigue siendo el primero (primera cerca en la línea 22).
- Verificación:

Citas de líneas de `.gitignore` en el documento frente a `grep -n` del patrón en `.gitignore`
esperado: cada número citado igual al de `grep -n`
obtenido: documento «`.gitignore` (línea 44» y «`.gitignore`, línea 10»; `grep -n` = `44:20_insumos/auxiliares/directorio_oficial_ee.csv` y `10:40_salidas/intermedios/*.parquet`. Coinciden.

- PRUEBAS: no aplica (sin código).
- Alcance: `git show --name-only 276a447` = `50_documentacion/activa/50_datos_versionados_autorizados.md`. Dentro del ALCANCE.
- Subagentes: ninguno. Cuenta Opus acumulada: 0.
- Bugs: ninguno.
- Decisiones autónomas: ninguna (Q-36 se resuelve corrigiendo el documento, como pide D1; el verificador I8 vive fuera del repositorio y no se toca).
- Errores propios: ninguno.
- Dudas: ninguna.

### FASE F1: dos caras de gobCL con familia propia (D35-9) (ola 1, escritor Opus)

- Estado: completa, con un criterio literal que no discrimina ((iii) sin respaldo), declarado y suplido con la forma que sí discrimina (D-F1-a).
- Commits: `41de233` feat(sitio): gobCL-sitio con Regular 400 y Bold 700; retira Light y Heavy (D35-9).
- Paso 1 (orquestador, autorizaciones 7 y 2): `md5 -q ~/Library/Fonts/gobCL_Bold.otf`, `cp` a `10_utils/fuentes/gobCL_Bold.otf`, `md5 -q` de la copia y del origen; luego `git rm -q 10_utils/fuentes/gobCL_Light.otf 10_utils/fuentes/gobCL_Heavy.otf`.
esperado: a7407ed6a70160cdb96021f83808a94c antes, en la copia y en el origen después; Light y Heavy fuera del índice y del disco
obtenido: «antes origen: a7407ed6a70160cdb96021f83808a94c», «copia: a7407ed6a70160cdb96021f83808a94c 44716», «despues origen: a7407ed6a70160cdb96021f83808a94c»; `git status --porcelain`: `D  …gobCL_Heavy.otf`, `D  …gobCL_Light.otf`, `?? …gobCL_Bold.otf`
- Contrato: `$TMPDIR/s35c_contratos/comun.md` y `f1.md` (con la excepción de poder correr `00_build.R`, por ser la única tarea de su ola, y la advertencia sobre `document.fonts.load('… gobCL')` de la reparación R-50 en la vista).
- Cambios sustantivos (+58/−44 en 4 archivos, más las fuentes):
  - `10_utils/10_html.R`: `FUENTES_GOBCL` = `gobCL_Regular.otf` 400 `0257bb4b…` y `gobCL_Bold.otf` 700 `a7407ed6…`; `FORMATO_FONT_FACE` con `font-family: "gobCL-sitio"`; comentarios de cabecera, de la tipografía y de `insertar_sitio()`. La lógica de `css_fuentes_gobcl()` e `insertar_sitio()` (detención por md5) no cambia.
  - `33_fragmento_sitio.html`: comentarios (dos `@font-face`, familia `gobCL-sitio`, 800 y 900 en Bold).
  - `33_motor_template.html`: `--font-display` y `--font-body` = `"gobCL-sitio", system-ui, …` (sale `"gobCL"`); `const FONT_SVG = "gobCL-sitio, system-ui, sans-serif"`; comentarios. `FONT_SIGNO` y `.hint-signo` sin cambio; los dos comentarios R-47 («gobCL dibuja «†» igual que «+»») se conservan porque nombran la tipografía y siguen siendo ciertos.
  - `36_trayectorias_template.html`: `--font-display` y `--font-body` = `"gobCL-sitio",system-ui,…`; `document.fonts.load('400 1em gobCL-sitio')` y `('700 1em gobCL-sitio')` en el recálculo de R-50; comentarios.
- Verificación:

Rutas y diff (orquestador: `git status --porcelain`, `git diff --stat`, `grep -n gobCL` en los cuatro archivos)
esperado: solo rutas del ALCANCE de F1; ninguna referencia de código a la familia `"gobCL"`
obtenido: `M` `10_html.R`, fragmento y las dos plantillas; `D` Light y Heavy (orquestador); `??` Bold y el log; +58/−44. Todas las apariciones de «gobCL» que no son `gobCL-sitio` son prosa de comentario (nombre de la tipografía o de los archivos `gobCL_*.otf`)

PRUEBAS (orquestador, árbol de F1): `Rscript 00_build.R`, batería, I-5 e I-2
esperado: codigo_build=0; 31/31 y C3 PASA; «JSON idéntico a la línea base»; 0 0 en los cuatro HTML
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor d0bee5968332eb4a1cb65eacc646f588, vista d979559dbba49a3de43041ce1bad9739 (iguales a los del subagente), parquet comunal 468099a9c63bb3c0ddb74e67e2c7c19f; codigo_bateria=0, «Resultado: 31 pruebas, 31 pasan, 0 fallan», C3 PASA (12724 filas, idénticas TRUE, control plantado TRUE); «JSON idéntico a la línea base»; I-2 0 0 en `40_salidas/motor_comparacion.html`, `40_salidas/trayectorias_traspasos.html`, `docs/index.html` y `docs/trayectorias.html`

Criterio de carga (i) y (iii) (orquestador, `$TMPDIR/cal_s35c/orq_f1.R`, a 1280 px, en la vista, `#comparacion` y `#panorama`; caso malo = copias sin `@font-face` del subagente en `$TMPDIR/s35c_f1/malo/`, con 0 reglas `font-family: "gobCL-sitio"`)
esperado: (i) exactamente 400 y 700; (iii) diferencia de más de 1 px; en el caso malo, (i) ninguna cara y (iii) a lo más 1 px
obtenido: después: «caras gobCL-sitio cargadas: 400,700 | todas: gobCL-sitio:400:loaded gobCL-sitio:700:loaded | dif literal -17.04 | dif con respaldo -17.04» en las tres; caso malo: «caras …: (ninguna) | todas: | dif literal -26.2 | dif con respaldo 0» en las tres. **(i) discrimina. (iii) en la forma literal del encargo (`700 32px "gobCL-sitio"` contra `700 32px system-ui`) se cumple pero no discrimina**: sin la cara, el canvas cae en la fuente por omisión del navegador y la diferencia es −26,2 px. En la forma con respaldo (`700 32px "gobCL-sitio", system-ui`), que es la «diferencia de ancho medida contra el respaldo del sistema» de D35-9, discrimina: −17,04 frente a 0.

Criterio (ii) (retorno del subagente, `$TMPDIR/s35c_f1/fuentes.R`: `DOM.getDocument`, `DOM.querySelector`, `CSS.enable`, `CSS.getPlatformFontsForNode`)
esperado: `isCustomFont` verdadero y familia gobCL en el título, el menú, una cifra de barras y una de la sparkline (motor) y en el título, el menú y un texto del gráfico (vista); en el caso malo, fuentes del sistema
obtenido: título «gobCL/gobCL custom=TRUE + gobCL/gobCL-Bold custom=TRUE»; menú «gobCL/gobCL-Bold custom=TRUE»; barras «gobCL/gobCL custom=TRUE»; sparkline «gobCL/gobCL-Bold custom=TRUE glifos=3 + .SF NS/.SFNS-Bold custom=FALSE glifos=1» (la «†» en su `tspan` del sistema); vista, gráfico «gobCL/gobCL custom=TRUE»; panorama «gobCL/gobCL custom=TRUE»; caso malo: todo «.SF NS/… custom=FALSE»; base: «gobCL/gobCL-Heavy custom=TRUE» en título y menú

«†» en la Bold (retorno del subagente: máscaras de «†» y «+» en canvas; `$TMPDIR/cal_s35b/orq_r47.R` sobre el motor)
esperado: IoU ~1 con `gobCL-sitio` (la marca debe seguir en la familia del sistema); las 43 marcas en `tspan` con la familia del sistema e IoU ~0,18
obtenido: `gobCL-sitio` 700 IoU 1.000 y 400 IoU 1.000; system-ui 700 0.183; «textos con †: 43 | con tspan propio: 43», «IoU †/+ con la fuente de la marca: min 0.183 max 0.192», calibración con la fuente del `<text>` «min 1 max 1»

Calibración del md5 de `insertar_sitio()` (retorno del subagente: copia del repo sin `.git` en `$TMPDIR/s35c_f1/repo_calib/`, build bueno y build con 1 byte alterado en la copia de `gobCL_Bold.otf`)
esperado: bueno código 0; malo distinto de 0 con un mensaje que nombre el archivo; fuentes del repo intactas
obtenido: codigo_bueno=0 (motor d0bee596…, vista d979559d…, iguales al repo); codigo_malo=1, «md5 inesperado en la fuente gobCL_Bold.otf: 228840c833e8aafb1646f9e481329e92 (se esperaba a7407ed6a70160cdb96021f83808a94c)»; fuentes del repo a7407ed6… y 0257bb4b…

base64 incrustado (retorno del subagente, `b64.R`, calibrado con un salto plantado y un carácter cambiado)
esperado: 2 reglas por página, 0 saltos, md5 decodificado igual al `.otf`
obtenido: «reglas: 2»; 400: 48.704 caracteres, 0 saltos, md5 0257bb4b…; 700: 59.624 caracteres, 0 saltos, md5 a7407ed6…; malo: «saltos 1» y md5 sin coincidencia

Criterio de tamaño (orquestador: `wc -c`)
esperado: diferencia negativa por página
obtenido: motor 2.954.547 → 2.904.127 (−50.420 B); vista 2.252.447 → 2.201.983 (−50.464 B)

`scrollWidth` a 375, 540, 640, 680, 768 y 1280 px (orquestador, `orq_f1.R`, carga nueva por ancho, barras ocultas)
esperado: igual al viewport en las 18 mediciones
obtenido: vista, `#comparacion` y `#panorama`: 375/540/640/680/768/1280 en las tres; «iguales al viewport: 18 de 18 | red total 0 | errores total 0». El subagente midió lo mismo (18 de 18, dos veces). Calibración del subagente (copia con `body{min-width:900px}`): 900 a 375 y 768, «iguales al viewport: 0 de 2»

Carrera de carga de fuente de la vista, R-50 (retorno del subagente, `carrera.R`, 20 cargas nuevas a 768 px; `carga_familia.R`)
esperado: un solo estado, `--tabs-h` igual al alto del menú; `document.fonts.load('… gobCL-sitio')` resuelve las dos caras
obtenido: «101px | 317px | 101 | 400,700» ×20, «estados distintos: 1 | --tabs-h igual al menú: 20 de 20»; calibración con `--tabs-h` +4 px: «igual al menú: 0 de 3»; `load()` con `gobCL-sitio` resuelve 400 y 700 y con `gobCL` ninguna (en la base, al revés). La regresión realista (`load()` con la familia vieja) no se manifestó en 30 cargas: el chequeo directo del nombre la suple.

- Alcance: `git show --name-status 41de233` = `M 10_utils/10_html.R`, `A 10_utils/fuentes/gobCL_Bold.otf`, `D 10_utils/fuentes/gobCL_Heavy.otf`, `D 10_utils/fuentes/gobCL_Light.otf`, `M` fragmento y las dos plantillas. Dentro del ALCANCE. `40_salidas/*.html` están ignorados (`.gitignore` L13-14).
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de F1; devolvió «completa»; verificado arriba (rutas, PRUEBAS, (i), (iii), anchos). Cuenta Opus acumulada: 1.
- Bugs: ninguno en el producto.
- Decisiones autónomas:
  - D-F1-a (del subagente, aceptada por el orquestador; riesgo medio): el criterio (iii) se registra en las dos formas; la forma literal se cumple pero no pasa la calibración del encargo («(iii) debe fallar sobre la copia sin `@font-face`»), así que la que funda el criterio es la forma con respaldo `"gobCL-sitio", system-ui`, que realiza lo que D35-9 describe. No cambia el valor esperado (> 1 px) ni la meta. Mismo patrón que Q-32 con `document.fonts.check()`.
  - D-F1-b (orquestador; riesgo bajo): `gobCL_Bold.otf` quedó en el índice con modo `100755`, porque el `cp` conservó los permisos del origen (`-rwxrwxrwx` en `~/Library/Fonts`). Es el único archivo ejecutable del repositorio. No se corrigió: `chmod` no está en la lista cerrada de autorizaciones, y el modo no cambia el md5 ni el uso. Queda como duda Q-40.
  - Del subagente, aceptadas: comentarios R-47 conservados; `FONT_SVG` sin comillas internas (identificador CSS válido); el error de consola «Unsafe attempt to load URL file://…» se trató como artefacto del instrumento (solo aparece al activar los dominios DOM/CSS de CDP, igual en base y caso malo; 38 cargas sin esos dominios dan 0 errores y 0 red).
- Consecuencias medidas (información): con la Bold (700 real) en vez de la Heavy (900), `--cardw` de la vista a 768 px pasa de 318 a 317 px, en un solo estado (20 de 20). El PNG exportado del motor ya no puede usar una gobCL instalada en el equipo (la familia `gobCL-sitio` no existe fuera de la página): cae siempre al respaldo del sistema (agrava Q-31, excluido de este encargo; ADVIERTE).
- Errores propios (del subagente): el selector `#panorama svg text` no existía en su primera versión del criterio (ii) (corregido a `svg.panorama-svg text`); una calibración del base64 que no alteró nada (el carácter ya era «A»), rehecha; un código de salida tomado tras un `tail`, re-medido; un comentario mal cortado, corregido antes del build.
- Dudas:
  - Q-40. `10_utils/fuentes/gobCL_Bold.otf` está versionada con modo 100755 (D-F1-b). ¿Se pasa a 100644 en un encargo posterior (`chmod 644` y commit)? (sí / no)
  - Q-41. ¿Se reemplaza en los encargos siguientes la forma literal de (iii) por la forma con respaldo (`"gobCL-sitio", system-ui`), que es la que discrimina? (sí / no)

### FASE S1: regla C de las cifras de la sparkline (D35-8) (ola 2, escritor Opus)

- Estado: completa.
- Commits: `674522d` fix(motor): cifras de la sparkline ordenadas por valor, con ocultamiento de respaldo (D35-8, R-48).
- Contrato: `$TMPDIR/s35c_contratos/comun.md` y `s1.md` (corrida en paralelo con V1, sin `00_build.R`). El orquestador corrigió el contrato antes de lanzarlo: la calibración 627/893 va sobre la base del punto de retorno, no sobre la posterior a F1.
- Cambios sustantivos (+240/−33 en `33_motor_template.html`):
  - bloque `SPARK_DIMS` (W 320, H 90, márgenes; cifra: `sobrePunto` 6, `holgura` 0,5, `orden` 0,05, `borde` 0,5; `anios.linea` 13; `traspaso.linea` −2; `asterisco` dx 0,5 y dy −1);
  - función `colocarCifrasSparkline()` con la regla C comentada en cuatro pasos: (1) posición inicial `cy − sobrePunto` (sin la cota `Math.max(8, ·)`) y corrimiento horizontal de la cifra que saldría por un lado; (2) techo (borde del SVG y, si la cifra toca el rótulo «traspaso», su borde inferior: la cifra baja) y piso (banda de años); (3) orden por valor: si dos cajas se tocan, la mayor queda entera sobre la menor; primero sube la mayor, lo que el techo no le deja subir lo baja la menor sin tocar la banda de años; consecutivas visibles con redondeo distinto también en orden de línea base y de centro; pares de igual cifra redondeada prueban los dos sentidos (≤ 2^8) y queda la disposición de menor desplazamiento; (4) validación con las cajas dibujadas: ante inversión, superposición o salida del SVG oculta la cifra del año más antiguo del par (o la cifra sola que sale o toca un rótulo), con `display="none"` y `data-oculta`, y reordena;
  - se retira la regla de choque de M2/R-51; el «*» preliminar pasa a la derecha de la caja de su cifra y cuenta como obstáculo;
  - `makeTooltip`: con `n_estab === 1`, el valor Adecuado lleva «†» y el aviso empieza con «†», ambos en un `span` con `FONT_SIGNO`;
  - `construirSvgGraficos` toma `SPARK_W`/`SPARK_H` de `SPARK_DIMS` (mismos valores).
- Verificación:

Barrido amplio con el medidor extendido del subagente (`$TMPDIR/s35c_s1/barrido.R`, `medir_spark.js`, `resumen.R`), calibrado antes de tocar código
esperado: base del punto de retorno 627 (auditor), 893 (`inv_todas`), 0 superposiciones, 1 fuera por arriba; `1a92827` 0 inversiones; después de S1: 0 inversiones (auditor, estricta, `inv_todas`), 0 superposiciones de las cuatro clases, 0 fuera por arriba y por abajo, ≤ 5 por los lados
obtenido (tabla del subagente; 2.832 sparklines y 16.406 cifras en todas las columnas):

| métrica | base del punto de retorno | base de la ola (post-F1) | después de S1 | `1a92827` (caso bueno) |
|---|---|---|---|---|
| inversiones, auditor | 627 | 637 | 0 | 0 |
| inversiones, estricta | 1.079 | 1.093 | 0 | 0 |
| `inv_todas` | 893 | 913 | 0 | 0 |
| cifra-cifra / cifra-«traspaso» / cifra-año / cifra-«*» | 0 / 0 / 0 / 0 | 0 / 0 / 0 / 0 | 0 / 0 / 0 / 0 | 3 / 7 / 0 / 0 |
| cifra-«*» con preliminar forzado | 1.987 | 1.987 | 0 | — |
| fuera izquierda / derecha | 535 / 831 | 535 / 831 | 0 / 0 | 206 / 383 |
| fuera arriba / abajo | 1 / 0 | 1 / 0 | 0 / 0 | 0 / 0 |
| subidas / bajadas (máx.) | 1.479 / 0 (31) | 1.498 / 0 (36,9) | 2.451 / 52 (38,4 / 20,4) | 0 / 0 |
| ocultas | 0 | 0 | 0 | 0 |

Calibración sintética del medidor (subagente, `calib_sintetico.R`: una sparkline con una respuesta conocida por clase)
esperado: 1 por clase (cc, ct, ca, c*, fuera por cada lado), 1 oculta, auditor 1, estricta 2, `inv_todas` 2
obtenido: «cifras 9, visibles 8, ocultas 1 (2016 45%), cc 1, ct 1, ca 1, cs 1, fuera 1/1/1/1, auditor 1, inv_todas 2, estricta 2»

Re-derivación del orquestador con el medidor original de H8 (sin las extensiones del subagente): `Rscript $TMPDIR/cal_s35b/r48/amplio2.R 40_salidas/motor_comparacion.html $TMPDIR/cal_s35c/amplio_s1.rds`, y lo mismo sobre la base posterior a F1; resumen con `resumir.R` y `fuera_desglose.R`
esperado: después de S1, 0 inversiones (auditor y `inv_todas`), 0 fuera por arriba y 0 cifras de la sparkline fuera por los lados; base post-F1 igual a la del subagente
obtenido: «postf1 | … | solapes 342 | fuera arriba 1 abajo 0 lados 7079 | subidas 1498 | … | invertidas (auditor) 637 | invertidas (todas) 913 | subida máx 36.9»; «s1 | … | solapes 342 | fuera arriba 0 abajo 0 lados 5713 | subidas 2580 | bajadas 51 | invertidas (auditor) 0 | invertidas (todas) 0 | subida máx 38.4»; desglose de lados en s1: 5.664 de barras, 49 rótulos «traspaso», **0 cifras de la sparkline**. (Subidas 2.580 frente a 2.451 del subagente: el medidor original compara con `max(8, cy−6)` y el del subagente, con `cy−6`.)

Superposiciones fuera de la sparkline (orquestador, `$TMPDIR/cal_s35c/solapes_desglose.R`)
esperado: 0, como en la base del punto de retorno
obtenido: base 0; **post-F1 342 y después de S1 342, todas en `bars-svg:apilado`** (cifras rescatadas del tipo «A 3,9%†» con «E 11,8%†», área 34-42 px², 285 tarjetas). Las introduce F1, no S1: **hallazgo H-F1-1 para FASE R**. Estado por defecto del motor (orquestador, `$TMPDIR/cal_s35c/orq_barras.R`, 1280 y 375 px, simple y apilado): 0 pares en la base y en el estado actual.

Tarjeta 5103, grupo Medio bajo (subagente, `casos_pagina.R`, estado por defecto)
esperado: «52%†» sobre «42%†», o la de 2014-2018 oculta
obtenido: «52%† aba 28.48 <= 42%† arr 28.9 : TRUE | centro 52%† 22.98, centro 42%† 34.4»

Casos de borde (subagente, `casos_borde.R`, capturas en `$TMPDIR/s35c_s1/final_*.png`)
esperado: cifras dentro del SVG y 0 pares superpuestos en SLEP 1305 (R-53), un Servicio Local traspasado con «traspaso», una serie bajo 30 % con «†» contiguas y una racha monótona 2014-2018 con «†»
obtenido: los cuatro «cifras dentro del SVG: TRUE | pares cifra-cifra superpuestos: 0»; R-53: «71%†» arriba en 28,5 (bajo «traspaso»); racha monótona 52/47/43/35/28 en escalera, bajo máximo 67,5 < banda 74

Cifras ocultas y tooltip (subagente)
esperado: número y lista de ocultas; cada oculta con su valor (y «†» si corresponde) en el tooltip, 3 casos con chromote
obtenido: el barrido real deja **0 ocultas** (`ocultas_final.csv` sin filas). Para verificar el mecanismo se forzaron 3 ocultas en una pestaña de prueba (series parcheadas en el navegador, sin tocar el repo): comunas 5103, 5105 y 5107, Medio, 4° Básico Matemática, 2014; tooltips por hover CDP: «95,0%» sin «†» (3 establecimientos), «95,0%†» con la marca en `system-ui…` y «† Baja representatividad — un solo establecimiento», y lo mismo más «* Dato preliminar 2014». Tooltip real de 5103 Medio bajo 2024: «51,6%†» con aviso; 2014: «19,8%» sin aviso. SVG exportado con ocultas forzadas: 3 `data-oculta` con `display="none"`, 0 dibujadas (calibración sin `display`: 3 dibujadas).

Carrera de carga de fuente (subagente, `carrera_fuente.R`)
esperado: la disposición de la carga inicial igual a la de un re-render con la fuente cargada
obtenido: «cifras carga inicial: 83 | tras re-render: 83 | idénticas (texto, x, y): TRUE»; calibración (otra prueba) «idénticas FALSE»

PRUEBAS e invariantes (orquestador, estado con S1 y V1): `Rscript 00_build.R`, batería, I-5, I-8
esperado: codigo_build=0; 32/32; «JSON idéntico a la línea base»; I-8 vacío
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor 25ad353ad2d454fd62bae9df09e81938 (igual al del subagente), vista 20f3214de0973c403390a8d7aa84c271, parquet 468099a9c63bb3c0ddb74e67e2c7c19f; «Resultado: 32 pruebas, 32 pasan, 0 fallan»; «JSON idéntico a la línea base»; I-8 vacío. Consola y red 0 a 1280 y 375 px (subagente).

- Alcance: antes del commit, `git status --porcelain` = `M` motor (S1), `M` plantilla y batería de la vista (V1) y el log; `git show --name-only 674522d` = `30_procesamiento/33_motor_template.html`. Dentro del ALCANCE.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de S1; devolvió «completa»; verificado arriba con el medidor original (distinto del suyo), el build, I-5 e I-8. Cuenta Opus acumulada: 3 (S1 y V1).
- Bugs: ninguno propio de S1.
- Decisiones autónomas (del subagente, aceptadas por el orquestador):
  - D-S1-a (riesgo medio): las 1.366 salidas laterales se resuelven corriendo la `x` de la cifra (con su «*») lo justo para quedar dentro del `viewBox` (`SPARK_DIMS.cifra.borde`), sin ocultar ninguna.
  - D-S1-b (riesgo medio): posición inicial literal `cy − 6`, sin la cota `Math.max(8, ·)`: cambia la posición inicial de 242 de 16.406 cifras (valores sobre 65 %); el techo del SVG y el del rótulo cubren lo que la cota protegía.
  - D-S1-c (riesgo bajo): el orden se exige también entre consecutivas visibles que no se tocan (a través del gap y del corte de traspaso), en línea base y en centro, para que las métricas den 0 por construcción.
  - D-S1-d (riesgo bajo): pares de igual cifra redondeada prueban los dos sentidos y queda la disposición de menor desplazamiento (sin eso, rachas de «10%†» se apilaban en escalera).
  - D-S1-e (riesgo bajo): el «*» preliminar pasa de `cx + 7` a la derecha de la caja de su cifra (en `cx + 7` pisaba su propia cifra: 1.987 casos con preliminar forzado).
  - D-S1-f (riesgo bajo): la «†» del tooltip usa `style.fontFamily = FONT_SIGNO` y no la clase `.hint-signo`, de ancho fijo de 14 px.
  - Las 3 ocultas del criterio se forzaron en una pestaña de prueba porque el barrido real no deja ninguna.
- Errores propios (del subagente): un diseño de ocultas forzadas que no ocultó en 5103 (rediseñado con un «*» forzado); un error de sintaxis JS en su script de casos (instrumento); un `grep` de `const` que Babel transpila a `var`; un código de salida tomado de `grep` y no de `Rscript` (repetido).
- Dudas:
  - Q-42 (Q-S1-3). Con la regla C, las rachas monótonas de cifras con «†» se apilan en escalera: 164 cifras suben 20 unidades o más (máx. 38,4) y la menor puede quedar sobre su punto. ¿(A) se acepta, porque cumple D35-8 con 0 ocultas, o (B) se prefiere bajar primero la menor?
  - Q-43 (Q-S1-4, previa). A 375 px las sparklines de `#comparacion` miden 43 px de ancho (supergrid de 4 columnas de 64,75 px; ya registrado como Q-34). ¿Se registra junto con Q-34? (sí / no)
  - Q-S1-1 y Q-S1-2 (superposiciones de barras desde F1 y 3 con preliminar forzado) pasan a FASE R como H-F1-1.

### FASE V1: vista, tooltip del referente y plano entre 680 y 800 px (Q-26, Q-33) (ola 2, escritor Opus)

- Estado: completa.
- Commits: `28caa7f` fix(trayectorias): tooltip del referente desde los datos (Q-26); `86319b6` fix(trayectorias): el plano no colapsa entre 680 y 800 px (Q-33).
- Contrato: `$TMPDIR/s35c_contratos/comun.md` y `v1.md` (en paralelo con S1, sin `00_build.R`). Pidió devolver cada paso por separado (`$TMPDIR/s35c_v1/paso1_plantilla.patch`, `paso1_verificar.patch`, `paso2_plantilla.patch` y la copia `$TMPDIR/s35c_v1/paso1/`).
- Cambios sustantivos:
  - Paso 1 (`36_trayectorias_template.html` y `36_verificar_trayectorias.R`, 985 → 1063 líneas): `rangoOlas(porOla)`, compartida por `rotuloReferente()` (su salida no cambia) y por la nueva `descripcionReferente()`, que arma desde `META.REF` y `ANIOS` el texto «<cat> municipales en <ancla> que no figuran en el catálogo de Servicios Locales: <vig> <rango> y <cat−vig> cerraron antes de su traspaso. Conjunto fijo; la marca no usa la escala de tamaño» (singular con 1 cerrado; omite la cláusula con 0). La batería gana **R7**: abre la vista, provoca el tooltip del referente con un `mousemove` sobre la marca `[data-ref]` visible y exige que las cifras del texto sean exactamente las de `DATA` (ancla, `cat`, `vig`, olas mínima y máxima, cerrados), con control plantado.
  - Paso 2 (`36_trayectorias_template.html`, +20): `@media (min-width:680px) and (max-width:822px)` al final de la hoja, con cuatro reglas bajo `.app:not(.pres)`: `height:auto`, `.main` en una columna, `.card{width:var(--cardw,300px);max-width:100%}` y `svg.chart{flex:none;height:360px}`. El modo presentación y los anchos fuera del tramo no cambian.
  - `36_funciones_trayectorias.R` sin cambio (md5 d552023e694f1d4fc616bfc5bb1663a9).
- Verificación:

Tooltip del referente (subagente: cursor real CDP en `tip.R` y R7 de la batería)
esperado: el texto trae las cifras de `DATA`, sin números literales en la plantilla
obtenido: antes «Municipales en 2014 que no están en los 36 Servicios Locales del catálogo: los traspasan las olas siguientes. Conjunto fijo; la marca no usa la escala de tamaño»; después «1.299 municipales en 2014 que no figuran en el catálogo de Servicios Locales: 1.282 se traspasan entre 2027 y 2029 y 17 cerraron antes de su traspaso. Conjunto fijo; la marca no usa la escala de tamaño»; literales con dígitos en `descripcionReferente()`: ninguno

Calibración de R7 (subagente, batería sobre la vista base)
esperado: R7 FALLA con el texto anterior; las otras 31 PASA
obtenido: «R7 FALLA … cifras del texto 36/2014 …», «Resultado: 32 pruebas, 31 pasan, 1 fallan», codigo=1

Alto de `svg.chart` a 680, 700, 720, 760, 800 y 822 px, ventana de 900 px (subagente, `medir.R`, cohorte inicial y 2027; orquestador, `$TMPDIR/cal_s35c/orq_v1.R`, cohorte inicial, más 1024 y 1280)
esperado: base con menos de 30 px en al menos un ancho (calibración); después 320 px o más en los seis, `scrollWidth` igual al viewport, 1024 y 1280 sin cambio
obtenido: subagente: base, cohorte 2027 0/0/0/29,6/117,3/166,3 y cohorte inicial 117,3/117,3/132,3/132,3/149,8/183,8; después 360 en los 12 casos, `scrollWidth` igual al viewport en los 24. Orquestador: base post-F1 117,3/117,3/132,3/132,3/149,8/183,8 y 248,8 a 1024 y 426,9 a 1280; después 360,0 en los seis, 248,8 a 1024 y 426,9 a 1280; `scrollWidth` igual al viewport en los ocho anchos; `--cardw` 317px; errores 0 y red 0

0 píxeles distintos a 1024, 1280 y 1920 px frente a la base de la tarea (subagente, `capturas.R` y `comparar.R`, página completa)
esperado: 0 en cada ancho; determinismo de la base 0; calibración con `--line-motor` #E7DFC8 más de 0
obtenido: base_a contra final 0/0/0 (y 0 a 679 y 823 px, fuera del tramo); base_b contra final 0/0/0; determinismo 0/0/0; calibración 14.422, 18.983 y 24.471

Modo presentación y cambio de ancho (subagente, `pres.R` y `extra.R`)
esperado: modo presentación idéntico a la base; al pasar a 1024 px, `--cardw` 317 y plano como la base
obtenido: «pres: identico a la base» (el intento 1 descartado sí difería: 455,6×176 contra 558,3×289 a 680 px); a 1024 px, base y final «cardw=317px, chart=248.8, chartw=585»

Estado intermedio del paso 1 (orquestador: la plantilla del paso 1, md5 85a4be61e8e7463f978044cc094b252e, copiada al árbol; `36_generar_trayectorias.R`; batería)
esperado: 32/32 con solo el paso 1
obtenido: vista 9d7e5a6f16f2cf6a926cca965503da3a (igual a la del subagente); «Resultado: 32 pruebas, 32 pasan, 0 fallan», codigo=0; luego commit del paso 1 y restitución de la plantilla final (md5 5541ea112ce036c7294b4e3b76f7f951) para el commit del paso 2

Carrera de fuente R-50 (subagente, `extra.R`, 10 cargas a 768 px)
esperado: un solo estado
obtenido: 10 «101px | 317px | 101»; calibración con `anchoTarjeta` perturbada: 6 y 4 en dos estados

PRUEBAS (orquestador): las de FASE S1 (build 0, 32/32, C3 y R7 PASA, I-5 idéntico). Validador de portabilidad (subagente): «Fallas criticas: 0 | Advertencias: 7».

- Alcance: `git show --name-only 28caa7f` = plantilla y batería de la vista; `git show --stat 86319b6` = plantilla (+20). Dentro del ALCANCE.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de V1; devolvió «completa»; verificado arriba (rutas, batería en los dos estados, alto del plano con instrumento propio). Cuenta Opus acumulada: 3.
- Bugs: 1 (intento 1 del paso 2: la tarjeta a todo el ancho heredaba `--cardw` 430 en el modo presentación y al pasar sobre 822 px), resuelto en el intento 2; parche del intento descartado en `$TMPDIR/s35c_v1/intento1_descartado.patch`.
- Decisiones autónomas (del subagente, aceptadas): la frase «que no están en los 36 Servicios Locales del catálogo» pasa a «que no figuran en el catálogo de Servicios Locales» (el 36 salía de `__NOTA_N_VIGENTES__`, fijado al generar, y el contrato pedía cifras de `DATA`); `rangoOlas()` compartida; tramo `680-822` con límites enteros; variante A2 (tarjeta con `--cardw`, plano de 360 px) y reglas bajo `.app:not(.pres)`; la calibración del plano se cumple con la cohorte 2027 (con la inicial, la base nunca baja de 30 px: el «0 a 30 px» describe el peor caso).
- Errores propios (del subagente): dos variantes CSS de prueba armadas con `python3` en `$TMPDIR` (no entregables); el parche del intento descartado se guardó después de descartarlo, reconstruyendo su plantilla, y no antes (regla 7 del contrato); dos códigos de salida engañosos tras tuberías.
- Dudas:
  - Q-44 (Q-V1-1). Con ventana de 900 px de alto, entre 823 y 1023 px el plano sigue bajo 320 px en la base y en la final (183,8 a 823 px; 248,8 de 860 a 1024). ¿Se extiende la media query hasta 1023 px en un encargo posterior? (sí / no)
  - Q-45 (Q-V1-2). El comentario de `30_procesamiento/36_generar_trayectorias.R` (~L120-121) dice que `N_VIGENTES` aparece «en las notas y en el tooltip del referente»; tras el paso 1 ya no aparece en el tooltip. El archivo está fuera de todo ALCANCE de este encargo. ¿Se corrige en un encargo posterior? (sí / no)
  - Q-46 (Q-V1-3, previa). Con las cohortes 2027 a 2029, la tabla se desplaza en horizontal dentro de sí desde 680 px (497/428) y oculta la columna «Establecimientos»; y la pista tiene 7 pares de años superpuestos a 680 px. ¿Se registran como pendientes? (sí / no)
  - Q-47 (Q-V1-4). Las notas metodológicas (L357 de la plantilla) dicen «que en 2014 eran municipales», con el año en la plantilla (mismo patrón de Q-26). ¿Pendiente? (sí / no)

### FASE F2: desborde y referencias después de la fuente final (D35-10) (ola 3, escritor Opus)

- Estado: **completa sin cambios**. El criterio de desborde ya se cumplía en el estado final de S1 y V1; no hay commit (el encargo lo prevé: «si no hubo cambios, se declara y no se commitea»).
- Commits: ninguno. Plantillas sin diff frente a `86319b6` (motor bf9963902e023f1c4289c37295f56199, vista 5541ea112ce036c7294b4e3b76f7f951); salidas sin regenerar (25ad353a…, 20f3214d…).
- Contrato: `$TMPDIR/s35c_contratos/comun.md` y `f2.md`. `_archivo/20260925_capturas_s35c/` la creó el orquestador antes de la ola (autorización 6); `git check-ignore -v` = `.gitignore:31:_archivo/`.
- Verificación:

`scrollWidth` a 375, 540, 640, 641, 665, 680 y 768 px en la vista, `#comparacion` y `#panorama` (subagente, `$TMPDIR/s35c_f2/medir_sw.R`, carga nueva por ancho, barras ocultas, caras 400 y 700 cargadas, dos lecturas separadas por 3 s; orquestador, `$TMPDIR/cal_s35c/orq_f1.R` con esos anchos)
esperado: 21 de 21 iguales al viewport
obtenido: subagente «iguales al viewport: 21 de 21 | red total 0 | errores total 0»; orquestador: las tres vistas 375/540/640/641/665/680/768, «iguales al viewport: 21 de 21 | red total 0 | errores total 0»

Calibración del medidor de desborde (subagente: copias con un `div` de `calc(100vw + 1px)`)
esperado: ancho + 1 en las 9 mediciones
obtenido: 376/666/769 en las tres vistas, «iguales al viewport: 0 de 9»

0 píxeles distintos entre tres cargas nuevas a 768, 1024, 1280 y 1920 px, tres vistas (subagente, `capturas.R`, página completa, 12 s de espera en `#comparacion`)
esperado: 0 en cada comparación de la carga 2 y la 3 contra la 1 (24)
obtenido: 24 de 24 en 0, más las 12 de la carga 3 contra la 2 (36 en 0); el mismo estado de diseño en las tres cargas (vista a 768: `--tabs-h` 101px, `--cardw` 317px, menú 101; desde 1024: 51px, 317px, 51)

Calibración de la comparación de píxeles (subagente: copia byte a byte y copia con `--line`/`--line-motor` #E7DFC9 → #E7DFC8)
esperado: copia sin alterar 0 en 12 casos; copia con color más de 0 en 12
obtenido: 0 en los 12; con color, vista 13.233/14.422/18.983/24.471, `#comparacion` 22.558/29.169/35.859/44.864, `#panorama` 6.326/5.118/6.210/7.894

Re-derivación del orquestador (`$TMPDIR/cal_s35c/orq_f2_px.R`: carga propia, captura y `pixeles_distintos()` contra la referencia de F2)
esperado: 0 píxeles distintos
obtenido: `ref_trayectorias_1024.png` 0; `ref_comparacion_1280.png` 0 (segundo intento: el primero agotó el tiempo de `Runtime.evaluate` con una espera de 12 s dentro de JS; error del instrumento, corregido con `Sys.sleep`); `ref_panorama_768.png` 0

Capturas (subagente; `ls -la` del orquestador)
esperado: 12 de referencia (768, 1024, 1280 y 1920 px × tres vistas) y 6 de revisión (375 y 1280 px) en `_archivo/20260925_capturas_s35c/`
obtenido: 18 PNG: `ref_{trayectorias,comparacion,panorama}_{768,1024,1280,1920}.png` y `rev_{trayectorias,comparacion,panorama}_{375,1280}.png` (p. ej., `ref_comparacion_1280.png` 1280×3601, `rev_comparacion_375.png` 375×4338); cada `rev_*_1280` es igual píxel a píxel a su `ref_*_1280`

I-5 y batería (subagente)
esperado: «JSON idéntico a la línea base»; 32/32
obtenido: codigo_I5=0 e «idéntico»; «Resultado: 32 pruebas, 32 pasan, 0 fallan», C3 y R7 PASA

- Alcance: `git status --porcelain` tras la ola = solo el log; las capturas están en `_archivo/` (ignorada).
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de F2; devolvió «completa» sin corrección; verificado arriba. Cuenta Opus acumulada: 4.
- Bugs: ninguno.
- Decisiones autónomas (del subagente, aceptadas): sin edición ni build (nada que regenerar); se reportan 36 comparaciones (24 pedidas más las 12 de la carga 3 contra la 2; el «36» del contrato del orquestador contaba mal: error propio del orquestador); 12 s de espera en `#comparacion` en todos los anchos; `ref_*` y `rev_*` son la carga 1 de corridas con al menos una gemela en 0.
- Errores propios (del subagente): una sustitución `perl` con ancla `^` que no alteraba nada (detectada por el `diff` vacío, rehecha); un código de salida tomado de `tail`.
- Dudas: la del subagente sobre `--cardw` 318 → 317 px se registra como información (consecuencia de D35-9, ya anotada en FASE F1).

### FASE R: auditoría y reparación

**R.1 Inventario de afirmaciones auditables** (derivado de las secciones anteriores del log; anexado antes de auditar). Estado auditado: `HEAD` = `86319b6`; punto de retorno `d1b6a43`. Auditor 1: S1 y el hallazgo H-F1-1. Auditor 2: F1, V1 y F2. Auditor 3: FASE 0, T0, N1, D1, I-1 a I-11 y alcance.

| id | afirmación (fuente en el log) | auditor |
|---|---|---|
| R-01 | T0 (`d1b6a43`) agrega exactamente la decisión, el log de errores y el encargo (md5 del encargo acea9ddb…; de las otras dos, f31780f8… y 15e6fbb6…); su padre es `5e65bd3` (H3, H4, T0) | 3 |
| R-02 | Antes del encargo, `origin/main` = `9d612a3`, con 14 commits sin publicar, y es ancestro de `HEAD` (H3) | 3 |
| R-03 | H7: la única `gobCL_Bold.otf` de las tres ubicaciones está en `~/Library/Fonts`, md5 a7407ed6…, `usWeightClass` 700, `fsType` 4; la versionada es idéntica | 3 |
| R-04 | H8: el medidor de s35b da 627 (auditor), 893 (`inv_todas`), 0 solapes y 1 fuera por arriba sobre la base; en la sparkline, 1.366 cifras con «†» salen por los lados | 1 |
| R-05 | N1: NOTICE tiene una sola línea con `TIPOGRAF`, 6 apariciones de «gobCL», el copyright de la tabla `name` de la Regular y de la Bold transcrito literal, la exclusión de los activos tipográficos de las «plantillas HTML/JS/CSS», y dice que Apache 2.0 no cubre gobCL, con D35-7 | 3 |
| R-06 | D1: `glob2rx()` convierte `*` en `.*`, así que `20_insumos/auxiliares/*.csv` alcanza `directorio_oficial_ee.csv` y las entradas alcanzan subcarpetas; el documento lo dice; sus citas de `.gitignore` (líneas 44 y 10) coinciden con `grep -n`; el primer bloque cercado sigue siendo el de «Entradas», sin cambio | 3 |
| R-07 | F1: el índice tiene solo `gobCL_Regular.otf` (0257bb4b…) y `gobCL_Bold.otf` (a7407ed6…); `FUENTES_GOBCL` y la `@font-face` usan la familia `gobCL-sitio`; cada HTML trae 2 reglas cuyo base64 decodifica al `.otf` exacto | 2 |
| R-08 | F1: en la vista, `#comparacion` y `#panorama` quedan cargadas exactamente las caras `gobCL-sitio` 400 y 700; sin la `@font-face`, ninguna | 2 |
| R-09 | F1: `measureText('Establecimiento 42%')` difiere −17,04 px entre `700 32px "gobCL-sitio", system-ui` y `700 32px system-ui` (0 sin la cara); la forma literal sin respaldo no discrimina (−26,2 px sin la cara) | 2 |
| R-10 | F1: `CSS.getPlatformFontsForNode` da fuente web (`isCustomFont`) gobCL en título, menú, barras y sparkline del motor y en título, menú y gráfico de la vista | 2 |
| R-11 | F1: `insertar_sitio()` detiene el build con un `.otf` alterado (copia del repo), nombrando el archivo | 2 |
| R-12 | F1: cada HTML pesa menos que en la base (motor −50.420 B, vista −50.464 B) | 2 |
| R-13 | F1: no queda código que pida la familia `"gobCL"` (CSS, `FONT_SVG`, `document.fonts.load`); la vista pide `gobCL-sitio` en `load()` y su recálculo de R-50 deja un solo estado (`--tabs-h` igual al alto del menú) | 2 |
| R-14 | F1: en `gobCL-sitio` 700 la «†» se dibuja igual que «+» (IoU ~1); las 43 marcas del estado por defecto van en `tspan` con la familia del sistema (IoU ~0,18) | 2 |
| R-15 | F1: `scrollWidth` igual al viewport a 375, 540, 640, 680, 768 y 1280 px en las tres vistas | 2 |
| R-16 | S1: barrido amplio (2.832 sparklines) con 0 inversiones (auditor, estricta y `inv_todas`), 0 superposiciones cifra-cifra, cifra-«traspaso», cifra-año y cifra-«*», 0 cifras fuera del SVG por ningún lado y 0 ocultas | 1 |
| R-17 | S1: en la tarjeta 5103, grupo Medio bajo, «52%†» queda sobre «42%†» | 1 |
| R-18 | S1: casos de borde dentro del SVG y sin superposición: SLEP 1305 (R-53), un Servicio Local traspasado con «traspaso», una serie bajo 30 % con «†» contiguas y una racha monótona 2014-2018 con «†» | 1 |
| R-19 | S1: el tooltip de un punto con un solo establecimiento muestra el valor con «†» y el aviso con «†», en la familia del sistema; una cifra oculta queda oculta en el SVG exportado | 1 |
| R-20 | S1: las distancias de la regla C están en `SPARK_DIMS`, sin literales en `colocarCifrasSparkline()` ni en el dibujo de cifras, años, «traspaso» y «*» | 1 |
| R-21 | S1: la disposición de la carga inicial es igual a la de un re-render con la fuente cargada (sin carrera de fuente) | 1 |
| R-22 | H-F1-1: desde F1, el barrido de barras apiladas tiene 342 pares de cajas de texto superpuestas (cifras rescatadas «A …%†» con «E …%†»; 0 antes de F1), porque la caja de la cifra rescatada crece de 10 a 11 u (12 a 13 con «†») con la Bold; el estado por defecto tiene 0 | 1 |
| R-23 | V1: el tooltip del referente dice «1.299 municipales en 2014 … 1.282 se traspasan entre 2027 y 2029 y 17 cerraron antes de su traspaso…», con cifras de `DATA` y sin números literales en la plantilla | 2 |
| R-24 | V1: R7 falla con el texto anterior y pasa con el nuevo | 2 |
| R-25 | V1: `svg.chart` mide 360 px a 680, 700, 720, 760, 800 y 822 px (antes 117-184 con la cohorte inicial y 0-166 con la 2027); `scrollWidth` igual al viewport | 2 |
| R-26 | V1: 0 píxeles distintos a 1024, 1280 y 1920 px frente a la vista posterior a F1; el modo presentación no cambia | 2 |
| R-27 | F2: `scrollWidth` igual al viewport a 375, 540, 640, 641, 665, 680 y 768 px en las tres vistas | 2 |
| R-28 | F2: 0 píxeles distintos entre tres cargas a 768, 1024, 1280 y 1920 px en las tres vistas; las 18 capturas existen en `_archivo/20260925_capturas_s35c/` | 2 |
| R-29 | I-1 `docs/` intacto | 3 |
| R-30 | I-2 sin cargas por red | 3 |
| R-31 | I-3 vendorizados `.js` sin cambio | 3 |
| R-32 | I-4 guarda de locale | 3 |
| R-33 | I-5 JSON del motor idéntico a la línea base | 1 |
| R-34 | I-6 (C3) filas vigentes y del referente sin cambio | 3 |
| R-35 | I-7 absoluto vacío | 3 |
| R-36 | I-8 sin literales nuevos en `fill` | 3 |
| R-37 | I-9 mockup congelado | 3 |
| R-38 | I-10 un `__SITIO_HTML__` por plantilla | 3 |
| R-39 | I-11 28 archivos de datos versionados | 3 |
| R-40 | Alcance global: `git diff --name-only d1b6a43..HEAD` dentro de la unión de los ALCANCE, más el log; cada commit dentro del ALCANCE de su tarea | orquestador y 3 |
| R-41 | Regresión: build 0, batería 32/32, I-5 idéntico en el estado final | orquestador |

**R.2 Re-derivación independiente.** Panel de 3 lectores Opus 5.5 (esfuerzo xhigh) en una sola ola (workflow `s35c-fase-r`), con contrato común `$TMPDIR/s35c_contratos/auditor_comun.md` y repartos `r1.md`, `r2.md`, `r3.md`: cada uno recibió las afirmaciones, las rutas de las fuentes y el repositorio, sin el log, sin los contratos ni los scripts de las tareas y sin los `verificar_*.R`, con la orden de no construir en el árbol (los builds se hicieron en copias del repo en `$TMPDIR/s35c_r1/repo`, `s35c_r2/repo` y `s35c_r3/repo`, y reprodujeron los md5 del árbol). Scripts propios en `$TMPDIR/s35c_r1/`, `s35c_r2/` y `s35c_r3/`; el auditor 1 escribió su propio medidor de la sparkline (`medidor_r1.js`, con cajas llevadas al `viewBox` por la inversa de `getScreenCTM`) y lo corrió sobre una muestra reproducible de 300 sparklines y sobre las 2.832. Resultado: auditor 1, 9 de 9 CONFIRMADA (R-04, R-16 a R-22, R-33); auditor 2, 15 de 15 CONFIRMADA (R-07 a R-15, R-23 a R-28) y una sonda de superposiciones sin hallazgos (0 pares nuevos en 27 combinaciones de barras simples, apiladas y panorama); auditor 3, 16 CONFIRMADA (R-01 a R-03, R-05, R-06, R-29 a R-32, R-34 a R-40) y R-33 NO VERIFICABLE por contrato (la re-derivó el auditor 1). Cuenta Opus acumulada: **7** (tope 8).

**R.3 Invariantes 🔒** (orquestador, estado final `7273760`, tras el build de la regresión; `<punto_de_retorno>` = `d1b6a43`)

I-1 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47
obtenido: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47 → **PASA** (auditor 3: blobs de `d1b6a43`, `HEAD` y árbol idénticos)

I-2 `grep -c 'src="http'` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html`
esperado: 0 en cada archivo
obtenido: motor 0 0, vista 0 0, `docs/index.html` 0 0, `docs/trayectorias.html` 0 0 → **PASA** (auditor 3: también 0 con un patrón amplio de comillas simples, sin esquema, `<link href>`, `@import` y `<script src>`; ver R-42)

I-3 `git diff --name-only d1b6a43..HEAD -- '10_utils/*.js'`
esperado: vacío
obtenido: vacío → **PASA**

I-4 `md5 -q 10_utils/10_locale.R` y `grep -n asegurar_locale_utf8 10_utils/10_configuracion.R`
esperado: dc900c1b… y una línea
obtenido: dc900c1b0d2d252c9e5730875be5d632 y `16:asegurar_locale_utf8("10_configuracion")` → **PASA**

I-5 `Rscript verificar_contenido_motor.R` (motor `ebf7f46b309837a9ad140e978907b055`)
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base» → **PASA** (auditor 1, decodificador propio en Python: sha256 del JSON sin fecha igual en base, post-F1 y final)

I-6 prueba C3
esperado: PASA
obtenido: «C3 PASA … (12724 filas de 37 unidades; idénticas: TRUE; control plantado detectado: TRUE)» → **PASA** (auditor 3: 12.724/12.724 filas idénticas y DATA completo idéntico a la vista base)

I-7 `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`
esperado: vacío
obtenido: vacío → **PASA** (auditor 3, AST: 55 llamadas de agrupamiento, 0 hallazgos; control con 2 plantados: 2)

I-8 `git diff d1b6a43..HEAD -- 30_procesamiento/33_motor_template.html | grep -E '^\+.*attr\("fill", *"#' | grep -vE '#FFFFFF|#0A3A5C'`
esperado: vacío
obtenido: vacío → **PASA**

I-9 `git diff --name-only d1b6a43..HEAD -- 50_documentacion/andamios/mockup_trayectoria_traspasos.html`
esperado: vacío
obtenido: vacío → **PASA**

I-10 `grep -c '__SITIO_HTML__'` en las dos plantillas
esperado: 1 y 1
obtenido: 1 y 1 → **PASA**

I-11 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 → **PASA**

**R.4 Alcance global** (orquestador: `git diff --name-only d1b6a43..HEAD` con `$TMPDIR/cal_s35c/orq_alcance.R`, rutas por commit con `git show --name-only`, y `git status --porcelain`, estado final)
esperado: 0 rutas fuera de la unión de los ALCANCE, más el log; cada commit dentro del ALCANCE de su tarea; el árbol solo con el log sin commitear
obtenido: «rutas: 10 | fuera: (ninguna)»; por commit: `d900bb1` NOTICE (N1); `276a447` documento de datos (D1); `41de233` `10_html.R`, las tres fuentes, el fragmento y las dos plantillas (F1); `674522d` motor (S1); `28caa7f` plantilla y batería de la vista (V1); `86319b6` plantilla de la vista (V1); `7273760` motor (reparación R-22 de F1, dentro del ALCANCE de F1); `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260925_pendientes_s35c_log.md`. Auditor 3 (`r40_alcance.py`, matcher propio): «fuera: []» global y en los 7 commits. **PASA.**

**R.5 Regresión completa** (estado final `7273760`)
esperado: `Rscript 00_build.R` codigo 0; batería 32/32 codigo 0; «JSON idéntico a la línea base»
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor ebf7f46b309837a9ad140e978907b055, vista 20f3214de0973c403390a8d7aa84c271, parquet comunal 468099a9c63bb3c0ddb74e67e2c7c19f; «Resultado: 32 pruebas, 32 pasan, 0 fallan», codigo_bateria=0; «JSON idéntico a la línea base» → **PASA**

**R.6 Control positivo de la propia auditoría.**
- Cifra alterada (orquestador): copia del motor final fuera del árbol con el primer decimal del JSON de 3.5 a 3.6 (`alterar_json_motor.R`); `Rscript verificar_contenido_motor.R <copia>` → «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)», codigo_alterado=1; el motor real da «idéntico». **Dispara.** Auditores: una fila del DATA de la vista de 9.8 a 9.9 hace fallar la re-derivación de I-6 (auditor 3); `datos.anio[0]` 2014 → 2015 hace fallar la de I-5 (auditor 1); el `vig` del referente a 1.283 cambia el tooltip a «1.283 … 16 cerraron» (auditor 2).
- Archivo fuera de alcance (orquestador): `orq_alcance.R` sobre una lista simulada de 7 rutas (`NOTICE`, `docs/index.html`, `10_utils/10_locale.R`, `30_procesamiento/33_generar_html.R`, `40_salidas/intermedios/simce_rbd.parquet`, `10_utils/d3.v7.min.js`, `_archivo/otra/x.png`) → «fuera: docs/index.html, 10_utils/10_locale.R, 30_procesamiento/33_generar_html.R, 40_salidas/intermedios/simce_rbd.parquet, 10_utils/d3.v7.min.js, _archivo/otra/x.png» (acepta solo `NOTICE`). **Dispara.** Auditor 3: su verificador marcó 6 rutas inventadas y, por tarea, `README.md` en N1.
- Además, cada instrumento de los auditores disparó en su caso malo (medidor de la sparkline con 9 casos sintéticos; copias del motor sin la regla C y con holgura negativa: 167 SVG con falla y 212 ocultas; copias sin `@font-face`; `usWeightClass` alterado; un carácter del base64; un bloque de 3×3 px invertido; un `div` de 2.000 px).

**R.7 Veredicto por hallazgo.**
- BLOQUEA: ninguno.
- REPARA: **R-22** (H-F1-1, confirmado por el auditor 1 con su propio medidor: base 0, post-F1 342, final 342, de ellos 338 A†-E† y 4 E†-I†; alto de caja de la rescatada 10 → 11 u y 12 → 13 u con «†»; estado por defecto 0). Defecto del propio trabajo (F1), dentro del ALCANCE de F1 (plantilla del motor), sin tocar un 🔒, con verificación calibrada (base 0 contra post-F1 342).
- ADVIERTE: R-42 a R-52 (tabla R.10). No se reparan.

**R.8 Ciclo de reparación 1** (orquestador en serie; no queda cupo para un subagente de escritura sin arriesgar el tope de 8).

R-22. (a) Causa raíz: las cifras rescatadas bajo el eje de las barras apiladas van en renglones a paso fijo de 12 unidades (`ih + 28 + k * 12`). Con `gobCL-sitio` (la Bold declara `hhea` 750/−250 y `win` 1017/399; la Heavy, 780/−220 con `lineGap` 75), la caja de una cifra rescatada de 10 px y peso 700 mide 11 u (10 con la Heavy) y 13 u con la «†» del sistema (12 con la Heavy): dos renglones se tocan en 1 u (`$TMPDIR/cal_s35c/alto_caja.R`: base «sin marca 10.00 | con marca 12.00»; post-F1 «sin marca 11.00 | con marca 13.00»; `$TMPDIR/cal_s35c/metricas_otf.R` para las métricas). (b) Fix quirúrgico: `RECENT_DIMS.rescate = { linea: 28, paso: 14 }`, con comentario, y el renglón `k` en `ih + RECENT_DIMS.rescate.linea + k * RECENT_DIMS.rescate.paso`. Con dos renglones como máximo, el segundo queda con su caja en `ih + 32` a `ih + 45`, dentro del margen inferior de 48 y sobre la nota. Intento guardado como parche: `$TMPDIR/cal_s35c/r22/r22_intento1.patch`, md5 334dfcd056d7fcb95b33c17f67671379 (copia previa de la plantilla en `$TMPDIR/cal_s35c/r22/motor_template_antes.html`, md5 bf9963902e023f1c4289c37295f56199). (c) Mismo chequeo (barrido de H8, `amplio2.R`, y `solapes_desglose.R`):
esperado: 0 superposiciones en el barrido; la sparkline sin cambio (0 inversiones, 0 fuera)
obtenido: «r22 | sparklines 2832 | barras 5664 | solapes 0 | fuera arriba 0 abajo 0 lados 5713 | subidas 2580 | bajadas 51 | invertidas (auditor) 0 | invertidas (todas) 0 | subida máx 38.4»; «r22 : 0 solapes»; «cifras de sparkline fuera: 0» (antes de la reparación, «solapes 342»)
Chequeo distinto (medidor independiente del auditor 1, `$TMPDIR/s35c_r1/r1_r22_detalle.R`, barrido completo de barras apiladas y estado por defecto con el conmutador apagado y encendido en cuatro combinaciones nivel × prueba):
esperado: 0 pares en el barrido y en el estado por defecto
obtenido: «defecto, conmutador apagado: {"n_svg":14,"pares":0,"resc":0}», «encendido: {"n_svg":14,"pares":0,"resc":3}», 2° Medio Lectura 0 (24 rescatadas), 2° Medio Matemática 0 (26), 4° Básico Matemática 0 (21); «barrido amplio, pares por tipo: {}»
(d) Regresión: la de R.5 (build 0, 32/32, I-5 idéntico, I-8 vacío). Además, las 8 referencias del motor de F2 frente a cargas nuevas del estado final (`orq_f2_px.R`, `#comparacion` y `#panorama` a 768, 1024, 1280 y 1920 px):
esperado: 0 píxeles distintos (la reparación no toca el estado por defecto)
obtenido: 0 en las 8
(e) Commit: `7273760` fix(auditoria): R-22 las cifras rescatadas de las barras apiladas no se tocan con gobCL-sitio. (f) Fila R-22 de la tabla.

Pasos 2 a 5 sobre lo tocado: re-derivación con dos instrumentos (arriba), invariantes (R.3), alcance (R.4) y regresión (R.5), todos sobre `7273760`. La reparación no destapó otro defecto: no hubo ciclo 2.

**R.9 Prohibiciones.** Ningún criterio, tolerancia, valor esperado ni ALCANCE se ajustó; ningún 🔒 se tocó; la evidencia escrita no se editó (el desbalance de una línea de «obtenido» en FASE S1 se declara en FASE L, sin corregirlo); la reparación del auditor no se aceptó sin re-verificarla (no la hubo: la hizo el orquestador).

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | T0 con las 3 rutas, md5 y padre | A3: `diff-tree --name-status`, `cat-file blob` + `openssl`, `rev-list --parents` | 3 rutas; md5; 5e65bd3 | iguales (2 M y 1 A) | ADVIERTE (R-44, redacción) | registrar | — | — |
| R-02 | `origin/main` 9d612a3, 14 sin publicar, ancestro | A3: `rev-list --count`, `merge-base`, reflog | 14; 0 | 14; 0; 21 hasta `HEAD` | — | ninguna | — | — |
| R-03 | Bold única en `~/Library/Fonts`, 700, fsType 4 | A3: `find`, Python `struct` sobre `OS/2` | iguales | iguales; `cmp` idénticos | — | ninguna | — | — |
| R-04 | H8: base con inversiones y 1.366 laterales | A1: medidor propio, muestra 300 y 2.832 | > 0 | 1.119 inversiones; 1.366 laterales, 1 arriba, 0 solapes | — | ninguna | — | — |
| R-05 | NOTICE: TIPOGRAF, 6 gobCL, copyright literal, exclusión, D35-7 | A3: `verificar_notice.py` (lee nameID 0 y 7) | cumple | cumple; `d900bb1` solo NOTICE | ADVIERTE (R-43) | registrar | — | — |
| R-06 | D1: `glob2rx` y citas de `.gitignore` | A3: R `glob2rx`, bloque cercado contra `d1b6a43` | cumple | cumple; el I8 real usa `grepl(glob2rx(...))` | — | ninguna | — | — |
| R-07 | índice con Regular y Bold; 2 `@font-face` exactas | A2: `ls-files -s`, Python sobre las reglas | cumple | cumple; Bold 100755 | ADVIERTE (R-51) | registrar | — | — |
| R-08 | caras 400 y 700 cargadas; ninguna sin `@font-face` | A2: chromote | ["400","700"]; [] | iguales | — | ninguna | — | — |
| R-09 | −17,04 px con respaldo; literal no discrimina | A2: canvas | −17,04 / 0; −26,2 | −17,0359 / 0; −26,2031 | — | ninguna | — | — |
| R-10 | fuente web gobCL en 7 nodos | A2: CDP `getPlatformFontsForNode` | custom TRUE | custom TRUE; «†» en .SF NS | — | ninguna | — | — |
| R-11 | `.otf` alterado detiene el build | A2: copia del repo, XOR de un byte | codigo ≠ 0 | codigo=1, nombra `gobCL_Bold.otf` | — | ninguna | — | — |
| R-12 | −50.420 y −50.464 B | A2: `wc -c`, bases reconstruidas | iguales | iguales | — | ninguna | — | — |
| R-13 | sin familia `"gobCL"` en código; R-50 un estado | A2: `git grep`, 6 cargas, `fonts.load` por familia | cumple | cumple | ADVIERTE (R-52) | registrar | — | — |
| R-14 | «†» = «+» en la Bold; 43 marcas en `tspan` del sistema | A2: IoU propio, recorrido de nodos, `cmap` | ~1; 43 | 1; 43; sin cara 0,246 | — | ninguna | — | — |
| R-15 | 18 anchos iguales al viewport (F1) | A2: medición propia | 18/18 | 18/18 | — | ninguna | — | — |
| R-16 | barrido S1: 0 en todas las clases | A1: medidor propio, 300 y 2.832, y a 349/269/205/141 px | 0 | 0 en todo; 0 ocultas | ADVIERTE (R-46, R-47, R-48) | registrar | — | — |
| R-17 | 5103 Medio bajo: «52%†» sobre «42%†» | A1: `r1_r17_version.R` | sobre | centro 27,33 sobre 40,92 (base al revés) | — | ninguna | — | — |
| R-18 | 4 casos de borde | A1: búsqueda propia de casos | 0 fallas | 0 fallas (353 traspasados, 927 bajo 30 %, 11 rachas) | — | ninguna | — | — |
| R-19 | tooltip con «†» del sistema; oculta oculta al exportar | A1: hover, CDP, 79 ocultas forzadas | cumple | cumple | — | ninguna | — | — |
| R-20 | distancias en `SPARK_DIMS` | A1: `r20_literales.py` sobre `674522d` | sin literales | sin literales (control en `41de233`: 6 literales) | — | ninguna | — | — |
| R-21 | disposición inicial igual al re-render | A1: 9 cargas con CPU ×1 a ×20 | iguales | iguales; contrafactual sin fuente: distintas | ADVIERTE (R-46) | registrar | — | — |
| R-22 | H-F1-1: 342 pares en barras apiladas desde F1 | A1: medidor propio, 2.456 barras | base 0, post-F1 > 0 | 0 / 342 / 342 (338 A†-E†, 4 E†-I†); defecto 0 | **REPARA** | `RECENT_DIMS.rescate`, paso 14 | 7273760 | barrido 342 → 0; medidor del A1 0; referencias de F2 0 px |
| R-23 | tooltip del referente desde `DATA` | A2: CDP con cursor real, `META` propio | igual | igual; copia con `vig` 1.283 cambia | — | ninguna | — | — |
| R-24 | R7 falla con el texto viejo | A2: batería en copias | FALLA / PASA | 31/32 / 32/32 | — | ninguna | — | — |
| R-25 | plano de 360 px entre 680 y 822 | A2: `r25_plano.R`, dos cohortes | 360 | 360 en los 12 casos | ADVIERTE (R-49) | registrar | — | — |
| R-26 | 0 px a 1024+ y presentación igual | A2: capturas post-F1 y final | 0 | 0 (y 0 en presentación a 6 anchos) | — | ninguna | — | — |
| R-27 | 21 anchos iguales (F2) | A2: medición propia, 24 | igual | 24/24 | — | ninguna | — | — |
| R-28 | 0 px entre cargas; 18 capturas | A2: tres sesiones nuevas y md5 | 0; 18 | 0; 18; `ref_*` = carga nueva | — | ninguna | — | — |
| R-29 a R-32 | I-1 a I-4 | A3: blobs, `hash-object`, `openssl` | PASA | PASA | ADVIERTE (R-42 en I-2) | registrar | — | — |
| R-33 | I-5 | A1: decodificador Python y sha256 | idéntico | idéntico | — | ninguna | — | — |
| R-34 a R-39 | I-6 a I-11 | A3: DATA propio, AST, `ls-tree` | PASA | PASA | — | ninguna | — | — |
| R-40 | alcance global y por commit | A3: `r40_alcance.py` | 0 fuera | 0 fuera | ADVIERTE (R-45) | registrar | — | orquestador tras R-22: 0 fuera en 7 commits |
| R-41 | regresión | orquestador | 0; 32/32; idéntico | iguales (R.5) | — | ninguna | — | — |
| R-42 | el comando de I-2 no ve `src='http…'` ni `src=//…` | A3: `i2_red.py` con un plantado | — | el grep del encargo da 0 con el plantado; el patrón amplio da 0 en las 4 salidas reales | ADVIERTE | registrar (punto ciego del criterio) | — | — |
| R-43 | NOTICE (`d900bb1`) nombra la Bold dos commits antes de que entre (`41de233`) | A3 | — | así en la historia; el estado final es coherente | ADVIERTE | registrar (orden del grafo, D-N1-a) | — | — |
| R-44 | R-01 dice «agrega» y T0 modifica 2 rutas y agrega 1 | A3 | — | matiz de redacción | ADVIERTE | registrar | — | — |
| R-45 | el build de PRUEBAS reescribe `40_salidas/intermedios/*.parquet` (ignorados) | A3 | — | bytes idénticos a un build limpio | ADVIERTE | registrar | — | — |
| R-46 | la regla C depende de que `gobCL-sitio` cargue antes del primer dibujo; el motor no recoloca las cifras al cargar la fuente | A1: carreras con CPU ×20 y contrafactual sin fuente | — | Chrome gana siempre aquí; contrafactual: 23 inversiones y 164 cifra-cifra | ADVIERTE | registrar (riesgo no medible aquí: Safari, equipos lentos) | — | — |
| R-47 | el cero exacto vale a la escala del dibujo: un cambio de ancho sin re-render deja diferencias bajo 1 u | A1: dibujar y medir a anchos distintos | — | ≤ 0,09 u en inversiones, ≤ 1,87 u² en solapes | ADVIERTE | registrar (cosmético) | — | — |
| R-48 | la regla C deja más cifras sobre la línea de la serie (1.142 frente a 662) y menos sobre su punto (45 frente a 130) | A1: sonda | — | informativo | ADVIERTE | registrar | — | — |
| R-49 | el plano colapsa sobre 822 px en ventanas bajas (650 px de alto: 0 px a 823-1024) | A2 | — | previo a V1; fuera del criterio de Q-33 | ADVIERTE | registrar (= Q-44 ampliada) | — | — |
| R-50 | el SVG y el PNG exportados piden `gobCL-sitio`, que fuera de la página no existe: salen siempre en la fuente del sistema | A2: `sonda_export.R` | — | 371 atributos, 0 `@font-face`; 0 px frente a system-ui | ADVIERTE | registrar (Q-31, excluido) | — | — |
| R-51 | `gobCL_Bold.otf` versionada con modo 100755 | A2: `ls-tree`, `show --summary` | — | 100755 | ADVIERTE | registrar (D-F1-b, Q-40) | — | — |
| R-52 | la prueba de un solo estado en cargas repetidas no distingue la familia de `load()` en Chrome headless | A2: copia con `load('… gobCL')` | — | 6/6 iguales también con la familia vieja; `fonts.load` por familia sí discrimina | ADVIERTE | registrar (método) | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA; 1 REPARA (R-22, defecto de F1) corregido y re-verificado con dos instrumentos en el ciclo 1; 11 ADVIERTE (R-42 a R-52), ninguno sobre datos ni invariantes; 40 afirmaciones del inventario CONFIRMADA (R-33 por el auditor 1) y 0 REFUTADA; controles positivos del orquestador y de los tres auditores dispararon.

## Cierre

### 1. Resumen

Se aplicaron D35-7 (NOTICE declara gobCL fuera de Apache 2.0), D35-9 (familia `gobCL-sitio` con Regular 400 y Bold 700; salen Light y Heavy) y D35-8 (regla C de las cifras de la sparkline: 0 inversiones, 0 superposiciones, 0 cifras fuera del SVG y 0 ocultas en las 2.832 sparklines del barrido, frente a 627/893 inversiones y 1.366 salidas laterales de la base); se corrigieron el tooltip del referente (desde `DATA`, con la prueba R7), el plano de la vista entre 680 y 822 px (360 px) y el documento de datos autorizados (alcance real de `glob2rx()` y líneas de `.gitignore`). F2 confirmó, sin editar, que no hay desborde con la fuente final y regeneró las 12 referencias y 6 capturas de revisión (D35-10). FASE R confirmó las 40 afirmaciones auditadas, encontró un defecto de F1 (R-22: cifras rescatadas de las barras apiladas que se tocaban con la Bold), lo reparó y registró 11 advertencias. Veredicto: APROBADO CON ADVERTENCIAS.

### 2. Inventario de commits (`git log --oneline d1b6a43^..HEAD`)

```text
d1b6a43 docs(sesion 35): decisiones D35-7 a D35-10, errores ERR-35-12 a ERR-35-15 y encargo de la tercera ola
d900bb1 docs(licencia): NOTICE declara la tipografia gobCL fuera de Apache 2.0 (D35-7)
276a447 docs(gobernanza): datos autorizados precisa el alcance de sus globs (Q-36)
41de233 feat(sitio): gobCL-sitio con Regular 400 y Bold 700; retira Light y Heavy (D35-9)
674522d fix(motor): cifras de la sparkline ordenadas por valor, con ocultamiento de respaldo (D35-8, R-48)
28caa7f fix(trayectorias): tooltip del referente desde los datos (Q-26)
86319b6 fix(trayectorias): el plano no colapsa entre 680 y 800 px (Q-33)
7273760 fix(auditoria): R-22 las cifras rescatadas de las barras apiladas no se tocan con gobCL-sitio
```

Más el commit de este log (`docs(log): pendientes de la sesion 35, tercera ola`), cuyo hash va en el reporte final. F2 no tiene commit (sin cambios).

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-52).

### 4. Invariantes

I-1 a I-11 en PASA en el estado final `7273760` (FASE R, R.3), con I-7 en forma absoluta. En ningún cierre de fase un 🔒 dio FALLA.

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 del encargo (acea9ddba6db107ea7e80d8c675ed6e6, verificado).
- Ninguna otra decisión del titular durante la sesión (modo autónomo). Las decisiones D35-7 a D35-10 son anteriores y están en T0.

### 6. Estado de cifras (todas medidas en esta sesión con Rscript o chromote)

- Fuentes: `10_utils/fuentes/` = `gobCL_Regular.otf` (0257bb4b…, 400) y `gobCL_Bold.otf` (a7407ed6…, 700, 44.716 B, modo 100755); caras cargadas `gobCL-sitio` 400 y 700 en la vista, `#comparacion` y `#panorama`; `measureText` con respaldo −17,04 px (0 sin la cara).
- Peso de los HTML: motor 2.954.547 → 2.904.127 B tras F1 (−50.420) y 2.916.809 B tras S1; vista 2.252.447 → 2.201.983 B tras F1 (−50.464) y 2.204.520 B tras V1. Motor final tras R-22: ebf7f46b309837a9ad140e978907b055.
- Barrido de la sparkline (2.832 sparklines, 16.406 cifras): base del punto de retorno 627 inversiones (auditor), 893 (`inv_todas`), 1.079 (estricta), 0 solapes, 1 fuera por arriba, 1.366 por los lados; post-F1 637/913/1.093; final 0/0/0, 0 solapes de las cuatro clases, 0 fuera por ningún lado, 0 ocultas; subidas 2.580 (medidor de H8) y bajadas 51, subida máxima 38,4 u.
- Barras apiladas del barrido: 0 pares en la base, 342 tras F1, 0 tras R-22.
- Vista: tooltip del referente «1.299 municipales en 2014 … 1.282 se traspasan entre 2027 y 2029 y 17 cerraron antes de su traspaso…»; `svg.chart` 360 px de 680 a 822 px (antes 117,3-183,8 con la cohorte inicial y 0-166,3 con la 2027); `--cardw` 317 px (318 antes de F1); batería 31 → 32 (R7).
- `scrollWidth` igual al viewport: 18/18 (F1: 375, 540, 640, 680, 768 y 1280 px) y 21/21 (F2: 375, 540, 640, 641, 665, 680 y 768 px), en las tres vistas.
- Estado final de `40_salidas/`: motor ebf7f46b309837a9ad140e978907b055; vista 20f3214de0973c403390a8d7aa84c271; `simce_comunal.parquet` 468099a9c63bb3c0ddb74e67e2c7c19f (sin cambio en toda la sesión). JSON del motor idéntico a la línea base. `docs/` sin cambio (8deb0459…/267857a2…).

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno.

Dudas, cada una con pregunta cerrada:
- Q-40. `gobCL_Bold.otf` está versionada con modo 100755 (D-F1-b, R-51). ¿Se pasa a 100644 en un encargo posterior? (sí / no)
- Q-41. ¿Se reemplaza en los encargos siguientes la forma literal del criterio (iii) de F1 por la forma con respaldo (`"gobCL-sitio", system-ui`), que es la que discrimina (D-F1-a)? (sí / no)
- Q-42. Con la regla C, las rachas monótonas con «†» se apilan en escalera (164 cifras suben 20 u o más). ¿(A) se acepta, o (B) se prefiere bajar primero la menor? (A / B)
- Q-43. A 375 px las sparklines de `#comparacion` miden 43 px de ancho (supergrid de 4 columnas). ¿Se registra junto con Q-34? (sí / no)
- Q-44. El plano de la vista sigue bajo 320 px entre 823 y 1023 px con ventana de 900 px de alto, y colapsa a 0 px de 823 a 1024 px con 650 px de alto (R-49; previo). ¿Se extiende la corrección en un encargo posterior? (sí / no)
- Q-45. El comentario de `30_procesamiento/36_generar_trayectorias.R` (~L120-121) dice que `N_VIGENTES` aparece en el tooltip del referente, y ya no aparece. ¿Se corrige en un encargo posterior? (sí / no)
- Q-46. Con las cohortes 2027 a 2029 la tabla de la vista se desplaza en horizontal dentro de sí desde 680 px y oculta la columna «Establecimientos»; y la pista tiene 7 pares de años superpuestos a 680 px (previos). ¿Pendientes? (sí / no)
- Q-47. Las notas metodológicas dicen «que en 2014 eran municipales», con el año en la plantilla. ¿Pendiente? (sí / no)
- Q-48. La regla C calcula las cajas en el primer dibujo y no recoloca las cifras cuando carga la fuente (R-46): en Chrome la fuente gana siempre; en Safari o en equipos lentos no se pudo medir. ¿Se agrega una recolocación tras la carga de `gobCL-sitio`, como R-50 en la vista? (sí / no)
- Q-49. El comando de I-2 no ve `src='http…'` ni `src=//…` (R-42). ¿Se amplía el patrón en los encargos siguientes? (sí / no)

Pendientes fuera del encargo: publicación a `docs/` y Pages (§11); revisión en Safari; los excluidos de §11 (Museo Sans, Q-21, Q-34, `OP_PREVIO`, Q-29, Q-31, Q-39, v30-5, pendientes 8, 10, 12 y 13 de v34, Q-16); CLAUDE.md (D2, no se creó: la regla global pide crearlo, pero `.gitignore` lo excluye y el ALCANCE es cerrado, como en s35 y s35b).

### 8. Errores propios consolidados

- F1: copié la Bold con `cp`, que conservó los permisos de `~/Library/Fonts` (`-rwxrwxrwx`), y quedó versionada con modo 100755 (D-F1-b, R-51).
- Contrato de S1: puse primero la calibración 627/893 sobre la base posterior a F1; lo corregí antes de lanzarlo (la base correcta es la del punto de retorno).
- Contrato de F2: escribí «36 comparaciones» para «carga 2 y 3 contra la 1», que son 24 (el subagente reportó las 24 más 12).
- Contrato de los auditores: la primera versión les prohibía leer `$TMPDIR/s35c_contratos/`, donde está su propio contrato; lo corregí antes de lanzarlos.
- Inventario de FASE R: R-22 describía los 342 pares como «A …%† con E …%†»; 4 son E†-I† (auditor 1). R-01 decía «agrega» para dos rutas modificadas (R-44).
- `orq_f2_px.R`: una espera de 12 s dentro de `Runtime.evaluate` agotó el tiempo del instrumento en el primer intento; se pasó a `Sys.sleep` (1 reintento).
- Control positivo de FASE R: el primer `echo codigo_alterado=$?` tomó el código de `tail`; lo repetí redirigiendo la salida (codigo_alterado=1).
- FASE S1 del log: la tabla del barrido abre con «obtenido (tabla del subagente…):» y no con «obtenido:», así que el conteo de `^obtenido:` queda una línea bajo el de `^esperado:` (ver punto 10). No se reescribió la sección.
- Ninguno de estos errores tocó el producto.

### 9. Notas para el revisor

- Revisar en Safari, idealmente en un equipo sin gobCL instalada (en esta estación está en `~/Library/Fonts`; desde F1 la familia incrustada se llama `gobCL-sitio` y una gobCL local ya no puede sustituirla):
  - el motor: títulos, menú, tablas y gráficos en gobCL; la sparkline de la tarjeta 5103, grupo Medio bajo (ahora «52%†» sobre «42%†»); rachas monótonas con «†» (escalera, Q-42); el tooltip de un punto con un solo establecimiento («51,6%†» y «† Baja representatividad…»); las barras apiladas con cifras rescatadas (R-22);
  - la vista: el tooltip del referente, el plano a 680-822 px (360 px) y la tabla con la cohorte 2027;
  - R-46: si en Safari una sparkline aparece con cifras superpuestas al cargar, es la carrera de la fuente (Q-48).
- Capturas en `_archivo/20260925_capturas_s35c/`: `ref_{trayectorias,comparacion,panorama}_{768,1024,1280,1920}.png` (referencias de D35-10, iguales al estado final tras R-22) y `rev_{…}_{375,1280}.png` para la revisión.
- NOTICE describe la tipografía como decidió el titular (D35-7); conviene leerlo antes de publicar a `docs/`.
- El SVG y el PNG exportados salen siempre con la fuente del sistema (R-50, ligado a Q-31).

### 10. Estado de cierre

- **Commiteado:** 8 commits del encargo (T0 a R-22) más el de este log, en `main`.
- **Condiciones de publicación medidas antes de este commit** (autorización 4): veredicto de FASE R `APROBADO CON ADVERTENCIAS`; `git -C "$RAIZ" fetch origin` fetch_codigo=0; `origin/main` = `9d612a3`; `git merge-base --is-ancestor origin/main HEAD` ancestro_codigo=0; 22 commits por publicar (14 de s35b y 8 de este encargo); md5 de `docs/index.html` y `docs/trayectorias.html` = 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47 (iguales a H4); `git status --porcelain` = solo este log (queda vacío con su commit). El `git push origin main` se corre después de este commit, con `git status --porcelain`, `fetch` y `merge-base` medidos otra vez; su resultado va en el reporte final.
- **Queda al titular:** la revisión en Safari; las dudas Q-40 a Q-49; la publicación a `docs/` (efecto público, excluida de este encargo).
- **Hash de `docs(log)`:** se informa en el reporte final (`git log -1 --format=%h`).
- Verificación del archivo (FASE L, paso 5), medida antes del commit: ver el reporte final; el conteo de `^esperado:` y `^obtenido:` difiere en 1 por la línea de la tabla de FASE S1 (punto 8), sin ajustarlo.
