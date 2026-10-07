# Log: tooltip y centrado óptico (s35f) (slep_simce_adecuado)

- Meta: que el tooltip del motor quede siempre dentro de la ventana y que el texto de los controles quede centrado ópticamente en las dos páginas, publicado en Pages.
- Fecha: 2026-09-25 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: 476b1e1 (commit de T0)
- Encargo: `50_documentacion/activa/encargos/encargo_tooltip_centrado_s35f.md`, md5 `f63b70885577620991f8d6fdd8244ffd` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`); el harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y lo prevalece: sin subagentes ni Workflow; todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, TT, TB, PUB, FASE R, FASE L con el push, y P3 después del push.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Navegador de medición: Google Chrome 153.0.8010.53 (`chromote::find_chrome()`), headless; `text-box` disponible desde Chrome 133.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: el tooltip del motor queda dentro de la ventana en los bordes derecho e inferior, sin tapar el punto cuando cabe a un lado, y el panel abre en todos los clics (TT, 28/28; barrido 0/240 fuera). El texto de los controles queda centrado ópticamente en las dos páginas: 90/90 medidas dentro de ±2 px de dispositivo (base −6,94 a −2,50; final −1,57 a +1,54), con altos y posiciones iguales a la base y 0 píxeles fuera de los controles (TB). Todo copiado a `docs/` (PUB). El push y lo que sirve Pages van en el reporte final.
- Estado por tarea: FASE 0 completa · T0 completa · TT completa en el intento 2 · TB completa en el intento 2 (D-TB-a a D-TB-e) · PUB completa · FASE R: 0 BLOQUEA, 0 REPARA, 15 ADVIERTE.
- Commits: 476b1e1 (T0, punto de retorno), 6f74d70 (TT), fa89e7c (TB), 2a719b1 (PUB), más docs(log) (hash en el reporte final).
- Auditoría (FASE R): sin subagentes. El orquestador re-derivó las 32 afirmaciones con instrumentos distintos: TT con `offset*` y tres tamaños nuevos; TB con maquetación y tinta aislada a DSF 3; píxeles con otras capturas; I-8 con `scrollX`; datos en Python; `hash-object`; un segundo patrón de red. Resultado: 32 CONFIRMADA, 0 REFUTADA; controles positivos dispararon; R-33 a R-47 ADVIERTE; veredicto APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-8 PASA en el estado final `2a719b1`.
- Cifras críticas: tooltip base 22/28 fuera (1.433 > 1.280), final 0/28 y 42/42 paneles en la re-derivación; centrado base −6,94 a −2,50, final −1,57 a +1,54 (90/90), tinta aislada 80/80, maquetación 0,0000; Δ alto 0; píxeles fuera 0/0/0; `docs/` 601df6d7…/1067908e… → 65f2f59b…/713dfa9d…; JSON sha256 7967dfa07a99ef11 sin cambio; batería 32/32.
- Decisiones autónomas de mayor riesgo: D-TB-c (`--ajuste-optico-select` con el redondeo a píxel del navegador, 0,104 em a 15 px, en vez de 0,0875 em literal); D-TB-b (el script de la vista separa el año de los botones de cohorte, cuyo marcado sale de un generador fuera del ALCANCE); D-TB-a (el texto suelto de los controles flex va en un elemento propio); D-TB-d (holgura de 0,25 em en el nombre del territorio); D-TT-a (sin lado libre, solo rige «dentro»); D0-a (dos bases).
- Desviaciones respecto del encargo: el valor de `--ajuste-optico-select` (D-TB-c); marcado nuevo en las plantillas para aplicar `text-box` al texto (D-TB-a y D-TB-b); el inventario acotado con una regla explícita (D-TB-e); no se creó CLAUDE.md (regla global frente a `.gitignore` y al ALCANCE cerrado).
- Dudas abiertas: Q-54 a Q-60 (cierre, punto 7); prioritarias Q-59 (navegadores sin `text-box`) y Q-60 (botones de Nivel y Prueba en Safari).
- Errores propios: 8, ninguno sobre el producto: tres números de línea citados de memoria en FASE TT y corregidos en el log (R-47), más siete del medidor de TB corregidos antes de registrar resultados.
- Qué debe verificar el revisor por sí mismo: en Safari, los botones de Nivel y Prueba (alto y centrado; R-34), el menú, el selector de territorio, los controles de la vista y el tooltip en los bordes; con un navegador sin `text-box`, el alto del menú y de los botones (R-33); las capturas de `_archivo/20260925_capturas_s35f/`.
- No publicado / queda al usuario: la revisión en Safari; Q-54 a Q-60; la guarda `@supports` (Q-59) no está en `docs/` ni en las plantillas. El push y P3 se informan en el reporte final.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite aunque el harness tenía «ultracode» activo); medición en Chrome 153 headless; sin WebKit ni Firefox en la sesión.

### FASE 0: log, punto de retorno y premisas

Paso 1: log creado antes de H1. Por eso H1 muestra también la línea del propio log.

**H1.** `git -C "$RAIZ" status --porcelain`
esperado: las tres rutas de §2, más el log recién creado
obtenido:
```text
 M 30_procesamiento/33_motor_template.html
 M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_tooltip_centrado_s35f.md
?? 50_documentacion/andamios/logs/20260925_tooltip_centrado_s35f_log.md
```

**H2.** `git -C "$RAIZ" stash list | wc -l`
esperado: 0
obtenido: 0

**H3.** `git -C "$RAIZ" fetch origin` (fetch_codigo=0), luego `git -C "$RAIZ" rev-parse --short HEAD` y `git -C "$RAIZ" rev-parse --short origin/main` en dos comandos
esperado: c1e2047 y c1e2047
obtenido: c1e2047 y c1e2047

**H4.** `md5 -q` de las dos rutas modificadas, del encargo, de `docs/` y de `40_salidas/`; además `git show HEAD:30_procesamiento/33_motor_template.html | md5 -q`, `md5 -q 10_utils/fuentes/*.otf` y el conteo de I-7
esperado: plantilla f84001c908044db86c71147b51fb6988 (en `HEAD`, 1427c375f0adb4612653fc3f94b1ee63); log de errores cc2502541b70fff2c931db5fa9258b16; encargo f63b70885577620991f8d6fdd8244ffd (mensaje de entrega); `docs/` y `40_salidas/` 601df6d7bfdc8bb60f57c5f9fba3db54 (motor) y 1067908ec09ce95dbee692b9696da7fa (vista); fuentes a7407ed6… y 0257bb4b…; 28
obtenido: f84001c908044db86c71147b51fb6988; 1427c375f0adb4612653fc3f94b1ee63; cc2502541b70fff2c931db5fa9258b16; f63b70885577620991f8d6fdd8244ffd; `docs/` 601df6d7bfdc8bb60f57c5f9fba3db54 y 1067908ec09ce95dbee692b9696da7fa; `40_salidas/` 601df6d7bfdc8bb60f57c5f9fba3db54 y 1067908ec09ce95dbee692b9696da7fa; a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc (las dos en 100644); 28

**Línea base (antes de T0).** `git show HEAD:30_procesamiento/33_motor_template.html > $TMPDIR/base_s35f/33_motor_template_HEAD.html` y `cp` de las dos salidas de `40_salidas/` a `$TMPDIR/base_s35f/`
esperado: la plantilla con el md5 de `HEAD` y las dos salidas con el md5 del origen
obtenido: 1427c375f0adb4612653fc3f94b1ee63; motor_comparacion.html 601df6d7bfdc8bb60f57c5f9fba3db54 (2.921.439 B) y trayectorias_traspasos.html 1067908ec09ce95dbee692b9696da7fa (2.206.558 B), iguales en origen y copia. Esta base (sin el cambio del tooltip) es la que TT usa para su calibración.

**T0.** `git add` de las tres rutas de §2 y `git commit -m "fix(motor): el tooltip se ubica dentro de la ventana; encargo s35f y ERR-35-18"`
esperado: un commit con esas tres rutas
obtenido: `476b1e1 fix(motor): el tooltip se ubica dentro de la ventana; encargo s35f y ERR-35-18`; `git show --name-only` = la plantilla del motor, el encargo y el log de errores de la sesión 35; `git status --porcelain` = solo este log. **Punto de retorno: 476b1e1.**

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"` (salida en `$TMPDIR/cal_s35f/h5.txt`)
esperado: 32 pruebas o más en PASA y codigo=0
obtenido: «Resultado: 32 pruebas, 32 pasan, 0 fallan», codigo_bateria=0

**H6.** `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"` (salida en `$TMPDIR/cal_s35f/h6.txt`)
esperado: codigo=0
obtenido: codigo_build=0; «Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 6 segundos»; motor 6825812fc6f9a408f00400c202f2f9af (cambia por el tooltip), vista 1067908ec09ce95dbee692b9696da7fa (sin cambio), `simce_comunal.parquet` 468099a9c63bb3c0ddb74e67e2c7c19f. Las dos salidas se copiaron a `$TMPDIR/base_s35f/h6/` (md5 iguales): es la base de H6, con el tooltip y sin el centrado, contra la que TB compara.

`verificar_contenido_motor.R` apuntaba a `$TMPDIR/base_s35d/`: se apuntó a `$TMPDIR/base_s35f/h6/` (línea 24 y comentarios de las líneas 3 y 12). Calibración (`$TMPDIR/cal_s35f/alterar_json_motor.R`, copia del de s35d, sobre la base de H6)
esperado: «idéntico» sobre el build y sobre la base; «difiere» sobre la copia alterada
obtenido: «fragmento original: 3.5 -> alterado: 3.6»; build codigo_actual=0 «JSON idéntico a la línea base»; base codigo_base=0 «JSON idéntico a la línea base»; copia codigo_alterado=1 «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)»; además, la salida previa a T0 (`$TMPDIR/base_s35f/motor_comparacion.html`) da «JSON idéntico a la línea base» (codigo_preT0=0): el tooltip no tocó los datos.

Comparador de I-4 (`$TMPDIR/cal_s35f/i4_data_vista.R`: extrae `var DATA={…};` de la vista, lo decodifica con `jsonlite::fromJSON(simplifyVector = FALSE)` y compara con `identical()` contra la base de H6)
esperado: TRUE sobre el build y sobre la salida previa a T0; FALSE sobre una copia con un número alterado
obtenido: build «claves anios,meta,nac,datos,nube,comunas | identical: TRUE» (codigo_actual=0); previa a T0 «identical: TRUE»; «fragmento original: 23.9 -> alterado: 23.8» y copia «identical: FALSE» (codigo_alterado=1)

**Compuerta de dudas previa al acto público** (SETTINGS §2.1, gatillo 2). Dudas abiertas antes de publicar, y la tarea que mide cada una:
- ¿el tooltip queda dentro de la ventana en los bordes derecho e inferior, sin cambiar el caso normal? → TT;
- ¿el texto de los controles queda centrado sin cambiar el alto de las cajas ni el resto del dibujo? → TB;
- ¿lo publicado en `docs/` es idéntico a lo construido? → PUB;
- ¿Pages sirve lo publicado? → P3.

**Cierre de FASE 0.**
- Estado: completa. H1 a H6 dan lo esperado.
- Commits: `476b1e1` fix(motor): el tooltip se ubica dentro de la ventana; encargo s35f y ERR-35-18 (T0, punto de retorno).
- Cambios sustantivos: el tooltip del asistente queda commiteado (T0); TT lo verifica. `verificar_contenido_motor.R` (ignorado) apunta a `$TMPDIR/base_s35f/h6/`.
- Alcance: T0 tocó solo las tres rutas de §2.
- Regresión: H5 y H6 son la regresión de partida.
- Subagentes: ninguno (el encargo no los admite).
- Bugs: ninguno.
- Decisiones autónomas: D0-a (riesgo bajo): «la base de H6» se lee como dos bases: la previa a T0 (`$TMPDIR/base_s35f/`, sin el cambio del tooltip, igual a lo publicado) para la calibración de TT, que pide la plantilla «sin el cambio»; y la salida de H6 (`$TMPDIR/base_s35f/h6/`, con el tooltip y sin el centrado) para I-3, I-4 y TB. Los datos son idénticos en las dos (I-3 e I-4 dan TRUE sobre ambas).
- Errores propios: ninguno en esta fase.
- Dudas: ninguna.

### FASE TT: el tooltip queda dentro de la ventana

- Estado: completa, en el segundo de 3 intentos.
- Commits: `476b1e1` (T0, el cambio del asistente) y `6f74d70` fix(motor): ajuste del tooltip tras la medicion (TT).
- Paso 0: `grep -n` del código versionado en `476b1e1`: `TOOLTIP_DIMS = { desplaz: 14, margen: 8 }` (L1962) y `ubicarTooltip(tip, ptX, ptY)` (L1963-1975); `show` y `pin` llenan el tooltip con `populate` y lo ubican después (L2102-2103 y L2127-2128); `.tooltip` en `position: absolute`, 200-280 px (L478-487); el tooltip es un solo `<div id="global-tooltip">` hijo de `<body>` (L1151), así que su bloque contenedor es el inicial.
- Medidor: `$TMPDIR/cal_s35f/tt/tt_medir.R` (chromote, sobre `verificar_navegador.R`). Mueve el ratón con `Input.dispatchMouseEvent` (eventos reales: `mouseenter` de d3 y `offsetX` del navegador) y lee `getBoundingClientRect()` del tooltip; `ptX` y `ptY` se registran con un oyente de captura que repite la cuenta del motor (`svgRect.left + e.offsetX`). Casos por tamaño: hover y clic sobre el punto de sparkline y la barra más a la derecha de la tarjeta de la primera fila en la última columna (`spark_ult`, `barra_ult`) y en la primera (`spark_pri`, `barra_pri`); hover y clic sobre la barra más a la derecha de la tarjeta de la última fila, con su centro a 20 px del borde inferior de la ventana, en la primera y en la última columna (`barra_abajo_pri`, `barra_abajo_ult`). Antes de cada caso, el ratón va a una posición neutra (x = 4). En cada clic: el botón «Ver establecimientos» se pulsa donde `elementFromPoint` lo halla, se comprueba que `.estab-popup` se abre y se cierra con un `mousedown` fuera. Tamaños: 1280 × 800 y 375 × 740 con barras superpuestas (como macOS), y 1280 × 800 con barras clásicas (solo los dos casos del borde derecho). Además, un barrido: los 240 puntos y barras de las 14 tarjetas, de izquierda a derecha y sin posición neutra entre uno y otro (el tooltip parte cada vez de la posición del anterior). Resúmenes con `$TMPDIR/cal_s35f/tt/resumir.R`.
- Evaluación: «dentro» = el rectángulo en `[8, clientWidth − 8] × [8, clientHeight − 8]` (tolerancia 0,01 px); «lado» = si cabe a la derecha (`ptX + 14 + ancho ≤ clientWidth − 8`), `|left − (ptX + 14)| ≤ 0,5`; si no cabe a la derecha pero sí a la izquierda (el borde derecho), `right ≤ ptX − 14 + 1`; si no cabe en ningún lado, solo rige «dentro»; «normal» = si cabe a la derecha y abajo, la posición de antes (`ptX + 14`, `ptY − 14`).

Calibración (caso malo): la salida previa a T0 (`$TMPDIR/base_s35f/motor_comparacion.html`, sin el cambio)
esperado: el hover en el borde derecho da `rect.right > clientWidth`
obtenido: 1280 × 800: `spark_ult` hover `right` 1.433,00 > 1.280 (`ptX` 1.219), `barra_ult` 1.391,00; 375 × 740: `spark_ult` 536,25 > 375, `barra_ult` 529,25; el borde inferior también se salía (`barra_abajo_pri` a 1280: `bottom` 978,95 > 800); con barras clásicas, lo mismo (1.433,00). En los clics del borde derecho y del inferior, «Ver establecimientos» quedaba fuera de la ventana (`elementFromPoint` no lo halla): panel abierto en 4 de 14 clics. Casos: 22 de 28 fuera; barrido: 25 de 119 fuera a 1280 y 93 de 119 a 375. **La calibración da el caso malo.**

Intento 1 (el cambio de T0, build de H6, motor 6825812f…)
esperado: los 28 casos dentro, del lado correcto y con el panel abierto en los 14 clics
obtenido: 28 dentro; panel abierto en 14 de 14; caso normal igual a la base (`spark_pri` y `barra_pri` a 1280: `left` 143,00 y 207,00, `top` 323,70 y 490,36, iguales antes y después); **1 caso del lado incorrecto: `barra_abajo_ult` hover a 375 × 740, `ptX` 312,25, `left` 22,25, `right` 302,25 > `ptX − 13` = 299,25** (el tooltip tapa 3 px del lado del punto). Barrido: 0 fuera y 0 del lado incorrecto con un lado libre. **No cumple.**

Causa raíz del intento 1: `ubicarTooltip` mide `offsetWidth` con el tooltip todavía en la posición del anterior (el clic de `barra_abajo_pri`, `left` 99). Con el bloque contenedor inicial, a un tooltip de `position: absolute` con `left` 99 le quedan 276 px de ancho disponible: mide 276, se ubica en `ptX − 276 − 14` = 22,25 y, ya movido, vuelve a su ancho de 280 y tapa el punto. Ajuste (intento 2, +5 líneas en `ubicarTooltip`): antes de medir, el tooltip va al origen (`left: 0px; top: 0px`), donde el ancho disponible es el de la ventana.

Intento 2 (build con el ajuste, motor ecc21351…)
esperado: el mismo criterio
obtenido: casos: 28 de 28 dentro, 0 del lado incorrecto, panel abierto en 14 de 14 (7, 7, 1, 1, 2 y 1 filas, según la tarjeta); `barra_abajo_ult` hover a 375: `left` 18,25, `right` 298,25 ≤ 299,25; borde derecho a 1280: `spark_ult` `right` 1.205,00 ≤ `ptX − 13` = 1.206, `barra_ult` 1.163,00 ≤ 1.164; a 375: 308,25 ≤ 309,25 y 301,25 ≤ 302,25; borde inferior: `bottom` 792,00 = 800 − 8 en los cuatro casos de 1280 y 732,00 = 740 − 8 en los cuatro de 375; caso normal igual a la base; barras clásicas iguales a las superpuestas. Barrido: 1280, 119 visibles, 0 fuera, 0 del lado incorrecto (94 a la derecha, 25 a la izquierda); 375, 119 visibles, 0 fuera, 0 del lado incorrecto (26 a la derecha, 45 a la izquierda, 48 sin lado libre). **Cumple.**

- Verificación adicional: `Rscript verificar_contenido_motor.R` sobre el build del intento 2 → «JSON idéntico a la línea base».
- PRUEBAS: build del intento 2 codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); la batería y la regresión completa corren en PUB y en FASE R.
- Alcance: `git show --stat 6f74d70` = solo `30_procesamiento/33_motor_template.html` (+5). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: 1 (el ancho medido en la posición anterior), corregido en el intento 2.
- Decisiones autónomas: D-TT-a (riesgo bajo): «en el borde derecho» se evalúa cuando el tooltip no cabe a la derecha y sí a la izquierda; cuando no cabe en ningún lado (a 375 px, un tooltip de 200 a 280 px sobre un punto del medio: `barra_pri` a 375 y 48 del barrido), solo rige «dentro», y el tooltip tapa el punto. El algoritmo del asistente no se cambió en ese caso (el encargo pide ajustes solo si falla el criterio); queda como duda Q-54. D-TT-b (riesgo bajo): el tooltip se mide en el origen y no, por ejemplo, con `visibility: hidden` en su lugar, porque lo que achicaba el ancho era la posición y no la visibilidad.
- Errores propios: ninguno nuevo (la falla del intento 1 venía del código del asistente, commiteado en T0).
- Dudas: Q-54 (en el cierre).
- Hovers sin acierto: en el barrido, 1 elemento por tamaño no estaba bajo su propio centro (`elementFromPoint` devolvía otro) y no mostró tooltip; se registra, no cuenta como falla.

### FASE TB: centrado óptico del texto de los controles

- Estado: completa, en el segundo de 3 intentos.
- Commits: `fa89e7c` fix(sitio): texto de los controles centrado opticamente con text-box (gobCL-sitio).

**Paso 1. Inventario** (`$TMPDIR/cal_s35f/tb/inventario.R`: controles con texto visible, `display`, alto y si el texto va suelto en un flex o una rejilla). Regla: controles con caja (fondo o borde) y alto fijo o relleno simétrico, con una línea de texto, visibles en el estado inicial de las tres vistas, más los que el encargo nombra y piden una interacción (`.select` y la píldora), y los que comparten la regla CSS de uno del inventario. Los selectores son los de `verificar_centrado.R` (INV_*).
- Menú (fragmento, en las dos páginas): `.view-tab` ×3.
- Motor, `#comparacion`: `.segmented-btn` ×4 (Nivel y Prueba); `.btn-primary` «Agregar territorio»; `.btn-toggle` «Mostrar niveles Elemental e Insuficiente»; `.gse-filter select` («Todos»); `.notes-toggle` «Notas metodológicas»; la píldora `.loading-pill` «Recalculando…» (tras cambiar de nivel; dura 420 ms y el medidor la retiene anulando ese `setTimeout`); y en el modal «Agregar territorio», pestaña «Comuna»: `.select` («Todas las dependencias») y los `.btn` «Cancelar» y «Agregar al análisis» (comparten la regla de «Agregar territorio»).
- Motor, `#panorama`: `.territorio-select`; `.segmented.is-on-dark .segmented-btn` ×2 (Nivel); `.notes-toggle`.
- Vista: los 9 botones de cohorte (`#c-coh button`); `select#c-np` (nivel y asignatura); `select#c-gse` (grupo); los 2 interruptores de «Cobertura» (`.sw`); `.btn` «Notas metodológicas», «Ver el desglose…» (`#b-det`) y «Cerrar» (`#b-cerrar`, en las notas); las 4 insignias `.num` de la tabla (las etiquetas tipo píldora de la vista).
- Total: 45 controles por ancho, 90 medidas (1280 y 375 px).
- Fuera del inventario, con su razón: `.entity-estab-btn` (texto enlace, sin caja); las filas `.rw` de la tabla (sin caja); los botones solo de ícono (`.btn-icon-only`, velocidades `#c-vel`, `.btn.ico`, `.play`, `.icon-export` en reposo); el rótulo de `.icon-export` (visible solo al pasar el ratón); del modal del motor, las pestañas `.modal-tab`, el campo `.input` y las filas de casillas; el botón «Ver establecimientos» del tooltip fijado. Quedan como pendiente (Q-57).
- Estructura hallada con `$TMPDIR/cal_s35f/tb/sonda_textbox.R` (Chrome 153): `text-box` recorta en un botón de `display` por omisión (alto 28 → 22,797), en un ítem flex que es contenedor de bloque (`<a>` del menú: 47 → 40,156; `<span>` hijo: 16 → 10,797) y en un bloque; **no** recorta el texto suelto de un botón o una etiqueta `display: flex/inline-flex` (40 → 40, texto sin moverse), ni en una rejilla (22 → 22), ni en un `<select>` (40 → 40; 30 → 30). En el inventario, el texto va suelto en un flex o una rejilla en: los `.btn` de las dos páginas, las cohortes, «Cobertura» y las insignias `.num`.

**Paso 2. Medidor** `verificar_centrado.R` (raíz, ignorado; sin rutas absolutas porque el validador del build revisa los `verificar_*.R`). Chromote a `deviceScaleFactor` 2, ventana de 1280 × 900 y 375 × 900, barras superpuestas. Por control: la caja de relleno (sin borde) en px de dispositivo fraccionarios; las filas y columnas enteramente dentro de ella; los caracteres del texto principal con `Range.getClientRects()` (en un `<select>`, con `measureText` del lienzo desde el borde del relleno); la captura de la ventana con el control a la vista.
- «arriba» = borde superior del trazo de la altura de mayúscula (mayúsculas, dígitos y ascendentes b, d, h, k, l, en todo su ancho, en la primera línea) − borde superior de la caja;
- «abajo» = borde inferior de la caja − línea base (letras sin descendente con tinta abajo en su franja central, más los dígitos, en la última línea, en el 50 % central de cada carácter para no leer la cola de un vecino);
- cobertura = distancia de color al fondo (el color más frecuente de la franja) sobre la distancia máxima; el trazo se detecta con cobertura ≥ 0,5 y el borde se ubica dentro de la fila límite, o de la vecina con cobertura ≥ 0,1, según su cobertura (precisión subpíxel);
- criterio: |arriba − abajo| ≤ 2 px de dispositivo.
- Constantes: `DSF` 2, `UMBRAL_DETECCION` 0,5, `UMBRAL_TINTA` 0,1, `MITAD_COLUMNA` 0,25, `TOLERANCIA_DISP` 2, `ESPERA_CARGA_S` 1,5, `MARGEN_VISTA` 70.
- Referencias elegidas por medición (`$TMPDIR/cal_s35f/tb/glifos.R`: gobCL-sitio a 80 px, Regular y Bold, tinta de cada carácter en todo su ancho y en la franja central, contra la «H»). Todas las mayúsculas y los dígitos llegan a la altura de mayúscula; las redondas (C, G, O, S, 0, 3, 6, 8, 9) y las ascendentes b, d, h, k, l sobresalen 1,25 % de em. En la franja central, sin tinta arriba: H (Regular), U, V, X, Y; sin tinta abajo: A, H, X, x.

Control positivo del medidor (`$TMPDIR/cal_s35f/tb/sintetico.R` y `plano_fase.R`, sobre la base)
esperado: un texto centrado por construcción (`text-box` y relleno simétrico) lee ≈ 0; desplazado 1 px CSS, ≈ ±4
obtenido:
- desplazado −1 y +1 px: −6,17 a −3,00 y +1,83 a +5,00 (sensibilidad ±4 respecto del centrado, en los cinco tamaños);
- centrado: −2,17 a +1,00 según el tamaño.
- Letras planas («HETEH») con `text-box`, a 12-22 px y en los dos pesos: la tinta coincide con la caja recortada con un error de ±0,125 px CSS: el recorte de Chrome es exacto.
- Pero con la caja a distintas posiciones subpíxel (paso 0,125 px), la tinta salta de a 1 px CSS: **Chrome ubica la línea base del texto en píxeles CSS enteros aun a DSF 2**. Un texto bien centrado lee entre −1,9 y +1,9 px de dispositivo según dónde caiga su caja, justo la tolerancia del encargo.
- Conclusión: el medidor es sensible y exacto; lo que varía es la cuantización real del navegador. **Dispara.**

Calibración (caso malo): la base de H6 (`$TMPDIR/base_s35f/h6/`)
esperado: arriba < abajo en el selector de territorio y en «4° Básico», con 2 px de dispositivo o más de diferencia
obtenido: selector de territorio, arriba 22,03 y abajo 26,80 (−4,77) a 1280, −4,57 a 375; «4° Básico» (Nivel del motor), 15,12 y 18,82 (−3,70) a 1280, −3,52 a 375; «4° Básico» sobre fondo oscuro (panorama), −5,08 y −4,96. Los 90 controles de la base quedan fuera del criterio, entre −6,94 y −2,50. **La calibración da el caso malo.**

**Paso 3. Corrección** (intento 1, parche guardado en `$TMPDIR/cal_s35f/tb/intentos/TB_intento1.patch`, 308 líneas, md5 2ecde535216bea06966f7fb9073795af; intento 2 sobre él):
- Constantes nuevas en `:root` de las dos plantillas: `--compensa-recorte: calc((1lh - 1cap) / 2)` y `--ajuste-optico-select`; en el motor, además, `--holgura-tinta: 0.25em` (el descendente de gobCL). Con `lh` y `cap` la compensación no lleva cifras fijas: se midió que `1lh` da el alto de línea usado (19 px a 18 px, 15 a 14 px) y `1cap` la altura de mayúscula.
- Controles que son contenedor de bloque, en su propia regla: `text-box: trim-both cap alphabetic`, relleno `calc(<relleno de antes> + var(--compensa-recorte))` y `min-height` con el alto de antes (`1lh` + relleno + borde). El recorte redondea al 1/64 de píxel y sin `min-height` el alto quedaba hasta 1/64 corto. Son `.view-tab` (en el fragmento, con `--relleno-tab` 14/12 px y `--borde-tab` 3 px) y `.segmented-btn` (`--relleno-segmentado` 6 px; cubre también `is-on-dark`).
- Texto suelto en un flex o una rejilla: el texto va en un elemento propio (`<span class="control-texto">` en el JSX del motor, `<span class="tx">` en la vista) con `text-box`, `padding-block: var(--compensa-recorte)` y `min-height: 1lh`: la caja queda del mismo tamaño y en el mismo lugar que el texto suelto de antes. Sitios: motor, «Agregar territorio», «Elegir territorio», «Cancelar», «Agregar al análisis / Guardar cambios», el botón de niveles, las notas y la píldora; vista, «Cobertura» ×2, «Notas metodológicas», «Cerrar», `#b-det` (en su cadena JS) y las insignias `.num` (en `tarjeta()`).
- Botones de cohorte (el marcado lo arma `36_generar_trayectorias.R`, fuera del ALCANCE): el script de la vista separa al iniciar el año en `<span class="tx">`, y `#c-coh button` pasa a `align-items: baseline` con `padding-top: calc((var(--h) - 6px - 1lh) / 2)`. Así el año queda centrado y la cifra `<em>` sigue en su línea base.
- Nombre del territorio (`.territorio-select-name`, que corta con `overflow: hidden`): `text-box`, `padding-block: var(--holgura-tinta)` y `margin-block: calc(var(--compensa-recorte) - var(--holgura-tinta))`.
- `<select>` nativos (ignoran `text-box`): relleno asimétrico con `--ajuste-optico-select`. En `.select` (regla propia; `.input` no cambia) y en `.gse-filter select`, `padding-top: calc(P + A)`, `padding-bottom: calc(P - A)` y `min-height` con el alto de antes. En los `select` de la vista (alto fijo de 40 px, texto centrado), `padding: calc(2 * A) 30px 0 12px`.

Medición de que el `<select>` ignora `text-box` (`$TMPDIR/cal_s35f/tb/select_y_em.R`: base, con y sin `style.textBox = 'trim-both cap alphabetic'`)
esperado: (sin esperado previo; se registra)
obtenido: `#c-np`, valor computado «cap alphabetic»; alto 40,000 y arriba/abajo 24,17/30,86 con y sin la propiedad; captura igual píxel a píxel. `.gse-filter select`, lo mismo (25,000; 9,90/16,55). **Lo ignora.**

**Paso 4. Criterio.** Intento 1 (`--ajuste-optico-select: 0.0875em`; build motor ceb3a973…, vista 2516fa2e…)
esperado: los 90 dentro del criterio; alto de cada caja igual al de la base (|Δ| ≤ 0,5 px)
obtenido: 86 de 90 dentro. Fuera, los dos `select` de la vista: nivel −2,69 (1280) y −2,50 (375), grupo −2,70 y −2,50. Altos: iguales salvo el selector de territorio, +0,0312 px (1/32), que baja 1/32 px lo que sigue en el panorama. **No cumple.**

Causas del intento 1:
- A 15 px, Chrome redondea el ascendente (11,25 → 11) y el descendente (3,75 → 4). El desvío real es (10,125 − (11 − 4)) / 2 = 1,5625 px = 0,104 em, y no 0,0875 em = 1,3125 px. A 14 y 16 px los dos valores coinciden (1,225 y 1,4).
- El margen negativo del nombre redondea hacia cero en unidades de 1/64 (−1,075 → −1,0625): su caja medía 19,031 y alargaba el botón.

Ajustes del intento 2:
- `--ajuste-optico-select: calc((1cap - (round(0.75em, 1px) - round(0.25em, 1px))) / 2)`: la misma métrica de §2 (750, 250 y la altura de mayúscula), con el redondeo a píxel que el navegador aplica a `line-height: normal`. Da 0,0875 em a 14 y 16 px y 0,104 em a 15 px.
- `.territorio-select` con `height` en vez de `min-height`, igual al alto de antes.

Intento 2 (build motor 65f2f59b…, vista 713dfa9d…; resultados en `$TMPDIR/cal_s35f/tb/centrado_i2.rds`)
esperado: el mismo criterio
obtenido: **90 de 90 dentro, de −1,57 a +1,54** (base: 90 de 90 fuera, de −6,94 a −2,50); alto de cada caja igual al de la base (|Δ| máximo 0) y posición igual (Δy máximo 0), a 1280 y a 375 px. Por control (dif en px de dispositivo; base → final):

| vista | control | ancho | n | alto (px CSS) | base | final |
|---|---|---|---|---|---|---|
| comparación | menú | 1280 / 375 | 3 | 50 / 43 | −4,76 a −4,54 / −3,77 a −3,67 | −0,76 a −0,54 / 0,23 a 0,33 |
| comparación | Nivel y Prueba | 1280 / 375 | 4 | 28 | −3,97 a −3,57 / −3,79 a −3,38 | 0,03 a 0,43 / 0,21 a 0,62 |
| comparación | Agregar territorio | 1280 / 375 | 1 | 32 | −6,57 / −3,38 | 1,43 / 0,62 |
| comparación | niveles E e I | 1280 / 375 | 1 | 27 | −6,70 / −4,64 | 1,30 / −0,64 |
| comparación | GSE (select) | 1280 / 375 | 1 | 25 | −6,65 / −4,60 | 1,35 / −0,60 |
| comparación | notas | 1280 / 375 | 1 | 38 | −5,00 / −6,94 | −1,00 / 1,06 |
| comparación | píldora | 1280 / 375 | 1 | 29 | −5,33 / −3,14 | −1,33 / 0,86 |
| modal | `.select` | 1280 / 375 | 1 | 30 | −3,72 / −3,72 | 0,28 / 0,28 |
| modal | Cancelar, Agregar al análisis | 1280 / 375 | 2 | 32 | −3,72 | 0,28 a 0,29 |
| panorama | menú | 1280 / 375 | 3 | 50 / 43 | −4,76 a −4,54 / −3,77 a −3,67 | −0,76 a −0,54 / 0,23 a 0,33 |
| panorama | territorio | 1280 / 375 | 1 | 39 | −4,77 / −4,57 | −0,77 / −0,57 |
| panorama | Nivel (oscuro) | 1280 / 375 | 2 | 28 | −5,34 a −5,08 / −5,22 a −4,96 | −1,34 a −1,08 / −1,22 a −0,96 |
| panorama | notas | 1280 / 375 | 1 | 38 | −5,57 / −6,69 | −1,57 / 1,31 |
| vista | menú | 1280 / 375 | 3 | 50 / 43 | −4,76 a −4,54 / −3,77 a −3,67 | −0,76 a −0,54 / 0,23 a 0,33 |
| vista | cohortes | 1280 / 375 | 9 | 34 | −6,67 a −6,64 / −6,49 a −6,46 | 1,33 a 1,36 / 1,51 a 1,54 |
| vista | nivel (select) | 1280 / 375 | 1 | 40 | −6,69 / −6,50 | 1,31 / 1,50 |
| vista | grupo (select) | 1280 / 375 | 1 | 40 | −6,70 / −6,50 | 1,30 / 1,50 |
| vista | Cobertura | 1280 / 375 | 2 | 40 / 40 y 44 | −6,70 a −6,69 / −6,50 a −4,51 | 1,30 a 1,31 / −0,51 a 1,50 |
| vista | Notas metodológicas | 1280 / 375 | 1 | 40 | −6,70 / −6,50 | 1,30 / 1,50 |
| vista | Ver el desglose | 1280 / 375 | 1 | 32 | −3,97 / −6,54 | 0,03 / 1,46 |
| vista | insignias `.num` | 1280 / 375 | 4 | 22 | −2,90 a −2,68 / −2,72 a −2,50 | 1,10 a 1,32 / 1,28 a 1,50 |
| notas de la vista | Cerrar | 1280 / 375 | 1 | 40 | −4,21 | −0,21 |

Píxeles fuera de los controles (`$TMPDIR/cal_s35f/tb/tb_pixeles.R`: página completa a 1280 × 900, DSF 1, base de H6 contra el intento 2, con las cajas de borde de los controles enmascaradas —unión de las de los dos estados—; capturas en `$TMPDIR/cal_s35f/tb/pix_i2/`)
esperado: 0 píxeles distintos fuera de los controles en las tres vistas
obtenido: comparación (3.601 × 1.280, 11 cajas), panorama (1.289 × 1.280, 7) y vista (1.119 × 1.280, 22): **0, 0 y 0 fuera**; distintos dentro de los controles 9.119, 6.739 y 14.502; cajas iguales en los dos estados; determinismo base contra base 0, 0 y 0; 0 errores de consola y 0 solicitudes de red en el estado final.

I-8 (`$TMPDIR/cal_s35f/tb/i8.R`, `scrollWidth` de la vista, `#comparacion` y `#panorama` a 375, 540, 768 y 1280 px)
esperado: igual al ancho en los 12 casos, antes y después
obtenido: base 12 de 12 y final 12 de 12 (375, 540, 768 y 1280 en los tres). **PASA.**

I-3 e I-4 sobre el build del intento 2
esperado: «JSON idéntico a la línea base»; DATA de la vista `identical()`; C3 PASA
obtenido: «JSON idéntico a la línea base»; «identical: TRUE»; batería «Resultado: 32 pruebas, 32 pasan, 0 fallan», con «C3 PASA … (12724 filas de 37 unidades; idénticas: TRUE; control plantado detectado: TRUE)». **PASA.**

Comprobaciones adicionales:
- Cifra `<em>` de las cohortes (`select_y_em.R`): línea base del año − línea base de la cifra = 0 antes y después; anchos de los 9 botones iguales (72,766 a 77,203 px).
- Nombre del territorio con acentos y descendentes (`recorte_nombre.R`, «Ángol, Ñuñoa y Puqueldón (Concepción)»):
  - en la base, el `overflow: hidden` ya cortaba la tilde de «Á» y la virgulilla de «Ñ» (defecto previo): tinta de la fila 19 a la 54;
  - en el final se ven enteras y los descendentes no se cortan: filas 18 a 56, 7.239 píxeles con tinta contra 7.191.

Capturas para el titular en `_archivo/20260925_capturas_s35f/` (ignorada; 1280 × 900, DSF 2, antes y después): `s35f_motor_encabezado_{antes,despues}_1280.png` (encabezado, menú y barra de controles), `s35f_motor_selector_territorio_{antes,despues}_1280.png` (selector y tarjeta con Nivel) y `s35f_vista_menu_y_controles_{antes,despues}_1280.png` (menú y controles de la vista).

- PRUEBAS: build del intento 2 codigo_build=0; batería 32/32; I-3 idéntico.
- Alcance: `git show --stat fa89e7c` = las dos plantillas y el fragmento (+114/−22), más las capturas en `_archivo/` (ignorada). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: 2 del intento 1 (el ajuste del `<select>` a 15 px; 1/32 px del selector de territorio), corregidos en el intento 2.
- Decisiones autónomas:
  - D-TB-a (riesgo bajo): donde el texto iba suelto en un flex o una rejilla, `text-box` no alcanza, así que el texto se puso en un elemento propio con la misma regla. «Aplica text-box al texto de cada control» se cumple sobre ese elemento. Es un cambio de marcado en las plantillas (JSX del motor, HTML y cadenas JS de la vista) sin efecto sobre el tamaño de las cajas (medido: Δ 0).
  - D-TB-b (riesgo medio): los botones de cohorte los arma `36_generar_trayectorias.R`, fuera del ALCANCE; el script de la vista separa el año al iniciar. La alternativa limpia, cambiar el generador, queda como pendiente (Q-58).
  - D-TB-c (riesgo medio; **desviación**): `--ajuste-optico-select` no quedó en 0,0875 em literal, sino en la misma métrica con el redondeo a píxel del navegador, porque con 0,0875 em los `select` de 15 px fallaban el criterio (−2,69 y −2,50). A 14 y 16 px el valor es el mismo. En Windows el texto del selector queda bajo el centro: unos 0,06 em (0,06 a 0,08 em según el tamaño). La alternativa, reemplazar el selector nativo, queda pendiente sin implementar (§11).
  - D-TB-d (riesgo bajo): el nombre del territorio lleva holgura de 0,25 em con margen negativo, para que el recorte no corte acentos ni descendentes. Con eso, además, ya no se cortan los acentos de las mayúsculas, que antes sí se cortaban.
  - D-TB-e (riesgo bajo): el inventario se acotó con la regla del paso 1; los controles fuera de él quedan en Q-57.
- Errores propios (del medidor, corregidos antes de registrar resultados):
  - `seq()` con un carácter fuera de la caja daba índices negativos;
  - el bloque principal corría también al cargarse con `source()`;
  - la franja central de la «V» y de la «d» no tiene tinta arriba, lo que daba un signo falso en `#b-det`; se corrigió con el ancho completo arriba;
  - el umbral fijo de 50 % dejaba un sesgo de hasta +1,4 px, y un umbral bajo leía el rastro del borde de la caja; se corrigió separando detección y ubicación;
  - la primera versión de `plano.R` leía el fondo de la página como tinta.
- Dudas: Q-55 a Q-58 (en el cierre).

### FASE PUB: copia a `docs/`

- Estado: completa (TT y TB completas antes de copiar).
- Commits: `2a719b1` deploy(docs): tooltip dentro de la ventana y centrado optico de los controles.

`md5 -q docs/index.html docs/trayectorias.html` antes de la copia
esperado: 601df6d7bfdc8bb60f57c5f9fba3db54 y 1067908ec09ce95dbee692b9696da7fa (H4)
obtenido: 601df6d7bfdc8bb60f57c5f9fba3db54 y 1067908ec09ce95dbee692b9696da7fa

**Paso 1.** `Rscript 00_build.R` y la batería (salidas en `$TMPDIR/cal_s35f/pub/`)
esperado: codigo 0 y 32 pruebas o más en PASA
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); codigo_bateria=0, «Resultado: 32 pruebas, 32 pasan, 0 fallan»; motor 65f2f59bcccd8da57e0aa4aa07a2533c y vista 713dfa9d1e6750b8562ff0300179b53a, iguales a los del intento 2 de TB (build reproducible)

**Paso 2.** `cp 40_salidas/motor_comparacion.html docs/index.html` y `cp 40_salidas/trayectorias_traspasos.html docs/trayectorias.html` (autorización 2)

**Paso 3. Verificación.**

md5 de `docs/` contra `40_salidas/`
esperado: iguales
obtenido: `docs/index.html` 65f2f59bcccd8da57e0aa4aa07a2533c = motor; `docs/trayectorias.html` 713dfa9d1e6750b8562ff0300179b53a = vista

I-2 (`grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'`)
esperado: 0 en cada uno
obtenido: `40_salidas/motor_comparacion.html` 0 0; `40_salidas/trayectorias_traspasos.html` 0 0; `docs/index.html` 0 0; `docs/trayectorias.html` 0 0

I-3 (`Rscript verificar_contenido_motor.R docs/index.html`) y, además, I-4 sobre `docs/trayectorias.html`
esperado: «JSON idéntico a la línea base»; `identical: TRUE`
obtenido: «JSON idéntico a la línea base», codigo_I3=0; «DATA de la vista: … identical: TRUE»

`git status --porcelain` antes del commit
esperado: solo los dos archivos de `docs/` (más este log, sin seguimiento)
obtenido: ` M docs/index.html`, ` M docs/trayectorias.html`, `?? 50_documentacion/andamios/logs/20260925_tooltip_centrado_s35f_log.md`

- Alcance: `git show --stat 2a719b1` = `docs/index.html` y `docs/trayectorias.html`. Dentro del ALCANCE.
- Subagentes: ninguno. Bugs: ninguno. Decisiones autónomas: ninguna. Errores propios: ninguno. Dudas: ninguna.

### FASE R: auditoría y reparación

Sin subagentes: el orquestador re-deriva cada afirmación con un comando distinto del que la produjo.

**R.1 Inventario de afirmaciones auditables** (armado desde este log, antes de auditar):

| id | afirmación | fase |
|---|---|---|
| R-01 | H1-H4: tres rutas de §2 más el log; 0 stash; `HEAD` y `origin/main` en c1e2047; md5 de §2 y del encargo | FASE 0 |
| R-02 | T0 = `476b1e1`, con las tres rutas de §2, hijo de c1e2047 | FASE 0 |
| R-03 | H5 32/32; H6 codigo 0; motor 6825812f…, vista 1067908e… | FASE 0 |
| R-04 | los comparadores de I-3 e I-4 disparan con un número alterado | FASE 0 |
| R-05 | TT, calibración: sin el cambio, el hover del borde derecho sale de la ventana (1.433 > 1.280; 536,25 > 375) | TT |
| R-06 | TT, intento 1: 1 caso del lado incorrecto (`barra_abajo_ult` a 375, 302,25 > 299,25) | TT |
| R-07 | TT, intento 2: 28/28 dentro y del lado correcto, panel en 14/14, caso normal igual; barrido 0/0 | TT |
| R-08 | `6f74d70` toca solo la plantilla del motor (+5) | TT |
| R-09 | `text-box` recorta un botón de display por omisión y un ítem flex de bloque; no el texto suelto de un flex, una rejilla ni un `<select>` | TB |
| R-10 | inventario: 45 controles por ancho | TB |
| R-11 | el medidor tiene sensibilidad ±4 px de dispositivo por 1 px CSS; Chrome ubica la línea base en px CSS enteros | TB |
| R-12 | calibración de TB: territorio −4,77 y «4° Básico» −3,70 (1280); 90/90 fuera en la base | TB |
| R-13 | intento 1: 86/90; `select` de 15 px −2,69/−2,50; territorio +1/32 px | TB |
| R-14 | intento 2: 90/90 dentro (−1,57 a +1,54); altos y posiciones iguales a la base | TB |
| R-15 | 0 píxeles distintos fuera de los controles a 1280 en las tres vistas | TB |
| R-16 | I-8 12/12 antes y después | TB |
| R-17 | el `<select>` ignora `text-box` | TB |
| R-18 | la cifra `<em>` de las cohortes sigue en la línea base del año; anchos iguales | TB |
| R-19 | el nombre del territorio ya no corta acentos; los descendentes no se cortan | TB |
| R-20 | `fa89e7c` toca solo las dos plantillas y el fragmento | TB |
| R-21 | `docs/` = `40_salidas/` (65f2f59b…, 713dfa9d…); I-2 en 0; JSON y DATA idénticos | PUB |
| R-22 | `2a719b1` toca solo `docs/index.html` y `docs/trayectorias.html` | PUB |
| R-23 a R-30 | I-1 a I-8 | §4 |
| R-31 | alcance global dentro de la unión de los ALCANCE, más el log | global |
| R-32 | regresión: build 0, batería ≥ 32 en PASA, JSON idéntico | global |

**R.2 Re-derivación independiente** (orquestador; scripts en `$TMPDIR/cal_s35f/r/`)

R-01 y R-02 (`git cat-file -p 476b1e1`, `git diff-tree --name-status`, `git cat-file blob 476b1e1:<ruta> | md5 -q`, `git stash list`)
esperado: padre c1e2047; las tres rutas de §2 (M, A, M); md5 de §2 y del encargo; 0 stash
obtenido: «parent c1e2047a1d8…»; `M 30_procesamiento/33_motor_template.html`, `A …/encargo_tooltip_centrado_s35f.md`, `M …/20260924_sesion35_errores_asistente.md`; f84001c9…, cc250254…, f63b7088…; la plantilla en c1e2047, 1427c375…; stash 0 → CONFIRMADAS

R-03 y R-32 (regresión completa de R.5, sobre el estado final): ver R.5 → CONFIRMADAS

R-04 (control positivo de R.6 sobre el estado final, con otro decodificador en Python): ver R.6 → CONFIRMADA

R-05, R-06 y R-07 (TT) con otro instrumento (`rd_tt.R`: posición por `offsetLeft`/`offsetTop`/`offsetWidth`, no por `getBoundingClientRect`), otros tamaños (1024 × 700, 414 × 896 y 1440 × 900) y todas las tarjetas de la primera y la última columna (punto y barra más a la derecha), en hover y en clic, sobre `docs/index.html` y sobre la base previa a T0
esperado: final, 0 fuera y 0 del lado incorrecto, panel en todos los clics; base, fuera por la derecha
obtenido: final «casos 84 | visibles 84 | fuera 0 | fuera por la derecha 0 | lado incorrecto 0 | sin lado libre 0 | clics con panel 42 de 42»; base «fuera 50 | fuera por la derecha 48 | lado incorrecto 48 | clics con panel 19 de 42» (16 a 18 por tamaño) → CONFIRMADAS. (R-06, el caso del intento 1, no se re-ejecuta: el código del intento 1 ya no existe en el árbol; su causa la confirma el ajuste, que lo corrige y deja 0 del lado incorrecto también en los tamaños nuevos.)

R-08, R-20 y R-22 (`git diff-tree --numstat -r <commit>` y padre)
esperado: `6f74d70` solo la plantilla del motor; `fa89e7c` las dos plantillas y el fragmento; `2a719b1` los dos archivos de `docs/`
obtenido: `6f74d70` (padre 476b1e1) «5 0 30_procesamiento/33_motor_template.html»; `fa89e7c` (padre 6f74d70) «12 3 …/33_fragmento_sitio.html», «64 11 …/33_motor_template.html», «38 8 …/36_trayectorias_template.html»; `2a719b1` (padre fa89e7c) «123 18 docs/index.html», «50 11 docs/trayectorias.html» → CONFIRMADAS

R-09 y R-17: ya medidas con dos métodos (`sonda_textbox.R`, alto y posición del texto; `select_y_em.R`, captura píxel a píxel con y sin la propiedad) → CONFIRMADAS

R-11 (instrumento): control positivo con desplazamientos conocidos (±1 px CSS) y letras planas en fases de 0,125 px (TB) → CONFIRMADA

R-12, R-14 y R-18 (TB) con dos instrumentos distintos del medidor de TB (`rd_tb.R`, sobre `docs/` y sobre la base de H6, a 1280 y 375 px, 80 controles del estado inicial):
- (a) maquetación: en el elemento recortado, su caja de contenido va de la altura de mayúscula a la línea base; se comparan el hueco de arriba y el de abajo en la caja de relleno del control;
- (b) tinta aislada: captura con el texto visible menos captura con el texto transparente, a DSF 3 y en filas enteras;
- (c) altos con `getComputedStyle(height)`.

esperado: final, |dif| ≤ 1 px CSS en todos por tinta y ≈ 0 por maquetación; base, fuera; altos iguales
obtenido: final «tinta aislada: |dif| <= 1 px CSS en 80, rango -0.92 a 0.71 | maquetación: medidos 74, |dif| máx 0.0000 px CSS»; base «|dif| <= 1 px CSS en 0, rango -3.60 a -1.41»; altos iguales por grupo (27, 28, 32, 25, 38, 22, 28, 40-42, 39, 43/50, 32, 40, 34) → CONFIRMADAS

R-15 (píxeles) por otras condiciones de captura, con `tb_pixeles.R` a 1280 × 1000 (página completa) y capturas solo de ventana a 900, 1000, 1119 y 1219 de alto (`ventana_vista.R`, `ventana_1219.R`, `ruido_vista.R`)
esperado: 0 fuera de los controles
obtenido:
- a 1280 × 1000, de página completa: comparación 0 y panorama 0; **vista 1.131** (filas 640 a 696, dos líneas de la cuadrícula del plano), determinista (5 capturas).
- La maquetación de la vista es idéntica en los dos estados a 900 y a 1000 de alto (`diag_vista.R`: plano 566,6563/526,9063, `.app`, `.ctls`, `.main`, `.pl`, columnas 317/875 y `--tabs-h` 51 iguales; atributos `y1` iguales).
- Solo de ventana, con la misma vista: a 1000, 0 y 3; a 900, 3 y 4; a 1219, 1 y 0; a 1119, 0 y 0.
- El ruido de la captura solo de ventana, base contra base, es de 0 a 6 píxeles (final contra final, de 0 a 5).
- La captura de página completa redimensiona la ventana durante la toma y la vista, con alto en `dvh`, vuelve a pintar el plano. Con una ventana real de 1219 de alto la diferencia no aparece.
→ CONFIRMADA en las condiciones del criterio (1280 × 900) y en ventanas reales; los 1.131 píxeles son un artefacto de la captura (ADVIERTE R-36).

R-16 (I-8) por otra vía (`rd_i8.R`: `window.scrollTo(100000, 0)` y lectura de `scrollX`, más `document.body.scrollWidth`, a 375, 540, 768 y 1280 px con 800 de alto)
esperado: `scrollX` 0 y `body.scrollWidth` ≤ ancho en los 12
obtenido: 0 y igual al ancho en los 12 → CONFIRMADA

R-19 (`recorte_nombre.R`, tinta del nombre con acentos y descendentes, más la revisión de los recortes ampliados): base, tilde de «Á» y virgulilla de «Ñ» cortadas; final, enteras → CONFIRMADA

R-21 (identidad de lo publicado) con `git hash-object` y `git ls-tree`
esperado: blobs iguales en `docs/` y `40_salidas/`, y los de `HEAD`
obtenido: `995a3f28a826…` en `docs/index.html`, `40_salidas/motor_comparacion.html` y `HEAD:docs/index.html`; `b625058efa91…` en `docs/trayectorias.html`, `40_salidas/trayectorias_traspasos.html` y `HEAD`; en `476b1e1`, `595219a66c94…` y `c49396e1be1e…` (lo publicado antes) → CONFIRMADA

R-21 (red) con un segundo patrón (`rd_inv.py`: patrones ampliados —`src` con o sin comillas, `url(`, `<link href>`, `@import`, `fetch(`— y toda aparición de `http`, revisada a mano)
esperado: 0 cargas por red; los aciertos de `http`, sin carga
obtenido: 0 cargas en los cuatro HTML. Aciertos de `http`:
- motor, 28, igual que lo publicado antes: 15 espacios de nombres SVG/XLink; 8 cadenas `http://www.w3.org/…` de React y D3 (XHTML, MathML, XML); la URL del decodificador de errores de React (una cadena, no se carga); dos nombres de atributo `httpEquiv`/`http-equiv`; el comentario de licencia de D3 (`https://d3js.org`) y el de pako (`https://github.com/nodeca/pako`);
- vista, 2, los dos espacios de nombres SVG.
→ CONFIRMADA

R-21 (datos) por otra vía (`rd_inv.py`, JSON del motor en Python sin `meta.fecha_generacion`, sha256 canónico; bloque `DATA` de la vista byte a byte)
esperado: iguales a la base de H6
obtenido: «I-3 … sha256 7967dfa07a99ef11 base 7967dfa07a99ef11 idéntico: True» en `40_salidas/` y en `docs/`; «I-4 … bloque DATA idéntico byte a byte: True | largo 2018084 | DATA igual al parsear: True» en los dos → CONFIRMADA

**R.3 Invariantes 🔒** (estado final `2a719b1`, tras el build de la regresión)

I-1 `md5 -q docs/*.html` tras PUB
esperado: iguales a `40_salidas/`
obtenido: 65f2f59bcccd8da57e0aa4aa07a2533c y 713dfa9d1e6750b8562ff0300179b53a en `docs/` y en `40_salidas/` → **PASA**

I-2 `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html`
esperado: 0 en cada uno
obtenido: 0 0 en los cuatro → **PASA**

I-3 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base», codigo_I3=0 → **PASA**

I-4 prueba C3 y el `DATA` de la vista contra la base de H6 con `identical()`
esperado: PASA e idéntico
obtenido: «C3 PASA … (12724 filas de 37 unidades; idénticas: TRUE; control plantado detectado: TRUE)»; «identical: TRUE» → **PASA**

I-5 `md5 -q 10_utils/fuentes/*.otf`
esperado: a7407ed6… y 0257bb4b…
obtenido: a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc; blobs ccbdbdc6… y b78fd5c5… iguales en `HEAD` y en `476b1e1` → **PASA**

I-6 `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`
esperado: vacío
obtenido: vacío (0 líneas) → **PASA**

I-7 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 (y 28 con `git ls-files -- '*.csv' '*.xlsx' '*.parquet' '*.rds' | wc -l`) → **PASA**

I-8 `scrollWidth` en la vista, `#comparacion` y `#panorama` a 375, 540, 768 y 1280 px (`i8.R` sobre `40_salidas/`)
esperado: igual al viewport
obtenido: 12 de 12 → **PASA**

**R.4 Alcance global** (`git diff --name-only 476b1e1..HEAD` con `rd_alcance.R`, y `git status --porcelain`)
esperado: 0 rutas fuera de la unión de los ALCANCE (más el log); el árbol solo con el log
obtenido: «rutas: 5 | fuera: (ninguna)» (el fragmento, las dos plantillas y los dos `docs/`); `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260925_tooltip_centrado_s35f_log.md`; las capturas van en `_archivo/20260925_capturas_s35f/` (ignorada). **PASA.**

**R.5 Regresión completa** (estado final `2a719b1`; salidas en `$TMPDIR/cal_s35f/r/`)
esperado: `Rscript 00_build.R` codigo 0; batería ≥ 32 en PASA y codigo 0; «JSON idéntico a la línea base»
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»), motor 65f2f59b… y vista 713dfa9d… (iguales a PUB); codigo_bateria=0, «Resultado: 32 pruebas, 32 pasan, 0 fallan»; codigo_I3=0, «JSON idéntico a la línea base» → **PASA**

**R.6 Control positivo de la propia auditoría**
- Cifra alterada en una copia fuera del árbol (`$TMPDIR/cal_s35f/r/ctl/`): motor 3.5 → 3.6 y vista 23.9 → 23.8. Resultados: `rd_inv.py` «I-3 … idéntico: False» e «I-4 … idéntico byte a byte: False | … igual al parsear: False»; `verificar_contenido_motor.R` «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)», codigo=1; `i4_data_vista.R` «identical: FALSE». **Dispara.**
- Archivo fuera de alcance en un diff simulado: `rd_alcance.R` sobre 7 rutas da «fuera: 30_procesamiento/36_generar_trayectorias.R, 10_utils/fuentes/gobCL_Bold.otf, 40_salidas/intermedios/simce_rbd.parquet, _archivo/otra/x.png, verificar_centrado.R» (acepta la plantilla del motor y `docs/index.html`). **Dispara.**
- Además, los instrumentos de TT y TB dispararon sobre las bases: 50 fuera y 19 de 42 paneles; 0 de 80 dentro por tinta aislada.

**R.7 Veredicto por hallazgo.**
- BLOQUEA: ninguno.
- REPARA: ninguno. R-33 sería un defecto propio reparable en las plantillas (guardar la compensación con `@supports`), pero la reparación exige reconstruir después de PUB, y `docs/` dejaría de ser igual a `40_salidas/` (I-1 en FALLA). Una reparación no puede tocar un 🔒 y la copia a `docs/` solo vale en PUB (autorización 2), así que se registra como ADVIERTE con su corrección propuesta (Q-59).
- ADVIERTE: R-33 a R-47 (tabla R.10). No se corrigen.

**R.8 Ciclo de reparación.** No aplica (0 REPARA).

**R.9 Prohibiciones.** Ningún criterio, tolerancia, valor esperado ni ALCANCE se ajustó; ningún 🔒 se tocó. Las correcciones del medidor de TB se hicieron antes de registrar resultados, y la base se volvió a medir con el medidor final. Evidencia editada tras escribirla: una vez, en FASE TT, antes de cerrar su sección, para corregir tres números de línea citados de memoria (R-47, error propio).

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1-H4 | `cat-file`, `diff-tree`, blobs, `stash list` | §2 | iguales | — | ninguna | — | — |
| R-02 | T0 `476b1e1` | `cat-file -p`, `diff-tree` | 3 rutas, padre c1e2047 | así | — | ninguna | — | — |
| R-03 | H5 y H6 | R.5 | 0; 32/32 | 0; 32/32 | — | ninguna | — | — |
| R-04 | comparadores de I-3 e I-4 | R.6 (Python y R sobre una copia alterada) | disparan | disparan | — | ninguna | — | — |
| R-05 | TT, calibración | `rd_tt.R` en la base (otros tamaños, `offset*`) | fuera por la derecha | 48 de 84; paneles 19 de 42 | — | ninguna | — | — |
| R-06 | TT, intento 1 | causa confirmada por el ajuste; código ya no existe | — | ver R-07 | — | ninguna | — | — |
| R-07 | TT, intento 2 | `rd_tt.R` sobre `docs/index.html` | 0 fuera, 0 lado; paneles | 0; 0; 42 de 42 | ADVIERTE (R-38) | registrar | — | — |
| R-08 | alcance de `6f74d70` | `diff-tree --numstat` | la plantilla | +5 | — | ninguna | — | — |
| R-09 | dónde aplica `text-box` | `sonda_textbox.R` (alto y posición) | — | como se registró | ADVIERTE (R-34) | registrar | — | — |
| R-10 | inventario 45 por ancho | `verificar_centrado.R`, `rd_tb.R` | 45 | 45 (80 del estado inicial en `rd_tb.R`) | ADVIERTE (R-42) | registrar | — | — |
| R-11 | medidor y cuantización | `sintetico.R`, `plano_fase.R` | ±4; exacto | ±4; ±0,125 | ADVIERTE (R-35) | registrar | — | — |
| R-12 | calibración de TB | `rd_tb.R` en la base | fuera | 0 de 80 dentro (−3,60 a −1,41) | — | ninguna | — | — |
| R-13 | intento 1 de TB | parche guardado; causa medida | — | 15 px: 0,104 em | ADVIERTE (R-39) | registrar | — | — |
| R-14 | intento 2: 90/90, altos iguales | `rd_tb.R` (maquetación y tinta aislada, DSF 3) | ≤ 1 px CSS; ≈ 0 | 80/80 (−0,92 a 0,71); 0,0000 | — | ninguna | — | — |
| R-15 | 0 px fuera a 1280 | `tb_pixeles.R` a 1000; capturas de ventana | 0 | 0/0 y 1.131 (artefacto); ventana 0-4 (ruido 0-6) | ADVIERTE (R-36, R-37) | registrar | — | — |
| R-16 | I-8 | `rd_i8.R` (`scrollX` tras desplazar) | 0 | 0 en 12 | — | ninguna | — | — |
| R-17 | `<select>` ignora `text-box` | `select_y_em.R` (píxel a píxel) | — | igual | ADVIERTE (R-43) | registrar | — | — |
| R-18 | cifra `<em>` y anchos | `select_y_em.R` | 0; iguales | 0; iguales | ADVIERTE (R-40) | registrar | — | — |
| R-19 | acentos del nombre | `recorte_nombre.R` y recortes | no cortados | enteros | ADVIERTE (R-44) | registrar | — | — |
| R-20 | alcance de `fa89e7c` | `diff-tree --numstat` | 3 rutas | 3 | — | ninguna | — | — |
| R-21 | `docs/` = `40_salidas/`; red; datos | `hash-object`, `ls-tree`; `rd_inv.py` | iguales; 0; idénticos | iguales; 0; idénticos | — | ninguna | — | — |
| R-22 | alcance de `2a719b1` | `diff-tree --numstat` | 2 rutas | 2 | — | ninguna | — | — |
| R-23 a R-30 | I-1 a I-8 | R.3 y re-derivaciones | PASA | PASA | — | ninguna | — | — |
| R-31 | alcance global | `rd_alcance.R` y `status` | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-32 | regresión | R.5 | 0; ≥ 32; idéntico | 0; 32/32; idéntico | — | ninguna | — | — |
| R-33 | sin soporte de `text-box` (Safari < 18.2, Firefox < 154, Chrome < 133) la compensación agranda las cajas: menú +6,84 px, segmentados +5,19, `.btn` +5,19 y +5,53, notas +4,53 (motor 3.601 → 3.624 px de alto); los controles de alto fijo no cambian | copia con `text-box` desconocido (`sin_textbox/`, `altos_sin.R`) | — | así | ADVIERTE | registrar (Q-59; corrección propuesta: la compensación dentro de `@supports (text-box: trim-both cap alphabetic)`) | — | — |
| R-34 | en WebKit (Safari), `text-box` podría no alcanzar al texto directo de un `<button>` (`.segmented-btn`: Nivel y Prueba); si no alcanza, esos botones crecen 5,19 px y el texto sigue alto. En Chrome sí alcanza. No hay WebKit en la sesión | `sonda_textbox.R` solo en Chrome | — | no medible | ADVIERTE | registrar (Q-60; corrección propuesta: el texto en `<span class="control-texto">` con `display: block`, como en los `.btn`) | — | — |
| R-35 | Chrome ubica la línea base en px CSS enteros: queda un desvío de hasta ±0,5 px CSS según la posición subpíxel de la caja (la tolerancia del encargo); Safari puede cuantizar distinto | `plano_fase.R` | — | ±0,95 px CSS de dif | ADVIERTE | registrar (Q-56) | — | — |
| R-36 | la captura de página completa de la vista a 1280 × 1000 da 1.131 px distintos en la cuadrícula del plano; no aparece con ventanas reales de 1000 ni de 1219 de alto | `ventana_vista.R`, `ventana_1219.R`, `diag_vista.R` | — | artefacto de la toma | ADVIERTE | registrar | — | — |
| R-37 | las capturas solo de ventana tienen un ruido de 0 a 6 px entre cargas del mismo archivo | `ruido_vista.R` | — | 0-6 | ADVIERTE | registrar | — | — |
| R-38 | a 375 px, cuando el tooltip no cabe en ningún lado (48 de 119 del barrido), tapa el punto | `tt_medir.R` | — | 48 | ADVIERTE | registrar (Q-54) | — | — |
| R-39 | `--ajuste-optico-select` no es 0,0875 em literal sino la misma métrica con el redondeo a píxel del navegador (0,104 em a 15 px) | lectura de la plantilla | — | desviación declarada (D-TB-c) | ADVIERTE | registrar | — | — |
| R-40 | los botones de cohorte se reescriben al iniciar (el año va en `.tx`), porque su marcado sale de `36_generar_trayectorias.R`, fuera del ALCANCE | lectura | — | D-TB-b | ADVIERTE | registrar (Q-58) | — | — |
| R-41 | a 375 px el modal del motor desborda la ventana (`.select` en x = −59,5; `min-width: 540px`); previo | `rec_modal.R` | — | previo | ADVIERTE | registrar (Q-55) | — | — |
| R-42 | controles fuera del inventario, sin centrar: pestañas y campo del modal, rótulos de exportar al pasar el ratón, «Ver establecimientos» del tooltip | inventario | — | fuera | ADVIERTE | registrar (Q-57) | — | — |
| R-43 | en Windows (win 1017/399) el texto de los `<select>` queda unos 0,06 a 0,08 em bajo el centro | métrica de §2 | — | declarado | ADVIERTE | registrar | — | — |
| R-44 | la base ya cortaba los acentos de las mayúsculas en el nombre del territorio (previo); D-TB-d lo corrige de paso | `recorte_nombre.R` | — | previo | ADVIERTE | registrar | — | — |
| R-45 | no se creó CLAUDE.md (regla global frente a `.gitignore` y a un ALCANCE cerrado), como en s35 a s35d | — | — | D2 | ADVIERTE | registrar | — | — |
| R-46 | «la base de H6» leída como dos bases (D0-a) | — | — | declarada | ADVIERTE | registrar | — | — |
| R-47 | FASE TT: tres números de línea citados de memoria, corregidos en el log antes de cerrar la sección | — | — | error propio | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA ni REPARA. Las 32 afirmaciones del inventario quedan CONFIRMADAS (ninguna REFUTADA), con controles positivos que dispararon. Hay 15 ADVIERTE (R-33 a R-47), ninguno sobre datos ni invariantes. Las advertencias prioritarias para el titular son R-33 y R-34 (Safari).

## Cierre

### 1. Resumen

El tooltip del motor queda siempre dentro de la ventana. A la derecha del punto cuando cabe, a la izquierda sin taparlo en el borde derecho, y sube en el borde inferior; el caso normal no cambia y «Ver establecimientos» abre su panel en todos los clics. TT se completó en el segundo intento: el cambio del asistente medía el tooltip en la posición del anterior y lo tapaba por 3 px a 375 px, y el ajuste lo mide en el origen.

El texto de los controles queda centrado ópticamente en las dos páginas: 90 de 90 medidas dentro del criterio (−1,57 a +1,54 px de dispositivo; la base, de −6,94 a −2,50), con altos y posiciones idénticos a la base y 0 píxeles distintos fuera de los controles a 1280 px. Los mecanismos:
- `text-box` en la regla de cada control o en un elemento propio para el texto, donde iba suelto en un flex;
- `--compensa-recorte`, con `lh` y `cap`;
- relleno asimétrico en los `<select>`, que ignoran `text-box`.

Todo se publicó en `docs/` (PUB). FASE R confirmó las 32 afirmaciones con instrumentos distintos y registró 15 advertencias. Las prioritarias: sin soporte de `text-box` las cajas crecen (R-33), y en Safari los botones de Nivel y Prueba pueden no recortarse (R-34). Veredicto: APROBADO CON ADVERTENCIAS.

### 2. Inventario de commits (`git log --oneline 476b1e1^..HEAD`)

```text
2a719b1 deploy(docs): tooltip dentro de la ventana y centrado optico de los controles
fa89e7c fix(sitio): texto de los controles centrado opticamente con text-box (gobCL-sitio)
6f74d70 fix(motor): ajuste del tooltip tras la medicion (TT)
476b1e1 fix(motor): el tooltip se ubica dentro de la ventana; encargo s35f y ERR-35-18
```

Más el commit de este log (`docs(log): tooltip y centrado optico (s35f)`), cuyo hash va en el reporte final.

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-47).

### 4. Invariantes

I-1 a I-8 en PASA en el estado final `2a719b1` (FASE R, R.3), con re-derivaciones por otra vía (R.2). En ningún cierre de tarea un 🔒 dio FALLA.

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 del encargo (f63b70885577620991f8d6fdd8244ffd, verificado).
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión con Rscript y chromote, Chrome 153)

- Tooltip, casos pedidos (28): base, 22 fuera de la ventana, `right` 1.433 a 1280 px y 536,25 a 375 px, panel en 4 de 14 clics; final, 0 fuera y 0 del lado incorrecto, panel en 14 de 14. Barrido de 240 hovers: 0 fuera. Re-derivación en tres tamaños nuevos (84 casos): base 50 fuera; final 0, panel en 42 de 42.
- Centrado (90 medidas, px de dispositivo, |arriba − abajo|): base, de −6,94 a −2,50 (calibración: territorio −4,77, «4° Básico» −3,70); intento 1, 86 de 90; final, 90 de 90, de −1,57 a +1,54. Re-derivación a DSF 3 con tinta aislada: 80 de 80 dentro de ±1 px CSS (base 0 de 80), y por maquetación una diferencia de 0,0000 px CSS en los 74 elementos recortados.
- Altos y posiciones de los controles: Δ 0 en las 90 medidas. Píxeles fuera de los controles a 1280 × 900: 0, 0 y 0.
- I-8: 12 de 12 antes y después.
- Salidas finales: motor 65f2f59bcccd8da57e0aa4aa07a2533c, vista 713dfa9d1e6750b8562ff0300179b53a; `docs/` igual (blobs 995a3f28… y b625058e…); JSON del motor y `DATA` de la vista idénticos a la base (sha256 7967dfa07a99ef11); `simce_comunal.parquet` 468099a9c63bb3c0ddb74e67e2c7c19f sin cambio; batería 32/32.
- `docs/` antes: 601df6d7… y 1067908e…; después: 65f2f59b… y 713dfa9d….

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno.

Dudas, cada una con pregunta cerrada (las dos primeras son prioritarias):
- Q-59 (R-33). Sin soporte de `text-box` (Safari < 18.2, Firefox < 154, Chrome < 133), la compensación agranda el menú y los botones entre 4,5 y 6,8 px. ¿Se guarda la compensación con `@supports (text-box: trim-both cap alphabetic)` en un encargo propio? (sí / no)
- Q-60 (R-34). Tras revisar en Safari los botones de Nivel y Prueba: si crecieron o el texto sigue alto, ¿se pone su texto en `<span class="control-texto">` con `display: block`, como en los `.btn`? (sí / no)
- Q-54 (R-38). A 375 px, cuando el tooltip no cabe en ningún lado, tapa el punto. ¿Se prueba ubicarlo arriba o abajo del punto en ese caso? (sí / no)
- Q-55 (R-41). A 375 px el modal «Agregar territorio» desborda la ventana (previo). ¿Se corrige en un encargo propio? (sí / no)
- Q-56 (R-35). Chrome deja un desvío de hasta ±0,5 px CSS por ubicar la línea base en píxeles enteros. ¿Se acepta como límite del centrado? (se acepta / medir en Safari con un medidor propio)
- Q-57 (R-42). ¿Se centran también los controles fuera del inventario (pestañas y campo del modal, rótulos de exportar, «Ver establecimientos» del tooltip)? (sí / no)
- Q-58 (R-40). ¿Se mueve el `<span class="tx">` de los botones de cohorte a `36_generar_trayectorias.R` y se quita la reescritura del script de la vista? (sí / no)

Pendientes fuera del encargo:
- la revisión en Safari (§10);
- el reemplazo del selector nativo (§11), si el ajuste no alcanza en Windows;
- los excluidos de §11 (Q-42, Q-43, Q-51, Q-52, Q-34, Q-21, `OP_PREVIO`, Q-29, Q-31, Q-39, v30-5, Museo Sans, pendientes 8, 10, 12 y 13 de v34);
- CLAUDE.md (D2; no se creó: `.gitignore` lo excluye y el ALCANCE es cerrado).

`# REVISAR` nuevos: ninguno (`git diff 476b1e1..HEAD | grep -c "^+.*REVISAR"` = 0).

### 8. Errores propios consolidados

- FASE TT: cité tres números de línea de memoria y los corregí en el log antes de cerrar la sección (R-47).
- Medidor de TB, corregidos antes de registrar resultados:
  - `seq()` con índices negativos;
  - el bloque principal corría al cargarse con `source()`;
  - supuse que el modal abría en la pestaña «Comuna»;
  - la franja central de la V y de la d no tiene tinta arriba;
  - el umbral fijo de tinta tenía un sesgo, y el umbral bajo leía el borde de la caja;
  - la primera versión de `plano.R` leía el fondo de la página como tinta.
- Ninguno de estos errores tocó el producto. La falla del intento 1 de TT venía del cambio del asistente (T0); las dos del intento 1 de TB, de mi primera versión, y se corrigieron en el intento 2.

### 9. Notas para el revisor

- Revisar en Safari (18.2 o superior), idealmente con una ventana de 1280 px y un iPhone:
  - **los botones de Nivel y Prueba del motor (R-34)**: que su alto sea el de antes y el texto quede centrado;
  - el menú de las dos páginas;
  - el selector «Territorio» (probar un nombre con acentos y descendentes, como «Concepción»);
  - los controles de la vista (cohortes, selectores, «Cobertura», «Notas metodológicas»);
  - el tooltip en la última columna y en la última fila visible, en hover y fijado, y «Ver establecimientos».
- Si hay acceso a un navegador sin `text-box` (Firefox ESR o Safari < 18.2), el menú y los botones se verán 4,5 a 6,8 px más altos (R-33).
- Capturas antes y después en `_archivo/20260925_capturas_s35f/` (1280 × 900, DSF 2): encabezado del motor, selector de territorio y menú y controles de la vista.

### 10. Estado de cierre

- **Commiteado:** 4 commits del encargo (T0, TT, TB, PUB) más el de este log, en `main`.
- **Condiciones de publicación medidas antes del commit de este log** (autorización 4):
  - veredicto de FASE R `APROBADO CON ADVERTENCIAS`;
  - `git fetch origin` fetch_codigo=0; `origin/main` = `c1e2047`;
  - `git merge-base --is-ancestor origin/main HEAD` ancestro_codigo=0; 4 commits por publicar;
  - md5 de `docs/` = 65f2f59bcccd8da57e0aa4aa07a2533c y 713dfa9d1e6750b8562ff0300179b53a, iguales a los de PUB;
  - `git status --porcelain` = solo este log, que queda vacío con su commit.

  El `git push origin main` se corre después de este commit, con `status`, `fetch` y `merge-base` medidos otra vez. Su resultado y el de P3 (lo que sirve Pages) van en el reporte final.
- **Queda al titular:** la revisión en Safari (§9) y las dudas Q-54 a Q-60.
- **Hash de `docs(log)`:** se informa en el reporte final (`git log -1 --format=%h`).
- **Verificación del archivo** (antes del commit): `grep -c '^### FASE'` = 5 (FASE 0, TT, TB, PUB y R; FASE L es este «Cierre» y P3 va al reporte final); `grep -c '^esperado:'` = `grep -c '^obtenido:'`; `grep -c '^## J'` = 1, con el bloque relleno; privacidad sin coincidencias. Los conteos exactos, en el reporte final.
