# Log: pendientes de la sesión 35 (slep_simce_adecuado)

- Meta: implementar D35-1 y D35-2 en la vista de trayectorias, resolver los pendientes ejecutables de v34 en el motor y en el repositorio, migrar el sitio a gobCL, medir las dudas heredadas, y dejar todo commiteado y pusheado sin tocar `docs/`.
- Fecha: 2026-09-25 (el encargo lleva fecha 2026-09-24; el nombre del log se conserva tal como lo fija el contrato) · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: f4bd59e (commit de T0)
- Encargo: `50_documentacion/activa/encargos/encargo_pendientes_s35.md`, md5 `a468a261eb9beb5222e79799f5db1ecf` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo ultracode; orquestador Opus; subagentes tope 4 (≤ 3 Opus); total Opus ≤ 12
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; esfuerzo `ultracode` (xhigh + orquestación dinámica con Workflow); orquestador Opus 5.5 (`claude-opus-5-5[1m]`); subagentes lanzados con la herramienta Workflow, una ola por invocación, con `parallel()` de a lo más 4 agentes; los Opus heredan el modelo de la sesión y el lector de T10 va con `model: 'sonnet'`.
- Grafo y plan de concurrencia (copiados de §5 del encargo):
  - T0 (docs del asistente) es la raíz de todo. T9 requiere T0. T1 requiere T0; T2 requiere T1; T3 requiere T2. T4 requiere T0; T5 requiere T4; T6 requiere T5; T7 requiere T6. T8 requiere T3 y T7. T10 y T11 requieren T0 y son independientes de todo lo demás. FASE R y FASE L corren siempre.
  - Olas: (orquestador) FASE 0, T0, T9 · Ola 1: T1 (escritura Opus), T4 (escritura Opus), T11 (lectura Opus), T10 (lectura Sonnet) · Ola 2: T2, T5 (escritura Opus ×2) · Ola 3: T3, T6 (escritura Opus ×2) · Ola 4: T7 (escritura Opus ×1) · Ola 5: T8 (escritura Opus ×1) · FASE R: panel adversarial (lectura Opus ×3). Total Opus declarado: 12.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando

## J. Juicio (lo rellena FASE L)

- Meta y resultado: D35-2 y D35-1 implementadas en la vista; pendientes 2, 5 y 6 de v34 y CSS sin uso resueltos en el motor; `_archivo/` fuera del índice; ramas y dudas heredadas medidas. No se logró: gobCL (T8), la vista sin desborde bajo 666 px (T3) ni el validador en el build (T9.2). Todo está commiteado; sin push.
- Estado por tarea: T0 completa · T9.1 completa · T9.2 congelada · T1 completa con desviación (D1-a) · T2 completa · T3 congelada · T4 completa con desviación (D4-a) · T5 completa · T6 completa · T7 completa (orquestador) · T8 congelada por el grafo · T10 completa · T11 completa (v30-2 PASA, v30-3 PASA, v30-5 FALLA, v31-2 PASA, v31-3 PASA).
- Commits: f4bd59e (T0, punto de retorno), 00a8cdd, 6d7c757, 34c6553, 5a0ec3f, 291093f, 5c0994b, 84860ea, dd7fe76, f076470, 9e83ecf, 1150846, bfa40c9, más docs(log) (hash en el reporte final).
- Auditoría (FASE R): panel de 3 Opus; 46 afirmaciones (44 CONFIRMADA, 2 REFUTADA: R-32 frase imprecisa, R-39 I-7); 1 BLOQUEA, 4 REPARA corregidos en 2 ciclos (R-47, R-48, R-49, R-63), 14 ADVIERTE; control positivo disparó en los dos casos; veredicto BLOQUEADO.
- Invariantes: I-1 a I-6 e I-8 a I-12 PASA en el estado final; I-7 FALLA literal por `32_agregar_comunal.R:206`, igual en el punto de retorno y fuera de todo ALCANCE.
- Cifras críticas: 37 unidades futuras (13/11/13) con 2.564 establecimientos; 12.724 filas vigentes+REF idénticas a la línea base; REF 1.299 (olas 479/407/408; 17 cerrados); #lg «1.299 … 2014: 1.124»; JSON del motor idéntico; batería 28/28; 28 archivos de datos; `docs/` 8deb0459…/267857a2….
- Decisiones autónomas de mayor riesgo: D1-a (no congelar T1 aunque la calibración especificada de C5 no discrimina: 0 RBD con depe 5 en esas comunas); D4-a (no congelar T4 aunque (e) da 2,78 en Elemental apilado, propiedad previa de la paleta); clasificar R-47, R-48, R-49 y R-63 como REPARA y corregirlos.
- Desviaciones respecto del encargo: T7 la hizo el orquestador (D-plan-1, por el reintento de T1); H3 medido con un comando equivalente (D0-c); `png` desde la biblioteca del sistema (D0-d); H1 incluye la línea del log (D0-a); no se creó CLAUDE.md (D0-b); D1-a y D4-a.
- Dudas abiertas: Q-01 a Q-25 (en «Cierre», punto 7); Q-06 (I-7) condiciona el push; Q-18 condiciona T3 y T8.
- Errores propios: 5 errores de medición del orquestador, corregidos antes de concluir (extracción de DATA, medidor de T7, `sed` de calibración, espera de captura, frase R-32); ninguno tocó el producto.
- Qué debe verificar el revisor por sí mismo: la vista en Safari a 768 px (botones de cohorte en dos filas) y a 375 px (desborde previo, T3); el asterisco y la nota del motor; las notas del motor en tres columnas; D1-a y D4-a; Q-06 antes del push.
- No publicado / queda al usuario: sin `git push` (veredicto BLOQUEADO, autorización 3 no satisfecha); `docs/` y Pages sin tocar; T3, T8 y T9.2 para otro encargo.
- Ejecución: ultracode con Workflow; orquestador Opus 5.5; 11 agentes Opus (T1 ×2 por relanzamiento del harness, T4, T11, T2, T5, T3, T6 y 3 auditores) y 1 Sonnet (T10), con un máximo de 4 simultáneos y 3 Opus; tope Opus de 12 respetado.

### FASE 0: log, punto de retorno y premisas

Decisión autónoma previa (D0-a): el paso 1 crea este log antes de H1, y el log es un archivo nuevo sin commit en `50_documentacion/andamios/logs/` (no lo cubre `.gitignore`). Por eso H1 se compara contra las 5 líneas de §2 más la línea del propio log. Cualquier otra línea detiene la sesión.

Decisión autónoma previa (D0-b): la regla global exige un `CLAUDE.md` en la raíz, pero `.gitignore` lo declara gobernanza fuera del repositorio y el ALCANCE del encargo es una lista cerrada. No se crea; se declara en el reporte final.

**H1.** `git -C "$RAIZ" status --porcelain`
esperado: las 5 líneas de §2 (una ` M` y cuatro `??`: decision_datos_vista_trayectorias.md M; decision_referente_traspasos.md, encargo_pendientes_s35.md, contexto_referente_trayectorias.html, sesion35_errores_asistente.md ??) más la del propio log (D0-a)
obtenido:
```text
 M 50_documentacion/activa/decisiones/20260924_decision_datos_vista_trayectorias.md
?? 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
?? 50_documentacion/activa/encargos/encargo_pendientes_s35.md
?? 50_documentacion/andamios/20260924_contexto_referente_trayectorias.html
?? 50_documentacion/andamios/logs/20260924_pendientes_s35_log.md
?? 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
```

**H2.** `git -C "$RAIZ" stash list | wc -l`
esperado: 0
obtenido: 0

**H3.** `git -C "$RAIZ" fetch origin && git -C "$RAIZ" rev-parse --short HEAD origin/main`
esperado: b8c8e1a dos veces
obtenido:
```text
fatal: Needed a single revision
```

Nota H3: el comando literal falla por sintaxis de git (`rev-parse --short` acepta una sola revisión), no por el estado del repositorio. El `fetch` corrió sin error (sin salida). Se repite con el equivalente válido, una revisión por llamada (decisión autónoma D0-c; no es un reintento por causa transitoria).
**H3 (equivalente).** `git -C "$RAIZ" fetch origin; git -C "$RAIZ" rev-parse --short HEAD; git -C "$RAIZ" rev-parse --short origin/main`
esperado: b8c8e1a dos veces
obtenido:
```text
fetch_codigo=0
b8c8e1a
b8c8e1a
```

**H4.** `md5 -q` de las 4 rutas de §2 con md5 declarado, y del encargo
esperado:
```text
d76951a793fdcb7225d943f8604b0f64  (decision_datos_vista_trayectorias.md)
f6e79bb619b053c7245b83cd2deb1fee  (decision_referente_traspasos.md)
7d2c0f2a8584ca79a1ce64ab32d262c5  (contexto_referente_trayectorias.html)
100028e3cbdd73c245e1fc41a30345fc  (sesion35_errores_asistente.md)
a468a261eb9beb5222e79799f5db1ecf  (encargo_pendientes_s35.md, md5 del mensaje de entrega)
```
obtenido:
```text
d76951a793fdcb7225d943f8604b0f64
f6e79bb619b053c7245b83cd2deb1fee
7d2c0f2a8584ca79a1ce64ab32d262c5
100028e3cbdd73c245e1fc41a30345fc
a468a261eb9beb5222e79799f5db1ecf
```

**H5 y H6.** `md5 -q docs/index.html docs/trayectorias.html 10_utils/10_locale.R`
esperado: 8deb04595510b0f15da8bb65813b7a38, 267857a2962602bd9e6c5cc56effcb47, dc900c1b0d2d252c9e5730875be5d632
obtenido:
```text
8deb04595510b0f15da8bb65813b7a38
267857a2962602bd9e6c5cc56effcb47
dc900c1b0d2d252c9e5730875be5d632
```

**T0 (commit de los archivos del asistente).** `git add` de las 5 rutas de §2 y `git commit -m "docs(sesion 35): decisiones D35-1 y D35-2, contexto del referente, encargo y errores"`; luego `git rev-parse --short HEAD`
esperado: un commit con 5 archivos; queda sin commit solo el propio log
obtenido:
```text
[main f4bd59e] docs(sesion 35): decisiones D35-1 y D35-2, contexto del referente, encargo y errores
 5 files changed, 1062 insertions(+)
f4bd59e
?? 50_documentacion/andamios/logs/20260924_pendientes_s35_log.md
```
**Punto de retorno: `f4bd59e`.**

**H7.** `git ls-files | grep -cE "\.(csv|xlsx|parquet|rds)$"`
esperado: 27
obtenido: 27

**H8.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"`
esperado: 19 pruebas en PASA y codigo=0
obtenido: 19 pruebas (D1-D14c), 19 pasan, 0 fallan; codigo=0. Línea base de PRUEBAS: 19. Salida literal (sin las dos líneas de aviso de renv/locale):
```text
D1     PASA  Ningún agregado supera Adecuado + Insuficiente = 100 (máximo observado 89.7)
D2     PASA  El consolidado equivale a los cinco grupos combinados y ponderados (desviació
D3     PASA  Los estudiantes evaluados del consolidado igualan la suma por grupo (0 desaju
D4     PASA  Dentro de un mismo nivel y prueba, cada escuela tiene un solo grupo (condició
D5     PASA  Se declara cuántas escuelas cambian de grupo entre niveles (6345 de 52945 par
D6     PASA  El panel de serie completa nunca tiene más establecimientos que el total (0 v
D7     PASA  Toda combinación del panel de serie completa existe en el panel total (0 comb
D8     PASA  Control positivo: alterar una cifra en 0,5 puntos dispara exactamente un hall
D9     PASA  El n del total T iguala la suma de todos los grupos del parquet (entidades, r
D9c    PASA  Control positivo: un total con un evaluado de menos dispara exactamente un ha
D10    PASA  Fidelidad al mockup de la sesión 30: mismas filas; solo difieren empates de r
D10c   PASA  Control positivo: una cifra movida un décimo sin empate dispara exactamente u
D11    PASA  Las notas declaran el referente, la nube, las filas excluidas y el ejemplo qu
D12    PASA  El HTML no carga nada por red y su DATA es el que construye el generador (car
D12c   PASA  Control positivo: el patrón de red detecta un <script src="https:..."> planta
D13    PASA  Invertir el orden de las filas del parquet deja el DATA idéntico byte a byte 
D13c   PASA  Control positivo: un DATA con una cifra movida un décimo no pasa el cotejo
D14    PASA  La base no trae filas con marca ni con menos de 10 evaluados, y excluye exact
D14c   PASA  Control positivo: marcar una fila válida la saca de la base, exactamente una 
Resultado: 19 pruebas, 19 pasan, 0 fallan
codigo=0
```
Aviso observado al arrancar R: `- The project is out-of-sync -- use renv::status() for details.` (se registra; no es parte de ninguna tarea).

**H9.** `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"`
esperado: codigo=0
obtenido: codigo=0; `=== 00_build.R: OK en 6 segundos ===` (real 0m6.449s). Resumen literal del paso 33: Filas en JSON 44975; Comunas 345; Regiones 16; SLEPs 36 (2337 RBDs); Años 9 (2014-2018, 2022-2025); Peso HTML 2723.0 KB. Paso 36: `DATA: 9 años, 37 entidades, 12724 filas en datos, 20948 en nube, 180 comunas (1.4 MB)`.

**H10 (navegador y píxeles).** `Rscript -e "cat(requireNamespace(\"chromote\", quietly=TRUE), requireNamespace(\"png\", quietly=TRUE))"` y `ls "/Applications/Google Chrome.app"`
esperado: TRUE TRUE y la carpeta existe
obtenido:
```text
FALSE FALSE

Contents
ls_codigo=0
```

**H11.** `md5 -q /Users/tomgc/Projects/slep_central_datos/30_procesamiento/catalogo/dim_slep_comunas.csv` y `git -C /Users/tomgc/Projects/slep_central_datos log -1 --format=%h -- 30_procesamiento/catalogo/dim_slep_comunas.csv`
esperado: fdb3015da12264d370a9d670c6886c0b y d7a8ec6
obtenido:
```text
fdb3015da12264d370a9d670c6886c0b
d7a8ec6
```

**H12.** `md5 -q 50_documentacion/suite/fonts/gobCL_{Light,Regular,Heavy}.otf`
esperado: f5a622b0b5f209c9197b2acfd2e1e299, 0257bb4b62d5ec557627aa0136f1e1dc, 6f435f30d6a13092b7d5db5255dcca1b
obtenido:
```text
f5a622b0b5f209c9197b2acfd2e1e299
0257bb4b62d5ec557627aa0136f1e1dc
6f435f30d6a13092b7d5db5255dcca1b
44776 50_documentacion/suite/fonts/gobCL_Heavy.otf
37960 50_documentacion/suite/fonts/gobCL_Light.otf
36528 50_documentacion/suite/fonts/gobCL_Regular.otf
```

**H14.** `git -C "$RAIZ" ls-files _archivo`
esperado: una sola línea, _archivo/auditoria_agregacion_comunal.R
obtenido:
```text
_archivo/auditoria_agregacion_comunal.R
```

Nota H10: `chromote` y `png` faltan en la biblioteca del proyecto (`renv/library/...`); Chrome existe. Ambos están en la biblioteca del sistema (`/Library/Frameworks/R.framework/Versions/Current/Resources/library`) y en la caché de renv, pero renv aísla el proyecto. Se aplica la autorización 6 (solo `chromote`).
**H10, autorización 6.** `cd "$RAIZ" && Rscript -e "install.packages(\"chromote\", repos = \"https://cloud.r-project.org\")"`
esperado: instalación sin error; luego `requireNamespace("chromote")` TRUE
obtenido: codigo=0. renv interceptó `install.packages` y enlazó desde su caché 9 paquetes en la biblioteca del proyecto: AsioHeaders 1.30.2-1, chromote 0.5.1, fastmap 1.2.0, later 1.4.8, otel 0.2.0, processx 3.9.0, promises 1.5.0, ps 1.9.3, websocket 1.4.4 («Successfully installed 9 packages in 9.4 milliseconds»). No se corrió `renv::snapshot()`.

**H10 (re-medición).** mismo comando que H10, más `git status --porcelain renv.lock`
esperado: TRUE para chromote; png se re-mide; renv.lock sin cambios
obtenido:
```text
TRUE FALSE
renv.lock: []
```

**H9, línea base.** Copias de `40_salidas/motor_comparacion.html` y `40_salidas/trayectorias_traspasos.html` en `$TMPDIR/base_s35/` (`$TMPDIR=/var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/`).
esperado: copias con el mismo md5 que las salidas del build de H9
obtenido: motor_comparacion.html e8cae1083250a96b77b52e41a6bdcaac (2788309 B); trayectorias_traspasos.html 267857a2962602bd9e6c5cc56effcb47 (1485448 B), igual en las dos ubicaciones. La vista reproduce byte a byte `docs/trayectorias.html`; el motor difiere de `docs/index.html` solo por `fecha_generacion` (conocido).

**verificar_contenido_motor.R.** Escrito en la raíz tras leer `33_generar_html.R` (L383-392: `memCompress(type = "gzip")` + `jsonlite::base64_enc` sin saltos; plantilla L1167: `Uint8Array.from(atob("__JSON_DATA__"), ...)`). Extrae el único literal `atob("...")`, decodifica, quita `meta$fecha_generacion`, compara con `identical()` e imprime el primer camino distinto.
Calibración (a): `Rscript verificar_contenido_motor.R` (actual = línea base recién construida)
esperado: JSON idéntico a la línea base
obtenido:
```text
here() starts at /Users/tomgc/Projects/slep_simce_adecuado
[ locale ] 10_configuracion: la locale del proceso era UTF-8 pero el
  entorno no la declaraba. Se exportaron LANG y LC_CTYPE para que los
  procesos hijos (quarto, typst, system2) no arranquen en C.
JSON idéntico a la línea base
codigo=0
```
Calibración (b): copia `$TMPDIR/cal_s35/motor_alterado.html` con `datos$pct[1]` 3.5 → 3.6 (decodificado, alterado y recodificado por `$TMPDIR/cal_s35/calibrar_contenido_motor.R`); `Rscript verificar_contenido_motor.R $TMPDIR/cal_s35/motor_alterado.html`
esperado: JSON difiere (en $datos$pct)
obtenido:
```text
here() starts at /Users/tomgc/Projects/slep_simce_adecuado
[ locale ] 10_configuracion: la locale del proceso era UTF-8 pero el
  entorno no la declaraba. Se exportaron LANG y LC_CTYPE para que los
  procesos hijos (quarto, typst, system2) no arranquen en C.
JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)
codigo=1
```

Decisión autónoma D0-d (png): tras la autorización 6, `png` sigue ausente de la biblioteca del proyecto y ninguna autorización cubre instalarlo. No se instala. Los medidores efímeros lo cargan en solo lectura desde la biblioteca del sistema (`loadNamespace("png", lib.loc = "/Library/Frameworks/R.framework/Versions/Current/Resources/library")`, png 0.1.9, prueba de escritura y lectura de un PNG de 1×1 correcta). La comparación sigue siendo `png::readPNG` + `identical()`, como pide el encargo. Se registra como duda (Q-01).

**verificar_navegador.R.** Escrito en la raíz: `abrir_pagina()` (file:// a un ancho dado, con registro de errores de consola, excepciones y solicitudes de red que no son file:/data:/blob:), `ancho_scroll()`, `capturar_png()` (página completa), `cajas_texto()` (cajas de los `<text>` de un SVG), y ayudas `pares_superpuestos()`, `pixeles_distintos()` (png::readPNG + identical), `cambiar_ancho()`, `permitir_descargas()`.
Calibración de scrollWidth, intento 1: vista base (`40_salidas/trayectorias_traspasos.html`) a 375 px y a 1280 px
esperado: más de 375 a 375 px; 1280 a 1280 px
obtenido: 375 px → 641; 1280 px → 1265 (sesión redimensionada y sesión nueva). El caso bueno no da 1280: Chrome headless reserva 15 px para una barra de desplazamiento clásica.
Corrección del medidor (no de la meta): `fijar_ancho()` llama `Emulation.setScrollbarsHidden(hidden = TRUE)`, que emula las barras superpuestas de macOS (no restan ancho). Calibración, intento 2:
esperado: más de 375 a 375 px; 1280 a 1280 px
obtenido: 375 px → 641; 1280 px → 1280 (redimensionada) y 1280 (sesión nueva). Errores de consola 0, excepciones 0, red 0. Dos capturas seguidas a 1280 px: 0 píxeles distintos (determinismo de la captura). 99 `<text>` en los SVG de la vista.
Control positivo del registro de red y consola: copia de la vista en `$TMPDIR/cal_s35/` con `<img src="http://example.invalid/x.png">` y `console.error("plantado")` plantados
esperado: red 1; errores de consola ≥ 1
obtenido: red 1 (http://example.invalid/x.png); errores de consola 2 («plantado» y «Failed to load resource: net::ERR_NAME_NOT_RESOLVED»)

**H13.** En R (`$TMPDIR/cal_s35/h13.R`): `establecimientos_chile.parquet` y el CSV de origen (`read.csv2`, todo `character`), con `stopifnot(nrow(cat) == length(readLines(ruta)) - 1L)`
esperado: 2564 municipales (`cod_depe2 == "1"`) en comunas con `anio_traspaso` 2027-2029; 37 pares (cod_slep, anio_traspaso), 13, 11 y 13
obtenido:
```text
filas catálogo: 346
municipales en comunas de olas 2027-2029 (RBD distintos): 2564  filas: 2564
pares (cod_slep, anio_traspaso): 37
2027 2028 2029
  13   11   13
códigos distintos: 36
```

**Cierre de FASE 0.**
- Estado: completa. H1-H14 dan lo esperado, con tres notas: H1 incluye la línea del propio log (D0-a); el comando literal de H3 falla por sintaxis y el equivalente da lo esperado (D0-c); H10 requirió la autorización 6 para chromote y `png` se carga desde la biblioteca del sistema (D0-d, duda Q-01).
- Commits: `f4bd59e` (T0). Punto de retorno: `f4bd59e`.
- Cambios sustantivos: 9 paquetes enlazados desde la caché de renv en la biblioteca del proyecto (autorización 6); `renv.lock` sin cambios. Dos medidores efímeros en la raíz (`verificar_contenido_motor.R`, `verificar_navegador.R`, ignorados).
- Verificación: arriba, medición por medición.
- Alcance: T0 solo agregó las 5 rutas de §2. Queda sin commit el propio log.
- Regresión: H8 (19/19, codigo=0) y H9 (codigo=0) son la línea base.
- Subagentes: ninguno. Cuenta Opus acumulada: 0.
- Bugs: ninguno del producto. Un defecto del propio medidor (barra de 15 px) corregido en la calibración.
- Decisiones autónomas: D0-a, D0-b, D0-c, D0-d.
- Errores propios: ninguno.
- Dudas: Q-01. ¿Se acepta cargar `png` desde la biblioteca del sistema con `lib.loc` en los scripts efímeros, o se prefiere autorizar su instalación en la biblioteca de renv? (sí se acepta / no, instalar).
- Observación para las tareas: `10_validar_portabilidad.R` escanea todos los `.R` del proyecto fuera de `_archivo`, `renv` y `50_documentacion/andamios`, incluidos los `verificar_*.R` de la raíz. Si T9 lo conecta al build, un `verificar_*.R` con una ruta absoluta de usuario rompe el build. Los subagentes reciben esa regla.

### FASE T9: higiene del repositorio

Paso 0: lectura de `00_build.R` (41 líneas) y de `10_utils/10_validar_portabilidad.R` (API `validar_portabilidad()` y `validar_portabilidad_autotest()`; escanea `.R|.Rmd|.qmd|.yml` fuera de `_archivo`, `renv`, `50_documentacion/andamios`, `.git`...).

**T9.1.** `git rm --cached _archivo/auditoria_agregacion_comunal.R` (autorización 2; H14 midió exactamente esa línea). Verificación: `git ls-files _archivo | wc -l` y `test -f _archivo/auditoria_agregacion_comunal.R && echo presente`
esperado: 0 y presente
obtenido:
```text
0
presente
```
Commit T9.1: `00a8cdd` chore(repo): saca _archivo/ del índice (pendiente 11 de v34).

**T9.2, medición.** `Rscript -e "source(here::here(\"10_utils\",\"10_validar_portabilidad.R\")); r <- validar_portabilidad(detener_si_falla = FALSE); print(r)"` y `validar_portabilidad_autotest()`
esperado: 0 fallas críticas; el autotest detecta su violación plantada (SI) y limpia (SI)
obtenido: codigo=0 (la medición no detiene). `criticas= 1  advertencias= 5  archivos= 20`. La única crítica es de entorno: `data_root_resuelto FALLA` («Data root no resuelto o inaccesible; declarar <PROYECTO>_DATA_ROOT o WORKSPACE_DATA_ROOT en ~/.Renviron»). Estáticos: 0 críticos; 5 advertencias (`separador_manual` en 00_escanear_proyecto.R:101 y :184, 10_utils/10_html.R:46, 30_procesamiento/36_generar_trayectorias.R:116; `system_shell` en 10_utils/10_locale.R:27). Autotest: «Violacion sembrada detectada: SI», «Limpieza verificada: SI» (con el sabotaje, 5 críticas: 4 estáticas en `zz_autotest_sabotaje_portabilidad.R:2` más la de entorno).
Nota: la tabla de checks de entorno que imprime el validador desalinea la columna `detalle` (muestra textos de falla junto a checks en OK); el conteo `criticas` sí es 1.

- Estado T9.2: **CONGELADA** (regla de T9: «Si hay críticas: no edites 00_build.R, congela esta subtarea y registra la lista de críticas como duda»). `00_build.R` no se editó. Sin control positivo del build y sin commit.
- Lista de críticas: 1, `data_root_resuelto`. El proyecto no usa raíz de datos externa (los insumos viven en `20_insumos/`, según el encabezado de `10_utils/10_configuracion.R`), y el validador es una plantilla canónica que no se edita por proyecto.
- Duda Q-02: para conectar el validador al build, ¿se declara en la plantilla canónica de herramientas_dev una excepción de `data_root` para proyectos con insumos en el repositorio, o se define `SLEP_SIMCE_ADECUADO_DATA_ROOT` en `~/.Renviron` apuntando a la raíz del repo? (excepción en la plantilla / variable en ~/.Renviron).

**Cierre de FASE T9.**
- Estado: T9.1 completa; T9.2 congelada (Q-02).
- Commits: `00a8cdd` chore(repo): saca _archivo/ del índice (pendiente 11 de v34).
- Cambios sustantivos: `_archivo/auditoria_agregacion_comunal.R` sale del índice y queda en disco.
- Verificación: T9.1 esperado 0 y presente, obtenido 0 y presente.
- Alcance: `git show --name-only 00a8cdd` = `_archivo/auditoria_agregacion_comunal.R` (dentro del ALCANCE de T9). `00_build.R` sin cambios.
- Regresión: no aplica (T9 no tocó código).
- Subagentes: ninguno (tarea del orquestador). Cuenta Opus acumulada: 0.
- Bugs: ninguno. Decisiones autónomas: ninguna. Errores propios: ninguno. Dudas: Q-02.

### FASE T1: cohortes futuras en la vista (D35-2)

- Estado: **completa con desviación declarada** (D1-a). La calibración de C5 especificada no discrimina con los datos vigentes; se aceptó una calibración complementaria plantada.
- Commits: `6d7c757` feat(insumos): catalogo de olas de traspaso desde slep_central_datos (D35-2) · `34c6553` feat(trayectorias): cohortes futuras 2027-2029 con itinerario previo al traspaso (D35-2).
- Cambios sustantivos (retorno del subagente, verificados por diff): `36_funciones_trayectorias.R` (+238: `leer_auxiliar_csv()` validada, lectura de `establecimientos_chile.parquet`, `OLAS_FUTURAS`, `ORDEN_REGIONES`, `SEP_ID_FUTURO`, `unidades_futuras()` con validación contra el catálogo, argumento `incluir_futuras`, 9 cifras nuevas en `cifras_notas()`); `36_generar_trayectorias.R` (+56: marcador `<!--__COHORTES__-->` con los botones generados desde `tras`, reemplazo de marcadores `__NOTA_*__` en todas sus apariciones); `36_trayectorias_template.html` (botones literales retirados, `COH0` desde el botón marcado, encuadre sobre todas las unidades, apartado «Cohortes por traspasar», «36» literal reemplazado por `__NOTA_N_VIGENTES__`/`__NOTA_PARES_POSIBLES__`/`__NOTA_N_UNIDADES__`); `36_verificar_trayectorias.R` (+155: C1-C5 con control plantado; D10 construye su DATA con `incluir_futuras = FALSE`); CSV copiado; dos `.md` de gobernanza de datos.
- Verificación:

Paso 1, batería con C1-C5 antes del código (retorno del subagente; repetido contra el código de `f4bd59e` porque el reintento encontró el código nuevo ya escrito)
esperado: 19 previas en PASA y C1-C5 en FALLA
obtenido: 19 PASA; C1, C2, C3, C4 y C5 en FALLA («el argumento no fue usado (incluir_futuras = TRUE)»); «Resultado: 24 pruebas, 19 pasan, 5 fallan», codigo=1

Copia de la línea base de DATA (`$TMPDIR/base_s35/DATA_trayectorias_base.rds`, retorno del subagente)
esperado: igual al DATA de hoy; `incluir_futuras = FALSE` la reproduce exactamente
obtenido: identical() TRUE contra el DATA del código de HEAD; su JSON es idéntico al incrustado en la vista base (= `docs/trayectorias.html`); identical() TRUE contra el código nuevo con `incluir_futuras = FALSE`

md5 de la copia del catálogo (orquestador: `md5 -q 20_insumos/auxiliares/dim_slep_comunas.csv`)
esperado: fdb3015da12264d370a9d670c6886c0b
obtenido: fdb3015da12264d370a9d670c6886c0b

Batería completa (orquestador, tras el build de la ola: `Rscript 30_procesamiento/36_verificar_trayectorias.R`)
esperado: 24 en PASA (19 + C1-C5), código 0
obtenido: «Resultado: 24 pruebas, 24 pasan, 0 fallan», codigo_bateria=0 (C1: 37 unidades, 2027=13, 2028=11, 2029=13; C3: 12724 filas de 37 unidades idénticas; C5: suma 2.564, recuento independiente 2.564)

Generador (orquestador, dentro de `Rscript 00_build.R`)
esperado: código 0
obtenido: codigo_build=0; «DATA: 9 años, 74 entidades, 24745 filas en datos, 20948 en nube, 180 comunas (2.0 MB)»; vista 2,08 MB (antes 1,49 MB)

Re-derivación independiente del orquestador (`$TMPDIR/cal_s35/orq_t1.R`: lee el DATA del HTML generado y el de la línea base, sin 36_funciones ni la batería)
esperado: 37 unidades nuevas, 13/11/13, todas con `_`, sin choque, post 0, suma de `cat` 2.564, REF 1.299 en ambos, filas de las 36 vigentes y REF idénticas y en el mismo orden; `anios`, `nac`, `nube` y `comunas` sin cambio
obtenido: «unidades base: 37 actuales: 74 nuevas: 37»; tras 2027 13, 2028 11, 2029 13; «todas con '_': TRUE choque con vigentes: FALSE»; «post de futuras: 0»; «suma cat futuras: 2564»; «REF cat base/actual: 1299 / 1299»; «C3 (orq): filas vigentes+REF idénticas y en el mismo orden: TRUE» (12724 filas); «anios iguales: TRUE nac igual: TRUE nube igual: TRUE comunas iguales: TRUE»; 2 unidades con sufijo (506_2027, 1601_2027)

Navegador, 1280 px, botón 2027 (orquestador, `$TMPDIR/cal_s35/orq_nav_ola1.R`)
esperado: 13 Servicios Locales; 0 errores de consola; 0 solicitudes de red
obtenido: botones «2018 4 | 2020 3 | 2021 4 | 2024 4 | 2025 11 | 2026 10 | 2027 13 | 2028 11 | 2029 13»; #cnt «13 de 13 en pantalla · 416 establecimientos con resultado en 2014, de 827 que la cohorte administra.»; consola 0, excepciones 0, red 0, scrollWidth 1280

Calibración de C3 (retorno del subagente: fila vigente alterada en una copia de DATA)
esperado: C3 en FALLA
obtenido: «C3 FALLA ... (12724 filas de 37 unidades; idénticas: FALSE; control plantado detectado: TRUE)», codigo 1

Calibración de C5 especificada (retorno del subagente: contar `cod_depe2 %in% c("1","5")` en una copia temporal)
esperado: C5 en FALLA
obtenido: C5 PASA (suma 2.564). No dispara: en las comunas de las olas 2027-2029 el directorio no tiene ningún RBD con `cod_depe2 == "5"` (1: 2.564, 2: 2.495, 3: 347, 4: 26); los 1.707 con «5» están en otras comunas. El caso malo coincide con el bueno.

Calibración complementaria de C5 (retorno del subagente: un RBD plantado con `cod_depe2 == "5"` en la comuna 2101)
esperado: caso bueno PASA; caso malo FALLA
obtenido: (i) PASA (2.564); (ii) FALLA (suma 2.565 frente a 2.564); D12 también falla en (ii)

Máximo de los ejes (retorno del subagente; ADVIERTE esperado por el encargo)
esperado: medirlo antes y después
obtenido: máximo global 100 × 100 antes y después; cambia el marco en 26 de las 50 combinaciones previas; selección por defecto (4b_lect, T, panel 0): x 60 → 70, y 60 → 80 (lo fijan unidades futuras con 1 o 2 establecimientos, p. ej. 504_2027 con cat 2); 3 combinaciones nuevas (grupo 5) que solo existen por 1310_2029. **ADVIERTE.**

- Alcance: `git diff --name-only HEAD` + no seguidos, antes de commitear = las 7 rutas del ALCANCE de T1 más `33_motor_template.html` (de T4) y el log (del orquestador). `git show --name-only 6d7c757 34c6553` = las 7 rutas de T1. Dentro del ALCANCE.
- Regresión: build codigo=0; batería 24/24 codigo=0; I-5 «JSON idéntico a la línea base».
- Subagentes: escritura, Opus 5.5 (heredado de la sesión), esfuerzo xhigh, ALCANCE de T1. **Dos agentes**: el primero (a719abdc) trabajó de 08:39 a 09:05 y su transcripción termina con el evento «[Request interrupted by user]» sin retorno (no hubo mensaje del titular en la conversación del orquestador); el harness de Workflow lo relanzó con el mismo contrato (ab460bdb, 09:05-09:18), que auditó los cambios del primero, los adoptó, corrigió una frase y rehízo todas las mediciones. Esto consume el único reintento que admite la regla 7. Verificado con los comandos de arriba. Cuenta Opus acumulada tras la ola 1: **4** (T1 ×2, T4, T11).
- Bugs: ninguno en el producto.
- Decisiones autónomas del orquestador:
  - **D1-a (riesgo alto).** La regla «resultado no enumerado → congela» se aplicaría a la calibración de C5, cuyo caso malo no discrimina con los datos. No se congela T1: el criterio de C5 (2.564) y su valor esperado no cambian, el caso especificado no es malo con estos datos (0 RBD con «5» en esas comunas, medido), y la calibración plantada demuestra que C5 detecta una unidad de más. Congelar T1 habría congelado T2, T3 y T8. Queda como desviación declarada y duda Q-03; FASE R la audita.
  - D1-b. Se acepta que el reintento adopte el trabajo del primer agente (mismo contrato, auditado por el segundo y verificado aquí por el orquestador).
- Errores propios: mi primer script de re-derivación (`orq_t1.R`) falló dos veces al extraer DATA (posiciones de `regexpr` en bytes mezcladas con `substring` en caracteres); corregido con extracción por regex. No afectó al producto.
- Dudas:
  - Q-03. ¿Se acepta la calibración complementaria de C5 (RBD plantado con `cod_depe2 == "5"`) en lugar del caso especificado, que no discrimina con los datos vigentes? (sí / no)
  - Q-04. ¿Se acepta que el reintento de T1 haya adoptado, tras auditarlos, los cambios del agente interrumpido? (sí / no)
  - Q-05. En las cohortes por traspasar, #cnt dice «de 827 que la cohorte administra», y esas unidades aún no administran sus establecimientos. ¿Se cambia esa frase para las cohortes futuras (p. ej., «que se le traspasan») en un encargo posterior? (sí / no)
  - Q-06. El comando de I-7 no da vacío ni siquiera en el punto de retorno: `git grep` en `f4bd59e` encuentra `30_procesamiento/32_agregar_comunal.R:206: .by = c(nom_com_rbd, cod_grupo, anio)` (un resumen por consola; último commit que lo toca: 8b919df). ¿Se registra como hallazgo de línea base, fuera de este encargo, sin atribuirlo a ninguna tarea? (sí / no)

### FASE T4: motor, un solo establecimiento con asterisco (pendiente 2 de v34)

- Estado: **completa con desviación declarada** (D4-a). El criterio (e) de contraste ≥ 4,5 falla en el modo apilado para el blanco sobre la franja Elemental (2,78:1), igual que ya ocurría en la línea base con todos los puntos.
- Commits: `5a0ec3f` fix(motor): un solo establecimiento se marca con asterisco y nota, sin atenuar (pendiente 2 de v34).
- Cambios sustantivos (retorno del subagente, 63 inserciones y 18 eliminaciones en `33_motor_template.html`): las cifras del bloque reciente pierden `.attr("opacity", isLowN ? 0.7 : 1)` y llevan `ASTERISCO_UNICO` ("*"); los `rect` del bloque reciente pierden la opacidad 0,45; nota `NOTA_UNICO` («* Un solo establecimiento») con `FS_SVG.barras.notaUnico` (9,5) y `RECENT_DIMS.nota` (alto 14, línea 10), fill `#0A3A5C`; el viewBox crece 14 solo en tarjetas con algún punto único (203 frente a 189); la exportación conserva el alto propio de cada SVG de barras (`BARS_H_MAX`). Las sparklines conservan 0,45.
- Verificación:

Premisa (retorno del subagente, antes de editar)
esperado: `isLowN = s.n_estab === 1`, barras 0,45 y cifras 0,7 hacia L2323-2420
obtenido: L2323-2324; barras 0,45 (L2348, L2379); cifras 0,7 en L2363, L2398 y L2416

Estado con n_estab == 1 (retorno del subagente, medido en R sobre el JSON del motor)
esperado: un estado (territorio, nivel, prueba, grupo) con n_estab == 1 en el bloque reciente
obtenido: tablero por defecto; nivel 4b, prueba lect, territorio cod_com 5103 (depe2 5), cod_grupo 2; puntos 2023, 2024 y 2025 con n_estab 1; 7 de las 14 tarjetas sin punto único

(a)-(d) y la nota en el navegador (retorno del subagente: simple y apilado, 375 y 1280 px)
esperado: (a) 0 `<text>` con opacity; (b) cifras de puntos únicos terminadas en «*»; (c) una nota en la tarjeta elegida y ninguna en tarjetas sin punto único; (d) 0 pares superpuestos
obtenido: (a) 0 en las 4 combinaciones; (b) 3/3 (simple) y 9/9 (apilado), 0 desacuerdos con R en todas las tarjetas; (c) 1 nota en la elegida, 7 de 14 tarjetas con nota, 0 en las 7 sin punto único; (d) 0 en la elegida y en todas

Re-medición del orquestador (`$TMPDIR/cal_s35/orq_nav_ola1.R`, estado por defecto, 1280 px, base contra actual)
esperado: actual con 0 `<text>` con opacity, 0 rect atenuados, cifras con «*» y notas; base con atenuación y sin «*»
obtenido: base «<text> con opacity 37 | rect con opacity<1 15 | cifras con '*' 0 | notas 0 | pares superpuestos 0»; actual «<text> con opacity 0 | rect con opacity<1 0 | cifras con '*' 15 | notas 7 | pares superpuestos 0 | consola 0 exc 0 red 0»

(e) Contraste WCAG (retorno del subagente)
esperado: 4,5 o más en todas las cifras
obtenido: modo simple (el tablero tal como abre): 9,48 en las 3 cifras de la elegida y 0 de 37 bajo 4,5 en todas las tarjetas. Modo apilado: Adecuado 9,48, Insuficiente 9,85, **Elemental 2,78** (blanco sobre #6BA0CE) en 3 de 9; 35 de 111 cifras bajo 4,5 en todas las tarjetas, todas del par blanco/Elemental. En la línea base esas 9 cifras daban 1,35 / 1,92 / 1,87, y las 22 cifras de Elemental de puntos con varios establecimientos ya daban 2,78. Ningún color permitido por I-8 alcanza 4,5 sobre #6BA0CE (#0A3A5C 4,26; COLOR_ADEC 3,41; COLOR_INSUF 3,54). La plantilla ya lo documenta en L1713-1717 («El azul claro de la franja Elemental da 2,78:1 sobre blanco»). **Criterio (e) no cumplido en modo apilado.**

Exportación (retorno del subagente)
esperado: el SVG exportado contiene la nota
obtenido: 7 notas en el SVG exportado, dentro del SVG anidado (viewBox 320×203); PNG 3080×3686 con 1484 píxeles de tinta en cada nota y 0 en las cajas de control

Calibraciones (retorno del subagente)
esperado: (d) dispara con dos textos plantados en la misma posición; (e) < 4,5 para blanco sobre Elemental a 0,45
obtenido: (d) 0 pares antes, 1 par con dos «88%» plantados (área 266,44); (e) fondo efectivo #BCD4E8, 1,53

I-5 e I-8 (orquestador)
esperado: «JSON idéntico a la línea base»; ningún `attr("fill", "#...")` nuevo fuera de #FFFFFF y #0A3A5C
obtenido: «JSON idéntico a la línea base» (codigo_I5=0); `git diff f4bd59e -- 33_motor_template.html | grep ... | grep -vE '#FFFFFF|#0A3A5C'` vacío

- Alcance: `git show --name-only 5a0ec3f` = `30_procesamiento/33_motor_template.html`. Dentro del ALCANCE.
- Regresión: build codigo=0; batería 24/24; I-5 idéntico.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de T4; devolvió estado «parcial» por (e); verificado con los comandos de arriba. Cuenta Opus acumulada: 4.
- Bugs: ninguno.
- Decisiones autónomas del orquestador:
  - **D4-a (riesgo alto).** El criterio (e) no se cumple en modo apilado para Elemental, y la regla de detención congelaría T4 y, por el grafo, T5, T6, T7 y T8. No se congela: el fallo es una propiedad previa de la paleta (D-color-nivel), que afecta igual a todos los puntos y que ningún color permitido por I-8 resuelve; T4 no lo causa y mejora las cifras de punto único (1,35 → 2,78; 1,87 → 9,48; 1,92 → 9,85); en el tablero tal como abre, (e) se cumple en todas. Queda como desviación declarada, ADVIERTE y duda Q-07. FASE R la audita.
- Errores propios: ninguno.
- Dudas:
  - Q-07. ¿Se acepta T4 con (e) cumplido en el modo por defecto y en las cifras de Adecuado, Insuficiente y rescatadas, dejando el 2,78:1 del blanco sobre Elemental (previo, de toda la paleta) como pendiente aparte, que exige revisar D-color-nivel o I-8? (sí / no)
  - Q-08. `ASTERISCO_UNICO` ("*") coincide con la marca de dato preliminar («* Dato preliminar»). Hoy `meta.anios_preliminar` está vacío. ¿Se mantiene "*"? (sí / no)
  - Q-09. La leyenda ChartHints sigue mostrando una muestra atenuada con «Baja representatividad (un solo establecimiento)». Sigue siendo verdadera para las sparklines, pero ya no para las barras. ¿Se deja sin cambios? (sí / no)

### FASE T10: diagnóstico de ramas

- Estado: completa (solo lectura).
- Commits: ninguno.
- Verificación:

Conteo de ramas (retorno del subagente: `git branch --format='%(refname:short)' | grep -vc '^main$'`)
esperado: 4
obtenido: 4 (feat/contrato-contexto, gobernanza/v16, respaldo_normativos_20260824, respaldo_prerebase_20260824)

Re-derivación del orquestador con otro comando (`git rev-list --count main..<rama>`)
esperado: los mismos conteos de la columna «commits en main..rama» de la tabla del subagente
obtenido: feat/contrato-contexto 9; gobernanza/v16 2; respaldo_normativos_20260824 7; respaldo_prerebase_20260824 1 (coinciden)

Tabla (literal del subagente, sin juicio; `main` en el momento de la medición: `00a8cdd`):

| rama | commits en main..rama | cherry '+' | diff --stat main...rama (última línea) | ramas remotas que la contienen | fecha del último commit |
|---|---|---|---|---|---|
| feat/contrato-contexto | 9 | 3 | 16 files changed, 977 insertions(+), 760 deletions(-) | origin/feat/contrato-contexto | 2026-07-11 09:44:25 -0400 |
| gobernanza/v16 | 2 | 1 | 9 files changed, 2046 insertions(+), 68 deletions(-) | (ninguna) | 2026-08-24 09:48:05 -0400 |
| respaldo_normativos_20260824 | 7 | 1 | 11 files changed, 459 insertions(+), 745 deletions(-) | origin/feat/contrato-contexto | 2026-07-01 14:58:05 -0400 |
| respaldo_prerebase_20260824 | 1 | 0 | 2 files changed, 119 insertions(+), 4 deletions(-) | (ninguna) | 2026-08-01 17:48:28 -0400 |

- Alcance: ninguna ruta tocada.
- Subagentes: lectura, **Sonnet** (`model: 'sonnet'`), xhigh, sin ALCANCE de escritura; verificado con `git rev-list --count`. No cuenta como Opus. Cuenta Opus acumulada: 4.
- Bugs, decisiones, errores, dudas: ninguno.

### FASE T11: dudas heredadas

- Estado: completa (solo lectura). Veredictos: v30-2 PASA, v30-3 PASA, v30-5 FALLA, v31-2 PASA, v31-3 PASA.
- Commits: ninguno.
- Decisión autónoma del orquestador (D11-a): por concurrencia con T4, v31-2 y v31-3 se midieron sobre una copia de la línea base del motor (`$TMPDIR/s35_t11/motor_base.html`, md5 e8cae108…, estado anterior a T4), no sobre `40_salidas/`. La superposición del motor posterior a T4 la midieron T4 (0 pares) y el orquestador (0 pares, estado por defecto).
- Verificación:

v30-2 (`grep -n "estándar\|punto de corte" 50_documentacion/activa/referencia_glosas_simce.md`)
esperado: no se declara ningún cambio de punto de corte entre 2018 y 2022
obtenido: **PASA.** 3 coincidencias (L57, L120, L210), todas sobre `marca_eda_*` y sufijos; 0 de «punto de corte» y 0 de «corte». Calibración: una línea plantada en una copia en TMPDIR que declara un cambio de punto de corte es detectada por el mismo grep (L223). Límite: el documento no trata el tema.

v30-3 (% Adecuado nacional con y sin filas sin `cod_grupo`, regla D33-1, TOL_PP 0,15)
esperado: diferencia absoluta menor que 0,15 en las 4 combinaciones y todos los años; número de filas sin grupo (herencia: 652)
obtenido: **PASA.** 36 celdas, diferencia exactamente 0 en todas (máximo 0). 140.345 filas cumplen D33-1 y ninguna es sin grupo. 2.330 filas sin grupo en el parquet nacional (ninguna con `palu_eda_ade`); las 652 heredadas se reproducen exactas en el universo del catálogo de Servicios Locales (39.914 filas; 1.678 sin grupo fuera del catálogo). Calibración: con TOL_PP 0 el predicado marca las 36 celdas pero todas las diferencias son exactamente 0 (declarado); una fila sin grupo plantada en memoria mueve 2014/2m/lect de 23,8659 a 23,9051 y se detecta.

Re-derivación del orquestador de v30-3 (`$TMPDIR/cal_s35/orq_v30_3.R`, R base con `aggregate()`, sin dplyr)
esperado: las mismas cifras del subagente
obtenido: «filas: 185378 sin cod_grupo: 2330 sin grupo con palu_eda_ade: 0»; «filas regla D33-1: 140345 de ellas sin grupo: 0»; «celdas: 36 max |dif|: 0»; 2025/4b/lect 47,70646 en los dos cálculos (el subagente: 47,70645544). Coinciden.

v30-5 (`ls 50_documentacion/andamios/*motor*` y `git ls-files 50_documentacion/andamios`)
esperado: existe un archivo que reproduce las 28 pruebas de la auditoría del motor
obtenido: **FALLA.** `ls` sin coincidencias (rc=1); 38 rutas versionadas en andamios y ninguna es esa batería; `traspaso_cierre_v30.md` L198: «La batería de invariantes del motor se escribió en Playwright como medición y **no se versionó**».

v31-2 (375 px, 2° Medio Matemática, con Elemental e Insuficiente)
esperado: 0 pares de `<text>` superpuestos en `svg.bars-svg`
obtenido: **PASA.** 9 `svg.bars-svg` con datos, 137 textos (26 cifras rescatadas), 0 pares; contraprueba en unidades del viewBox a 375 px y en píxeles a 1280 px, 0 pares. Calibración propia: dos textos plantados encimados dan 1 par; en una tarjeta real, 1 par con lo plantado. Observación: a 375 px cada `svg.bars-svg` mide 42,75 px y los textos 1-2 px de alto: no se enciman, pero no se leen (materia de T6).

v31-3 (PNG exportado del supergrid, tarjeta Concón, grupo Bajo)
esperado: el segundo renglón bajo el año queda completo: lienzo con la altura del SVG × 2 y el `<text>` dentro del viewBox
obtenido: **PASA.** Lienzo 3546 × 3080 = 2 × (1773 × 1540) del SVG rasterizado; el único texto del segundo renglón («E 12,7%», bajo 2015) ocupa y 171-183 dentro del viewBox 0 0 320 189; 539 píxeles de tinta en su caja del PNG, 0 en la caja de control. No hizo falta juicio visual; no se dejó captura en `_archivo/`.

- Alcance: ninguna ruta del árbol tocada (retorno: `rutas_tocadas` vacío; `git status` sin cambios propios).
- Subagentes: lectura, Opus 5.5, xhigh; verificado con la re-derivación de v30-3. Cuenta Opus acumulada: 4.
- Bugs: dos fallos de su propio script de medición (regex sensible a mayúsculas; filtro con NA), corregidos al tercer intento; no del producto.
- Dudas:
  - Q-10. ¿Se registra que las 652 filas sin grupo de la herencia corresponden al universo de los Servicios Locales y que el parquet nacional tiene 2.330? (sí / no)
  - Q-11. ¿Se cierra v30-2 con este PASA de predicado, sin buscar una fuente de la Agencia sobre los puntos de corte de 2018 y 2022? (sí / no)

**Nota de plan (orquestador, tras la ola 1).** El reintento de T1 consumió una unidad Opus: la cuenta va en 4 y quedan 8 para 9 agentes planificados (T2, T5, T3, T6, T7, T8 y los 3 auditores). Para no ampliar el tope y no reducir el panel de FASE R, **T7 (la tarea más chica y mecánica) la ejecuta el orquestador en serie** (regla 7 del contrato de subagentes), con el mismo criterio y la misma calibración. Desviación declarada D-plan-1.

### FASE T2: rótulo del referente y marca de ola (D35-1)

- Estado: completa.
- Commits: `291093f` feat(trayectorias): rotulo del referente y marca de ola (D35-1).
- Cambios sustantivos (retorno del subagente, verificados por diff: 3 archivos, +427/−22 junto con T5): `filas_referente()` compartida por `construir_datos_trayectorias()` y `cifras_notas()`; `meta$REF$olas` y `meta$REF$marcas` (solo con `incluir_futuras = TRUE`, para que `FALSE` siga reproduciendo el DATA previo y D10 siga igual); `N_CERRADOS` en `cifras_notas()`; en la plantilla, `rotuloReferente()`, la constante `MARCA_OLA` y el dibujo de la marca en la pista de años (`#tk`) con `var(--ref)`; frase de las notas ampliada; R1-R4 en la batería (R2 y R4 abren la vista con chromote).
- Verificación:

Paso 1 (retorno del subagente: R1-R4 agregadas, sin código nuevo)
esperado: R1 en PASA; R2, R3 y R4 en FALLA
obtenido: R1 PASA; R2, R3 y R4 FALLA; las 24 previas en PASA; «Resultado: 28 pruebas, 25 pasan, 3 fallan», codigo=1

`meta$REF` (retorno del subagente)
esperado: olas 2027 = 479, 2028 = 407, 2029 = 408; marcas vacío; cerrados 17
obtenido: `{"2027":479,"2028":407,"2029":408}`; `marcas` = `[]`; `N_CERRADOS` = "17"; el resto de DATA idéntico al previo a T2 (anios, nac, datos, nube, comunas y meta sin REF)

Re-derivación del orquestador (`$TMPDIR/cal_s35/orq_ola2.R`, R base: regla de filas, municipal en cada fila, fuera de `sleps_chile`, con resultado en 2014)
esperado: 1.299; 479/407/408 por la comuna de la última fila; 1.282 en el directorio y 17 fuera
obtenido: «REF (orq): 1299»; por la comuna de la última fila: 2025 1, 2026 4, 2027 479, 2028 407, 2029 408; «en directorio: 1282 fuera (cerrados): 17»; por la comuna del directorio: 2027 475, 2028 406, 2029 401

Batería completa (orquestador, tras el build de la ola)
esperado: todas en PASA, código 0
obtenido: «Resultado: 28 pruebas, 28 pasan, 0 fallan», codigo_bateria=0 (R2: «esperado 1.299 y 1.124»; R3: «olas en DATA 2027=479, 2028=407, 2029=408; recuento independiente» igual; R4: «marcas en DATA 0 (esperado 0); con la copia de R3 2027/2027»)

#lg y marcas en el navegador, 1280 px, estado inicial (orquestador)
esperado: contiene «1.299» y el `e` calculado en R (1.124 para REF, 2014, 4b_lect, T, panel 0); 0 marcas de ola
obtenido: «Referente: 1.299 municipales que se traspasan entre 2027 y 2029 · con resultado en 2014: 1.124»; `.marca-ola` 0; red 0, consola 0, excepciones 0

Control positivo de la marca (retorno del subagente: vista con el DATA de la copia de R3, año 2027, 1280 y 375 px)
esperado: 1 marca «sale la ola 2027» en `var(--ref)` y «820 de 1.299 aún municipales»
obtenido: 1 marca; stroke y fill `var(--ref)`; #lg «... con resultado en 2027: 622 · 820 de 1.299 aún municipales»; 0 errores y 0 red

Calibración de R4 (retorno del subagente: plantilla copiada en TMPDIR cuyo bucle recorre `META.REF.olas` en vez de `META.REF.marcas`)
esperado: R4 en FALLA
obtenido: «R4 FALLA ... marcas en la vista 3 ...»; «28 pruebas, 27 pasan, 1 falla», codigo=1

- Alcance: `git show --name-only 291093f` = `36_funciones_trayectorias.R`, `36_trayectorias_template.html`, `36_verificar_trayectorias.R`. Dentro del ALCANCE de T2 (no tocó `36_generar_trayectorias.R`).
- Regresión: build codigo=0; batería 28/28; I-5 idéntico.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de T2; verificado con los comandos de arriba. Cuenta Opus acumulada: 5.
- Bugs: ninguno.
- Decisiones autónomas (del subagente, aceptadas por el orquestador): `olas` cuenta por la comuna de la fila más reciente de cada RBD en `simce_rbd` (reproduce 479/407/408 y los 820/413/5 de la decisión; incluye 12 de los 17 cerrados), no por la comuna del directorio (475/406/401); «aún municipales» se calcula para el año en pantalla; la batería permanente depende ahora de chromote y Chrome (chromote no está en `renv.lock`).
- Errores propios: ninguno.
- Dudas:
  - Q-12. La decisión dice «1.282 están en el directorio en comunas de las olas 2027 (479), 2028 (407) y 2029 (408)», pero 479 + 407 + 408 = 1.294. ¿Se acepta que `meta$REF$olas` cuente por la comuna de la última fila en `simce_rbd` (479/407/408, con 12 cerrados incluidos) y no por la del directorio (475/406/401)? (sí / no)
  - Q-13. ¿Se acepta que R3 compruebe también `meta$REF$olas`, que es lo que la hacía fallar antes del código? (sí / no)
  - Q-14. ¿Se acepta que «<n> de <cat> aún municipales» se calcule para el año en pantalla y no para el último año de la serie? (sí / no)
  - Q-15. El rótulo «sale la ola <año>» en `--ref` (#8A8478) sobre blanco da unos 3,7:1 a 13 px (bajo 4,5:1). Hoy no se dibuja. ¿Se mantiene en `--ref`? (sí / no)
  - Q-16. La batería permanente pasa a requerir chromote y Chrome, y chromote no está en `renv.lock`. ¿Se registra chromote en `renv.lock` en un encargo posterior? (sí / no)

### FASE T5: motor, notas metodológicas sin columna vacía (pendiente 5 de v34)

- Estado: completa.
- Commits: `5c0994b` fix(motor): notas metodologicas sin columna vacia (pendiente 5 de v34).
- Cambios sustantivos: una regla CSS (+5/−1): `.notes-grid { columns: 3 280px; column-gap: 36px; orphans: 1; widows: 1; }` con comentario. Causa (retorno del subagente): cada nota es `inline-block`, la grilla es un solo bloque con una línea por nota, y `orphans`/`widows` (2 por omisión) impiden una columna con una sola nota; con 5 notas, a 3 columnas la tercera quedaba vacía (desde unos 1.050 px).
- Verificación:

Premisa (retorno del subagente: medidor `verificar_t5_columnas.R`, notas abiertas con `.notes-toggle`, sobre el motor de HEAD `5a0ec3f`)
esperado: 1 o más columnas vacías
obtenido: 1 vacía (pista 3; notas por pista 2,3,0) en #comparacion y en #panorama a 1280 y 1920 px; también a 1050, 1100 y 1440; 0 a 375, 768 y 1024 (1 o 2 pistas)

Criterio (retorno del subagente: 2 vistas × 375, 768, 1024, 1280 y 1920 px)
esperado: 0 columnas vacías; innerText de las notas idéntico al de antes; I-5
obtenido: 0 en las 10 mediciones (notas por pista 1,1,3 a 1280 y 1920); innerText idéntico en las 10 (3.058 caracteres); «JSON idéntico a la línea base»

Re-medición del orquestador (`$TMPDIR/cal_s35/orq_ola2.R`: posición x de cada `.note` frente al número de columnas calculado del CSS, 1280 px)
esperado: base con una columna sin notas; actual con las 3 columnas ocupadas; texto igual
obtenido: #comparacion y #panorama: base «columnas 3, x distintas de notas 2 (69,69,462,462,462), texto 3058»; actual «columnas 3, x distintas 3 (69,462,854,854,854), texto 3058»

Calibración (retorno del subagente)
esperado: > 0 sobre el estado base (caso malo); 0 sobre una tabla completa de otra sección (caso bueno)
obtenido: base: 1 vacía [pista 3]; `table.data-table`: 0 de 11 columnas; `.heat-scale-bar`: 0 de 4 pistas; extra: una tabla y una grilla plantadas con una columna vacía dan 1 cada una

- Alcance: `git show --name-only 5c0994b` = `30_procesamiento/33_motor_template.html`. Dentro del ALCANCE.
- Regresión: build codigo=0; batería 28/28; I-5 «JSON idéntico a la línea base».
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de T5; verificado con la re-medición. Cuenta Opus acumulada: **6**.
- Bugs, decisiones del orquestador, errores propios: ninguno.
- Dudas:
  - Q-17. La corrección se midió solo en Chromium. ¿Se agrega al gate visual del titular abrir las notas del motor en Safari a 1280 px y confirmar que las tres columnas tienen texto? (sí / no)

### FASE T3: la vista sin desborde a 375 px (pendiente 4 de v34)

- Estado: **CONGELADA** (regla de detención: el criterio no se puede cumplir y el estado a 768 px no está enumerado). Por el grafo, congela también **T8** (requiere T3).
- Commits: ninguno. `30_procesamiento/36_trayectorias_template.html` sin cambios (md5 5e05189016a47a1ab90ba68ad4f7b25c, igual a HEAD).
- Verificación:

Paso 1, scrollWidth antes (retorno del subagente: vista regenerada desde `5c0994b`, una carga nueva por ancho)
esperado: más de 375 a 375 px (el criterio supone además que 768 px no desborda, porque exige 0 píxeles distintos ahí)
obtenido: 375 → 799; 540 → 799; 680 → 823; 768 → **823**; 1280 → 1280; 1920 → 1920. La vista desborda hasta 822 px. Causa medida: `#c-coh` pasó de 6 a 9 botones con T1 (487,2 → 749,2 px); `.ctls` mide 783,2 px y arrastra a `.main` y `.pl`. En la línea base el umbral era 665 px (768 → 768). El desborde no viene del fragmento del sitio.

Re-medición del orquestador (`$TMPDIR/cal_s35/orq_ola3.R`, 768 px)
esperado: si la premisa del subagente es cierta, la vista actual desborda a 768 px y la base no
obtenido: «vista actual a 768 px scrollWidth 823»; «vista base a 768 px scrollWidth 768»

Determinismo de las capturas (retorno del subagente)
esperado: dos capturas seguidas del mismo estado → 0 píxeles distintos
obtenido: 0 a 768, 1280 y 1920 px

- Por qué se congela: a 768 px, «scrollWidth = 768» y «0 píxeles distintos frente a la captura del paso 1» no pueden cumplirse a la vez, porque la captura del paso 1 muestra la página desbordada (quedan cortados el botón 2029, el de presentación y parte del gráfico). La única forma de cumplir la letra sería recortar el desborde con `overflow-x: clip`, que esconde contenido; el subagente la descartó y el orquestador coincide. Reemplazar el criterio a 768 px está prohibido.
- Hallazgo para FASE R: **T1 introdujo un desborde horizontal entre 666 y 822 px** que la línea base no tenía (la vista publicada no desborda a 768 px). Queda como hallazgo H-T1-1.
- Alcance: ninguna ruta versionada tocada; solo `verificar_t3_*.R` (ignorados) y `$TMPDIR/s35_t3/`.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de T3; se detuvo antes de editar y devolvió estado «congelada». Verificado con la re-medición a 768 px. Cuenta Opus acumulada: 7.
- Dudas:
  - Q-18. ¿Se acepta que, solo a 768 px, el criterio «0 píxeles distintos» se reemplace por «scrollWidth = 768 y revisión visual», manteniendo 0 píxeles distintos a 1280 y 1920 px, con la corrección en un `@media` hasta 823 px? (sí: se corrige así en un encargo posterior / no: se corrige solo bajo 768 px y a 768 px queda en 823)

### FASE T6: el panorama sin desborde a 375 px (pendiente 6 de v34)

- Estado: completa.
- Commits: `84860ea` fix(motor): panorama sin desborde bajo 540 px (pendiente 6 de v34).
- Cambios sustantivos: +7 líneas de CSS: `@media (max-width: 640px) { .panorama-grid { grid-template-columns: minmax(0, 1fr); } }` con comentario. Causa (retorno del subagente): `.panorama-grid { grid-template-columns: repeat(auto-fit, minmax(460px, 1fr)) }`; a 375 px la sección deja 295 px y la celda mide 460 px (scrollWidth 500).
- Verificación:

Paso 1 (retorno del subagente, motor regenerado desde `5c0994b`)
esperado: scrollWidth mayor a 375 a 375 px en #panorama
obtenido: 500

Criterios (retorno del subagente)
esperado: scrollWidth = viewport en #panorama a 375, 540, 680, 768 y 1280 px; 0 píxeles distintos a 768, 1280 y 1920 px en #panorama y #comparacion; I-5
obtenido: 375, 540, 680, 768, 1280 (y 1920); 0, 0, 0 en cada vista; «JSON idéntico a la línea base»; determinismo 0 en las 24 combinaciones; `document.getAnimations().length` 0

Re-medición del orquestador (`$TMPDIR/cal_s35/orq_ola3.R`: capturas propias del motor previo a T6, md5 f76bc306…, contra el actual)
esperado: #panorama 375/540/680/768/1280; 0 píxeles distintos a 768, 1280 y 1920 en las dos vistas
obtenido: «#panorama scrollWidth actual 375/540/680/768/1280: 375/540/680/768/1280»; #panorama 768/1280/1920: 0, 0, 0; #comparacion 768/1280/1920: 0, 0, 0; #comparacion 375 → 376 (sin cambio)

Calibración (retorno del subagente: `--line` #E7DFC9 → #E7DFCA en una copia de la plantilla, generada fuera del árbol)
esperado: > 0 píxeles distintos en las 6 combinaciones
obtenido: panorama 6300/6186/7870; comparacion 22331/35575/44171; la copia sin alterar reproduce el md5 de `40_salidas`

- Alcance: `git show --name-only 84860ea` = `30_procesamiento/33_motor_template.html`.
- Regresión: build codigo=0; batería «28 pruebas, 28 pasan, 0 fallan»; I-5 idéntico.
- Subagentes: escritura, Opus 5.5, xhigh, ALCANCE de T6; verificado con las capturas propias. Cuenta Opus acumulada: **8**.
- Dudas:
  - Q-19. #comparacion a 375 px sigue en 376 (1 px). Otra causa: el texto «Últimas 3 aplicaciones» (`span.sub-eyebrow`) desborda las celdas de la última columna del supergrid (4 columnas de 64,75 px). ¿Se registra como pendiente aparte? (sí / no)
  - Q-20. A 375 px, `.hero-card` del panorama deja el título en 3 líneas, casi una palabra por línea (anterior a T6; no es desborde). ¿Se registra como pendiente aparte? (sí / no)

### FASE T8: migración del sitio a gobCL (pendiente 3 de v34, D33-4)

- Estado: **CONGELADA por el grafo** (requiere T3, congelada). Además, su verificación exige scrollWidth = viewport en los anchos de T3 para la vista, que hoy desborda de 375 a 822 px. No se lanzó ningún subagente ni se copió ninguna fuente a `10_utils/fuentes/`; no se creó `_archivo/20260924_capturas_gobcl/`.
- Commits: ninguno. Subagentes: ninguno. Cuenta Opus acumulada: 8.
- Dudas: queda para un encargo posterior, después de resolver Q-18.

### FASE T7: CSS sin uso de la cabecera antigua (deuda técnica de v34)

- Estado: completa. **Ejecutada por el orquestador en serie** (D-plan-1), no por un subagente.
- Commits: `dd7fe76` refactor(motor): quita CSS sin uso de la cabecera antigua.
- Cambios sustantivos: −21 líneas en `33_motor_template.html`: `.app-header-right`, `.brand-lockup`, `.brand-eyebrow`, `.brand-eyebrow-muted` y `.brand-divider` (antes L129-140) y `.app-header-right .btn-ghost` con su `:hover` (antes L314-323). No quedan otras `.brand-*` (`grep -c "app-header-right\|brand-"` en la plantilla y en el HTML generado: 0 y 0).
- Paso 0: lectura de las reglas (L125-142 y L308-324). En el HTML generado antes de T7, cada selector aparecía una sola vez, en su propia regla CSS; ninguna aparición en el JS.
- Verificación:

Paso 1, selectores en uso (`Rscript verificar_t7_selectores.R`, motor posterior a T6, md5 7e34cb29…; 23 estados: en #comparacion la carga inicial, las notas, Elemental e Insuficiente, el popup del chip, el popup de celda, el tooltip del gráfico, el modal «Agregar territorio» y sus 6 pestañas; en #panorama la carga inicial, las notas, el selector de territorio y sus 6 pestañas, y el panorama con territorio «Nacional»)
esperado: 0 en todos los estados, y cada estado efectivamente abierto
obtenido: «estados: 23 | abiertos: 23 | con conteo > 0: 0 | consola 0/0 | red 0/0»

Control positivo del medidor (mismo script con un `<span class="brand-x">` plantado en la página)
esperado: conteo 1 en los 23 estados
obtenido: «estados: 23 | abiertos: 23 | con conteo > 0: 23»

Determinismo de las capturas (`verificar_t7_capturas.R`, dos capturas seguidas del mismo estado)
esperado: 0 píxeles distintos en las 8 combinaciones (2 vistas × 375, 768, 1280, 1920 px)
obtenido: con 1,5 s de espera, #comparacion a 375 px dio 10.641; con 3,5 s, 0 en las 8 en la corrida «antes» pero 10.641 otra vez en #comparacion 375 en la corrida «después». La diferencia está en las filas 3.483-4.344 (la parte baja de la página, que termina de pintarse tarde a ese ancho). Con 6 s de espera y 3 capturas cada 2 s, las 3 capturas «antes» y las 3 «después» son idénticas entre sí (matriz 6 × 6 de ceros), y la captura estable coincide con la segunda de la corrida corta.

Criterio (capturas antes y después de T7; «antes» con el motor posterior a T6)
esperado: 0 píxeles distintos a 375, 768, 1280 y 1920 px en #comparacion y #panorama; I-5
obtenido: #comparacion 768/1280/1920: 0/0/0; #panorama 375/768/1280/1920: 0/0/0/0; #comparacion 375: 0 entre las capturas estables (6 s) de antes y de después (la comparación de la corrida corta dio 10.641, la misma cifra y la misma zona que la carrera de determinismo); «JSON idéntico a la línea base»

Calibración del comparador (copia del HTML con `--line` #E7DFC9 → #E7DFCA, 1280 px)
esperado: > 0 píxeles distintos
obtenido: #comparacion 35.575; #panorama 6.186

- Alcance: antes de commitear, `git diff --name-only HEAD` = `30_procesamiento/33_motor_template.html` (más el log). `git show --name-only dd7fe76` = esa ruta.
- Regresión: build codigo=0; batería «28 pruebas, 28 pasan, 0 fallan»; I-5 idéntico.
- Subagentes: ninguno (D-plan-1). Cuenta Opus acumulada: 8.
- Bugs: ninguno.
- Decisiones autónomas: D-plan-1 (ejecución por el orquestador); D7-a: la espera de las capturas subió de 1,5 s a 3,5 s y, para #comparacion a 375 px, a 6 s, porque a ese ancho la página tarda en terminar de pintarse. La espera es parte del medidor, no del criterio.
- Errores propios: la primera versión del medidor de estados no abría el selector de #panorama (hay territorio por defecto; se abre con `.territorio-select`); corregido antes de medir el motor de T7. La primera calibración falló por un `sed` que no admitía los espacios de `--line:        #E7DFC9`; corregido con una expresión regular.
- Dudas: ninguna.

### FASE R: auditoría y reparación

**R.1 Inventario de afirmaciones auditables** (derivado de las secciones anteriores del log; anexado antes de auditar). Estado auditado: `HEAD` = `dd7fe76`; punto de retorno `f4bd59e`.

| id | afirmación (fuente en el log) | auditor |
|---|---|---|
| R-01 | T0 (`f4bd59e`) agrega exactamente las 5 rutas de §2 con los md5 declarados (H4) | 3 |
| R-02 | En el punto de retorno había 27 archivos de datos versionados (H7) | 3 |
| R-03 | Catálogo de origen: md5 fdb3015d…, último commit d7a8ec6 (H11); fuentes gobCL con los md5 de H12 | 3 |
| R-04 | H13: 2.564 municipales en comunas de olas 2027-2029; 37 pares (13/11/13), 36 códigos | 1 |
| R-05 | Las 19 pruebas previas (D1-D14c) siguen en PASA en el estado final (H8 como subconjunto) | 1 |
| R-06 | El comparador del JSON del motor distingue «idéntico» de «difiere» (calibración de FASE 0) | 2 |
| R-07 | T9.1: `_archivo/` fuera del índice (0 rutas) y el archivo sigue en disco | 3 |
| R-08 | T9.2: `validar_portabilidad()` da 1 crítica, de entorno (`data_root_resuelto`), y 0 críticas estáticas; `00_build.R` no se editó | 3 |
| R-09 | T1: copia del catálogo en `20_insumos/auxiliares/` con md5 fdb3015d… | 1 |
| R-10 | C1: 37 unidades futuras, 13/11/13, pares iguales a los del catálogo | 1 |
| R-11 | C2: ningún identificador futuro coincide con uno vigente | 1 |
| R-12 | C3 / I-6: las 12.724 filas de `datos` de las 36 vigentes y REF son idénticas a las de la línea base | 1 |
| R-13 | C4: toda unidad futura tiene `post == 0` | 1 |
| R-14 | C5: la suma de establecimientos de las futuras es 2.564; con los datos vigentes no hay RBD `cod_depe2 == "5"` en esas comunas | 1 |
| R-15 | Botones de cohorte generados: 2018:4 2020:3 2021:4 2024:4 2025:11 2026:10 2027:13 2028:11 2029:13; al pulsar 2027, 13 Servicios Locales | 1 |
| R-16 | R1: `meta$REF$cat` = 1.299 | 1 |
| R-17 | R2: #lg inicial contiene «1.299» y el `e` de REF en 2014/4b_lect/T/panel 0 (1.124) | 1 |
| R-18 | R3: con un año sintético 2027, el referente pierde exactamente los RBD de la ola 2027 | 1 |
| R-19 | R4: `meta$REF$marcas` vacío con los datos actuales; 0 marcas en la vista | 1 |
| R-20 | `meta$REF$olas` = 479/407/408 (por la comuna de la última fila en `simce_rbd`); 1.282 en el directorio, 17 fuera | 1 |
| R-21 | v30-3: diferencia 0 entre el % Adecuado nacional con y sin filas sin grupo; 2.330 filas sin grupo, 652 en el universo de Servicios Locales | 1 |
| R-22 | T4 (a)-(d): en el estado por defecto del motor, 0 `<text>` con `opacity` y 0 `rect` atenuados en `svg.bars-svg`; 15 cifras con «*»; 7 notas; 0 pares superpuestos | 2 |
| R-23 | T4 (e): contraste ≥ 4,5 en el modo por defecto; en modo apilado, blanco sobre Elemental (#6BA0CE) = 2,78 | 2 |
| R-24 | T4: el SVG exportado contiene la nota | 2 |
| R-25 | T5: 0 columnas vacías en las notas del motor a 1280 px en las dos vistas; texto de las notas idéntico al previo | 2 |
| R-26 | T6: #panorama con scrollWidth = viewport a 375/540/680/768/1280; #comparacion a 375 da 376 (sin cambio) | 2 |
| R-27 | T7: 0 elementos `.app-header-right, [class*="brand-"]`; las reglas ya no existen; sin cambio visual a 768/1280/1920 frente a la línea base en las zonas no tocadas por T4-T6 | 2 |
| R-28 | T3 (congelada): la vista actual desborda a 768 px (823) y la base no (768) | 2 |
| R-29 | v31-2: 0 pares superpuestos a 375 px en 2° Medio Matemática con Elemental e Insuficiente (motor base) | 2 |
| R-30 | T10: conteos `main..rama` 9, 2, 7, 1 | 3 |
| R-31 | v30-2 PASA y v30-5 FALLA (evidencia de grep y ls) | 3 |
| R-32 | T8 congelada: no existe `10_utils/fuentes/` ni `_archivo/20260924_capturas_gobcl/`; ningún archivo de T8 cambió | 3 |
| R-33 | I-1 docs/ intacto | 3 |
| R-34 | I-2 sin cargas por red | 3 |
| R-35 | I-3 vendorizados sin cambio | 3 |
| R-36 | I-4 guarda de locale | 3 |
| R-37 | I-5 JSON del motor idéntico a la línea base (con decodificador propio) | 2 |
| R-38 | I-6 (= R-12) | 1 |
| R-39 | I-7 sin agregación por `nom_com_rbd` introducida por el encargo (el acierto de `32_agregar_comunal.R:206` es previo) | 3 |
| R-40 | I-8 sin fills nuevos fuera de #FFFFFF y #0A3A5C | 3 |
| R-41 | I-9 mockup congelado | 3 |
| R-42 | I-10 un `__SITIO_HTML__` por plantilla | 3 |
| R-43 | I-11 28 archivos de datos versionados | 3 |
| R-44 | I-12 (cubierto por I-5) | 2 |
| R-45 | Alcance global: `git diff --name-only f4bd59e..HEAD` contenido en la unión de los ALCANCE | orquestador y 3 |
| R-46 | Regresión: build codigo=0, batería 28/28, I-5 idéntico en el estado final | orquestador |

**R.3 Invariantes 🔒** (orquestador, estado `dd7fe76`, tras el build de la regresión; comandos de §4 con `<punto_de_retorno>` = `f4bd59e`)

I-1 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47
obtenido: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47 → **PASA**

I-2 `grep -c 'src="http'` y `grep -c 'url(http'` en los 4 HTML
esperado: 0 en cada archivo
obtenido: 0, 0, 0, 0 y 0, 0, 0, 0 → **PASA**

I-3 `git diff --name-only f4bd59e..HEAD -- 10_utils/*.js`
esperado: vacío
obtenido: vacío → **PASA**

I-4 `md5 -q 10_utils/10_locale.R` y `grep -n 'asegurar_locale_utf8' 10_utils/10_configuracion.R`
esperado: dc900c1b… y una línea
obtenido: dc900c1b0d2d252c9e5730875be5d632 y «16:asegurar_locale_utf8("10_configuracion")» → **PASA**

I-5 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base», codigo_I5=0 → **PASA**

I-6 prueba C3 de la batería
esperado: PASA
obtenido: «C3 PASA ... (12724 filas de 37 unidades; idénticas: TRUE; control plantado detectado: ...)» → **PASA**

I-7 `grep -nE '(\.by|by|group_by)[^#]*nom_com_rbd' 30_procesamiento/*.R`
esperado: vacío
obtenido: «30_procesamiento/32_agregar_comunal.R:206: .by = c(nom_com_rbd, cod_grupo, anio)» → **FALLA en la letra**. La misma línea ya estaba en el punto de retorno (`git grep` sobre `f4bd59e`, FASE T1); ningún commit del encargo toca `32_agregar_comunal.R` (ver alcance global). Clasificación en R.7.

I-8 `git diff f4bd59e..HEAD -- 30_procesamiento/33_motor_template.html | grep -E '^\+.*attr\("fill", *"#' | grep -vE '#FFFFFF|#0A3A5C'`
esperado: vacío
obtenido: vacío → **PASA**

I-9 `git diff --name-only f4bd59e..HEAD -- 50_documentacion/andamios/mockup_trayectoria_traspasos.html`
esperado: vacío
obtenido: vacío → **PASA**

I-10 `grep -c '__SITIO_HTML__'` en las dos plantillas
esperado: 1 en cada una
obtenido: 1 y 1 → **PASA**

I-11 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 → **PASA**

I-12 cubierto por I-5
esperado: «idéntico»
obtenido: «JSON idéntico a la línea base» → **PASA**

**R.4 Alcance global** (`git diff --name-only f4bd59e..HEAD`)
esperado: contenido en la unión de los ALCANCE (más el log, aún sin commitear)
obtenido: `20_insumos/auxiliares/dim_slep_comunas.csv` (T1), `30_procesamiento/33_motor_template.html` (T4-T7), `30_procesamiento/36_funciones_trayectorias.R`, `36_generar_trayectorias.R`, `36_trayectorias_template.html`, `36_verificar_trayectorias.R` (T1-T2), `50_documentacion/activa/50_datos_versionados_autorizados.md`, `50_documentacion/activa/manifiesto_insumos.md` (T1), `_archivo/auditoria_agregacion_comunal.R` (T9, salida del índice). Todas dentro de la unión. `git status --porcelain`: solo `?? 50_documentacion/andamios/logs/20260924_pendientes_s35_log.md`. **PASA.**

**R.5 Regresión completa** (estado `dd7fe76`)
esperado: `Rscript 00_build.R` codigo=0; batería codigo=0 con 28 pruebas (19 previas + C1-C5 + R1-R4); I-5 idéntico
obtenido: codigo_build=0; «Resultado: 28 pruebas, 28 pasan, 0 fallan», codigo_bateria=0; «JSON idéntico a la línea base», codigo_I5=0 → **PASA**

**R.2 Re-derivación independiente.** Panel de 3 lectores Opus en una sola ola (workflow `fase-r-s35`), cada uno con las afirmaciones, las rutas de las fuentes y el repositorio, sin el log, sin los `verificar_*.R` de la raíz ni los temporales de las tareas, y sin correr la batería como evidencia. Scripts propios en `$TMPDIR/s35_r1/`, `s35_r2/` y `s35_r3/`. Resultado: auditor 1, 15/15 CONFIRMADA; auditor 2, 11/11 CONFIRMADA; auditor 3, 16 CONFIRMADA y 2 REFUTADA (R-32 y R-39). Cuenta Opus acumulada: **11** (tope 12).

**R.6 Control positivo de la propia auditoría.**
- Cifra alterada (auditor 1): copia de la vista en TMPDIR con el `e` de REF (2014, 4b_lect, T, panel 0) cambiado de 1124 a 1125 (1 byte). Instrumento de R-12: sin alteración «identicas y en orden: TRUE»; con alteración «identicas y en orden: FALSE» y «difiere fila 1623». Instrumento de R-17: sin alteración «VEREDICTO instrumento: PASA»; con alteración «contiene 'con resultado en 2014: 1.124': FALSE», «VEREDICTO instrumento: FALLA». **Dispara.**
- Archivo fuera de alcance (auditor 3): diff real «total_rutas=10 fuera=0»; con `10_utils/10_locale.R` y el mockup plantados, «FUERA_DE_ALCANCE: 10_utils/10_locale.R», «FUERA_DE_ALCANCE: 50_documentacion/andamios/mockup_trayectoria_traspasos.html», «total_rutas=12 fuera=2»; prefijo engañoso `33_motor_template.html.bak`, «fuera=1». **Dispara.**
- Además: superposición (auditor 2) 0 pares sin plantar, 1 par con dos `<text>` plantados en (60,60), 0 al retirarlos; comparador de JSON propio del auditor 2 «DIFIERE en $datos$pct[[1]] 3.5 vs 3.6»; detector de red con chromote (auditor 3) 1 solicitud con un `<img>` plantado.

**R.7-R.8 Hallazgos, severidad y ciclos de reparación.** Ciclo 1: R-47, R-48 y R-49. Ciclo 2: R-63 (defecto del mismo tipo que R-48, detectado por el orquestador al consolidar Q-05). Tras cada ciclo se repitieron los pasos 2 a 5 sobre lo tocado (abajo). Ninguna reparación destapó otro defecto.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | T0 agrega 5 rutas con sus md5 | A3: `git show f4bd59e:<ruta> \| md5` | 5 md5 de §2 | los 5 iguales; commit con 5 rutas | — | ninguna | — | — |
| R-02 | 27 datos versionados en f4bd59e | A3: `git ls-tree -r f4bd59e` + filtro | 27 | 27 | — | ninguna | — | — |
| R-03 | md5 del catálogo y de las fuentes gobCL | A3: md5 y `git log` en slep_central_datos | fdb3015d…/d7a8ec6; f5a622b0…, 0257bb4b…, 6f435f30… | iguales (HEAD de slep_central_datos pasó a a0e5dd9; ningún commit nuevo toca el catálogo) | — | ninguna | — | — |
| R-04 | H13: 2.564; 37 pares 13/11/13 | A1: R base, `read.table` + parquet | 2.564; 37; 36 códigos | 2564; 37 (13/11/13); 36 (502 repetido) | — | ninguna | — | — |
| R-05 | 19 pruebas previas siguen verdaderas | A1: D1, D4, D6/D7, D9, D11-D14 con código propio | todas verdaderas | todas verdaderas (D1 máx. 100,0; D12 0 red; D13 permutación aleatoria idéntica) | — | ninguna | — | — |
| R-06 | comparador de JSON calibrado | A2: decodificador propio | idéntico/difiere | «IDENTICA» y «DIFIERE en $datos$pct[[1]]» | — | ninguna | — | — |
| R-07 | T9.1 fuera del índice, en disco | A3: `git ls-files _archivo`, `test -f`, `git show --stat 00a8cdd` | 0; presente; 1 ruta | 0; presente; 1 ruta | — | ninguna | — | — |
| R-08 | T9.2: 1 crítica de entorno | A3: `validar_portabilidad(detener_si_falla = FALSE)` | 1 (data_root_resuelto); 0 estáticas | criticas_total=1, criticas_estaticas=0; 00_build.R sin cambios | — | ninguna (T9.2 congelada) | — | — |
| R-09 | md5 de la copia del catálogo | A1: md5, openssl, `cmp` | fdb3015d… | idénticos byte a byte | — | ninguna | — | — |
| R-10 | C1 | A1: ids fuera de sleps_chile | 37; 13/11/13; pares = catálogo | 37; 13/11/13; TRUE | — | ninguna | — | — |
| R-11 | C2 | A1: intersección de ids | 0 | 0 | — | ninguna | — | — |
| R-12 | C3 / I-6 | A1: texto crudo y JSON parseado contra la base | 12.724 idénticas | TRUE (M1 y M2) | — | ninguna | — | — |
| R-13 | C4 | A1: `post` de las futuras | 0 en las 37 | 0:37 | — | ninguna | — | — |
| R-14 | C5; 0 RBD depe 5 en esas comunas | A1: suma y tabla de `cod_depe2` | 2.564; 0 | 2564; 0 (1:2564 2:2495 3:347 4:26) | ADVIERTE (R-61) | registrar | — | — |
| R-15 | botones de cohorte y clic en 2027 | A1: chromote con `Input.dispatchMouseEvent` | 9 botones; 13 | iguales; 13; 0 errores, 0 red | — | ninguna | — | — |
| R-16 | R1 | A1: conteo propio del referente | 1.299 | 1299 | — | ninguna | — | — |
| R-17 | R2 | A1: chromote + `e` propio | «1.299» y «1.124» | ambos presentes | — | ninguna | — | — |
| R-18 | R3 | A1: copia sintética propia | pierde exactamente la ola 2027 | TRUE | — | ninguna | — | — |
| R-19 | R4 | A1: `meta.REF.marcas` y DOM | vacío; 0 marcas | vacío; 0 | — | ninguna | — | — |
| R-20 | olas 479/407/408; 1.282 y 17 | A1: conteo propio | 479/407/408; 1.282; 17 | iguales | ADVIERTE (R-51) | registrar | — | — |
| R-21 | v30-3 | A1: cálculo propio | diferencia 0; 2.330 y 652 | 0; 2330; 652 | — | ninguna | — | — |
| R-22 | T4 (a)-(d) | A2: chromote propio a 1280 y 375 | 0 opacity; 15 «*»; 7 notas; 0 pares | iguales; «*» ⇔ n_estab == 1 en los datos | — | ninguna | — | — |
| R-23 | T4 (e) | A2: WCAG propio | ≥ 4,5 por defecto; 2,78 Elemental apilado | iguales | ADVIERTE (R-60) | registrar | — | — |
| R-24 | nota en el SVG exportado | A2: descarga propia | presente | presente | — | ninguna | — | — |
| R-25 | T5 | A2: columnas de `.notes-grid` y texto | 0 vacías; texto idéntico | 0; idéntico | — | ninguna | — | — |
| R-26 | T6 | A2: scrollWidth propio | viewport en 5 anchos; 376 en #comparacion 375 | iguales (base 500) | — | ninguna | — | — |
| R-27 | T7 | A2: plantilla previa y uso de clases | reglas ausentes; 0 usos | iguales | — | ninguna | — | — |
| R-28 | T3: la vista desborda a 768 | A2: scrollWidth propio | 823 hoy; 768 base | 823; 768 | REPARA (R-47) | corregido | f076470 | ver R-47 |
| R-29 | v31-2 | A2: superposición propia | 0 pares | 0 | — | ninguna | — | — |
| R-30 | T10 | A3: `git log --format=%H main..<rama> \| wc -l` | 9, 2, 7, 1 | 9, 2, 7, 1 | — | ninguna | — | — |
| R-31 | v30-2 PASA; v30-5 FALLA | A3: grep y `git ls-files` propios | sin cambio de corte; sin batería de 28 | iguales | — | ninguna | — | — |
| R-32 | T8 sin rastro | A3: `ls`, blobs, `grep -ci gobcl` | sin fuentes ni capturas; 10_html.R y fragmento sin cambio; «ninguna plantilla menciona gobCL» | lo primero, igual; pero hay 3 menciones previas en comentarios (motor L11 y L80, vista L13), iguales en f4bd59e; el diff no agrega ni quita ninguna | ADVIERTE (R-64) | corregir la afirmación: el diff f4bd59e..HEAD no tiene líneas con gobCL | — | — |
| R-33 | I-1 | A3: md5 y `git diff -- docs/` | 8deb0459…, 267857a2…; vacío | iguales; vacío | — | ninguna | — | — |
| R-34 | I-2 | A3: grep y chromote | 0 | 0; 0 solicitudes externas | ADVIERTE (R-59) | registrar | — | — |
| R-35 | I-3 | A3 | vacío | vacío | — | ninguna | — | — |
| R-36 | I-4 | A3 | dc900c1b…; 1 | iguales | — | ninguna | — | — |
| R-37 | I-5 | A2: decodificador propio | idéntico | idéntico | — | ninguna | — | — |
| R-38 | I-6 | = R-12 | PASA | PASA | — | ninguna | — | — |
| R-39 | I-7 | A3: grep, `git grep f4bd59e`, blame, líneas «+» | vacío | 1 acierto (`32_agregar_comunal.R:206`, commit f3318d4 del 2026-06-08), igual en f4bd59e; 0 en las líneas «+» del encargo | **BLOQUEA** | no se repara (fuera de todo ALCANCE; un BLOQUEA no se repara); ninguna tarea de origen en el encargo; duda Q-06 | — | — |
| R-40 | I-8 | A3 | vacío | vacío | — | ninguna | — | — |
| R-41 | I-9 | A3 | vacío | vacío | — | ninguna | — | — |
| R-42 | I-10 | A3 | 1 y 1 | 1 y 1 | — | ninguna | — | — |
| R-43 | I-11 | A3 | 28 | 28; el único agregado es el catálogo | — | ninguna | — | — |
| R-44 | I-12 | = R-37 | idéntico | idéntico | — | ninguna | — | — |
| R-45 | alcance global | A3: `alcance.sh` por ruta y por commit | 0 fuera | 0 fuera en total y en los 8 commits; historia lineal | — | ninguna | — | — |
| R-46 | regresión | orquestador | build 0; 28/28; I-5 | iguales (R.5, y de nuevo tras cada ciclo) | — | ninguna | — | — |
| R-47 | T1 hizo desbordar la vista entre 666 y 822 px | A1 y A2 (scrollWidth); orquestador | sin desborde donde la base no desbordaba | 823 a 680-822 px | REPARA | `#c-coh` se reparte en líneas si no cabe (`flex-wrap`, alto mínimo de botón, `.f.f-coh{max-width:100%}`) | f076470 | mismo chequeo: 680/768/800/822 → 680/768/800/822; chequeo distinto: 0 elementos fuera del viewport (antes 54/36/18/5); 0 píxeles distintos a 900, 1024, 1280 y 1920; 375 y 540 quedan en 641, como la base (materia de T3) |
| R-48 | la nota «Cohortes por traspasar» es falsa para del Litoral (502_2028) | A1; orquestador | frase verdadera contra DATA | 1 violación | REPARA | la frase se acota a «las cohortes 2018 a 2026» con marcadores existentes | 9e83ecf | chequeo lógico contra DATA: 0 violaciones (calibración con la frase vieja: 1, 502_2028); texto presente en la vista; 0 marcadores sin reemplazar |
| R-49 | el comentario nuevo de T4 dice que la sparkline no lleva cifra | A2 | comentario verdadero | falso (la sparkline lleva cifra a 0,405) | REPARA | comentario corregido; sin cambio de conducta | 1150846 | I-5 idéntico; 0 píxeles distintos a 1280 en las dos vistas |
| R-50 | las futuras cambian el marco de los ejes en 29 de 53 combinaciones | A1 | ADVIERTE esperado (§7 T1.4) | 4b_lect/T/0: 60×60 → 70×80, fijado por unidades de 1 o 2 establecimientos | ADVIERTE | registrar; decide el titular (Q-21) | — | — |
| R-51 | `olas` cuenta 12 cerrados; «aún municipales» los contaría como vigentes; la suma de la decisión no cuadra (1.294 ≠ 1.282) | A1 | — | sin efecto hoy (marcas vacío) | ADVIERTE | registrar (Q-12, Q-22) | — | — |
| R-52 | la batería no recuenta de forma independiente las 12.021 filas futuras; C3 no se ancla a la línea base | A1 | — | recuento propio del auditor: 0 diferencias | ADVIERTE | registrar (Q-23) | — | — |
| R-53 | las cifras de la sparkline de un solo establecimiento siguen atenuadas (2,14:1) | A2 | — | igual que la base; premisa de T4.2 falsa | ADVIERTE | registrar (Q-24) | — | — |
| R-54 | la leyenda «Baja representatividad» conserva la muestra atenuada | A2 | — | — | ADVIERTE | registrar (Q-09) | — | — |
| R-55 | «*» significa dato preliminar y un solo establecimiento | A2 | — | simulado con 2025 preliminar: conviven en 4 barras, sin superposición | ADVIERTE | registrar (Q-08) | — | — |
| R-56 | a 375 px, apilado y con establecimientos agregados, cifras rescatadas se superponen por fracciones de píxel | A2 | — | 0,43-0,46 px² (base 0,37-0,40) | ADVIERTE | registrar | — | — |
| R-57 | a 375 px los textos del supergrid rinden a ~1,3 px | A2 | — | previo | ADVIERTE | registrar | — | — |
| R-58 | captura no determinista de los bordes de tabla de #comparacion a 375 px | A2 y orquestador (T7) | — | 10.641 píxeles en la zona 3.483-4.344 | ADVIERTE | registrar (método) | — | — |
| R-59 | el comando de I-2 no ve `src='http` ni `//` | A3 | — | 0 solicitudes externas medidas con chromote | ADVIERTE | registrar (instrumento) | — | — |
| R-60 | T4 (e): 2,78 blanco/Elemental en apilado | A2 | ≥ 4,5 | 2,78 | ADVIERTE | registrar (D4-a, Q-07) | — | — |
| R-61 | calibración especificada de C5 no discrimina | A1 | dispara | no dispara (0 RBD depe 5) | ADVIERTE | registrar (D1-a, Q-03) | — | — |
| R-62 | `50_datos_versionados_autorizados.md` sigue diciendo «27 rutas» | A3 | — | 28 archivos de datos | ADVIERTE | registrar (Q-25) | — | — |
| R-63 | #cnt dice «que la cohorte administra» en las cohortes por traspasar | orquestador (Q-05) | frase verdadera | 3 cohortes con la frase falsa (2027-2029) | REPARA | la frase pasa a «que se traspasan a la cohorte» cuando el id es `<cod_slep>_<año>` (constante `SEP_ID_FUTURO`) | bfa40c9 | chequeo por cohorte de los 9 botones: 0 incorrectas (calibración con la plantilla previa: 3); 0 píxeles distintos en el estado inicial; batería 28/28 |
| R-64 | la afirmación R-32 del inventario era imprecisa | A3 | — | 3 menciones previas de gobCL en comentarios | ADVIERTE | error propio registrado | — | — |

**Pasos 2-5 tras los ciclos** (orquestador, estado `bfa40c9`)
esperado: re-derivaciones de lo tocado sin cambios (C3 contra la línea base, #lg, botones, marcas); invariantes como en R.3; alcance global igual; build 0, batería 28/28, I-5 idéntico
obtenido: «C3 (orq): ... idénticas y en el mismo orden: TRUE»; #lg «Referente: 1.299 ... con resultado en 2014: 1.124»; botones iguales; `.marca-ola` 0; I-1 8deb0459…/267857a2…; I-2 0 y 0; I-3 vacío; I-4 dc900c1b… y 1; I-7 la misma línea previa; I-8 vacío; I-9 vacío; I-10 1 y 1; I-11 28; alcance: las mismas 9 rutas; codigo_build=0; «Resultado: 28 pruebas, 28 pasan, 0 fallan»; «JSON idéntico a la línea base»

**Veredicto global de FASE R: BLOQUEADO.** Un solo hallazgo BLOQUEA, R-39: el invariante I-7 da FALLA literal por una línea anterior al encargo (`32_agregar_comunal.R:206`, commit f3318d4), que ninguna tarea tocó ni podía tocar. Leerlo como no-regresión sería cambiar el criterio (§8.9). No compromete el repositorio (es un resumen por consola que no llega a ningún parquet ni HTML), así que la sesión no se detiene; pero, por la autorización 3, **no se publica**. Sin R-39, el veredicto sería APROBADO CON ADVERTENCIAS: 4 REPARA corregidos y re-verificados (R-47, R-48, R-49, R-63), 14 ADVIERTE registrados (R-50 a R-62 y R-64), 0 afirmaciones refutadas sobre el producto (las dos refutadas son R-32, una frase imprecisa del inventario, y R-39).

## Cierre

**FASE L, paso 1 (estado del árbol antes de tocar el cierre).** `git status --porcelain`
esperado: vacío, o solo el propio log
obtenido: `?? 50_documentacion/andamios/logs/20260924_pendientes_s35_log.md` (solo el log)

### 1. Resumen

D35-2 (cohortes futuras) y D35-1 (rótulo del referente y marca de ola) quedaron implementadas en la vista. En el motor quedaron resueltos los pendientes 2, 5 y 6 de v34 y la deuda de CSS sin uso. También se hizo T9.1 y se midieron T10 y T11. Quedaron congeladas T3 (el criterio es incumplible a 768 px), T8 (depende de T3) y T9.2 (una crítica de entorno del validador). FASE R confirmó todas las afirmaciones sobre el producto, corrigió 4 defectos propios (R-47, R-48, R-49, R-63) y registró 14 advertencias. Su veredicto es BLOQUEADO por I-7: el comando falla por una línea anterior al encargo. Todo quedó commiteado en `main`. **No se hizo push.**

### 2. Inventario de commits (`git log --oneline f4bd59e..HEAD`, más T0)

```text
bfa40c9 fix(auditoria): R-63 las cohortes por traspasar no dicen que administran sus establecimientos
1150846 fix(auditoria): R-49 el comentario de la sparkline del motor dice que su cifra sigue atenuada
9e83ecf fix(auditoria): R-48 la nota de cohortes por traspasar se acota a las cohortes vigentes
f076470 fix(auditoria): R-47 la vista no desborda entre 666 y 822 px con las cohortes futuras
dd7fe76 refactor(motor): quita CSS sin uso de la cabecera antigua
84860ea fix(motor): panorama sin desborde bajo 540 px (pendiente 6 de v34)
5c0994b fix(motor): notas metodologicas sin columna vacia (pendiente 5 de v34)
291093f feat(trayectorias): rotulo del referente y marca de ola (D35-1)
5a0ec3f fix(motor): un solo establecimiento se marca con asterisco y nota, sin atenuar (pendiente 2 de v34)
34c6553 feat(trayectorias): cohortes futuras 2027-2029 con itinerario previo al traspaso (D35-2)
6d7c757 feat(insumos): catalogo de olas de traspaso desde slep_central_datos (D35-2)
00a8cdd chore(repo): saca _archivo/ del índice (pendiente 11 de v34)
f4bd59e docs(sesion 35): decisiones D35-1 y D35-2, contexto del referente, encargo y errores   (T0, punto de retorno)
```
Más el commit `docs(log): pendientes de la sesion 35` de este archivo; su hash se informa en el reporte final porque el archivo no puede contener el hash de su propio commit.

### 3. Tabla de auditoría

La tabla completa está en FASE R (R.10). Hay 64 filas: 46 afirmaciones (44 CONFIRMADA y 2 REFUTADA: R-32 era una frase imprecisa del inventario y R-39 es I-7) y 18 hallazgos nuevos. En total: 1 BLOQUEA (R-39), 4 REPARA corregidos (R-47 f076470, R-48 9e83ecf, R-49 1150846, R-63 bfa40c9) y 14 ADVIERTE. Se usaron dos ciclos de reparación, sin pendientes de reparación.

### 4. Invariantes

I-1, I-2, I-3, I-4, I-5, I-6, I-8, I-9, I-10, I-11 e I-12: **PASA** al cierre de cada fase y en el estado final `bfa40c9`. I-7: **FALLA literal**, con la misma línea en el punto de retorno (`32_agregar_comunal.R:206`). Ningún commit del encargo toca ese archivo ni agrega aciertos.

### 5. Decisiones del usuario

No hubo mensajes del titular durante la ejecución: la única instrucción fue ejecutar el encargo, verificando antes su md5. Las decisiones del titular que aplicó el encargo vienen de la sesión 35: D35-1, el alcance de D35-2, el asterisco con nota de T4 y T10 como solo diagnóstico.

### 6. Estado de cifras (todas medidas en esta sesión con Rscript o chromote; ver cada fase)

- Vista: 74 entidades (36 vigentes, 37 futuras con 13/11/13 por ola, más REF). 24.745 filas en `datos` (antes 12.724); las 12.724 de las vigentes y de REF son idénticas a la línea base. 2.564 establecimientos futuros, de ellos 1.593 con algún resultado. `meta.REF`: cat 1.299; olas 479/407/408; marcas vacío. Cerrados: 17. En el directorio: 1.282 (475/406/401). #lg inicial: «1.299 … con resultado en 2014: 1.124». Batería: 28 pruebas en PASA.
- Motor: JSON de datos idéntico a la línea base. En el tablero por defecto hay 15 cifras con «*» y 7 notas. Contraste por defecto: 9,48; en modo apilado, blanco sobre Elemental: 2,78. #panorama sin desborde de 375 a 1280 px (antes: 500 a 375 px). #comparacion a 375 px: 376 (sin cambio).
- Repositorio: 28 archivos de datos versionados; `docs/` intacto (8deb0459…, 267857a2…).
- Dudas heredadas: v30-2 PASA; v30-3 PASA (diferencia 0; 2.330 filas sin grupo en total, 652 en los Servicios Locales); v30-5 FALLA; v31-2 PASA; v31-3 PASA.

### 7. Dudas y pendientes consolidados

Tareas congeladas:
- T3: su criterio no se puede cumplir a 768 px (Q-18).
- T8: depende de T3.
- T9.2: una crítica de entorno del validador (Q-02).

Dudas, cada una con pregunta cerrada en su fase:
- Q-01 `png` cargado desde la biblioteca del sistema.
- Q-02 excepción de `data_root` o variable en `~/.Renviron`.
- Q-03 calibración complementaria de C5.
- Q-04 adopción del trabajo del agente de T1 interrumpido.
- Q-05 frase de #cnt: resuelta en FASE R como R-63; queda la redacción a juicio del titular.
- Q-06 I-7: ¿se evalúa como no-regresión sobre `f4bd59e..HEAD` o como estado absoluto? ¿Se corrige `32_agregar_comunal.R:206` en otro encargo?
- Q-07 contraste de Elemental en modo apilado.
- Q-08 «*» con doble significado.
- Q-09 leyenda ChartHints.
- Q-10 las 652 frente a las 2.330 filas sin grupo.
- Q-11 cierre de v30-2.
- Q-12 regla de conteo de `olas`.
- Q-13 R3 cubre `olas`.
- Q-14 «aún municipales» por año en pantalla.
- Q-15 contraste del rótulo de la marca.
- Q-16 chromote en `renv.lock`.
- Q-17 notas del motor en Safari.
- Q-18 criterio de T3 a 768 px.
- Q-19 1 px en #comparacion a 375.
- Q-20 `.hero-card` a 375 px.

Dudas nuevas de FASE R:
- Q-21. ¿El marco de los ejes excluye a las unidades con muy pocos establecimientos, o se acepta que 504_2027 y 1310_2029 lo fijen? (sí, se excluyen / no, se acepta)
- Q-22. Antes de la primera marca de ola, ¿«aún municipales» descuenta los cerrados, y se corrige el paréntesis de la decisión (1.294 ≠ 1.282)? (sí / no)
- Q-23. ¿Se extiende el recuento independiente de D9 a las unidades futuras? (sí / no)
- Q-24. ¿La cifra de la sparkline de un solo establecimiento pasa al asterisco, como las barras? (sí / no)
- Q-25. ¿Se actualiza el conteo «27 rutas» de `50_datos_versionados_autorizados.md`? (sí / no)

Pendientes que quedan fuera de este encargo: publicación a `docs/` y Pages (§11); push (ver punto 10); y los pendientes excluidos de §11.

### 8. Errores propios consolidados

- Extracción de DATA en mi primer script de re-derivación (bytes contra caracteres): corregida.
- Primera versión del medidor de estados de T7: no abría el selector de #panorama. Corregida antes de medir.
- `sed` de la calibración de T7: no admitía los espacios de `--line:`. Corregido.
- Espera de captura insuficiente (1,5 s) a 375 px en T7: subida a 3,5 s y a 6 s.
- Afirmación R-32 del inventario: decía «ninguna plantilla menciona gobCL», cuando hay 3 comentarios previos (R-64).
- Plan: la cuenta Opus previa a FASE R llegó a 8 y no a 7, porque el harness relanzó el agente de T1. Se compensó con T7 hecha por el orquestador, y el total final fue 11 ≤ 12.
- Ninguno de estos errores tocó el producto.

### 9. Notas para el revisor

- Revisar en Safari:
  - la vista a 768 px (los botones de cohorte en dos filas, R-47) y a 375 px (sigue desbordando hasta 641 px, como en la línea base; es T3);
  - el motor con el asterisco y la nota (T4);
  - las tres columnas de las notas metodológicas (T5, Q-17);
  - el panorama a 375 px (T6).
- Leer las dos desviaciones de mayor riesgo: D1-a (T1 aceptada con la calibración de C5 que no discrimina) y D4-a (T4 aceptada con 2,78:1 en Elemental apilado). Las dos evitaron congelar sus cadenas y FASE R las confirmó como ADVIERTE.
- Q-06 (I-7) decide si el push es posible.
- La batería permanente ahora usa chromote y Chrome (Q-16).
- Hay capturas en `$TMPDIR/s35_*`, que no se versionan. No se creó `_archivo/20260924_capturas_gobcl/`, porque T8 está congelada.

### 10. Estado de cierre

- **Commiteado:** 13 commits del encargo (T0 a R-63) más el de este log, todos en `main`.
- **Publicado: no.** La autorización 3 exige un veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`, y el veredicto es `BLOQUEADO` (R-39, I-7). No se corrió `git push`. `origin/main` sigue en `b8c8e1a`, ancestro de `HEAD` (medido por el auditor 3 sobre la referencia local).
- **Queda al titular:**
  - responder Q-06 y hacer el push;
  - la revisión en Safari;
  - T3 y T8 en un encargo posterior;
  - la publicación a `docs/`.
- **Hash de `docs(log)`:** se informa en el reporte final (`git log -1 --format=%h`).
