# Log: pantallas angostas, centrado restante y fuente del PNG (s35h) (slep_simce_adecuado)

- Meta: que el motor se lea y se use a 375 px (modal y supergrid), que los controles que faltaban queden centrados con la misma guarda `@supports`, que el PNG salga con gobCL, y que la vista mida bien la tarjeta al cambiar de ancho y no deje el plano angosto; todo publicado en Pages.
- Fecha: 2026-09-26 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: (se completa en H4, commit de T0)
- Encargo: `50_documentacion/activa/encargos/encargo_pantallas_angostas_s35h.md`, md5 `697919992d09c443f9e0ee55e6f263cc` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`); el harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y prevalece: sin subagentes ni Workflow; todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, M1, M2, M3, M4, V1, V2, PUB, FASE R, FASE L con el push, P3 y su commit (autorización 8).
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Navegador de medición: Google Chrome 153.0.8010.53 (`chromote`), headless; R 4.5.2.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: el motor se lee y se usa a 375 px (modal: 0 elementos visibles fuera de la ventana en 12 casos; supergrid: 0 textos fuera de su celda con 1, 2, 4, 5 y 6 territorios); los controles de Q-57 quedan centrados solo con `text-box` (28/28 dentro de ±2 px; sin soporte, los altos de antes); el PNG sale con gobCL (22/22 mediciones con la tinta de gobCL-sitio); la vista mide la tarjeta al cambiar de ancho (6/6) y no deja el plano angosto (36/36 ≥ 384 px de 823 a 1023). Todo copiado a `docs/` (PUB). El push y lo que sirve Pages van en la sección FASE P3.
- Estado por tarea: FASE 0 completa (H6 con la salvedad D0-a) · T0 completa · M1 completa (intento 2) · M2 completa (intento 1) · M3 completa (intento 1) · M4 completa (intento 1) · V1 completa (intento 1) · V2 completa (intento 1) · PUB completa · FASE R: 0 BLOQUEA, 0 REPARA, 12 ADVIERTE.
- Commits: b3cc432 (T0, punto de retorno), df73a45 (M1), a653259 (M2), 52bab39 (M3), 206cb3a (M4), 1458285 (V1), 0f06bc8 (V2), 78abd6b (PUB), más docs(log) y docs(log): P3 de s35h (hashes en FASE P3 y en el reporte final).
- Auditoría (FASE R): sin subagentes. El orquestador re-derivó las 38 afirmaciones con instrumentos distintos: Python, `hash-object`, DSF 3, CSSOM, `scrollLeft`/`offsetLeft`, `scrollWidth` de celdas, lectura en R del PNG descargado, otros anchos, altos y pares. Resultado: 38 CONFIRMADA, 0 REFUTADA; los controles positivos dispararon; R-39 a R-50 ADVIERTE; veredicto APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-10 PASA en el estado final 78abd6b (I-10 tras corregir el simulador, que tomaba como CSS un `<style>` del JavaScript de M4).
- Cifras críticas: modal fuera 19-51 → 0; supergrid, columnas 64,75 → 112 px, sparklines 42,75 → 90 px, textos fuera 45/64 → 0; Q-57 25/26 fuera → 28/28 dentro; PNG «VIÑA DEL MAR» 205 (`system-ui`) → 177 (gobCL-sitio), título 801 → 705; `--cardw` 640 → 1024 de 437 → 317 (carga nueva 317); plano a 823 con la 2027 de 179 → 709 (una columna), `ANCHO_PLANO_MIN` 384; `docs/` de 7f5971a3…/523ce765… → fe30d56f…/69357a69…; JSON sha256 7967dfa07a99ef11 sin cambio.
- Decisiones autónomas de mayor riesgo: D0-a (seguir pese al md5 de H6, que difería solo por la fecha de generación, pasada la medianoche); D0-c (6 territorios medidos en una copia con el tope en 6); D0-d (ancho del texto del PNG como tinta contra tinta); D-M3-a («Ver establecimientos» 27 → 24 px con soporte); D-M3-b (posición del inventario evaluada contra el build de M2); D-V2-a (el ancho disponible resta el relleno y el borde del panel); D-V2-d/e (la regla vale en cualquier ancho y a 823 px cambia 7 de 9 cohortes).
- Desviaciones respecto del encargo: H6 con md5 distinto por la fecha (D0-a); el criterio de 6 territorios medido en una copia con el tope en 6 (el motor admite 5); «posición igual a la base» de M3 leída como «M3 no mueve nada» (contra el build de M2), porque M1 y M2 mueven 5 controles a 375 px a propósito; CLAUDE.md sin crear (regla global frente a `.gitignore` y a un ALCANCE cerrado; D2). Ninguna en tolerancias ni en el ALCANCE.
- Dudas abiertas: Q-63 (tope de 5 territorios), Q-64 (seis cohortes a 823 px en una columna por 4-12 px), Q-65 (`rebuild()` mide la tarjeta desde el ancho anterior, previa), Q-66 (supergrid de 641 a ~686 px con 5 territorios, previa).
- Errores propios: 5 en instrumentos y 1 en el producto antes del commit (una constante declarada dos veces: el build falló sin escribir salidas). Todos se corrigieron antes de registrar resultados o de commitear, y ninguno tocó lo publicado.
- Qué debe verificar el revisor por sí mismo: en un teléfono real, el modal y el supergrid al tacto; en Safari 18.2+, el centrado de Q-57 y un PNG exportado (que salga con gobCL y sin el aviso «No se pudo generar el PNG»); la vista de 823 a 1023 px con la 2027; las capturas de `_archivo/20260925_capturas_s35h/`.
- No publicado / queda al usuario: la revisión en Safari y en un teléfono; Q-63 a Q-66. El push y P3, en la sección FASE P3.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite aunque el harness tenía «ultracode» activo); medición en Chrome 153 sin cabeza; sin WebKit ni Firefox en la sesión.

### FASE 0: log, punto de retorno y premisas

Paso 1: log creado antes de H1. Por eso H1 muestra también la línea del propio log. Carpeta de trabajo: `$TMPDIR/cal_s35h/` (instrumentos y salidas); base de H6 en `$TMPDIR/base_s35h/`.

**H1.** `git -C "$RAIZ" status --porcelain`
esperado: exactamente ` M …/20260924_decision_referente_traspasos.md`, ` M …/20260924_sesion35_errores_asistente.md` y `?? …/encargo_pantallas_angostas_s35h.md`, más el log
obtenido:
```text
 M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
 M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_pantallas_angostas_s35h.md
?? 50_documentacion/andamios/logs/20260925_pantallas_angostas_s35h_log.md
```

**H2.** `git -C "$RAIZ" stash list | wc -l`
esperado: 0
obtenido: 0

**H3.** `git -C "$RAIZ" fetch origin` (fetch_codigo=0), luego `git -C "$RAIZ" rev-parse --short HEAD` y `git -C "$RAIZ" rev-parse --short origin/main` en dos comandos
esperado: cefa729 y cefa729
obtenido: cefa729 y cefa729

**H4.** `md5 -q` del encargo y de `docs/`; además `md5 -q` de `40_salidas/`, de `10_utils/fuentes/*.otf`, el conteo de I-7 y `grep -c '@supports'` en las tres plantillas
esperado: encargo 697919992d09c443f9e0ee55e6f263cc (mensaje de entrega); `docs/` 7f5971a3… y 523ce765…; fuentes a7407ed6… y 0257bb4b…; 28; `@supports` 7 (motor), 4 (vista) y 3 (fragmento)
obtenido: 697919992d09c443f9e0ee55e6f263cc; `docs/index.html` 7f5971a3a99b24540ee797b9c1966a0c, `docs/trayectorias.html` 523ce765359e1cb1ee080b3fe557c93b (iguales en `40_salidas/` antes de H6); a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc; 28; `@supports` 7, 4 y 3

**T0.** `git add` de las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la octava ola y decisiones D35-11 a D35-13"`
esperado: un commit con el encargo, el archivo de decisiones y el log de errores
obtenido: `b3cc432 docs(sesion 35): encargo de la octava ola y decisiones D35-11 a D35-13`, padre `cefa729`; `git show --name-status` = `M …/20260924_decision_referente_traspasos.md`, `A …/encargo_pantallas_angostas_s35h.md`, `M …/20260924_sesion35_errores_asistente.md`; `git status --porcelain` = solo este log. **Punto de retorno: b3cc432.**

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R` (salida en `$TMPDIR/cal_s35h/h5.txt`; código leído sin tubería)
esperado: 33 en PASA, código 0
obtenido: codigo_bateria=0; «Resultado: 33 pruebas, 33 pasan, 0 fallan»

**H6.** `cd "$RAIZ" && Rscript 00_build.R` (salida en `$TMPDIR/cal_s35h/h6.txt`)
esperado: código 0, y salidas con md5 iguales a `docs/` (build reproducible, como en s35g)
obtenido: codigo_build=0; «Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 6 segundos». Vista 523ce765359e1cb1ee080b3fe557c93b (= `docs/`). Motor **d9e80e91578db1ebe918f0a295ae6d6b** (≠ 7f5971a3…). `simce_comunal.parquet` 468099a9c63bb3c0ddb74e67e2c7c19f.

Causa de la diferencia del motor (`$TMPDIR/cal_s35h/h6_diff.R`: el HTML sin el bloque de datos, byte a byte, y el JSON decodificado)
esperado: (sin esperado previo; se registra)
obtenido: «fuera del bloque de datos, idéntico: TRUE | largo 832053 832053»; «fecha_generacion hoy: 2026-09-26 | docs: 2026-09-25»; «JSON sin fecha_generacion, identical: TRUE»; «texto JSON: largo 13597248 13597248 | caracteres distintos: 1». La única diferencia es `meta$fecha_generacion` (`format(Sys.Date())`, `33_generar_html.R:200`): la sesión empezó a las 00:48 del 2026-09-26 y el motor publicado se construyó el 2026-09-25. Decisión D0-a (abajo): H6 se da por cumplido, con el build reproducible por contenido.

Las dos salidas se copiaron a `$TMPDIR/base_s35h/` (md5 d9e80e91… y 523ce765…): es la base de H6. `verificar_contenido_motor.R` apuntaba a `$TMPDIR/base_s35g/`: se apuntó a `$TMPDIR/base_s35h/` (línea 24 y comentarios de las líneas 3 y 12). El comparador de I-4 se copió a `$TMPDIR/cal_s35h/i4_data_vista.R`, con la base en `$TMPDIR/base_s35h/`.

Calibración de I-3 e I-4 (`alterar_json_motor.R` e `i4_data_vista.R --alterar` sobre la base de H6)
esperado: «idéntico» sobre el build y sobre la base; «difiere» con un número alterado
obtenido: motor «fragmento original: 3.5 -> alterado: 3.6»; build codigo_actual=0 «JSON idéntico a la línea base»; base codigo_base=0 «idéntico»; `docs/index.html` codigo_docs=0 «idéntico»; copia codigo_alterado=1 «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)». Vista «fragmento original: 23.9 -> alterado: 23.8»; build «identical: TRUE» (codigo 0); copia «identical: FALSE» (codigo 1). **Disparan.**

Capturas de I-9 (`$TMPDIR/cal_s35h/capturas.R`, modo `inicial`: las tres vistas en su estado inicial a 1280 × 900 y 1440 × 900, página completa a DSF 1 y ventana de arriba a DSF 2; barras superpuestas; espera de 3 s tras `document.fonts.ready`), dos cargas independientes (`$TMPDIR/base_s35h/cap_a/` y `cap_b/`), comparadas con `$TMPDIR/cal_s35h/comparar.R`
esperado: 0 píxeles distintos entre las dos cargas
obtenido: 12 capturas por carga; `cap_a` contra `cap_b`: 0 píxeles distintos en las 12 (páginas de 3.601, 1.289 y 1.119 de alto a 1280; 3.708, 1.339 y 1.119 a 1440). **Base determinista.**

**Paso 8. Mediciones de partida.**

*M1* (`$TMPDIR/cal_s35h/m1_medir.R`, base de H6; `m1/base.txt`). A 375 × 740 y 414 × 896, modal abierto; cada pestaña se trae a la vista con `scrollIntoView` y se activa con un clic real (`Input.dispatchMouseEvent`) en su centro. Por pestaña: elementos del modal (el `.modal` y sus descendientes con caja) con `left < 0` o `right > innerWidth`, con la caja sin recortar («crudo») y con la caja recortada por los antepasados del modal que recortan su desborde («visible»; una caja oculta del todo dentro de un contenedor con desplazamiento no está en pantalla). Además: «interno» (elementos fuera de `.modal-tabs` cuya caja se sale del `.modal` a los lados), desplazamiento lateral de `.modal-body`, pie «Cancelar / Agregar» dentro del modal y de la ventana, y `scrollWidth` del documento.
esperado: al menos 1 elemento fuera a 375 (R-41 de s35f)
obtenido: fuera (visible) a 375: Establecimiento 19, Comuna 26, SLEP 50, Región 51, Nacional 22, Grupo personalizado 22; a 414: 19, 26, 47, 44, 21 y 37 (crudo de 19 a 1.054). El `.modal` mide 540 px (`min-width`) y queda en x = −82,5 a 375 y −63,0 a 414; el campo de la pestaña «Comuna» en x = −60,5 (R-41 de s35f). Pie visible 0 de 12. A 375 el centro de «Establecimiento» cae fuera de la ventana (no se puede pulsar) y «Grupo personalizado» no se activa con el clic (el `scrollIntoView` desplaza el modal, que tiene `overflow: hidden`): pestaña activa tras el clic en 11 de 12. `.modal-tabs` mide 573 a 578 px dentro de un modal de 540. `scrollWidth` del documento = ancho en 12 de 12. **Dispara.**

Capturas del modal a 768 y 1280 px en las 6 pestañas (`capturas.R` modo `modal`, ventana de 900 de alto, DSF 1), dos cargas (`$TMPDIR/base_s35h/modal_a/` y `modal_b/`)
esperado: 0 píxeles distintos entre las dos cargas
obtenido: 0 en las 12. **Base determinista.**

*M2* (`$TMPDIR/cal_s35h/m2_medir.R`, base de H6; `m2/base.txt`). Por ancho y número de entidades (menos de 4: se quitan con «Eliminar»; más de 4: se agregan por la pestaña «SLEP» del modal, las primeras casillas habilitadas): anchos de columna (`gridTemplateColumns` calculado), ancho de cada `svg.sparkline-svg`, y cada nodo de texto HTML del supergrid (fuera de los SVG) con alguna caja de línea (`Range.getClientRects()`) que supera el borde de su celda (el hijo directo de `.supergrid` que lo contiene). «Requerido» de cada caja de línea: lo que ocupa desde el borde izquierdo de su celda más el relleno y el borde derechos de la celda.
esperado: a 375 px, estado inicial (4 entidades), al menos 2 textos que superan su celda (Q-19 de s35b)
obtenido: 4 columnas de 64,75 px; 14 sparklines de 42,75 px; **45 de 64 textos** superan su celda (PUCHUNCAVÍ +42,91, QUINTERO +19,33, CONCÓN +7,33; «Últimas 3 aplicaciones» +30,45 y «Trayectoria histórica» +21,95 en cada celda; «Medio bajo», «Medio», «Medio alto» +19,66; «Bajo» +6,30); textos SVG fuera de su celda 0; `scrollWidth` del documento 375. **Dispara.**

Otros casos de la base (información para el criterio de M2):
- 375 px: 1 entidad, columna 295, sparkline 273, 0 textos fuera; 2, 141,5 y 119,5, 0; 5, 49,39 a 49,41 y 27,39 a 27,41, 62 fuera, documento **381** px.
- 414 px: 1, 334 y 312, 0; 2, 161 y 139, 0; 4, 74,5 y 52,5, 40 fuera; 5, 57,19 a 57,20 y 35,19 a 35,20, 58 fuera, documento 414.
- 6 entidades (copia con el tope en 6, ver D0-c; `m2/base_tope6.txt`): 375 px, columnas de 39,16 a 39,17, sparklines de 17,16 a 17,17, 75 de 96 fuera, documento **391**; 414 px, 45,66 a 45,67 y 23,66 a 23,67, 74 fuera, documento **424**. Con 5 y 6 entidades la página ya desborda a 375 (y con 6, también a 414).
- Nombres: CONCÓN, PUCHUNCAVÍ, QUINTERO y VIÑA DEL MAR (estado inicial); la quinta y la sexta son SLEP Aconcagua y SLEP Andalién Costa.

Valor de `--supergrid-col-min` (paso 1 de M2): el texto más ancho del supergrid a 375 px en el estado inicial es PUCHUNCAVÍ (`.sg-ent-name`, 18 px, 800), de 103,66 px; el relleno de su celda (`.supergrid-entity-head`, 4 + 4 px) da 111,66 px, redondeado hacia arriba **112 px**. Es también el mayor «requerido» de los 64 textos (le siguen «aplicaciones», 106,20 con el relleno de 22 px de `.chart-cell` y los 2 px de `.sub-eyebrow`, y «Trayectoria», 97,70). Con 112 px, cada sparkline mide al menos 112 − 22 = 90 px.

*M3* (`verificar_centrado.R` ampliado: conjunto `q57`, ver D0-e; base de H6; `m3/base_q57.txt`). Pestañas del modal (la activa, «Comuna», y las 5 inactivas), el campo de búsqueda de la pestaña «Comuna» (marcador de posición «Buscar comuna…»), el rótulo de cada botón de exportar con foco (`focus({ focusVisible: true })`: 3 en `#comparacion` y 3 en `#panorama`) y «Ver establecimientos» del tooltip fijado (clic real en el primer punto de la primera sparkline). Desvío arriba − abajo en px de dispositivo, a 1280 y 375 px.
esperado: se registra; al menos uno fuera de ±2 px de dispositivo
obtenido: 28 medidas, 26 con valor, 25 fuera de ±2:
- 1280: campo −3,30; pestañas −3,72, −3,60 (activa), −3,61, −3,33, −3,72, −3,71; exportar en comparación −5,22, −5,21, −5,16; «Ver establecimientos» +2,82; exportar en panorama −4,98 (×3).
- 375: campo y «Establecimiento» sin medida (fuera de la ventana: el modal desborda); pestañas −3,61 (activa), −3,61, −3,33, −3,72, −3,60; exportar en comparación −5,17, −5,17, −7,09; «Ver establecimientos» +0,52 (el único dentro); exportar en panorama −7,36 (×3).

**Dispara.**

Inventario de s35f sobre la base, con el medidor ampliado (`m3/base_inv2.txt`)
esperado: 90 de 90 dentro de ±2 (el estado de s35g); las medidas del medidor de s35g sin cambio
obtenido: «90 controles medidos | en criterio 90 | fuera 0»; dif de −1,57 a +1,54; contra la medición con el medidor anterior (misma base): «dif idéntico: TRUE | máx |Δ dif| 0 | alto idéntico: TRUE».

*M4* (`$TMPDIR/cal_s35h/m4_medir.R`, base de H6, ventana de 1280 × 900; `m4_base.txt`, archivos en `m4/base/`; ver D0-d). En cada exportación (supergrid y panorama) se guardan los `Blob` que crea la página (el SVG interno que `rasterizarSvgAPng()` carga como imagen y el PNG que recibe `descargarBlob()`), más el archivo descargado. Ancho del texto en el PNG: la caja de los píxeles que cambian al rasterizar en la página (igual que la app) el mismo SVG sin ese `<text>`, dentro de una ventana alrededor del texto. Referencias a `PNG_SCALE` (2): (a) `getComputedTextLength()` de un `<text>` con los mismos atributos y `font-family` «gobCL-sitio» o «system-ui» (avance); (b) la tinta del mismo texto con `fillText` en un lienzo a escala 2 con cada familia.
esperado: el PNG coincide con `system-ui` (confirma la hipótesis de §2), y los dos anchos de referencia difieren en más de 4 px de PNG
obtenido (px de PNG; PNG / tinta gobCL-sitio / tinta system-ui / avance gobCL-sitio / avance system-ui):
- supergrid, nombre «VIÑA DEL MAR» (el más largo de los cuatro; 14 px, 800): 205 / 177 / 205 / 176,81 / 205,47;
- supergrid, título «Motor Simce — Adecuado · Lectura · 4° Básico» (18 px, 800): 801 / 705 / 801 / 706,84 / 802,91;
- panorama, rótulo «Lectura» (14 px, 800; el panorama no tiene un `<text>` solo con el nombre del territorio): 104 / 89 / 104 / 90,59 / 107,19;
- panorama, título «Panorama territorial · SLEP Costa Central · 4° Básico» (18 px, 800): 912 / 800 / 912 / 802,88 / 913,97.

En los 4 textos el PNG es igual a la tinta de `system-ui` (diferencia 0) y está a 15-112 px de gobCL-sitio; los avances de las dos familias se separan 16,60 a 111,09 px (> 4) y el PNG queda siempre más cerca del avance de `system-ui`. Tres exportaciones seguidas del supergrid dan lo mismo. Sin `<style>` ni `@font-face` en el SVG interno; SVG interno = SVG exportado (md5 5149473c… en el supergrid, 78fee2e0… en el panorama); PNG 5dbe882b… y 01ac5653…; 0 diálogos, 0 errores de consola, 0 solicitudes de red. Instrumento: al rasterizar en la página el SVG sin cambios se obtiene el PNG exportado exacto (0 píxeles distintos), y al quitar un texto cambian además 1 o 2 píxeles aislados lejos de él; por eso la caja se mide en una ventana alrededor del texto (ver errores propios). **Confirma la hipótesis y discrimina.**

*V1* (`$TMPDIR/cal_s35h/v_medir.R v1`, base de H6; `v/v1_base.txt`). Por par A → B y cohorte (inicial, 2018, y 2027): carga a A, cohorte, cambio a B sin recargar (`setDeviceMetricsOverride`), `--cardw`; contra una carga nueva a B con la misma cohorte.
esperado: al menos un par distinto (R-32 de s35d)
obtenido: 640 → 1024: inicial 437 (tras el cambio) contra 317 (carga nueva), 2027 540 contra 522; 1280 → 900: 317 = 317 y 522 = 522; 900 → 1280: 317 = 317 y 522 = 522. **2 de 6 pares distintos: dispara.**

*V2* (`v_medir.R v2`, base de H6; `v/v2_base.txt`). A 823, 900, 960 y 1023 px de ancho y 900 de alto, carga nueva por cohorte (las 9 de `#c-coh`), ancho y alto de `svg.chart`.
esperado: la 2027 queda bajo el mínimo de la cohorte inicial en al menos un ancho (R-31 de s35d)
obtenido: mínimo con la cohorte inicial (2018): **384,00 px, a 823** (461, 521 y 584 a 900, 960 y 1023): **`ANCHO_PLANO_MIN` = 384**. La 2027 queda bajo ese mínimo en los 4 anchos (179, 256, 316 y 379). Además, a 823 px quedan bajo 384 otras seis cohortes: 2020 (380), 2024 (377), 2025 (379), 2026 (379), 2028 (378) y 2029 (372); 2021 da 396. Alto del plano 360 en los 36 casos; `scrollWidth` = ancho en 36 de 36. **Dispara.** (Las seis cohortes de 823 px quedan como duda Q-64; la regla de V2 se aplica tal como la fija el encargo.)

**Compuerta de dudas previa al acto público** (SETTINGS §2.1, gatillo 2). Dudas abiertas antes de publicar y la tarea que mide cada una: ¿el modal cabe a 375 px? → M1; ¿el supergrid se lee sin desbordar la página? → M2; ¿los controles de Q-57 quedan centrados solo con soporte? → M3; ¿el PNG sale con gobCL? → M4; ¿`--cardw` se vuelve a medir al cambiar de ancho? → V1; ¿el plano deja de quedar angosto? → V2; ¿lo publicado es idéntico a lo construido? → PUB; ¿Pages lo sirve? → P3.

**Cierre de FASE 0.**
- Estado: completa. H1 a H5 dan lo esperado; H6 con la salvedad de D0-a; las seis calibraciones disparan.
- Commits: `b3cc432` docs(sesion 35): encargo de la octava ola y decisiones D35-11 a D35-13 (T0, punto de retorno).
- Cambios sustantivos: ninguno en el producto. `verificar_contenido_motor.R` (ignorado) apunta a `$TMPDIR/base_s35h/`; `verificar_centrado.R` (ignorado) ampliado (D0-e).
- Alcance: T0 tocó solo sus tres rutas.
- Regresión: H5 y H6 son la regresión de partida.
- Subagentes: ninguno (el encargo no los admite).
- Bugs: ninguno.
- Decisiones autónomas:
  - D0-a (riesgo medio): el motor de H6 difiere de `docs/` solo en `meta$fecha_generacion` (1 carácter del JSON; el resto del HTML es idéntico byte a byte). Es el efecto conocido del md5 del motor que cambia de un día al siguiente: la sesión empezó pasada la medianoche. Leí la regla de detención de H6 («batería o build fallan») como falla del build o de su reproducibilidad, no como un cambio de fecha. Por eso no detuve la sesión y registro el esperado literal (md5 igual) como no cumplido. Efecto: todas las salidas de hoy llevan la fecha 2026-09-26; la base de comparación es este build, así que las comparaciones de la sesión no dependen de la fecha.
  - D0-b (riesgo bajo): en M1, «fuera de la ventana» se evalúa con la caja visible, recortada por los antepasados del modal que recortan su desborde. La fila de 6 pestañas con desplazamiento propio, que pide el encargo, deja por construcción pestañas fuera de la ventana en la caja sin recortar, pero no en pantalla: es el mismo criterio que s35b usó con `.table-wrap`. Se informan también la cuenta cruda, la del contenido que el modal cortaría («interno») y el desplazamiento lateral del cuerpo.
  - D0-c (riesgo medio): el motor admite hasta 5 territorios (`MAX_ENTIDADES = 5`, L1789), y el criterio de M2 pide 1, 2, 4 y 6. Se mide 5 en el producto y 6 en una copia de la salida con el tope en 6. La copia cambia un solo byte, `var MAX_ENTIDADES = 5;` → `6;` (md5 de la copia de la base: 0bf69044…). El dibujo del supergrid no depende del tope. Queda como duda Q-63.
  - D0-d (riesgo medio): en M4, el ancho del texto en el PNG es su tinta, y el criterio de ±2 px compara tinta con tinta: la del PNG contra la de cada familia. El avance de `getComputedTextLength()` incluye los márgenes laterales de los glifos: en «Lectura», el PNG (104) está a 3,19 px del avance de `system-ui` (107,19), la familia con que se dibujó. Por eso el avance se informa y se usa para la separación de las dos familias (> 4 px), no para el ±2.
  - D0-e (riesgo bajo): cambios del medidor de centrado, calibrados sobre la base:
    - conjunto `q57`, con una rama para `<input>` que mide su valor o su marcador de posición con el lienzo, como el `<select>`;
    - `MARGEN_BORDE_DISP` = 1: se salta una fila de dispositivo junto a cada borde. Chrome pintaba el borde del campo una fila más adentro que la caja, y con el gris claro del marcador esa fila se leía como tinta (arriba 0,31). El inventario queda idéntico: dif y alto iguales en 90 de 90;
    - el anillo de foco de los botones de exportar (outline auto, azul) se vuelve transparente solo durante la medición. Cubría el borde y se leía como tinta (arriba 0,19, abajo 0,81). El contorno no ocupa espacio, así que el rótulo no se mueve.
  - D0-f (riesgo bajo): el «relleno de la celda» de `--supergrid-col-min` es la distancia de la caja de línea del texto a los bordes de su celda (4 + 4 px en la cabecera de entidad). Con el relleno de `.chart-cell` (22 px), el mayor requerido sería el de «aplicaciones» (106,20), menor que el de PUCHUNCAVÍ: el valor es el mismo, 112.
- Errores propios (en instrumentos, corregidos antes de registrar resultados):
  - `m4_medir.R` usaba `ti[-seq_len(n)]` con n = 0, que en R da un vector vacío: no hallaba el Blob del SVG;
  - la primera caja de diferencias de M4 tomaba 1 o 2 píxeles aislados lejos del texto; se acotó a una ventana alrededor del texto;
  - el medidor de centrado leía como tinta el borde del campo y el anillo de foco (D0-e).
- Dudas: Q-63 (tope de 5 territorios) y Q-64 (seis cohortes bajo `ANCHO_PLANO_MIN` a 823 px), en el cierre.

### FASE M1: el modal cabe a 375 px (Q-55)

- Estado: completa, en el segundo de 3 intentos.
- Commits: `df73a45` fix(motor): el modal de territorio cabe en pantallas angostas (Q-55).

**Cambios** (dentro del `@media (max-width: 640px)` que ya tenía el motor, L1183; sobre 640 px nada cambia):
- `.modal { min-width: 0; width: 100%; }`: el modal toma el ancho del fondo, dentro de su relleno de 20 px.
- `.form-grid { grid-template-columns: minmax(0, 1fr); }`: el formulario en una columna.
- `.modal-tabs { overflow-x: auto; overflow-y: hidden; border-bottom: 0; box-shadow: inset 0 -1px 0 var(--border-1); }` y `.modal-tab { margin-bottom: 0; }`: las 6 pestañas siguen en una fila (`nowrap` de siempre) que se desplaza en horizontal dentro de sí misma.

Intento 1 (solo `overflow-x: auto` en `.modal-tabs`; parche en `$TMPDIR/cal_s35h/m1/intentos/M1_intento1.patch`, 18 líneas, md5 127503aaca5fbe73f8e40011094d0a6f; build motor a9e6dffe…): cumplía el criterio, pero la fila con desplazamiento recorta lo que sale de su caja. El subrayado de 2 px de la pestaña activa, que con el margen de −1 px montaba sobre el borde inferior de la fila, perdía la fila de abajo: 1 fila de color océano (346) a 375 px, contra 2 (346 y 347) a 1280 (`$TMPDIR/cal_s35h/m1/subrayado.R`). Intento 2: la línea inferior pasa de borde a sombra interior del mismo grosor y color, la pestaña deja el margen negativo, y `overflow-y: hidden` evita un desplazamiento vertical.

Build del intento 2 (`$TMPDIR/cal_s35h/m1/build_i2.txt`; salidas en `m1/i2/`)
esperado: código 0
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor 351d6e206bb77f764dc3e67d78a776c1, vista 523ce765… (sin cambio)

**Criterio: el modal dentro de la ventana** (`m1_medir.R` sobre el intento 2; `m1/i2.txt`)
esperado: a 375 × 740 y 414 × 896, en las 6 pestañas, 0 elementos del modal con `left < 0` o `right > innerWidth`, y `scrollWidth` del documento igual al viewport
obtenido: fuera (visible) 0 en los 12 casos (base: 19 a 51 por pestaña). El modal queda de x = 20 a 355 (375 px) y de 20 a 394 (414 px); el campo de «Comuna» en x = 42 (base −60,5). Crudo: 1 o 2 por caso, siempre pestañas ocultas dentro de la fila con desplazamiento (p. ej., con «Comuna» activa a 375: «Nacional» 376,92-434,00 y «Grupo personalizado» 458,00-593,48; la fila mide 619-624 px dentro de 335 o 374). Interno 0 (base: 11 y 357 en «Grupo personalizado»); `.modal-body` sin desplazamiento lateral (335/335 y 374/374). `scrollWidth` = ancho en 12 de 12. **Cumple.**

**Criterio: pestañas y pie** (mismo medidor)
esperado: cada pestaña se activa con un clic tras `scrollIntoView`; el pie «Cancelar / Agregar» visible dentro del modal
obtenido: el centro de cada pestaña, tras `scrollIntoView`, es la propia pestaña (`elementFromPoint`) en 12 de 12, y queda activa tras el clic real en 12 de 12 (base 11 de 12: «Establecimiento» fuera de la ventana y «Grupo personalizado» sin activarse, a 375); pie dentro del modal y de la ventana en 12 de 12 (base 0 de 12). **Cumple.**

**Criterio: sobre 640 px nada cambia** (`capturas.R` modo `modal`, 768 y 1280 px, 6 pestañas, contra `base_s35h/modal_a`)
esperado: 0 píxeles distintos
obtenido: 0 en las 12 capturas. **Cumple.**

Subrayado de la pestaña activa a 375 px (`subrayado.R`)
esperado: 2 filas de color océano (como a 1280 px), y la línea gris en la fila de abajo
obtenido: intento 2, filas 346 y 347 (intento 1: solo 346); en una pestaña inactiva, las filas 345 a 348 valen 255,255,255 | 255,255,255 | 231,223,201 | 255,255,255, iguales a las de 1280 en la base.

Comprobaciones adicionales:
- I-3 sobre el intento 2: «JSON idéntico a la línea base», codigo_I3=0.
- I-9 (`capturas.R` modo `inicial`, 1280 y 1440 px, contra `base_s35h/cap_a`): 0 píxeles distintos en las 12.

Capturas para el titular en `_archivo/20260925_capturas_s35h/` (ignorada; 375 × 900, DSF 1): `s35h_m1_modal_375_comuna_{antes,despues}.png` y `s35h_m1_modal_375_grupo_{antes,despues}.png`. Revisión visual: antes, el modal cortado a los dos lados; después, entero, con la fila de pestañas cortada a la derecha, que indica que sigue.

- PRUEBAS: build codigo 0; la batería y la regresión completa corren en PUB y en FASE R.
- Alcance: `git show --stat df73a45` = `30_procesamiento/33_motor_template.html` (+15), más las capturas en `_archivo/20260925_capturas_s35h/` (ignorada). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: 1 del intento 1 (el subrayado recortado), corregido en el intento 2.
- Decisiones autónomas: D-M1-a (riesgo bajo): el borde inferior de la fila de pestañas pasa a sombra interior de 1 px del mismo color bajo 640 px, y la pestaña pierde su margen negativo. Es lo mínimo para que la fila con desplazamiento, que pide el encargo, no recorte el subrayado. No agrega medidas: el grosor es el del borde que reemplaza.
- Errores propios: ninguno.
- Dudas: ninguna.

### FASE M2: el supergrid se lee a 375 px (Q-34 y Q-43)

- Estado: completa, en el primer intento.
- Commits: `a653259` fix(motor): el supergrid se lee en pantallas angostas (Q-34, Q-43).

**Cambios** (motor):
- `:root`: constante nueva `--supergrid-col-min: 0px` (sin mínimo en pantallas anchas).
- En el `@media (max-width: 640px)`: `:root { --supergrid-col-min: 112px; }` (FASE 0: PUCHUNCAVÍ, 103,66 px, más el relleno de su celda, 4 + 4 px, redondeado hacia arriba) y `.supergrid { overflow-x: auto; }`: el supergrid se desplaza en horizontal dentro de sí mismo.
- JSX del supergrid: `gridTemplateColumns: repeat(N, minmax(var(--supergrid-col-min), 1fr))` en vez de `minmax(0, 1fr)`. Sobre 640 px la variable vale 0 y la rejilla es la de antes.

Build (`$TMPDIR/cal_s35h/m2/build_i1.txt`; salidas en `m2/i1/`; copia con el tope en 6 en `m2/i1_tope6/`, un byte distinto, md5 87b8f080…)
esperado: código 0
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor 23d48830d8ed0b9fceb5e7a672cc8255, vista 523ce765… (sin cambio)

**Criterio: textos y sparklines** (`m2_medir.R` sobre el build, con 1, 2, 4 y 5 entidades, y sobre la copia con el tope en 6, con 6; `m2/i1.txt` y `m2/i1_tope6.txt`)
esperado: a 375 y 414 px, con 1, 2, 4 y 6 entidades, 0 textos del supergrid que superen el borde de su celda, y cada sparkline de ancho ≥ `--supergrid-col-min` − relleno de la celda (112 − 22 = 90 px)
obtenido:
- 375 px: 1 entidad, columna 295, sparklines 273, 0 de 14 textos fuera; 2, 141,5 y 119,5, 0 de 28; 4, 112 y **90**, **0 de 64** (base 45); 5, 112 y 90, 0 de 82 (base 62); 6, 112 y 90, **0 de 96** (base 75).
- 414 px: 1, 334 y 312, 0; 2, 161 y 139, 0; 4, 112 y 90, 0 de 64 (base 40); 5, 112 y 90, 0 de 82 (base 58); 6, 112 y 90, 0 de 96 (base 74).
- Holgura mínima de un texto a su borde −4,34 px (PUCHUNCAVÍ); textos SVG fuera de su celda: 0.

**Cumple.**

**Criterio: I-8, desplazamiento solo en el supergrid** (mismo medidor, y `$TMPDIR/cal_s35h/i8.R` a 375, 414, 540, 768, 1024 y 1280 px)
esperado: `scrollWidth` del documento igual al viewport; el desplazamiento vive solo en el contenedor del supergrid
obtenido: documento = viewport en los 10 casos de `m2_medir.R` (base: 381 con 5 entidades y 391/424 con 6). Supergrid, `scrollWidth/clientWidth` y `overflow-x`: 484/295 (4), 608/295 (5) y 732/295 (6) a 375 px; 484/334, 608/334 y 732/334 a 414; 295/295 y 334/334 con 1 y 2, que caben sin desplazarse. Sin desplazamiento vertical (`scrollHeight` = `clientHeight`). `i8.R`: «m2_i1 : I-8 PASA» (18 de 18) y «base : I-8 PASA». **Cumple.**

**Criterio: sobre 640 px nada cambia** (`capturas.R` modo `inicial` a 768, 1280 y 1440 px contra la base: `base_s35h/cap_a` más `cap_768`)
esperado: 0 píxeles distintos en `#comparacion` a 768 y 1280 px
obtenido: 0 en las 18 capturas (las tres vistas, página completa y ventana de arriba a DSF 2, a 768, 1280 y 1440). **Cumple.**

Información (no es criterio): a 375 px, la captura de la ventana de arriba de `#comparacion` a DSF 2 difiere de la base en 1.002 píxeles (filas 1107-1707, columnas 81-582). Son las esquinas redondeadas de los segmentados y de las fichas y los rótulos «Territorios a comparar / 4 de 5 activos», con una diferencia máxima de 3/255 por canal: invisible. Es estable (base contra base 0, M2 contra M2 0) y viene de M2 (con solo M1, 0 píxeles). Probablemente el nuevo contenedor con desplazamiento cambia cómo Chrome rasteriza la página (no se aisló). La página completa pasa de 4.338 a 4.383 px de alto: las celdas, más anchas, tienen sparklines más altas.

Comprobaciones adicionales:
- I-3: «JSON idéntico a la línea base», codigo_I3=0.

Capturas para el titular en `_archivo/20260925_capturas_s35h/` (375 px, página completa recortada al supergrid): `s35h_m2_supergrid_375_{antes,despues}.png`. Revisión visual: antes, los nombres, «Trayectoria histórica», «Últimas 3 aplicaciones» y «Medio bajo» montados sobre la celda vecina; después, cada texto dentro de su celda y la tercera columna cortada en el borde, que indica que el supergrid sigue hacia el lado.

- PRUEBAS: build codigo 0; la batería y la regresión completa corren en PUB y en FASE R.
- Alcance: `git show --stat a653259` = `30_procesamiento/33_motor_template.html` (+14/−1), más las capturas en `_archivo/` (ignorada). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas:
  - D-M2-a (riesgo bajo): el supergrid mismo es el contenedor con desplazamiento (`overflow-x: auto` en `.supergrid`), sin un envoltorio nuevo en el JSX. La fila de cabeceras y las celdas se desplazan juntas.
  - D-M2-b (riesgo bajo): el valor por omisión, 0 px, va en `:root`; el de pantallas angostas, en un `:root` dentro del `@media`.
  - D-M2-c (riesgo medio): con 6 entidades se midió en la copia con el tope en 6 (D0-c). Se midió también con 5, el máximo real del producto.
- Errores propios: ninguno.
- Dudas: Q-63 (el tope; en el cierre).

### FASE M3: centrado de los controles restantes (Q-57)

- Estado: completa, en el primer intento.
- Commits: `52bab39` fix(motor): centrado optico de pestañas, campo, exportar y tooltip (Q-57).

**Sonda previa** (`$TMPDIR/cal_s35h/m3/sonda.R`, base de H6, 1280 px):
- el `<input>` del modal no admite el recorte: con `style.textBox = 'trim-both cap alphabetic'` (valor calculado «cap alphabetic») da el mismo alto (30,000) y el mismo desvío (−3,30) que sin la propiedad, como el `<select>` en s35f;
- «Ver establecimientos» (`display: block`, 12 px) mide 27 px, cuando 1lh es 12: la «▸» sale de la fuente del sistema y alarga la línea a 15 px. Con el recorte de `.segmented-btn`, mide 24 y queda centrado (+0,82), y el tooltip pasa de 301 a 298 px.

**Cambios** (motor; cada bloque va inmediatamente después de la regla que modifica, como en G1 de s35g; fuera de los bloques, la regla de hoy sin cambios):
- `.modal-tab`: bloque `@supports` con `--relleno-pestana: 12px`, relleno `calc(var(--relleno-pestana) + var(--compensa-recorte)) 0`, `min-height: calc(1lh + 2 * var(--relleno-pestana) + 2px)` (el borde inferior de 2 px) y `text-box: trim-both cap alphabetic`, como `.segmented-btn`.
- `.input` (el campo del modal; las 6 apariciones de `.input` están en el modal): ajuste equivalente al del `<select>`, porque no admite el recorte. Bloque `@supports` con `--relleno-campo: 6px`, `padding-top: calc(var(--relleno-campo) + var(--ajuste-optico-select))`, `padding-bottom: calc(var(--relleno-campo) - var(--ajuste-optico-select))` y `min-height: calc(1lh + 2 * var(--relleno-campo) + 2px)`.
- `.icon-export-label`: la clase `control-texto` en el marcado (JSX de `IconExport`), sin CSS nuevo; la regla de `.control-texto` ya vive en su bloque `@supports` desde s35g.
- `.tt-estab-link`: bloque `@supports` con `--relleno-estab: 5px`, relleno `calc(var(--relleno-estab) + var(--compensa-recorte)) 8px`, `min-height: calc(1lh + 2 * var(--relleno-estab) + 2px)` y `text-box: trim-both cap alphabetic`.

Build (`$TMPDIR/cal_s35h/m3/build_i1.txt`; salidas en `m3/i1/`)
esperado: código 0
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor ed030cdb817213c790bfb2013740516f, vista 523ce765… (sin cambio); 9 bloques `@supports` en el motor (s35g: 6), `grep -c '@supports'` 10 líneas (7 + 3)

**Criterio con soporte: controles de Q-57** (`verificar_centrado.R … q57` sobre el build; `m3/i1_q57.txt`)
esperado: dentro de ±2 px de dispositivo, a 1280 y 375 px
obtenido: «28 controles medidos | en criterio 28 | fuera 0 | sin medida 0» (base: 26 con medida, 25 fuera). Por control, base → final:
- 1280: campo −3,30 → +0,70; pestañas −3,72/−3,60 (activa)/−3,61/−3,33/−3,72/−3,71 → +0,28/+0,40/+0,39/+0,67/+0,28/+0,29; exportar en comparación −5,22/−5,21/−5,16 → −1,22/−1,21/−1,16; «Ver establecimientos» +2,82 → +0,82; exportar en panorama −4,98 → −0,98 (×3).
- 375: campo sin medida → +0,70; pestañas sin medida/−3,61/−3,61/−3,33/−3,72/−3,60 → +0,28/+0,39/+0,39/+0,67/+0,28/+0,28; exportar en comparación −5,17/−5,17/−7,09 → −1,17/−1,17/−0,41; «Ver establecimientos» +0,52 → +1,70; exportar en panorama −7,36 → +0,64 (×3).
- Altos iguales a los de la base salvo «Ver establecimientos», 27 → 24 (D-M3-a).

**Cumple.**

**Criterio: los 90 controles del inventario** (`verificar_centrado.R … inventario` sobre el build, contra la base y contra el build de M2; `m3/i1_inv.txt`, `m3/m2_inv.txt`)
esperado: los 90 dentro de ±2 px, con alto y posición iguales a la base (|Δ| ≤ 0,5 px)
obtenido: «90 controles medidos | en criterio 90 | fuera 0» (dif de −1,91 a +1,54). Contra el build de M2, el estado justo antes de M3: los 90 con Δ alto, Δ y, Δ x y Δ dif = 0 (0 de 90 con |Δ| > 0,5). Contra la base de H6: alto igual en los 90 (máx |Δ| 0) y posición igual en 85. Los 5 restantes, todos a 375 px, se movieron con M1 y M2, no con M3:
- el `.select` del modal, +102,5 en x, y «Cancelar» y «Agregar al análisis», −102,5: el modal ya no desborda (M1);
- el `select` GSE y las notas, +45,33 en y: el supergrid es más alto (M2).

El build de M2 da contra la base las mismas 5 diferencias. **Cumple** en lo que toca a M3 (D-M3-b).

**Criterio sin soporte (I-10)** (`Rscript verificar_sin_textbox.R q57 <motor> <dir> <ref>`: la copia simulada del build contra la base de H6 simulada igual, `$TMPDIR/sin_textbox/s35h_base/altos_q57.rds`; `m3/sim_i1.txt`)
esperado: altos de los controles de Q-57 iguales a los de la base simulada (|Δ| ≤ 0,5)
obtenido: «28 controles emparejados (solo en simulado 0, solo en altos_q57.rds 0) | |Δ alto| <= 0.5: 28 | fuera 0 | Δ alto 0.0000 a 0.0000». A 1280, además, Δ y y Δ x = 0 en los 14; a 375, Δ y hasta 45,33 y Δ x hasta 102,5 por M1 y M2 (los mismos desplazamientos de arriba). **Cumple.**

**Criterio: `grep` fuera de `@supports`** (`Rscript verificar_sin_textbox.R grep` sobre las tres plantillas, el mismo comando que G1 de s35g; `m3/grep_i1.txt`)
esperado: 0 apariciones nuevas de `text-box`, `1cap`, `lh` como unidad o `round(` fuera de un bloque `@supports`
obtenido: «fuera de @supports: 0 apariciones (con comentarios) | 0 declaraciones»; bloques 2 (fragmento), 9 (motor) y 3 (vista); dentro, en el motor, `text-box` 23, `1cap` 2, `lh` 11, `round(` 2. **Cumple.**

Comprobaciones adicionales:
- I-9 (capturas del estado inicial a 768, 1280 y 1440 px contra la base): 0 píxeles distintos en las 18. Los rótulos de exportar están ocultos en reposo y el modal y el tooltip están cerrados.
- Regresión de M1 (`m1_medir.R` sobre el build de M3): fuera (visible) 0 en 12 de 12; pestañas activas 12 de 12; pie 12 de 12; `scrollWidth` 12 de 12.
- Modal a 768 y 1280 px contra la base: 2.570 a 3.928 píxeles distintos por pestaña, en la fila de pestañas y en el campo (filas 190-502). Es el cambio buscado: el criterio de «0 píxeles» del modal es de M1 y se midió en M1, antes de M3.

Capturas para el titular en `_archivo/20260925_capturas_s35h/` (1280 × 900, DSF 2, recortadas): `s35h_m3_{antes,despues}_{pestanas,campo,exportar_foco,ver_establecimientos}_1280.png`. El rótulo de exportar se ve con su anillo de foco real.

- PRUEBAS: build codigo 0; la batería y la regresión completa corren en PUB y en FASE R.
- Alcance: `git show --stat 52bab39` = `30_procesamiento/33_motor_template.html` (+35/−1), más las capturas en `_archivo/` (ignorada). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas:
  - D-M3-a (riesgo medio): «Ver establecimientos» se recorta como `.segmented-btn` y, con soporte, pasa de 27 a 24 px, y el tooltip de 301 a 298. Los 3 px venían de la «▸», que sale de la fuente del sistema y alargaba la línea por sobre 1lh. Conservar los 27 px exigiría una cifra nueva que depende de la fuente del sistema de cada equipo. Sin soporte mide 27, como antes (I-10).
  - D-M3-b (riesgo medio; desviación en la lectura del criterio): «posición igual a la base» se evaluó contra la base de H6 y contra el build de M2. A 375 px, 5 controles del inventario se movieron con M1 (el modal entra en la ventana) y con M2 (el supergrid crece), que corren antes de M3 por el orden fijo del encargo. M3 no mueve ninguno: Δ 0 en los 90 contra el build de M2.
  - D-M3-c (riesgo bajo): el campo usa el ajuste del `<select>` (`--ajuste-optico-select`), declarado como el equivalente que admite el encargo. Se midió que el `<input>` ignora `text-box`.
- Errores propios: ninguno.
- Dudas: ninguna.

### FASE M4: el PNG exportado lleva la fuente del sitio (Q-31)

- Estado: completa, en el primer intento (con un error de compilación corregido antes de medir; ver errores propios).
- Commits: `206cb3a` fix(motor): el PNG exportado incrusta gobCL (Q-31).

**Cambios** (motor, junto a `rasterizarSvgAPng()`):
- `reglasFuenteSitio()`: recorre `document.styleSheets` (y las reglas anidadas) y devuelve el `cssText` de cada `CSSFontFaceRule` cuya familia es `FAMILIA_SITIO`. Es la constante que ya existía (L2519, «gobCL-sitio», la usa la espera de la fuente): se reutiliza. Las reglas se leen en tiempo de ejecución y no se duplican en la plantilla.
- `svgConFuenteSitio(svgStr)`: inserta esas reglas en un `<style><![CDATA[…]]></style>` justo después de la etiqueta raíz `<svg …>`. Sin reglas, devuelve el SVG sin cambios.
- `rasterizarSvgAPng()` crea su `Blob` con `svgConFuenteSitio(svgStr)`. En `img.onload`, dibuja cuando `img.decode()` se resuelve (si falla, dibuja igual), con `then` y no con `async`: Babel, con el preset env, no trae el runtime de regenerator. El cuerpo de antes queda igual, solo con 2 espacios más de sangría: `git diff -w` no muestra cambios en el techo de superficie ni en los mensajes de error.
- Las exportaciones SVG (`exportarGraficosSVG` y la del panorama) no pasan por `svgConFuenteSitio`.

Build (`$TMPDIR/cal_s35h/m4/build_i1.txt`; salidas en `m4/i1/`)
esperado: código 0
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor fe30d56f866d082501bd8937a24f752e, vista 523ce765… (sin cambio). En la salida, `var lista = img.decode ? img.decode()["catch"](function () {}) : Promise.resolve();`.

**Criterio: la fuente del PNG** (`m4_medir.R` sobre el build, 10 exportaciones PNG seguidas del supergrid y una del panorama; `m4/i1.txt`, archivos en `m4/i1/res/`)
esperado: en el PNG del supergrid y en el del panorama, el ancho del texto de referencia coincide con el de gobCL-sitio (±2 px de PNG) y difiere del de `system-ui`
obtenido (px de PNG; PNG / tinta gobCL-sitio / tinta system-ui; base entre paréntesis):
- supergrid, «VIÑA DEL MAR»: **177** / 177 / 205 (base 205), en las 10 exportaciones;
- supergrid, título: **705** / 705 / 801 (base 801), en las 10;
- panorama, «Lectura»: **89** / 89 / 104 (base 104);
- panorama, título: **800** / 800 / 912 (base 912).

Las 22 mediciones coinciden con gobCL-sitio, con diferencia 0, y difieren de `system-ui` en 15 a 112 px. Por avance (`getComputedTextLength()` × 2), cada PNG queda más cerca de gobCL-sitio (176,81, 706,84, 90,59 y 802,88) que de `system-ui` (205,47, 802,91, 107,19 y 913,97). **Cumple.**

**Criterio: el SVG exportado no cambia** (md5 del `Blob` de «Exportar SVG» y del archivo descargado)
esperado: idéntico byte a byte al de la base
obtenido: supergrid 5149473c1b10084864e8262f03fc7dd4 y panorama 78fee2e0f6cc840f4a9e61b587dcd00f, los mismos de la base (FASE 0). El archivo descargado tiene el mismo md5. **Cumple.** El SVG interno que se rasteriza sí cambia (md5 bcacbe28… y 655ef328…): lleva el `<style>`.

**Criterio: I-2, sin red** (el SVG interno y la salida)
esperado: el `<style>` usa `data:`; sin carga por red
obtenido: `<style>` presente, 2 `@font-face` (400 y 700) con la fuente en `data:font/otf;base64`, sin `http` en el estilo; 0 solicitudes de red en las dos páginas; en la salida, `grep -cE "src=[\"']?(https?:)?//"` = 0 y `grep -c 'url(http'` = 0. **Cumple.**

**Criterio: el techo y los mensajes no cambian** (`git diff -w` del motor)
esperado: `PNG_MAX_SUPERFICIE_PX` y los textos de `alert` iguales
obtenido: el diff sin espacios no muestra ninguna línea quitada ni cambiada salvo la creación del `Blob`; la constante y los tres mensajes quedan iguales. En las exportaciones medidas: 0 diálogos. **Cumple.**

**`img.decode()`, medido** (copia del build con `var lista = Promise.resolve();`, es decir, dibujando en cuanto llega `onload`; `m4/sin_decode.txt`)
esperado: (sin esperado previo; se registra)
obtenido: también 22 de 22 con gobCL-sitio, y los mismos md5 del PNG. En Chrome 153, el `load` de la imagen SVG ya espera las fuentes `data:` incrustadas, así que `decode()` no cambia el resultado aquí. Queda como resguardo para otros motores: no se midió en WebKit ni en Firefox.

Comprobaciones adicionales:
- El PNG descargado es el mismo `Blob` que recibe `descargarBlob()`: md5 5de54fd3… (supergrid) y 83f2d03e… (panorama) en los dos. Las 10 exportaciones dan el mismo ancho.
- I-3: «JSON idéntico a la línea base», codigo_I3=0.
- I-9 (1280 y 1440 px contra la base): 0 píxeles distintos en las 12.

Capturas para el titular en `_archivo/20260925_capturas_s35h/`: `s35h_m4_png_supergrid_encabezado_{antes,despues}.png`, los primeros 300 × 1500 px del PNG exportado. Antes, título y nombres en la fuente del sistema; después, en gobCL.

- PRUEBAS: build codigo 0; la batería y la regresión completa corren en PUB y en FASE R.
- Alcance: `git show --stat 206cb3a` = `30_procesamiento/33_motor_template.html` (+64/−28, casi todo sangría), más las capturas en `_archivo/` (ignorada). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno en lo medido.
- Decisiones autónomas:
  - D-M4-a (riesgo bajo): el `<style>` va dentro de `<![CDATA[…]]>`. Así el `cssText` (con comillas) se inserta tal cual, sin escapar para XML.
  - D-M4-b (riesgo bajo): `decode()` se espera con `then`, no con `async`, porque la transpilación no incluye el runtime de regenerator. Si `decode()` falla, se dibuja igual, que es el comportamiento de antes.
  - D-M4-c (riesgo medio): no se midió en Safari. Un navegador que contamine el lienzo con una imagen SVG que trae fuentes incrustadas haría fallar `toBlob`; el `try/catch` de siempre avisaría con «No se pudo generar el PNG». Queda para la revisión del titular.
- Errores propios: el primer build falló (codigo_build=1, «Identifier 'FAMILIA_SITIO' has already been declared»): declaré otra vez una constante que ya existía. Se quitó mi declaración y se reutilizó la de L2519. Las salidas de `40_salidas/` no se escribieron con ese build (motor ed030cdb…, el de M3). La copia de `m4/i1/` se rehízo con el build bueno.
- Dudas: ninguna.

### FASE V1: `--cardw` se vuelve a medir al cambiar de ancho (Q-52)

- Estado: completa, en el primer intento.
- Commits: `1458285` fix(trayectorias): la tarjeta se vuelve a medir al cambiar el ancho (Q-52).

**Cambio** (vista): en el manejador de `resize`, después de `altoMenu()` y antes de `pista()`, `build()` y `render()`, `document.documentElement.style.removeProperty('--cardw')` y `anchoTarjeta()`, como en `trasFuentes()`, con un comentario que cita Q-52.

Build (`$TMPDIR/cal_s35h/v/build_v1.txt`; salidas en `v/v1_i1/`)
esperado: código 0
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor fe30d56f… (sin cambio), vista cb9c6596257fc2106669a4192cced678

**Criterio: `--cardw` tras el cambio = carga nueva** (`v_medir.R v1` sobre el build; `v/v1_i1.txt`)
esperado: con los pares de FASE 0 y las cohortes inicial y 2027, `--cardw` tras el cambio igual al de una carga nueva en el ancho de llegada
obtenido: 640 → 1024: inicial 437 → **317** (carga nueva 317), 2027 540 → **522** (522); 1280 → 900: 317 = 317 y 522 = 522; 900 → 1280: 317 = 317 y 522 = 522. **6 de 6 iguales** (base: 4 de 6). El ancho del plano tras el cambio también es el de la carga nueva: 585 = 585 y 380 = 380 a 1024 (base: 465 y 362). **Cumple.**

**Criterio: sin cambiar de ancho, nada cambia** (`capturas.R` modo `inicial` a 375, 768 y 1280 px, solo la vista, contra la base: `cap_375b`, `cap_768` y `cap_a`)
esperado: 0 píxeles distintos
obtenido: 0 en las 6 capturas de la vista (página completa y ventana de arriba a DSF 2, en los tres anchos). **Cumple.**

Comprobaciones adicionales:
- I-4: «DATA de la vista: … identical: TRUE».
- Batería (`36_verificar_trayectorias.R`): codigo_bateria=0, «Resultado: 33 pruebas, 33 pasan, 0 fallan».

- PRUEBAS: build codigo 0; batería 33/33.
- Alcance: `git show --stat 1458285` = `30_procesamiento/36_trayectorias_template.html` (+5/−1). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas: ninguna.
- Errores propios: ninguno.
- Dudas: ninguna.

### FASE V2: el plano no queda angosto entre 823 y 1023 px (Q-51)

- Estado: completa, en el primer intento.
- Commits: `0f06bc8` fix(trayectorias): una columna cuando la tarjeta deja el plano angosto (Q-51).

**Cambios** (vista):
- Constante nueva `ANCHO_PLANO_MIN = 384`, el mínimo del plano con la cohorte inicial en FASE 0 (a 823 px; entero, sin redondeo).
- `unaColumna()`: calcula el ancho que le queda al plano en dos columnas: el de `.main` (`getBoundingClientRect`) menos `--cardw`, el `column-gap` de `.main` y el relleno y el borde laterales de `.plot`, leídos con `getComputedStyle`. Si es menor que `ANCHO_PLANO_MIN`, pone en `.app` la clase `una-col`; si no, la quita.
- Se llama tras cada `anchoTarjeta()`: en la carga, en `trasFuentes()`, en el manejador de `resize` (V1) y en `rebuild()` (cambio de cohorte y de los demás filtros). Además, al salir del modo presentación (`pres(false)`).
- CSS al final de la hoja, `@media (min-width:823px)`: con `.app.una-col:not(.pres)`, las cuatro declaraciones del tramo de 680 a 822 px (`height:auto`; `.main` en una columna; `.card` con `width:var(--cardw,300px)`; `svg.chart` con `flex:none` y `height:var(--alto-plano-fijo)`).

Build (`$TMPDIR/cal_s35h/v/build_v2.txt`; salidas en `v/v2_i1/`)
esperado: código 0
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor fe30d56f… (sin cambio), vista 69357a69dc04db6186e75d3245c6b873

**Criterio: ancho y alto del plano** (`v_medir.R v2` sobre el build: carga nueva por ancho y cohorte, la inicial sin clic; `v/v2_i1.txt`)
esperado: a 823, 900, 960 y 1023 px, con todas las cohortes, plano de 384 px o más de ancho y de 320 o más de alto
obtenido: 36 de 36 con el plano ≥ 384 (mínimo 384,00: la cohorte inicial a 823, en dos columnas); alto 360 en los 36. Pasan a una columna los 10 casos que en FASE 0 quedaban bajo 384: a 823, 2020, 2024, 2025, 2026, 2027, 2028 y 2029 (plano de 372-380, y 179 la 2027, → 709); a 900, 960 y 1023, la 2027 (256, 316 y 379 → 786, 846 y 909). Los otros 26 siguen en dos columnas, con el mismo `--cardw` y el mismo plano que en FASE 0. **Cumple.**

**Criterio: 0 píxeles en las cohortes que ya cumplían** (`capturas.R` modo `vista`, página completa por ancho y cohorte, contra la base; la inicial sin clic, como en FASE 0, `vista_ini_a`, y las demás con un clic desde la inicial, `vista_coh_a`; base contra base: 0 en las 40)
esperado: 0 píxeles distintos en las cohortes con el plano ≥ 384 en FASE 0 (a 823: 2018 y 2021; a 900, 960 y 1023: todas menos la 2027)
obtenido: 0 en los 26 casos: la inicial en los 4 anchos, 2021 a 823 y las 7 cohortes que no son ni la inicial ni la 2027 a 900, 960 y 1023. Los 10 casos que pasan a una columna cambian de alto (p. ej., 823 con la 2027: 1.470 → 1.829 px). **Cumple.**

**Criterio: I-8 en esos anchos** (mismo medidor)
esperado: `scrollWidth` = viewport
obtenido: 36 de 36. **Cumple.**

**Criterio: presentación sin cambios** (`capturas.R` modo `pres`, 1024 × 768, cohorte inicial; base contra base 0)
esperado: 0 píxeles distintos contra la base
obtenido: 0. **Cumple.**

Hallazgo durante la medición (previo a este encargo, fuera de Q-51):
- La primera tanda de capturas pedía también la cohorte 2018 con un clic. A 823 px ese caso salió en una columna (1.618 px de alto contra 1.350).
- Causa (`$TMPDIR/cal_s35h/v/ruta_cohorte.R`): al cambiar de cohorte, `rebuild()` mide la tarjeta con el ancho que tenía, sin volver `--cardw` a su valor por omisión. En la base, a 823 px:
  - un clic sobre la cohorte que ya estaba activa (2018) pasa `--cardw` de 317 a 323;
  - 2027 → 2018 deja 403 (carga nueva: 317);
  - 2027 → 2021 deja 396 (305);
  - 2029 → 2020 deja 325 (321).
- `unaColumna()` responde bien al ancho que la tarjeta tiene de verdad: con 323 el plano mediría 378 y con 403, 298, ambos bajo 384. El que depende del camino es `--cardw`.
- Se probó, en una copia del build (`v/opcion1/`), reiniciar `--cardw` también en `rebuild()`. Da el mismo valor por cualquier camino (2018: 317 siempre), pero cambia el ancho de la tarjeta de 7 cohortes en 5 a 8 px respecto de hoy (2020: 321 → 314; 2021: 305 → 297; …, 28 de 36 casos distintos de FASE 0). Eso rompería el criterio de 0 píxeles y está fuera de Q-51.
- No se aplicó: queda como duda Q-65.
- La captura de la inicial se repitió sin clic, el camino de FASE 0: 0 píxeles (arriba).

Información (no es criterio): la regla vale en cualquier ancho desde 823 px. Con la 2027, a 1024-1027 px el plano en dos columnas mediría 380-383, así que la vista va en una columna (plano de 910-913); desde 1028 px, dos columnas (384). Con las demás cohortes, desde 900 px no cambia nada.

Comprobaciones adicionales:
- Regresión de V1 (`v_medir.R v1` sobre el build de V2): 6 de 6 pares iguales a la carga nueva.
- Estado inicial a 375, 768, 1280 y 1440 px contra la base (24 capturas): la vista, 0 en las 8; el panorama, 0; `#comparacion` a 768, 1280 y 1440, 0. Los dos únicos distintos son `#comparacion` a 375, el efecto conocido de M2: página de 4.338 → 4.383 px y los 1.002 píxeles invisibles de la ventana de arriba.
- I-4: «identical: TRUE»; batería codigo_bateria=0, «33 pruebas, 33 pasan, 0 fallan».

Capturas para el titular en `_archivo/20260925_capturas_s35h/` (823 × 900, página completa): `s35h_v2_vista_823_2027_{antes,despues}.png` y `s35h_v2_vista_823_2020_{antes,despues}.png`. Después, la tabla arriba con su ancho y el plano abajo a todo el ancho.

- PRUEBAS: build codigo 0; batería 33/33.
- Alcance: `git show --stat 0f06bc8` = `30_procesamiento/36_trayectorias_template.html` (+36/−5), más las capturas en `_archivo/` (ignorada). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno en V2.
- Decisiones autónomas:
  - D-V2-a (riesgo medio): el «ancho disponible para el plano» resta, además de `--cardw` y el gap, el relleno y el borde del panel del plano (34 px, leídos del estilo calculado). `ANCHO_PLANO_MIN` se midió sobre `svg.chart`: comparar el ancho de la columna (418 a 823 px con la inicial) con el del plano dejaría en dos columnas las cohortes con plano de 350 a 383, por debajo del mínimo que pide el criterio.
  - D-V2-b (riesgo bajo): la regla de `una-col` vale desde 823 px. Debajo, cada tramo ya da una columna, y sin el límite la clase cambiaría el ancho de la tarjeta bajo 680 px, que allí ocupa todo el ancho.
  - D-V2-c (riesgo bajo): la clase también se recalcula al salir del modo presentación. Un `resize` durante la presentación la calcularía con la presentación, que es 48 px más ancha. En presentación, la clase no tiene efecto (`:not(.pres)`).
  - D-V2-d (riesgo medio): la regla se aplica en cualquier ancho, no solo de 823 a 1023, como la describe el encargo («después de `anchoTarjeta()`, si …»). Con la 2027 afecta también a 1024-1027 px.
  - D-V2-e (riesgo medio): a 823 px pasan a una columna seis cohortes que quedaban entre 4 y 12 px bajo el mínimo (duda Q-64), además de la 2027.
- Errores propios: la primera tanda de capturas elegía la cohorte inicial con un clic, un camino distinto del de FASE 0 (carga nueva sin clic). Se repitió con el camino de FASE 0 antes de evaluar el criterio. La diferencia que dio el clic está explicada arriba (Q-65).
- Dudas: Q-64 y Q-65, en el cierre.

### FASE PUB: copia a `docs/`

- Estado: completa (M1, M2, M3, M4, V1 y V2 completas antes de copiar; ninguna congelada).
- Commits: `78abd6b` deploy(docs): pantallas angostas, centrado restante y PNG con gobCL.

`md5 -q docs/index.html docs/trayectorias.html` antes de la copia
esperado: 7f5971a3a99b24540ee797b9c1966a0c y 523ce765359e1cb1ee080b3fe557c93b (H4)
obtenido: 7f5971a3a99b24540ee797b9c1966a0c y 523ce765359e1cb1ee080b3fe557c93b

**Paso 1.** `Rscript 00_build.R` y la batería (salidas en `$TMPDIR/cal_s35h/pub/`)
esperado: código 0 y 33 pruebas o más en PASA
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 6 segundos»); codigo_bateria=0, «Resultado: 33 pruebas, 33 pasan, 0 fallan»; motor fe30d56f866d082501bd8937a24f752e y vista 69357a69dc04db6186e75d3245c6b873, iguales a los de M4 y V2 (build reproducible)

**Paso 2.** `cp 40_salidas/motor_comparacion.html docs/index.html` y `cp 40_salidas/trayectorias_traspasos.html docs/trayectorias.html` (autorización 2)

**Paso 3. Verificación.**

md5 de `docs/` contra `40_salidas/`
esperado: iguales
obtenido: `docs/index.html` fe30d56f866d082501bd8937a24f752e = motor; `docs/trayectorias.html` 69357a69dc04db6186e75d3245c6b873 = vista

I-2 (`grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'`)
esperado: 0 en cada uno
obtenido: `40_salidas/motor_comparacion.html` 0 0; `40_salidas/trayectorias_traspasos.html` 0 0; `docs/index.html` 0 0; `docs/trayectorias.html` 0 0

I-3 (`Rscript verificar_contenido_motor.R docs/index.html`) e I-4 (`i4_data_vista.R docs/trayectorias.html`), códigos leídos sin tubería
esperado: «JSON idéntico a la línea base»; `identical: TRUE`
obtenido: codigo_I3=0, «JSON idéntico a la línea base»; codigo_I4=0, «DATA de la vista: … identical: TRUE»

`git status --porcelain` antes del commit
esperado: solo los dos archivos de `docs/` (más este log, sin seguimiento)
obtenido: ` M docs/index.html`, ` M docs/trayectorias.html`, `?? 50_documentacion/andamios/logs/20260925_pantallas_angostas_s35h_log.md`

- Alcance: `git show --numstat 78abd6b` = `docs/index.html` (+130/−30) y `docs/trayectorias.html` (+40/−5). Dentro del ALCANCE.
- Subagentes: ninguno. Bugs: ninguno. Decisiones autónomas: ninguna. Errores propios: ninguno. Dudas: ninguna.

### FASE R: auditoría y reparación

Sin subagentes: el orquestador re-deriva cada afirmación con un comando distinto del que la produjo. Scripts en `$TMPDIR/cal_s35h/r/`.

**R.1 Inventario de afirmaciones auditables** (armado desde este log, antes de auditar):

| id | afirmación | fase |
|---|---|---|
| R-01 | H1-H4: tres rutas y el log sin commit; 0 stash; `HEAD` y `origin/main` en cefa729; md5 del encargo 69791999…; `docs/` 7f5971a3… y 523ce765…; fuentes; 28; `@supports` 7/4/3 | FASE 0 |
| R-02 | T0 = `b3cc432`, solo sus tres rutas, hijo de cefa729 | FASE 0 |
| R-03 | H5 33/33; H6 código 0; el motor de H6 difiere de `docs/` solo en `meta$fecha_generacion` (D0-a); la vista es igual | FASE 0 |
| R-04 | los comparadores de I-3 e I-4 disparan con un número alterado | FASE 0 |
| R-05 | capturas de la base deterministas (12 del estado inicial y 12 del modal) | FASE 0 |
| R-06 | M1, calibración: a 375 px, 19 a 51 elementos del modal fuera por pestaña; pie visible 0 de 12 | FASE 0 |
| R-07 | M2, calibración: a 375 px, 4 columnas de 64,75, sparklines de 42,75, 45 de 64 textos fuera; `--supergrid-col-min` = 112 (PUCHUNCAVÍ 103,66 + 8) | FASE 0 |
| R-08 | M3, calibración: 25 de 26 controles de Q-57 medibles fuera de ±2; el medidor ampliado deja el inventario idéntico | FASE 0 |
| R-09 | M4, calibración: el PNG de la base tiene la tinta de `system-ui` (diferencia 0) y las dos familias se separan > 4 px | FASE 0 |
| R-10 | V1, calibración: 2 de 6 pares distintos (640 → 1024) | FASE 0 |
| R-11 | V2, calibración: `ANCHO_PLANO_MIN` = 384 (inicial a 823); la 2027 bajo el mínimo en los 4 anchos; seis cohortes más a 823 | FASE 0 |
| R-12 | M1: 0 elementos visibles fuera en 12 casos; pestañas activas 12/12; pie 12/12; `scrollWidth` = viewport; modal a 768 y 1280, 0 píxeles; subrayado de 2 filas | M1 |
| R-13 | `df73a45` toca solo el motor | M1 |
| R-14 | M2: 0 textos fuera con 1, 2, 4, 5 y 6 entidades a 375 y 414; sparklines ≥ 90; documento = viewport; desplazamiento solo en el supergrid; 0 píxeles a 768, 1280 y 1440 | M2 |
| R-15 | `a653259` toca solo el motor | M2 |
| R-16 | M3: 28/28 dentro de ±2 con soporte; inventario sin cambios contra el build de M2; altos sin soporte iguales a la base; `grep` 0 fuera de `@supports` | M3 |
| R-17 | `52bab39` toca solo el motor | M3 |
| R-18 | M4: el PNG tiene la tinta de gobCL-sitio (22/22); SVG exportado idéntico; `<style>` con `data:`; sin red; techo y mensajes sin cambio | M4 |
| R-19 | `206cb3a` toca solo el motor | M4 |
| R-20 | V1: 6 de 6 pares iguales a la carga nueva; la vista a 375, 768 y 1280, 0 píxeles | V1 |
| R-21 | `1458285` toca solo la vista | V1 |
| R-22 | V2: plano ≥ 384 y alto 360 en 36/36; 0 píxeles en los 26 casos que ya cumplían; I-8; presentación 0 píxeles | V2 |
| R-23 | `0f06bc8` toca solo la vista | V2 |
| R-24 | `docs/` = `40_salidas/` (fe30d56f…, 69357a69…); I-2 en 0; JSON y DATA idénticos; build reproducible | PUB |
| R-25 | `78abd6b` toca solo los dos `docs/` | PUB |
| R-26 a R-35 | I-1 a I-10 | §4 |
| R-36 | alcance global dentro de la unión de los ALCANCE, más el log | global |
| R-37 | regresión: build 0, batería ≥ 33 en PASA, JSON idéntico | global |
| R-38 | toda medida nueva va en una constante nombrada (`--supergrid-col-min`, `--relleno-pestana`, `--relleno-campo`, `--relleno-estab`, `ANCHO_PLANO_MIN`) | M2, M3, V2 |

**R.2 Re-derivación independiente** (orquestador; scripts y salidas en `$TMPDIR/cal_s35h/r/`)

R-01, R-02, R-13, R-15, R-17, R-19, R-21, R-23, R-25 (`git fetch` y `rev-parse` completos, `git stash list`, `git diff-tree --numstat` de cada commit con su padre, `git cat-file blob` de cefa729 y de b3cc432)
esperado: `origin/main` = cefa729; 0 stash; cada commit toca solo su ALCANCE y es hijo del anterior; los blobs de cefa729 dan los md5 de H4
obtenido: fetch=0; `origin/main` cefa729675fd58ea51eb547203072553341a606f; `HEAD` 78abd6bebbd1…; stash 0. `b3cc432` (padre cefa729) 23/0 decisiones, 504/0 encargo, 12/0 log de errores; `df73a45` (padre b3cc432) 15/0 motor; `a653259` 14/1 motor; `52bab39` 35/1 motor; `206cb3a` 64/28 motor; `1458285` 5/1 vista; `0f06bc8` 36/5 vista; `78abd6b` 130/30 `docs/index.html` y 40/5 `docs/trayectorias.html`. Blobs de cefa729: `docs/` 7f5971a3… y 523ce765…; encargo en b3cc432 69791999…; `@supports` en cefa729 7, 4 y 3 → CONFIRMADAS

R-03 (D0-a) y R-24 (datos) por otra vía (`rd_inv.py`: Python, JSON del motor con zlib, sha256 canónico sin `meta.fecha_generacion`; el HTML sin el bloque de datos; el bloque `DATA` de la vista byte a byte)
esperado: el motor de H6 igual al publicado en cefa729 salvo la fecha; `docs/` con los datos de la base
obtenido: sha256 sin fecha 7967dfa07a99ef11 en `docs/`, `40_salidas/`, la base de H6 y `cefa729:docs/index.html` (el mismo de s35g); fechas 2026-09-26 (hoy) y 2026-09-25 (cefa729); «claves de meta distintas: ['fecha_generacion'] | JSON sin fecha igual: True | HTML fuera del bloque igual byte a byte: True»; «I-4 bloque DATA (docs contra base) idéntico byte a byte: True | largo 2018084 | igual al parsear: True» → CONFIRMADAS

R-04: control positivo de R.6 (R, Python y `hash-object`) → CONFIRMADA

R-05 (md5 de cada PNG, identidad de bytes y no el comparador de píxeles)
esperado: `cap_a` = `cap_b` y `modal_a` = `modal_b`
obtenido: 12 de 12 y 12 de 12 con el mismo md5 → CONFIRMADA

R-06, R-12 (M1) con otro método y otros tamaños (`rd_m1.R`: la fila de pestañas se desplaza con `scrollLeft`, no con `scrollIntoView`; el modal se ubica con `offsetLeft`/`offsetWidth`; pie con `elementFromPoint`; pistas de `.form-grid`; desborde de la página con `scrollTo`; 360 × 740, 390 × 844, 540 × 900, 640 × 900 y 641 × 900)
esperado: bajo 641 px, `docs/` con el modal dentro, pestañas activas, pie visible y una pista; la base, con el modal fuera en las angostas; a 641 px, el modal de siempre
obtenido: `docs/` bajo 641 px: modal dentro 24/24, pestaña activa tras el clic 24/24, pie 24/24, una pista 24/24, `scrollX` 0 24/24; base: modal dentro 12/24 (fuera en los 12 casos de 360 y 390), una pista 0/24. A 641 px el modal mide 601 px en las dos (sin cambio sobre 640) → CONFIRMADAS

R-07, R-14 (M2) con otro método y otros anchos (`rd_m2.R`: por celda del supergrid, `scrollWidth > clientWidth`; ancho de pista por las cabeceras; `scrollLeft` máximo del supergrid; `scrollX` de la página tras `scrollTo`; 360, 390, 600, 640 y 641 px, con 4 y 5 entidades). Además, `rd_colmin.R`: ancho de «PUCHUNCAVÍ» con `measureText` del lienzo
esperado: `docs/` sin celdas que desborden bajo 641 px y sin desborde de la página; la base, con celdas que desbordan; 112 px con el otro método
obtenido:
- `docs/`: 0 celdas con desborde en los 8 casos bajo 641 px; pistas de 112 (360 y 390, 4 y 5 entidades; 600 y 640 con 5) o 121/131 (600 y 640 con 4); `scrollLeft` máximo del supergrid 204, 328, 174, 298, 0, 88, 0 y 48; página `scrollX` 0 en todos.
- Base: 17 y 23 celdas con desborde a 360 (4 y 5), 17 y 23 a 390, 19 a 600 con 5, 1 a 640 con 5; página `scrollX` 9 y 3 con 5 entidades a 360 y 390.
- A 641 px con 5 entidades, 1 celda desborda en las dos (pista de 102,59 px): ADVIERTE R-40.
- `measureText` de PUCHUNCAVÍ: 103,64 px (letter-spacing −0,09 px), relleno 8, suma 111,64, redondeo **112**.

→ CONFIRMADAS

R-08, R-16 (M3) con otro instrumento: el medidor a DSF 3 (`rd_q57.R dsf3`, tolerancia ±3 px de dispositivo, 1 px CSS, la misma que ±2 a DSF 2), inventario y Q-57
esperado: `docs/` 118 de 118 dentro; la base, Q-57 fuera
obtenido: `docs/` «118 medidas | en criterio 118 | fuera 0 | sin medida 0» (Q-57 de −1,84 a +2,58; inventario de −2,82 a +2,33, en px de dispositivo a DSF 3); base: Q-57 con medida 26, fuera de ±3: 25, de −11,02 a +4,27 → CONFIRMADAS

R-16 (sin soporte) e I-10 con otro instrumento: el CSSOM en la página viva (`rd_q57.R sin`: `deleteRule` de los `@supports` con `text-box`, `removeProperty('text-box')`), sobre `docs/` y la base
esperado: altos de Q-57 iguales
obtenido: en `docs/` se borran 11 `@supports` (9 del motor y 2 del fragmento) y en la base 8; «28 emparejados | |Δ alto| <= 0,5: 28 | máx |Δ alto| 0.0000 | a 1280: máx |Δ y| 0.0000, máx |Δ x| 0.0000»; altos sin soporte: exportar 32, campo 30, pestañas 42, «Ver establecimientos» 27 (el de antes) → CONFIRMADAS

R-09, R-18 (M4) con otro instrumento: en R, sobre los archivos PNG descargados (no los `Blob`), la tinta de la franja del título y del nombre de la primera columna contra el color de fondo (`rd_m4.R`)
esperado: título de la base 801 (system-ui) y de `docs/` 705 (gobCL-sitio)
obtenido: base «tinta del título 801 px | nombre 126 px»; final «tinta del título 705 px | nombre 105 px» → CONFIRMADAS

R-10, R-20 (V1) con otros pares y otro indicador (`rd_v.R`: 375 → 1280, 1440 → 823, 823 → 1100 y 768 → 960, cohortes inicial, 2027 y 2029; `--cardw` y `offsetWidth` de `.card`)
esperado: con la inicial y la 2027 (las del criterio), igual a la carga nueva; la base, distinta en al menos un par
obtenido: `docs/`: inicial y 2027, 8 de 8 iguales (`--cardw` y ancho de la tarjeta). La 2029 da 323 tras el cambio de ancho y 329 en la «carga nueva» (4 de 4 distintos). La carga nueva de la 2029 pasa por un clic, y `rebuild()` mide desde el ancho anterior (317), no desde el valor por omisión como `trasFuentes()`, que V1 imita: es Q-65 (ADVIERTE R-39). Base: 375 → 1280 distinto en las tres cohortes (333 contra 317 con la inicial; 366 contra 522 con la 2027); los otros 9, iguales (sin nueva medida) → CONFIRMADAS con la advertencia R-39

R-11, R-22 (V2) con otros anchos y altos (`rd_v.R`: 830, 850 y 1000 px × 700 y 1100 de alto, cohortes inicial, 2020, 2024, 2027 y 2029; pistas de `.main` con `getComputedStyle`)
esperado: plano ≥ 384 y alto ≥ 320 en `docs/`; la clase coincide con una pista
obtenido: `docs/` «30 casos | plano >= 384: 30 | alto >= 320: 30 | una-col = 1 pista: 30 | scrollX 0: 30»; base «plano >= 384: 22 | alto >= 320: 28». Presentación a 823 × 900 con la 2027: `docs/` con la clase puesta y 2 pistas (la clase no rige en presentación); captura de la ventana idéntica a la de la base (0 píxeles) → CONFIRMADAS

R-24 (identidad) con `git hash-object` y `git ls-tree HEAD docs/`
esperado: blobs iguales en `docs/`, `40_salidas/` y `HEAD`
obtenido: `9e00cdba0a3f…` en `docs/index.html`, `40_salidas/motor_comparacion.html` y `HEAD:docs/index.html`; `f05d894b2892…` en `docs/trayectorias.html`, `40_salidas/trayectorias_traspasos.html` y `HEAD` → CONFIRMADA

R-24 (red) con un segundo patrón (`rd_inv.py`: `src` con o sin comillas, `url(`, `<link href>`, `@import`, `fetch(`; cada `http` clasificado por dominio; `grep -c 'http'`)
esperado: 0 cargas; los aciertos de `http`, sin carga
obtenido: 0 cargas en los cuatro HTML. Motor: 26 URL (23 `http://www.w3.org` de los espacios de nombres SVG y de React/D3, `https://reactjs.org` del decodificador de errores de React, `https://d3js.org` y `https://github.com` de las licencias de D3 y pako), 17 líneas con `http`; vista: 2 (`www.w3.org`). Revisadas a mano: ninguna es una carga; son las mismas de s35g (28 apariciones de «http» contando `httpEquiv` y `http-equiv`). M4 no agregó ninguna → CONFIRMADA

R-38 (`git diff b3cc432..HEAD` de las dos plantillas, líneas agregadas con cifras, sin comentarios; revisión a mano)
esperado: cifras nuevas solo en constantes con nombre
obtenido: constantes nuevas `--supergrid-col-min` (0px y 112px), `--relleno-campo` (6px), `--relleno-estab` (5px), `--relleno-pestana` (12px) y `ANCHO_PLANO_MIN` (384). Las demás cifras ya existían en el código:
- `+ 2px`: el borde, como en `.select` desde s35f;
- `8px` y `0`: los rellenos laterales de antes;
- `inset 0 -1px 0`: el borde de 1 px que reemplaza;
- `0` y `100%`: valores neutros;
- `min-width:823px`: el corte existente de Q-44;
- `var(--cardw,300px)`: la declaración copiada del tramo de 680 a 822;
- `1e6`, `2d` y `0, 0`: líneas del rasterizador que solo cambiaron de sangría.

→ CONFIRMADA

**R.3 Invariantes 🔒** (estado final `78abd6b`, tras el build de la regresión)

I-1 `md5 -q docs/*.html` tras PUB
esperado: iguales a `40_salidas/`
obtenido: fe30d56f866d082501bd8937a24f752e y 69357a69dc04db6186e75d3245c6b873 en `docs/` y en `40_salidas/` → **PASA**

I-2 `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html`
esperado: 0 en cada uno
obtenido: 0 0 en los cuatro → **PASA**

I-3 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base», codigo_I3=0 → **PASA**

I-4 el `DATA` decodificado de la vista contra la base de H6 con `identical()` (`i4_data_vista.R`)
esperado: `TRUE`
obtenido: «DATA de la vista: claves anios,meta,nac,datos,nube,comunas | identical: TRUE», codigo_I4=0 → **PASA**

I-5 `md5 -q 10_utils/fuentes/*.otf`
esperado: a7407ed6… (Bold) y 0257bb4b… (Regular)
obtenido: a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc; blobs ccbdbdc6… y b78fd5c5…, 100644 → **PASA**

I-6 `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`
esperado: vacío
obtenido: vacío (0 líneas) → **PASA**

I-7 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 (y 28 con `git ls-files -- '*.csv' '*.xlsx' '*.parquet' '*.rds' | wc -l`) → **PASA**

I-8 `scrollWidth` de la vista, `#comparacion` y `#panorama` a 375, 414, 540, 768, 1024 y 1280 px (`i8.R` sobre `docs/`)
esperado: igual al viewport
obtenido: «docs_final : I-8 PASA» (18 de 18); por otra vía (`rd_i8.R`, `scrollX` tras `scrollTo(100000, 0)`): 0 en los 18 y `body.scrollWidth` = ancho; «I-8 (otra vía): PASA» → **PASA**

I-9 capturas de las tres vistas a 1280 × 900 y 1440 × 900, estado inicial, de `docs/` contra la base de H6
esperado: 0 píxeles distintos
obtenido: 0 en las 12 con el comparador; además, 12 de 12 con el mismo md5 → **PASA**

I-10 `verificar_sin_textbox.R q57` sobre el estado final (`docs/index.html`) contra la base de H6 simulada igual
esperado: altos de los controles de Q-57 iguales a la base (|Δ| ≤ 0,5 px)
obtenido: primera corrida: codigo_I10=1, «llaves sin cerrar: 1». El simulador tomaba como CSS la cadena `"<style><![CDATA[…]]></style>"` que M4 arma en el JavaScript: error del instrumento, corregido (solo los `<style>` fuera de `<script>`; la región CSS de `docs/` queda en 1, de 160.790 caracteres, la misma del build de M3). Segunda corrida: codigo_I10=0; «condiciones @supports reemplazadas 11 | declaraciones text-box borradas fuera de @supports 0 | dentro de @supports 17»; «28 controles emparejados | |Δ alto| <= 0.5: 28 | fuera 0 | Δ alto 0.0000 a 0.0000». Por otra vía (CSSOM, R.2): 28 de 28 → **PASA**

**R.4 Alcance global** (`git diff --name-only b3cc432^..HEAD` con `rd_alcance.R`, y `git status --porcelain`)
esperado: 0 rutas fuera de la unión de los ALCANCE (más el log); el árbol solo con el log
obtenido: «rutas: 7 | fuera: (ninguna)»: las dos plantillas, los dos `docs/` y las tres rutas de T0. `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260925_pantallas_angostas_s35h_log.md`. Las capturas van en `_archivo/20260925_capturas_s35h/` (ignorada, 20 archivos). **PASA.**

**R.5 Regresión completa** (estado final `78abd6b`; salidas en `$TMPDIR/cal_s35h/r/`)
esperado: `Rscript 00_build.R` código 0; batería ≥ 33 en PASA y código 0; «JSON idéntico a la línea base»
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»; «OK en 6 segundos»), motor fe30d56f… y vista 69357a69… (iguales a PUB); codigo_bateria=0, «Resultado: 33 pruebas, 33 pasan, 0 fallan»; codigo_I3=0, «JSON idéntico a la línea base» → **PASA**

**R.6 Control positivo de la propia auditoría**
- Cifra alterada en copias fuera del árbol (`$TMPDIR/cal_s35h/r/ctl/`, sobre `docs/`): motor 3.5 → 3.6 y vista 23.9 → 23.8.
  - `verificar_contenido_motor.R`: «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)», codigo=1;
  - `i4_data_vista.R`: «identical: FALSE», codigo=1;
  - Python: «sha256 aec5b073d08b11db base 7967dfa07a99ef11 idéntico: False» y «bloque DATA idéntico: False»;
  - `git hash-object`: f18a0953… contra 9e00cdba….

  **Dispara.**
- Archivo fuera de alcance en un diff simulado: `rd_alcance.R` sobre 8 rutas da «fuera: 30_procesamiento/32_agregar_comunal.R, 10_utils/fuentes/gobCL_Bold.otf, 40_salidas/intermedios/simce_rbd.parquet, _archivo/20260925_capturas_s35g/x.png, verificar_sin_textbox.R, 30_procesamiento/36_generar_trayectorias.R» (acepta la plantilla del motor y `docs/index.html`). **Dispara.**
- Además, los instrumentos nuevos dispararon sobre la base:
  - `rd_m1.R`: modal fuera en 12 de 24;
  - `rd_m2.R`: hasta 23 celdas con desborde y `scrollX` de 9;
  - DSF 3: 25 fuera;
  - `rd_m4.R`: 801 = `system-ui`;
  - `rd_v.R`: V1, 3 pares distintos; V2, 8 planos bajo 384.

**R.7 Veredicto por hallazgo.**
- BLOQUEA: ninguno.
- REPARA: ninguno. R-39 y R-40 son defectos previos al encargo, y corregirlos rompería un criterio del propio encargo («0 píxeles contra la base» de V2; «sobre 640 px nada cambia» de M2): no son reparaciones de este trabajo. El error del simulador (I-10) era del instrumento y se corrigió antes de registrar el invariante.
- ADVIERTE: R-39 a R-50 (tabla R.10). No se corrigen.

**R.8 Ciclo de reparación.** No aplica (0 REPARA).

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado ni ALCANCE, y no se tocó ningún 🔒. Evidencia editada después de escrita: el número de la duda de las cohortes (Q-66 → Q-64), para que las dudas queden en orden. Se hizo al cerrar FASE 0, antes de la sección siguiente, y se declara aquí.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1-H4 | `fetch`, `rev-parse` completo, `stash list`, blobs de cefa729 | §2 | iguales | — | ninguna | — | — |
| R-02 | T0 `b3cc432` | `diff-tree --numstat`, padre | 3 rutas; padre cefa729 | así | — | ninguna | — | — |
| R-03 | H5, H6 y D0-a | `rd_inv.py` (Python); R.5 | solo la fecha difiere; 0; 33 | así | ADVIERTE (R-42) | registrar | — | — |
| R-04 | comparadores de I-3 e I-4 | R.6 (R, Python, `hash-object`) | disparan | disparan | — | ninguna | — | — |
| R-05 | capturas deterministas | md5 de PNG | iguales | 24/24 | — | ninguna | — | — |
| R-06 | calibración de M1 | `rd_m1.R` sobre la base (otros tamaños, `offsetLeft`) | modal fuera | 12/24 fuera | — | ninguna | — | — |
| R-07 | calibración de M2 y 112 px | `rd_m2.R` sobre la base; `measureText` | desbordes; 112 | 17-23 celdas; 111,64 → 112 | — | ninguna | — | — |
| R-08 | calibración de M3 | DSF 3 sobre la base | fuera | 25 de 26 | — | ninguna | — | — |
| R-09 | calibración de M4 | `rd_m4.R` (R, archivo descargado) | 801 | 801 | — | ninguna | — | — |
| R-10 | calibración de V1 | `rd_v.R` sobre la base (otros pares) | algún par distinto | 3 de 12 | — | ninguna | — | — |
| R-11 | calibración de V2 | `rd_v.R` sobre la base (otros anchos y altos) | planos bajo 384 | 8 de 30 | — | ninguna | — | — |
| R-12 | M1 | `rd_m1.R` (`scrollLeft`, `offsetLeft`, captura, `elementFromPoint`, pistas) | dentro; activas; pie; 1 pista | 24/24 en cada uno | — | ninguna | — | — |
| R-13 | alcance de `df73a45` | `diff-tree --numstat` | el motor | 15/0 | — | ninguna | — | — |
| R-14 | M2 | `rd_m2.R` (`scrollWidth` de celdas, `scrollX`) | 0 desbordes bajo 641 | 0 en 8; 1 a 641 con 5 | ADVIERTE (R-40, R-41) | registrar | — | — |
| R-15 | alcance de `a653259` | `diff-tree --numstat` | el motor | 14/1 | — | ninguna | — | — |
| R-16 | M3 con y sin soporte | DSF 3; CSSOM | dentro; altos iguales | 118/118; 28/28 | ADVIERTE (R-44, R-45) | registrar | — | — |
| R-17 | alcance de `52bab39` | `diff-tree --numstat` | el motor | 35/1 | — | ninguna | — | — |
| R-18 | M4 | `rd_m4.R` sobre el PNG descargado | 705 (gobCL-sitio) | 705 | ADVIERTE (R-47) | registrar | — | — |
| R-19 | alcance de `206cb3a` | `diff-tree --numstat` | el motor | 64/28 | — | ninguna | — | — |
| R-20 | V1 | `rd_v.R` (otros pares, `offsetWidth`) | iguales con inicial y 2027 | 8/8; 2029, 4 distintos | ADVIERTE (R-39) | registrar (Q-65) | — | — |
| R-21 | alcance de `1458285` | `diff-tree --numstat` | la vista | 5/1 | — | ninguna | — | — |
| R-22 | V2 | `rd_v.R` (otros anchos y altos, pistas); presentación a 823 | ≥ 384; 1 pista con la clase; presentación igual | 30/30; 30/30; 0 px | ADVIERTE (R-46) | registrar (Q-64) | — | — |
| R-23 | alcance de `0f06bc8` | `diff-tree --numstat` | la vista | 36/5 | — | ninguna | — | — |
| R-24 | `docs/` = `40_salidas/`; red; datos | `hash-object`, `ls-tree`; `rd_inv.py` | iguales; 0; idénticos | iguales; 0; idénticos | — | ninguna | — | — |
| R-25 | alcance de `78abd6b` | `diff-tree --numstat` | 2 rutas | 2 | — | ninguna | — | — |
| R-26 a R-35 | I-1 a I-10 | R.3 y re-derivaciones | PASA | PASA | ADVIERTE (R-49: el simulador de I-10) | registrar | — | — |
| R-36 | alcance global | `rd_alcance.R` y `status` | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-37 | regresión | R.5 | 0; ≥ 33; idéntico | 0; 33/33; idéntico | — | ninguna | — | — |
| R-38 | medidas nuevas con nombre | `git diff` de las plantillas, revisión a mano | solo en constantes | así | — | ninguna | — | — |
| R-39 | `rebuild()` (cambio de cohorte) mide la tarjeta desde el ancho anterior, sin volver `--cardw` al valor por omisión: 2027 → 2018 deja 403 (carga nueva 317) y un clic sobre la cohorte activa, 323. V1 imita `trasFuentes()` y tras un cambio de ancho mide desde el valor por omisión, así que la 2029 da 323 y su «carga nueva» (con clic), 329. Con V2, la clase sigue el ancho que la tarjeta tiene de verdad (a 823, la 2018 con un clic pasa a una columna). Reiniciar `--cardw` en `rebuild()` cambia la tarjeta de 7 cohortes en 5-8 px y rompe el criterio de 0 píxeles de V2. Previo al encargo | `ruta_cohorte.R`; `v/opcion1/`; `rd_v.R` | — | así | ADVIERTE | registrar (Q-65) | — | — |
| R-40 | con 5 territorios, de 641 a unos 686 px (sobre el corte de 640, donde «nada cambia»), la columna mide menos que el nombre más ancho (102,59 px a 641) y PUCHUNCAVÍ sale hasta ~9 px de su celda, como en la base | `rd_m2.R` | — | 1 celda a 641 en las dos | ADVIERTE | registrar (Q-66) | — | — |
| R-41 | a 375 px, M2 cambia 1.002 píxeles de la ventana de arriba de `#comparacion` (esquinas y rótulos; máximo 3/255 por canal), en forma estable; invisible | `comparar.R` | — | así | ADVIERTE | registrar | — | — |
| R-42 | H6: el md5 del motor difiere del de `docs/` por `meta$fecha_generacion` (la sesión empezó pasada la medianoche); el esperado literal de H6 no se cumplió y la sesión siguió (D0-a) | `rd_inv.py` | — | solo la fecha | ADVIERTE | registrar | — | — |
| R-43 | el motor admite 5 territorios; el caso de 6 de M2 se midió en una copia con el tope en 6 (D0-c) | — | — | — | ADVIERTE | registrar (Q-63) | — | — |
| R-44 | con soporte, «Ver establecimientos» pasa de 27 a 24 px y el tooltip de 301 a 298 (la «▸» de la fuente del sistema alargaba la línea); sin soporte, 27 como antes (D-M3-a) | sonda; CSSOM | — | así | ADVIERTE | registrar | — | — |
| R-45 | «posición igual a la base» del inventario se evaluó también contra el build de M2: a 375 px, 5 controles se movieron con M1 y M2, no con M3 (D-M3-b) | `verificar_centrado.R` sobre tres builds | — | Δ 0 contra M2 | ADVIERTE | registrar | — | — |
| R-46 | a 823 px pasan a una columna seis cohortes que quedaban entre 4 y 12 px bajo `ANCHO_PLANO_MIN`, además de la 2027; con la 2027, también de 1024 a 1027 px (D-V2-d, D-V2-e) | `v_medir.R v2`; `rd_v.R` | — | así | ADVIERTE | registrar (Q-64) | — | — |
| R-47 | el PNG con gobCL se midió solo en Chrome 153; en Chrome, `decode()` no cambia el resultado (el `load` ya espera las fuentes `data:`). En Safari y Firefox no se midió: un lienzo contaminado por la imagen con fuentes haría fallar `toBlob`, con el aviso de siempre | `m4/sin_decode` | — | 22/22 sin `decode()` | ADVIERTE | registrar (revisión del titular) | — | — |
| R-48 | todo se midió en Chrome 153 sin cabeza; sin WebKit, Firefox ni un teléfono real en la sesión (modal y supergrid al tacto, centrado en Safari) | — | — | no medible | ADVIERTE | registrar (revisión del titular) | — | — |
| R-49 | errores propios en instrumentos, corregidos antes de registrar resultados: `ti[-seq_len(0)]`; píxeles aislados en la caja de M4; el borde del campo y el anillo de foco en el medidor de centrado; la captura de la 2018 con un clic; la constante `FAMILIA_SITIO` declarada dos veces (el build falló antes de escribir salidas); el simulador que tomaba un `<style>` del JavaScript en I-10 | — | — | corregidos | ADVIERTE | registrar | — | — |
| R-50 | no se creó CLAUDE.md (regla global frente a `.gitignore`, que lo excluye como gobernanza del Project, y al ALCANCE cerrado; D2 en §11), como en s35 a s35g | — | — | D2 | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA ni REPARA. Las 38 afirmaciones del inventario quedan CONFIRMADAS con instrumentos distintos (R-20 con la advertencia R-39, fuera del criterio), con controles positivos que dispararon. Hay 12 ADVIERTE (R-39 a R-50), ninguno sobre datos ni invariantes; los prioritarios para el titular son R-39 (Q-65), R-40 (Q-66) y R-48 (revisión en Safari y en un teléfono).

## Cierre

### 1. Resumen

Seis arreglos, todos en el primer intento salvo M1 (segundo), todos publicados en `docs/`:
- **M1 (Q-55).** Bajo 640 px el modal «Agregar territorio» toma el ancho del fondo, el formulario va en una columna y las 6 pestañas se desplazan dentro de su fila. A 375 y 414 px, 0 elementos visibles fuera de la ventana (antes, 19 a 51 por pestaña), con las 6 pestañas pulsables y el pie visible. Sobre 640 px, 0 píxeles distintos.
- **M2 (Q-34, Q-43).** Bajo 640 px cada columna del supergrid mide al menos 112 px (`--supergrid-col-min`), y el supergrid se desplaza en horizontal dentro de sí mismo. A 375 y 414 px, con 1, 2, 4, 5 y 6 territorios, 0 textos fuera de su celda (antes, 45 de 64 con 4). Las sparklines miden 90 px (antes 43), y la página ya no desborda con 5 o 6 territorios (antes, hasta 49 px).
- **M3 (Q-57).** Las pestañas y el campo del modal, los rótulos de exportar y «Ver establecimientos» quedan centrados, dentro de la guarda `@supports`: 28 de 28 dentro de ±2 px (antes, 25 de 26 fuera). El inventario de s35f no cambia, y sin `text-box` los altos son los de antes.
- **M4 (Q-31).** El PNG exportado incrusta las `@font-face` de gobCL-sitio, leídas de la página: el texto del PNG tiene la tinta de gobCL (antes, la de `system-ui`). El SVG exportado no cambia.
- **V1 (Q-52).** Al cambiar de ancho, la vista vuelve a medir la tarjeta: `--cardw` es el de una carga nueva en 6 de 6 pares (antes, 4 de 6).
- **V2 (Q-51).** Si en dos columnas el plano mediría menos de 384 px (`ANCHO_PLANO_MIN`), la vista pasa a una columna. De 823 a 1023 px, el plano mide 384 o más con todas las cohortes (antes, 179 a 379 con la 2027).

FASE R confirmó las 38 afirmaciones con instrumentos distintos y registró 12 advertencias. Veredicto: APROBADO CON ADVERTENCIAS.

### 2. Inventario de commits (`git log --oneline b3cc432^..HEAD`, que incluye T0)

```text
78abd6b deploy(docs): pantallas angostas, centrado restante y PNG con gobCL
0f06bc8 fix(trayectorias): una columna cuando la tarjeta deja el plano angosto (Q-51)
1458285 fix(trayectorias): la tarjeta se vuelve a medir al cambiar el ancho (Q-52)
206cb3a fix(motor): el PNG exportado incrusta gobCL (Q-31)
52bab39 fix(motor): centrado optico de pestañas, campo, exportar y tooltip (Q-57)
a653259 fix(motor): el supergrid se lee en pantallas angostas (Q-34, Q-43)
df73a45 fix(motor): el modal de territorio cabe en pantallas angostas (Q-55)
b3cc432 docs(sesion 35): encargo de la octava ola y decisiones D35-11 a D35-13
```

Más el commit de este log (`docs(log): pantallas angostas, centrado restante y PNG (s35h)`) y, después de P3, el de `docs(log): P3 de s35h`; sus hashes van en la sección FASE P3 y en el reporte final.

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-50).

### 4. Invariantes

I-1 a I-10 en PASA en el estado final `78abd6b` (FASE R, R.3), con re-derivaciones por otra vía (R.2). En ningún cierre de tarea un 🔒 dio FALLA.

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 del encargo (697919992d09c443f9e0ee55e6f263cc, verificado).
- En el encargo: D35-11 a D35-13 (commiteadas en T0).
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión con Rscript y chromote, Chrome 153)

- Modal a 375 × 740: elementos visibles fuera de la ventana por pestaña 19/26/50/51/22/22 → 0 (a 414: 19/26/47/44/21/37 → 0); pie visible 0/12 → 12/12; modal de x = −82,5 a 457,5 → de 20 a 355.
- Supergrid a 375 px, 4 territorios: columnas 64,75 → 112; sparklines 42,75 → 90; textos fuera 45 de 64 → 0; con 5 y 6 territorios, página de 381 y 391 px → 375.
- Centrado de Q-57 (px de dispositivo a DSF 2), 1280/375: pestañas −3,72…−3,33 → +0,28…+0,67; campo −3,30 → +0,70; exportar −5,22…−4,98 (1280) y −7,36…−5,17 (375) → −1,22…+0,64; «Ver establecimientos» +2,82/+0,52 → +0,82/+1,70 (24 px de alto, antes 27). Inventario: 90/90, sin cambios.
- PNG (px de PNG): «VIÑA DEL MAR» 205 → 177, título 801 → 705, panorama 104 → 89 y 912 → 800 (gobCL-sitio 177/705/89/800; `system-ui` 205/801/104/912).
- `--cardw` de 640 a 1024 px: 437 → 317 con la cohorte inicial (carga nueva 317) y 540 → 522 con la 2027 (522).
- Plano de 823 a 1023 px: mínimo 179 (la 2027 a 823) → 384; `ANCHO_PLANO_MIN` = 384.
- Salidas finales: motor fe30d56f866d082501bd8937a24f752e y vista 69357a69dc04db6186e75d3245c6b873, iguales en `docs/` (blobs 9e00cdba… y f05d894b…). JSON del motor y `DATA` de la vista idénticos a la base (sha256 7967dfa07a99ef11). Validador del build: 0 críticas y 7 advertencias. Batería 33/33.
- `docs/` antes: 7f5971a3… y 523ce765…; después: fe30d56f… y 69357a69….

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno.

Dudas nuevas, con pregunta cerrada:
- Q-63 (R-43). El motor admite hasta 5 territorios (`MAX_ENTIDADES = 5`) y el criterio de M2 pedía 6; se midió 5 en el producto y 6 en una copia con el tope en 6. ¿Se sube el tope a 6, o los próximos encargos piden 5? (subir el tope / pedir 5)
- Q-64 (R-46). Con `ANCHO_PLANO_MIN` = 384, a 823 px pasan a una columna 7 de 9 cohortes; seis de ellas quedaban solo entre 4 y 12 px bajo el mínimo (372 a 380). ¿Se deja así, o `ANCHO_PLANO_MIN` pasa al mínimo de las cohortes sin la 2027 (372), para que solo la 2027 cambie? (dejar 384 / 372)
- Q-65 (R-39, previa al encargo). Al cambiar de cohorte, `rebuild()` mide la tarjeta desde el ancho anterior: 2027 → 2018 deja 403 px (carga nueva 317) y el plano, 298 en dos columnas; con V2 esa vista pasa a una columna. ¿Se reinicia `--cardw` también en `rebuild()`, como en `resize` y `trasFuentes()`? Cambiaría el ancho de la tarjeta de 7 cohortes en 5 a 8 px respecto de hoy. (sí / no)
- Q-66 (R-40, previa al encargo). Con 5 territorios, de 641 a unos 686 px, el supergrid no tiene mínimo de columna y PUCHUNCAVÍ sale hasta ~9 px de su celda. ¿Se sube el corte del supergrid de 640 a ~690 px? (sí / no)

Revisión pendiente del titular (R-47, R-48): el sitio en Safari y en un teléfono real (modal y supergrid al tacto, centrado de Q-57); un PNG exportado desde Safari.

Pendientes fuera del encargo (§11): Q-39 (s35i), v30-5 (s35i), Museo Sans en la suite, los pendientes 8, 10, 12 y 13 de v34, CLAUDE.md (D2; no se creó: `.gitignore` lo excluye y el ALCANCE es cerrado). Ninguna tarea tocó Q-61, Q-62, Q-60, Q-56, Q-42, Q-29 ni Q-21 (cerradas o aceptadas en D35-11 y D35-12).

`# REVISAR` nuevos: ninguno (`git diff b3cc432..HEAD | grep -c "^+.*REVISAR"` = 0).

### 8. Errores propios consolidados

- Instrumentos, corregidos antes de registrar resultados:
  - `m4_medir.R` con `ti[-seq_len(0)]` (vector vacío en R);
  - la caja de diferencias de M4 tomaba píxeles aislados lejos del texto; se acotó a una ventana;
  - el medidor de centrado leía como tinta el borde del campo y el anillo de foco (D0-e; inventario idéntico con el cambio);
  - la primera tanda de capturas de V2 elegía la cohorte inicial con un clic (otro camino que FASE 0);
  - el simulador sin `text-box` tomaba como CSS el `<style>` que M4 arma en el JavaScript (I-10 en FASE R).
- Producto, corregido antes del commit: en M4 declaré `FAMILIA_SITIO`, que ya existía. El build falló antes de escribir salidas; se reutilizó la constante existente.
- Ninguno tocó lo publicado.

### 9. Notas para el revisor

- En un teléfono (375-414 px de ancho):
  - «Agregar territorio» debe verse entero, con las pestañas deslizables en una fila y «Cancelar / Agregar al análisis» a la vista;
  - el supergrid de «Comparación entre territorios» debe deslizarse de lado dentro de sí mismo, sin mover la página, con cada nombre dentro de su columna.

  Referencias: `_archivo/20260925_capturas_s35h/s35h_m1_*` y `s35h_m2_*`.
- En Safari 18.2+: las pestañas y el campo del modal, los rótulos de exportar (con el foco del teclado) y «Ver establecimientos» del tooltip fijado, centrados (`s35h_m3_*`). En Safari anterior o en Firefox < 154: los mismos controles, con el alto de antes.
- Exportar PNG desde Safari (supergrid y panorama): el texto debe salir en gobCL (`s35h_m4_png_supergrid_encabezado_{antes,despues}.png`). Si Safari no deja generar el PNG, aparecerá «No se pudo generar el PNG» (R-47).
- La vista de trayectorias en una ventana de 823-1023 px con la cohorte 2027: la tabla arriba y el plano abajo, a todo el ancho (`s35h_v2_*`). También al cambiar el ancho de la ventana sin recargar.
- Q-63 a Q-66.

### 10. Estado de cierre

- **Commiteado:** 8 commits del encargo (T0, M1, M2, M3, M4, V1, V2 y PUB) más el de este log, en `main`.
- **Condiciones de publicación medidas antes del commit de este log** (autorización 4):
  - veredicto de FASE R `APROBADO CON ADVERTENCIAS`;
  - `git fetch origin` fetch_codigo=0; `origin/main` = `cefa729`;
  - `git merge-base --is-ancestor origin/main HEAD`: se mide justo antes del push;
  - md5 de `docs/` = fe30d56f866d082501bd8937a24f752e y 69357a69dc04db6186e75d3245c6b873, iguales a los de PUB;
  - `git status --porcelain` = solo este log, que queda vacío con su commit.

  El `git push origin main` se corre después de este commit, con `status`, `fetch` y `merge-base` medidos otra vez. Su resultado, P3 (lo que sirve Pages) y el hash de este commit se anexan en la sección FASE P3 (autorización 8), sin reescribir esta. Un archivo no puede llevar el hash de su propio commit.
- **Queda al titular:** la revisión en Safari y en un teléfono real (§9) y las dudas Q-63 a Q-66.
- **Verificación del archivo** (antes del commit):
  - `grep -c '^### FASE'` = 9 (FASE 0, M1, M2, M3, M4, V1, V2, PUB y R; FASE L es este «Cierre» y P3 se anexa después);
  - `grep -c '^esperado:'` = 77 y `grep -c '^obtenido:'` = 75: dos líneas de resultado empiezan con «obtenido (px de PNG; …):», L118 (FASE 0, M4) y L334 (FASE M4), así que `grep -c '^obtenido'` da 77. No se reescribieron: se declara;
  - `grep -c '^## J'` = 1, con el bloque relleno;
  - privacidad: el `grep` del patrón de RUT no halla coincidencias. Tampoco hay nombres de establecimientos (`liceo|escuela|colegio|instituto`: 0) ni de personas; los nombres que aparecen son de comunas y de Servicios Locales.

### FASE P3: lo que sirve Pages (tras el push de FASE L; autorización 8)

- Commit de este log antes de P3: `000d31c` docs(log): pantallas angostas, centrado restante y PNG (s35h).

Push de FASE L. Condiciones medidas después del commit del log, en el mismo turno:
- `git status --porcelain` vacío;
- `git fetch origin` fetch_codigo=0; `origin/main` = cefa729675fd58ea51eb547203072553341a606f;
- `git merge-base --is-ancestor origin/main HEAD` ancestro_codigo=0, con 9 commits por publicar;
- md5 de `docs/` = fe30d56f… y 69357a69…, los de PUB.

Luego `git push origin main`
esperado: push aceptado
obtenido: «cefa729..000d31c  main -> main», push_codigo=0

**P3.** `$TMPDIR/cal_s35h/p3.sh`: cada 60 s, hasta 10 minutos, `curl -s https://tomgc.github.io/slep_simce_adecuado/ | md5 -q` y `curl -s https://tomgc.github.io/slep_simce_adecuado/trayectorias.html | md5 -q`, contra `md5 -q docs/*.html` (salida en `$TMPDIR/cal_s35h/p3.txt`)
esperado: fe30d56f866d082501bd8937a24f752e y 69357a69dc04db6186e75d3245c6b873
obtenido: intento 1 (02:16:27): 7f5971a3… y 523ce765…, la versión anterior; intento 2 (02:17:28): **fe30d56f866d082501bd8937a24f752e y 69357a69dc04db6186e75d3245c6b873**, «COINCIDE en el intento 2». `curl -sI`: HTTP/2 200, `last-modified: Sat, 26 Sep 2026 05:16:44 GMT` en las dos páginas (etag «6ab7553c-2cc54d» y «6ab7553c-21c2ec»).

Cierre con la autorización 8: se agrega esta sección; `git add` del log; `git commit -m "docs(log): P3 de s35h"`; y `git push origin main`, solo si `git diff --name-only HEAD~1..HEAD` muestra únicamente el log y si `fetch` y `merge-base --is-ancestor origin/main HEAD` dan código 0. El hash de ese commit va en el reporte final: un archivo no puede llevar el hash de su propio commit.
