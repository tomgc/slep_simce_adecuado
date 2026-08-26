# Encargo — Homogeneidad visual y quinto territorio (slep_simce_adecuado)

> **Destino:** `50_documentacion/activa/encargos/encargo_homogeneidad_y_quinto_territorio.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.

---

## 0. Contrato

**ENTORNO.** macOS aarch64. Proyecto R con `renv`. Intérprete de los bloques de
comando: `bash`. Intérprete de R: `Rscript` invocado desde la raíz del proyecto
(el `.Rprofile` activa `renv`, así que un `Rscript` lanzado desde otro directorio
apunta a la librería equivocada).

**POSICIÓN.** Todos los comandos usan ruta absoluta desde la raíz. No asumas el
directorio de trabajo heredado. Raíz del proyecto:

```
/Users/tomgc/Projects/slep_simce_adecuado
```

**INSUMOS.** Un solo archivo se edita en todo el encargo:

```
/Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
```

El motor generado (`40_salidas/motor_comparacion.html`) **está en `.gitignore`**
(fuente: `.gitignore` línea 13, verificado en sesión previa): nunca aparecerá en
`git status` y eso es lo esperado, no un fallo.

**Contexto en una frase.** Motor interactivo de comparación de resultados Simce
por estándares de aprendizaje. La UI llama "territorio" a cada unidad comparada
(comuna, SLEP, región, nacional, establecimiento). El árbol de trabajo trae una
migración tipográfica ya terminada y verificada, pendiente de commit; este
encargo la commitea primero y después arregla seis defectos visuales detectados
en revisión y sube el tope de comparación de 4 a 5 territorios.

---

## 1. Estado de partida (premisas marcadas)

1. El árbol de trabajo tiene **exactamente un** archivo modificado,
   `30_procesamiento/33_motor_template.html`, con la migración tipográfica sin
   commitear *(hipótesis, se mide en FASE 0)*.
2. La rama es `main` y está sincronizada con `origin/main`, sin commits locales
   sin pushear *(hipótesis, se mide en FASE 0)*.
3. La librería `renv` del proyecto está restaurada y `here`, `arrow`, `dplyr` y
   `jsonlite` cargan *(hipótesis, se mide en FASE 0)*.
4. Los seis defectos que arreglan los commits 3 y 4 son **anteriores** a la
   migración tipográfica: ninguno es regresión de ella *(fuente: inspección del
   motor generado en sesión previa; no requiere re-verificación)*.
5. El motor generado no se versiona *(fuente: `.gitignore`, ver §0)*.

---

## 2. Invariantes (🔒 intocables)

- 🔒 Estado por defecto del motor = las **4 comunas** de Costa Central con
  `depe2="5"`. Debe seguir siendo 4 después del commit 5, aunque el tope suba.
- 🔒 Color por nivel, cálculo del % Adecuado y corte de traspaso: no se tocan.
- 🔒 Identificadores de código con raíz "entidad" (`entidadesPorDefecto`,
  `MAX_ENTIDADES`, `entidadDependeSlep`, `entities`) permanecen así. Solo el
  texto visible dice "territorio".
- 🔒 Cero literales `px` en CSS declarativo y cero `fontSize: <número>` inline en
  React: todo tamaño de letra pasa por las variables `--fs-*` de `:root`. Las
  declaraciones de D3 SVG (`.attr("font-size", N)`) y de objetos JS
  (`"font-size": N`) quedan **fuera de alcance**: no se tocan.
- 🔒 Ningún `text-transform: uppercase`.
- 🔒 Ningún comentario CSS puede contener la secuencia literal `*/` en su
  interior.
- 🔒 `docs/index.html` no se toca. Se actualiza por copia manual del titular.
- 🔒 Un commit por grupo, en el orden dado. `git status --short` antes de cada
  `git add`. Nunca `git add .`; siempre por ruta explícita.
- 🔒 No se hace `push`. El encargo termina con commits locales.

---

## 3. Autorizaciones

Estás autorizado a:

1. Editar `30_procesamiento/33_motor_template.html`.
2. Crear los cinco commits descritos en §5.
3. Ejecutar `30_procesamiento/33_generar_html.R`.
4. Escribir el log de §7.

Nada más.

---

## 4. FASE 0 — Medición

Corre y reporta la salida literal de cada comando.

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
git status --short --branch
git log origin/main..HEAD --oneline
git log --oneline -3
Rscript -e 'for (p in c("here","arrow","dplyr","jsonlite")) cat(p, as.character(packageVersion(p)), "\n")'
grep -n "sub-eyebrow" 30_procesamiento/33_motor_template.html
sed -n '/^\.sub-eyebrow/,/}/p' 30_procesamiento/33_motor_template.html
sed -n '/^\.sg-gse-eyebrow/,/}/p' 30_procesamiento/33_motor_template.html
sed -n '/^\.sg-gse-name/,/}/p' 30_procesamiento/33_motor_template.html
grep -c '" · " + SimceData.DEPE2_LABELS' 30_procesamiento/33_motor_template.html
grep -n "MAX_ENTIDADES = " 30_procesamiento/33_motor_template.html
grep -c "repeat(4" 30_procesamiento/33_motor_template.html
```

**Valores esperados y ramas de detención:**

| Medición | Esperado | Si difiere |
|---|---|---|
| `git status --short --branch` | rama `main`, un solo archivo `M`: `30_procesamiento/33_motor_template.html` | **DETENTE.** Si hay más archivos modificados o el árbol está limpio, el estado de partida no es el que este encargo asume |
| `git log origin/main..HEAD` | vacío | **DETENTE** y reporta los commits locales |
| Las 4 dependencias R | las 4 imprimen versión | **DETENTE.** Falta restaurar el entorno: reporta cuál falla, no lo instales por tu cuenta |
| `grep -c '" · " + SimceData.DEPE2_LABELS'` | 3 | Si es otro número, repórtalo y sigue: el commit 2 debe cubrir **todas** las ocurrencias que existan, no tres por decreto |
| `MAX_ENTIDADES = ` | `= 4` | Si ya dice 5, **DETENTE**: el encargo ya corrió |
| `grep -c "repeat(4"` | 2 | Si es otro número, repórtalo antes de editar |

Ante cualquier otra discrepancia no prevista entre lo medido y lo declarado,
detente y reporta antes de editar.

---

## 5. Commits

Localiza cada punto **por contenido**, nunca por número de línea.

### Commit 1 — Migración tipográfica (ya hecha, solo commitear)

Sin edición. El archivo ya está modificado en el árbol.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "style(motor): migra escala tipografica a variables CSS, restaura .app-title a 30px"
```

### Commit 2 — Nombre de territorio sin sufijo de dependencia

**Defecto:** el nombre de un territorio se compone como
`<comuna> · <etiqueta de dependencia>`, y la misma etiqueta se vuelve a mostrar
en la línea `meta` de la tarjeta y de la cabecera del supergrid. El texto sale
duplicado, y el nombre largo desborda la tabla y el SVG exportado.

**Cambios:**

- a) En `entidadesPorDefecto()`, el `name` pasa a ser solo el nombre de la
  comuna, sin el sufijo ` · <etiqueta>`.
- b) En el alta desde el modal, quita el mismo sufijo de las tres
  construcciones de `name` (alta por comuna, por región y la nacional). Se
  localizan con `grep -n '" · " + SimceData.DEPE2_LABELS'`.
- c) La rama `region` no existe en el `meta` de `EntityChip` y cae al `else`,
  con lo que el tipo se pierde. Agrégala con la misma forma que ya usa `slep`:
  `Región · ${entity.comunas.length} comunas`.

La dependencia sigue apareciendo, una sola vez, en el `meta`.

**Verificación con rama de detención:**

```bash
grep -c '" · " + SimceData.DEPE2_LABELS' /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html   # esperado: 0
grep -n 'kind === "region"' /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
```

Si el primero no da 0, **detente**.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "fix(motor): elimina duplicacion de la dependencia en el nombre del territorio"
```

### Commit 3 — Homogeneidad tipográfica

**Defecto:** tres bloques mezclan familia, tamaño y color sin criterio.

- a) `.entities-count` (el "N de M activas") usa familia body, peso 500 y
  `--fs-caption`, al lado de `.section-eyebrow` que es familia display, peso 700,
  `--fs-overline` y con tracking. Iguala `.entities-count` a la familia, el
  tamaño y el tracking de `.section-eyebrow`; que se diferencie solo por peso
  (500) y conserve `color: var(--fg-3)`.
- b) `.sg-gse-name` baja de `var(--fs-h4)` a `var(--fs-body)` y **conserva su
  color propio** (el contraste de color es deseado; el de tamaño no).
  `.sub-eyebrow` se alinea al estilo exacto de `.sg-gse-eyebrow`: familia
  display, peso 700, `var(--fs-overline)`, `var(--tracking-overline)`,
  `var(--fg-3)`. Si al leerlo en FASE 0 resulta que ya coincide, dilo en el
  reporte y no lo toques.
- c) `.hint-muted` pisa tamaño **y** color sobre `.hint-item`. Quítale ambos
  overrides: que herede los 14px y el `var(--fg-1)` del contenedor. El
  difuminado se queda **solo** en el cuadro `.hint-low-n`, cuyo `opacity: 0.45`
  no se toca.

**Verificación:** `grep` de `--fs-` en las reglas tocadas; ningún literal `px`
nuevo.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "style(motor): homogeneiza rotulos de seccion, etiquetas GSE y leyenda de graficos"
```

### Commit 4 — Desborde en tabla y en exportación SVG

**Defecto a.** En la tabla comparativa, `td.td-ent` es `position: sticky` y
hereda `white-space: nowrap` de `.data-table tbody td`. Un nombre largo no
envuelve: se sale de la celda y las columnas vecinas (también `sticky`, mismo
`z-index`) lo pintan encima por orden del DOM, con lo que el texto queda cortado
a pedazos. **Corrección:** en `th.th-ent` y `td.td-ent`, agrega
`max-width: 260px`, `white-space: normal` y `overflow-wrap: anywhere`. No
cambies `min-width` ni `z-index` ni el `background`.

**Defecto b.** En `construirSvgGraficos`, el nombre y el meta de cada cabecera
de territorio se dibujan sin truncar dentro de celdas de ancho fijo
(`CELL_W = 340`), y con varios territorios las cabeceras se superponen. El PNG
se rasteriza del mismo SVG, así que se corrige solo. **Corrección:** agrega un
helper local de truncado con puntos suspensivos y aplícalo al nombre y al meta.
Los presupuestos van como **constantes nombradas** junto a las otras constantes
de layout de esa función, no como números sueltos en la llamada, cada una con un
comentario que declare que es una aproximación calibrada a `CELL_W = 340`:

- nombre, dibujado a 14px en peso 800: **38** caracteres.
- meta, dibujado a 10px: **46** caracteres.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "fix(motor): evita desborde del nombre en la tabla y en la exportacion SVG"
```

### Commit 5 — Quinto territorio

- a) `MAX_ENTIDADES`: de 4 a 5.
- b) El mensaje del tope tiene el 4 **hardcodeado** dentro del `alert`.
  Interpólalo con `${MAX_ENTIDADES}`.
- c) El `supergrid` fija `repeat(4, minmax(0, 1fr))` mientras itera
  `entities.map`: con cinco territorios el quinto cae a una segunda fila,
  desalineado de sus gráficos. Pásalo a `entities.length`.
- d) `.entity-chip`: `max-width` de 340px a 250px, y `.entity-name` gana
  `overflow-wrap: anywhere`, para que cinco tarjetas quepan en una fila.

**Verificación con rama de detención:**

```bash
grep -n "repeat(4" /Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html
```

Debe quedar **una sola** ocurrencia, la de `.heat-scale-bar`: son las cuatro
bandas de la escala de color, no territorios. Si quedan dos, **detente**.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "feat(motor): permite comparar hasta 5 territorios"
```

---

## 6. FASE FINAL — Regeneración y verificación

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
Rscript -e 'source(here::here("30_procesamiento","33_generar_html.R"))'
md5 -q 40_salidas/motor_comparacion.html
ls -la 40_salidas/motor_comparacion.html
grep -c "fontSize: *[0-9]" 40_salidas/motor_comparacion.html
grep -o "font-size: *[0-9.]*px" 40_salidas/motor_comparacion.html | sort | uniq -c
grep -c "MAX_ENTIDADES = 5" 40_salidas/motor_comparacion.html
grep -c "repeat(4" 40_salidas/motor_comparacion.html
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado log --oneline -6
```

| Criterio | Esperado | Si difiere |
|---|---|---|
| Script de generación | exit 0 | **DETENTE**, reporta el error literal completo, no borres nada |
| `fontSize: <número>` | 0 | **DETENTE** |
| `font-size: Npx` en CSS | listado vacío | **DETENTE** |
| `MAX_ENTIDADES = 5` | 1 | **DETENTE** |
| `repeat(4` | 1 | **DETENTE** |
| `git status --short` | vacío | Si aparece el motor generado, tu `.gitignore` no es el declarado: repórtalo |
| `git log --oneline -6` | los 5 commits nuevos sobre el anterior | Repórtalo |

---

## 7. Log

Escribe un log en:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/AAAAMMDD_homogeneidad_y_quinto_territorio_log.md
```

con la fecha real del día. Contenido: la salida literal de FASE 0, qué cambió en
cada commit con su hash, las verificaciones de §5 y §6 con su resultado, y las
decisiones que tomaste ante ambigüedades.

**El log se deja sin commitear**, para revisión del titular antes de persistirlo.

---

## 8. Reporte final al chat

1. Salidas literales de FASE 0.
2. Los cinco hashes con el alcance de cada uno.
3. Las verificaciones de §5 y §6 con su valor medido.
4. Ruta del log.
5. Qué falló o sorprendió. **Si nada, dilo explícitamente.**

No hagas `push`. No toques `docs/index.html`. La revisión visual y el despliegue
son del titular.
