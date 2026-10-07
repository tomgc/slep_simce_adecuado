# Log — Escala tipográfica del SVG y limpieza de código muerto

**Fecha:** 2026-08-27
**Encargo:** `50_documentacion/activa/encargos/encargo_deuda_tipografica_svg_y_codigo_muerto.md`
**Archivo editado:** `30_procesamiento/33_motor_template.html` (único)
**Resultado:** ejecutado completo, con el COMMIT 3 **deliberadamente omitido**
por falta de autorización (ver §4).
**Push:** no se hizo. El encargo termina con tres commits locales sobre `main`.

> Este encargo se ejecutó como segundo eslabón de una cadena. El primero
> —`encargo_entorno_y_suite_standalone.md`— quedó **detenido** por una causa
> externa a este repositorio (el paquete `suitedoc` no está publicado en ningún
> remoto). Ver `20260827_entorno_y_suite_standalone_log.md`. Nada de aquel
> encargo se mezcló con este: no se tocó `renv.lock` ni se instaló ningún
> paquete.

---

## 1. FASE 0 — Medición (salida literal)

### `git status --short --branch`

```
## main...origin/main [ahead 2]
?? 50_documentacion/activa/encargos/encargo_deuda_tipografica_svg_y_codigo_muerto.md
?? 50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md
```

Los dos `??` son los archivos de encargo de la cadena en curso, y el titular los
declaró de antemano como estado esperado. Los `ahead 2` son los dos commits del
encargo 1 detenido. Cero modificaciones sobre archivos versionados.

### `git log --oneline -3`

```
9d28b5d docs(log): apenda reanudacion detenida por origen no publicado de suitedoc
c79a6ea docs(encargos): versiona encargo de entorno y suite con su log
06d6586 docs(encargos): versiona encargo de homogeneidad y quinto territorio con su log
```

### `grep -n 'attr("font-size"' 30_procesamiento/33_motor_template.html`

```
1871:            .attr("font-size", 8)
1946:            .attr("font-size", 10.5)
1956:            .attr("font-size", 9.5)
1963:              .attr("font-size", 10.5)
2023:            .attr("font-size", 9.5)
2071:                    .attr("font-size", 11)
2104:            .attr("font-size", 12)
2115:            .attr("font-size", 10.5)
2125:              .attr("font-size", 13)
```

### `grep -c 'attr("font-size"' 30_procesamiento/33_motor_template.html`

```
9
```

### `grep -n '"font-size":' 30_procesamiento/33_motor_template.html`

```
2446:        "font-size": 18, "font-weight": 800,
2453:        "font-size": 11, fill: "#747474",
2469:          "font-size": 14, "font-weight": 800,
2484:          "font-size": 10, fill: "#747474",
2506:          "font-size": 9, "font-weight": 700,
2514:          "font-size": 13, "font-weight": 800,
2538:              "font-size": 11, fill: "#BCA493",
2547:            "font-size": 8, "font-weight": 700,
2568:            "font-size": 8, "font-weight": 700,
```

### `grep -c '"font-size":' 30_procesamiento/33_motor_template.html`

```
9
```

### `grep -n "depe2Label" 30_procesamiento/33_motor_template.html`

```
2875:          const depe2Label = depe2 ? SimceData.DEPE2_LABELS[depe2] : "Todas las dependencias";
```

Conteo: `1` (`grep -c "depe2Label"`). Una sola aparición, y es la declaración:
no hay ni un solo uso.

### `grep -n -- "--fs-display" 30_procesamiento/33_motor_template.html`

```
86:  --fs-display-1: clamp(48px, 6vw, 88px);
87:  --fs-display-2: clamp(36px, 4.5vw, 64px);
```

Conteo: `2` (`grep -c -- "--fs-display"`). Usos vía `var()`: `0`
(`grep -c "var(--fs-display"`).

### `grep -n "text-transform" 30_procesamiento/33_motor_template.html`

```
653:  text-transform: uppercase;
```

Conteo: `1` (`grep -c "text-transform"`).

### Multiconjunto completo de valores de FASE 0

Es el contrato del refactor. Extraído con
`grep -oE 'attr\("font-size", [0-9.]+|"font-size": [0-9.]+' … | grep -oE '[0-9.]+$' | sort -n | uniq -c`:

```
  3x 8
  1x 9
  2x 9.5
  1x 10
  3x 10.5
  3x 11
  1x 12
  2x 13
  1x 14
  1x 18
  total: 18
```

### Tabla de FASE 0

| Medición | Valor esperado | Valor medido |
|---|---|---|
| `git status --short --branch` | limpio salvo los encargos de la cadena | 2 `??`, ambos archivos de encargo; 0 modificados (`git status --short --branch`) |
| `.attr("font-size", N)` | 9 | 9 (`grep -c 'attr("font-size"'`) |
| `"font-size": N` | 9 | 9 (`grep -c '"font-size":'`) |
| Total de literales | 18 | 18 (suma de los dos anteriores) |
| `depe2Label` | 1, sin uso | 1, la declaración (`grep -c "depe2Label"`) |
| `--fs-display` | 2 definiciones, 0 usos | 2 definiciones (`grep -c -- "--fs-display"`), 0 usos (`grep -c "var(--fs-display"`) |
| `text-transform` | 1 | 1, línea 653 (`grep -c "text-transform"`) |

Las seis premisas del §1 del encargo se cumplieron sin excepción.

---

## 2. COMMIT 1 — Escala tipográfica del SVG en constantes JS

### Dónde se colocó la escala, y por qué ahí

Las dos familias de declaraciones viven en funciones distintas:

- `SparklineSubchart` (línea 1815 pre-edición) y `RecentBarsSubchart` (1976)
  dibujan con D3 dentro de componentes React.
- `construirSvgGraficos` (2385) arma el SVG compuesto de exportación con
  atributos literales.

Antes de decidir la ubicación se verificó que las tres compartieran ámbito
léxico con el bloque de constantes de gráficos (`COLOR_ADEC` y hermanas, línea
1480):

```
awk 'NR>1482 && NR<2385 && /^[^ ]/ {print} NR>1482 && NR<2385 && /^ {1,3}[^ ]/ {print}' …
(vacío)
```

Ninguna línea con indentación menor a 4 entre ambos puntos: las tres funciones y
el bloque de constantes son hermanos del mismo ámbito. La escala se insertó
inmediatamente después de `COLOR_INSUF`, con su propio encabezado de sección,
que es "junto a las demás constantes de layout de los gráficos" tal como pedía
el encargo.

### Nombres por rol elegidos

Se derivaron leyendo qué dibuja cada llamada, no de una lista previa. La escala
se agrupó en tres sub-objetos porque los roles se repiten entre gráficos con
valores distintos —un "año del eje" mide 9.5 en el sparkline y 10.5 en las
barras—, y un espacio de nombres plano habría obligado a inventar sufijos
numéricos, que es justo lo que el encargo prohíbe.

| Grupo | Constante | Valor | Rol real que dibuja |
|---|---|---|---|
| `sparkline` | `marcaTraspaso` | 8 | rótulo "traspaso" sobre el marcador vertical del año de traspaso |
| `sparkline` | `valorPunto` | 10.5 | porcentaje sobre cada punto de la serie |
| `sparkline` | `anioEje` | 9.5 | año bajo el eje X |
| `sparkline` | `marcaPreliminar` | 10.5 | asterisco de dato preliminar |
| `barras` | `tickEje` | 9.5 | ticks del eje Y (`d3.axisLeft`) |
| `barras` | `valorSegmento` | 11 | porcentaje dentro del segmento apilado (Elemental / Insuficiente) |
| `barras` | `valorBarra` | 12 | porcentaje de la barra Adecuado |
| `barras` | `anioEje` | 10.5 | año bajo el eje X |
| `barras` | `marcaPreliminar` | 13 | asterisco de dato preliminar |
| `exportacion` | `titulo` | 18 | título del documento exportado |
| `exportacion` | `subtitulo` | 11 | procedencia y fecha de exportación |
| `exportacion` | `nombreTerritorio` | 14 | nombre del territorio en el encabezado de columna |
| `exportacion` | `metaTerritorio` | 10 | meta bajo el nombre (tipo y nº de comunas) |
| `exportacion` | `rotuloGse` | 9 | rótulo "GSE" de la columna izquierda |
| `exportacion` | `valorGse` | 13 | nivel GSE de la fila |
| `exportacion` | `celdaVacia` | 11 | mensaje "Sin datos" |
| `exportacion` | `subcabeceraCelda` | 8 | subcabeceras internas de la celda |

Son **17 constantes para 18 declaraciones**: ver la decisión 2.

### Tabla de mapeo completa — las 18 declaraciones migradas

| # | Línea antes | Valor antes | Constante que la reemplaza | Valor después | Línea después |
|---|---|---|---|---|---|
| 1 | 1871 | 8 | `FS_SVG.sparkline.marcaTraspaso` | 8 | 1913 |
| 2 | 1946 | 10.5 | `FS_SVG.sparkline.valorPunto` | 10.5 | 1988 |
| 3 | 1956 | 9.5 | `FS_SVG.sparkline.anioEje` | 9.5 | 1998 |
| 4 | 1963 | 10.5 | `FS_SVG.sparkline.marcaPreliminar` | 10.5 | 2005 |
| 5 | 2023 | 9.5 | `FS_SVG.barras.tickEje` | 9.5 | 2065 |
| 6 | 2071 | 11 | `FS_SVG.barras.valorSegmento` | 11 | 2113 |
| 7 | 2104 | 12 | `FS_SVG.barras.valorBarra` | 12 | 2146 |
| 8 | 2115 | 10.5 | `FS_SVG.barras.anioEje` | 10.5 | 2157 |
| 9 | 2125 | 13 | `FS_SVG.barras.marcaPreliminar` | 13 | 2167 |
| 10 | 2446 | 18 | `FS_SVG.exportacion.titulo` | 18 | 2488 |
| 11 | 2453 | 11 | `FS_SVG.exportacion.subtitulo` | 11 | 2495 |
| 12 | 2469 | 14 | `FS_SVG.exportacion.nombreTerritorio` | 14 | 2511 |
| 13 | 2484 | 10 | `FS_SVG.exportacion.metaTerritorio` | 10 | 2526 |
| 14 | 2506 | 9 | `FS_SVG.exportacion.rotuloGse` | 9 | 2548 |
| 15 | 2514 | 13 | `FS_SVG.exportacion.valorGse` | 13 | 2556 |
| 16 | 2538 | 11 | `FS_SVG.exportacion.celdaVacia` | 11 | 2580 |
| 17 | 2547 | 8 | `FS_SVG.exportacion.subcabeceraCelda` | 8 | 2589 |
| 18 | 2568 | 8 | `FS_SVG.exportacion.subcabeceraCelda` | 8 | 2610 |

Ningún valor cambió. Las líneas "después" se midieron con
`grep -n 'attr("font-size", FS_SVG\.\|"font-size": FS_SVG\.'` sobre el archivo
ya editado; el desplazamiento se debe a las 44 líneas del bloque insertado en
1482 y a las 3 líneas borradas en el COMMIT 2.

### Decisión 1 — sub-objetos por gráfico en vez de nombres planos

**Ambigüedad.** El encargo pide "nombres por rol, no por número", sin especificar
si el espacio de nombres debe ser plano.

**Decisión.** Tres sub-objetos: `sparkline`, `barras`, `exportacion`.

**Fundamento.** Dos roles colisionan entre gráficos con valores distintos:
`anioEje` (9.5 en sparkline, 10.5 en barras) y `marcaPreliminar` (10.5 y 13).
Con nombres planos habría que llamarlos `anioEjeSparkline` / `anioEjeBarras`, o
peor, recaer en numeración.

**Alternativa descartada.** Un objeto plano con sufijos. Se descartó porque el
sufijo termina codificando el contexto en el nombre en vez de en la estructura,
y porque agrupar deja legible de un vistazo qué escala usa cada gráfico.

### Decisión 2 — una constante para dos declaraciones del mismo rol

**Ambigüedad.** El encargo dice "sustituye las 18 declaraciones"; podría leerse
como que deben quedar 18 constantes.

**Decisión.** 17 constantes. Las líneas 2547 y 2568 —"Trayectoria histórica" y
"Últimas 3 aplicaciones"— son ambas subcabeceras internas de la misma celda, con
idéntico tamaño (8), idéntico peso (700) e idéntico `letter-spacing` (0.08em).
Comparten rol, así que comparten constante: `exportacion.subcabeceraCelda`.

**Fundamento.** El criterio del encargo es "ninguna queda como literal", y las 18
quedan referenciadas. Duplicar una constante idéntica solo para llegar a 18
reintroduciría por la puerta de atrás el problema que el refactor viene a
resolver: dos sitios que hay que acordarse de cambiar juntos.

**Alternativa descartada.** `subcabeceraTrayectoria` y `subcabeceraUltimas`, ambas
a 8. Se descartó por lo anterior.

### Decisión 3 — el comentario declara el piso de 12px, no lo aplica

El bloque insertado dice explícitamente que la escala **no** está sujeta al piso
de 12px de la UI, y por qué: son etiquetas de gráfico compacto que bajan de 12px
por diseño. Cinco de los diecisiete valores están bajo 12 (8, 9, 9.5, 10, 10.5) y
se preservaron tal cual, que es lo que manda el invariante.

También deja escrito por qué esto no puede ser una variable CSS: el atributo SVG
recibe un número, no una cadena, y `var(--fs-…)` no funciona ahí.

### Verificación del COMMIT 1 (salida literal)

```
### grep -c 'attr("font-size", *[0-9]'   (esperado 0)
0

### grep -c '"font-size": *[0-9]'        (esperado 0)
0
```

Ambas ramas de detención quedaron sin disparar.

### Verificación adicional: preservación del multiconjunto

El conteo a cero prueba que no quedan literales, pero **no** prueba que los
valores se hayan preservado: una migración que pusiera 12 en todas partes también
daría 0. Se añadió una comprobación que resuelve cada una de las 18 referencias
contra el objeto `FS_SVG` —respetando la ruta completa `grupo.campo`— y compara
el multiconjunto resultante con el de FASE 0:

```
### multiconjunto ANTES (18 literales del respaldo)
  3x 8
  1x 9
  2x 9.5
  1x 10
  3x 10.5
  3x 11
  1x 12
  2x 13
  1x 14
  1x 18
  total: 18

### multiconjunto DESPUES (18 referencias resueltas contra FS_SVG)
  3x 8
  1x 9
  2x 9.5
  1x 10
  3x 10.5
  3x 11
  1x 12
  2x 13
  1x 14
  1x 18
  total: 18

### VEREDICTO
md5 multiconjunto antes:   42ec61319dc49a945ad019c793cd2462
md5 multiconjunto despues: 42ec61319dc49a945ad019c793cd2462
IDENTICOS: los 18 valores se preservaron
```

**Lo que salió mal por el camino, y queda escrito:** el primer verificador que
escribí resolvía las referencias por el último tramo del nombre (`anioEje`) en
lugar de por la ruta completa (`barras.anioEje`), y con `head -1` cazaba siempre
la primera coincidencia del archivo. Eso hizo aparecer un falso desajuste —9.5
subía de 2 a 3 y 13 bajaba de 2 a 1— que se explicaba enteramente por las dos
colisiones de nombre entre `sparkline` y `barras`. El código migrado nunca estuvo
mal; el verificador sí. Se reescribió con un `awk` que construye el mapa
`grupo.campo → valor` antes de resolver, y ahí los md5 coincidieron.

### Validación sintáctica del bloque insertado

```
### node --check + evaluacion del objeto
sintaxis OK
{"sparkline":{"marcaTraspaso":8,"valorPunto":10.5,"anioEje":9.5,"marcaPreliminar":10.5},"barras":{"tickEje":9.5,"valorSegmento":11,"valorBarra":12,"anioEje":10.5,"marcaPreliminar":13},"exportacion":{"titulo":18,"subtitulo":11,"nombreTerritorio":14,"metaTerritorio":10,"rotuloGse":9,"valorGse":13,"celdaVacia":11,"subcabeceraCelda":8}}
```

### Tabla del COMMIT 1

| Medición | Valor esperado | Valor medido |
|---|---|---|
| `attr("font-size", <número>)` | 0 | 0 (`grep -c 'attr("font-size", *[0-9]'`) |
| `"font-size": <número>` | 0 | 0 (`grep -c '"font-size": *[0-9]'`) |
| Declaraciones migradas | 18 | 18 (`grep -n 'attr("font-size", FS_SVG\.\|"font-size": FS_SVG\.'`) |
| Multiconjunto de valores | idéntico a FASE 0 | idéntico, md5 `42ec6131…` en ambos |
| Sintaxis del bloque | válida | válida (`node --check`) |

**Hash: `df52516`** — `refactor(motor): escala tipografica del SVG en constantes JS nombradas`

---

## 3. COMMIT 2 — Código muerto

### Comprobación previa de no-uso

`depe2Label`: `grep -c "depe2Label"` → `1`. La única aparición es la propia
declaración. El `onSave({...})` inmediatamente siguiente pasa `depe2: depe2 ||
null`, o sea el código crudo, no la etiqueta. Confirmado sin uso.

`--fs-display-1` / `--fs-display-2`: `grep -c -- "--fs-display"` → `2`, las dos
definiciones de `:root`. `grep -c "var(--fs-display"` → `0`. Confirmadas sin uso.

Las tres resultaron efectivamente muertas: la rama de detención "si alguna
resulta usada, no la toques" no se disparó.

### Verificación posterior (salida literal)

```
grep -c "depe2Label"      (esperado 0): 0
grep -c -- "--fs-display" (esperado 0): 0
```

```
### diff resumido
 30_procesamiento/33_motor_template.html | 3 ---
 1 file changed, 3 deletions(-)
```

Tres líneas borradas, ni una añadida ni modificada. El comentario
`/* Type scale */` se conservó: sigue encabezando el resto de la escala
(`--fs-h1` en adelante).

### Tabla del COMMIT 2

| Medición | Valor esperado | Valor medido |
|---|---|---|
| `depe2Label` | 0 | 0 (`grep -c "depe2Label"`) |
| `--fs-display` | 0 | 0 (`grep -c -- "--fs-display"`) |
| Líneas tocadas | 3 borradas | 3 borradas, 0 añadidas (`git diff --stat`) |

**Hash: `89d2ac9`** — `chore(motor): elimina constante y variables tipograficas sin uso`

---

## 4. COMMIT 3 — `.badge-traspaso`: **NO EJECUTADO**

**Estado: pendiente de decisión del titular.**

El encargo lo marca como condicional: *"Solo si el titular lo autorizó
explícitamente al entregarte este encargo. Si no hay autorización expresa,
sáltate este commit y déjalo anotado en el log como pendiente de decisión."*

El titular, al encadenar los encargos, fue explícito en sentido contrario: *"El
commit 3 del encargo 2 (`.badge-traspaso`, quitar `text-transform: uppercase`) es
condicional y requiere autorización expresa. NO está autorizado: sáltalo y déjalo
anotado en el log como pendiente de decisión del titular."*

Lo repitió al reanudar la cadena: *"El commit 3 del encargo 2 (`.badge-traspaso`)
sigue SIN autorizar: sáltalo y anótalo en el log."*

**No se tocó.** Estado al cierre del encargo:

```
### grep -n "text-transform" 30_procesamiento/33_motor_template.html
651:  text-transform: uppercase;
```

Contexto de la regla, sin modificar:

```
  display: inline-block;
  margin-left: 6px;
  padding: 1px 6px;
  border-radius: 8px;
  background: rgba(0,98,160,0.10);
  color: var(--ocean);
  font-size: var(--fs-overline);
  font-weight: 800;
  text-transform: uppercase;
  letter-spacing: 0.02em;
  vertical-align: middle;
  white-space: nowrap;
```

La deuda sigue abierta: `.badge-traspaso` incumple el invariante de proyecto
sobre `text-transform`, como registró el log del 2026-08-26 §5. Cuando se
autorice, el trabajo es quitar la declaración de la línea 651 y escribir el texto
del badge directamente en la caja tipográfica que corresponda.

---

## 5. FASE FINAL — Regeneración y verificación

### `Rscript -e 'source(here::here("30_procesamiento","33_generar_html.R"))'`

```
- The project is out-of-sync -- use `renv::status()` for details.
here() starts at /Users/tomgc/Projects/slep_simce_adecuado
[1] Cargando insumos...
    simce_comunal.parquet: 44975 filas
    comunas_chile.parquet: 345 comunas
    sleps_chile.parquet:   2337 filas (36 SLEPs)
    establecimientos_chile.parquet: 10945 establecimientos
[2] Construyendo JSON...
    JSON listo: 13597252 caracteres (13.6 MB sin comprimir).
    JSON comprimido: 2.1 MB (gzip+base64, 15.4% del plano).
[3] Leyendo plantilla, D3 y pako...
    Plantilla: 155275 caracteres
    D3:        279702 caracteres (273 KB)
    pako:      46858 caracteres (46 KB)
[4] Construyendo HTML final...
    OK: 40_salidas/motor_comparacion.html (2519 KB)

=== Resumen ===
  Filas en JSON: 44975
  Comunas:       345
  Regiones:      16
  SLEPs:         36 (2337 RBDs)
  Establec.:     10945 RBDs distintos
  RBDs×nivel:    17983 filas (catálogo popup)
  RBDs×GSE:      29277 filas (catálogo popup celda)
  simce_rbd:     140345 filas (datos por establecimiento)
  Años:          9 (2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025)
  Peso HTML:     2518.7 KB

33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html
```

El aviso de `renv` fuera de sincronía es el que dejó abierto el encargo 1
detenido. No impidió la generación: las dependencias del pipeline
(`here`, `arrow`, `dplyr`, `jsonlite`) están instaladas y cargables.

### `md5 -q 40_salidas/motor_comparacion.html`

```
antes de regenerar:  4ca29869b1e192a632803468d77ad3a9   (fichero del 26 ago 13:02)
después:             79921d5efbe8667e8ac10dc8cfceba75
```

### Verificaciones con rama de detención (salida literal)

```
### grep -c 'attr("font-size", *[0-9]' 40_salidas/motor_comparacion.html   (esperado 1)
1

### grep -c "fontSize: *[0-9]" 40_salidas/motor_comparacion.html           (esperado 0)
0

### grep -o "font-size: *[0-9.]*px" 40_salidas/motor_comparacion.html | sort | uniq -c   (esperado vacío)
(fin del listado)
```

La única ocurrencia superviviente se identificó en contexto para confirmar que es
el vendor y no código del proyecto:

```
ext(p),m.filter(Ct).attr("fill","none").attr("font-size",10).attr("font-family
```

Código minificado —identificadores de una letra, sin espacios tras las comas—:
es el D3 vendorizado, exactamente la ocurrencia que la premisa 3 del encargo
declaraba intocable. No se tocó.

### `git status --short`

```
?? 50_documentacion/activa/encargos/encargo_deuda_tipografica_svg_y_codigo_muerto.md
?? 50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md
```

`40_salidas/motor_comparacion.html` no aparece, y es lo correcto: está en
`.gitignore` línea 13 (`grep -n "motor_comparacion" .gitignore`).

### `git log --oneline -4`

```
89d2ac9 chore(motor): elimina constante y variables tipograficas sin uso
df52516 refactor(motor): escala tipografica del SVG en constantes JS nombradas
9d28b5d docs(log): apenda reanudacion detenida por origen no publicado de suitedoc
c79a6ea docs(encargos): versiona encargo de entorno y suite con su log
```

### Tabla de la FASE FINAL

| Medición | Valor esperado | Valor medido |
|---|---|---|
| `33_generar_html.R` corre | sin error | sin error, "OK. Producto en 40_salidas/motor_comparacion.html" |
| `attr("font-size", <número>)` en el producto | 1 (solo vendor) | 1, y verificado en contexto que es el D3 minificado |
| `fontSize: <número>` | 0 | 0 (`grep -c "fontSize: *[0-9]"`) |
| `font-size: Npx` | listado vacío | listado vacío (`grep -o … \| sort \| uniq -c`) |
| `git status` | sin archivos nuevos versionables | solo los 2 encargos `??` (`git status --short`) |

---

## 6. Qué quedó sin verificar

- **La equivalencia visual.** Es lo central de este encargo y **no está
  verificado**: el asistente no abre navegador. Lo que sí se verificó es la
  condición que la produce —que los 18 valores numéricos se preservaron uno a
  uno, comprobado por igualdad de md5 del multiconjunto—. De ahí se sigue que los
  gráficos deberían verse idénticos, pero eso es una inferencia, no una
  observación. **La comprobación visual la hace el titular.**
- **Que el motor generado se ejecute sin error de JavaScript en el navegador.**
  Se validó la sintaxis del bloque `FS_SVG` con `node --check`, pero el resto del
  template es JSX transformado por Babel en el cliente y no se puede validar así.
  El refactor no introdujo construcciones nuevas más allá de un objeto literal y
  accesos por punto, pero no se ejecutó en navegador.
- **Que `FS_SVG` sea visible desde las tres funciones en tiempo de ejecución.**
  Se verificó por análisis estático de indentación (ninguna línea con sangría
  menor a 4 entre la declaración y el último consumidor), no ejecutando el
  código.
- **El resto del pipeline.** Solo se corrió `33_generar_html.R`. `00_build.R` y
  los demás scripts de `30_procesamiento/` no se ejecutaron: este encargo no los
  toca.
- **`renv::status()` sigue fuera de sincronía**, por el encargo 1 detenido. No se
  intentó arreglar aquí: pertenece a otro encargo y el titular lo excluyó
  expresamente del alcance de esta cadena.

---

## 7. Qué falló o sorprendió

1. **Nada falló en el código.** Las seis premisas del encargo se cumplieron
   exactamente: 9 + 9 = 18 declaraciones, `depe2Label` con una sola aparición,
   dos `--fs-display` sin uso, un `text-transform`, y la ocurrencia del vendor
   sobrevivió sola en el producto.

2. **Falló un verificador mío, no el trabajo.** El primer intento de comprobar la
   preservación del multiconjunto resolvía los nombres sin distinguir grupo y dio
   un falso desajuste. Está descrito en §2. Vale la pena que quede: el conteo a
   cero de literales, que es lo que el encargo pide como rama de detención, no
   habría detectado un cambio de valores; hizo falta una comprobación adicional
   que el encargo no pedía.

3. **Sorpresa de diseño: dos roles colisionan entre gráficos.** `anioEje` y
   `marcaPreliminar` existen en el sparkline y en las barras con valores
   distintos. Es lo que empujó a agrupar la escala en sub-objetos y no en un
   espacio plano.

4. **Sorpresa menor: dos declaraciones comparten rol exacto.** Las subcabeceras
   de celda del SVG de exportación son idénticas en tamaño, peso y
   `letter-spacing`. Quedaron con una sola constante, por lo que hay 17
   constantes para 18 declaraciones.

5. **El aviso de `renv` fuera de sincronía aparece en cada invocación de
   `Rscript`.** Es ruido heredado del encargo 1 detenido, no un problema de este
   encargo. La generación funcionó sin incidentes.
