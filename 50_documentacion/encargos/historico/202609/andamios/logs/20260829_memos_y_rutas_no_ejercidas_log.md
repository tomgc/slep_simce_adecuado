# Log — Corrección de memos y auditoría de rutas no ejercidas

> **Encargo:** `50_documentacion/activa/encargos/encargo_memos_y_rutas_no_ejercidas.md`
> **Ejecutado:** 2026-08-29, Claude Code, modo autónomo secuencial, 0 subagentes.
> Este log queda sin trackear y sin commitear.

---

## 1. Resumen y veredicto por tarea

| Tarea | Veredicto | En una línea |
|---|---|---|
| T1 (memos) | **CONGELADA — insumo ausente** | La plantilla del working tree NO es la versión nueva: diff contra `HEAD` vacío, 4539 líneas (las de `a668951`), no 4551. Sin nada que cotejar ni commitear |
| T2a (CSV) | **CERRADA** | Ejecutada de verdad con Node v26.5.0: las seis comprobaciones PASAN |
| T2b (contrato PNG) | **CERRADA** | Las tres piezas comparten `{ svgStr, totalW, totalH, fnameBase }`; ciclo de object URLs completo en éxito y error |
| T2c | declarado | La descarga real no es observable sin navegador |
| T3 (siembra) | **CERRADA** | Exactamente 1 SLEP matchea (`Costa Central`, cod 503), 4 comunas, 73 RBDs |
| T4 (umbrales) | **CERRADA** | Dos columnas → una bajo 1016px; fila de territorio se parte bajo ≈414px (fórmula abajo); el SVG escala sin recorte pero el piso de 460px del grid desborda bajo ≈540px |
| Push | **OMITIDO** | T1 congelada: no hay commit que empujar (`HEAD` = `origin/main` = `a668951`) |

## 2. El gate de cotejo de base

`git -C $R diff -- 30_procesamiento/33_motor_template.html` → **salida vacía** (exit 0).
No hay bloques que atribuir: el archivo del working tree es byte a byte el de `HEAD`.
Combinado con `wc -l` = 4539 (esperado: 4551) y `status` sin ` M` en la plantilla, el
diagnóstico es que **el reemplazo a mano no llegó al working tree** (no se guardó, o se
guardó en otra ruta u otra copia). Es el insumo equivocado; T1 se congela sin commit.
El gate en sí no encontró bloques ajenos — no había bloques en absoluto.

## 3. Por tarea: salidas literales y tablas

### FASE 0

```
--- status ---
?? 50_documentacion/activa/encargos/encargo_memos_y_rutas_no_ejercidas.md
--- rev-parse ---
a66895139b1cc5b2568b52f01bb10f34d829b3da
a66895139b1cc5b2568b52f01bb10f34d829b3da
--- wc -l ---
    4539 /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
--- md5 docs ---
d440aa6e6236fb20c40e9e4269f4e46f
--- md5 motor ---
d440aa6e6236fb20c40e9e4269f4e46f
--- node ---
v26.5.0
--- diff contra HEAD ---
(vacío, exit 0)
--- no regresion ---
text-transform -> 0   sembradas -> 0   TRASPASO {s -> 1   ALTO_MIN_ROTULO -> 2
```

| Medición | Esperado | Medido |
|---|---|---|
| `status` | ` M` plantilla + `??` del encargo y su log | **sin ` M`**; solo `??` del encargo (el log aún no existía) — parte del insumo ausente |
| `rev-parse` | ambos `a668951` | ambos ✓ |
| `wc -l` | 4551 | **4539** ✗ — versión de `a668951` |
| md5 docs y motor | ambos `d440aa6e6236fb20c40e9e4269f4e46f` | ambos ✓ |
| `node --version` | versión o AUSENTE | v26.5.0 ✓ (T2a se ejecuta de verdad) |
| no regresión | 0, 0, 1, ≥1 | 0, 0, 1, 2 ✓ (controles en §8) |

Ningún **otro** archivo versionado modificado: el DETENTE de la tabla no aplica al resto;
la anomalía es exclusivamente la ausencia del reemplazo, que congela T1 y solo T1.

### T1

No ejecutada más allá del gate: sin `git add`, sin `commit`, sin `Rscript`, sin copia a
`/tmp`. El motor generado conserva `d440aa6e6236fb20c40e9e4269f4e46f` (§9).

### T2a — ejecución real del CSV

Función extraída literal: `sed -n '3361,3398p'` de la plantilla → `/tmp/t2a_funcion_extraida.js`
(38 líneas, de `function exportarPanoramaCSV({ entity, nivel }) {` a su cierre).
Arnés: `/tmp/t2a_arnes.js` (§4). Resultado literal:

```
1 BOM. PASA — primeros codepoints: U+FEFF U+74
2 separador ;. PASA — header con 15 campos separados por ';' (y sin comas)
3 campos por fila. PASA — header=15; filas=15,15,15,15,15,15
4 decimales con coma. PASA — fila 2018 contiene '7,1' y '40,9': true; algun punto decimal residual: false
5 sin dato = vacio. PASA — filas 2022: 2; sin NaN/undefined/null: true; campos 7-14 vacios: true
6 preliminar 1/0. PASA — valores distintos: 0,1
NOMBRE: simce_panorama_SLEP_Costa_Central_2__Medio.csv
```

| # | Comprobación | Resultado |
|---|---|---|
| 1 | empieza con BOM `﻿` | PASA (U+FEFF) |
| 2 | separador `;` | PASA (15 campos, sin comas en el header) |
| 3 | campos por fila = header | PASA (15 en las 6 filas de datos) |
| 4 | decimales con coma | PASA (`7,1`, `40,9`; cero puntos decimales residuales) |
| 5 | año sin dato → campos vacíos | PASA (2 filas 2022; sin `NaN`/`undefined`/`null`; campos 7-14 vacíos) |
| 6 | preliminar `1`/`0` | PASA (valores observados: exactamente `0` y `1`) |

Nota de lectura: `52` sin decimal en la fila 2018 es un entero legítimo
(`String(52)` no tiene punto que reemplazar), no un fallo del formato.

### T2b — contrato del rasterizador

Ver §5.

### T3 — siembra

Ver §6. Salida literal:

```
SLEPs en el catalogo: 36
SLEPs cuyo nombre normalizado contiene 'costa central': 1
   503 : Costa Central -> costa central
Comunas del SLEP: 4
Codigos de comuna: 5103, 5105, 5107, 5109
Nombres de comuna: CONCÓN, PUCHUNCAVÍ, QUINTERO, VIÑA DEL MAR
RBDs del SLEP: 73
Control del normalizador: Chiloé -> chiloe; Aysén -> aysen; Valle Diguillín -> valle diguillin
```

| Medición | Esperado | Medido |
|---|---|---|
| SLEPs con `costa central` | exactamente 1 | 1 (cod 503, `Costa Central`) ✓ |
| comunas | 4 | 4 (5103, 5105, 5107, 5109) ✓ |
| RBDs | ≥1 | 73 ✓ |

### T4 — umbrales

Ver §7.

### FASE FINAL

```
?? 50_documentacion/activa/encargos/encargo_memos_y_rutas_no_ejercidas.md
a66895139b1cc5b2568b52f01bb10f34d829b3da
a66895139b1cc5b2568b52f01bb10f34d829b3da
d440aa6e6236fb20c40e9e4269f4e46f   (docs/index.html)
d440aa6e6236fb20c40e9e4269f4e46f   (motor generado)
```

Push omitido y dicho: T1 congelada, `HEAD` ya igual a `origin/main`.

## 4. T2a: script efímero íntegro y CSV capturado

`/tmp/t2a_funcion_extraida.js` = líneas 3361-3398 de la plantilla, sin alterar.
`/tmp/t2a_arnes.js`:

```js
// T2a — Arnés efímero para ejecutar exportarPanoramaCSV fuera del navegador.
// La función bajo prueba se carga LITERAL desde /tmp/t2a_funcion_extraida.js
// (sed 3361,3398p de 33_motor_template.html). Dobles: solo lo que no existe
// fuera del navegador (descargarBlob, Blob) y la serie sintética que exige el
// encargo (generateSeriesGseCombinado). DATA.meta.pruebas lleva los valores
// reales del generador (33_generar_html.R: lect=Lectura, mate=Matemática).
"use strict";
const fs = require("fs");

let capturado = null;
let fnameCapturado = null;

class Blob {
  constructor(parts, opts) {
    this.text = parts.join("");
    this.opts = opts;
  }
}

function descargarBlob(blob, fname) {
  capturado = blob.text;
  fnameCapturado = fname;
}

const DATA = { meta: { pruebas: { lect: "Lectura", mate: "Matemática" } } };

const SERIE_SINTETICA = [
  { year: 2018, pct: 7.1, pct_ele: 40.9, pct_ins: 52, n_eval: 471,
    n_estab: 6, n_adec: 33, n_ele: 193, n_ins: 245, preliminar: false },
  { year: 2022, pct: null, pct_ele: null, pct_ins: null, n_eval: null,
    n_estab: null, n_adec: null, n_ele: null, n_ins: null, preliminar: false },
  { year: 2025, pct: 55.5, pct_ele: 30.3, pct_ins: 14.2, n_eval: 380,
    n_estab: 5, n_adec: 211, n_ele: 115, n_ins: 54, preliminar: true },
];

const SimceData = {
  generateSeriesGseCombinado: (entity, nivel, prueba) => SERIE_SINTETICA,
};

// La fuente se evalúa como expresión (entre paréntesis) porque bajo
// "use strict" un eval directo no exporta declaraciones a este ámbito.
// El texto de la función no se altera.
const fuente = fs.readFileSync("/tmp/t2a_funcion_extraida.js", "utf8");
const exportarPanoramaCSV = eval("(" + fuente + ")");

const entity = { name: "SLEP Costa Central", kind: "slep" };
exportarPanoramaCSV({ entity, nivel: "2° Medio" });
// ... (comprobaciones 1-6; salida literal en §3)
```

(El arnés completo, con las seis comprobaciones, quedó en `/tmp/t2a_arnes.js`;
arriba está la parte que define los dobles y ejecuta. Primer intento con `eval`
directo falló con `ReferenceError` por el modo estricto; la corrección fue del
arnés, no de la función bajo prueba.)

CSV capturado, literal (BOM mostrado como `<BOM>`):

```
<BOM>territorio;tipo;nivel;prueba;gse;anio;pct_adecuado;pct_elemental;pct_insuficiente;n_evaluados;n_adecuado_derivado;n_elemental_derivado;n_insuficiente_derivado;n_establecimientos;preliminar
SLEP Costa Central;slep;2° Medio;Lectura;combinado;2018;7,1;40,9;52;471;33;193;245;6;0
SLEP Costa Central;slep;2° Medio;Lectura;combinado;2022;;;;;;;;;0
SLEP Costa Central;slep;2° Medio;Lectura;combinado;2025;55,5;30,3;14,2;380;211;115;54;5;1
SLEP Costa Central;slep;2° Medio;Matemática;combinado;2018;7,1;40,9;52;471;33;193;245;6;0
SLEP Costa Central;slep;2° Medio;Matemática;combinado;2022;;;;;;;;;0
SLEP Costa Central;slep;2° Medio;Matemática;combinado;2025;55,5;30,3;14,2;380;211;115;54;5;1
```

## 5. T2b: las cinco respuestas, con archivo y línea

Funciones extraídas a `/tmp` con `sed` y patrones anclados dentro de cada una
(`/tmp/t2b_rasterizarSvgAPng.js` = L3007-3053; `/tmp/t2b_construirSvgGraficos.js` =
L2772-2979; `/tmp/t2b_construirSvgPanorama.js` = L3286-3350; `/tmp/t2b_descargarBlob.js` =
L2981-2988; todas de `30_procesamiento/33_motor_template.html`).

1. **`rasterizarSvgAPng` destructura:** `{ svgStr, totalW, totalH, fnameBase }` (L3007).
2. **`construirSvgGraficos` devuelve:** `{ svgStr, totalW, totalH, fnameBase }` (L2978).
3. **`construirSvgPanorama` devuelve:** `{ svgStr, totalW, totalH, fnameBase }` (L3349).
4. **¿Coinciden?** **Sí, las tres listas son idénticas.** Ninguna clave esperada falta:
   `exportarGraficosPNG` (L3055) y `exportarPanoramaPNG` (L3357) pasan el objeto entero
   de su constructor al rasterizador; el contrato es coherente.
5. **Object URLs:** anclado por función:
   - `descargarBlob` (L2981-2988): 1 `createObjectURL` (L2982), 1 `revokeObjectURL`
     (L2987), ruta única y síncrona (`a.click()` entre medio).
   - `rasterizarSvgAPng`: 1 `createObjectURL` (L3009); liberación por `liberarUrl`
     idempotente (L3012-3015, flag `urlLiberada`) invocada en **las cuatro salidas**:
     tope de superficie (L3024), camino feliz tras `drawImage` (L3038), `catch` (L3044)
     y `onerror` (L3049). Ninguna ruta deja la URL viva.

## 6. T3: script íntegro y nombres

`/tmp/t3_siembra.R`:

```r
# T3 — Réplica de la búsqueda de la siembra por defecto del panorama contra el
# dato real. Normalización IDÉNTICA a la de entidadesPorDefecto
# (33_motor_template.html L4269): toLowerCase -> NFD -> quitar diacríticos
# (rango combinante U+0300-U+036F) -> includes("costa central").
suppressMessages({ library(arrow); library(dplyr); library(stringi) })

sleps <- read_parquet("/Users/tomgc/Projects/slep_simce_adecuado/40_salidas/intermedios/sleps_chile.parquet")

norm_js <- function(s) {
  gsub("[̀-ͯ]", "", stri_trans_nfd(tolower(s)), perl = TRUE)
}

catalogo <- sleps |> distinct(cod_slep, nombre_slep)
catalogo$norm <- norm_js(catalogo$nombre_slep)
match_cc <- catalogo |> filter(grepl("costa central", norm, fixed = TRUE))
# ... (conteos de comunas y RBDs del match; control del normalizador con
#      nombres reales con tilde; salida literal en §3)
```

La función del motor leída para la réplica: `entidadesPorDefecto`
(L4268-4290; `norm` en L4269, búsqueda en L4270; el segundo uso idéntico en
L4300-4301 es la siembra del territorio del panorama). Encontrado: **`Costa
Central` (cod 503)** — único match; comunas 5103, 5105, 5107, 5109 (Concón,
Puchuncaví, Quintero, Viña del Mar); 73 RBDs. Control del normalizador con
tildes reales: `Chiloé → chiloe`, `Aysén → aysen`, `Valle Diguillín → valle diguillin`.

## 7. T4: aritmética de umbrales

Valores extraídos del `<style>` (selector → valor → línea aproximada por bloque):

| Selector | Valor relevante |
|---|---|
| `html, body` | `margin: 0; padding: 0` (L107) |
| `.app-main` | `max-width: 1600px; width: 100%`, sin padding |
| `.panorama-section` | `padding: 22px 40px 8px` → 40px por lado |
| `.territorio-row` | `padding: 16px 40px 0`, `flex-wrap: wrap`, `gap: 14px` |
| `.view-tabs-inner` | `padding: 0 40px`, `max-width: 1600px`, `flex-wrap: wrap` |
| `.hero-card` | `margin: 16px 40px 0`, `flex-wrap: wrap` |
| `.panorama-grid` | `grid-template-columns: repeat(auto-fit, minmax(460px, 1fr)); gap: 16px` |
| `.territorio-select` | `flex: 0 1 440px; min-width: 240px` |
| `.panorama-svg` | `width: 100%; height: auto; overflow: visible` |

No hay media queries que toquen estos selectores (las únicas dos del archivo, L730 y
L794, afectan `heat-legend` y `notes-grid`).

**1. Dos columnas → una (`.panorama-grid`).**
Ancho interno de la sección = viewport − 40 − 40 (bajo 1600px de viewport, `.app-main`
no limita). Dos pistas `auto-fit` de mínimo 460px + gap 16 caben cuando
`interno ≥ 460 × 2 + 16 = 936`. Umbral: `viewport = 936 + 80 = **1016px**`.
Bajo 1016px de ventana el panorama pasa a una columna.

**2. La fila del territorio se parte (`.territorio-row`).**
Contenido: label `Territorio` (ancho intrínseco `L`, no expresable en CSS) + gap 14 +
botón (base 440, encogible hasta `min-width: 240`). Padding lateral 80.
- El botón empieza a encogerse bajo `viewport = L + 14 + 440 + 80 = L + 534`.
- La fila se parte (por `flex-wrap: wrap`) cuando ni con 240px cabe:
  `viewport < L + 14 + 240 + 80 = **L + 334**`.
Con `L ≈ 80px` (9 glifos a `--fs-body` en peso 700, estimación declarada — es render,
no CSS), el quiebre ronda los **414px**; el encogimiento empieza cerca de los 614px.
La fórmula es exacta; el número final depende de `L`.

**3. Escalado del SVG y anchos fijos.**
`.panorama-svg` tiene `width: 100%`, `height: auto` y el `<svg>` recibe
`viewBox 0 0 520 328` con `preserveAspectRatio xMidYMid meet` (PanoramaChart):
**escala proporcionalmente sin recorte** dentro de su celda (y `overflow: visible`
tolera desbordes menores de texto). El ancho fijo en píxeles que sí existe es el
**piso de 460px de `minmax(460px, 1fr)`**: la pista del grid no baja de 460px, así que
bajo `460 + 80 = **540px** de viewport la celda desborda horizontalmente` su
contenedor (el SVG interior sigue escalando, pero la celda ya no cabe). Ese es el
elemento con ancho fijo, no el SVG.

## 8. Controles positivos

| Cero | Comando | Control | Resultado |
|---|---|---|---|
| `text-transform` = 0 (plantilla) | `grep -c` | mismo patrón sobre `20260829_rescate_rotulos_y_precedente_c3_log.md` (cita la regresión) | `4` ✓ |
| `sembradas` = 0 (plantilla) | `grep -c` | mismo archivo | `5` ✓ |
| (T2a no produjo ceros de patrón; T3 dio 1, no 0; el control del normalizador de T3 — tildes reales → sin tilde — cubre el instrumento de normalización) | | | |

## 9. Verificación de invariantes

| Invariante | Veredicto | Evidencia |
|---|---|---|
| `docs/index.html` intacto | PASA | `md5 -q` en FASE 0 y FASE FINAL: `d440aa6e6236fb20c40e9e4269f4e46f` ambos |
| T2-T4 no escriben en el repo | PASA | todos los scratch en `/tmp` (`t2a_*`, `t2b_*`, `t3_siembra.R`); `status` final sin ` M` |
| T1 sin ediciones | PASA (vacuo) | T1 congelada antes de todo; ni `add` ni `commit` ni regeneración (md5 del motor sin cambiar) |
| D3 vendorizado intocado | PASA | nada se escribió en el árbol |
| `status` antes de cada `git add`; nunca `git add .` | PASA (vacuo) | no hubo ningún `git add` |
| Un solo push, solo del commit de T1 | PASA | push omitido: no existe el commit de T1; `HEAD` = `origin/main` = `a668951` |

## 10. Dudas

**Duda 1 — T1 congelada (la única).**
- **Contexto:** el mensaje de reanudación afirma que la plantilla fue reemplazada por
  una versión de 4551 líneas; el working tree tiene la de `a668951` (4539 líneas, diff
  vacío, sin ` M` en status).
- **Pregunta cerrada:** ¿el reemplazo se guardó en disco, y en esta ruta
  (`30_procesamiento/33_motor_template.html` de `slep_simce_adecuado`)? Si el archivo
  quedó en otra carpeta, sin guardar en el editor, o en otra copia del repo, ahí está
  la explicación; en cuanto el working tree muestre ` M` con 4551 líneas, T1 se
  re-ejecuta desde el gate.
- **Qué quedó bloqueado:** el commit de memos, la regeneración y el push. T2-T4 no
  dependían y están cerradas.

## 11. Lo que quedó sin verificar

- **La descarga real de los tres exportadores** (`Blob` verdadero, `canvas`,
  `toBlob`, el diálogo del navegador): T2 probó contenido y contrato, no descarga.
- **El render en pantalla estrecha:** los umbrales de T4 son aritmética de CSS, no
  render; el ancho real del label `Territorio` (la `L` de §7.2) es de render.
- **La corrección de memos en sí** (T1): no existe en el working tree; nada que
  verificar todavía.
- **El CSV con datos reales del motor:** T2a corrió con la serie sintética exigida por
  el encargo; la serie real pasa por `generateSeriesGseCombinado`, cuya aritmética ya
  quedó verificada en la corrida de dudas s29, pero el CSV con datos reales no se
  generó aquí.

## Auto-auditoría

1. **¿Alguna rama de detención se disparó en el camino nominal?** Sí: la de FASE 0
   por insumo ausente (plantilla sin reemplazar). Estaba bien escrita — el gate de
   cotejo existe exactamente para no commitear lo que no corresponde — y este caso
   (diff vacío) es su variante más benigna: no había ni siquiera algo que atribuir.
2. **¿Cada cero tiene su control positivo?** Sí (§8).
3. **¿Cada patrón anclado en su función?** Sí: T2a y T2b extrajeron las funciones a
   `/tmp` con `sed` y todos los greps de contrato corrieron sobre los extractos; los
   únicos greps de archivo completo fueron los de no-regresión de FASE 0, cuya
   afirmación es global por diseño ("no está en ninguna parte del archivo").
4. **¿Alguna conclusión afirma más de lo que midió?** La frontera quedó dicha: T2a
   prueba el contenido del CSV con una serie sintética, no la descarga ni el dato real
   (§11); T2b prueba el contrato de claves, no el PNG resultante; T4 da fórmulas
   exactas y separa la única magnitud de render (`L`) como estimación declarada.

---

# REANUDACIÓN — T1 (misma fecha, corrida posterior)

El titular reemplazó la plantilla de nuevo; T2-T4 no se repitieron. La duda 1 de §10
queda **resuelta**: el reemplazo ahora sí está en el working tree.

## FASE 0 — Remedición y gate

Salida literal:

```
--- status ---
 M 30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_memos_y_rutas_no_ejercidas.md
?? 50_documentacion/andamios/logs/20260829_memos_y_rutas_no_ejercidas_log.md
--- rev-parse ---
a66895139b1cc5b2568b52f01bb10f34d829b3da   (HEAD y origin/main)
--- wc -l ---
    4551 30_procesamiento/33_motor_template.html
--- md5 docs ---
d440aa6e6236fb20c40e9e4269f4e46f
--- diff ---
(NO vacío; dos hunks, transcritos abajo)
```

| Medición | Esperado | Medido |
|---|---|---|
| `status` | ` M` plantilla + `??` de encargo y log | exactamente eso ✓ |
| `rev-parse` | ambos `a668951` | ambos ✓ |
| `wc -l` | 4551 | 4551 ✓ |
| md5 docs | `d440aa6e...` | idéntico ✓ |
| diff | no vacío | dos hunks ✓ |

**Gate de cotejo: PASA.** El diff de la fuente son dos hunks, ambos dentro de
`PanoramaSection` (contexto: el memo de disponibilidad de datos sobre
`generateSeriesGseCombinado`, L3468, y el memo de la meta de la tarjeta, L3494).
Cada hunk = (a) la lista de dependencias del `useMemo` —
`[id, kind, depe2, nivel]` → `[id, kind, depe2, rbd, comunas.join(","), rbds.join(","), nivel]`,
la misma lista que usa `PanoramaChart` — más (b) el comentario que la explica
(el modal conserva `editing?.id` al cambiar de territorio, así que depender solo
del id dejaría la meta congelada en el territorio anterior). Ningún bloque fuera
de (a)/(b).

## T1

```
[main 04d9523] fix(motor): incluye la composicion del territorio en las dependencias de los memos del panorama
 30_procesamiento/33_motor_template.html | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)
```

Regeneración: `Rscript 33_generar_html.R` → OK (aviso renv esperado; peso 2561.9 KB).

| Medición | Esperado | Medido |
|---|---|---|
| commit | solo la plantilla | `04d9523`, 1 archivo ✓ |
| md5 copia previa (`/tmp/motor_previo_memos.html`) | `d440aa6e...` | idéntico ✓ |
| md5 build nuevo | distinto | `f3f787025e05994ce2f089a261b0b38c` ✓ |
| diff del build | solo dependencias + comentario | dos bloques (3473c3473,3479 y 3499c3505,3511), transcritos abajo, idénticos al diff de la fuente; sin payload, sin D3, sin CSS ✓ |
| `status` | sin el motor (ignorado) | solo los `??` del encargo y este log ✓ |
| md5 `docs/index.html` | sin cambiar | `d440aa6e6236fb20c40e9e4269f4e46f` ✓ |

Diff del build, íntegro:

```diff
3473c3473,3479
<       }, [entity && entity.id, entity && entity.kind, entity && entity.depe2, nivel]);
---
>       // Las dependencias incluyen la composición del territorio, no solo su id:
>       // al cambiar de territorio el modal conserva el id (`editing?.id`), así que
>       // depender del id dejaría la meta y el estado vacío en el valor anterior.
>       // Es la misma lista que usa PanoramaChart, por la misma razón.
>       }, [entity && entity.id, entity && entity.kind, entity && entity.depe2,
>           entity && entity.rbd, ((entity && entity.comunas) || []).join(","),
>           ((entity && entity.rbds) || []).join(","), nivel]);
3499c3505,3511
<       }, [entity && entity.id, entity && entity.kind, entity && entity.depe2, nivel]);
---
>       // Las dependencias incluyen la composición del territorio, no solo su id:
>       // al cambiar de territorio el modal conserva el id (`editing?.id`), así que
>       // depender del id dejaría la meta y el estado vacío en el valor anterior.
>       // Es la misma lista que usa PanoramaChart, por la misma razón.
>       }, [entity && entity.id, entity && entity.kind, entity && entity.depe2,
>           entity && entity.rbd, ((entity && entity.comunas) || []).join(","),
>           ((entity && entity.rbds) || []).join(","), nivel]);
```

## FASE FINAL

Push: `a668951..04d9523  main -> main`. Verificación: `HEAD` = `origin/main` =
`04d9523fe81d40b4a60238c7473a8538f21ae740`; `docs/index.html` en
`d440aa6e6236fb20c40e9e4269f4e46f` (sin desplegar — el gate visual del titular
es previo a la publicación); `status` sin versionados modificados.

## Auto-auditoría de la reanudación

1. Ninguna rama de detención se disparó: el gate pasó con los dos bloques
   esperados y nada más.
2. Sin ceros nuevos que controlar (el diff no vacío es un positivo).
3. La atribución se hizo sobre los hunks del diff (fuente y build), anclada por
   contexto de función (`PanoramaSection`), no por barrido del archivo.
4. Lo publicado es el fix en la fuente y su build local; que la meta de la
   tarjeta se actualice al cambiar territorio es render y queda para el gate
   visual del titular, previo al despliegue en otra corrida.

---

# CORRIDA POSTERIOR — Selección única, reorden del selector y mayúsculas (misma fecha)

Tercer reemplazo a mano de la plantilla en esta sesión: versión de **4582** líneas
con tres cambios además de los dos previstos originalmente (la instrucción de la
corrida deroga explícitamente el esperado anterior de 4562).

## FASE 0 — Medición y gate de cinco categorías

Salida literal:

```
--- status ---
 M 30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_memos_y_rutas_no_ejercidas.md
?? 50_documentacion/andamios/logs/20260829_memos_y_rutas_no_ejercidas_log.md
--- rev-parse ---
04d9523fe81d40b4a60238c7473a8538f21ae740   (HEAD y origin/main)
--- wc -l ---
    4582
--- md5 docs / motor ---
d440aa6e6236fb20c40e9e4269f4e46f / f3f787025e05994ce2f089a261b0b38c
--- conteos ---
TRASPASO {s -> 0   (control positivo: 2 en 20260829_rescate_rotulos_y_precedente_c3_log.md)
aNombrePropio -> 4 (esperado ≥4)
--- diff ---
(NO vacío; nueve hunks)
```

Todas las mediciones en su estado esperado.

**Gate: PASA.** Atribución de los nueve hunks de la fuente:

| Hunk (línea vieja) | Contenido | Categoría |
|---|---|---|
| `@@ -3397` | `CONECTORES_NOMBRE` + `function aNombrePropio` con su comentario | (d) |
| `@@ -3410` | `aNombrePropio(entity.com)` en estab + `aNombrePropio(reg.nombre)` en comuna, con comentario | (d) |
| `@@ -3420` | `aNombrePropio(c ? c.nom : cod)` en la lista de comunas | (d) |
| `@@ -3436` | `NIVEL` → `Nivel` en `hero-card-control-label` | (e) |
| `@@ -3525` | `TerritorioSelect` pasa sobre `PanoramaHero` en `PanoramaSection` | (c) |
| `@@ -3818` | `toggleSel` de AddEntityModal: con `maxSel === 1` reemplaza en vez de bloquear (deselección prohibida solo en edición), con comentarios | (a) |
| `@@ -3994` | `bloqueado` de la lista de regiones gana `maxSel > 1 &&` | (b) |
| `@@ -4079` | `bloqueado` de la lista de SLEP, ídem | (b) |
| `@@ -4092` | `TRASPASO {s.anio_traspaso}` → `Traspaso {s.anio_traspaso}` | (e) |

Nota de continuidad: `Nivel` y `Traspaso` son los mismos rótulos de la regresión
revertida en la corrida del rescate, ahora reintroducidos por la vía correcta
(cambio de markup sin `text-transform` en CSS — el conteo de `text-transform`
sigue siendo el del template publicado) y esta vez **amparados por el gate**
(categoría e, explícita).

## FASE 1 — Vía elegida: commit único

`git add -p` es interactivo y este entorno no admite flags interactivos, así que
se tomó la **segunda vía** del encargo (declarada, no improvisada): un commit con
el mensaje combinado.

```
[main d4e3017] fix(motor): corrige la seleccion unica, reordena el selector sobre el banner y elimina mayusculas sostenidas
 30_procesamiento/33_motor_template.html | 47 +++++++++++++++++++++++++++------
 1 file changed, 39 insertions(+), 8 deletions(-)
```

Único archivo: la plantilla. Tras el commit, ningún versionado modificado.

## FASE 2 — Regeneración y verificación

| Medición | Esperado | Medido |
|---|---|---|
| md5 copia previa (`/tmp/motor_previo_orden.html`) | `f3f787025e05994ce2f089a261b0b38c` | idéntico ✓ |
| md5 build nuevo | distinto | `c9747962e7f9cc8179de3a717f66f9af` ✓ |
| diff del build | mismos bloques que la fuente; sin payload/D3/CSS | 13 rangos que mapean 1:1 a los nueve hunks (el reorden aparece como par `3529a3550`+`3532d3552`; el helper como `3399a3400,3417`) ✓ |
| `TRASPASO {s` en build | 0 con control | 0; control: 2 en el log del rescate ✓ |
| `status` | sin el motor (ignorado) | solo los `??` del encargo y este log ✓ |
| md5 `docs/index.html` | `d440aa6e...` sin cambiar | idéntico ✓ |

Atribución del diff del build (rangos → categoría): `3399a3400,3417`,
`3407c3425`, `3414a3433,3434`, `3416c3436`, `3425c3445` → (d);
`3441c3461` → (e) Nivel; `3529a3550`+`3532d3552` → (c) reorden;
`3822a3843,3846`+`3823a3848,3854` → (a) toggleSel;
`3999c4030`, `4084c4115` → (b) bloqueado; `4097c4128` → (e) Traspaso.
Ningún rango toca el payload base64, el D3 vendorizado ni CSS.

## FASE FINAL

Push: `04d9523..d4e3017  main -> main`. Verificación: `HEAD` = `origin/main` =
`d4e3017cf8400858126240163c7dd290586939a2`; `docs/index.html` en
`d440aa6e6236fb20c40e9e4269f4e46f` (sin desplegar: el gate visual del titular es
previo); `status` sin versionados modificados.

## Auto-auditoría de la corrida

1. Ninguna rama de detención se disparó: el gate pasó con los nueve hunks dentro
   de las cinco categorías.
2. El único cero (`TRASPASO {s`, en fuente y en build) llevó su control positivo
   en ambas mediciones (2 apariciones en el log del rescate).
3. La atribución se hizo hunk a hunk sobre los dos diffs, anclada por el contexto
   de función que el propio diff muestra.
4. Lo probado es el patrón en la fuente y su build; el comportamiento del modal
   (reemplazo al hacer clic con cupo 1) y el orden visual selector→banner son
   render y quedan para el gate visual del titular.

---

# DESPLIEGUE — Gate visual aprobado (misma fecha, corrida posterior)

El titular aprobó el gate visual de los cuatro cambios (reemplazo en el modal,
selector sobre el banner, nombres propios, meta que se actualiza) y autorizó el
despliegue.

## FASE 0 — Medición

```
--- status ---
?? 50_documentacion/activa/encargos/encargo_memos_y_rutas_no_ejercidas.md
?? 50_documentacion/andamios/logs/20260829_memos_y_rutas_no_ejercidas_log.md
--- rev-parse ---
d4e3017cf8400858126240163c7dd290586939a2   (HEAD y origin/main)
--- md5 motor ---
c9747962e7f9cc8179de3a717f66f9af           (el artefacto revisado; sin regenerar)
--- md5 docs ---
d440aa6e6236fb20c40e9e4269f4e46f
```

Todo en estado esperado; los únicos sin trackear son el encargo y este log.

## FASE 1 — Despliegue por copia íntegra

Tras `cp`, ambos md5 dan la misma cadena `c9747962e7f9cc8179de3a717f66f9af`.

```
[main 3b17b9b] deploy(docs): publica el reorden del selector, los nombres propios y la seleccion unica
 docs/index.html | 63 ++++++++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 53 insertions(+), 10 deletions(-)
```

Único archivo: `docs/index.html`. El stat acumula los dos fixes pendientes desde
el despliegue anterior (`d440aa6e`, previo a los builds de memos y de esta
corrida): las dependencias de los memos (`04d9523`) y la selección única +
reorden + nombres propios (`d4e3017`).

## FASE FINAL

Push: `d4e3017..3b17b9b  main -> main`. Verificación: `HEAD` = `origin/main` =
`3b17b9b0c607f4d4dfeef598b1cb75745db0a7f4`; `docs/index.html` en
`c9747962e7f9cc8179de3a717f66f9af`; `status` sin versionados modificados.

Nada falló ni sorprendió: las tres fases en sus estados esperados al primer
intento. La confirmación byte a byte contra el servidor de Pages, cuando
reconstruya, es el mismo `curl` + `cmp` de T1 de la corrida de dudas, esperando
ahora `c9747962e7f9cc8179de3a717f66f9af`.
