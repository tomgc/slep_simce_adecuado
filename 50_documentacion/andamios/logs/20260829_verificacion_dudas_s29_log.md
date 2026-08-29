# Log — Verificación de dudas abiertas de la sesión 29

> **Encargo:** `50_documentacion/activa/encargos/encargo_verificacion_dudas_s29.md`
> **Ejecutado:** 2026-08-29, Claude Code, sesión limpia, modo autónomo secuencial, 0 subagentes.
> **Naturaleza:** solo lectura. Este log es el único archivo creado; queda sin trackear y sin commitear.

---

## 1. Resumen

- **T1 (Pages sirve el build): CERRADA.** El sitio publicado entrega hoy, byte a byte, el mismo `docs/index.html` de `origin/main` (`cmp` → `IDENTICOS`).
- **T2 (franjas sin rótulo): CERRADA.** El umbral derivado del código es 7,0093 puntos porcentuales. No es hipótesis de laboratorio: 1.408 de 11.783 puntos comunales (11,9%) y 189 de 1.296 puntos SLEP (14,6%) tienen al menos una franja dibujada sin rótulo. La franja muda es casi siempre **Adecuado** (1.529 de 1.614 franjas afectadas). Región y nacional: 0 afectados.
- **T3 (xmlns duplicado): PARCIAL.** El patrón está en el código: `construirSvgGraficos` crea el raíz con `createElementNS` **y** fija `xmlns` a mano **y** serializa con `XMLSerializer`; `construirSvgPanorama` no fija `xmlns` (y su comentario documenta el porqué). Lo que no se puede probar desde aquí: la cadena real que emite el serializador del navegador. Esa frontera la declara el propio encargo.
- **T4 (motor autocontenido): CERRADA, con resultado contrario al esperado.** El motor **no** es autocontenido: hay **tres cargas reales de red al abrirse** — React 18.3.1, ReactDOM 18.3.1 y Babel standalone 7.29.0 desde `unpkg.com`, con hashes SRI (decisión documentada de la auditoría B4, s13, en comentario del propio HTML). Las tres son candidatas a la causa del error "Unsafe attempt to load URL"; la hipótesis del origen `file://` no gana el peso que el estado esperado anticipaba.
- **Congeladas: ninguna.**

## 2. Veredicto por duda

| Duda | Veredicto | Evidencia en una línea |
|---|---|---|
| ¿GitHub Pages sirve el build desplegado? | CERRADA | `cmp /tmp/pages_index.html docs/index.html` → `IDENTICOS`; md5 descargado `f00e9126b86fc703b001e55080de0969` |
| ¿Cuántas franjas del panorama quedan sin rótulo? | CERRADA | Réplica exacta de `mkPunto`: 1.408/11.783 puntos comunales (11,9%) y 189/1.296 SLEP (14,6%) afectados; nivel mudo dominante: Adecuado |
| ¿`xmlns` duplicado en la exportación del supergrid? | PARCIAL | Patrón presente en `construirSvgGraficos` (L2797+L2818+L2974); serialización real del navegador no observable desde aquí |
| ¿El motor publicado es autocontenido? | CERRADA (refutada) | 3 `<script src="https://unpkg.com/...">` activos en `docs/index.html` L1219/L1222/L1225, con SRI |

---

## 3. Por tarea: salidas literales y tablas de medición

### FASE 0 — Punto de partida

Comandos: `git -C $R fetch --quiet --all --prune; git -C $R status --porcelain; git -C $R rev-parse HEAD origin/main; md5 -q $R/docs/index.html; md5 -q $R/40_salidas/motor_comparacion.html; ls -1 $R/40_salidas/intermedios/` con `R=/Users/tomgc/Projects/slep_simce_adecuado`.

Salida literal:

```
--- status ---
?? 50_documentacion/activa/encargos/encargo_verificacion_dudas_s29.md
--- rev-parse ---
4e8f946f0cf6b252c296cf6d545299d25aa139e7
4e8f946f0cf6b252c296cf6d545299d25aa139e7
--- md5 docs/index.html ---
f00e9126b86fc703b001e55080de0969
--- md5 motor ---
f00e9126b86fc703b001e55080de0969
--- ls intermedios ---
comunas_chile.parquet
establecimientos_chile.parquet
simce_comunal.parquet
simce_rbd.parquet
slep_cc_establecimientos.parquet
sleps_chile.parquet
```

Esquema de `simce_comunal.parquet` (comando: `Rscript -e 'x <- arrow::open_dataset(".../simce_comunal.parquet"); print(x$schema)'`; el aviso de renv desincronizado apareció y es el esperado):

```
anio: int32
nivel: string
prueba: string
cod_com_rbd: string
nom_com_rbd: string
cod_reg_rbd: string
nom_reg_rbd: string
cod_grupo: string
cod_depe2: string
pct_adecuado: double
pct_elemental: double
pct_insuficiente: double
n_evaluados: int32
n_estab: int32
```

Esquema de `sleps_chile.parquet` (mismo comando sobre ese archivo):

```
cod_slep: string
nombre_slep: string
anio_traspaso: int32
cod_com_rbd: string
nom_com_rbd: string
rbd: string
nom_rbd: string
```

Esquema de `simce_rbd.parquet`, medido antes de usarlo en T2 (mismo comando sobre ese archivo):

```
anio: int32
nivel: string
prueba: string
rbd: string
cod_com_rbd: string
nom_com_rbd: string
cod_grupo: string
cod_depe2: string
nalu: int32
palu_eda_ade: double
palu_eda_ele: double
palu_eda_ins: double
marca: string
preliminar: bool
prom: double
dif: double
difgru: double
sigdif: int32
siggru: int32
```

| Medición | Esperado | Medido |
|---|---|---|
| `git status --porcelain` | vacío o solo artefactos de este encargo | `?? .../encargo_verificacion_dudas_s29.md` (el `.md` del propio encargo) ✓ |
| `rev-parse HEAD origin/main` | ambos `4e8f946` | ambos `4e8f946f0cf6b252c296cf6d545299d25aa139e7` ✓ |
| md5 `docs/index.html` | `f00e9126b86fc703b001e55080de0969` | idéntico ✓ |
| md5 motor generado | el mismo | idéntico ✓ |
| `ls` intermedios | seis `.parquet` | seis ✓ |
| esquemas | transcritos antes de usarse | arriba ✓ |

### T1 — GitHub Pages

Comandos (literales del encargo, `U=https://tomgc.github.io/slep_simce_adecuado/`):

```
curl -s -o /tmp/pages_index.html -w "http_code=%{http_code} size=%{size_download} tiempo=%{time_total}\n" "$U"
curl -sI "$U" | sed -n '1p;/[Ee][Tt]ag/p;/[Ll]ast-[Mm]odified/p;/[Aa]ge:/p;/[Cc]ache-[Cc]ontrol/p'
md5 -q /tmp/pages_index.html
md5 -q $R/docs/index.html
cmp /tmp/pages_index.html $R/docs/index.html && echo "IDENTICOS" || echo "DIFIEREN"
```

Salida literal:

```
http_code=200 size=2620381 tiempo=0.466611
HTTP/2 200 
last-modified: Sat, 29 Aug 2026 17:54:56 GMT
etag: "6a931cf0-27fbdd"
cache-control: max-age=600
age: 0
f00e9126b86fc703b001e55080de0969
f00e9126b86fc703b001e55080de0969
IDENTICOS
```

| Medición | Esperado | Medido |
|---|---|---|
| `http_code` | 200 | 200 ✓ |
| `cmp` | IDENTICOS | IDENTICOS ✓ |
| md5 descargado | `f00e9126b86fc703b001e55080de0969` | idéntico ✓ |

Ninguna de las tres ramas de discriminación fue necesaria: la descarga coincide byte a byte al primer intento (`age: 0` en la caché de Pages).

### T3 — Constructores de SVG

Comandos y salidas literales:

```
$ grep -n "XMLSerializer" $R/30_procesamiento/33_motor_template.html
2974:      const serializer = new XMLSerializer();
3269:      // el espacio de nombres SVG y XMLSerializer emite la declaración. Fijarlo
3313:      const svgStr = new XMLSerializer().serializeToString(root);

$ grep -n "createElementNS" $R/30_procesamiento/33_motor_template.html
2797:        const node = document.createElementNS(NS, tag);
3267:      const root = document.createElementNS(NS, "svg");
3268:      // El atributo xmlns NO se fija a mano: createElementNS ya deja el nodo en

$ grep -n "xmlns" $R/30_procesamiento/33_motor_template.html
7:<link rel="icon" href="data:image/svg+xml,...xmlns='http://www.w3.org/2000/svg'..." />
226:  background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg'...");
972:  background-image: url("data:image/svg+xml;utf8,<svg xmlns='http://www.w3.org/2000/svg'...");
2818:        xmlns: NS,
3268:      // El atributo xmlns NO se fija a mano: createElementNS ya deja el nodo en
3270:      // además produce un `xmlns` duplicado en la cadena serializada, que es XML
```

Lectura del código (no solo conteos):

- **`construirSvgPanorama`** (L3254–3318): raíz con `document.createElementNS(NS, "svg")` (L3267); **no** fija atributo `xmlns` (el comentario L3268–3271 documenta que fijarlo produciría el duplicado); cadena final con `new XMLSerializer().serializeToString(root)` (L3313). **Coincide con lo esperado.**
- **`construirSvgGraficos`** (L2771–2977): raíz con `el("svg", { xmlns: NS, ... })` (L2817–2822), donde `el()` hace `document.createElementNS(NS, tag)` (L2797) y luego `node.setAttribute(k, v)` por cada atributo (L2798) — es decir, crea con `createElementNS` **y además** fija `xmlns` explícito; cadena final con `new XMLSerializer(); serializer.serializeToString(root)` (L2974–2975). **El patrón productor del duplicado está presente.**

| Constructor | Esperado | Medido |
|---|---|---|
| `construirSvgPanorama` | `createElementNS`, sin `xmlns` manual, `XMLSerializer` | exactamente eso (L3267, L3268-3274, L3313) ✓ |
| `construirSvgGraficos` | pendiente de medir | `createElementNS` (L2797) + `xmlns` manual (L2818 vía L2798) + `XMLSerializer` (L2974-2975) |

**Frontera probado / no probado.** Probado: el patrón en el código del template (que es idéntico en lo relevante al artefacto publicado, cuyo md5 coincide con el motor generado). No probado: que el `XMLSerializer` del navegador reemita la declaración cuando ya existe el atributo homónimo — los serializadores difieren y eso no es observable sin navegador. La duda pasa de "¿existe el patrón?" (sí) a "¿lo tolera el navegador?", que queda para el titular.

### T4 — Referencias de red

Comandos literales del encargo y salidas:

```
$ grep -o -E 'https?://[^"'"'"' )>]+' $R/docs/index.html | sort | uniq -c | sort -rn
   7 http://www.w3.org/2000/svg
   1 https://unpkg.com/react@18.3.1/umd/react.production.min.js
   1 https://unpkg.com/react-dom@18.3.1/umd/react-dom.production.min.js
   1 https://unpkg.com/@babel/standalone@7.29.0/babel.min.js
   1 https://github.com/nodeca/pako
   1 https://d3js.org
   1 http://www.w3.org/XML/1998/namespace
   1 http://www.w3.org/2000/xmlns/
   1 http://www.w3.org/1999/xlink
   1 http://www.w3.org/1999/xhtml

$ grep -c -F 'src="http' $R/docs/index.html      -> 3
$ grep -c -F 'href="http' $R/docs/index.html     -> 0
$ grep -c -F '@import' $R/docs/index.html        -> 0
$ grep -c -F 'fetch(' $R/docs/index.html         -> 1
$ grep -c -F 'XMLHttpRequest' $R/docs/index.html -> 0
```

Contexto de los no-ceros (comando: `sed -n '1210,1236p' $R/docs/index.html` y `perl -ne` sobre las apariciones de `fetch(`):

- Las 3 líneas `src="http` son tags activos en el `<body>` (L1219, L1222, L1225), cada uno con `integrity="sha384-..."` y `crossorigin="anonymous"`, precedidos por el comentario `<!-- React + Babel desde CDN — builds production + SRI (auditoría B4, s13) ... -->`.
- El conteo `fetch( = 1` es **1 línea** (el bundle minificado de d3 inline es una sola línea, L1231); dentro de ella hay varias apariciones y todas son **definiciones** de los helpers de d3-fetch (`d3.blob`, `d3.buffer`, `d3.json`, `d3.text`...), no invocaciones al abrir. Las invocaciones en el código del motor se midieron aparte: `grep -c -F 'd3.json(' → 0`, `'d3.csv(' → 0`, `'d3.text(' → 0`, `'d3.blob(' → 0` (controles positivos en §6).
- `new Image(` (medición adicional, `grep -c -F 'new Image(' → 1`): en `rasterizarSvgAPng`, `img.src = url` donde `url = URL.createObjectURL(svgBlob)` (template L3007-3008, L3051) — blob local, no red, y solo corre al exportar PNG por acción del usuario.

| Medición | Esperado | Medido |
|---|---|---|
| URLs categoría 1 | una o más, todas de `www.w3.org` | 5 URLs únicas w3.org (11 apariciones) ✓ |
| URLs categoría 3 | **ninguna** | **tres** (unpkg.com ×3) ✗ — hallazgo, ver §7 |
| `@import`, `XMLHttpRequest` | 0 con control | 0 y 0, controles en §6 ✓ |
| `fetch(` | 0 con control | 1 línea, clasificada: definiciones de librería d3, sin invocación propia (los `d3.*(` dan 0 con control) |
| `href="http` | (parte del protocolo) | 0, control positivo en §6 ✓ |

---

## 4. T2 completo

### 4.1 Umbral derivado del código

Líneas exactas de `30_procesamiento/33_motor_template.html`:

```
3070:    const PANORAMA_DIMS = {
3071:      W: 520, H: 300,
3072:      M: { top: 40, right: 14, bottom: 46, left: 36 },
3073:    };
...
3076:      const y = d3.scaleLinear().domain([0, 100]).range([ih, 0]);
...
3178:            if (h >= 15) {
```

- Altura interna: `ih = H − M.top − M.bottom = 300 − 40 − 46 = 214` px (el `ih` que recibe `dibujarPanoramaEnGrupo` se calcula así en L3226 y L3258).
- Escala lineal 0–100 → una franja de `v` puntos porcentuales mide `h = v × 214/100 = v × 2,14` px (L3160-3173: `h = botY − topY` con `y` lineal; los tres niveles suman 100 por construcción de `mkPunto`, verificado en §4.3).
- Rótulo solo si `h >= 15` (L3178) ⇒ **umbral = 15 / 214 × 100 = 7,0093457944 puntos porcentuales** (comando: impreso por el script de §4.2). En la grilla de 1 decimal de `mkPunto`: 7,0 queda sin rótulo; 7,1 lo lleva.
- Franja con `v <= 0` no se dibuja en absoluto (L3168): se contó aparte (`con_franja_cero`), no como "sin rótulo".

La condición es una comparación directa de altura contra una constante y `PANORAMA_DIMS` tiene la forma supuesta: la rama de detención del paso 1 no aplica.

### 4.2 Script de R que replicó la aritmética (íntegro, ejecutado como `Rscript /tmp/t2_panorama_replica.R`)

```r
# T2 — Réplica exacta de la aritmética del panorama territorial
# (generateSeriesGseCombinado + mkPunto de 33_motor_template.html) para contar
# franjas bajo el umbral de rótulo. Script efímero: solo lee parquet, escribe
# a stdout. No toca el árbol del proyecto.
#
# Umbral derivado del código (33_motor_template.html):
#   L3178: if (h >= 15)                  -> altura mínima del rótulo: 15 px
#   L3070-3073: PANORAMA_DIMS H=300, M.top=40, M.bottom=46 -> ih = 214 px
#   L3076: y = escala lineal [0,100] -> [ih,0], así h = v * ih/100 = v * 2.14
#   umbral = 15 / 214 * 100 = 7.009345794... puntos porcentuales

suppressMessages({
  library(arrow)
  library(dplyr)
})

RAIZ <- "/Users/tomgc/Projects/slep_simce_adecuado"
TH <- 15 * 100 / 214  # 7.009345794392523

# Math.round de JS: half away from zero para no negativos = floor(x + 0.5).
# (R round() usa banker's rounding; NO sirve para replicar mkPunto.)
js_round <- function(x) floor(x + 0.5)

# mkPunto (L1372-1386 del template), vectorizado.
mk_punto <- function(num, num_ele, num_ins, den) {
  pct <- js_round(num / den * 1000) / 10
  pe  <- ifelse(num_ele > 0, num_ele / den * 100, 0)
  pin <- ifelse(num_ins > 0, num_ins / den * 100, 0)
  resto <- pmax(0, 100 - pct)
  suma_ei <- pe + pin
  pe2 <- ifelse(suma_ei > 0, js_round(pe / suma_ei * resto * 10) / 10, 0)
  pi2 <- ifelse(suma_ei > 0,
                js_round((resto - pe2) * 10) / 10,
                js_round(resto * 10) / 10)
  tibble(pct = pct, pct_ele = pe2, pct_ins = pi2)
}

# ---------------------------------------------------------------------------
# Fuente comunal: EXACTAMENTE lo que el generador incrusta como DATA.simce_comunal
# (33_generar_html.R L139-141: pct_* redondeados a 2 decimales con round() de R).
# ---------------------------------------------------------------------------
com <- read_parquet(file.path(RAIZ, "40_salidas/intermedios/simce_comunal.parquet")) |>
  mutate(
    pct     = round(pct_adecuado, 2),
    pct_ele = round(pct_elemental, 2),
    pct_ins = round(pct_insuficiente, 2)
  )

YEARS <- sort(unique(as.integer(com$anio)))  # meta$anios del generador

# Filtros del bucle comunal de generateSeriesGseCombinado (L1599-1602):
#   p == null || n == null || n === 0  -> fuera
#   filaSuprimida(p, pe, pi): (p||0)+(pe||0)+(pi||0) === 0 -> fuera
com_ok <- com |>
  filter(!is.na(pct), !is.na(n_evaluados), n_evaluados != 0) |>
  filter((coalesce(pct, 0) + coalesce(pct_ele, 0) + coalesce(pct_ins, 0)) != 0)

# Acumulación L1606-1609: num += p*n/100; num_ele += pe*n/100 (si pe != null); den += n
acumular <- function(df, ...) {
  df |>
    group_by(...) |>
    summarise(
      num     = sum(pct * n_evaluados / 100),
      num_ele = sum(ifelse(is.na(pct_ele), 0, pct_ele * n_evaluados / 100)),
      num_ins = sum(ifelse(is.na(pct_ins), 0, pct_ins * n_evaluados / 100)),
      den     = sum(n_evaluados),
      .groups = "drop"
    ) |>
    filter(den > 0)
}

pts_comuna <- acumular(com_ok, cod_com_rbd, nom_com_rbd, nivel, prueba, anio) |>
  mutate(estrato = "comuna", terr = paste0(nom_com_rbd, " (", cod_com_rbd, ")")) |>
  select(estrato, terr, nivel, prueba, anio, num, num_ele, num_ins, den)

pts_region <- acumular(com_ok, cod_reg_rbd, nom_reg_rbd, nivel, prueba, anio) |>
  mutate(estrato = "region", terr = paste0(nom_reg_rbd, " (", cod_reg_rbd, ")")) |>
  select(estrato, terr, nivel, prueba, anio, num, num_ele, num_ins, den)

pts_nacional <- acumular(com_ok, nivel, prueba, anio) |>
  mutate(estrato = "nacional", terr = "Chile") |>
  select(estrato, terr, nivel, prueba, anio, num, num_ele, num_ins, den)

# ---------------------------------------------------------------------------
# Estrato SLEP: el motor lo calcula por lista de RBDs (entity.rbds, de
# sleps_chile) contra DATA.simce_rbd, que el generador incrusta filtrado con el
# criterio de producción (33_generar_html.R L205-216): palu_eda_ade no-NA,
# nalu >= 10, marca NA, y palu_* redondeados a 2 decimales.
# ---------------------------------------------------------------------------
sleps <- read_parquet(file.path(RAIZ, "40_salidas/intermedios/sleps_chile.parquet"))

rbd <- read_parquet(file.path(RAIZ, "40_salidas/intermedios/simce_rbd.parquet")) |>
  filter(!is.na(palu_eda_ade), !is.na(nalu), nalu >= 10, is.na(marca)) |>
  mutate(
    palu     = round(palu_eda_ade, 2),
    palu_ele = round(palu_eda_ele, 2),
    palu_ins = round(palu_eda_ins, 2),
    rbd      = as.character(rbd)
  )

# Bucle SLEP de generateSeriesGseCombinado (L1574-1590): mismos filtros de fila.
rbd_ok <- rbd |>
  filter(!is.na(palu), !is.na(nalu), nalu != 0) |>
  filter((coalesce(palu, 0) + coalesce(palu_ele, 0) + coalesce(palu_ins, 0)) != 0)

pts_slep <- sleps |>
  distinct(cod_slep, nombre_slep, rbd) |>
  mutate(rbd = as.character(rbd)) |>
  inner_join(rbd_ok, by = "rbd", relationship = "many-to-many") |>
  group_by(cod_slep, nombre_slep, nivel, prueba, anio) |>
  summarise(
    num     = sum(palu * nalu / 100),
    num_ele = sum(ifelse(is.na(palu_ele), 0, palu_ele * nalu / 100)),
    num_ins = sum(ifelse(is.na(palu_ins), 0, palu_ins * nalu / 100)),
    den     = sum(nalu),
    .groups = "drop"
  ) |>
  filter(den > 0) |>
  mutate(estrato = "slep", terr = paste0("SLEP ", nombre_slep, " (", cod_slep, ")")) |>
  select(estrato, terr, nivel, prueba, anio, num, num_ele, num_ins, den)

# ---------------------------------------------------------------------------
# mkPunto por punto y conteo contra el umbral. YEARS.map limita al calendario
# del motor: solo años presentes en meta$anios.
# ---------------------------------------------------------------------------
pts <- bind_rows(pts_comuna, pts_region, pts_nacional, pts_slep) |>
  filter(anio %in% YEARS)

pts <- bind_cols(pts, mk_punto(pts$num, pts$num_ele, pts$num_ins, pts$den))

# Franja "bajo el umbral" = se dibuja (v > 0) pero sin rótulo (v < TH).
# Franja v == 0 no se dibuja: se cuenta aparte, no como "sin rótulo".
bajo <- function(v) v > 0 & v < TH
pts <- pts |>
  mutate(
    b_ade = bajo(pct), b_ele = bajo(pct_ele), b_ins = bajo(pct_ins),
    n_bajo = b_ade + b_ele + b_ins,
    n_cero = (pct == 0) + (pct_ele == 0) + (pct_ins == 0),
    min_bajo = pmin(ifelse(b_ade, pct, Inf),
                    ifelse(b_ele, pct_ele, Inf),
                    ifelse(b_ins, pct_ins, Inf))
  )

cat(sprintf("UMBRAL = 15 / 214 * 100 = %.10f puntos porcentuales\n", TH))
cat(sprintf("YEARS (meta$anios) = %s\n\n", paste(YEARS, collapse = ", ")))

cat("== TABLA 1: estrato x puntos x puntos con >=1 franja bajo el umbral ==\n")
t1 <- pts |>
  group_by(estrato) |>
  summarise(
    puntos = n(),
    afectados = sum(n_bajo >= 1),
    pct_afectados = round(sum(n_bajo >= 1) / n() * 100, 1),
    con_franja_cero = sum(n_cero >= 1),
    .groups = "drop"
  ) |>
  arrange(match(estrato, c("comuna", "region", "nacional", "slep")))
print.data.frame(t1, row.names = FALSE)

cat("\n== TABLA 2: desglose por nivel de logro (franjas bajo el umbral) ==\n")
t2 <- pts |>
  group_by(estrato) |>
  summarise(
    adecuado = sum(b_ade), elemental = sum(b_ele), insuficiente = sum(b_ins),
    .groups = "drop"
  ) |>
  arrange(match(estrato, c("comuna", "region", "nacional", "slep")))
print.data.frame(t2, row.names = FALSE)
cat("\nTotales pais (todas los estratos):\n")
print.data.frame(
  pts |> summarise(adecuado = sum(b_ade), elemental = sum(b_ele),
                   insuficiente = sum(b_ins)),
  row.names = FALSE
)

cat("\n== TABLA 3: los 10 casos mas extremos ==\n")
cat("(criterio: franja dibujada sin rotulo mas pequena; empates por n_bajo desc)\n")
t3 <- pts |>
  filter(n_bajo >= 1) |>
  arrange(min_bajo, desc(n_bajo), desc(den)) |>
  head(10) |>
  select(estrato, terr, nivel, prueba, anio, pct, pct_ele, pct_ins, n_eval = den)
print.data.frame(t3, row.names = FALSE)

cat("\n== Verificacion interna: suma pct+pct_ele+pct_ins ==\n")
chk <- pts |> mutate(s = pct + pct_ele + pct_ins) |>
  summarise(min_s = min(s), max_s = max(s), fuera = sum(abs(s - 100) > 1e-9))
print.data.frame(chk, row.names = FALSE)
```

**Decisiones de fidelidad, todas verificadas contra el código fuente:**

- Se replicó lo que el motor realmente consume: `DATA.simce_comunal` = parquet completo con `pct_*` redondeados a 2 decimales con `round()` de R (`33_generar_html.R` L139-141); `DATA.simce_rbd` = parquet filtrado `!is.na(palu_eda_ade) & nalu >= 10 & is.na(marca)` y redondeado a 2 decimales (`33_generar_html.R` L205-216).
- `Math.round` de JS ≠ `round()` de R: se usó `floor(x + 0.5)` (válido para valores no negativos, que es el dominio aquí).
- El estrato SLEP se calculó **como lo hace el motor**: por lista de RBDs de `sleps_chile` contra `simce_rbd` (rama `entity.kind === "slep"` de `generateSeriesGseCombinado`, L1565-1590), no por mapeo comuna→SLEP. La cláusula del encargo contemplaba mapear comunas; la clave real de la vista son los `rbds` y `sleps_chile.parquet` la trae (`cod_slep`, `rbd`) sin inventar nada — mapear por comunas habría contado una distribución que no es la del panorama, exactamente el caso malo que la calibración de T2 prohíbe.
- Universo por entidad **sin filtro `depe2`** (es opcional y por defecto `null` en el alta de entidades, template L3795/L3809/L3853): el punto de partida de la vista es el territorio completo.
- Grupos y dependencias se combinan dentro de cada territorio (eso ES el panorama); la segmentación GSE de la vista de comparación no se tocó.

### 4.3 Salida literal del script

```
UMBRAL = 15 / 214 * 100 = 7.0093457944 puntos porcentuales
YEARS (meta$anios) = 2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025

== TABLA 1: estrato x puntos x puntos con >=1 franja bajo el umbral ==
  estrato puntos afectados pct_afectados con_franja_cero
   comuna  11783      1408          11.9             392
   region    576         0           0.0               0
 nacional     36         0           0.0               0
     slep   1296       189          14.6               1

== TABLA 2: desglose por nivel de logro (franjas bajo el umbral) ==
  estrato adecuado elemental insuficiente
   comuna     1340        62           23
   region        0         0            0
 nacional        0         0            0
     slep      189         0            0

Totales pais (todas los estratos):
 adecuado elemental insuficiente
     1529        62           23

== TABLA 3: los 10 casos mas extremos ==
(criterio: franja dibujada sin rotulo mas pequena; empates por n_bajo desc)
 estrato                   terr nivel prueba anio pct pct_ele pct_ins n_eval
    slep  SLEP Barrancas (1303)    2m   mate 2015 0.2    12.1    87.7    471
  comuna         CARAHUE (9102)    2m   mate 2017 0.3    26.2    73.5    306
  comuna      LOS ÁLAMOS (8206)    2m   mate 2015 0.5    14.6    84.9    213
  comuna          FREIRE (9105)    2m   mate 2018 0.5    17.1    82.4    187
  comuna      MEJILLONES (2102)    2m   mate 2018 0.6    14.0    85.4    171
    slep   SLEP Tamarugal (102)    2m   mate 2014 0.6    15.0    84.4    160
  comuna TIERRA AMARILLA (3103)    2m   mate 2017 0.7     5.4    93.9    149
  comuna TIERRA AMARILLA (3103)    2m   lect 2017 0.7     3.5    95.8    143
  comuna         CARAHUE (9102)    2m   mate 2015 0.7    23.1    76.2    273
  comuna         CARAHUE (9102)    2m   mate 2016 0.7    27.0    72.3    267

== Verificacion interna: suma pct+pct_ele+pct_ins ==
 min_s max_s fuera
   100   100     0
```

**Lectura.** El universo declarado es: todo punto (territorio × nivel × prueba × año) con dato en la vista del panorama, para 345 comunas efectivas (11.783 puntos), 16 regiones (576), el nacional (36) y los SLEP con RBDs mapeables (1.296). Afecta a casos reales: 11,9% de los puntos comunales y 14,6% de los SLEP tienen al menos una franja dibujada sin rótulo, y la franja muda es Adecuado en 1.529 de las 1.614 franjas afectadas — el patrón típico es un territorio con Adecuado bajo 7% en 2° Medio Matemática. Región y nacional: 0. Los diez casos de la tabla 3 se pueden abrir en el motor y verificar a ojo. La verificación interna (suma exacta 100 en los 13.691 puntos, `fuera = 0`) confirma que la réplica de `mkPunto` es exacta y no una aproximación.

---

## 5. T4 completo — URLs únicas con su categoría

Comando productor: `grep -o -E 'https?://[^"'"'"' )>]+' $R/docs/index.html | sort | uniq -c | sort -rn`; clasificación por lectura del contexto (L1219-1234 del artefacto).

| URL única | Apariciones | Categoría | Detalle |
|---|---|---|---|
| `http://www.w3.org/2000/svg` | 7 | 1 — namespace | declaraciones `xmlns` (3 en data: URIs de CSS/favicon, resto en código SVG); falso positivo conocido (A-xmlns) |
| `http://www.w3.org/1999/xlink` | 1 | 1 — namespace | ídem |
| `http://www.w3.org/1999/xhtml` | 1 | 1 — namespace | ídem |
| `http://www.w3.org/2000/xmlns/` | 1 | 1 — namespace | ídem |
| `http://www.w3.org/XML/1998/namespace` | 1 | 1 — namespace | ídem |
| `https://unpkg.com/react@18.3.1/umd/react.production.min.js` | 1 | **3 — carga real** | `<script src>` activo, L1219, con SRI sha384 + `crossorigin` |
| `https://unpkg.com/react-dom@18.3.1/umd/react-dom.production.min.js` | 1 | **3 — carga real** | `<script src>` activo, L1222, con SRI |
| `https://unpkg.com/@babel/standalone@7.29.0/babel.min.js` | 1 | **3 — carga real** | `<script src>` activo, L1225, con SRI |
| `https://d3js.org` | 1 | 2 — comentario | cabecera del bundle d3 v7.9.0 **inline** (L1230) |
| `https://github.com/nodeca/pako` | 1 | 2 — comentario | licencia del bundle pako 2.1.0 **inline** (L1234) |

**Conclusión de T4, apoyada solo en la categoría 3:** el motor publicado **no** es autocontenido. Al abrirse solicita tres scripts a `unpkg.com` (React, ReactDOM, Babel standalone), decisión deliberada y documentada en el propio HTML (comentario "React + Babel desde CDN — builds production + SRI (auditoría B4, s13)"). d3 y pako sí están inline. No hay hojas de estilo, fuentes, `@import`, `fetch`/`XMLHttpRequest` propios ni imágenes de red (`new Image()` usa un blob local y solo en la exportación PNG). Para la duda del error "Unsafe attempt to load URL": la parte estática queda medida — sí existen referencias de red y son candidatas a la causa; la hipótesis del origen `file://` no gana el peso que anticipaba el estado esperado del encargo (que suponía cero cargas).

---

## 6. Controles positivos (regla 4: ningún cero sin control)

| Patrón con conteo 0 en el motor | Comando de control | Resultado del control |
|---|---|---|
| `href="http` (0) | `grep -c -F 'href="http' $R/50_documentacion/activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md` (archivo real del repo hallado con `grep -rlF`) | `1` — el patrón no está mudo ✓ |
| `@import` (0) | `grep -c -F '@import' /tmp/control_t4.txt` | `1` ✓ |
| `XMLHttpRequest` (0) | `grep -c -F 'XMLHttpRequest' /tmp/control_t4.txt` | `1` ✓ |
| `d3.json(` (0) | `grep -c -F 'd3.json(' /tmp/control_t4.txt` | `1` ✓ |
| `d3.csv(` (0) | `grep -c -F 'd3.csv(' /tmp/control_t4.txt` | `1` ✓ |
| `d3.text(` (0) | `grep -c -F 'd3.text(' /tmp/control_t4.txt` | `1` ✓ |
| `d3.blob(` (0) | `grep -c -F 'd3.blob(' /tmp/control_t4.txt` | `1` ✓ |

Archivo de control creado en scratch (registrado según lo exige el encargo): `/tmp/control_t4.txt`, generado con `printf '@import url("x.css");\nvar r = new XMLHttpRequest();\nd3.json("x")\nd3.csv("x")\nd3.text("x")\nd3.blob("x")\n'`. `src="http` no necesitó control: su conteo fue 3 (no cero). Los ceros de T2 no existen (todos los conteos fueron positivos) y los "0 afectados" de región/nacional no son ceros de patrón sino resultados aritméticos sobre 576 y 36 puntos contados, con el mismo código que sí encontró 1.597 afectados en comunas y SLEP (ese es su control positivo).

## 7. Dudas y tareas congeladas

**Tareas congeladas: ninguna.** Las cuatro llegaron a veredicto.

**Duda registrada (no congela nada):**

- **Contexto:** el estado esperado de T4 decía "URLs de categoría 3: ninguna" y se midieron tres. La prosa del propio encargo enumeraba esta rama ("si existe una referencia de red, es candidata a la causa"), así que se trató como hallazgo del protocolo de clasificación, no como estado no enumerado que congele la tarea. **Pregunta cerrada que la resuelve:** ¿solicita el motor recursos de red al abrirse? Sí: React, ReactDOM y Babel desde unpkg.com (L1219/L1222/L1225, con SRI). **Qué queda bloqueado:** nada de este encargo; la parte dinámica (¿son estas cargas la causa del "Unsafe attempt to load URL"? ¿qué pasa sin internet o bajo `file://`?) es del titular, con navegador.

## 8. Verificación de invariantes (🔒 de §2)

| Invariante | Veredicto | Evidencia |
|---|---|---|
| No se escribe en el repositorio; sin git de escritura | PASA | `git status --porcelain` final: solo `?? .../encargo_verificacion_dudas_s29.md` (preexistente, del titular); `rev-parse` final: `HEAD` = `origin/main` = `4e8f946f0cf6b252c296cf6d545299d25aa139e7`; únicos comandos git ejecutados: `fetch`, `status`, `rev-parse` |
| Único archivo creado: este log, sin trackear ni commitear | PASA | este archivo; no hubo `git add` ni `git commit` (el log aparecerá como `??` en el próximo `status`) |
| Scratch solo en `/tmp` | PASA | `/tmp/pages_index.html`, `/tmp/t2_panorama_replica.R`, `/tmp/control_t4.txt` — `ls -1 /tmp/pages_index.html` → existe |
| No se ejecuta pipeline ni se regenera el motor; md5 finales = iniciales | PASA | `md5 -q` final de `docs/index.html` y `40_salidas/motor_comparacion.html`: ambos `f00e9126b86fc703b001e55080de0969`, idénticos a FASE 0 |
| `cod_com_rbd` como clave comunal, nunca `nom_com_rbd` | PASA | el script de §4.2 agrupa por `cod_com_rbd` (y `nom_com_rbd` viaja solo como etiqueta); SLEP mapeado por `rbd`/`cod_slep` |
| Segmentación GSE de la vista de comparación intocada | PASA | T2 trabajó exclusivamente sobre la combinación del panorama (`generateSeriesGseCombinado`); ninguna medición tocó la segmentación por GSE |

## 9. Lo que quedó sin verificar y por qué

- **El badge `TRASPASO` renderizado y la consola del sitio publicado**: exigen navegador; siguen siendo del titular (mínimo declarado por el encargo).
- **La cadena real que emite `XMLSerializer` en la exportación del supergrid** (T3): depende del serializador del navegador; aquí solo quedó probado el patrón en el código.
- **El comportamiento del motor cuando unpkg.com no responde o bajo `file://`** (T4): la parte dinámica del error "Unsafe attempt to load URL" exige navegador y red controlada.
- **Que Pages siga sirviendo el mismo byte mañana** (T1): lo probado vale para hoy (`age: 0`, `cache-control: max-age=600`); un md5 igual hoy no es un contrato a futuro.

## Auto-auditoría (FASE FINAL)

1. **¿Alguna rama de detención se disparó en el camino nominal?** No. Ninguna tarea se congeló. La única tensión fue el estado esperado de T4 ("categoría 3: ninguna") contra lo medido (tres): la rama estaba contemplada en la prosa de T4 pero la tabla de estados esperados la contradecía — la tabla estaba escrita como apuesta, no como conjunto completo de estados, y en un encargo futuro conviene que la tabla enumere también el estado "categoría 3 ≥ 1 → hallazgo, clasificar y cerrar". Análogamente, la cláusula SLEP de T2 hablaba de mapear comunas cuando la clave real de la vista son los RBDs; se resolvió con la clave del motor y quedó documentado en §4.2.
2. **¿Cada cero tiene su control positivo?** Sí — §6, siete patrones con control ejecutado en el mismo turno.
3. **¿Cada cifra viene del comando citado en la misma línea?** Sí — cada tabla y cifra nombra su comando (grep/curl/md5/cmp/Rscript) o la sección donde está la salida literal.
4. **¿Alguna conclusión afirma más de lo que su comando midió?** Se cuidó la frontera: T3 afirma el patrón en el código, no el defecto en el archivo exportado (§3, §9); T1 afirma identidad de bytes hoy, no un contrato del servidor (§9); T4 afirma que existen tres solicitudes al abrir y que son candidatas a la causa, no que sean la causa (§5, §7).
