# Log — Homogeneidad visual y quinto territorio

**Fecha:** 2026-08-26
**Encargo:** `50_documentacion/activa/encargos/encargo_homogeneidad_y_quinto_territorio.md`
**Archivo editado:** `30_procesamiento/33_motor_template.html` (único)
**Push:** no se hizo. El encargo termina con cinco commits locales sobre `main`.

---

## 1. FASE 0 — Medición (salida literal)

### `git status --short --branch`

```
## main...origin/main
 M 30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_homogeneidad_y_quinto_territorio.md
```

### `git log origin/main..HEAD --oneline`

```
(vacío)
```

### `git log --oneline -3`

```
1ccb4d9 chore(estado): destila v27 e instala campos de candado; abre sesion 28
31e35d7 docs(backlog): anexa delta s27, entradas 134-138
6a1c8b6 docs(suite): corrige terminologia entidad->territorio en documentar.R; rota snapshots de estructura
```

### Dependencias R

```
- The project is out-of-sync -- use `renv::status()` for details.
here 1.0.1
arrow 24.0.0
dplyr 1.2.0
jsonlite 2.0.0
```

### `grep -n "sub-eyebrow"`

```
494:.sub-eyebrow {
2127:            <span className="sub-eyebrow">Trayectoria histórica</span>
2131:            <span className="sub-eyebrow">Últimas 3 aplicaciones</span>
```

### `.sub-eyebrow`

```css
.sub-eyebrow {
  font-family: var(--font-display);
  font-weight: 700; font-size: var(--fs-overline);
  letter-spacing: var(--tracking-overline);
  color: var(--fg-3);
  padding-left: 2px; margin-bottom: 2px;
}
```

### `.sg-gse-eyebrow`

```css
.sg-gse-eyebrow {
  font-family: var(--font-display);
  font-weight: 700; font-size: var(--fs-overline);
  letter-spacing: var(--tracking-overline);
  color: var(--fg-3);
}
```

### `.sg-gse-name`

```css
.sg-gse-name {
  font-family: var(--font-display);
  font-weight: 800; font-size: var(--fs-h4);
  color: #0A3A5C;
  letter-spacing: -0.005em; line-height: 1.1; margin-top: 2px;
}
```

### Contadores

```
grep -c '" · " + SimceData.DEPE2_LABELS'  → 3
grep -n "MAX_ENTIDADES = "                → 1453:    const MAX_ENTIDADES = 4;
grep -c "repeat(4"                        → 2
```

### Contraste con lo esperado

| Medición | Esperado | Medido | Veredicto |
|---|---|---|---|
| Rama y archivo modificado | `main`, un solo `M` | `main`, un solo `M` + un `??` | Pasa, con nota (§4) |
| `git log origin/main..HEAD` | vacío | vacío | Pasa |
| Dependencias R | las 4 imprimen versión | las 4 imprimen versión | Pasa, con nota (§4) |
| Sufijo `DEPE2_LABELS` | 3 | 3 | Pasa |
| `MAX_ENTIDADES` | `= 4` | `= 4` | Pasa |
| `repeat(4` | 2 | 2 | Pasa |

---

## 2. Commits

### `7826f8e` — style(motor): migra escala tipografica a variables CSS, restaura .app-title a 30px

Sin edición. Commitea la migración tipográfica que ya venía en el árbol de
trabajo. `1 file changed, 10 insertions(+), 19 deletions(-)`.

### `d2f75ee` — fix(motor): elimina duplicacion de la dependencia en el nombre del territorio

- `entidadesPorDefecto()`: `name` pasa de `(c ? c.nom : cod) + " · " + depeLabel`
  a `(c ? c.nom : cod)`.
- Las tres construcciones de `name` en el alta desde el modal pierden el sufijo
  ` · <etiqueta>`: comuna (`c.nom`), región (`reg.nombre`) y nacional (`"Chile"`).
- `EntityChip`: se agrega la rama `region` al `meta`, con la forma que ya usa
  `slep`: `Región · ${entity.comunas.length} comunas`. Antes caía al `else` y el
  tipo se perdía.

`1 file changed, 6 insertions(+), 5 deletions(-)`.

**Verificación §5:**

| Comprobación | Esperado | Medido |
|---|---|---|
| `grep -c '" · " + SimceData.DEPE2_LABELS'` | 0 | **0** |
| `grep -n 'kind === "region"'` | aparece en `EntityChip` | línea 1564, junto a 2447/2773/2791/3338 preexistentes |

### `712a9e5` — style(motor): homogeneiza rotulos de seccion, etiquetas GSE y leyenda de graficos

- `.entities-count`: pasa de `font-size: var(--fs-caption)` en familia body a la
  familia display, `var(--fs-overline)` y `var(--tracking-overline)` de
  `.section-eyebrow`. Se diferencia solo por `font-weight: 500` y conserva
  `color: var(--fg-3)`.
- `.sg-gse-name`: `var(--fs-h4)` → `var(--fs-body)`. Conserva `color: #0A3A5C`.
- `.sub-eyebrow`: **no se tocó.** Ya coincidía con `.sg-gse-eyebrow` en las cinco
  propiedades pedidas (familia display, peso 700, `--fs-overline`,
  `--tracking-overline`, `--fg-3`); solo añade `padding-left` y `margin-bottom`,
  que son espaciado, no estilo tipográfico. El encargo instruye reportarlo y no
  tocarlo.
- `.hint-muted`: pierde los dos overrides (`color: var(--fg-3)` y
  `font-size: var(--fs-overline)`). Hereda los 14px de `.chart-hints`
  (`var(--fs-caption)`) y el `var(--fg-1)` de `.hint-item`. El `opacity: 0.45`
  de `.hint-low-n` no se tocó.

`1 file changed, 8 insertions(+), 3 deletions(-)`.

**Verificación §5:** las reglas tocadas usan solo variables `--fs-*`; ningún
literal `px` nuevo. `grep -o "font-size: *[0-9.]*px"` → listado vacío;
`grep -c "fontSize: *[0-9]"` → 0.

### `c69335c` — fix(motor): evita desborde del nombre en la tabla y en la exportacion SVG

**Defecto a.** `th.th-ent` y `td.td-ent` ganan `max-width: 260px`,
`white-space: normal` y `overflow-wrap: anywhere`. `min-width`, `z-index` y
`background` quedan como estaban.

**Defecto b.** En `construirSvgGraficos` se agrega el helper local `truncar(s,
maxChars)` (corta y añade `…`), junto a `el`/`txt`. Los presupuestos van como
constantes nombradas junto a las demás constantes de layout de la función, cada
una con su comentario de calibración:

```js
const MAX_CHARS_NOMBRE = 38; // aproximación calibrada a CELL_W = 340 (14px, peso 800)
const MAX_CHARS_META   = 46; // aproximación calibrada a CELL_W = 340 (10px)
```

Se aplican en `txt(truncar(ent.name, MAX_CHARS_NOMBRE), …)` y
`txt(truncar(meta, MAX_CHARS_META), …)`. Las declaraciones `"font-size": N` de
esos objetos no se tocaron (fuera de alcance por invariante).

`1 file changed, 21 insertions(+), 3 deletions(-)`.

### `51ed157` — feat(motor): permite comparar hasta 5 territorios

- `MAX_ENTIDADES`: `4` → `5`.
- El `alert` del tope pasa de literal a template string:
  `` `Máximo de comparación: ${MAX_ENTIDADES} territorios. Elimina uno antes de agregar otro.` ``
- `supergrid`: `repeat(4, minmax(0, 1fr))` → `` `repeat(${entities.length}, minmax(0, 1fr))` ``.
- `.entity-chip`: `max-width` 340px → 250px. `.entity-name` gana
  `overflow-wrap: anywhere`.

`1 file changed, 5 insertions(+), 4 deletions(-)`.

**Verificación §5:**

| Comprobación | Esperado | Medido |
|---|---|---|
| `grep -n "repeat(4"` | una sola ocurrencia, la de `.heat-scale-bar` | **1** — línea 2292, `.heat-scale-bar` |

---

## 3. FASE FINAL — Regeneración y verificación

`Rscript -e 'source(here::here("30_procesamiento","33_generar_html.R"))'` →
**exit 0**. Salida:

```
    OK: 40_salidas/motor_comparacion.html (2516 KB)
  Filas en JSON: 44975 · Comunas: 345 · Regiones: 16 · SLEPs: 36 (2337 RBDs)
  Establec.: 10945 RBDs · Años: 9 (2014–2025) · Peso HTML: 2516.3 KB
33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html
```

```
md5 -q 40_salidas/motor_comparacion.html  → 84aca866fabf543573d14cc88d1ef25d
ls -la                                    → -rw-r--r--@ 1 tomgc staff 2576679 Aug 26 10:59
```

| Criterio | Esperado | Medido | Veredicto |
|---|---|---|---|
| Script de generación | exit 0 | exit 0 | Pasa |
| `grep -c "fontSize: *[0-9]"` | 0 | **0** | Pasa |
| `grep -o "font-size: *[0-9.]*px"` | listado vacío | **vacío** | Pasa |
| `grep -c "MAX_ENTIDADES = 5"` | 1 | **1** | Pasa |
| `grep -c "repeat(4"` | 1 | **1** | Pasa |
| `git status --short` | vacío | solo el `??` del encargo | Pasa: el motor generado no aparece, el `.gitignore` es el declarado |

`git log --oneline -6`:

```
51ed157 feat(motor): permite comparar hasta 5 territorios
c69335c fix(motor): evita desborde del nombre en la tabla y en la exportacion SVG
712a9e5 style(motor): homogeneiza rotulos de seccion, etiquetas GSE y leyenda de graficos
d2f75ee fix(motor): elimina duplicacion de la dependencia en el nombre del territorio
7826f8e style(motor): migra escala tipografica a variables CSS, restaura .app-title a 30px
1ccb4d9 chore(estado): destila v27 e instala campos de candado; abre sesion 28
```

---

## 4. Decisiones ante ambigüedades

**a) Archivo untracked en FASE 0.** `git status` mostró, además del `M`
esperado, un `??`: el propio archivo de encargo, en la ruta que el encargo
declara como su destino en §0. La rama de detención cubre "más archivos
**modificados**"; un untracked no lo es, y detenerse por la presencia del
encargo que se está ejecutando lo haría inejecutable por construcción. Se
siguió. Como todos los `git add` fueron por ruta explícita (nunca `git add .`),
el archivo no entró en ningún commit y sigue untracked.

**b) `renv` out-of-sync.** El `Rscript` de FASE 0 imprimió
`The project is out-of-sync`. El criterio declarado —"las 4 dependencias
imprimen versión"— se cumplió. `renv::status()` (solo lectura, sin instalar
nada) atribuye el aviso a `openxlsx` (usado, no instalado, no registrado) y
`suitedoc` (instalado, no registrado); ninguno es dependencia de
`33_generar_html.R`, que solo usa `here`, `arrow`, `dplyr` y `jsonlite`. El
generador corrió con exit 0. Queda anotado como deuda de entorno ajena a este
encargo.

**c) Invariante de las 4 comunas por defecto con `MAX_ENTIDADES = 5`.**
`entidadesPorDefecto()` construye el estado inicial con
`slep.comunas.slice(0, MAX_ENTIDADES)`. Subir el tope a 5 podría haber roto el
invariante 🔒 de "el estado por defecto son las 4 comunas de Costa Central".
Se midió el parquet: el SLEP Costa Central tiene **exactamente 4 comunas**, así
que `slice(0, 5)` sigue devolviendo 4 y el invariante se preserva sin cambio
adicional. No se tocó `entidadesPorDefecto()` por este motivo.

**d) Constante huérfana en `entidadesPorDefecto()`.** Al quitar el sufijo,
`const depeLabel = SimceData.DEPE2_LABELS["5"];` quedó sin uso. Se eliminó en el
mismo commit 2, por ser residuo introducido por el propio cambio.

**e) Constante huérfana preexistente, no tocada.** `const depe2Label` en
`handleSave()` (rama `comuna`) ya estaba sin uso **antes** de este encargo: el
`grep` de FASE 0 la muestra como única ocurrencia. No la introdujo el commit 2 y
está fuera de la lista cerrada de autorizaciones de §3, así que **no se tocó**.
Queda anotada como candidata a limpieza en otro encargo.

**f) Regla `.hint-muted` vacía.** Quitar los dos overrides pedidos dejaba
`.hint-muted { }` sin declaraciones. Se eliminó la regla CSS completa en vez de
dejarla vacía. La clase se conserva en el JSX (`className="hint-item hint-muted"`)
como gancho semántico sin efecto visual, que es exactamente el resultado pedido:
que herede del contenedor.

---

## 5. Qué falló o sorprendió

Nada falló. Los cinco commits, las verificaciones de §5 y las seis de §6 pasaron
en el primer intento, sin retrocesos ni ediciones correctivas.

Tres cosas sorprendieron, ninguna bloqueante y las tres detalladas en §4: el
aviso de `renv` out-of-sync (ajeno a las dependencias del generador), el riesgo
latente de que el commit 5 rompiera el invariante de las 4 comunas por defecto
(descartado midiendo el parquet: Costa Central tiene exactamente 4), y las dos
constantes que quedaban huérfanas —una tratada, la otra preexistente y por eso
dejada intacta.

**Este log se deja sin commitear**, para revisión del titular.
