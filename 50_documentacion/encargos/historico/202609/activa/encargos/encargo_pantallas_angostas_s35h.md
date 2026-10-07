# Encargo autónomo: pantallas angostas, centrado restante y fuente del PNG (sesión 35, octava ola)

Instrumento: `encargo_autonomo_claude_code_v1.md` (v1.6). Redacción: asistente de análisis, sesión 35,
2026-09-25. Ejecución: Claude Code en la estación macOS del titular, en una sesión nueva.

**Contexto.** `encargo_supports_cohortes_s35g.md` quedó publicado (`cefa729`; Pages sirve `7f5971a3…` y
`523ce765…`). Tras leer su log, el titular decidió en bloque las dudas abiertas (D35-11 a D35-13, en
`50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`). Este encargo resuelve las que
piden cambios:

- **Q-55.** A 375 px el modal «Agregar territorio» desborda la ventana (`min-width: 540px`).
- **Q-34 y Q-43.** A 375 px el supergrid de `#comparacion` tiene 4 columnas de unos 65 px: los rótulos se montan
  sobre la celda vecina y las sparklines miden 43 px de ancho.
- **Q-57 (D35-13).** El centrado óptico se extiende a las pestañas y al campo del modal, a los rótulos de
  exportar y a «Ver establecimientos» del tooltip.
- **Q-31 (D35-13).** El PNG exportado incrusta la fuente del sitio.
- **Q-52.** Al cambiar el ancho de la ventana sin recargar, `--cardw` no se vuelve a medir.
- **Q-51.** Con la cohorte 2027, entre 823 y 1023 px, el plano queda de 179 a 379 px de ancho.

**Meta en una línea:** que el motor se lea y se use a 375 px (modal y supergrid), que los controles que
faltaban queden centrados con la misma guarda `@supports`, que el PNG salga con gobCL, y que la vista mida
bien la tarjeta al cambiar de ancho y no deje el plano angosto. Todo publicado en Pages.

---

## 1. Encabezado de contrato

**Modo y disciplina.** Modo autónomo, todo en este turno. **Sin subagentes:** las seis tareas tocan dos
plantillas y un solo build, y el encargo termina en un acto público.

```text
EJECUCIÓN: esfuerzo xhigh; orquestador Opus (modelo de la sesión); subagentes 0; total Opus del encargo 0
```

**Topes de esfuerzo.** 3 intentos por bug; 2 ciclos de reparación en FASE R; 1 reintento por comando.

**Regla de detención.**

- H1 a H4 no dan lo esperado → **detén la sesión** y pasa a FASE L.
- H5 o H6 (batería o build) fallan → **detén la sesión**.
- Si una tarea no cumple su criterio tras 3 intentos → congela esa tarea y sigue con la siguiente. Con
  **cualquier** tarea congelada no hay copia a `docs/` ni push. El resto se commitea igual.
- Un 🔒 da FALLA → **detén la sesión** antes del push.
- `git push` rechazado, o `origin/main` no es ancestro de `HEAD` tras `fetch` → no publiques y pasa a FASE L.
- **Cualquier estado, conteo o resultado no enumerado en este encargo → congela ESTA tarea, regístrala como
  duda (4.1) y sigue con la próxima tarea independiente.**

**Autorizaciones (lista cerrada).**

1. `git add <rutas explícitas del ALCANCE>` y `git commit` por tarea.
2. `cp 40_salidas/motor_comparacion.html docs/index.html` y
   `cp 40_salidas/trayectorias_traspasos.html docs/trayectorias.html`, solo en PUB y con las seis tareas
   completas.
3. Descartar un intento sin commitear: `git checkout -- <ruta>` sobre rutas del ALCANCE de la tarea en curso,
   después de guardar el intento como parche en `$TMPDIR/cal_s35h/` y anotar su md5 en el log.
4. `git push origin main`, una sola vez, al final de FASE L. Condiciones medidas en el mismo turno:
   - veredicto de FASE R `APROBADO` o `APROBADO CON ADVERTENCIAS`;
   - árbol vacío;
   - `fetch` y luego `merge-base --is-ancestor origin/main HEAD` con código 0;
   - md5 de `docs/` iguales a los de PUB.
5. Crear, sobrescribir y borrar `verificar_*.R` en la raíz y archivos en `$TMPDIR`.
6. `curl -s` y `curl -sI` de lectura contra las dos URL públicas, solo en P3.
7. Crear `_archivo/20260925_capturas_s35h/` (ignorado) y escribir capturas en esa carpeta.
8. **Segundo push, solo del log** (corrige ERR-35-19: en s35g, P3 quedó fuera del log versionado). Después
   de P3: anexar al log la sección `### FASE P3`, `git add` del log, `git commit -m "docs(log): P3 de s35h"` y
   `git push origin main`. Solo si `git diff --name-only HEAD~1..HEAD` muestra únicamente el log y si
   `fetch` y `merge-base --is-ancestor origin/main HEAD` dan código 0.

Van implícitos en el patrón los commits `fix(auditoria)` y `docs(log)`. Nada más.

**Reglas canónicas heredadas.** R es el único lenguaje de los entregables. Los commits van en español. Toda
medida nueva va en una constante nombrada (CSS: variable en `:root`; JS: constante en mayúsculas). `docs/`
solo cambia por copia íntegra. I-6 se mide en forma absoluta. Los `.otf` no se editan. Todo centrado nuevo va
dentro de `@supports (text-box: trim-both cap alphabetic)`, como dejó s35g (fuera, la regla de hoy).

**Contrato de entorno.**

1. **ENTORNO:** Claude Code en la estación macOS, en `/Users/tomgc/Projects/slep_simce_adecuado`.
2. **INSUMOS:**
   - el log de s35g (G1, G3, R-37 a R-43) y el de s35f (FASE TB: inventario y medidor de centrado);
   - el log de s35d (R-31, R-32, Q-51, Q-52) y el de s35b (FASE M3: Q-19 y Q-34);
   - D35-11 a D35-13 en el archivo de decisiones;
   - los medidores de la raíz: `verificar_centrado.R` y `verificar_sin_textbox.R` (ignorados por git; si no
     están o no corren, se reescriben con la misma especificación que describen sus logs).
3. **POSICIÓN:**
   - rutas completas;
   - `bash -c '...'` con `RAIZ=/Users/tomgc/Projects/slep_simce_adecuado`;
   - R con `cd "$RAIZ" && Rscript ...`;
   - `rev-parse` con un argumento por comando;
   - `fetch` antes de operar contra el remoto;
   - un código de salida se lee sin tubería (lección de s35g: tras `| tail` se lee el de `tail`).
4. **LOG:** `50_documentacion/andamios/logs/20260925_pantallas_angostas_s35h_log.md`.
5. **ALCANCE:** en §5.
6. **PRUEBAS:**
   - `Rscript 00_build.R` → código 0, con 0 fallas críticas;
   - batería (`30_procesamiento/36_verificar_trayectorias.R`) → código 0, con 33 pruebas o más;
   - `Rscript verificar_contenido_motor.R` → «JSON idéntico a la línea base».
7. **PUNTO DE RETORNO:** el hash del commit de T0.

---

## 2. Estado de partida (premisas marcadas)

Salvo que se indique otra cosa, cada premisa se midió en la sesión 35 con git de solo lectura, `grep`, `sed`,
`md5sum` o `curl` sobre la estación.

- `HEAD` y `origin/main` están en `cefa729` (fuente: `git rev-parse`). El árbol tiene dos archivos modificados
  sin commit, que T0 commitea: el archivo de decisiones (D35-11 a D35-13) y
  `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md` (ERR-35-19) (fuente:
  `git status --porcelain`). Pages sirve `7f5971a3a99b24540ee797b9c1966a0c` y
  `523ce765359e1cb1ee080b3fe557c93b`, iguales a `docs/` (fuente: `curl | md5sum` y `md5sum docs/*.html`).
- `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'` da `28` (fuente: el comando).
- **Modal (Q-55).** `.modal` tiene `min-width: 540px; max-width: min(880px, 96vw)`; `.modal-tabs` es
  `display: flex; flex-wrap: nowrap` con 6 pestañas; `.form-grid` tiene 2 columnas; `.modal-backdrop` tiene
  `padding: 20px` (fuente: `sed -n 839,935p 33_motor_template.html`). En s35f el `.select` del modal quedó en
  x = −59,5 a 375 px (fuente: log s35f, R-41).
- **Supergrid (Q-34 y Q-43).** Las columnas salen de
  `gridTemplateColumns: repeat(${entities.length}, minmax(0, 1fr))` (L4868 del motor). A 375 px, con 4
  entidades, cada columna mide 64,75 px, y «Últimas 3 aplicaciones» y «Trayectoria histórica» superan su celda
  en 32,27 px (fuente: log s35b, FASE M3). El motor tiene un `@media (max-width: 640px)` en la L1183 (fuente:
  `grep -n '@media'`).
- **Controles de Q-57.** `.modal-tab` (L872), `.input.input-search` (4 usos en el modal), `.icon-export-label`
  (L423, visible al pasar el ratón o con foco) y el botón `.tt-estab-link` que crea el tooltip fijado
  (L2164-2168) (fuente: `grep -n` y `sed`). Hoy hay 7 `@supports` en el motor, 4 en la vista y 3 en el
  fragmento, contando las líneas de comentario (fuente: `grep -c '@supports'`).
- **PNG (Q-31).** Los `<text>` del SVG usan `FONT_SVG = "gobCL-sitio, system-ui, sans-serif"` (L1821).
  `rasterizarSvgAPng()` (L3440) carga el SVG serializado como `Image` desde un `Blob` y lo dibuja en un
  `canvas` (fuente: `sed -n 3395,3490p`). Hipótesis (se mide en FASE 0): una imagen SVG cargada así no ve las
  `@font-face` de la página, así que hoy el PNG sale **siempre** con `system-ui`, aunque el equipo tenga gobCL
  instalada (la familia se llama `gobCL-sitio` desde D35-9).
- **`--cardw` (Q-52).** El manejador de `resize` de la vista (L1190-1191) llama a `altoMenu()`, `pista()`,
  `build()` y `render()`, pero no a `anchoTarjeta()`. `trasFuentes()` (L1212) sí la vuelve a medir, después de
  `removeProperty('--cardw')` (fuente: `sed -n 1186,1221p`). En s35d, de 640 a 1024 px sin recargar,
  `--cardw` quedaba en 430 o 437, cuando una carga nueva a 1024 daba 323 (fuente: log s35d, R-32).
- **Plano (Q-51).** En 823-1023 px la vista va en dos columnas (`.main{grid-template-columns:var(--cardw,300px)
  minmax(0,1fr)}`, L152). El tramo 680-822 ya pasa a una columna con tres declaraciones
  (`.app:not(.pres) .main`, `.card` con `--cardw` y `svg.chart` con `--alto-plano-fijo`, L315-320) (fuente:
  `sed -n 300,345p`). Con la cohorte 2027 el plano medía de 179 a 379 px de ancho en ese tramo (fuente: log
  s35d, R-31).

---

## 3. Contexto mínimo

Son seis arreglos chicos e independientes en su efecto, pero comparten build y capturas. Cada uno cambia solo
su zona: el modal y el supergrid bajo 640 px, los controles de Q-57 solo con soporte de `text-box`, el PNG
solo en el archivo descargado, y la vista solo al cambiar de ancho o con una tarjeta ancha entre 823 y
1023 px. Por eso el invariante I-9 exige 0 píxeles distintos en el estado inicial a 1280 y 1440 px.

---

## 4. Invariantes 🔒

| # | Invariante | Comando | Esperado |
|---|---|---|---|
| I-1 | `docs/` solo cambia por copia íntegra en PUB | `md5 -q docs/*.html` tras PUB | iguales a `40_salidas/` |
| I-2 | Sin carga por red | `grep -cE "src=[\"']?(https?:)?//"` y `grep -c 'url(http'` en `40_salidas/*.html` y `docs/*.html` | `0` en cada uno |
| I-3 | Los datos del motor no cambian | `Rscript verificar_contenido_motor.R` | «JSON idéntico a la línea base» |
| I-4 | Los datos de la vista no cambian | el `DATA` decodificado de la vista, comparado con la base de H6 con `identical()` | `TRUE` |
| I-5 | Las fuentes no cambian | `md5 -q 10_utils/fuentes/*.otf` | `a7407ed6…` (Bold) y `0257bb4b…` (Regular) |
| I-6 | Se agrega por `cod_com_rbd` | `grep -nE '(\.by\|\bgroup_by\|group_vars)[^#]*nom_com_rbd' 30_procesamiento/*.R \| grep -v cod_com_rbd` | vacío |
| I-7 | No se agregan archivos de datos | `git ls-files \| grep -cE '\.(csv\|xlsx\|parquet\|rds)$'` | `28` |
| I-8 | Sin desborde horizontal | `scrollWidth` de la vista, `#comparacion` y `#panorama` a 375, 414, 540, 768, 1024 y 1280 px | igual al viewport |
| I-9 | El estado inicial de escritorio no cambia | capturas de las tres vistas a 1280 × 900 y 1440 × 900, estado inicial, contra la base de H6 | 0 píxeles distintos |
| I-10 | Sin `text-box`, el centrado nuevo no existe | `verificar_sin_textbox.R` sobre el estado final, contra la base de H6 simulada igual | altos de los controles de Q-57 iguales a la base (\|Δ\| ≤ 0,5 px) |

---

## 5. Tareas y ALCANCE

El orden es fijo: T0, M1, M2, M3, M4, V1, V2, PUB, FASE R, FASE L con el push, P3 y su commit (autorización 8).

| Tarea | ALCANCE |
|---|---|
| T0 | este encargo, `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`, `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md` |
| M1 | `30_procesamiento/33_motor_template.html`, `_archivo/20260925_capturas_s35h/` |
| M2 | `30_procesamiento/33_motor_template.html`, `_archivo/20260925_capturas_s35h/` |
| M3 | `30_procesamiento/33_motor_template.html`, `_archivo/20260925_capturas_s35h/` |
| M4 | `30_procesamiento/33_motor_template.html`, `_archivo/20260925_capturas_s35h/` |
| V1 | `30_procesamiento/36_trayectorias_template.html` |
| V2 | `30_procesamiento/36_trayectorias_template.html`, `_archivo/20260925_capturas_s35h/` |
| PUB | `docs/index.html`, `docs/trayectorias.html`, `40_salidas/*.html` |
| P3 | el log |

---

## 6. FASE 0

1. Crear el log con el encabezado, el slot `## J. Juicio (lo rellena FASE L)` vacío y la plantilla del Apéndice.
2. **H1.** `git status --porcelain` → esperado, exactamente estas tres líneas, más el log:
   - ` M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`
   - ` M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`
   - `?? 50_documentacion/activa/encargos/encargo_pantallas_angostas_s35h.md`
3. **H2.** `git stash list | wc -l` → esperado: `0`.
4. **H3.** `fetch`. Después, `rev-parse --short HEAD` → `cefa729` y `rev-parse --short origin/main` → `cefa729`.
5. **H4.** md5 de este encargo → esperado: el del mensaje de entrega. md5 de `docs/` → esperado:
   `7f5971a3…` y `523ce765…`. Después, `git add` de las tres rutas de T0 y
   `git commit -m "docs(sesion 35): encargo de la octava ola y decisiones D35-11 a D35-13"`. El hash
   resultante es el punto de retorno.
6. **H5.** Batería → esperado: 33 en PASA, código 0.
7. **H6.** `Rscript 00_build.R` → esperado: código 0, y salidas con md5 iguales a `docs/` (build
   reproducible, como en s35g).
   - Copia las dos salidas a `$TMPDIR/base_s35h/`.
   - Calibra `verificar_contenido_motor.R`: «idéntico» sobre la base y «difiere» con un número alterado.
   - Guarda las capturas de I-9 (tres vistas a 1280 × 900 y 1440 × 900) y comprueba que dos cargas dan
     0 píxeles distintos.
8. **Mediciones de partida (calibraciones de cada tarea).** Cada una se anota con esperado/obtenido:
   - M1: a 375 × 740 y 414 × 896, con el modal abierto en cada una de sus 6 pestañas, cuántos elementos del
     modal quedan con `left < 0` o `right > innerWidth`. Esperado: al menos 1 a 375 (R-41 de s35f).
   - M2: a 375 px, con el estado inicial de `#comparacion`, el ancho de cada columna del supergrid, el ancho
     de cada sparkline, y cuántos textos del supergrid superan el borde derecho de su celda (medido con
     `Range.getClientRects()` contra la caja de la celda). Esperado: al menos 2 textos (Q-19 de s35b).
   - M3: con `verificar_centrado.R` ampliado a los controles de Q-57 (pestaña activa e inactiva, campo de
     búsqueda, un rótulo de exportar con foco, «Ver establecimientos» con el tooltip fijado), el desvío
     `arriba − abajo` de cada uno a 1280 y 375 px. Esperado: se registra; al menos uno fuera de ±2 px de
     dispositivo (si ninguno lo está, M3 no tiene defecto medible: congela M3 y regístralo como duda).
   - M4: exporta el PNG del supergrid y el del panorama (capturando el `Blob` que recibe `descargarBlob`).
     Mide, en el PNG, el ancho en píxeles de un texto de referencia del SVG (por ejemplo, el nombre de una
     entidad). Compáralo con `getComputedTextLength()` del mismo texto en la página, con `gobCL-sitio` y con
     `system-ui`, multiplicado por `PNG_SCALE`. Esperado: el PNG coincide con `system-ui` (confirma la
     hipótesis de §2), y los dos anchos de referencia difieren en más de 4 px de PNG (si no difieren, el
     criterio no discrimina: congela M4 y regístralo como duda).
   - V1: cargar a 640 px, pasar a 1024 px sin recargar, y leer `--cardw`; compararlo con una carga nueva a
     1024 px. Lo mismo de 1280 a 900 y de 900 a 1280, con la cohorte inicial y con la 2027. Esperado: al
     menos un par distinto (R-32 de s35d).
   - V2: el ancho del plano (`svg.chart`) a 823, 900, 960 y 1023 px de ancho (alto 900), con todas las
     cohortes. Anota el mínimo con la cohorte inicial: es `ANCHO_PLANO_MIN` de V2. Esperado: la 2027 queda
     bajo ese mínimo en al menos un ancho (R-31 de s35d).
9. Anexa `### FASE 0`.

---

## 7. Tareas

### M1. El modal cabe a 375 px (Q-55)

1. Bajo 640 px (el `@media` existente del motor u otro en el mismo punto de corte), el modal se ajusta a la
   ventana:
   - `.modal` sin el `min-width` de 540 px (por ejemplo, `min-width: 0` y `width: 100%` dentro del
     `padding` del fondo);
   - `.form-grid` en una columna;
   - `.modal-tabs` con desplazamiento horizontal propio (`overflow-x: auto`), sin salto de línea, para que las
     6 pestañas sigan en una fila.

   Sobre 640 px nada cambia.
2. **Criterio.**
   - A 375 × 740 y 414 × 896, en las 6 pestañas: 0 elementos del modal con `left < 0` o
     `right > innerWidth`, y el `scrollWidth` del documento igual al viewport.
   - Cada pestaña se puede activar con un clic tras desplazarla a la vista (`scrollIntoView`), y el pie
     «Cancelar / Agregar» queda visible dentro del modal.
   - A 768 y 1280 px, con el modal abierto en las 6 pestañas: 0 píxeles distintos contra la base.
   - **Calibración:** FASE 0, paso 8 (M1).
3. Commit: `fix(motor): el modal de territorio cabe en pantallas angostas (Q-55)`.

### M2. El supergrid se lee a 375 px (Q-34 y Q-43)

1. Bajo 640 px, el supergrid tiene columnas de un ancho mínimo nombrado (`--supergrid-col-min`) y se desplaza
   en horizontal dentro de su propio contenedor, sin desbordar la página. El valor sale de la medición de
   FASE 0: el texto más ancho del supergrid a 375 px, más el relleno de la celda, redondeado hacia arriba.
   Sobre 640 px nada cambia.
2. **Criterio.**
   - A 375 y 414 px, con 1, 2, 4 y 6 entidades: 0 textos del supergrid que superen el borde de su celda, y
     cada sparkline con un ancho igual o mayor que `--supergrid-col-min` menos el relleno de la celda.
   - I-8: el `scrollWidth` del documento es igual al viewport; el desplazamiento vive solo en el contenedor
     del supergrid.
   - A 768 y 1280 px: 0 píxeles distintos contra la base en `#comparacion`.
   - **Calibración:** FASE 0, paso 8 (M2).
3. Commit: `fix(motor): el supergrid se lee en pantallas angostas (Q-34, Q-43)`.

### M3. Centrado de los controles restantes (Q-57)

1. Aplica a `.modal-tab`, al campo `.input` del modal, a `.icon-export-label` y a `.tt-estab-link` el mismo
   centrado óptico de s35f, con los tokens que ya existen (`--compensa-recorte` y, si el control lo pide,
   `.control-texto` en el marcado), **solo dentro de** `@supports (text-box: trim-both cap alphabetic)`. Fuera
   del bloque, la regla de hoy sin cambios. Si un control no admite el recorte (como el `<select>` en s35f),
   usa el ajuste equivalente y decláralo.
2. **Criterio.**
   - Con soporte: los controles de Q-57 dentro de ±2 px de dispositivo, a 1280 y 375 px.
   - Los 90 controles del inventario de s35f siguen dentro de ±2 px, con alto y posición iguales a la base
     (|Δ| ≤ 0,5 px).
   - Sin soporte (I-10): con `verificar_sin_textbox.R`, los altos de los controles de Q-57 son iguales a los
     de la base simulada.
   - `grep` fuera de `@supports`: 0 apariciones nuevas de `text-box`, `1cap`, `lh` como unidad o `round(`
     (el mismo comando que en G1 de s35g).
   - **Calibración:** FASE 0, paso 8 (M3).
3. Commit: `fix(motor): centrado optico de pestañas, campo, exportar y tooltip (Q-57)`.

### M4. El PNG exportado lleva la fuente del sitio (Q-31)

1. Antes de rasterizar, el SVG que recibe `rasterizarSvgAPng()` lleva dentro un `<style>` con las
   `@font-face` de `gobCL-sitio` (Regular 400 y Bold 700, en `data:`). Se leen en tiempo de ejecución de las
   hojas de estilo de la página (reglas `CSSFontFaceRule` de esa familia), no se duplican en la plantilla. La
   imagen se dibuja cuando la fuente está lista (`img.decode()` o equivalente, medido). La exportación **SVG**
   no cambia.
2. **Criterio.**
   - En el PNG del supergrid y en el del panorama, el ancho del texto de referencia coincide con el de
     `gobCL-sitio` (±2 px de PNG) y difiere del de `system-ui` (FASE 0).
   - El SVG exportado es idéntico byte a byte al de la base.
   - I-2: el `<style>` usa `data:`, sin red.
   - El techo de superficie (`PNG_MAX_SUPERFICIE_PX`) y los mensajes de error no cambian.
   - **Calibración:** FASE 0, paso 8 (M4).
3. Commit: `fix(motor): el PNG exportado incrusta gobCL (Q-31)`.

### V1. `--cardw` se vuelve a medir al cambiar de ancho (Q-52)

1. En el manejador de `resize`, antes de `pista()`, `build()` y `render()`: `removeProperty('--cardw')` y
   `anchoTarjeta()`, igual que en `trasFuentes()`.
2. **Criterio.**
   - Con los pares de anchos de FASE 0 y las cohortes inicial y 2027: `--cardw` tras el cambio es igual al de
     una carga nueva en el ancho de llegada.
   - Sin cambiar de ancho, las capturas de la vista a 375, 768 y 1280 px dan 0 píxeles distintos contra la base.
   - **Calibración:** FASE 0, paso 8 (V1).
3. Commit: `fix(trayectorias): la tarjeta se vuelve a medir al cambiar el ancho (Q-52)`.

### V2. El plano no queda angosto entre 823 y 1023 px (Q-51)

1. Nueva constante `ANCHO_PLANO_MIN`, con el valor medido en FASE 0. Después de `anchoTarjeta()`, si el ancho
   disponible para el plano (ancho de `.main` menos `--cardw` y el `gap`) es menor que `ANCHO_PLANO_MIN`, la
   vista agrega a `.app` una clase (por ejemplo, `una-col`). Con esa clase, y fuera del modo presentación, la
   vista usa las mismas declaraciones que el tramo 680-822: una columna, tarjeta con `--cardw` y plano con
   `--alto-plano-fijo`, y crece con su contenido. La clase se recalcula en cada `resize` (V1) y al cambiar de
   cohorte.
2. **Criterio.**
   - A 823, 900, 960 y 1023 px, con todas las cohortes: el plano mide `ANCHO_PLANO_MIN` o más de ancho, y 320
     o más de alto (el umbral de Q-44).
   - Las cohortes que en FASE 0 ya tenían el plano en `ANCHO_PLANO_MIN` o más: 0 píxeles distintos contra la
     base en esos anchos.
   - I-8 en esos anchos.
   - Presentación: sin cambios (0 píxeles distintos contra la base a 1024 × 768).
   - **Calibración:** FASE 0, paso 8 (V2).
3. Commit: `fix(trayectorias): una columna cuando la tarjeta deja el plano angosto (Q-51)`.

### PUB. Copia a `docs/` (solo con las seis tareas completas)

1. `Rscript 00_build.R` y la batería → código 0.
2. `cp` a `docs/` (autorización 2).
3. **Verificación.**
   - md5 de `docs/` igual a `40_salidas`;
   - I-2, I-3 e I-4;
   - `git status --porcelain` muestra solo los dos archivos de `docs/` (más el log sin seguimiento).
4. Commit: `deploy(docs): pantallas angostas, centrado restante y PNG con gobCL`.

### P3. Lo que sirve Pages (después del push de FASE L)

1. Cada 60 s, hasta 10 minutos:
   - `curl -s https://tomgc.github.io/slep_simce_adecuado/ | md5` → esperado: igual a
     `md5 -q docs/index.html`;
   - `curl -s https://tomgc.github.io/slep_simce_adecuado/trayectorias.html | md5` → esperado: igual a
     `md5 -q docs/trayectorias.html`.
2. Si a los 10 minutos no coincide, anota los md5 y el `last-modified` que devuelve `curl -sI`. No
   reintentes el push de FASE L.
3. Anexa `### FASE P3` al log con esperado/obtenido y cierra con la autorización 8 (commit y push solo del
   log).

---

## 8. FASE R: auditoría propia y reparación (penúltima y obligatoria; corre aunque haya tareas congeladas)

La regla de oro: **la reparación cambia el trabajo, nunca el criterio, la tolerancia, el valor esperado ni
la meta**.

1. **Inventario de afirmaciones auditables.** Se arma desde el log, no desde la memoria: cada línea
   `Verificación:`, cada cifra de las secciones por fase, cada 🔒 de §4 con su comando y el alcance global. Se
   numeran `R-01`, `R-02`, etc., y el inventario se anexa al log **antes** de auditar.
2. **Re-derivación independiente.** Sin subagentes: el orquestador re-deriva cada afirmación con un comando
   distinto del que la produjo. La identidad de lo publicado se comprueba con `git hash-object` sobre `docs/` y
   sobre `40_salidas/`, en vez de `md5`. La ausencia de red se comprueba con un segundo patrón, `grep -c 'http'`,
   y cada acierto se revisa a mano: los enlaces `<a href>` a sitios oficiales en el texto son esperables.
3. **Invariantes 🔒.** Corre el comando de cada uno y anota PASA o FALLA con la salida literal.
4. **Chequeo global de alcance.** `git diff --name-only <punto_de_retorno>..HEAD` debe quedar dentro de la
   unión de los ALCANCE, más el log. Corre también `git status --porcelain`: lo que no esté commiteado es un
   hallazgo, no se limpia.
5. **Regresión completa.** Los tres comandos de PRUEBAS sobre el estado final.
6. **Control positivo de la propia auditoría.** Al menos una cifra alterada en una copia temporal fuera del
   árbol y un archivo fuera de alcance simulado en un diff de prueba. El instrumento debe disparar en los dos
   casos.
7. **Veredicto por hallazgo:**
   - **BLOQUEA:** gobernanza de datos, un 🔒 en FALLA, datos alterados, alcance violado o historia divergente.
     No se repara: se congela la tarea de origen y se registra como duda con pregunta cerrada. Si compromete el
     repositorio, se detiene la sesión y se pasa a FASE L.
   - **REPARA:** un defecto del propio trabajo, dentro del ALCANCE, que no toca un 🔒 y tiene una verificación
     calibrada. Se corrige en el ciclo del paso 8.
   - **ADVIERTE:** una discrepancia sin efecto sobre la meta ni los invariantes, o un riesgo que esta sesión no
     puede medir. Se registra, no se corrige.

   «0 hallazgos» solo se declara junto con el control positivo del paso 6.
8. **Ciclo de reparación (máximo 2 ciclos).** Por cada REPARA:
   - (a) causa raíz;
   - (b) fix quirúrgico dentro del ALCANCE;
   - (c) re-verificación con el mismo chequeo **y** con uno distinto;
   - (d) regresión;
   - (e) commit `fix(auditoria): R-NN <hallazgo>`;
   - (f) fila en la tabla.

   Luego se repiten los pasos 2 a 5 sobre lo tocado. Un hallazgo que sobrevive al segundo ciclo, o que destapa
   otro, se congela y se registra como pendiente.
9. **Prohibido:** ajustar un criterio, una tolerancia o un valor esperado; ampliar un ALCANCE; tocar un 🔒;
   editar evidencia ya escrita; reparar un BLOQUEA; aceptar una reparación de un subagente sin verificarla.
10. **Salida.** Una tabla con las columnas `id | afirmación | comando de re-derivación | esperado | obtenido |
    severidad | acción | commit | re-verificación` y un veredicto global: `APROBADO`,
    `APROBADO CON ADVERTENCIAS`, `OBSERVADO` o `BLOQUEADO`. El veredicto va al bloque J.

---

## 9. FASE L: cierre del log (última y obligatoria; corre siempre)

1. **Estado del árbol.** `git status --porcelain` → esperado: vacío o solo el log. Cualquier otra cosa es un
   hallazgo y no se limpia.
2. **Cierre del log.** Se completan las secciones de la plantilla: resumen, inventario de commits (desde
   `git log <punto_de_retorno>..HEAD --oneline`), tabla de auditoría, invariantes, cifras, dudas y
   pendientes, errores propios y notas para el revisor. Las secciones por fase no se reescriben.
3. **Bloque J.** Se rellena copiando del detalle, nunca de memoria.
4. **Privacidad.** `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]' <LOG>` → esperado: vacío. Una lectura
   confirma que no hay filas de datos ni nombres de personas o de establecimientos: se usan RBD o conteos.
5. **Verificación del archivo.**
   - `ls -l <LOG> && wc -l <LOG>`;
   - `grep -c '^### FASE' <LOG>` igual al número de fases ejecutadas;
   - `grep -c '^esperado:' <LOG>` igual a `grep -c '^obtenido:' <LOG>`;
   - `grep -c '^## J' <LOG>` igual a 1, con el bloque relleno.

   Si algo falta, se anexa con su estado real, sin ajustar el conteo.
6. **Commit.** `git add 50_documentacion/andamios/logs/20260925_pantallas_angostas_s35h_log.md` y
   `git commit -m "docs(log): pantallas angostas, centrado restante y PNG (s35h)"`. Después, `git push origin main`, solo
   si se cumple la autorización 4. Si no se cumple, se declara.
7. **Estado de cierre.** Qué quedó commiteado, si se publicó (con la condición medida) y qué queda al titular:
   revisión en Safari y en un teléfono real. Incluye el hash de `docs(log)`. P3 y su commit se anexan después
   (autorización 8), sin reescribir esta sección.

---

## 10. Reporte final

1. **Primera línea:** la salida literal de `ls -l <LOG> && wc -l <LOG>` (tras el commit de P3), el hash de
   `docs(log)` y el de `docs(log): P3 de s35h`.
2. **Segundo bloque:** el bloque J, tal cual.
3. Después, en este orden:
   - los hashes;
   - las verificaciones con su evidencia;
   - M1: elementos del modal fuera de la ventana, antes y después, por ancho y pestaña;
   - M2: `--supergrid-col-min`, textos que superan su celda y ancho de las sparklines, antes y después;
   - M3: desvío de centrado de cada control de Q-57, antes y después, con y sin soporte;
   - M4: ancho del texto de referencia en el PNG contra `gobCL-sitio` y `system-ui`, antes y después;
   - V1: `--cardw` por par de anchos y cohorte, antes y después, contra la carga nueva;
   - V2: `ANCHO_PLANO_MIN` y el ancho y alto del plano por ancho y cohorte, antes y después;
   - los md5 de `docs/` antes y después, los que sirve Pages (P3) y el hash del commit de P3;
   - los pendientes y los `# REVISAR`;
   - «lo que falló o sorprendió; si nada, decirlo explícitamente».

---

## 11. Excluidos (no se tocan en este encargo)

Q-39 (va en el encargo s35i), v30-5 (batería del motor sin versionar, s35i), Museo Sans en la suite, los
pendientes 8, 10, 12 y 13 del traspaso v34, CLAUDE.md (D2), y lo cerrado o aceptado en D35-11 y D35-12 (Q-61,
Q-62, Q-60, Q-56, Q-42, Q-29, Q-21). Si una tarea de este encargo los roza, se anotan como duda y no se
corrigen.

---

## Apéndice: plantilla del log

```markdown
# Log: pantallas angostas, centrado restante y fuente del PNG (s35h) (slep_simce_adecuado)

- Meta: <una línea>
- Fecha: <AAAA-MM-DD> · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: <hash de T0>
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: <...>
- Grafo y olas: <copiados de §5>
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando

## J. Juicio (lo rellena FASE L)

<!-- trece campos, una línea cada uno:
- Meta y resultado:
- Estado por tarea:
- Commits:
- Auditoría (FASE R):
- Invariantes:
- Cifras críticas:
- Decisiones autónomas de mayor riesgo:
- Desviaciones respecto del encargo:
- Dudas abiertas:
- Errores propios:
- Qué debe verificar el revisor por sí mismo:
- No publicado / queda al usuario:
- Ejecución:
-->

### FASE 0: log, punto de retorno y premisas
(Estado, Commits, Cambios sustantivos, Verificación con esperado/obtenido, Alcance, Regresión, Subagentes,
Bugs, Decisiones autónomas, Errores propios, Dudas)

### FASE M1 ... ### FASE P3 (una sección por tarea, en el orden en que cierran: M1, M2, M3, M4, V1, V2, PUB; P3 se anexa tras el push, autorización 8)

### FASE R: auditoría y reparación

## Cierre
1. Resumen · 2. Inventario de commits · 3. Tabla de auditoría · 4. Invariantes · 5. Decisiones del
usuario · 6. Estado de cifras · 7. Dudas y pendientes consolidados · 8. Errores propios consolidados ·
9. Notas para el revisor · 10. Estado de cierre
```
