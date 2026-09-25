# Log: cierre de riesgos antes de publicar (s35d) (slep_simce_adecuado)

- Meta: que el motor vuelva a colocar las cifras de la sparkline cuando carga `gobCL-sitio` (Q-48); además, corregir el literal de posición del panorama, el plano de la vista en ventanas bajas (Q-44), la tabla con las cohortes 2027-2029 (Q-46), los textos con «2014» literal (Q-47, Q-45) y el modo de la Bold (Q-40); todo publicado en `main`, sin tocar `docs/`.
- Fecha: 2026-09-25 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: 24a01a8 (commit de T0)
- Encargo: `50_documentacion/activa/encargos/encargo_riesgos_s35d.md`, md5 `22aa9cf34f31fb4db6ac5b156256d13d` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`); sin subagentes ni Workflow (el encargo no los admite); todo en serie.
- Grafo y olas (copiados de §5): T0 va primero. Q48 y PAN (motor) van en serie. Q44, Q46 y TXT (vista) van en serie. Q40 es independiente. FASE R y FASE L corren siempre. Orden de ejecución: T0, Q40, Q48, PAN, Q44, Q46, TXT.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- I-7 se mide en forma absoluta; I-2 con el patrón ampliado (Q-49).

## J. Juicio (lo rellena FASE L)

- Meta y resultado: el motor vuelve a colocar las cifras de la sparkline cuando carga `gobCL-sitio` (Q48: con la fuente retrasada, 0 inversiones, superposiciones y cifras fuera en 2.832 sparklines, antes 23/164 en la muestra); panorama con `PANORAMA_DIMS.rescate` (paso 12); plano de la vista con 320 px o más en 48 de 48 combinaciones (Q44); tabla de la cohorte 2027 entera (Q46); año ancla de las notas desde los datos (TXT); Bold sin modo ejecutable (Q40); todo commiteado; push condicionado a la autorización 4, con las condiciones medidas antes del commit del log (resultado en el reporte final).
- Estado por tarea: FASE 0 completa · T0 completa · Q40 completa (D-Q40-a) · Q48 completa en el intento 2 (D-Q48-a, D-Q48-b) · PAN completa · Q44 completa (D-Q44-a) · Q46 completa con desviación en la calibración (D-Q46-a) · TXT completa · FASE R: 0 BLOQUEA, 0 REPARA, 10 ADVIERTE.
- Commits: 24a01a8 (T0, punto de retorno), d16ef6e (Q40), 5e54b61 (Q48), b0f952d (PAN), 77017cd (Q44), 7765547 (Q46), f3c20cf (TXT), más docs(log) (hash en el reporte final).
- Auditoría (FASE R): sin subagentes; el orquestador re-derivó las 29 afirmaciones con instrumentos distintos (Q48 con la fuente a los 3.000 ms, otra muestra y otro medidor; Q44 con `getComputedStyle` y `matchMedia`; Q46 con el borde de la última columna; TXT desde el parquet; invariantes en Python y por blobs de git): 29 CONFIRMADA, 0 REFUTADA; controles positivos dispararon; R-30 a R-39 ADVIERTE; veredicto APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-10 PASA en el estado final `f3c20cf` (I-2 con el patrón ampliado; I-7 absoluto vacío; I-5 idéntico; C3 PASA).
- Cifras críticas: sparkline retrasada 23/164 (muestra) y 249/1.786 (barrido) → 0/0, dibujos 1 → 2, disposición `identical()` a la carga a tiempo; panorama caja 9 u, paso 12; plano 10/48 → 48/48, umbrales 1.054/972/831; tabla 2027 497/428 → 520/520; vigentes 0 píxeles; motor 601df6d7…, vista 1067908e…, parquet 468099a9…; `docs/` 8deb0459…/267857a2….
- Decisiones autónomas de mayor riesgo: D-Q48-a (`flushSync` para redibujar antes del siguiente frame); D-Q44-a (tres bloques por tramo de ancho, cada uno con su umbral, en vez de uno solo); D-Q46-a (calibración con la cohorte 2027 porque la 2029 no desborda); D-Q48-b (rama para caras declaradas después); D-Q40-a (modo del disco igualado con la autorización 3).
- Desviaciones respecto del encargo: la calibración de Q46 con la 2027 y no con la 2029 (premisa inexacta); Q48 agrega `flushSync` y una rama al patrón de R-50; Q44 en tres bloques; la frase de TXT estaba en la L404 y no en la L377; no se creó CLAUDE.md (regla global frente a `.gitignore` y a un ALCANCE cerrado).
- Dudas abiertas: Q-50 a Q-53 (en «Cierre», punto 7), ninguna condiciona la publicación en `main`.
- Errores propios: 4 (el intento 1 de Q48 medido con espera adicional; un `rm -rf` encadenado sobre una carpeta nueva de `$TMPDIR`, sin efecto; dos instrumentos de FASE R corregidos al primer intento; `timeout` inexistente en macOS). Ninguno tocó el producto.
- Qué debe verificar el revisor por sí mismo: en Safari, con la fuente lenta o la caché vacía, que las cifras de la sparkline se reacomoden al llegar la fuente (Q48); el panorama en 2° Medio; la vista con ventanas bajas y con la cohorte 2027; las notas; las capturas de `_archivo/20260925_capturas_s35d/`.
- No publicado / queda al usuario: `docs/` y Pages sin tocar (publicación excluida); revisión en Safari; Q-50 a Q-53. El push a `main` se informa en el reporte final.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow; re-derivaciones en Chrome (Firefox headless no disponible: R-34).

### FASE 0: log, punto de retorno y premisas

Paso 1: log creado antes de H1. Por eso H1 muestra también la línea del propio log.

**H1.** `git -C "$RAIZ" status --porcelain`
esperado: solo `?? 50_documentacion/activa/encargos/encargo_riesgos_s35d.md`, más el log recién creado
obtenido:
```text
?? 50_documentacion/activa/encargos/encargo_riesgos_s35d.md
?? 50_documentacion/andamios/logs/20260925_riesgos_s35d_log.md
```

**H2.** `git -C "$RAIZ" stash list | wc -l`
esperado: 0
obtenido: 0

**H3.** `git -C "$RAIZ" fetch origin` (fetch_codigo=0), luego `git -C "$RAIZ" rev-parse --short HEAD` y `git -C "$RAIZ" rev-parse --short origin/main` en dos comandos
esperado: e21038e y e21038e
obtenido: e21038e y e21038e

**H4.** `md5 -q docs/index.html docs/trayectorias.html` y el encargo; además `git ls-files -s 10_utils/fuentes/`, `md5 -q 10_utils/fuentes/*.otf`, `md5 -q 10_utils/10_locale.R` y el conteo de I-10
esperado: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47; encargo 22aa9cf34f31fb4db6ac5b156256d13d (mensaje de entrega); Bold 100755 a7407ed6…, Regular 100644 0257bb4b…; 28 archivos de datos
obtenido: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47; 22aa9cf34f31fb4db6ac5b156256d13d; `100755 ccbdbdc6… gobCL_Bold.otf` y `100644 b78fd5c5… gobCL_Regular.otf`, md5 a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc; `10_locale.R` dc900c1b0d2d252c9e5730875be5d632; 28

**T0.** `git add 50_documentacion/activa/encargos/encargo_riesgos_s35d.md` y `git commit -m "docs(sesion 35): encargo de cierre de riesgos antes de publicar"`
esperado: un commit con esa sola ruta
obtenido: `24a01a8 docs(sesion 35): encargo de cierre de riesgos antes de publicar`; `git show --name-only` = el encargo; `git status --porcelain` = solo el log. **Punto de retorno: 24a01a8.**

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R; echo "codigo=$?"` (salida en `$TMPDIR/cal_s35d/h5.txt`)
esperado: 32 pruebas en PASA y codigo=0
obtenido: «Resultado: 32 pruebas, 32 pasan, 0 fallan», codigo_bateria=0

**H6.** `cd "$RAIZ" && Rscript 00_build.R; echo "codigo=$?"` (salida en `$TMPDIR/cal_s35d/h6.txt`)
esperado: codigo=0
obtenido: codigo_build=0; «Fallas criticas: 0 | Advertencias: 7»; «00_build.R: OK en 8 segundos»

Línea base en `$TMPDIR/base_s35d/` (`cp` y `md5 -q` en origen y copia)
esperado: las dos copias con el md5 del original
obtenido: motor_comparacion.html ebf7f46b309837a9ad140e978907b055 (2.917.351 B) y trayectorias_traspasos.html 20f3214de0973c403390a8d7aa84c271 (2.204.520 B), iguales en origen y copia (y a los del cierre de s35c); parquet comunal 468099a9c63bb3c0ddb74e67e2c7c19f

`verificar_contenido_motor.R` apuntaba a `$TMPDIR/base_s35c/`: se apuntó a `$TMPDIR/base_s35d/` (línea 24 y comentario de la línea 12). Calibración (`$TMPDIR/cal_s35d/alterar_json_motor.R`, copia del de s35c, sobre la base)
esperado: «idéntico» sobre el build y sobre la base; «difiere» sobre la copia alterada
obtenido: «fragmento original: 3.5 -> alterado: 3.6»; build codigo_actual=0 «JSON idéntico a la línea base»; base codigo_base=0 «JSON idéntico a la línea base»; copia codigo_alterado=1 «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)»

**H7 (medidores de la sparkline).** Medidor del barrido de S1 de s35c hallado en `$TMPDIR/s35c_s1/` (`barrido.R`, `barrido.js`, `medir_spark.js`, `resumen.R`; no está en `verificar_*.R`). Copia con la fuente tardía de R-46: la del auditor 1 de s35c (`$TMPDIR/s35c_r1/cp_sin_fontface.html`, hecha sobre el motor anterior a R-22, con `r1_r21_swap.R`). Para medir sobre la base de este encargo se rehizo con el mismo método: `$TMPDIR/cal_s35d/quitar_fontface.R` (copia de la base sin las dos reglas `@font-face`, que se guardan aparte) y `$TMPDIR/cal_s35d/h7_tardia.R` (generalización de `r1_r21_swap.R`: abre la copia, monta la muestra reproducible de 300 sparklines del auditor 1 —semilla 20260925, `medidor_r1.js`—, inyecta las `@font-face`, espera `document.fonts.ready`, 1.500 ms y un frame, y mide).

Barrido de S1 sobre la base con la fuente a tiempo: `Rscript $TMPDIR/s35c_s1/barrido.R $TMPDIR/base_s35d/motor_comparacion.html $TMPDIR/cal_s35d/h7/barrido_base.rds libre` y `resumen.R`
esperado: 0 inversiones, 0 superposiciones, 0 cifras fuera
obtenido: «SPARKLINE: cifras 16406 visibles 16406 ocultas 0 | inv auditor 0 estricta 0 inv_todas 0 centro consecutivas 0 | solapes cifra-cifra 0 cifra-traspaso 0 cifra-año 0 cifra-* 0 | fuera izq 0 der 0 arr 0 aba 0»; también «solapes (todas las <text>) 0» (con R-22)

Copia de R-46 rehecha sobre la base (`quitar_fontface.R`: «reglas quitadas: 2»; `h7_tardia.R`)
esperado: con la fuente retrasada, 23 inversiones y 164 superposiciones cifra-cifra
obtenido: «caras gobCL-sitio antes: 0»; con la fuente del sistema, `inv_consec` 0 y `cc` 0; tras inyectar («400:loaded 700:loaded»): «svg_con_falla 106 | inv_consec 23 | inv_contig 21 | cc 164 | ct 0 | ca 0 | cast 0 | fuera 0/0/0/0 | ocultas 0». **H7 da lo esperado.**

Copia retrasada realista (método adicional, para Q48). La copia de R-46 no declara la `@font-face` hasta después del montaje, algo que el producto no hace: la regla va en el CSS del `<head>` desde el inicio y lo que puede llegar tarde son los bytes. Por eso se armó además `$TMPDIR/cal_s35d/copia_retenida.R` (la regla sigue declarada, pero su `src` apunta a `http://fuente.prueba/gobCL_<peso>.otf`) y `$TMPDIR/cal_s35d/retenida.R`, que abre la copia con la intercepción de red de Chrome (`Fetch.enable` y `Fetch.requestPaused`), retiene las dos solicitudes de fuente, espera las 14 tarjetas, monta la misma muestra de 300, libera las caras (`Fetch.fulfillRequest` con los bytes y `Access-Control-Allow-Origin: *`) y mide tras `document.fonts.ready`, un frame y 1.500 ms
esperado: (sin esperado previo; se registra) mientras las caras están en `loading`, 0 fallas; tras cargarlas, fallas en la muestra
obtenido: «caras al montar: 400:loading 700:loading | solicitudes retenidas: 2»; con la fuente de respaldo, tarjetas y muestra en 0; «caras tras liberar: 400:loaded 700:loaded»; tarjetas 0 (las 14 tarjetas por defecto no tienen pares cercanos); **muestra «svg_con_falla 106 | inv_consec 23 | inv_contig 21 | cc 164 | ct 0 | ca 0 | cast 0 | fuera 0/0/0/0 | ocultas 0», lo mismo que el método de R-46**

**Cierre de FASE 0.**
- Estado: completa. H1-H7 dan lo esperado.
- Commits: `24a01a8` docs(sesion 35): encargo de cierre de riesgos antes de publicar (T0, punto de retorno).
- Cambios sustantivos: ninguno sobre el producto. `verificar_contenido_motor.R` (ignorado) apunta a `$TMPDIR/base_s35d/`.
- Alcance: T0 tocó solo el encargo.
- Regresión: H5 y H6 son la regresión de partida.
- Subagentes: ninguno (el encargo no los admite).
- Bugs: ninguno.
- Decisiones autónomas: D0-a (riesgo bajo): además de la copia de R-46, se usa una copia retrasada realista (regla declarada, bytes retenidos), porque el hook que pide Q48 espera la carga de caras ya declaradas; las dos dan 23/164 sobre la base, y Q48 se mide con las dos.
- Errores propios: ninguno en esta fase.
- Dudas: ninguna.

### FASE Q40: la Bold sin modo ejecutable

- Estado: completa.
- Commits: `d16ef6e` chore(repo): gobCL_Bold.otf sin modo ejecutable (Q-40).
- Paso 0: `git ls-files -s 10_utils/fuentes/` = `100755 ccbdbdc6… gobCL_Bold.otf` y `100644 b78fd5c5… gobCL_Regular.otf`; en disco, `-rwxr-xr-x` la Bold; `core.fileMode` = true.
- Cambios sustantivos: `git update-index --chmod=-x 10_utils/fuentes/gobCL_Bold.otf` (autorización 2). El índice quedó en 100644, pero el archivo en disco seguía con permiso de ejecución y `git status --porcelain` mostró `MM 10_utils/fuentes/gobCL_Bold.otf`: el cambio de modo del disco contra el índice habría quedado sin commitear para siempre (y habría impedido el push, que exige el árbol vacío). Se aplicó la autorización 3: `git diff -- 10_utils/fuentes/gobCL_Bold.otf > $TMPDIR/cal_s35d/Q40_intento1.patch` («old mode 100644 / new mode 100755», md5 del parche 8e4a201ff0ecf6e2d210fa3ed2ee5c2b) y `git checkout -- 10_utils/fuentes/gobCL_Bold.otf`, que dejó el disco con el modo del índice.
- Verificación:

`git ls-files -s 10_utils/fuentes/`, `git show --summary HEAD`, I-9 (`md5 -q 10_utils/fuentes/*.otf`), `ls -l` y `git status --porcelain`
esperado: 100644 en las dos; I-9 a7407ed6… y 0257bb4b…; el contenido de la Bold sin cambio; el árbol solo con el log
obtenido: `100644 ccbdbdc6… gobCL_Bold.otf` y `100644 b78fd5c5… gobCL_Regular.otf` (el blob de la Bold no cambia: solo el modo); «mode change 100755 => 100644 10_utils/fuentes/gobCL_Bold.otf», «1 file changed, 0 insertions(+), 0 deletions(-)»; md5 a7407ed6a70160cdb96021f83808a94c antes y después del `checkout`, y 0257bb4b62d5ec557627aa0136f1e1dc; en disco `-rw-r--r--`; `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260925_riesgos_s35d_log.md`

- PRUEBAS: no aplica (sin código; el contenido de las fuentes no cambió, así que el build y sus md5 no cambian).
- Alcance: `git show --summary d16ef6e` = solo el cambio de modo de `10_utils/fuentes/gobCL_Bold.otf`. Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas: D-Q40-a (riesgo bajo): el modo del archivo en disco se igualó al del índice con la autorización 3 (`git checkout -- <ruta>` tras guardar el cambio como parche), en vez de `chmod`, que no está en la lista cerrada. El encargo describe la autorización 3 como «descartar un intento sin commitear»; aquí lo descartado es el cambio de modo en disco que dejó el `cp` de F1 en s35c. El contenido del archivo no cambió.
- Errores propios: ninguno nuevo (el modo 100755 venía del `cp` de s35c, ya registrado).
- Dudas: ninguna.

### FASE Q48: el motor vuelve a colocar las cifras de la sparkline cuando carga la fuente (R-46)

- Estado: completa, en el segundo de 3 intentos.
- Commits: `5e54b61` fix(motor): la sparkline vuelve a colocar sus cifras cuando carga gobCL-sitio (Q-48, R-46).
- Paso 0: `grep -n "document.fonts\|React.useState\|function use[A-Z]"` en el motor (ninguna llamada a `document.fonts`; ningún hook propio); el efecto de `SparklineSubchart` cerraba en la L2500 con las 8 dependencias de §2; la solución de R-50 de la vista, en la L1132-1147 (`Promise.all` de las dos caras, luego `document.fonts.ready`, con la rama de respaldo `document.fonts.ready`).
- Cambios sustantivos (+65/−1 en `33_motor_template.html`, antes de `SparklineSubchart`):
  - `FAMILIA_SITIO = "gobCL-sitio"` y `FUENTES_SITIO`, una sola promesa a nivel de módulo: sin `document.fonts`, lista desde el inicio; si no, `Promise.all([document.fonts.load('400 1em "gobCL-sitio"'), document.fonts.load('700 1em "gobCL-sitio"')])` y luego `document.fonts.ready`; si `load()` falla, la rama de respaldo espera solo `document.fonts.ready`; si `load()` no encuentra ninguna cara (la regla todavía no estaba declarada), espera el primer `loadingdone` que traiga una cara de la familia y luego `document.fonts.ready`. Al resolverse o fallar, marca `listas`;
  - hook `useFuentesListas()`: parte en `FUENTES_SITIO.listas` (false mientras la promesa no se resuelva; true sin `document.fonts` o si ya se resolvió) y pasa a true con `ReactDOM.flushSync` cuando la promesa se resuelve;
  - `SparklineSubchart` llama al hook y agrega `fuentesListas` a las dependencias de su `useEffect`. Las barras no se tocan.
- Intento 1 (sin `flushSync`; parche `$TMPDIR/cal_s35d/q48/q48_intento1.patch`, 79 líneas, md5 9a83417b6ae6fb1f662e3e0eec15d140): al converger daba 0 en todo, pero React repartía los nuevos dibujos en tareas posteriores, así que tras `document.fonts.ready` y un frame todavía no daba 0 (ver abajo). Intento 2: `flushSync` en el cambio de estado; con eso, cada tarjeta se vuelve a dibujar en la misma tarea en que la fuente queda lista.
- Verificación (medidores: `$TMPDIR/cal_s35d/retenida.R`, fuente retenida con la intercepción de red, muestra reproducible de 300 del auditor 1 de s35c o todas las candidatas, contador de dibujos por SVG en copias con `con_contador.R`, cajas a JSON; `h7_tardia.R`, método de R-46; `comparar_cajas.R`, `identical()` en R; copias en `$TMPDIR/cal_s35d/q48/`):

Calibración (caso malo), sin el cambio: base con fuente retenida y con el método de R-46, muestra de 300 (FASE 0, H7) y barrido completo con fuente retenida
esperado: 23 inversiones y 164 superposiciones cifra-cifra en la muestra; más de 0 en el barrido completo
obtenido: muestra, los dos métodos: «inv_consec 23 | cc 164»; barrido completo retenido: «n_svg 2832 | svg_con_falla 1162 | inv_consec 249 | inv_contig 227 | cc 1786 | ct 0 | ca 0 | cast 0 | fuera 0/0/0/0»; cada sparkline dibujada 1 vez

Intento 1, fuente retenida, muestra de 300, medido tras `document.fonts.ready`, un frame y 1.500 ms
esperado: 0 en todo
obtenido: «svg_con_falla 0 | inv_consec 0 | cc 0 | ct 0 | ca 0 | cast 0 | fuera 0/0/0/0»; dibujos «max 2, min 2, suma 628» (314 SVG)

Intento 1, medido solo tras `document.fonts.ready` y un frame (muestra), y barrido completo retenido
esperado: 0 en todo
obtenido: **no**: muestra a los 76 ms «svg_con_falla 101 | inv_consec 22 | cc 155» (solo 33 SVG ya redibujados); barrido completo a los 1.500 ms «svg_con_falla 1123 | inv_consec 231 | cc 1725» (120 redibujados), que llega a 0 recién a los 23.215 ms con todas dibujadas 2 veces. **Bug 1**: React repartía los nuevos dibujos en tareas posteriores al frame.

Intento 2 (`flushSync`), fuente retenida, medido tras `document.fonts.ready` y un frame
esperado: 0 inversiones, 0 superposiciones de las cuatro clases y 0 cifras fuera, en la muestra y en el barrido completo
obtenido: muestra: medición a los 333 ms de liberar las caras, «svg_con_falla 0 | inv_consec 0 | inv_contig 0 | cc 0 | ct 0 | ca 0 | cast 0 | fuera 0/0/0/0 | ocultas 0», tarjetas 0; **barrido completo**: medición a los 15.681 ms (el frame espera los nuevos dibujos), «n_svg 2832 | svg_con_falla 0 | inv_consec 0 | inv_contig 0 | cc 0 | ct 0 | ca 0 | cast 0 | fuera 0/0/0/0 | ocultas 0», tarjetas 0

Intento 2, método de R-46 (la regla declarada después del montaje), muestra de 300, tras `document.fonts.ready` y un frame
esperado: 0 en todo
obtenido: «svg_con_falla 0 | inv_consec 0 | cc 0 | ct 0 | ca 0 | cast 0 | fuera 0/0/0/0 | ocultas 0»

Disposición final idéntica a la de la carga con la fuente a tiempo (`comparar_cajas.R`: texto, x, y y `display` de cada cifra, con `identical()`)
esperado: `identical` TRUE, mismas ocultas; calibración: la base retenida contra la base a tiempo, FALSE
obtenido: barrido completo, intento 2 retenido contra a tiempo: «SVG 2846 2846 | cifras 16489 16489 | identical: TRUE | SVG distintos: 0 | ocultas 0 0»; muestra, intento 1: «identical: TRUE»; a tiempo nuevo contra a tiempo base: «identical: TRUE» (el cambio no mueve nada con la fuente a tiempo); calibración base retenida contra base a tiempo: «identical: FALSE | SVG distintos: 242»

Dibujos por sparkline (contador en copias de `$TMPDIR`, no en la plantilla)
esperado: como máximo una vez más que antes
obtenido: antes (base), 1 en todas, retenida y a tiempo; después, retenida «max 2, min 2» (muestra y barrido completo); a tiempo, muestra «max 2, min 1, suma 328» de 314 (las 14 tarjetas de la página, montadas antes de que se resuelva la promesa, 2; la muestra, 1) y barrido completo «suma 2860» de 2.846

Carga normal: barrido de S1 (`barrido.R … libre`) sobre el motor nuevo
esperado: 0 en todo
obtenido: «SPARKLINE: cifras 16406 visibles 16406 ocultas 0 | inv auditor 0 estricta 0 inv_todas 0 centro consecutivas 0 | solapes cifra-cifra 0 cifra-traspaso 0 cifra-año 0 cifra-* 0 | fuera izq 0 der 0 arr 0 aba 0»; «solapes (todas las <text>) 0»

Consola (`$TMPDIR/cal_s35d/consola.R` con `verificar_navegador.R`, 1280 y 375 px; y `retenida.R` con registro de consola)
esperado: 0 errores, 0 excepciones, 0 red; la calibración con un `console.error` plantado da 1
obtenido: «1280 px | errores de consola 0 | excepciones 0 | red 0», «375 px | … 0 | 0 | 0»; calibración «1»; fuente retenida y a tiempo: «consola (error, assert, warning) y excepciones: 0»

PRUEBAS (`00_build.R`, batería, I-5) e I-8
esperado: codigo_build=0; 32/32; «JSON idéntico a la línea base»; I-8 vacío
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor e2793e743b166ccfce0cfffcbe1d9034, vista 20f3214de0973c403390a8d7aa84c271 (sin cambio), parquet 468099a9c63bb3c0ddb74e67e2c7c19f; «Resultado: 32 pruebas, 32 pasan, 0 fallan»; «JSON idéntico a la línea base»; I-8 vacío

- Alcance: `git status --porcelain` antes del commit = ` M 30_procesamiento/33_motor_template.html` y el log; `git show --name-only 5e54b61` = la plantilla del motor. Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: 1 (el intento 1 no redibujaba antes del frame), resuelto en el intento 2.
- Decisiones autónomas:
  - D-Q48-a (riesgo medio): `ReactDOM.flushSync` en el cambio de estado del hook, para que el nuevo dibujo ocurra antes del siguiente frame. Con muchas tarjetas, la tarea en que carga la fuente se alarga lo que tarden los nuevos dibujos (15,7 s con 2.846 SVG montados a la vez en el barrido; en la página, 14 tarjetas por omisión).
  - D-Q48-b (riesgo bajo): la promesa también espera el primer `loadingdone` de la familia cuando `load()` no encuentra caras declaradas; así la copia de R-46 (regla declarada después del montaje) también queda en 0. En el producto la regla está en el `<head>` desde el inicio y esa rama no se usa.
  - D-Q48-c (riesgo bajo): el hook parte en `true` si la promesa ya se resolvió cuando la tarjeta se monta, para no dibujar dos veces sin necesidad.
- Errores propios: el criterio pide medir «después de `document.fonts.ready` y un frame» y el intento 1 lo medí primero con 1.500 ms de espera adicional; el barrido completo mostró el defecto.
- Dudas: ninguna.

### FASE PAN: el literal de posición de las cifras rescatadas del panorama

- Estado: completa.
- Commits: `b0f952d` fix(motor): cifras rescatadas del panorama con paso medido (R-22).
- Paso 0: `grep -n` en el motor: `PANORAMA_DIMS` (L3392, `M.bottom` 74) y el literal `ih + 44 + k * 12` en `dibujarPanoramaEnGrupo` (L3529 tras Q48); `FS_SVG.panorama.valorFuera` = 9,5. `dibujarPanoramaEnGrupo` dibuja la pantalla y el SVG exportado (`construirSvgPanorama`), así que un solo cambio cubre los dos. El panorama siempre dibuja las tres franjas (no tiene conmutador), así que Elemental e Insuficiente están siempre visibles.
- Medición del paso (`$TMPDIR/cal_s35d/alto_rescate_pan.R`: `<text>` «A 99,9%» con `FONT_SVG` y `FS_SVG.panorama.valorFuera` leídos de la página, peso 700, `getBBox` y `getBoundingClientRect` en un SVG sin `viewBox`, a 1280 px, caras `gobCL-sitio` 400 y 700 cargadas)
esperado: el alto de la caja en unidades; P = alto + 1, y nunca menos de 12
obtenido: «tam 9.5 | font_svg "gobCL-sitio, system-ui, sans-serif" | caras "400,700" | gob bbox_h 9, rect_h 9 | sistema bbox_h 11 | gob_E bbox_h 9»; 9 + 1 = 10 < 12, así que **P = 12**
- Cambios sustantivos (+8/−1): `PANORAMA_DIMS.rescate = { linea: 44, paso: 12 }` con un comentario que explica la medición y la regla; el renglón `k` pasa a `ih + PANORAMA_DIMS.rescate.linea + k * PANORAMA_DIMS.rescate.paso`. Con el mismo paso, el dibujo no cambia.
- Verificación:

Contactos entre renglones rescatados en pantalla y en el SVG exportado (`$TMPDIR/cal_s35d/pan_contactos.R`: `#panorama` a 1280 px, territorio por defecto, los dos niveles; el exportado se toma reemplazando en la pestaña `descargarBlob` y pulsando «Exportar SVG» del panorama; cajas en unidades del `viewBox`; contacto = cruce en x con separación vertical menor que 0,5 u)
esperado: 0 contactos en pantalla y en el exportado
obtenido: 4° Básico: pantalla «svg 2 | rescatadas 0 | contactos 0» y exportado «rescatadas 0 | contactos 0» (26.260 caracteres); 2° Medio: pantalla «svg 2 | rescatadas 11 | contactos 0 | cruces 0», exportado «svg 1 | rescatadas 11 | contactos 0 | cruces 0» (25.923 caracteres)

Calibración del medidor de contactos (`pan_contactos.R … plantar`: se clona la primera cifra rescatada de cada SVG en la misma posición)
esperado: más de 0 contactos
obtenido: 2° Medio, pantalla «rescatadas 13 | contactos 2 | cruces 2» («A 5,7% / A 5,7% sep=-10.11»); exportado «rescatadas 12 | contactos 1»

Segundo renglón dentro del margen inferior de 74. En el territorio por defecto ninguna barra tiene dos renglones (`$TMPDIR/cal_s35d/pan_renglones.R`: «barras_con_rescate 2 y 9 | con_dos_renglones 0 | fondo_max 300.76» con `viewBox` de 328 de alto). Se forzó el caso en la pestaña de prueba, sin tocar el repo (`$TMPDIR/cal_s35d/pan_forzado.R`: serie del panorama con A 3,1 %, E 4,2 % e I 92,7 % en cada año, así que A y E se rescatan)
esperado: 0 contactos entre los dos renglones y fondo de la caja del segundo renglón bajo 328 (el borde del margen inferior)
obtenido: por panel «rescatadas 18 | barras 9 | con_dos 9 | contactos 0 | separacion_min 1.89 | fondo_max 312.76 | alto_viewbox 328»

El dibujo no cambia (`pan_renglones.R` sobre el motor anterior a PAN y el nuevo, 2° Medio, 1280 px, y `pixeles_distintos()`)
esperado: 0 píxeles distintos (mismo paso)
obtenido: «píxeles distintos antes/después de PAN (2° Medio, 1280): 0»

PRUEBAS e I-8
esperado: codigo_build=0; 32/32; «JSON idéntico a la línea base»; I-8 vacío
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor 601df6d7bfdc8bb60f57c5f9fba3db54, vista 20f3214de0973c403390a8d7aa84c271, parquet 468099a9c63bb3c0ddb74e67e2c7c19f; «Resultado: 32 pruebas, 32 pasan, 0 fallan»; «JSON idéntico a la línea base»; I-8 vacío

- Alcance: `git show --stat b0f952d` = la plantilla del motor (+8/−1). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas: D-PAN-a (riesgo bajo): el segundo renglón se verificó con un caso forzado en la pestaña, porque el territorio por defecto no tiene barras con dos renglones rescatados.
- Errores propios: ninguno.
- Dudas: ninguna.

### FASE Q44: el plano de la vista no colapsa en ventanas bajas

- Estado: completa.
- Commits: `77017cd` fix(trayectorias): el plano no colapsa en ventanas bajas (Q-44).
- Paso 0: la plantilla de la vista: `.app{height:calc(100dvh - var(--tabs-h));min-height:600px;…}` (L53) y el bloque `@media (min-width:680px) and (max-width:822px)` de V1 (L277-282). Base de la tarea: `$TMPDIR/cal_s35d/q44/vista_antes.html` (md5 20f3214de0973c403390a8d7aa84c271) y la plantilla en `vista_template_antes.html`.
- Medidor: `$TMPDIR/cal_s35d/plano.R` (carga nueva por ancho y alto de ventana, barras ocultas; alto y ancho de `svg.chart` con `getBoundingClientRect` y `scrollWidth`, con la cohorte inicial y tras pulsar la cohorte 2027 en `#c-coh`).
- Verificación:

Estado previo, 48 combinaciones (anchos 680, 823, 860, 900, 1023, 1024, 1280 y 1920 px; altos 650, 768 y 900 px; cohorte inicial y 2027) (`$TMPDIR/cal_s35d/q44_antes.csv`)
esperado: calibración: menos de 30 px a 1024 × 650
obtenido: 1024 × 650: 0,0 (inicial) y 0,0 (2027). En total «plano >= 320: 10» de 48 (los de 680 px, por el bloque de V1, y 1280 y 1920 a 900 de alto); por ejemplo 823 × 900: 183,8 y 166,3; 1024 × 768: 116,8 y 116,8; 1280 × 650: 177,9 y 140,4; 1920 × 768: 317,5 y 294,9; `scrollWidth` igual al ancho en las 48

Calibración de `N` (el alto de ventana a partir del cual el plano recibe 320 px o más sin la regla): barrido de altos de 780 a 1.100 px cada 20 px, en el ancho más angosto de cada tramo (823, 1024 y 1280 px), con las cohortes inicial, 2027, 2028 y 2029 (`$TMPDIR/cal_s35d/q44_umbral.csv`, 204 combinaciones)
esperado: (sin esperado previo; se registra) el alto del plano en función del alto de ventana
obtenido: el alto del plano crece 1:1 con el de la ventana (p. ej. 823 px y cohorte 2027: 46,3 a 780, 166,3 a 900, 366,3 a 1.100); la cohorte 2027 es la peor en los tres anchos (a 1024 px, igual en las cuatro). Umbral exacto: 823 px, 166,3 + (h − 900) ≥ 320 → **1.054**; 1024 px, 248,8 + (h − 900) → **972**; 1280 px, 389,4 + (h − 900) → **831**. De ahí `N` = 1.053, 971 y 830

- Cambios sustantivos (+29/−2 en `36_trayectorias_template.html`): la propiedad `--alto-plano-fijo:360px` en `:root` (con comentario), usada por el bloque de A3 (bajo 680 px), el de V1 (680-822 px) y los nuevos, en vez del literal 360px; y tres bloques al final de la hoja, con comentario, cada uno con `.app:not(.pres){height:auto}` y `.app:not(.pres) svg.chart{flex:none;height:var(--alto-plano-fijo)}`: `@media (min-width:823px) and (max-width:1023px) and (max-height:1053px)`, `@media (min-width:1024px) and (max-width:1279px) and (max-height:971px)` y `@media (min-width:1280px) and (max-height:830px)`. De las reglas del bloque de V1 se aplican las dos del alto; la columna única y el ancho de la tarjeta no, porque desde 823 px tabla y plano caben lado a lado.

Estado posterior, las mismas 48 combinaciones (`$TMPDIR/cal_s35d/q44_despues.csv`)
esperado: plano de 320 px o más en las 48; `scrollWidth` igual al viewport en las 48
obtenido: «combinaciones: 48 | plano >= 320: 48 | scrollWidth = ancho: 48»: 360,0 en todas salvo 1280 × 900 (426,9 y 389,4) y 1920 × 900 (449,5 y 426,9), que no entran en la regla

Bordes de cada bloque (`plano.R` a `N` y `N + 1`, cohortes inicial y 2027)
esperado: en `N`, 360 (regla); en `N + 1`, 320 o más sin regla
obtenido: 823 × 1.053: 360,0 y 360,0; 823 × 1.054: 337,8 y 320,3; 1024 × 971: 360,0 y 360,0; 1024 × 972: 320,8 y 320,8; 1280 × 830: 360,0 y 360,0; 1280 × 831: 357,9 y 320,4

0 píxeles distintos con 1.080 px de alto a 1024, 1280 y 1920 frente a la base de la tarea (`$TMPDIR/cal_s35d/capturas_vista.R` y `comparar_px.R`, página completa)
esperado: 0 en los tres anchos; determinismo de la base 0; calibración con `--line-motor` #E7DFC9 → #E7DFC8 en una copia, más de 0
obtenido: base contra base (segunda carga) 0/0/0; base contra copia alterada 15.905/19.984/25.551; base contra el estado nuevo 0/0/0. Además, con 900 px de alto a 1280 y 1920 (fuera de la regla): 0 y 0

PRUEBAS (batería)
esperado: 32/32, C3 PASA
obtenido: «Resultado: 32 pruebas, 32 pasan, 0 fallan», codigo_bateria=0; C3 PASA (12724 filas; idénticas TRUE)

- Alcance: `git show --stat 77017cd` = la plantilla de la vista (+29/−2). Dentro del ALCANCE. Capturas de trabajo en `$TMPDIR/cal_s35d/q44/`.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas: D-Q44-a (riesgo medio): tres bloques por tramo de ancho, cada uno con su `N`, en vez de un solo `(min-width:823px) and (max-height:N)`. Con un solo bloque, `N` sería 1.053 (el umbral de 823 px), y a 1280 px de ancho la regla fijaría el plano en 360 px con ventanas de hasta 1.053 de alto, donde hoy recibe 350 a 580 px. Tres bloques dejan intacto todo lo que ya recibía 320 px. D-Q44-b (riesgo bajo): el umbral se calibró con las cohortes 2028 y 2029 además de la inicial y la 2027.
- Errores propios: ninguno.
- Dudas: ninguna.

### FASE Q46: la tabla muestra «Establecimientos» con las cohortes futuras

- Estado: completa, con una desviación declarada en la calibración (D-Q46-a).
- Commits: `7765547` fix(trayectorias): la tabla de las cohortes futuras cabe sin desplazarse (Q-46).
- Paso 0: `td.nm{…white-space:nowrap}` (L146) y `anchoTarjeta()` (L833-841), que calcula `24 + 33 + nombre más largo + 16 + última columna + 24` y lo acota a [268, 430] con literales. Las media queries vigentes son `max-width:679px` (A3, ya con `td.nm{white-space:normal}`), la de 680-822 px (V1) y las de ventanas bajas de Q44; en 1024 y 1280 px con ventana de 900 px de alto no rige ninguna. Base de la tarea: `$TMPDIR/cal_s35d/q46/vista_antes.html` (md5 0fbffc9a55ec1367816a33fb675b6209, la vista tras Q44).
- Medidor: `$TMPDIR/cal_s35d/tabla.R` (carga nueva por ancho, ventana de 900 px de alto; pulsa la cohorte; `scrollWidth` y `clientWidth` de `.tw`, `--cardw`, `scrollWidth` de la página y el ancho que pediría `anchoTarjeta()` sin tope, con su misma fórmula).
- Verificación:

Calibración: estado previo, una carga nueva por cohorte futura, a 680, 822, 1024 y 1280 px
esperado: `scrollWidth` mayor que `clientWidth` con la cohorte 2029 a 680 px (encargo)
obtenido: **2029: 327 = 327 en los cuatro anchos (no desborda)**; 2028: 321 = 321; **2027: 497 > 428 en los cuatro anchos**, con `--cardw` 430px y un ancho sin tope de 522 px. En una secuencia de clics 2027 → 2028 → 2029 → 2018 → 2026 dentro de la misma carga, lo mismo: solo desborda la 2027. El medidor dispara con la 2027 (caso malo); la premisa de §2 («con las cohortes 2027-2029 la tabla se desplaza») solo se cumple para la 2027 (D-Q46-a).

- Cambios sustantivos (+8/−2 en `36_trayectorias_template.html`): `var ANCHO_TARJETA_MIN=268,ANCHO_TARJETA_MAX=540;` con un comentario (el tope era 430; la cohorte 2027 pide 522 medidos; el tope nuevo es ese ancho más aire; las vigentes piden menos de 340) y `anchoTarjeta()` las usa en vez de los literales. La vía de las media queries vigentes no alcanza: no hay ninguna en 1024 y 1280 px con ventanas altas, y dos de los cuatro anchos del criterio caen ahí; por eso se sube el tope, como prevé el encargo. `td.nm` no se toca: con el tope nuevo, ningún nombre necesita partirse en los anchos del criterio.

Estado posterior, una carga nueva por cohorte futura
esperado: `scrollWidth` de `.tw` igual a su `clientWidth` con las cohortes 2027, 2028 y 2029 a 680, 822, 1024 y 1280 px
obtenido: 2027: 520 = 520 en los cuatro (`--cardw` 522px); 2028: 321 = 321; 2029: 327 = 327; `scrollWidth` de la página igual al ancho en los 12 casos

0 píxeles distintos con las cohortes vigentes a 1024, 1280 y 1920 px frente a la base de la tarea (`capturas_vista.R` con la cohorte pulsada y `comparar_px.R`, ventana de 900 px de alto, página completa)
esperado: 0 en cada cohorte vigente (2018, 2020, 2021, 2024, 2025 y 2026) y ancho; determinismo de la base 0; calibración con `--line-motor` #E7DFC9 → #E7DFC8 en una copia, más de 0
obtenido: 0 en las 18 comparaciones (6 cohortes × 3 anchos); base contra base 0/0/0; base contra copia alterada 15.759/18.987/24.466

PRUEBAS (batería)
esperado: 32/32
obtenido: «Resultado: 32 pruebas, 32 pasan, 0 fallan», codigo_bateria=0

Consecuencia medida (información): con la cohorte 2027 y la tarjeta más ancha, el plano se angosta entre 823 y 1023 px, donde tabla y plano van lado a lado (`plano.R`, 900 px de alto): 823 px, de 271 a 179 px de ancho; 900 px, de 348 a 256; 1023 px, de 471 a 379; su alto sigue en 360. Bajo 823 px la vista va en una columna y no cambia.

- Alcance: `git show --stat 7765547` = la plantilla de la vista (+8/−2). Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas: D-Q46-a (riesgo medio): la calibración pedida (2029 a 680 px) no dispara porque la 2029 no desborda; se calibró con la 2027, la única cohorte que desborda, y se verificaron las tres. Es un resultado no enumerado en el encargo y no congelé la tarea: el medidor se probó con un caso malo real y la meta de Q46 no cambia. Queda como duda Q-50. D-Q46-b (riesgo bajo): el tope nuevo es 540 (522 medidos más aire) y no exactamente 522, para que un navegador que dibuje los nombres un poco más anchos no vuelva a desbordar.
- Errores propios: ninguno.
- Dudas:
  - Q-50. La calibración de Q46 se hizo con la cohorte 2027 y no con la 2029 que pedía el encargo, porque la 2029 no desborda (327 = 327). ¿Se acepta? (sí / no)
  - Q-51. Con la cohorte 2027, entre 823 y 1023 px el plano queda de 179 a 379 px de ancho (antes, 271 a 471), porque la tabla ahora se muestra entera. ¿Se pasa a una columna en ese tramo cuando la tarjeta es ancha, en un encargo posterior? (sí / no)

### FASE TXT: textos con año literal y comentario desactualizado (Q-47, Q-45)

- Estado: completa.
- Commits: `f3c20cf` fix(trayectorias): el año del ancla sale de los datos en las notas (Q-47, Q-45).
- Paso 0: la frase está en la L404 de la plantilla (el encargo citaba la L377, anterior a V1 y Q44): «los __NOTA_N_REFERENTE__ establecimientos que en 2014 eran municipales y que no figuran en el catálogo de Servicios Locales»; `cifras_notas()` en `36_funciones_trayectorias.R` (L675) y `filas_referente()`, que fija el ancla con `min(base$anio)`; el comentario de `36_generar_trayectorias.R` L120-121; la prueba D11 de la batería (L398-427). Conteo de marcadores en la plantilla (`grep -o "__NOTA_[A-Z_]*__" | sort | uniq -c`): `N_VIGENTES`, `N_REFERENTE`, `N_REF_DIRECTORIO`, `COH_PRIMERA` y `COH_ULTIMA` aparecen 2 veces cada uno, todos en las notas.
- Cambios sustantivos (+22/−9 en 4 archivos):
  - plantilla: «que en __NOTA_ANIO_ANCLA__ eran municipales»;
  - `cifras_notas()`: `anio_ancla <- min(base$anio)`, con comentario (el mismo año con que `filas_referente()` fija el conjunto), y el elemento `ANIO_ANCLA = as.character(anio_ancla)`;
  - `36_generar_trayectorias.R`: el comentario dice dónde se repiten hoy las cifras (dentro de las notas, esos cinco marcadores dos veces cada uno) y que desde s35c el tooltip del referente arma su texto con DATA y ya no usa marcadores;
  - batería, D11: `ancla_txt <- sprintf("que en %d eran municipales", min(as.integer(unlist(DATA$anios))))`, `ancla_ok` entra en la condición y en el detalle, y la descripción agrega «su año ancla». La batería sigue con 32 pruebas.
- Verificación:

`grep -c 'en 2014 eran' 30_procesamiento/36_trayectorias_template.html`
esperado: 0
obtenido: 0

HTML generado (`36_generar_trayectorias.R`, luego `grep -o "establecimientos que en [0-9]* eran municipales"` y `grep -c "__NOTA_"`)
esperado: sigue diciendo «en 2014 eran municipales»; 0 marcadores sin reemplazar
obtenido: «establecimientos que en 2014 eran municipales»; 0; la vista queda con el mismo md5 que tras Q46 (1067908ec09ce95dbee692b9696da7fa): el texto no cambia

Batería
esperado: 32/32, D11 PASA con el año ancla
obtenido: «D11 PASA Las notas declaran el referente, su año ancla, la nube, las filas excluidas y el ejemplo que traen los datos (referente 1.299, año ancla «que en 2014 eran municipales»: TRUE, …, sin marcadores: TRUE)»; «Resultado: 32 pruebas, 32 pasan, 0 fallan»

Calibración de D11 (copia del repo sin `.git` en `$TMPDIR/cal_s35d/txt/repo/`, con la vista de `40_salidas` alterada para dejar «que en __NOTA_ANIO_ANCLA__ eran municipales», y la batería de la copia)
esperado: D11 FALLA con el marcador sin reemplazar
obtenido: «D11 FALLA … año ancla «que en 2014 eran municipales»: FALSE, … sin marcadores: FALSE»; «Resultado: 32 pruebas, 31 pasan, 1 fallan», codigo_bateria_calib=1

PRUEBAS
esperado: codigo_build=0; 32/32; «JSON idéntico a la línea base»
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor 601df6d7bfdc8bb60f57c5f9fba3db54, vista 1067908ec09ce95dbee692b9696da7fa, parquet 468099a9c63bb3c0ddb74e67e2c7c19f; «Resultado: 32 pruebas, 32 pasan, 0 fallan»; «JSON idéntico a la línea base»

- Alcance: `git show --stat f3c20cf` = plantilla, funciones, generador y batería de la vista. Dentro del ALCANCE.
- Subagentes: ninguno.
- Bugs: ninguno.
- Decisiones autónomas: D-TXT-a (riesgo bajo): el año ancla se calcula con `min(base$anio)`, la misma expresión de `filas_referente()`, y no con `DATA$anios`, para que la nota y el conjunto no puedan divergir; D11 lo re-deriva por otra vía (`min(DATA$anios)`).
- Errores propios: el comando que armó la copia de calibración encadenó `rm -rf` sobre `$TMPDIR/cal_s35d/txt/repo`, una carpeta nueva que todavía no existía (no borró nada); la autorización 5 cubre borrar en `$TMPDIR`, pero la regla global del titular pide aprobación individual para todo `rm -rf`. No se repite.
- Dudas: ninguna.

### FASE R: auditoría y reparación

**R.1 Inventario de afirmaciones auditables** (derivado de las secciones anteriores del log; anexado antes de auditar). Estado auditado: `HEAD` = `f3c20cf`; punto de retorno `24a01a8`. Sin subagentes: el orquestador re-deriva cada afirmación con un comando distinto del que la produjo.

| id | afirmación (fuente en el log) |
|---|---|
| R-01 | T0 (`24a01a8`) agrega solo el encargo (md5 22aa9cf3…), con padre `e21038e`; antes, `HEAD` y `origin/main` en `e21038e` (H1-H4, T0) |
| R-02 | H7: sobre la base, la sparkline da 0 inversiones, 0 superposiciones y 0 cifras fuera con la fuente a tiempo, y 23 inversiones y 164 superposiciones cifra-cifra con la fuente tardía (método de R-46 y copia retenida) |
| R-03 | Q40: la Bold queda con modo 100644 en el índice y en disco, con el mismo blob y md5; el árbol queda limpio |
| R-04 | Q48: con la fuente retrasada, tras `document.fonts.ready` y un frame, 0 inversiones, 0 superposiciones de las cuatro clases y 0 cifras fuera, en la muestra y en el barrido completo; también con el método de R-46 |
| R-05 | Q48: la disposición final con la fuente retrasada es idéntica a la de la carga a tiempo, y la de la carga a tiempo no cambia frente a la base |
| R-06 | Q48: cada sparkline se dibuja como máximo una vez más que antes |
| R-07 | Q48: la carga normal sigue en 0 en el barrido completo; 0 errores de consola; I-5 |
| R-08 | Q48: calibración: sin el cambio, la copia retrasada da 23/164 en la muestra (y 249/1.786 en el barrido completo) |
| R-09 | Q48: una sola promesa a nivel de módulo con las dos caras y `document.fonts.ready`, rama de respaldo, lista sin `document.fonts`; hook `useFuentesListas()` en las dependencias del efecto de `SparklineSubchart`; las barras no se tocan |
| R-10 | PAN: la caja de «A 99,9%» en Bold 700 a 9,5 px mide 9 u, así que el paso es 12; el literal `ih + 44 + k * 12` desaparece en favor de `PANORAMA_DIMS.rescate` |
| R-11 | PAN: 0 contactos entre renglones rescatados en pantalla y en el SVG exportado, a 1280 px, en el territorio por defecto; el segundo renglón queda dentro del margen inferior; el dibujo no cambia |
| R-12 | Q44: el plano mide 320 px o más y `scrollWidth` es igual al viewport en las 48 combinaciones; antes, 0 px a 1024 × 650 |
| R-13 | Q44: los umbrales de alto son 1.054, 972 y 831 px (a 823, 1024 y 1280 px de ancho), y los bloques cubren hasta un píxel bajo cada uno |
| R-14 | Q44: con 1.080 px de alto, 0 píxeles distintos a 1024, 1280 y 1920 px frente a la base de la tarea |
| R-15 | Q46: con la cohorte 2027, `.tw` pasa de 497/428 a 520/520 en 680, 822, 1024 y 1280 px; la 2028 y la 2029 no desbordan antes ni después |
| R-16 | Q46: con las cohortes vigentes, 0 píxeles distintos a 1024, 1280 y 1920 px frente a la base de la tarea |
| R-17 | TXT: la plantilla ya no trae «en 2014 eran»; el HTML generado dice «en 2014 eran municipales» y no deja marcadores; D11 pasa y falla con el marcador sin reemplazar; el comentario del generador dice dónde se repiten hoy las cifras |
| R-18 | I-1 `docs/` intacto |
| R-19 | I-2 sin red (patrón ampliado) |
| R-20 | I-3 vendorizados `.js` sin cambio |
| R-21 | I-4 guarda de locale |
| R-22 | I-5 JSON del motor idéntico a la línea base |
| R-23 | I-6 (C3) filas vigentes y del referente sin cambio |
| R-24 | I-7 absoluto vacío |
| R-25 | I-8 sin literales de color nuevos |
| R-26 | I-9 fuentes sin cambio de contenido |
| R-27 | I-10 28 archivos de datos versionados |
| R-28 | Alcance global: `git diff --name-only 24a01a8..HEAD` dentro de la unión de los ALCANCE, más el log; cada commit dentro de su tarea |
| R-29 | Regresión: build 0, batería 32/32, I-5 idéntico en el estado final |

**R.2 Re-derivación independiente** (orquestador, sin subagentes; scripts en `$TMPDIR/cal_s35d/r/`, distintos de los que produjeron cada resultado)

R-01 (`git cat-file -p 24a01a8`, `git diff-tree --name-status`, `git cat-file blob … | md5 -q`, `git reflog show origin/main`)
esperado: 1 ruta agregada, blob con md5 22aa9cf3…, padre e21038e; `origin/main` en e21038e por el push de s35c
obtenido: `A 50_documentacion/activa/encargos/encargo_riesgos_s35d.md`; 22aa9cf34f31fb4db6ac5b156256d13d; `parent e21038e694fe…`; reflog «e21038e refs/remotes/origin/main@{0}: update by push» → CONFIRMADA

R-02, R-04, R-05, R-06 y R-08 (Q48 y H7) con una copia retrasada distinta de la de H7: la fuente se suelta 3.000 ms después de pedirse (no al terminar el montaje); medidor propio `rd_medidor.js` (cajas con `getBBox` en el espacio del grupo y la traslación del grupo, en vez de `getBoundingClientRect`); otra muestra (una de cada 7 candidatas: 405 de 2.832); conteo de dibujos con un `MutationObserver` que cuenta los vaciados del SVG (dibujos = vaciados + 1), en vez del contador en la función; `rd_q48.R`
esperado: final, tras `document.fonts.ready` y un frame: 0 en todo, 2 dibujos por sparkline; disposición igual a la carga a tiempo; base: fallas (calibración)
obtenido: final retenido: antes de la fuente «inversiones 0 | cc 0 …»; «la fuente se pidió hace 2.42 s; se suelta a los 3000 ms»; después «svg 405 | cifras 2448 | ocultas 0 | inversiones 0 | cc 0 | ct 0 | ca 0 | cs 0 | fuera 0 | svg_con_falla 0»; dibujos «max 2, min 2». Final a tiempo: 0 en todo; dibujos «max 1, min 1». Base retenida (calibración): «inversiones 47 | cc 254 | svg_con_falla 168»; dibujos 1. `comparar_cajas.R`: final retenido contra final a tiempo «identical: TRUE | SVG distintos: 0»; base retenida contra final a tiempo «identical: FALSE | SVG distintos: 337» → CONFIRMADAS

R-03 (`git ls-tree HEAD 10_utils/fuentes/`, `stat -f "%Sp"`, `git diff HEAD --summary`, `git cat-file blob HEAD:… | md5 -q`, `git show --summary d16ef6e`)
esperado: 100644 en índice y disco, blob sin cambio, sin diferencias
obtenido: `100644 blob ccbdbdc6… gobCL_Bold.otf`, `100644 blob b78fd5c5… gobCL_Regular.otf`; `-rw-r--r--` las dos en disco; 0 líneas de `--summary`; a7407ed6a70160cdb96021f83808a94c; «mode change 100755 => 100644» → CONFIRMADA

R-07 (carga normal): cubierto arriba («final a tiempo», 405 SVG en 0) y por la consola de FASE Q48 con calibración; I-5 en R.3 → CONFIRMADA

R-09 (estructura del código; `grep` en la plantilla)
esperado: una promesa de módulo, las dos cargas, la rama de respaldo, la rama sin `document.fonts`, el hook en las dependencias; 0 cambios en las barras
obtenido: `const FUENTES_SITIO = ` 1; `function useFuentesListas` 1; L2343 `if (!fs) return { listas: true, …`; L2358-2360 las dos `fs.load` y `() => fs.ready`; L2392 `const fuentesListas = useFuentesListas();`; L2564 `…, prueba, fuentesListas]`; `fuentesListas` en `RecentBarsSubchart`: 0; líneas `RecentBarsSubchart` en el diff: 0 → CONFIRMADA

R-10 y R-11 (PAN) con otro caso forzado (A 92,0 %, E 4,1 %, I 3,9 %: se rescatan E e I) y cajas con `getBBox` agrupadas por panel, en pantalla y en el SVG exportado; y `grep` del literal (`rd_pan.R`)
esperado: 0 contactos; paso 12; el literal ya no está
obtenido: literal `ih + 44 + k * 12`: 0; `PANORAMA_DIMS.rescate`: 1; `rescate: { linea: 44, paso: 12 }`. Pantalla, por panel: «rescatadas 18 | contactos 0 | sep_min 1.89 | paso_entre_renglones [12]»; exportado: «rescatadas 36 | contactos 0 | sep_min 3 | paso_entre_renglones [12] | alto_caja_max 9 | paneles 2» → CONFIRMADAS. (El primer intento del instrumento comparaba cifras de los dos paneles del exportado, con las mismas coordenadas locales, y dio 18 falsos contactos; se corrigió comparando dentro de cada panel. Error del instrumento, no del producto.)

R-12 y R-13 (Q44) con otra medida (alto de `getComputedStyle` y `clientHeight`, no `getBoundingClientRect`), el bloque que rige según `matchMedia`, y tamaños distintos de los del criterio (`rd_q44.R`)
esperado: 320 o más en todos; en `N + 1`, sin bloque y 320 o más; el bloque que corresponde a cada tramo
obtenido: 700×640 «360px | bloque 1»; 950×700 «360px | bloque 2»; 1100×720 «bloque 3»; 1500×800 y 2200×700 «bloque 4»; 1024×650 «360px | bloque 3»; 1600×830 «360px | bloque 4» y 1600×831 «380.453px | ninguno»; 950×1053 «360px | bloque 2» y 950×1054 «402.812px | ninguno»; 1200×971 «360px | bloque 3» y 1200×972 «424.359px | ninguno»; con la cohorte 2029: 823×1054 «337.812px», 1024×972 «320.812px», 1280×831 «357.906px», todos sin bloque; `scrollWidth` igual al ancho en todos → CONFIRMADAS

R-14 (Q44, 1.080 px de alto) por md5 de las capturas, contra la base del encargo (no la de la tarea)
esperado: md5 iguales
obtenido: 1024: a54ca1d3… y a54ca1d3…; 1280: 5f5df730… y 5f5df730…; 1920: bb876ff9… y bb876ff9… → CONFIRMADA

R-15 (Q46) con otra métrica: borde derecho de la última columna («Establecimientos») frente al borde visible de `.tw`, y ancho de la tabla frente a `clientWidth` (`rd_q46.R`)
esperado: base, 2027 oculta; final, visible en 680, 822, 1024 y 1280 con la 2027, la 2028 y la 2029
obtenido: base, 2027 a 680 y 1280: «borde 538.2, visible hasta 469.0: OCULTA | tabla 497 / cliente 428»; final: 2027 «borde 561.0, visible hasta 561.0: VISIBLE | tabla 520 / cliente 520» en los cuatro; 2028 «362.0 / 362.0 VISIBLE | 321 / 321»; 2029 «368.0 / 368.0 VISIBLE | 327 / 327» → CONFIRMADA

R-16 (Q46, cohortes vigentes) por otra vía: `--cardw` de las seis cohortes a 1024, 1280 y 1920 en la base del encargo y en el final, y md5 de capturas
esperado: iguales
obtenido: `--cardw` idéntico en las 18 lecturas (2018 323px, 2020 323px, 2021 307px, 2024 320px, 2025 324px, 2026 324px); md5, 2021 a 1920×900: 18358a45… y 18358a45…; 2025 a 1024×1080: b5e57f1d… y b5e57f1d…. A 1024×900 la 2025 difiere entre la base del encargo y el final (cf5ac0b9… y a733415e…) por Q44, que a ese tamaño fija el plano en 360 px a propósito; contra la base de Q46 (posterior a Q44) es idéntica (a733415e… y a733415e…) → CONFIRMADA

R-17 (TXT) desde el parquet de resultados por establecimiento (`arrow`), la frase con una expresión regular en R y el texto del comentario (`rd_txt.R`)
esperado: el primer año del parquet es el de la frase; 0 «en 2014 eran» y 1 marcador en la plantilla; 0 marcadores en el HTML; el comentario ya no dice que la cifra está en el tooltip
obtenido: «primer año en simce_rbd.parquet: 2014 | frase del HTML: establecimientos que en 2014 eran municipales | coincide: TRUE»; «líneas con «en 2014 eran»: 0 | con __NOTA_ANIO_ANCLA__: 1»; «marcadores __NOTA_ sin reemplazar: 0»; «ya no usa marcadores: TRUE | sigue diciendo que N_VIGENTES aparece en el tooltip: FALSE» → CONFIRMADA

Invariantes por otra vía (`rd_inv.py` en Python y blobs de git)
esperado: I-1 blobs iguales; I-2 0 ocurrencias con un patrón más amplio; I-3 `.js` iguales; I-4 blob dc900c1b…; I-5 JSON igual; I-6 DATA igual; I-9 blobs a7407ed6… y 0257bb4b…; I-10 28 en `HEAD` y en el punto de retorno
obtenido: I-1 `1bec4bd1480d` en `24a01a8`, `HEAD` y disco (index), `0b9e4ba9a969` (trayectorias); I-2 «ocurrencias 0» en los cuatro HTML (src con o sin comillas y sin esquema, `url(`, `<link href>`, `@import`); I-3 «ls-tree .js igual: SI»; I-4 dc900c1b0d2d252c9e5730875be5d632; I-5 «sha256 final 7967dfa07a99ef11 base 7967dfa07a99ef11 idéntico: True» (el primer intento del decodificador usó gzip y el bloque va en zlib: error del instrumento, corregido); I-6 «bloque DATA idéntico byte a byte: True | filas 24745 | DATA completo igual: True»; I-9 los dos md5; I-10 28 y 28 → CONFIRMADAS

Otro navegador: Firefox 156 está instalado, pero su modo de captura sin interfaz falló dos veces («Could not find profile folder»; el primer intento además con `timeout`, que no existe en macOS) y no hay geckodriver para ejecutar JS. Las re-derivaciones se hicieron en Chrome (ADVIERTE R-34).

**R.3 Invariantes 🔒** (orquestador, estado final `f3c20cf`, tras el build de la regresión; `<punto_de_retorno>` = `24a01a8`)

I-1 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47
obtenido: 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47 → **PASA**

I-2 `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html`
esperado: 0 en cada uno
obtenido: motor 0 0, vista 0 0, `docs/index.html` 0 0, `docs/trayectorias.html` 0 0 → **PASA**

I-3 `git diff --name-only 24a01a8..HEAD -- '10_utils/*.js'`
esperado: vacío
obtenido: vacío → **PASA**

I-4 `md5 -q 10_utils/10_locale.R`
esperado: dc900c1b…
obtenido: dc900c1b0d2d252c9e5730875be5d632 → **PASA**

I-5 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: «JSON idéntico a la línea base», codigo_I5=0 → **PASA**

I-6 prueba C3
esperado: PASA
obtenido: «C3 PASA … (12724 filas de 37 unidades; idénticas: TRUE; control plantado detectado: TRUE)» → **PASA**

I-7 `grep -nE '(\.by|\bgroup_by|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R | grep -v cod_com_rbd`
esperado: vacío
obtenido: vacío → **PASA**

I-8 `git diff 24a01a8..HEAD -- 30_procesamiento/33_motor_template.html | grep -E '^\+.*attr\("fill", *"#' | grep -vE '#FFFFFF|#0A3A5C'`
esperado: vacío
obtenido: vacío → **PASA**

I-9 `md5 -q 10_utils/fuentes/*.otf`
esperado: a7407ed6… y 0257bb4b…
obtenido: a7407ed6a70160cdb96021f83808a94c y 0257bb4b62d5ec557627aa0136f1e1dc → **PASA**

I-10 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 → **PASA**

**R.4 Alcance global** (`git diff --name-only 24a01a8..HEAD` con `$TMPDIR/cal_s35d/r/rd_alcance.R`, rutas y resumen por commit, y `git status --porcelain`)
esperado: 0 rutas fuera de la unión de los ALCANCE (más el log); cada commit dentro de su tarea; el árbol solo con el log
obtenido: «rutas: 6 | fuera: (ninguna)» (`gobCL_Bold.otf`, la plantilla del motor, las tres de la vista y la plantilla de la vista); por commit: `d16ef6e` solo «mode change 100755 => 100644» de la Bold (Q40); `5e54b61` y `b0f952d` la plantilla del motor (Q48, PAN); `77017cd` y `7765547` la plantilla de la vista (Q44, Q46); `f3c20cf` plantilla, funciones, generador y batería de la vista (TXT); `git status --porcelain` = `?? 50_documentacion/andamios/logs/20260925_riesgos_s35d_log.md`. Las capturas de revisión van en `_archivo/20260925_capturas_s35d/` (ignorada, `.gitignore:31`). **PASA.**

**R.5 Regresión completa** (estado final `f3c20cf`)
esperado: `Rscript 00_build.R` codigo 0; batería 32/32 codigo 0; «JSON idéntico a la línea base»
obtenido: codigo_build=0 («Fallas criticas: 0 | Advertencias: 7»); motor 601df6d7bfdc8bb60f57c5f9fba3db54, vista 1067908ec09ce95dbee692b9696da7fa, parquet 468099a9c63bb3c0ddb74e67e2c7c19f; «Resultado: 32 pruebas, 32 pasan, 0 fallan», codigo_bateria=0; «JSON idéntico a la línea base», codigo_I5=0 → **PASA**

**R.6 Control positivo de la propia auditoría**
- Cifra alterada en una copia fuera del árbol: motor con el primer decimal del JSON de 3.5 a 3.6 (`$TMPDIR/cal_s35d/r/ctl/motor_comparacion.html`) → `rd_inv.py`: «I-5 … base aec5b073d08b11db idéntico: False»; vista con un número del DATA de 23.9 a 23.8 → «I-6 bloque DATA idéntico byte a byte: False | … DATA completo igual: False». **Dispara.**
- Archivo fuera de alcance en un diff de prueba: `rd_alcance.R` sobre 7 rutas simuladas → «fuera: docs/index.html, 10_utils/fuentes/gobCL_Regular.otf, 30_procesamiento/33_generar_html.R, 10_utils/react.production.min.js, 40_salidas/intermedios/simce_rbd.parquet, _archivo/otra/x.png» (acepta solo la plantilla de la vista). **Dispara.**
- Además: el medidor de R.2 da 47 inversiones y 254 superposiciones en la base retenida y `identical: FALSE`; los medidores de las tareas dispararon en sus calibraciones (23/164; D11 con el marcador sin reemplazar; `console.error` plantado; textos plantados en el panorama; copias con un color alterado; 2027 a 680 px).

**R.7 Veredicto por hallazgo.**
- BLOQUEA: ninguno.
- REPARA: ninguno. No hubo ciclo de reparación.
- ADVIERTE: R-30 a R-39 (tabla R.10). No se corrigen.

**R.8 Ciclo de reparación.** No aplica (0 REPARA).

**R.9 Prohibiciones.** Ningún criterio, tolerancia, valor esperado ni ALCANCE se ajustó; ningún 🔒 se tocó; la evidencia escrita no se editó. La calibración de Q46 se hizo con otra cohorte porque la pedida no desborda (D-Q46-a): se declara como desviación y como duda, no como ajuste del criterio, que se midió completo.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | T0 con el encargo; `origin/main` en e21038e | `cat-file`, `diff-tree`, reflog | 1 ruta; padre e21038e | iguales | — | ninguna | — | — |
| R-02 | H7: 0 a tiempo; 23/164 con fuente tardía | `rd_q48.R` (3.000 ms, otra muestra, otro medidor) sobre la base | 0 a tiempo; fallas tardía | 0 a tiempo (final idéntico a la base a tiempo); base retenida 47/254 | — | ninguna | — | — |
| R-03 | Q40: 100644 en índice y disco | `ls-tree`, `stat`, `diff --summary` | 100644 y limpio | iguales | ADVIERTE (R-35) | registrar | — | — |
| R-04 | Q48: 0 tras `fonts.ready` y un frame | `rd_q48.R` | 0 | 0 en 405 SVG | — | ninguna | — | — |
| R-05 | Q48: disposición igual a la carga a tiempo | `comparar_cajas.R` sobre `RD.disposicion()` | TRUE | TRUE (base: FALSE, 337) | — | ninguna | — | — |
| R-06 | Q48: como máximo un dibujo más | `MutationObserver` de vaciados | ≤ 2 | 2 (antes 1) | ADVIERTE (R-33, R-39) | registrar | — | — |
| R-07 | Q48: carga normal en 0; consola 0 | `rd_q48.R` a tiempo; R.3 | 0 | 0 | — | ninguna | — | — |
| R-08 | Q48: calibración 23/164 sin el cambio | `rd_q48.R` en la base | fallas | 47/254 | — | ninguna | — | — |
| R-09 | Q48: estructura pedida | `grep` en la plantilla | presente | presente; barras sin tocar | ADVIERTE (R-38) | registrar | — | — |
| R-10 | PAN: caja 9 u, paso 12, sin literal | `grep`; `rd_pan.R` | 12; 0 literales | 12; 0 | — | ninguna | — | — |
| R-11 | PAN: 0 contactos en pantalla y exportado | `rd_pan.R` (otro caso forzado, `getBBox` por panel) | 0 | 0 y 0 (sep 1,89 y 3) | — | ninguna | — | — |
| R-12 | Q44: 48 de 48 con 320 o más | `rd_q44.R` (`getComputedStyle`, `matchMedia`, otros tamaños) | ≥ 320 | 360 o 380-424 | ADVIERTE (R-31 en ancho del plano, de Q46) | registrar | — | — |
| R-13 | Q44: umbrales 1.054, 972 y 831 | `rd_q44.R` en `N` y `N + 1` | bloque en `N`, ninguno en `N + 1` | así, también con 2029 | — | ninguna | — | — |
| R-14 | Q44: 0 px con 1.080 de alto | md5 de capturas contra la base del encargo | iguales | iguales | — | ninguna | — | — |
| R-15 | Q46: 2027 cabe; 2028 y 2029 sin desborde | `rd_q46.R` (borde de la última columna) | visible | visible en los 12 | ADVIERTE (R-30) | registrar | — | — |
| R-16 | Q46: vigentes sin cambio | `--cardw` de 6 cohortes; md5 | iguales | iguales (la diferencia a 1024×900 es de Q44) | ADVIERTE (R-32) | registrar | — | — |
| R-17 | TXT | `rd_txt.R` (parquet con `arrow`) | 2014; 0; 0 | 2014; 0; 0; comentario corregido | ADVIERTE (R-36) | registrar | — | — |
| R-18 a R-27 | I-1 a I-10 | comandos del encargo (R.3) y `rd_inv.py`/blobs | PASA | PASA | — | ninguna | — | — |
| R-28 | alcance | `rd_alcance.R` y resumen por commit | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-29 | regresión | R.5 | 0; 32/32; idéntico | iguales | — | ninguna | — | — |
| R-30 | la calibración de Q46 pedía la cohorte 2029 a 680 px, que no desborda (327 = 327); solo desborda la 2027 | `tabla.R`, `rd_q46.R` | — | premisa de §2 inexacta («2027-2029») | ADVIERTE | registrar (D-Q46-a, Q-50) | — | — |
| R-31 | con la cohorte 2027, entre 823 y 1023 px el plano queda de 179 a 379 px de ancho (antes 271 a 471) | `plano.R` | — | consecuencia de mostrar la tabla entera | ADVIERTE | registrar (Q-51) | — | — |
| R-32 | al cambiar el ancho sin recargar, `--cardw` no se vuelve a medir: de 640 a 1024 px queda en 430 (base) o 437 (final), cuando una carga nueva a 1024 da 323; con la 2027 puede llegar a 540 | `rd_cardw_resize.R`; el manejador de `resize` no llama a `anchoTarjeta()` | — | previo; Q46 cambia cuánto se arrastra; bajo 680 px el dibujo no cambia (md5 iguales a 375, 540, 640 y 679) | ADVIERTE | registrar (Q-52) | — | — |
| R-33 | con `flushSync`, la tarea en que carga la fuente se alarga lo que tardan los nuevos dibujos: 333 ms con 314 sparklines, 15,7 s con 2.846 montadas a la vez | `retenida.R` | — | en la página por omisión hay 14 tarjetas | ADVIERTE | registrar | — | — |
| R-34 | Firefox headless no disponible para re-derivar (sin geckodriver; la captura falló dos veces) | `firefox --headless --screenshot` | — | «Could not find profile folder» | ADVIERTE | registrar | — | — |
| R-35 | el modo del disco de la Bold se igualó con la autorización 3 (`git checkout -- <ruta>`), no con `chmod` | FASE Q40 | — | contenido sin cambio | ADVIERTE | registrar (D-Q40-a) | — | — |
| R-36 | el encargo cita líneas ya desplazadas (la frase de TXT está en la L404, no en la L377) | `grep -n` | — | premisas de §2 anteriores a s35c | ADVIERTE | registrar | — | — |
| R-37 | la rama de la promesa para caras declaradas después (espera un `loadingdone`) no se usa en el producto, donde la regla está en el `<head>` desde el inicio | lectura del código; método de R-46 | — | solo la ejercita la copia de R-46 | ADVIERTE | registrar (D-Q48-b) | — | — |
| R-38 | la estructura de Q48 agrega una rama al patrón de R-50 (la de R-37) y usa `flushSync` | `grep` | — | desviación declarada | ADVIERTE | registrar (D-Q48-a y D-Q48-b) | — | — |
| R-39 | en la carga normal, las 14 tarjetas de la página se dibujan dos veces (se montan antes de que se resuelva la promesa) | contador de FASE Q48 | — | dentro del criterio (un dibujo más como máximo) | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA ni REPARA; 29 afirmaciones del inventario CONFIRMADA (ninguna REFUTADA), con controles positivos que dispararon; 10 ADVIERTE (R-30 a R-39), ninguno sobre datos ni invariantes.

## Cierre

### 1. Resumen

El motor vuelve a colocar las cifras de la sparkline cuando carga `gobCL-sitio` (Q48): con la fuente retrasada, tras `document.fonts.ready` y un frame, 0 inversiones, superposiciones y cifras fuera en las 2.832 sparklines del barrido, con la misma disposición que la carga a tiempo (antes, 23 inversiones y 164 superposiciones en la muestra de 300). El panorama ubica sus cifras rescatadas con `PANORAMA_DIMS.rescate` (paso medido: 12, sin cambio visible). La vista ya no colapsa el plano en ventanas bajas (Q44: 48 de 48 combinaciones con 320 px o más), muestra entera la tabla de la cohorte 2027 (Q46; la 2028 y la 2029 no desbordaban) y toma de los datos el año ancla de sus notas (TXT); la Bold quedó sin modo ejecutable (Q40). FASE R, hecha por el orquestador con instrumentos distintos, confirmó las 29 afirmaciones y registró 10 advertencias. Veredicto: APROBADO CON ADVERTENCIAS.

### 2. Inventario de commits (`git log --oneline 24a01a8^..HEAD`)

```text
24a01a8 docs(sesion 35): encargo de cierre de riesgos antes de publicar
d16ef6e chore(repo): gobCL_Bold.otf sin modo ejecutable (Q-40)
5e54b61 fix(motor): la sparkline vuelve a colocar sus cifras cuando carga gobCL-sitio (Q-48, R-46)
b0f952d fix(motor): cifras rescatadas del panorama con paso medido (R-22)
77017cd fix(trayectorias): el plano no colapsa en ventanas bajas (Q-44)
7765547 fix(trayectorias): la tabla de las cohortes futuras cabe sin desplazarse (Q-46)
f3c20cf fix(trayectorias): el año del ancla sale de los datos en las notas (Q-47, Q-45)
```

Más el commit de este log (`docs(log): cierre de riesgos antes de publicar (s35d)`), cuyo hash va en el reporte final.

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-39).

### 4. Invariantes

I-1 a I-10 en PASA en el estado final `f3c20cf` (FASE R, R.3), con I-2 en el patrón ampliado e I-7 en forma absoluta. En ningún cierre de tarea un 🔒 dio FALLA.

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 del encargo (22aa9cf34f31fb4db6ac5b156256d13d, verificado).
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión con Rscript y chromote)

- Sparkline con la fuente retrasada (muestra de 300; barrido completo de 2.832): base 23 inversiones y 164 superposiciones cifra-cifra (249 y 1.786); después de Q48, 0 y 0 en los dos, con cada sparkline dibujada 2 veces y la disposición `identical()` a la de la carga a tiempo (16.489 cifras en el barrido completo). Re-derivación (fuente a los 3.000 ms, 405 sparklines, otro medidor): base 47 y 254; después 0 y 0.
- Carga normal: 0 en todas las métricas del barrido de S1; 0 errores de consola a 1280 y 375 px.
- Panorama: caja de «A 99,9%» en Bold 700 a 9,5 px = 9 u, paso 12; 0 contactos en pantalla y en el exportado; dibujo sin cambio (0 píxeles).
- Plano de la vista: antes, 10 de 48 combinaciones con 320 px o más (0 px a 1024 × 650); después, 48 de 48. Umbrales de alto: 1.054 (823 px de ancho), 972 (1024) y 831 (1280). Con 1.080 px de alto, 0 píxeles distintos a 1024, 1280 y 1920.
- Tabla con la cohorte 2027: `.tw` 497/428 → 520/520 (`--cardw` 430 → 522) a 680, 822, 1024 y 1280 px; 2028 (321/321) y 2029 (327/327) sin desborde antes ni después; cohortes vigentes sin cambio (0 píxeles en 18 comparaciones).
- Estado final de `40_salidas/`: motor 601df6d7bfdc8bb60f57c5f9fba3db54; vista 1067908ec09ce95dbee692b9696da7fa; `simce_comunal.parquet` 468099a9c63bb3c0ddb74e67e2c7c19f (sin cambio en toda la sesión). JSON del motor idéntico a la línea base. `docs/` sin cambio (8deb0459…/267857a2…). Batería 32/32.

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno.

Dudas, cada una con pregunta cerrada:
- Q-50. La calibración de Q46 se hizo con la cohorte 2027 y no con la 2029 que pedía el encargo, porque la 2029 no desborda (R-30). ¿Se acepta? (sí / no)
- Q-51. Con la cohorte 2027, entre 823 y 1023 px el plano queda de 179 a 379 px de ancho (R-31). ¿Se pasa a una columna en ese tramo cuando la tarjeta es ancha? (sí / no)
- Q-52. Al cambiar el ancho de la ventana sin recargar, `--cardw` no se vuelve a medir (previo; R-32). ¿Se agrega `anchoTarjeta()` al manejador de `resize`? (sí / no)
- Q-53. `flushSync` alarga la tarea en que carga la fuente en proporción al número de sparklines (R-33). ¿Se acepta, o se prefiere repartir los nuevos dibujos aunque haya un cuadro con cifras mal colocadas? (se acepta / repartir)

Pendientes fuera del encargo: publicación a `docs/` y Pages (§11, tras la revisión en Safari); los excluidos de §11 (Q-42, Q-43, Q-34, Q-21, `OP_PREVIO`, Q-29, Q-31, Q-39, v30-5, Museo Sans, pendientes 8, 10, 12 y 13 de v34); la pista de años con 7 pares superpuestos a 680 px (Q-46, segunda parte); CLAUDE.md (D2; no se creó, como en s35, s35b y s35c: `.gitignore` lo excluye y el ALCANCE es cerrado). `# REVISAR` nuevos: ninguno (`git diff 24a01a8..HEAD | grep -c "^+.*REVISAR"` = 0).

### 8. Errores propios consolidados

- Q48: medí primero el intento 1 con 1.500 ms de espera adicional, no «tras `document.fonts.ready` y un frame» como pide el criterio; el barrido completo mostró que React repartía los nuevos dibujos, y el intento 2 lo corrigió.
- TXT: encadené un `rm -rf` sobre una carpeta nueva de `$TMPDIR` que todavía no existía (no borró nada). La autorización 5 cubre borrar en `$TMPDIR`, pero la regla global del titular pide aprobación individual para todo `rm -rf`.
- FASE R: dos instrumentos de re-derivación con un error al primer intento (en el SVG exportado del panorama, `getBBox` sin agrupar por panel dio 18 falsos contactos; el decodificador de I-5 usó gzip y el bloque va en zlib). Los dos se corrigieron antes de registrar el resultado.
- FASE R: el primer intento con Firefox usó `timeout`, que no existe en macOS.
- Ninguno de estos errores tocó el producto.

### 9. Notas para el revisor

- Revisar en Safari, idealmente en un equipo sin gobCL instalada:
  - el motor con una conexión lenta o con la caché vacía: al llegar la fuente, las cifras de la sparkline deben reacomodarse de inmediato (Q48; en Safari no se pudo medir);
  - el panorama en 2° Medio (cifras rescatadas bajo el eje);
  - la vista con ventanas bajas (1024 × 650 o 1280 × 768): el plano con su alto propio y la página que crece hacia abajo; la cohorte 2027 con la tabla entera y el plano más angosto entre 823 y 1023 px;
  - las notas metodológicas («que en 2014 eran municipales»).
- Capturas de revisión en `_archivo/20260925_capturas_s35d/`: `q44_vista_1024x650_{antes,despues}_1024.png`, `q44_vista_1280x768_{antes,despues}_1280.png` y `q46_vista_2027_{antes,despues}_1280.png`. Las referencias de D35-10 (`_archivo/20260925_capturas_s35c/`) siguen valiendo con 900 px de alto a 1280 y 1920; a 768 y 1024 px con 900 de alto la vista cambia por Q44 (el plano pasa a 360 px), a propósito.

### 10. Estado de cierre

- **Commiteado:** 7 commits del encargo (T0 a TXT) más el de este log, en `main`.
- **Condiciones de publicación medidas antes de este commit** (autorización 4): veredicto de FASE R `APROBADO CON ADVERTENCIAS`; `git -C "$RAIZ" fetch origin` fetch_codigo=0; `origin/main` = `e21038e`; `git merge-base --is-ancestor origin/main HEAD` ancestro_codigo=0; 7 commits por publicar; md5 de `docs/index.html` y `docs/trayectorias.html` = 8deb04595510b0f15da8bb65813b7a38 y 267857a2962602bd9e6c5cc56effcb47 (iguales a H4); `git status --porcelain` = solo este log (queda vacío con su commit). El `git push origin main` se corre después de este commit, con `git status --porcelain`, `fetch` y `merge-base` medidos otra vez; su resultado va en el reporte final.
- **Queda al titular:** la revisión en Safari y las capturas; las dudas Q-50 a Q-53; la publicación a `docs/`.
- **Hash de `docs(log)`:** se informa en el reporte final (`git log -1 --format=%h`).
