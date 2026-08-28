# Log — Normalización de `backlog_acumulativo.md` a POLITICA §10

**Fecha:** 2026-08-28
**Encargo:** `50_documentacion/andamios/encargo_normalizar_backlog_politica10.md`
**Ejecutor:** Claude Code (Opus 5), sesión 28
**Commit del cambio:** `a441c98`
**Archivo modificado, único:** `50_documentacion/activa/backlog_acumulativo.md` (287 → 362 líneas)

---

## 1. Por qué fue necesaria esta normalización

### El fallo

El instrumento `/cierre` (`cierre_sesion_autonomo_cc_v11.md`) se detuvo en su fase
**F2**, regla de detención 7.2, al intentar cerrar la sesión 28. F2 resuelve sus
tres inserciones por posición estructural y exige tres encabezados en el archivo
destino:

| Inserción | Encabezado exigido | Estado antes de este encargo |
|---|---|---|
| Bloque de sesión nuevo | sección `Detalle cronológico` | ausente como encabezado; el contenido existía suelto en 28 bloques `##` |
| Fila del resumen | tabla `Resumen estadístico por sesión` | ausente por completo |
| Fila del delta | tabla `Delta del backlog` | ausente como tabla; existían 17 líneas en prosa `**Delta del backlog:** …` |

Sin esos encabezados, F2 no puede posicionar, y los invariantes **I2**
(cuadratura: las filas del resumen suman el total nuevo) e **I3** (filas del
resumen = previas + 1) de su fase F4 son directamente **incomputables**.

### La inversión de diagnóstico que la precedió

El reporte de detención del cierre concluyó que **el instrumento modelaba un
backlog que este proyecto no tiene**, y ofreció como vía preferente enmendar el
instrumento para que aceptara la convención real del archivo, citando en su apoyo
el criterio de éxito del propio v11 ("si el fallo fue de cómputo, quedó trabajo
mecánico sin automatizar y este instrumento debe corregirse, no el redactor") y la
lección de la v10 sobre reglas que miden cuánto se parece un backlog al backlog
modelado.

**Ese diagnóstico estaba invertido.** El instrumento no inventó su estructura: la
toma de `POLITICA_PROYECTO.md` §10, que fija las cinco secciones y su orden, y de
`SETTINGS_Y_PROMPTS_OPERACIONALES.md` §2.2.5, que define el contenido de cada una.
Las tres "estructuras que el instrumento espera" son norma escrita del proyecto
desde antes que el instrumento existiera. El archivo llevaba 28 sesiones fuera de
norma y nadie lo había medido contra §10; el cierre fue el primer verificador que
lo hizo, y acertó.

El error de razonamiento fue tomar *"el archivo real no tiene esto"* como
evidencia de *"la norma no aplica"*, cuando la norma es exactamente el estándar
contra el cual el archivo real debía medirse. La v10 corrigió la regla 7.3 por
medir contra un catálogo hipotético en vez de contra la historia del archivo;
7.2 es distinta, porque su referente **sí** es normativo y externo. Aplicar la
lección de 7.3 a 7.2 fue una generalización indebida.

**Consecuencia para `herramientas_dev`:** la enmienda del instrumento que ese
reporte proponía habría degradado una detención correcta a falso positivo, y
habría propagado a otros proyectos la tolerancia a backlogs fuera de §10. El caso
queda documentado aquí para la sesión de `herramientas_dev`: **antes de enmendar
una rama de detención por "no aplica a este proyecto", hay que verificar si lo que
la rama exige está escrito en la norma del proyecto.** Si lo está, el que se
enmienda es el archivo.

---

## 2. FASE 0 — Medición. Salida literal

```
$ git status --short --branch
## main...origin/main [ahead 1]
?? 50_documentacion/andamios/encargo_normalizar_backlog_politica10.md
?? 50_documentacion/andamios/paquete_cierre_v28.md

$ wc -l 50_documentacion/activa/backlog_acumulativo.md
     287 50_documentacion/activa/backlog_acumulativo.md

$ grep -n '^#\{1,3\} ' 50_documentacion/activa/backlog_acumulativo.md
1:# Backlog histórico acumulativo — slep_simce_adecuado
7:## Taxonomía vigente
21:## Sesión 1 — Scaffold, pipeline de datos y UI v2 (traspaso v01)
28:## Sesión 2 — Dimensión depe2, sleps_chile y rediseño UI (traspaso v02)
35:## Sesión 3 — Bugs UI, exportación CSV y UX de tabla (traspaso v03)
42:## Sesión 4 — Orquestador y entidades región/establecimiento (traspaso v04)
49:## Sesión 5 — Exportación SVG, tooltip interactivo y escáner (traspaso v05)
57:## Sesión 6 — Auditoría de agregación y entidad nacional (traspaso v06)
63:## Sesión 7 — Portabilidad cross-OS y cierre de deuda técnica (traspaso v07)
69:## Sesión 8 — Bugs UX del motor y warning de pipeline (traspaso v08)
76:## Sesión 9 — Publicación y gobernanza (traspaso v09)
85:## Sesión 10 — Documentación visual/conceptual y simplificación UI (traspaso v10)
94:## Sesión 11 — Limpieza CSS, POLITICA v4, exportación PNG y consolidación del backlog (traspaso v11)
104:## Sesión 12 — Compresión gzip, SLEP traspaso 2026 y auditoría de supresión (traspaso v12)
115:## Sesión 13 — Auditoría pre-lanzamiento (traspaso v13)
136:## Sesión 14 — UI/UX del motor y toggle real de tres niveles (traspaso v14)
160:## Sesión 15 — Ajustes finos de UI: color fijo por nivel y default Adecuado (traspaso v15)
177:## Sesión 16 — Cierre en producción, auditoría depe4 y licencia Apache 2.0 (traspaso v16)
189:## Sesión 17 — Segmentación visual pre/post traspaso (traspaso v17)
197:## Sesión 18 — Deploy de la segmentación a GitHub Pages (traspaso v18)
203:## Sesión 19 — Gobernanza 4b/depe4 y suite suitedoc (traspaso v19)
211:## Sesión 20 — Documentación y gobernanza: decisión 4b/depe4, marcas de suite y reconstrucción del backlog (traspaso v20)
220:## Sesión 21 — Mantenimiento documental y cumplimiento Ley 21.719 (traspaso v21)
229:## Sesión 22 — Suite de documentación standalone offline (traspaso v22)
237:## Sesión 23 — Estado por defecto del motor y auditoría de suite standalone (traspaso v23)
246:## Sesión 24 — Cierre de backlog y pendientes de documentación (traspaso v24)
255:## Sesión 25 — Renombrado UI "entidad" → "territorio" y reparación de backlog truncado (traspaso v25)
264:## Sesión 26 — Auditoría de deuda heredada y sidequest histórico % Adecuado (traspaso v26)
274:## Entre sesiones 26 y 27 — cambio sin traspaso (registrado retroactivamente en s28)
280:## Sesión 27 — Terminología de la suite y escala tipográfica del motor (traspaso v27)

$ git log --reverse -1 --format='%ad' --date=format:'%B de %Y'
August de 2026
```

**Estados esperados: los cuatro se cumplen.** 287 líneas; 1 `#` y 29 `##` (uno de
taxonomía más 28 bloques cronológicos); cero `###`; los dos untracked son el
paquete de cierre y este encargo, que se reportan y no detienen. Ningún archivo
versionado modificado, así que la cláusula residual no se dispara. No existían
encabezados `###` ni ninguna de las tres secciones ausentes: el encargo no había
corrido antes.

### Defecto medido en el comando de fecha del encargo

El comando `git log --reverse -1` **no devuelve el primer commit**. Git aplica el
límite `-1` antes de invertir el orden, de modo que devuelve el commit **más
reciente**:

```
$ git log --reverse -1 --format='%h %ad %s' --date=short
c7fb2ee 2026-08-27 docs(gobernanza): declara los datos publicos versionados autorizados (I8)

$ git log --format='%h %ad %s' --date=short | tail -1
f07c4d9 2026-05-26 Scaffold inicial del proyecto
```

El primer commit real es `f07c4d9`, del **2026-05-26**. Haber sustituido el
placeholder por lo que el comando produce habría escrito *"En desarrollo desde
agosto de 2026"* en un documento permanente, afirmando como fecha de inicio del
proyecto la fecha de cierre de la sesión en curso: falso por tres meses.

**Resolución.** Se usó la magnitud que el encargo **nombra** ("la fecha del primer
commit"), no la que su comando **produce**. El texto quedó con `mayo de 2026`.

Nota adicional: el locale `es_ES.UTF-8` no está instalado en esta máquina, así que
`--date=format:'%B de %Y'` rinde `May de 2026` (mes en inglés con preposición en
español) aun apuntando al commit correcto. El nombre del mes se escribió a mano.

Este defecto es un caso de **A-s28-4** ("la premisa mide una cosa y afirma otra"):
el comando medía el último commit y el encargo afirmaba que medía el primero.

---

## 3. FASE 1 — Huella previa. Salida literal

```
$ grep -E '^[0-9]+\. ' 50_documentacion/activa/backlog_acumulativo.md > /tmp/backlog_entradas_antes.txt
$ wc -l /tmp/backlog_entradas_antes.txt
     138 /tmp/backlog_entradas_antes.txt
$ md5 -q /tmp/backlog_entradas_antes.txt
f781d9a0b5c6507e6e3e93a5c8d9f136

$ grep -E '^\*\*Delta del backlog' 50_documentacion/activa/backlog_acumulativo.md > /tmp/backlog_deltas_antes.txt
$ wc -l /tmp/backlog_deltas_antes.txt
      17 /tmp/backlog_deltas_antes.txt
$ md5 -q /tmp/backlog_deltas_antes.txt
780c97ac13c8da8af107670cfdfb226a
```

138 entradas y 17 líneas de delta, como el encargo espera. El
`backlog_total_previo: 138` que declara el paquete de cierre calza con el disco.

Respaldo íntegro adicional del archivo original en `/tmp/backlog_ORIGINAL.md`,
md5 `5732f62072c1eca37d0b29193e089543`. No lo pedía el encargo; se tomó por
prudencia antes de la primera escritura.

---

## 4. FASE 2a — Reparto por categoría

**Comando que produjo cada cifra.** Un único script Python sobre el archivo,
que agrupa el texto completo de cada entrada numerada (incluidas las que ocupan
varias líneas, como la 57), le asigna **un solo** código reconociendo las dos
formas de tag vigentes en el archivo —`N. [X]` inicial en las entradas 57-138 y
`[X]` final en las entradas 1-56— y marca como anomalía toda entrada sin tag, con
dos tags distintos, o con un código no declarado en la taxonomía:

```python
ini = re.match(r'^\d+\. \[([A-Za-z]+)\]', txt)   # forma inicial
fin = re.search(r'\[([A-Za-z]+)\]\s*$', txt)     # forma final
```

| Código | Categoría | N° | % sobre 138 |
|---|---|---:|---:|
| P | Pipeline R | 13 | 9,4% |
| UI | Motor HTML / React / D3 | 52 | 37,7% |
| D | Datos / Insumos | 2 | 1,4% |
| DOC | Documentación | 35 | 25,4% |
| REPO | Gobernanza del repo / Despliegue | 21 | 15,2% |
| Infra | Infraestructura (escáner, orquestador, CI) | 6 | 4,3% |
| DT | Deuda técnica | 9 | 6,5% |
| **Total** | | **138** | **100,0%** |

```
entradas detectadas: 138
TOTAL    138 100.0%
anomalías: ninguna
```

La suma da **138** exactas. Cero entradas sin tag, cero con dos tags, cero con
código no declarado. La condición de detención de la FASE 2a no se dispara.

---

## 5. FASE 2b — Resumen estadístico y contraste con los tramos declarados

Los `N° de cambios` se **contaron** de las entradas numeradas de cada bloque; no
se copiaron de las líneas de delta. Después se contrastaron contra ellas.

```
Sesión  Trasp.   contado declarado   tramo contado   tramo declarado  coincide
1       v01            4         —             1–4                 —  (sin delta)
2       v02            4         —             5–8                 —  (sin delta)
3       v03            4         —            9–12                 —  (sin delta)
4       v04            4         —           13–16                 —  (sin delta)
5       v05            5         —           17–21                 —  (sin delta)
6       v06            3         —           22–24                 —  (sin delta)
7       v07            3         —           25–27                 —  (sin delta)
8       v08            4         —           28–31                 —  (sin delta)
9       v09            6         —           32–37                 —  (sin delta)
10      v10            6         —           38–43                 —  (sin delta)
11      v11            7         —           44–50                 —  (sin delta)
12      v12            6         6           51–56             51–56  SÍ
13      v13            4         4           57–60             57–60  SÍ
14      v14           19        19           61–79             61–79  SÍ
15      v15           12        12           80–91             80–91  SÍ
16      v16            7         7           92–98             92–98  SÍ
17      v17            3         3          99–101            99–101  SÍ
18      v18            1         1         102–102               102  SÍ
19      v19            3         3         103–105           103–105  SÍ
20      v20            4         4         106–109           106–109  SÍ
21      v21            4         4         110–113           110–113  SÍ
22      v22            3         3         114–116           114–116  SÍ
23      v23            4         4         117–120           117–120  SÍ
24      v24            4         4         121–124           121–124  SÍ
25      v25            4         4         125–128           125–128  SÍ
26      v26            5         5         129–133           129–133  SÍ
—       —              1         1         134–134               134  SÍ
27      v27            4         4         135–138           135–138  SÍ
TOTAL                138
discrepancias contado-vs-declarado: ninguna
bloques: 28
```

**Constatación exigida por el encargo: los 17 tramos declarados coinciden, uno a
uno, con lo contado.** Ninguna discrepancia. Total 138.

Las sesiones 1-11 no tienen línea de delta: sus cifras salen exclusivamente del
conteo. La columna `Modelo` consta solo para las sesiones 13 (`Fable 5`) y 14
(`Opus 4.8`); las 26 restantes quedaron en `no registrado` y **no se infirieron**.
El bloque `Entre sesiones 26 y 27` va como fila final separada antes del total,
con `Sesión` = `—`, según SETTINGS §2.2.5.

La sesión 28 **no** se agregó: esa fila la inserta `/cierre` en su F2.

La tabla tal como quedó en el archivo está en `## Resumen estadístico por sesión`,
líneas 60-91.

---

## 6. FASE 3 — Reestructuración

Orden final, con los cinco encabezados `##` y su línea:

```
$ grep -n '^## ' 50_documentacion/activa/backlog_acumulativo.md
9:## Objetivo del proyecto
26:## Nota metodológica
47:## Clasificación temática
60:## Resumen estadístico por sesión
94:## Detalle cronológico
```

Coincide con el orden canónico de POLITICA §10.

**Decisiones de ejecución:**

- **Separador `---`.** Estaba en la línea 19, cerrando todo lo previo al detalle
  cronológico. Tras la reestructuración el preámbulo se reduce al título y las
  tres viñetas, porque la taxonomía pasó a ser sección propia. El separador se
  conservó en su función declarada de cierre del preámbulo, ahora en la línea 7,
  inmediatamente antes de `## Objetivo del proyecto`. No se eliminó.
- **Tabla de la Clasificación temática.** El encargo pide "ampliar a cuatro
  columnas" y a continuación enumera cinco (`Código`, `Categoría`, `N°`, `%`,
  `Descripción y ejemplos`). Se implementaron las **cinco enumeradas**: la
  enumeración es inequívoca y el "cuatro" es un lapsus de redacción.
- **Separador decimal.** Los porcentajes se escribieron con coma (`9,4%`),
  convención numérica chilena vigente en el proyecto. La primera escritura salió
  con punto en las filas y coma en el total; se unificó a coma antes del commit.
- **Los siete códigos y sus nombres de categoría se conservaron literales.** La
  taxonomía no se modificó.
- **La línea de Cobertura no se tocó.** Sigue diciendo `sesiones 1–26`, stale a
  propósito: es el rótulo R3 del catálogo del instrumento y lo actualiza `/cierre`
  en su F3.

---

## 7. FASE 4 — Verificación del invariante mayor. Salida literal

```
$ md5 -q /tmp/backlog_entradas_antes.txt
f781d9a0b5c6507e6e3e93a5c8d9f136
$ md5 -q /tmp/backlog_entradas_despues.txt
f781d9a0b5c6507e6e3e93a5c8d9f136
$ cmp /tmp/backlog_entradas_antes.txt /tmp/backlog_entradas_despues.txt && echo "ENTRADAS INTACTAS" || echo "ENTRADAS ALTERADAS"
ENTRADAS INTACTAS
$ cmp /tmp/backlog_deltas_antes.txt /tmp/backlog_deltas_despues.txt && echo "DELTAS INTACTOS" || echo "DELTAS ALTERADOS"
DELTAS INTACTOS
$ grep -c '^### Sesión\|^### Entre sesiones' 50_documentacion/activa/backlog_acumulativo.md
28
$ grep -c '^## ' 50_documentacion/activa/backlog_acumulativo.md
5
$ git diff --numstat 50_documentacion/activa/backlog_acumulativo.md
115	40	50_documentacion/activa/backlog_acumulativo.md
```

| Criterio | Esperado | Medido | Veredicto |
|---|---|---|---|
| `cmp` de entradas | `ENTRADAS INTACTAS`, md5 idénticos | `ENTRADAS INTACTAS`, `f781d9a0…` = `f781d9a0…` | verde |
| `cmp` de deltas | `DELTAS INTACTOS` | `DELTAS INTACTOS` | verde |
| Bloques en `###` | 28 | 28 | verde |
| Encabezados `##` | 5, en el orden canónico | 5, en el orden canónico | verde |
| `numstat` | eliminaciones solo por los 29 encabezados | **40 eliminaciones** | reportado abajo |

### Desglose de las 40 eliminaciones

El encargo preveía 29. La clasificación línea a línea de las 40 líneas eliminadas
del diff:

```
  28  encabezado ## degradado a ###
   1  encabezado ## renombrado (## Taxonomía vigente)
   9  fila de la tabla de taxonomía (reemplazada por la de 5 columnas)
   0  separador ---
   2  línea en blanco
   0  OTRO — REVISAR
  40  TOTAL

¿alguna línea de entrada o de delta entre las eliminadas? 0
```

Las 11 eliminaciones no previstas se explican íntegras y son consecuencia directa
de instrucciones del propio encargo:

- **9 líneas** son la tabla de taxonomía anterior (encabezado, separador y siete
  filas de dos columnas), que la FASE 3 punto 4 manda reescribir a cinco columnas.
  El encargo contó los encabezados pero no las filas de la tabla que él mismo
  ordena ampliar.
- **2 líneas en blanco** de la reestructuración del preámbulo.

**Cero entradas y cero líneas de delta entre las eliminadas**, confirmado por
grep independiente además del `cmp`. El invariante mayor se sostiene.

---

## 8. FASE 5 — Commit

```
$ git status --short
 M 50_documentacion/activa/backlog_acumulativo.md
?? 50_documentacion/andamios/encargo_normalizar_backlog_politica10.md
?? 50_documentacion/andamios/paquete_cierre_v28.md

$ git add 50_documentacion/activa/backlog_acumulativo.md
$ git status --short
M  50_documentacion/activa/backlog_acumulativo.md
?? 50_documentacion/andamios/encargo_normalizar_backlog_politica10.md
?? 50_documentacion/andamios/paquete_cierre_v28.md

$ git commit -m "docs(backlog): normaliza la estructura a las cinco secciones de POLITICA 10"
[main a441c98] docs(backlog): normaliza la estructura a las cinco secciones de POLITICA 10
 1 file changed, 115 insertions(+), 40 deletions(-)
```

Sin `git add .`. Ni el paquete de cierre ni el `ESTADO.md` ni los traspasos fueron
tocados. **No se hizo push.**

---

## 9. Nota sobre la taxonomía — decisión del titular, no ejecutada

SETTINGS §2.2.5 pide para la Clasificación temática **entre 8 y 15 categorías**,
subdividir la que supere el 25% y absorber la que quede bajo el 2% tras varias
sesiones. Lo medido:

| Condición de §2.2.5 | Estado real |
|---|---|
| Entre 8 y 15 categorías | **7** — una por debajo del mínimo |
| Ninguna sobre el 25% | **UI 37,7%** y **DOC 25,4%** la superan |
| Ninguna bajo el 2% | **D 1,4%** la incumple |

Tres desviaciones, no una. El encargo anticipaba la de `D` y no las dos de exceso.

**No se ejecutó ningún ajuste.** Subdividir UI o DOC, o absorber D, obliga a
reclasificar entradas ya tageadas —52 y 35 respectivamente— y el invariante mayor
de este encargo prohíbe expresamente reclasificar. Es una decisión del titular con
implicancias sobre las 138 entradas del histórico.

---

## 10. Lo que quedó sin verificar, y por qué

1. **Que `/cierre` ahora pase su F2.** No se ejecutó: el encargo lo prohíbe
   expresamente y el titular lo reiteró. La normalización satisface las tres
   condiciones estructurales que F2 exige y vuelve computables I2 e I3, pero eso
   es una inferencia sobre el instrumento, no una medición. **Se comprueba
   corriendo el cierre.**
2. **El texto de las secciones nuevas es autoría del encargo, no verificada contra
   el estado real del proyecto.** Los tres párrafos de `## Objetivo del proyecto`
   y los cuatro de `## Nota metodológica` se transcribieron literales, como manda
   el encargo. No se contrastaron contra el README, los traspasos ni el código:
   afirmaciones como "React 18 y D3 v7", "hasta cinco territorios" o el ámbito de
   uso se dan por buenas por venir del encargo. La única cifra que sí se verificó
   —y se corrigió— fue la fecha de inicio.
3. **La reducción de los `Foco` a tres-seis palabras es autoría de esta
   ejecución.** Se derivaron del título de cada bloque, que es la fuente que el
   encargo señala, pero la elección de palabras no tiene verificador programático.
4. **La columna `Modelo` es irrecuperable para 26 de 28 filas.** El dato no existe
   en el repositorio fuera de las líneas de delta 134 y 158 del archivo previo. No
   se infirió, según instrucción expresa.
5. **La línea de Cobertura sigue stale por diseño** (`sesiones 1–26` con el
   archivo cubriendo hasta la 27). Queda para F3 de `/cierre`.
6. **No se verificó el renderizado del markdown.** Las dos tablas nuevas son
   anchas —la de Clasificación temática lleva descripciones largas en su quinta
   columna— y no se comprobó cómo se ven en GitHub ni en un visor local.

---

## 11. Discrepancia de ruta del encargo

El encargo declara en su cabecera el destino
`50_documentacion/activa/encargos/encargo_normalizar_backlog_politica10.md`, y el
`git add` de su FASE 6 usa esa ruta. El archivo **no está ahí**: está en
`50_documentacion/andamios/encargo_normalizar_backlog_politica10.md`, ruta con la
que el titular lo entregó y única coincidencia en el repositorio.

Se versionó desde su ubicación real. **No se movió**: mover archivos no figura en
la lista cerrada de autorizaciones de la §2 del encargo, y un `git mv` no
solicitado sobre un archivo que otro documento referencia por ruta es
exactamente el tipo de cambio silencioso que el proyecto viene evitando. Queda a
decisión del titular si el encargo debe migrar a `activa/encargos/`.
