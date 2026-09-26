# Log: navegadores sin text-box, cohortes y tooltip angosto (s35g) (slep_simce_adecuado)

- Meta: que un navegador sin `text-box` vea el sitio exactamente como antes de s35f, que el marcado de las cohortes salga del generador, y que el tooltip no tape el punto a 375 px, todo publicado en Pages.
- Fecha: 2026-09-25 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: 95469aa (commit de T0)
- Encargo: `50_documentacion/activa/encargos/encargo_supports_cohortes_s35g.md`, md5 `6b7d0a7c44e0fb60da747221d16e1eb2` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`); el harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y prevalece: sin subagentes ni Workflow; todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, G1, G2, G3, PUB, FASE R, FASE L con el push, y P3.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Navegador de medición: Google Chrome 153.0.8010.53 (`chromote`), headless; `text-box` disponible desde Chrome 133.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: sin `text-box` el sitio se ve como antes de s35f (simulado en Chrome por texto y por CSSOM: 90 de 90 controles con Δ 0 contra `476b1e1` y 0 píxeles en 32 capturas); con soporte, igual que tras s35f (0 píxeles en 32 capturas, centrado 90/90 idéntico) (G1). El año de las cohortes sale del generador (C6 0/9 → 9/9, DOM de `#c-coh` idéntico) (G2). A 375 y 414 px el tooltip ya no tapa el punto (0 de 12 casos y 0 de 238 del barrido; 0 de 360 en la re-derivación) y a 1280 no cambia (G3). Todo copiado a `docs/` (PUB). El push y lo que sirve Pages van en el reporte final.
- Estado por tarea: FASE 0 completa · T0 completa · G1 completa (intento 1) · G2 completa (intento 1) · G3 completa (intento 1) · PUB completa · FASE R: 0 BLOQUEA, 0 REPARA, 7 ADVIERTE.
- Commits: 95469aa (T0, punto de retorno), 50bb730 (G1), ba1b4be (G2), c8964b6 (G3), 9ef4f2b (PUB), más docs(log) (hash en el reporte final).
- Auditoría (FASE R): sin subagentes. El orquestador re-derivó las 36 afirmaciones con instrumentos distintos (CSSOM de Chrome, JavaScript desactivado, md5 de PNG a otros anchos, `offset*` en cinco tamaños, Python, `hash-object`, segundo patrón de red). Resultado: 36 CONFIRMADA, 0 REFUTADA; controles positivos dispararon; R-37 a R-43 ADVIERTE; veredicto APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-9 PASA en el estado final `9ef4f2b`.
- Cifras críticas: sin `text-box`, menú +6,844 (1280) y +5,188 (375) y botones +4,531 a +5,531 (píldora +11,531) → Δ 0 en 90/90; `grep` fuera de `@supports` 31 → 0; batería 32 → 33/33; tooltip a 375, 2/12 casos y 43/119 del barrido tapan → 0 y 0; 1280, 12/12 y 119/119 iguales; `docs/` 65f2f59b…/713dfa9d… → 7f5971a3…/523ce765…; JSON sha256 7967dfa07a99ef11 sin cambio.
- Decisiones autónomas de mayor riesgo: D-G1-a (11 bloques `@supports`, cada uno tras la regla que modifica, para conservar la cascada de s35f); D-G1-b (fuera, el texto de `476b1e1` byte a byte; `--borde-tab` y `--relleno-territorio` repiten adentro el valor de afuera); D-G3-a (abajo o arriba, el tooltip conserva la posición horizontal de hoy); D-G2-a (C6 lee el HTML escrito con expresiones regulares); D0-a (el worktree enlaza lo ignorado en vez de copiarlo).
- Desviaciones respecto del encargo: ninguna en criterios, tolerancias ni ALCANCE; la batería pasa de 32 a 33 pruebas porque C6 lleva su control plantado dentro; no se creó CLAUDE.md (regla global frente a `.gitignore` y a un ALCANCE cerrado).
- Dudas abiertas: Q-61 (R-38: ¿se mide la guarda en un navegador real sin `text-box`?) y Q-62 (R-39: ¿se centra el tooltip bajo el punto?); siguen Q-60 y, de s35f, Q-55 a Q-57.
- Errores propios: 5 en instrumentos y en el log, y 1 en el producto antes del commit (el separador de C6 sumaba una advertencia al validador del build). Todos se corrigieron antes de registrar resultados o de cerrar su sección, y ninguno tocó lo publicado.
- Qué debe verificar el revisor por sí mismo: en un navegador sin `text-box` (Firefox ESR, Safari < 18.2), el alto del menú y de los botones, que debe ser el de antes de s35f (R-38); en Safari 18.2+, el sitio como tras s35f y los botones de Nivel y Prueba (Q-60); el tooltip en un teléfono real; las capturas de `_archivo/20260925_capturas_s35g/`.
- No publicado / queda al usuario: la revisión en navegadores reales y en un teléfono; Q-60 a Q-62. El push y P3 se informan en el reporte final.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite aunque el harness tenía «ultracode» activo); medición en Chrome 153 headless; sin WebKit ni Firefox en la sesión.

### FASE 0: log, punto de retorno y premisas

Paso 1: log creado antes de H1. Por eso H1 muestra también la línea del propio log.

**H1.** `git -C "$RAIZ" status --porcelain`
esperado: solo `?? 50_documentacion/activa/encargos/encargo_supports_cohortes_s35g.md`, más el log
obtenido:
```text
?? 50_documentacion/activa/encargos/encargo_supports_cohortes_s35g.md
?? 50_documentacion/andamios/logs/20260925_supports_cohortes_s35g_log.md
```

**H2.** `git -C "$RAIZ" stash list | wc -l`
esperado: 0
obtenido: 0

**H3.** `git -C "$RAIZ" fetch origin` (fetch_codigo=0), luego `git -C "$RAIZ" rev-parse --short HEAD` y `git -C "$RAIZ" rev-parse --short origin/main` en dos comandos
esperado: 6c51362 y 6c51362
obtenido: 6c51362 y 6c51362

**H4.** `md5 -q` del encargo y de `docs/`; además `md5 -q` de `40_salidas/`, de `10_utils/fuentes/*.otf`, el conteo de I-7 y `grep -c '@supports'` en las tres plantillas
esperado: encargo 6b7d0a7c44e0fb60da747221d16e1eb2 (mensaje de entrega); `docs/` 65f2f59b… y 713dfa9d…; fuentes a7407ed6… y 0257bb4b…; 28; 0 en las tres plantillas
obtenido: 6b7d0a7c44e0fb60da747221d16e1eb2; `docs/index.html` 65f2f59bcccd8da57e0aa4aa07a2533c, `docs/trayectorias.html` 713dfa9d1e6750b8562ff0300179b53a (iguales en `40_salidas/`); a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc; 28; `@supports` 0, 0 y 0

**T0.** `git add 50_documentacion/activa/encargos/encargo_supports_cohortes_s35g.md` y `git commit -m "docs(sesion 35): encargo de la septima ola (supports, cohortes, tooltip)"`
esperado: un commit con el encargo
obtenido: `95469aa docs(sesion 35): encargo de la septima ola (supports, cohortes, tooltip)`; `git show --name-status` = `A 50_documentacion/activa/encargos/encargo_supports_cohortes_s35g.md`; `git status --porcelain` = solo este log. **Punto de retorno: 95469aa.**

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"` (salida en `$TMPDIR/cal_s35g/h5.txt`)
esperado: 32 pruebas o más en PASA y codigo=0
obtenido: «Resultado: 32 pruebas, 32 pasan, 0 fallan», codigo_bateria=0

**H6.** `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"` (salida en `$TMPDIR/cal_s35g/h6.txt`)
esperado: codigo=0
obtenido: codigo_build=0; «Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 7 segundos»; motor 65f2f59bcccd8da57e0aa4aa07a2533c y vista 713dfa9d1e6750b8562ff0300179b53a (iguales a `docs/`: build reproducible), `simce_comunal.parquet` 468099a9c63bb3c0ddb74e67e2c7c19f. Las dos salidas se copiaron a `$TMPDIR/base_s35g/` (md5 iguales): es la base de H6.

`verificar_contenido_motor.R` apuntaba a `$TMPDIR/base_s35f/h6/`: se apuntó a `$TMPDIR/base_s35g/` (línea 24 y comentarios de las líneas 3 y 12). El comparador de I-4 se copió a `$TMPDIR/cal_s35g/i4_data_vista.R`, con la base en `$TMPDIR/base_s35g/`. Calibración (`$TMPDIR/cal_s35g/alterar_json_motor.R` y `i4_data_vista.R --alterar`, sobre la base de H6)
esperado: «idéntico» sobre el build y sobre la base; «difiere» sobre la copia alterada
obtenido: motor «fragmento original: 3.5 -> alterado: 3.6»; build codigo_actual=0 «JSON idéntico a la línea base»; base codigo_base=0 «JSON idéntico a la línea base»; copia codigo_alterado=1 «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)». Vista «fragmento original: 23.9 -> alterado: 23.8»; build «identical: TRUE» (codigo 0); copia «identical: FALSE» (codigo 1)

Capturas de la base (`$TMPDIR/cal_s35g/capturas.R`, dos cargas independientes: `$TMPDIR/base_s35g/cap_a/` y `cap_b/`). Por ancho (1280 y 375 px, ventana de 900 de alto, barras superpuestas): página completa de `#comparacion`, `#panorama` y la vista a DSF 1; la ventana de arriba (encabezado, menú y controles) de las tres a DSF 2; el modal «Agregar territorio» en la pestaña «Comuna» y las notas de la vista abiertas (ventana, DSF 1); espera de 3 s a 1280 y de 12 s a 375 tras `document.fonts.ready`; cajas de las regiones y de los controles en `rects.rds`. Comparador: `$TMPDIR/cal_s35g/comparar.R` (píxeles distintos en total y en la región «encabezado + menú + barra de controles», de y = 0 al borde inferior de `.controls-bar`, `.territorio-row` o `.ctls`)
esperado: (sin esperado previo; se registra el ruido entre cargas)
obtenido: 16 capturas por carga; `cap_a` contra `cap_b`: 0 píxeles distintos en las 16 (páginas de 3.601, 1.289 y 1.119 de alto a 1280; 4.338, 2.335 y 2.133 a 375). **Base determinista.**

Centrado de la base (`Rscript verificar_centrado.R` sobre `$TMPDIR/base_s35g/`, resultados en `$TMPDIR/cal_s35g/centrado_base.rds`)
esperado: 90 de 90 dentro de ±2 px de dispositivo (el estado final de s35f)
obtenido: «90 controles medidos | en criterio 90 | fuera 0»; dif de −1,57 a +1,54

**Paso 8. Referencia «antes de s35f».** `git worktree add --detach $TMPDIR/wt_476b1e1 476b1e1` (autorización 8). El worktree no trae lo ignorado: se enlazaron (symlink, sin copiar datos) `renv/library` y `20_insumos/auxiliares/directorio_oficial_ee.csv` del árbol principal. Luego `cd $TMPDIR/wt_476b1e1 && Rscript 00_build.R` (salida en `$TMPDIR/cal_s35g/ref_build.txt`) y copia de las dos salidas a `$TMPDIR/ref_476b1e1/`
esperado: codigo 0; datos iguales a la base de H6
obtenido: codigo_build_ref=0 («Fallas criticas: 0 | Advertencias: 7»); motor 6825812fc6f9a408f00400c202f2f9af y vista 1067908ec09ce95dbee692b9696da7fa, los mismos md5 que la base de H6 de s35f (con el tooltip de T0 y sin el ajuste de TT ni el centrado); `simce_comunal.parquet` 468099a9…; `verificar_contenido_motor.R` sobre el motor de la referencia «JSON idéntico a la línea base»; I-4 sobre la vista «identical: TRUE». Como los datos son idénticos, las capturas de la referencia se pueden comparar píxel a píxel con las del trabajo. Capturas con los mismos anchos y estados en `$TMPDIR/ref_476b1e1/cap_a/` (16).

**Paso 9. Simulador de navegador sin soporte.** `verificar_sin_textbox.R` (raíz, ignorado; sin rutas absolutas). Toma un HTML generado, escribe una copia en `$TMPDIR` y en su CSS (bloque `<style>`):
- reemplaza la condición de todo `@supports (text-box: trim-both cap alphabetic)` por `@supports (text-box: no-existe)`;
- borra cada declaración `text-box` (y sus longhands) que quede fuera de un `@supports`, con un escáner que enmascara comentarios y cadenas y ubica los bloques `@supports` por sus llaves.

Después abre la copia con chromote y mide alto y posición de los 45 controles por ancho del inventario de s35f, más el menú (`medir_todo()` de `verificar_centrado.R`, a 1280 y 375 px, DSF 2). Constante nueva: `TOLERANCIA_ALTO` 0,5 px. Modos: `medir` (sin transformar, para la referencia), `comparar` y `grep` (apariciones fuera de `@supports` en el CSS de un archivo: el criterio de G1). La referencia se midió con `Rscript verificar_sin_textbox.R medir $TMPDIR/ref_476b1e1 $TMPDIR/ref_476b1e1/altos.rds` (90 controles).

Calibración: el simulador sobre la base de H6 (sin `@supports`), contra `ref_476b1e1` (`$TMPDIR/cal_s35g/sim_calibracion.txt`)
esperado: el defecto de Q-59: el menú o los botones miden entre 4 y 7 px más que en `ref_476b1e1`
obtenido: la copia borra 4 declaraciones `text-box` en el motor y 2 en la vista (0 condiciones reemplazadas: la base no tiene `@supports`). Altos contra la referencia: menú +6,844 (1280) y +5,188 (375) en las tres vistas; segmentados (Nivel y Prueba, y Nivel oscuro) +5,188; «Agregar territorio» y los `.btn` del modal +5,188; botón de niveles +5,531; notas +4,531; píldora «Recalculando…» +11,531; «Cobertura» a 375 px +4,875 en uno de los dos; sin cambio los controles de alto fijo (`select`, territorio, cohortes, `.num`, botones de la vista). 45 de 90 fuera de |Δ| ≤ 0,5; Δ y de −2,594 a +36,656. Píxeles contra la referencia a 1280 (`comparar.R`): región «encabezado + menú + barra de controles» con 23.965 (comparación), 22.595 (panorama) y 66.259 (vista) píxeles distintos; páginas de 3.624, 1.300 y 1.118 de alto contra 3.601, 1.289 y 1.119. **El simulador da el defecto de Q-59.**

Calibración del `grep` de G1 (`Rscript verificar_sin_textbox.R grep` sobre las tres plantillas actuales, `$TMPDIR/cal_s35g/grep_calibracion.txt`)
esperado: cada aparición conocida de `text-box`, `1cap`, `lh` y `round(` (el `grep -n` de §2), fuera de `@supports`
obtenido: 31 apariciones fuera de `@supports` con comentarios (23 declaraciones): fragmento L48, 53, 54; motor L116, 119, 120, 126, 185, 186, 219, 225, 313, 318, 320, 977, 1105, 1120; vista L48, 50, 55, 56, 109, 112, 116. Coinciden con las líneas del `grep -n` crudo. **Dispara.**

**Compuerta de dudas previa al acto público** (SETTINGS §2.1, gatillo 2). Dudas abiertas antes de publicar, y la tarea que mide cada una:
- ¿un navegador sin `text-box` ve el sitio como antes de s35f, sin cambiar lo que ve uno con soporte? → G1;
- ¿el marcado de las cohortes sale del generador sin cambiar el DOM? → G2;
- ¿el tooltip deja de tapar el punto a 375 px sin cambiar lo de 1280? → G3;
- ¿lo publicado en `docs/` es idéntico a lo construido? → PUB; ¿Pages lo sirve? → P3.

**Cierre de FASE 0.**
- Estado: completa. H1 a H6 dan lo esperado; la referencia y el simulador están calibrados.
- Commits: `95469aa` docs(sesion 35): encargo de la septima ola (supports, cohortes, tooltip) (T0, punto de retorno).
- Cambios sustantivos: ninguno en el producto. `verificar_contenido_motor.R` (ignorado) apunta a `$TMPDIR/base_s35g/`; `verificar_sin_textbox.R` (ignorado) es nuevo.
- Alcance: T0 tocó solo el encargo.
- Regresión: H5 y H6 son la regresión de partida.
- Subagentes: ninguno (el encargo no los admite).
- Bugs: ninguno.
- Decisiones autónomas: D0-a (riesgo bajo): el worktree de la referencia enlaza `renv/library` y el directorio oficial en vez de copiarlos (el directorio trae MRUN: no se duplica). D0-b (riesgo bajo): el simulador mide con el inventario y el medidor de s35f (`medir_todo()`), que dan alto y posición a DSF 2 en los mismos estados (modal, píldora, notas); el `grep` de G1 mide sobre el CSS de cada archivo (bloque `<style>` o región `SITIO_CSS` del fragmento), porque `round(` aparece como `Math.round(` en el JavaScript; se informa con comentarios y sin ellos, y agrega los tokens y las clases del centrado.
- Errores propios: el primer `comparar.R` no comparaba la región cuando las páginas tenían altos distintos (daba NA); se corrigió antes de registrar resultados.
- Dudas: ninguna.

### FASE G1: guarda `@supports` (Q-59)

- Estado: completa, en el primer intento.
- Commits: `50bb730` fix(sitio): el centrado optico solo aplica con soporte de text-box (Q-59).

**Cambios.** En las tres plantillas, cada regla que `fa89e7c` agregó o cambió para el centrado quedó así: fuera, la regla de `476b1e1` tal cual (`git show 476b1e1:<ruta>`); inmediatamente después, un bloque `@supports (text-box: trim-both cap alphabetic) { ... }` con lo de s35f. Al ponerlo a continuación de la regla que modifica, conserva el mismo lugar en la cascada que tenía en s35f frente a las reglas posteriores (medias, `:hover`, `.is-on-dark`).
- Fragmento (2 bloques): `.view-tab` (`--relleno-tab`, `--borde-tab`, el relleno con `--compensa-recorte`, `min-height` con `1lh`, `text-box`) y su variante de pantallas angostas, anidada en el `@media (max-width: 640px)`. Fuera: `padding: 14px 18px` y `border-bottom: 3px solid transparent`, y en la media `padding: 12px 10px`.
- Motor (6 bloques): los tokens `--compensa-recorte`, `--ajuste-optico-select` y `--holgura-tinta` (un `:root` dentro del bloque); `.segmented-btn`; la regla `.select`; `.control-texto`; `.gse-filter select`; `.territorio-select` (`--relleno-territorio` y `height`) y `.territorio-select-name` (`text-box`, `padding-block`, `margin-block`). Fuera: `padding: 6px 14px`, `4px 22px 4px 8px` y `9px 14px`, y el nombre sin recorte.
- Vista (3 bloques): los tokens (`:root`); `.tx` y `#c-coh button` con `align-items: baseline`; el relleno de `select`. Fuera: `padding: 0 30px 0 12px`.
- Los comentarios del centrado pasaron adentro de los bloques. Los `<span class="control-texto">` y `<span class="tx">` del marcado quedan: fuera de los bloques no tienen estilo.

Fuera de los bloques, igual a `476b1e1` (`perl -0777 -pe 's/\n?[ \t]*\@supports \(text-box: trim-both cap alphabetic\)\s*(\{(?:[^{}]++|(?1))*\})//g' <plantilla>` y `diff` contra `git show 476b1e1:<plantilla>`)
esperado: el CSS idéntico; solo las diferencias de marcado de s35f (los `<span>`), las 5 líneas de TT (`6f74d70`) y la reescritura de las cohortes (G2)
obtenido: fragmento, sin diferencias; motor, una línea en blanco de más (L284, entre `.entities-actions` y `/* Buttons */`, donde estaba el bloque de `.control-texto`), los 7 `<span className="control-texto">` y las 5 líneas de TT; vista, los `<span class="tx">` (Cobertura ×2, notas, Cerrar, `.num`, `#b-det`) y la reescritura de las cohortes (L1126-1132). Ninguna regla CSS distinta.

**Criterio: `grep` fuera de `@supports`.** Comando: `Rscript verificar_sin_textbox.R grep 30_procesamiento/33_fragmento_sitio.html 30_procesamiento/33_motor_template.html 30_procesamiento/36_trayectorias_template.html` (CSS de cada archivo; patrones `text-box`, `1cap`, `lh` como unidad, `round(`, más `--compensa-recorte`, `--ajuste-optico-select`, `--holgura-tinta`, `.control-texto` y `.tx`; con comentarios y solo declaraciones; salida en `$TMPDIR/cal_s35g/g1/grep_g1.txt`)
esperado: 0 apariciones fuera de un bloque `@supports`
obtenido: «fuera de @supports: 0 apariciones (con comentarios) | 0 declaraciones»; bloques 2, 6 y 3; dentro: fragmento `text-box` 5, `lh` 1; motor `text-box` 17, `1cap` 2, `lh` 6, `round(` 2; vista `text-box` 9, `1cap` 2, `lh` 3, `round(` 2 (con comentarios). **Cumple.** (Calibración en FASE 0: 31 apariciones fuera antes del cambio.)

Build del intento 1 (`Rscript 00_build.R`, salida en `$TMPDIR/cal_s35g/g1/build_i1.txt`; salidas copiadas a `$TMPDIR/cal_s35g/g1/i1/`)
esperado: codigo 0
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor 67054385155728677d33e3366870feeb, vista 6c542095b3ed20a6e3960d5967df6dc2; 8 condiciones `@supports` en el motor y 5 en la vista (el fragmento va en las dos)

**Criterio con soporte (I-9).** Capturas del intento 1 (`capturas.R`, mismos anchos y estados que la base) contra la base de H6 (`cap_a`), con `comparar.R` (`$TMPDIR/cal_s35g/g1/pix_con_soporte.txt`)
esperado: 0 píxeles distintos en las tres vistas a 375 y 1280 px, más el menú y los controles
obtenido: 15 de 16 capturas en 0. `comparacion_375.png`, 10.181 distintos en las filas 3315-4184 (la tabla, fuera de la región de controles; región 0). Otra captura del mismo build (`cap2`) da 0 contra la base, y las dos capturas del mismo build difieren entre sí en los mismos 10.181: es el ruido conocido de la captura de `#comparacion` a 375 px, no el cambio. Con la segunda captura, 16 de 16 en 0. **Cumple.**

`Rscript verificar_centrado.R` sobre el intento 1 (`$TMPDIR/cal_s35g/g1/centrado_i1.rds`)
esperado: 90 de 90 dentro de ±2 px de dispositivo
obtenido: «90 controles medidos | en criterio 90 | fuera 0»; dif de −1,57 a +1,54; contra la base de H6, dif, alto y posición iguales en los 90 (máximo |Δ| 0,000, 0,0000 y 0,0000). **Cumple.**

**Criterio sin soporte.** `Rscript verificar_sin_textbox.R $TMPDIR/cal_s35g/g1/i1/motor_comparacion.html $TMPDIR/cal_s35g/g1/i1/trayectorias_traspasos.html $TMPDIR/sin_textbox/g1_i1 $TMPDIR/ref_476b1e1/altos.rds` (`$TMPDIR/cal_s35g/g1/sim_i1.txt`)
esperado: alto de cada control del inventario de s35f y del menú igual al de `ref_476b1e1` (|Δ| ≤ 0,5 px)
obtenido: copia del motor con 8 condiciones reemplazadas, 0 declaraciones `text-box` borradas fuera de `@supports` y 12 dentro; de la vista, 5, 0 y 7. «90 controles emparejados | |Δ alto| <= 0.5: 90 | fuera 0 | Δ alto 0.0000 a 0.0000 | Δ y 0.0000 a 0.0000 | Δ x 0.0000 a 0.0000». Además, el centrado medido es el de la referencia en los 90 (dif de −6,94 a −2,50, máximo |Δ| 0,000). Altos por grupo, con soporte → sin soporte (= referencia), 1280/375: menú 50/43 → 50/43; Nivel y Prueba 28; «Agregar territorio» y botones del modal 32; niveles E e I 27; GSE 25; notas 38; píldora 29; `.select` 30; territorio 39; Nivel oscuro 28; cohortes 34; `select` de la vista 40; Cobertura 40 (a 375, 44 y 40); notas y Cerrar 40; desglose 32; `.num` 22. **Cumple.**

Píxeles sin soporte: capturas de la copia simulada (`$TMPDIR/sin_textbox/g1_i1/cap/`) contra `ref_476b1e1/cap_a` (`$TMPDIR/cal_s35g/g1/pix_sin_soporte.txt`)
esperado: 0 píxeles distintos en el encabezado, el menú y la barra de controles de las tres vistas a 1280 px
obtenido: región 0, 0 y 0 (comparación, panorama y vista a 1280); además, 0 en las 16 capturas completas (páginas a 1280 y 375, ventanas de arriba a DSF 2, modal y notas). Como los datos son idénticos, no hizo falta la comparación de reserva por alto y posición: la dan igual las mediciones de arriba. **Cumple.**

Calibración: el simulador sobre la base de H6 da el defecto de Q-59 (FASE 0, paso 9: menú +6,844 y +5,188, botones +4,531 a +5,531; región con 23.965, 22.595 y 66.259 píxeles distintos). **Dispara.**

Comprobaciones adicionales:
- I-8 (`$TMPDIR/cal_s35g/i8.R`, copia del de s35f): intento 1 «I-8 PASA» (12 de 12) y copia simulada «I-8 PASA».
- I-3 e I-4 sobre el intento 1: «JSON idéntico a la línea base» e «identical: TRUE».

Capturas para el titular en `_archivo/20260925_capturas_s35g/` (ignorada; ventana de arriba a 1280 × 900 y DSF 2): `s35g_{comparacion,panorama,vista}_sin_textbox_antes_1280.png` (s35f sin `text-box`, simulado: el defecto), `..._sin_textbox_despues_1280.png` (con la guarda: igual a antes de s35f) y `..._con_textbox_1280.png` (con soporte: igual a s35f). Revisión visual de la de comparación: antes, menú y botones más altos; después, el alto de antes de s35f.

Paso 3: `rm` de los dos enlaces simbólicos del worktree y `git worktree remove $TMPDIR/wt_476b1e1` (autorización 8)
esperado: el worktree fuera; los destinos de los enlaces intactos
obtenido: codigo_remove=0; `git worktree list` = solo el árbol principal (`95469aa [main]`); `renv/library` y `directorio_oficial_ee.csv` (3.778.137 B) siguen en el árbol principal

- PRUEBAS: build codigo 0; la batería y la regresión completa corren en G2, PUB y FASE R.
- Alcance: `git show --stat 50bb730` = las tres plantillas (+129/−76), más las capturas en `_archivo/20260925_capturas_s35g/` (ignorada). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas: D-G1-a (riesgo bajo): cada bloque `@supports` va inmediatamente después de la regla de `476b1e1` que modifica, en vez de uno solo al final, para que su lugar en la cascada sea el de s35f; son 11 bloques. D-G1-b (riesgo bajo): fuera de los bloques el texto es el de `476b1e1` byte a byte (por eso `--borde-tab: 3px` y `--relleno-territorio: 9px` repiten, dentro, el borde y el relleno de la regla de afuera, con un comentario que lo dice); la variante angosta de `.view-tab` va en un `@supports` anidado en el `@media`. D-G1-c (riesgo bajo): los comentarios que nombran `text-box` pasaron adentro de los bloques, para que el `grep` dé 0 también contando comentarios.
- Errores propios: el escáner del simulador ubicaba cada bloque desde su `{`, y la condición `(text-box: …)` de la regla habría contado como declaración fuera del bloque (y el simulador la habría borrado). Se corrigió antes de aplicarlo a una salida con bloques: el bloque cuenta desde su `@supports`.
- Dudas: ninguna.

### FASE G2: el marcado de las cohortes sale del generador (Q-58)

- Estado: completa, en el primer intento.
- Commits: `ba1b4be` refactor(trayectorias): el texto de los botones de cohorte sale del generador (Q-58).

**Cambios.**
- `botones_cohortes()` (`36_generar_trayectorias.R`) escribe `<button data-v="%d" aria-pressed="%s"><span class="tx">%d</span><em>%d</em></button>`, con un comentario que explica por qué. Sin espacio entre el `span` y el `<em>`: es el DOM que dejaba la reescritura, que quitaba el espacio con `trim()`.
- En la plantilla de la vista se borró la reescritura (el `forEach` sobre `#c-coh button` con `replaceChild`) y su comentario. El comentario de `#c-coh button` dentro del bloque `@supports` ahora dice que el `.tx` lo escribe el generador.
- En la batería, la prueba C6, después de C5, y una frase en el encabezado. C6 lee el HTML escrito, no el DOM (así la reescritura del script no puede hacerla pasar). En el bloque `#c-coh`, cada `<button>` tiene exactamente un `<span class="tx">` cuyo texto es el año de su `data-v`, y no hay otro texto fuera de ese `span` y del `<em>`. Los años son las cohortes del `DATA` escrito en la misma vista (`meta$tras` sin el referente). Lleva un control plantado: el marcado de antes, `2021 <em>9</em>`, no pasa.

Calibración: la batería con C6 sobre la salida del generador anterior (el build de G1, vista 6c542095…; `$TMPDIR/cal_s35g/g2/bateria_calibracion.txt`)
esperado: C6 falla
obtenido: «C6 FALLA … (9 botones; con un único span.tx con su año y sin otro texto: 0; años 2018/2020/2021/2024/2025/2026/2027/2028/2029; cohortes del DATA 2018/…/2029; control plantado detectado: TRUE)»; «Resultado: 33 pruebas, 32 pasan, 1 fallan», codigo_bateria=1. **Dispara.**

Build y batería con el cambio (`$TMPDIR/cal_s35g/g2/build.txt` y `bateria.txt`; salidas copiadas a `$TMPDIR/cal_s35g/g2/i1/`)
esperado: build codigo 0; batería en PASA, con C6
obtenido: primera versión: build codigo 0, pero con «Advertencias: 8»: el validador marcó como `separador_manual` el `paste(..., collapse = "/")` del detalle de C6 (L665), un falso positivo que agregué yo. Se cambió por `toString()` antes del commit. Build final: codigo_build=0, «Fallas criticas: 0 | Advertencias: 7» (las mismas siete de H6, con las líneas corridas por lo agregado: `36_generar_trayectorias.R` L87 y L160, antes L84 y L157; `36_verificar_trayectorias.R` L937, antes L895). Motor 67054385155728677d33e3366870feeb (igual que G1), vista 523ce765359e1cb1ee080b3fe557c93b. Batería codigo_bateria=0: «C6 PASA … (9 botones; con un único span.tx con su año y sin otro texto: 9; años 2018, 2020, 2021, 2024, 2025, 2026, 2027, 2028, 2029; cohortes del DATA 2018, …, 2029; control plantado detectado: TRUE)»; «Resultado: 33 pruebas, 33 pasan, 0 fallan». **Cumple.**

Recalibración con el bloque C6 final (`$TMPDIR/cal_s35g/g2/c6_recalibrar.R` toma las líneas 628-667 literales de la batería y las evalúa sobre un HTML dado)
esperado: FALLA con el generador anterior; PASA con el nuevo
obtenido: base de H6 «C6 FALLA … con un único span.tx con su año y sin otro texto: 0»; build de G1 «C6 FALLA … 0»; build de G2 «C6 PASA … 9». **Dispara.**

**Criterio: DOM de `#c-coh`** (`$TMPDIR/cal_s35g/g2/dom_coh.R`: `outerHTML` de `#c-coh` guardado por un oyente de `DOMContentLoaded` inyectado con `Page.addScriptToEvaluateOnNewDocument`, y otra vez tras `load`; `dom_coh.txt`)
esperado: idéntico al de la base de H6
obtenido: «DOM #c-coh tras DOMContentLoaded idéntico: TRUE | tras load idéntico: TRUE» (953 caracteres en los dos); un `span.tx` por botón, con su año, en los 9 botones de las dos versiones. **Cumple.**

Diff del marcado estático de `#c-coh` (`perl` sobre el HTML escrito, base de H6 contra G2; `$TMPDIR/cal_s35g/g2/marcado_diff.txt`, 26 líneas)
esperado: (se registra)
obtenido: los 9 botones pasan de `<button data-v="2018" aria-pressed="true">2018 <em>4</em></button>` a `<button data-v="2018" aria-pressed="true"><span class="tx">2018</span><em>4</em></button>` (lo mismo en 2020, 2021, 2024, 2025, 2026, 2027, 2028 y 2029); los dos `<span class="sep">` y los saltos de línea no cambian.

**Criterio: píxeles.** Capturas de G2 (`capturas.R`, 16) contra la base de H6 (`cap_a`)
esperado: 0 píxeles distintos en la vista a 375 y 1280 px
obtenido: 0 en las 16 (la vista a 1280 y 375, página completa y ventana de arriba a DSF 2, y sus notas; también `#comparacion`, `#panorama` y el modal). **Cumple.**

Comprobaciones adicionales:
- I-3 e I-4 sobre G2: «JSON idéntico a la línea base» e «identical: TRUE».
- Regresión de G1 sin soporte, sobre G2 (el marcado de la vista cambió): simulador `$TMPDIR/sin_textbox/g2_i1` contra `ref_476b1e1`: «90 controles emparejados | |Δ alto| <= 0.5: 90 | fuera 0 | Δ alto 0.0000 a 0.0000 | Δ y 0.0000 a 0.0000 | Δ x 0.0000 a 0.0000»; capturas: 0 píxeles en las 16.

- PRUEBAS: build codigo 0; batería 33/33; I-3 idéntico.
- Alcance: `git show --stat ba1b4be` = `36_generar_trayectorias.R` (+5/−2), `36_trayectorias_template.html` (+3/−10) y `36_verificar_trayectorias.R` (+43/−1). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno en el producto.
- Decisiones autónomas: D-G2-a (riesgo bajo): C6 lee el HTML escrito con expresiones regulares (no hay `xml2` en la biblioteca) y exige además que no quede otro texto en el botón y que los años sean las cohortes del `DATA` escrito, para medir «su año» y no solo la presencia de un `span`; el control plantado va dentro de la misma prueba, como en C2 y C3, así que la batería pasa de 32 a 33 pruebas.
- Errores propios: el detalle de C6 con `collapse = "/"` agregó una advertencia al validador del build; se corrigió antes del commit y se recalibró C6 con el bloque final.
- Dudas: ninguna.

### FASE G3: el tooltip no tapa el punto en pantallas angostas (Q-54)

- Estado: completa, en el primer intento.
- Commits: `c8964b6` fix(motor): a 375 px el tooltip no tapa el punto (Q-54).

**Cambio** (`ubicarTooltip()`, +12/−2):
- `cabeDer = ptX + desplaz + ancho <= vw - margen` y `cabeIzq = ptX - ancho - desplaz >= margen`. La elección horizontal se reescribió con `cabeDer`; equivale a la condición de antes, `left + ancho > vw - margen`, con la misma aritmética.
- Si `!cabeDer && !cabeIzq`: `top = ptY + desplaz` cuando `ptY + desplaz + alto <= vh - margen`; si no, `top = ptY - alto - desplaz` cuando es `>= margen`; si ninguno cabe, `top` queda como hoy. La posición horizontal es la de hoy, acotada a la ventana.
- Solo usa `TOOLTIP_DIMS` (`desplaz`, `margen`). `git diff -U0` no muestra ninguna cifra nueva en las líneas de código (solo el «Q-54» del comentario).
- El comentario de cabecera de `TOOLTIP_DIMS` describe la regla nueva.

Medidor: `$TMPDIR/cal_s35g/g3/tt_g3.R`, copia de `tt_medir.R` de s35f con otros tamaños: 1280 × 800, 375 × 740 y 414 × 896, con barras superpuestas. Mide los casos de TT (6 elementos por tamaño, en hover y en clic, con el panel «Ver establecimientos» en cada clic) y el barrido de los 119 puntos y barras de cada tamaño. Los resúmenes salen de `resumir_g3.R`, con estas definiciones:
- tapa: el punto está dentro del rectángulo del tooltip agrandado 4 px por lado;
- sin lado: no cabe a la derecha ni a la izquierda;
- cabe abajo: `ptY + 14 + alto <= alto − 8`; cabe arriba: `ptY − 14 − alto >= 8`;
- rectángulo igual a la base: |Δ| ≤ 0,01 en `left`, `top`, `right` y `bottom`.

Calibración: la base de H6 (`$TMPDIR/base_s35g/motor_comparacion.html`; `$TMPDIR/cal_s35g/g3/base_resumen.txt`)
esperado: al menos un caso a 375 px con el punto tapado (R-38 de s35f)
obtenido: 375 × 740: 2 de 12 casos tapan, `barra_pri` hover (`ptX` 74, `ptY` 450,297; rectángulo 8–288 × 436,297–702,297) y clic (431–732). Ninguno cabe a un lado, y los dos caben abajo o arriba. Barrido: 43 de 119 tapan a 375 (48 sin lado) y 22 de 119 a 414 (22 sin lado). 1280 y 414 no tienen casos de TT sin lado. **Dispara.**

Build (`$TMPDIR/cal_s35g/g3/build_i1.txt`) y medición (`i1_resumen.txt`)
esperado: build codigo 0. A 375 × 740 y 414 × 896, el punto fuera del tooltip (con 4 px de margen) en todos los casos donde cabe arriba o abajo, y el tooltip dentro de la ventana en todos. A 1280 × 800, el mismo rectángulo que en la base. El panel abre en todos los clics.
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»). Motor 7f5971a3a99b24540ee797b9c1966a0c; vista 523ce765… (sin cambio).
- 375 × 740: 12 casos, 0 fuera, 0 tapan. Los 2 sin lado, `barra_pri`: hover abajo (`top` 464,297 = `ptY` + 14; `bottom` 730,297 ≤ 732) y clic arriba (`bottom` 436,297 = `ptY` − 14; `top` 135,297). En el clic el tooltip mide 301 y abajo no cabe: 450,3 + 14 + 301 > 732.
- 414 × 896: 12 casos, 0 fuera, 0 tapan.
- 1280 × 800: 12 casos, 0 fuera, 0 tapan; rectángulo igual a la base en 12 de 12 (máx |Δ| 0,000).
- Panel abierto en 6 de 6 clics por tamaño (18 de 18).
- Barrido: 1280, 119 visibles, 0 fuera, 0 tapan, 119 de 119 iguales a la base. 375, 0 fuera, 0 tapan (43 abajo, 5 arriba, 26 a la derecha, 45 a la izquierda). 414, 0 fuera, 0 tapan (22 abajo). Solo cambian los que en la base no tenían lado (48 a 375 y 22 a 414); el resto, igual a la base (71 y 97).

**Cumple.**

Comprobaciones adicionales:
- I-3: «JSON idéntico a la línea base».
- Capturas de las tres vistas (16, sin tooltip abierto) contra la base de H6: 0 píxeles en las 16.

- PRUEBAS: build codigo 0; la batería y la regresión completa corren en PUB y en FASE R.
- Alcance: `git show --stat c8964b6` = `30_procesamiento/33_motor_template.html` (+12/−2). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas: D-G3-a (riesgo bajo): abajo o arriba, el tooltip conserva la posición horizontal de hoy (a la izquierda, acotada a la ventana: `left` = 8 en los casos medidos) en vez de centrarse bajo el punto. Centrarlo exigiría un literal nuevo (`/ 2`), y la separación vertical de `desplaz` ya deja el punto libre. D-G3-b (riesgo bajo): «cabe» abajo o arriba se mide con el rectángulo completo dentro de la ventana, con `margen` (la misma regla que «dentro»); si cabe abajo se prefiere abajo, como pide el encargo.
- Errores propios: ninguno.
- Dudas: ninguna.

### FASE PUB: copia a `docs/`

- Estado: completa (G1, G2 y G3 completas antes de copiar).
- Commits: `9ef4f2b` deploy(docs): centrado solo con text-box, cohortes desde R y tooltip angosto.

`md5 -q docs/index.html docs/trayectorias.html` antes de la copia
esperado: 65f2f59bcccd8da57e0aa4aa07a2533c y 713dfa9d1e6750b8562ff0300179b53a (H4)
obtenido: 65f2f59bcccd8da57e0aa4aa07a2533c y 713dfa9d1e6750b8562ff0300179b53a

**Paso 1.** `Rscript 00_build.R` y la batería (salidas en `$TMPDIR/cal_s35g/pub/`)
esperado: codigo 0 y 32 pruebas o más en PASA
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); codigo_bateria=0, «Resultado: 33 pruebas, 33 pasan, 0 fallan»; motor 7f5971a3a99b24540ee797b9c1966a0c y vista 523ce765359e1cb1ee080b3fe557c93b, iguales a los de G3 (build reproducible)

**Paso 2.** `cp 40_salidas/motor_comparacion.html docs/index.html` y `cp 40_salidas/trayectorias_traspasos.html docs/trayectorias.html` (autorización 2)

**Paso 3. Verificación.**

md5 de `docs/` contra `40_salidas/`
esperado: iguales
obtenido: `docs/index.html` 7f5971a3a99b24540ee797b9c1966a0c = motor; `docs/trayectorias.html` 523ce765359e1cb1ee080b3fe557c93b = vista

I-2 (`grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'`)
esperado: 0 en cada uno
obtenido: `40_salidas/motor_comparacion.html` 0 0; `40_salidas/trayectorias_traspasos.html` 0 0; `docs/index.html` 0 0; `docs/trayectorias.html` 0 0

I-3 (`Rscript verificar_contenido_motor.R docs/index.html`) y, además, I-4 sobre `docs/trayectorias.html`
esperado: «JSON idéntico a la línea base»; `identical: TRUE`
obtenido: «JSON idéntico a la línea base», codigo_I3=0 (medido sin tubería; una primera lectura con `| tail -1` daba el código de `tail`, y se repitió); «DATA de la vista: … identical: TRUE»

`git status --porcelain` antes del commit
esperado: solo los dos archivos de `docs/` (más este log, sin seguimiento)
obtenido: ` M docs/index.html`, ` M docs/trayectorias.html`, `?? 50_documentacion/andamios/logs/20260925_supports_cohortes_s35g_log.md`

- Alcance: `git show --numstat 9ef4f2b` = `docs/index.html` (+112/−63) y `docs/trayectorias.html` (+58/−43). Dentro del ALCANCE.
- Subagentes: ninguno. Bugs: ninguno. Decisiones autónomas: ninguna. Dudas: ninguna.
- Errores propios:
  - el primer código de I-3 se leyó tras una tubería (era el de `tail`); se volvió a medir antes de registrarlo;
  - en la línea de alcance escribí primero cifras por archivo sin medirlas; las reemplacé por las de `git show --numstat` antes de cerrar la sección.

### FASE R: auditoría y reparación

Sin subagentes: el orquestador re-deriva cada afirmación con un comando distinto del que la produjo.

**R.1 Inventario de afirmaciones auditables** (armado desde este log, antes de auditar):

| id | afirmación | fase |
|---|---|---|
| R-01 | H1-H4: el encargo y el log sin seguimiento; 0 stash; `HEAD` y `origin/main` en 6c51362; md5 del encargo 6b7d0a7c…; `docs/` 65f2f59b… y 713dfa9d…; fuentes; 28; `@supports` 0/0/0 | FASE 0 |
| R-02 | T0 = `95469aa`, solo el encargo, hijo de 6c51362 | FASE 0 |
| R-03 | H5 32/32; H6 codigo 0; build reproducible (= `docs/`) | FASE 0 |
| R-04 | los comparadores de I-3 e I-4 disparan con un número alterado | FASE 0 |
| R-05 | las capturas de la base son deterministas (0 píxeles entre dos cargas, 16) | FASE 0 |
| R-06 | la referencia de `476b1e1` da 6825812f… y 1067908e…, con los datos de la base | FASE 0 |
| R-07 | el simulador sobre la base da el defecto de Q-59 (menú +6,844/+5,188; botones +4,531 a +5,531; región 23.965/22.595/66.259 px) | FASE 0 |
| R-08 | el `grep` de G1 da 31 apariciones fuera de `@supports` antes del cambio | FASE 0 |
| R-09 | G1: fuera de los bloques, el CSS es el de `476b1e1` | G1 |
| R-10 | G1: 0 apariciones de `text-box`, `1cap`, `lh`, `round(` (y tokens) fuera de `@supports`; bloques 2/6/3 | G1 |
| R-11 | G1 con soporte: 0 píxeles contra la base en 16 capturas (ruido de 10.181 en una captura de `#comparacion` a 375); centrado 90/90 igual a la base | G1 |
| R-12 | G1 sin soporte: altos y posiciones de los 90 controles iguales a `ref_476b1e1` (Δ 0); 0 píxeles en 16 capturas | G1 |
| R-13 | el worktree se quitó y los destinos de los enlaces siguen intactos | G1 |
| R-14 | `50bb730` toca solo las tres plantillas | G1 |
| R-15 | C6 falla con el generador anterior (0 de 9) y pasa con el nuevo (9 de 9); batería 33/33 | G2 |
| R-16 | el DOM de `#c-coh` tras `DOMContentLoaded` y tras `load` es idéntico al de la base | G2 |
| R-17 | G2: 0 píxeles contra la base (16); sin soporte, igual a la referencia | G2 |
| R-18 | el validador del build sigue en 7 advertencias (el falso positivo de C6 se corrigió) | G2 |
| R-19 | `ba1b4be` toca solo el generador, la plantilla de la vista y la batería | G2 |
| R-20 | G3, calibración: la base tapa el punto en 2 casos a 375 (`barra_pri`); barrido 43 y 22 | G3 |
| R-21 | G3: 0 casos tapan a 375 y 414; todos dentro; panel 18/18; 1280 igual a la base (12/12, barrido 119/119); solo cambian los casos sin lado | G3 |
| R-22 | G3 no agrega literales: solo `TOOLTIP_DIMS` | G3 |
| R-23 | `c8964b6` toca solo la plantilla del motor | G3 |
| R-24 | `docs/` = `40_salidas/` (7f5971a3…, 523ce765…); I-2 en 0; JSON y DATA idénticos; build reproducible | PUB |
| R-25 | `9ef4f2b` toca solo `docs/index.html` y `docs/trayectorias.html` | PUB |
| R-26 a R-34 | I-1 a I-9 | §4 |
| R-35 | alcance global dentro de la unión de los ALCANCE, más el log | global |
| R-36 | regresión: build 0, batería ≥ 32 en PASA, JSON idéntico | global |

**R.2 Re-derivación independiente** (orquestador; scripts en `$TMPDIR/cal_s35g/r/`)

R-01, R-02 (`git cat-file -p 95469aa`, `git diff-tree --name-status`, `git cat-file blob … | md5 -q`, `fetch` y `git rev-parse` completos, `git cat-file blob 6c51362:docs/…`, `git stash list`)
esperado: padre 6c51362; solo el encargo; md5 del encargo y de `docs/` en 6c51362; `origin/main` = 6c51362; 0 `@supports` en las plantillas de 6c51362; 0 stash
obtenido: «parent 6c513629c10c…»; `A 50_documentacion/activa/encargos/encargo_supports_cohortes_s35g.md`; 6b7d0a7c44e0fb60da747221d16e1eb2; `origin/main` 6c513629c10c0d585cb1a9a4835335c96d48925e (fetch=0); `docs/` en 6c51362 65f2f59b… y 713dfa9d…; `@supports` 0, 0 y 0; stash 0 → CONFIRMADAS

R-03, R-18, R-36: regresión completa de R.5 sobre el estado final → CONFIRMADAS

R-04: control positivo de R.6, con el decodificador de Python y los de R → CONFIRMADA

R-05, R-11, R-17, R-34 (I-9) con otro comando y otros anchos: md5 de cada PNG (identidad de bytes, no el comparador de píxeles) y capturas a 1440 × 900 y 414 × 900 (`capturas_otros.R`) de la base, `docs/`, la referencia y `docs/` simulado sin soporte (`$TMPDIR/cal_s35g/r/otros/`)
esperado: con soporte, `docs/` igual a la base; sin soporte, igual a la referencia; control base contra referencia, distintas
obtenido: con soporte, 16 de 16 PNG con el mismo md5 que la base; sin soporte, 16 de 16 con el mismo md5 que la referencia; control, 16 de 16 distintas. Además, agrupando por md5 las 15 capturas de `comparacion_375.png` de la sesión: `9ef3af46…` en base (`cap_a`, `cap_b`), G1 (`cap2`), G2, G3 y `cssom_final`; `813d4b58…` en la referencia, `cssom_ref` y las copias simuladas de G1 y G2 → CONFIRMADAS

R-09, R-10 (G1) con otro instrumento: el CSSOM de Chrome (`rd_cssom.R`). Recorre las reglas ya analizadas por el navegador y cuenta las que nombran `text-box`, `cap`, `lh`, `round(` o los tokens del centrado fuera de un `CSSSupportsRule` con `text-box` en su condición
esperado: `docs/`, 0 fuera; la base de H6 (calibración), las reglas de s35f fuera
obtenido: `docs/`: motor 311 reglas de estilo, 9 dentro de `@supports`, **0 fuera**; vista 161, 6 dentro, **0 fuera**; condición «(text-box: trim-both cap alphabetic) => true» en Chrome 153. Base: 9 fuera en el motor (`:root`, `.view-tab` ×2, `.segmented-btn`, `.select`, `.control-texto`, `.gse-filter select`, `.territorio-select`, `.territorio-select-name`) y 6 en la vista (`:root`, `.view-tab` ×2, `.tx`, `#c-coh button`, `select`); referencia, 0 reglas del centrado. El `grep` del simulador sobre `docs/*.html`: «0 apariciones (con comentarios) | 0 declaraciones» → CONFIRMADAS

R-12, R-17 (sin soporte) con otro instrumento: `rd_cssom.R` en modo «sin». En la página ya cargada borra con `deleteRule` cada `@supports` cuya condición nombra `text-box`, quita con `removeProperty` el `text-box` de las demás reglas y lanza un `resize`. Después mide alto y posición de 80 elementos y captura la página completa (`cmp_cssom.R`)
esperado: `docs/` sin soporte = referencia; `docs/` con soporte = base; calibración: la base sin soporte, con el defecto
obtenido:
- `docs/` sin soporte contra la referencia: 80 de 80 con |Δ alto| ≤ 0,5 (Δ alto 0,000; Δ y 0,000). En el motor se borraron 8 `@supports` y en la vista 5; 0 `text-box` sueltos. Capturas: 0 píxeles en 5 de 6; `comparacion_375.png` con 10.181 distintos en las filas 3315-4184 (la tabla), en dos cargas. Esa máscara es **idéntica** (10.181 de 10.181 píxeles, columnas 42-334) a la de la captura ruidosa de G1 con soporte contra la base. Es la variante conocida del dibujo de la tabla a 375 px, independiente de `text-box`, que el instrumento del CSSOM provoca en forma estable (ADVIERTE R-37). El simulador de texto da ahí el PNG exacto de la referencia.
- `docs/` con soporte contra la base: 80 de 80 iguales; 0 píxeles en 6 de 6.
- Base sin soporte (calibración): 41 de 80, Δ alto hasta +6,844; las páginas cambian de alto.

→ CONFIRMADAS

R-13 (`git worktree list`, `ls -ld`)
esperado: solo el árbol principal; los destinos existen
obtenido: «/Users/tomgc/Projects/slep_simce_adecuado 9ef4f2b [main]»; `renv/library` (directorio) y `directorio_oficial_ee.csv` (3.778.137 B) en su lugar → CONFIRMADA

R-14, R-19, R-23, R-25 (`git diff-tree --numstat -r` y padre)
esperado: `50bb730` las tres plantillas; `ba1b4be` generador, vista y batería; `c8964b6` el motor; `9ef4f2b` los dos `docs/`
obtenido: `50bb730` (padre 95469aa) 21/12 fragmento, 80/49 motor, 28/15 vista; `ba1b4be` (padre 50bb730) 5/2 generador, 3/10 vista, 43/1 batería; `c8964b6` (padre ba1b4be) 12/2 motor; `9ef4f2b` (padre c8964b6) 112/63 `docs/index.html`, 58/43 `docs/trayectorias.html` → CONFIRMADAS

R-15, R-16 (G2) con otro instrumento: el DOM con JavaScript desactivado (`Emulation.setScriptExecutionDisabled`) y, con JavaScript, `XMLSerializer` sobre los hijos de `#c-coh` (`rd_dom.R`)
esperado: sin JavaScript, la base sin `span.tx` (lo agregaba el script) y `docs/` con uno por botón; con JavaScript, iguales
obtenido: sin JS, base «0:-:2018 … 0:-:2029»; `docs/` «1:2018:2018 … 1:2029:2029»; con JS, las dos «1:2018:2018 … 1:2029:2029»; «serialización con JS idéntica (docs vs base): TRUE | docs sin JS = docs con JS: TRUE | docs sin JS = base con JS: TRUE | base sin JS = base con JS: FALSE». Batería de R.5: «C6 PASA … 9». → CONFIRMADAS

R-20, R-21 (G3) con otro instrumento (`rd_g3.R`, adaptado de `rd_tt.R` de s35f). Lee la posición con `offsetLeft`, `offsetTop` y `offsetWidth`, no con `getBoundingClientRect`. Usa otros tamaños: 360 × 740, 390 × 844, 375 × 667, 1440 × 900 y 1280 × 800. Recorre el elemento de la izquierda, el del medio y el de la derecha (punto y barra) de cada tarjeta de la primera y la última columna, en hover y en clic, con el panel en cada clic. Evalúa si el tooltip tapa (con 4 px de margen) y compara cada caso con la base.
esperado: la base tapa en ventanas angostas; `docs/`, 0 casos que tapen donde cabe, todos dentro, panel en todos los clics, 1280 y 1440 iguales a la base
obtenido:
- Base: 360 casos, 0 fuera, panel 180 de 180; tapan 16 (360 × 740), 10 (375 × 667) y 2 (390 × 844); los 28 sin lado y cabiendo abajo o arriba.
- `docs/`: 360 casos, 0 fuera, 0 del lado incorrecto, panel 180 de 180, **0 tapan** en los cinco tamaños (36 sin lado, todos caben abajo o arriba).
- Contra la base: 1280 y 1440, 72 de 72 iguales cada uno; 360, 50 iguales y 22 distintos; 375 × 667, 60 y 12; 390, 70 y 2. Los distintos son todos casos sin lado en la base.

→ CONFIRMADAS

R-22 (`git show c8964b6 | grep '^+'` sin comentarios)
esperado: ninguna cifra nueva
obtenido: siete líneas de código agregadas, solo con `ptX`, `ptY`, `desplaz`, `margen`, `ancho`, `alto`, `vw`, `vh`, `cabeDer`, `cabeIzq`, `left`, `top`: 0 literales numéricos → CONFIRMADA

R-24 (identidad) con `git hash-object` y `git ls-tree HEAD docs/`
esperado: blobs iguales en `docs/`, `40_salidas/` y `HEAD`
obtenido: `aebc48a96849…` en `docs/index.html`, `40_salidas/motor_comparacion.html` y `HEAD:docs/index.html`; `a9e78d10f600…` en `docs/trayectorias.html`, `40_salidas/trayectorias_traspasos.html` y `HEAD` → CONFIRMADA

R-24 (red) con un segundo patrón (`rd_inv.py`: `src` con o sin comillas, `url(`, `<link href>`, `@import`, `fetch(`, y cada aparición de `http` clasificada; `grep -c 'http'`, líneas)
esperado: 0 cargas por red; los aciertos de `http`, sin carga
obtenido: 0 cargas en los cuatro HTML. `grep -c 'http'`: motor 17 líneas, vista 2. Apariciones (revisadas a mano), iguales a las de s35f:
- motor, 28: 15 espacios de nombres SVG/XLink; 8 cadenas `www.w3.org` de React y D3; la URL del decodificador de errores de React; `httpEquiv` y `http-equiv`; los comentarios de licencia de D3 (`d3js.org`) y de pako (`github.com`);
- vista, 2: los espacios de nombres SVG.

→ CONFIRMADA

R-24 (datos) por otra vía (`rd_inv.py`, JSON del motor en Python sin `meta.fecha_generacion`, sha256 canónico; bloque `DATA` de la vista byte a byte)
esperado: iguales a la base de H6
obtenido: «I-3 … sha256 7967dfa07a99ef11 base 7967dfa07a99ef11 idéntico: True» en `40_salidas/` y `docs/`; «I-4 … bloque DATA idéntico byte a byte: True | largo 2018084 | DATA igual al parsear: True» en los dos → CONFIRMADA

R-06, R-07, R-08: calibraciones de FASE 0 re-derivadas por otras vías: el CSSOM sobre la base (R-09/R-10: 9 y 6 reglas fuera; R-12: Δ alto +6,844) y el md5 de las capturas de la referencia (`813d4b58…`, distinto del de la base) → CONFIRMADAS

**R.3 Invariantes 🔒** (estado final `9ef4f2b`, tras el build de la regresión)

I-1 `md5 -q docs/*.html` tras PUB
esperado: iguales a `40_salidas/`
obtenido: 7f5971a3a99b24540ee797b9c1966a0c y 523ce765359e1cb1ee080b3fe557c93b en `docs/` y en `40_salidas/` → **PASA**

I-2 `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html`
esperado: 0 en cada uno
obtenido: 0 0 en los cuatro → **PASA**

I-3 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base», codigo_I3=0 → **PASA**

I-4 prueba C3 y el `DATA` de la vista contra la base de H6 con `identical()`
esperado: PASA e idéntico
obtenido: «C3 PASA … (12724 filas de 37 unidades; idénticas: TRUE; control plantado detectado: TRUE)»; «identical: TRUE», codigo_I4=0 → **PASA**

I-5 `md5 -q 10_utils/fuentes/*.otf`
esperado: a7407ed6… y 0257bb4b…
obtenido: a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc; blobs ccbdbdc6… y b78fd5c5…, 100644 → **PASA**

I-6 `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`
esperado: vacío
obtenido: vacío (0 líneas) → **PASA**

I-7 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 (y 28 con `git ls-files -- '*.csv' '*.xlsx' '*.parquet' '*.rds' | wc -l`) → **PASA**

I-8 `scrollWidth` de la vista, `#comparacion` y `#panorama` a 375, 540, 768 y 1280 px (`i8.R` sobre `docs/`)
esperado: igual al viewport
obtenido: 12 de 12 («docs_final : I-8 PASA»); por otra vía (`rd_i8.R`: `scrollX` tras `scrollTo(100000, 0)`): «I-8 (otra vía): PASA» → **PASA**

I-9 capturas a 375 y 1280 px de las tres vistas (más menú, modal y notas) de `docs/` contra la base de H6
esperado: 0 píxeles distintos (salvo el tooltip abierto, que no se captura)
obtenido: 0 en las 16 (`$TMPDIR/cal_s35g/r/i9.txt`); además, 0 en las 16 de 1440 y 414 por md5 (R.2) → **PASA**

**R.4 Alcance global** (`git diff --name-only 95469aa..HEAD` con `rd_alcance.R`, y `git status --porcelain`)
esperado: 0 rutas fuera de la unión de los ALCANCE (más el log); el árbol solo con el log
obtenido: «rutas: 7 | fuera: (ninguna)» (el fragmento, las dos plantillas, el generador, la batería y los dos `docs/`); `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260925_supports_cohortes_s35g_log.md`; las capturas van en `_archivo/20260925_capturas_s35g/` (ignorada). **PASA.**

**R.5 Regresión completa** (estado final `9ef4f2b`; salidas en `$TMPDIR/cal_s35g/r/`)
esperado: `Rscript 00_build.R` codigo 0; batería ≥ 32 en PASA y codigo 0; «JSON idéntico a la línea base»
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»), motor 7f5971a3… y vista 523ce765… (iguales a PUB); codigo_bateria=0, «Resultado: 33 pruebas, 33 pasan, 0 fallan» (con «C6 PASA»); codigo_I3=0, «JSON idéntico a la línea base» → **PASA**

**R.6 Control positivo de la propia auditoría**
- Cifra alterada en copias fuera del árbol (`$TMPDIR/cal_s35g/r/ctl/`, sobre `docs/`): motor 3.5 → 3.6 y vista 23.9 → 23.8. `rd_inv.py`: «I-3 … sha256 aec5b073d08b11db base 7967dfa07a99ef11 idéntico: False» y «I-4 … idéntico byte a byte: False | … igual al parsear: False». `verificar_contenido_motor.R`: «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)», codigo=1. `i4_data_vista.R`: «identical: FALSE», codigo=1. `git hash-object`: 871a8fdf… contra aebc48a9…. **Dispara.**
- Archivo fuera de alcance en un diff simulado: `rd_alcance.R` sobre 8 rutas da «fuera: 30_procesamiento/32_agregar_comunal.R, 10_utils/fuentes/gobCL_Bold.otf, 40_salidas/intermedios/simce_rbd.parquet, _archivo/20260925_capturas_s35f/x.png, verificar_sin_textbox.R, 30_procesamiento/36_funciones_trayectorias.R» (acepta la plantilla del motor y `docs/index.html`). **Dispara.**
- Además, los instrumentos nuevos dispararon sobre la base: CSSOM (9 y 6 reglas fuera; Δ alto +6,844), JavaScript desactivado (0 `span.tx` en la base) y `rd_g3.R` (28 casos que tapan).

**R.7 Veredicto por hallazgo.**
- BLOQUEA: ninguno.
- REPARA: ninguno.
- ADVIERTE: R-37 a R-43 (tabla R.10). No se corrigen.

**R.8 Ciclo de reparación.** No aplica (0 REPARA).

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado ni ALCANCE, y no se tocó ningún 🔒. Evidencia editada después de escrita, dos veces, siempre antes de cerrar su sección y declarado como error propio:
- en PUB, la línea de alcance, con cifras por archivo escritas sin medir;
- el encabezado del log, al completar el punto de retorno (un campo de la plantilla).

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1-H4 | `cat-file`, `diff-tree`, blobs de 6c51362, `rev-parse` completo, `stash list` | §2 | iguales | — | ninguna | — | — |
| R-02 | T0 `95469aa` | `cat-file -p`, `diff-tree` | el encargo; padre 6c51362 | así | — | ninguna | — | — |
| R-03 | H5 y H6 | R.5 | 0; ≥ 32 | 0; 33/33 | — | ninguna | — | — |
| R-04 | comparadores de I-3 e I-4 | R.6 (Python, R, `hash-object`) | disparan | disparan | — | ninguna | — | — |
| R-05 | capturas deterministas | md5 de PNG (15 capturas de `comparacion_375`) | agrupan por estado | 2 grupos por estado, más 2 variantes | ADVIERTE (R-37) | registrar | — | — |
| R-06 | referencia de `476b1e1` | md5 de sus capturas; CSSOM | distinta de la base | 16/16 distintas; 0 reglas del centrado | — | ninguna | — | — |
| R-07 | el simulador da el defecto de Q-59 | CSSOM «sin» sobre la base | Δ alto > 4 | +6,844; 41 de 80 | — | ninguna | — | — |
| R-08 | `grep` antes de G1: 31 fuera | CSSOM sobre la base | reglas fuera | 9 y 6 reglas | — | ninguna | — | — |
| R-09 | fuera de los bloques, el CSS de `476b1e1` | CSSOM de la referencia y de `docs/` sin soporte (altos y píxeles) | iguales | 80/80 Δ 0; 16/16 md5 a 1440/414 | ADVIERTE (R-41) | registrar | — | — |
| R-10 | 0 fuera de `@supports` | CSSOM (`CSSSupportsRule`) | 0 | 0 en motor y vista | — | ninguna | — | — |
| R-11 | con soporte = base | md5 de PNG a 1440 y 414; CSSOM | iguales | 16/16; 80/80, 6/6 | — | ninguna | — | — |
| R-12 | sin soporte = referencia | CSSOM «sin» (`deleteRule`) | iguales | 80/80 Δ 0; 5/6 png, 1 con la variante de la tabla | ADVIERTE (R-37, R-38) | registrar | — | — |
| R-13 | worktree quitado | `worktree list`, `ls -ld` | fuera; destinos intactos | así | — | ninguna | — | — |
| R-14 | alcance de `50bb730` | `diff-tree --numstat` | 3 plantillas | 3 | — | ninguna | — | — |
| R-15 | C6 calibrada y en PASA | JavaScript desactivado; batería de R.5 | base sin span; docs 1 por botón | así; C6 PASA | — | ninguna | — | — |
| R-16 | DOM de `#c-coh` igual | `XMLSerializer`; JS desactivado | igual | igual | — | ninguna | — | — |
| R-17 | G2 sin cambio visual | md5 de PNG; CSSOM | iguales | iguales | — | ninguna | — | — |
| R-18 | 7 advertencias del validador | build de R.5 | 7 | 7 | — | ninguna | — | — |
| R-19 | alcance de `ba1b4be` | `diff-tree --numstat` | 3 rutas | 3 | — | ninguna | — | — |
| R-20 | G3, calibración | `rd_g3.R` sobre la base (otros tamaños, `offset*`) | tapa en angostas | 16/10/2 | — | ninguna | — | — |
| R-21 | G3, resultado | `rd_g3.R` sobre `docs/index.html` | 0 tapan; dentro; paneles; 1280/1440 iguales | 0; 360/360; 180/180; 144/144 | ADVIERTE (R-39) | registrar | — | — |
| R-22 | sin literales nuevos | `git show c8964b6 \| grep '^+'` | 0 cifras | 0 | — | ninguna | — | — |
| R-23 | alcance de `c8964b6` | `diff-tree --numstat` | el motor | 12/2 | — | ninguna | — | — |
| R-24 | `docs/` = `40_salidas/`; red; datos | `hash-object`, `ls-tree`; `rd_inv.py` | iguales; 0; idénticos | iguales; 0; idénticos | — | ninguna | — | — |
| R-25 | alcance de `9ef4f2b` | `diff-tree --numstat` | 2 rutas | 2 | — | ninguna | — | — |
| R-26 a R-34 | I-1 a I-9 | R.3 y re-derivaciones | PASA | PASA | — | ninguna | — | — |
| R-35 | alcance global | `rd_alcance.R` y `status` | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-36 | regresión | R.5 | 0; ≥ 32; idéntico | 0; 33/33; idéntico | — | ninguna | — | — |
| R-37 | la captura de página completa de `#comparacion` a 375 px tiene una variante del dibujo de la tabla (10.181 px en las filas 3315-4184, siempre la misma máscara): apareció en una captura de G1 con soporte y en el instrumento del CSSOM sin soporte; con otra carga o con el simulador de texto, 0 | máscaras comparadas | — | misma máscara en los dos modos | ADVIERTE | registrar | — | — |
| R-38 | el simulador y el CSSOM emulan en Chrome 153 un navegador que no conoce `text-box`; Safari < 18.2 y Firefox < 154 no se midieron (no hay WebKit ni Firefox sin cabeza en la sesión). Un navegador que tampoco conoce `lh` o `cap` ignora igual los bloques | — | — | no medible | ADVIERTE | registrar (revisión del titular) | — | — |
| R-39 | abajo o arriba, el tooltip conserva la posición horizontal acotada a la izquierda (`left` 8) y puede tapar otros puntos de la tarjeta, no el propio; si no cabe ni abajo ni arriba, tapa como antes (no ocurrió en los ocho tamaños medidos) | `tt_g3.R`, `rd_g3.R` | — | 0 casos sin lugar | ADVIERTE | registrar | — | — |
| R-40 | la guarda cubre solo lo que cambió s35f; Q-60 (los botones de Nivel y Prueba en Safari) sigue abierta: con soporte, el recorte en el `<button>` depende del motor del navegador | lectura | — | fuera del encargo | ADVIERTE | registrar (Q-60) | — | — |
| R-41 | `--borde-tab: 3px` y `--relleno-territorio: 9px` repiten dentro del bloque el borde y el relleno de la regla de afuera (D-G1-b); un cambio futuro de afuera debe repetirse adentro | lectura | — | declarado | ADVIERTE | registrar | — | — |
| R-42 | no se creó CLAUDE.md (regla global frente a `.gitignore`, que lo excluye como gobernanza del Project, y al ALCANCE cerrado), como en s35 a s35f | — | — | D2 | ADVIERTE | registrar | — | — |
| R-43 | errores propios corregidos antes de registrar o de commitear: la condición de `@supports` en el escáner, la región de `comparar.R`, el separador de C6 (una advertencia más del validador), el código de I-3 tras una tubería y las cifras de alcance de PUB escritas sin medir | — | — | corregidos | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA ni REPARA. Las 36 afirmaciones del inventario quedan CONFIRMADAS (ninguna REFUTADA), con controles positivos que dispararon. Hay 7 ADVIERTE (R-37 a R-43), ninguno sobre datos ni invariantes; la prioritaria para el titular es R-38: revisar en un navegador real sin `text-box`.

## Cierre

### 1. Resumen

Un navegador sin `text-box` ya no suma la compensación de s35f. Todo lo del centrado (tokens, relleno, `min-height` con `lh`, el ajuste de los `<select>`, `.control-texto`, `.tx`, la regla de las cohortes y `--holgura-tinta`) vive ahora en 11 bloques `@supports (text-box: trim-both cap alphabetic)`, cada uno inmediatamente después de la regla de `476b1e1` que modifica; fuera de ellos el CSS es el de antes de s35f, byte a byte. Resultado:
- Sin soporte (simulado en Chrome de dos formas: texto y CSSOM): los 90 controles del inventario miden y se ubican igual que en `476b1e1` (Δ 0), con 0 píxeles distintos en 32 capturas (1280, 375, 1440 y 414 px).
- Con soporte: el sitio es el de s35f, con 0 píxeles distintos en 32 capturas y el centrado 90/90 idéntico.

El año de cada botón de cohorte llega en el HTML escrito, en su `<span class="tx">`, desde `botones_cohortes()`; la plantilla ya no lo reescribe. La prueba C6 lo comprueba: falla con el generador anterior y pasa con el nuevo, y el DOM de `#c-coh` queda idéntico.

El tooltip, cuando no cabe a ningún lado del punto, va abajo del punto y, si ahí no cabe, arriba. A 375 y 414 px ya no tapa el punto en ningún caso medido, y a 1280 px no cambia nada.

Todo se publicó en `docs/` (PUB). FASE R confirmó las 36 afirmaciones con instrumentos distintos y registró 7 advertencias. Veredicto: APROBADO CON ADVERTENCIAS.

### 2. Inventario de commits (`git log --oneline 95469aa^..HEAD`, que incluye T0)

```text
9ef4f2b deploy(docs): centrado solo con text-box, cohortes desde R y tooltip angosto
c8964b6 fix(motor): a 375 px el tooltip no tapa el punto (Q-54)
ba1b4be refactor(trayectorias): el texto de los botones de cohorte sale del generador (Q-58)
50bb730 fix(sitio): el centrado optico solo aplica con soporte de text-box (Q-59)
95469aa docs(sesion 35): encargo de la septima ola (supports, cohortes, tooltip)
```

Más el commit de este log (`docs(log): supports, cohortes y tooltip angosto (s35g)`), cuyo hash va en el reporte final.

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-43).

### 4. Invariantes

I-1 a I-9 en PASA en el estado final `9ef4f2b` (FASE R, R.3), con re-derivaciones por otra vía (R.2). En ningún cierre de tarea un 🔒 dio FALLA.

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 del encargo (6b7d0a7c44e0fb60da747221d16e1eb2, verificado).
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión con Rscript y chromote, Chrome 153)

- Sin `text-box` (simulador), alto contra `476b1e1`, antes → después:
  - menú: +6,844 (1280) y +5,188 (375) → 0;
  - segmentados: +5,188 → 0; «Agregar territorio» y botones del modal: +5,188 → 0; niveles E e I: +5,531 → 0; notas: +4,531 → 0; píldora: +11,531 → 0;
  - en total, 45 de 90 fuera → 90 de 90 con Δ alto, Δ y y Δ x en 0.
- Píxeles de la región «encabezado + menú + barra de controles» a 1280, sin soporte: 23.965, 22.595 y 66.259 → 0, 0 y 0.
- `grep` fuera de `@supports`: 31 apariciones (23 declaraciones) → 0 y 0.
- Con soporte: 0 píxeles contra la base de H6 (16 capturas a 1280 y 375, 16 a 1440 y 414); centrado 90/90, de −1,57 a +1,54, igual a la base.
- Cohortes: C6 da 0 de 9 con el generador anterior y 9 de 9 con el nuevo; la batería pasa de 32/32 a 33/33; el DOM de `#c-coh` es idéntico (953 caracteres).
- Tooltip:
  - casos de TT que tapan: base 2 de 12 a 375 → 0; barrido 43 de 119 (375) y 22 de 119 (414) → 0 y 0;
  - 1280: 12 de 12 casos y 119 de 119 del barrido iguales a la base; panel 18 de 18;
  - re-derivación en cinco tamaños (360 casos): base 28 tapan → 0; panel 180 de 180; 1280 y 1440, 144 de 144 iguales.
- Salidas finales: motor 7f5971a3a99b24540ee797b9c1966a0c y vista 523ce765359e1cb1ee080b3fe557c93b, iguales en `docs/` (blobs aebc48a9… y a9e78d10…). JSON del motor y `DATA` de la vista idénticos a la base (sha256 7967dfa07a99ef11). Validador del build: 0 críticas y 7 advertencias.
- `docs/` antes: 65f2f59b… y 713dfa9d…; después: 7f5971a3… y 523ce765….

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno.

Dudas nuevas, con pregunta cerrada:
- Q-61 (R-38). La guarda se midió en Chrome 153, simulando la ausencia de `text-box` de dos formas. ¿Se da por cerrada Q-59 con esa medición, o se pide una en un navegador real sin `text-box` (Firefox ESR o Safari < 18.2)? (cerrar / medir)
- Q-62 (R-39). Abajo o arriba del punto, el tooltip conserva la posición horizontal acotada a la izquierda (`left` 8 a 375 px). ¿Se centra bajo el punto, acotado a la ventana? (sí / no)

Siguen abiertas, de s35f: Q-60 (los botones de Nivel y Prueba en Safari), Q-55, Q-56 y Q-57. Q-54, Q-58 y Q-59 quedan resueltas por G3, G2 y G1.

Pendientes fuera del encargo:
- la revisión en navegadores reales (§9);
- los excluidos de §11 (Q-55, Q-56, Q-57, Q-42, Q-43, Q-51, Q-52, Q-34, Q-21, `OP_PREVIO`, Q-29, Q-31, Q-39, v30-5, Museo Sans, pendientes 8, 10, 12 y 13 de v34);
- CLAUDE.md (D2; no se creó: `.gitignore` lo excluye y el ALCANCE es cerrado).

`# REVISAR` nuevos: ninguno (`git diff 95469aa..HEAD | grep -c "^+.*REVISAR"` = 0).

### 8. Errores propios consolidados

- Instrumentos, corregidos antes de registrar resultados:
  - `comparar.R` no comparaba la región cuando las páginas tenían altos distintos;
  - el escáner del simulador contaba la condición de un `@supports` como declaración fuera del bloque;
  - una línea de R en el control positivo de FASE R falló por comillas y se pasó a un script.
- Producto, corregido antes del commit: el detalle de C6 con `collapse = "/"` agregó una advertencia al validador del build; se cambió por `toString()` y C6 se recalibró con el bloque final.
- Log, corregidos antes de cerrar la sección:
  - en PUB, el código de I-3 leído tras una tubería;
  - en PUB, cifras de alcance por archivo escritas sin medir.
- Ninguno tocó lo publicado.

### 9. Notas para el revisor

- En un navegador sin `text-box` (Firefox ESR, Safari < 18.2 o Chrome < 133): el menú de las dos páginas, los botones de Nivel y Prueba, «Agregar territorio», el botón de niveles y las notas deben verse con el alto de antes de s35f (Q-61, R-38). Referencia: `_archivo/20260925_capturas_s35g/s35g_*_sin_textbox_despues_1280.png` (igual a antes de s35f) contra `..._sin_textbox_antes_1280.png` (el defecto de Q-59).
- En Safari 18.2 o superior: el sitio debe verse como tras s35f (`..._con_textbox_1280.png`); y los botones de Nivel y Prueba (Q-60).
- En un teléfono real (375 o 414 px de ancho): el tooltip de un punto del medio de una tarjeta debe quedar abajo del punto, o arriba si abajo no cabe, sin taparlo; «Ver establecimientos» debe abrir su panel.
- La vista de trayectorias: los botones de cohorte, con el mismo aspecto (el marcado ahora sale de R).

### 10. Estado de cierre

- **Commiteado:** 5 commits del encargo (T0, G1, G2, G3, PUB) más el de este log, en `main`.
- **Condiciones de publicación medidas antes del commit de este log** (autorización 4):
  - veredicto de FASE R `APROBADO CON ADVERTENCIAS`;
  - `git fetch origin` fetch_codigo=0; `origin/main` = `6c51362`;
  - `git merge-base --is-ancestor origin/main HEAD` ancestro_codigo=0; 5 commits por publicar;
  - md5 de `docs/` = 7f5971a3a99b24540ee797b9c1966a0c y 523ce765359e1cb1ee080b3fe557c93b, iguales a los de PUB;
  - `git status --porcelain` = solo este log, que queda vacío con su commit.

  El `git push origin main` se corre después de este commit, con `status`, `fetch` y `merge-base` medidos otra vez. Su resultado y el de P3 (lo que sirve Pages) van en el reporte final.
- **Queda al titular:** la revisión en navegadores reales (§9) y las dudas Q-60 a Q-62.
- **Hash de `docs(log)`:** se informa en el reporte final (`git log -1 --format=%h`).
- **Verificación del archivo** (antes del commit): `grep -c '^### FASE'` = 6 (FASE 0, G1, G2, G3, PUB y R; FASE L es este «Cierre» y P3 va al reporte final); `grep -c '^esperado:'` = `grep -c '^obtenido:'`; `grep -c '^## J'` = 1, con el bloque relleno; privacidad sin coincidencias. Los conteos exactos, en el reporte final.
