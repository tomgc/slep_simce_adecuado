# Traspaso de cierre — slep_simce_adecuado v28

**Proyecto:** slep_simce_adecuado
**Versión:** v28
**Fecha:** 2026-08-28
**Sesión:** 28 — Cierre de la migración tipográfica, quinto territorio, deuda del SVG, ordenación del repositorio, medición del panorama territorial y normalización del backlog
**Entorno:** macOS aarch64, Positron, R 4.5.2, `renv` (desincronizado, ver §2)
**Protocolo:** POLITICA v5.8, SETTINGS `> **Versión 34.**`
**`main` previo al cierre:** `542088c`
**Archivos principales modificados:** `30_procesamiento/33_motor_template.html`, `50_documentacion/activa/backlog_acumulativo.md`, `50_documentacion/activa/ESTADO.md`, `docs/index.html`

---

## 1. Resumen ejecutivo

Sesión larga y de alto rendimiento: 19 entradas de backlog y tres despliegues a
producción. Abrió saldando la deuda administrativa de s27 y siguió cerrando la
migración tipográfica que s27 había dejado a medias: el censo de s27 había
omitido una familia entera de declaraciones y su bloque `:root` quedó duplicado.
A partir de ahí se elevó el tope de comparación de 4 a 5 territorios, se
homogeneizaron rótulos, se corrigieron desbordes en tabla y exportación, se
migró la escala tipográfica del SVG a constantes JS y se ordenó el repositorio.
Se midieron los insumos de una funcionalidad nueva (panorama territorial), que
queda especificada y no construida. El cierre mismo destapó el hallazgo
estructural de la sesión: `backlog_acumulativo.md` llevaba 28 sesiones fuera de
POLITICA §10, y `/cierre` fue el primer verificador que lo midió.

Cinco encargos autónomos ejecutados, uno detenido por causa externa al
repositorio, tres despliegues verificados byte a byte.

---

## 2. Estado al cierre

**Funciona y está en producción** (`docs/index.html` = build `7dd16d92…`,
verificado con `cmp` contra `40_salidas/motor_comparacion.html`):

- Comparación de hasta 5 territorios, con grilla de gráficos dinámica.
- Escala tipográfica completa: interfaz por variables `--fs-*`, SVG por
  constantes `FS_SVG`. Cero literales fuera del D3 minificado vendorizado.
- Nombre del territorio sin duplicar la etiqueta de dependencia; tabla y
  exportación sin desbordes.
- Exportación PNG con `try/catch` y guarda de superficie; exportación SVG con
  truncado por constantes nombradas.
- Idempotencia del generador verificada con control positivo y respaldo: dos
  corridas consecutivas byte a byte idénticas.
- `backlog_acumulativo.md` conforme a POLITICA §10, con sus cinco secciones.

**No funciona / pendiente:**

- **`renv` desincronizado.** `openxlsx`, `Rcpp`, `zip` y `suitedoc` instalados y
  sin registrar en `renv.lock`. Bloquea `documentar.R` y
  `34_historico_pct_adecuado_costa_central.R`.
- **Suite standalone desfasada.** Los cuatro HTML siguen generados con el
  `documentar.R` anterior a la corrección de terminología del commit `6a1c8b6`.
- **`suitedoc` no existe en ningún remoto.** Vive solo en el disco del titular,
  dentro de `herramientas_dev`, que tiene 20 commits sin publicar y 13 entradas
  sucias. Es la causa raíz del bloqueo anterior y **es externa a este
  repositorio**.

**Delta respecto a v27:** 33 commits, tres despliegues.

---

## 3. Registro detallado de cambios

**Bloque A — Deuda administrativa de s27.** Anexo del delta 134-138 al backlog,
con una entrada retroactiva para el commit `65302c6` (los normativos dejan de
versionarse), que explica la discrepancia de tamaños que v27 §9 dejó declarada
sin investigar. `ESTADO.md` destilado con los seis campos de candado de SETTINGS
§2.1bis, que hasta entonces no tenía ninguno. Commits `31e35d7`, `1ccb4d9`.

**Bloque B — Cierre de la migración tipográfica.** El bloque `:root` de s27
estaba **duplicado**: las 10 definiciones ya existían antes de `d1d04f6`, y ese
commit añadió siete idénticas. Se consolidó al preexistente. `.app-title` volvió
de 28px a 30px vía `--fs-h1`, corrigiendo D-s27-2, que había mapeado a `--fs-h2`
bajo la premisa falsa de que no existía nivel display. Y se migraron los 8
literales `fontSize` inline React que el censo de s27 nunca inventarió. Commit
`7826f8e`.

**Bloque C — Presentación del territorio y quinto territorio.** Nombre sin
sufijo de dependencia (cuatro construcciones) más rama `region` en el `meta` de
`EntityChip` (`d2f75ee`). Homogeneidad de `.entities-count`, `.sg-gse-name` y
`.hint-muted` (`712a9e5`). Recorte del nombre en la tabla y truncado en el SVG
exportado (`c69335c`). `MAX_ENTIDADES` de 4 a 5, `alert` interpolado, `supergrid`
a `entities.length`, chip a 250px (`51ed157`). Eliminación de las celdas de
relleno del supergrid, que `51ed157` volvió obsoletas y que inyectaban filas
vacías con menos de cuatro territorios (`9e8ecdd`).

**Bloque D — Deuda del SVG y código muerto.** Las 18 declaraciones de tamaño de
letra de D3 y de objetos JS pasaron a 17 constantes nombradas en `FS_SVG`,
agrupadas en tres sub-objetos porque dos roles colisionan entre gráficos con
valores distintos. **Los valores se preservaron exactos**, verificado por
igualdad de multiconjunto. `depe2Label`, `--fs-display-1` y `--fs-display-2`
eliminados. Commits `df52516`, `89d2ac9`.

**Bloque E — Ordenación del repositorio.** `Motor SIMCE.html` renombrado a
`motor_simce.html` con `git mv`. Constancias `50_ordenacion_repositorio.md` y
`50_locale_utf8.md`. Los tres `verificar_*.R` **no se movieron**: resultaron no
versionados (`.gitignore` línea 28, patrón anclado a la raíz), de modo que
moverlos habría sido un cambio de política de versionado disfrazado de
ordenación. Commits `0871488`, `ec101b7`, `a340758`.

**Bloque F — Correcciones D1-D3.** El enlace "ver establecimientos" desbordaba su
tarjeta con contadores de cuatro dígitos: rótulo y flecha separados, rótulo con
elipsis y flecha con `flex-shrink: 0`. `exportarGraficosPNG` ganó `try/catch` y
guarda de superficie. `entidadesPorDefecto()` advierte por consola si el SLEP
excede el tope. Commits `8503745`, `a8386e6`, `72372b0`.

**Bloque G — Gobernanza.** `50_diseno_ramas_deteccion.md` con cuatro aprendizajes
sobre diseño de ramas de detención (`41f7026`), y
`50_datos_versionados_autorizados.md` con seis entradas que cubren las 27 rutas
de datos versionadas, exigido por el invariante I8 (`c7fb2ee`).

**Bloque H — Medición del panorama territorial.** Ver §10. Commits `2ecad9d`,
`c1ed238`.

**Bloque I — Normalización del backlog a POLITICA §10.** El primer intento de
cierre se detuvo en F2 de `/cierre`: faltaban tres de las cinco secciones que
POLITICA §10 exige (Objetivo del proyecto, Nota metodológica, Resumen
estadístico por sesión), la Clasificación temática vivía bajo otro nombre
(`## Taxonomía vigente`) reducida a leyenda de dos columnas, y el Detalle
cronológico existía como contenido sin sección contenedora, con sus 28 bloques
en `##`, lo que impedía toda inserción estructural. Se agregaron las tres
secciones ausentes, se amplió la Clasificación temática a cinco columnas con N°,
porcentaje y descripciones con ejemplos, se construyó el Resumen estadístico con
28 filas contadas del propio detalle, y los bloques cronológicos bajaron a
`###`. **Ninguna entrada cambió**: verificado por igualdad de md5 de la huella de
las 138 entradas y de las 17 líneas de delta, antes y después. Commits
`a441c98`, `542088c`.

---

## 4. Backlog acumulativo

19 entradas nuevas, 139-157. Total acumulado: 157. El archivo quedó conforme a
POLITICA §10 (ver Bloque I): sus invariantes I2 e I3 pasan a ser computables por
primera vez.

---

## 5. Bugs de la sesión

**Bug s28-1 — Filas vacías en el supergrid.** `51ed157` pasó la grilla a
`repeat(entities.length, …)` y dejó vivas las celdas de relleno
`Math.max(0, 4 - entities.length)`, que con menos de cuatro territorios caían a
una fila nueva. Detectado al reportarse un "4 hardcodeado residual"; la
corrección propuesta inicialmente (cambiar el 4 por `MAX_ENTIDADES`) habría
empeorado el defecto. **Regla aprendida:** cuando un contenedor pasa de fijo a
dinámico, el relleno que compensaba lo fijo es residuo, no parámetro. Corregido
en `9e8ecdd`.

**Bug s28-2 — Desborde del enlace de establecimientos.** El `white-space: nowrap`
añadido en esta misma sesión para evitar que la flecha quedara huérfana cambió un
salto de línea por un desborde de la tarjeta. **Regla aprendida:** un `nowrap`
sin `overflow` en algún ancestro no contiene, desborda. Corregido en `8503745`.

---

## 6. Aprendizajes y restricciones

**A-s28-1 — Rama de detención que no distingue lo inesperado de lo no
contemplado.** Tres encargos declararon "si `git status` no está limpio,
DETENTE" cuando el árbol traía untracked los propios archivos de encargo. La
rama se disparaba en el escenario nominal. Regla: declarar el **conjunto** de
estados esperados más una cláusula residual.

**A-s28-2 — Verificador de ausencia sin control positivo.** Un conteo de
literales a cero se cumple igual si los valores se preservaron que si todos se
reemplazaron. Regla: preservar exige **invariante medida antes y después**. Se
aplicó bien en la normalización del backlog, con md5 de la huella de entradas.

**A-s28-3 — El instrumento no matchea lo que se cree.** `grep` de BSD interpreta
`{…}` como intervalo. Regla: `-F` obligatorio, y validar el baseline.

**A-s28-4 — La premisa mide una cosa y afirma otra.** El escáner lista el disco,
no el índice de git (A20, incumplido por quien lo escribió); `grep -rl` prueba
que una cadena aparece, no que una función esté definida; y
`git log --reverse -1` aplica el `-1` **antes** de invertir, devolviendo el
commit más reciente, no el primero.

**A-s28-5 — La ausencia de una autorización explícita no es una autorización
tácita.** El invariante I8 llevaba pasando en verde por ausencia de comprobación.

**A-s28-6 — Una regla que mide contra la historia del archivo y otra que mide
contra una norma externa no se generalizan entre sí.** Ante la detención de F2,
se concluyó que el instrumento modelaba un backlog inexistente y se propuso
enmendarlo. Falso: las tres estructuras las fija POLITICA §10, norma escrita del
proyecto y anterior al instrumento. Regla: antes de declarar que una herramienta
está mal calibrada, comprobar si su referente es la historia del archivo o una
norma externa. Si es lo segundo, el desajuste lo tiene el archivo.

Los primeros cuatro están desarrollados en
`50_documentacion/activa/50_diseno_ramas_deteccion.md`, que conviene ampliar con
A-s28-6.

---

## 7. Decisiones de diseño

**D-s28-1 — El grupo personalizado no recibe tope de comunas.** Un grupo de
muchas comunas es un agregado legítimo, y el problema real (el contador
desbordando la tarjeta) se corrigió en el ancho. Alternativa descartada: imponer
un máximo, que habría sido un número mágico sin fundamento.

**D-s28-2 — El acoplamiento de `MAX_ENTIDADES` no se elimina, se hace ruidoso.**
El tablero no puede sembrar más territorios de los que admite. El defecto era el
silencio, no el recorte: se añadió `console.warn` y un comentario que declara la
relación.

**D-s28-3 — La escala del SVG preserva los valores exactos, sin piso de 12px.**
Las etiquetas de eje de un gráfico compacto son otro contexto que el texto de
interfaz. El refactor debía ser visualmente nulo, y esa fue su prueba.

**D-s28-4 — Los `verificar_*.R` no se mueven.** Moverlos a `10_utils/` los
sacaría del patrón anclado a la raíz y los volvería versionables, contra una
decisión documentada en el traspaso v20.

**D-s28-5 — Encargos y logs se versionan siempre.** Instrucción permanente del
titular. La plantilla de encargo de SETTINGS todavía instruye lo contrario.

**D-s28-6 — El backlog se normaliza a la norma; la taxonomía no se toca.** Ante
la detención de F2 había tres caminos: enmendar el instrumento, saltarse el
protocolo con un cierre manual, o normalizar el archivo. Se eligió el tercero
porque el referente de la regla es POLITICA §10. La taxonomía quedó **intacta**
pese a sus tres desviaciones (§10), porque reclasificar 138 entradas ya tageadas
choca con el invariante append-only y es decisión del titular.

---

## 8. Constantes y parámetros vigentes

| Constante | Valor | Archivo |
|---|---|---|
| `MAX_ENTIDADES` | 5 (antes 4) | `33_motor_template.html` |
| Escala tipográfica de interfaz | 8 variables `--fs-*` en `:root`, piso 12px | `33_motor_template.html` |
| Escala tipográfica del SVG | `FS_SVG`, 17 constantes en 3 sub-objetos, sin piso | `33_motor_template.html` |
| `PNG_SCALE` / `PNG_MAX_SUPERFICIE_PX` | 2 / 16.777.216 (nueva) | `33_motor_template.html` |
| Truncado de cabeceras del SVG | 38 caracteres (nombre), 46 (meta), calibrado a `CELL_W = 340` | `33_motor_template.html` |
| Umbral mínimo de alumnos | 10 (sin cambio) | `33_generar_html.R` |
| Filtro del universo utilizable | `is.na(marca)` y `nalu >= 10`, deja 140.345 filas | `10_utils.R:67` |
| md5 del motor publicado | `7dd16d922182df69e21ddb422a005bc7` | `docs/index.html` |

Años cubiertos (2014-2018, 2022-2025) y color por nivel: sin cambios, vigentes en
`31_leer_normalizar.R` y en la decisión `20260611_decision_color_por_nivel.md`.

---

## 9. Arquitectura de archivos

Escáner regenerado en el cierre. Cambios estructurales de la sesión: renombrado
de `Motor SIMCE.html` a `motor_simce.html`; cuatro documentos nuevos en
`50_documentacion/activa/` (`50_diseno_ramas_deteccion.md`,
`50_ordenacion_repositorio.md`, `50_locale_utf8.md`,
`50_datos_versionados_autorizados.md`); cinco encargos y seis logs nuevos;
`backlog_acumulativo.md` reestructurado a cinco secciones.

Compuerta de repositorio en la corrida previa al cierre: **7/9**, fallando I3
(commits sin pushear, que el propio cierre publica) e I5 (27 traspasos planos,
que la fase F6 archiva). I8 pasó tras declarar la lista de autorización.

**Desviación conocida:** dos encargos quedaron versionados en
`50_documentacion/andamios/` en lugar de `50_documentacion/activa/encargos/`.
Mover no estaba en la lista de autorizaciones del encargo que los versionó.
Pendiente de reubicación, ver §10.

**Limitación conocida del instrumento, declarada:** `commit_cierre` de
`ESTADO.md` se escribe con `542088c`, el último commit conocido al redactar el
paquete. El instrumento v11 establece que debería llevar el hash del commit del
log, que no existe cuando se redacta. La ascendencia se cumple igual, pero el
candado 0bis quedaría en verde aunque los commits del cierre no se publicaran.
Contrastar en la apertura de s29 contra los dos hashes del eco.

---

## 10. Pendientes y ruta sugerida

### Compuerta de dudas (4 registradas)

| # | supuesto | predicado | medición |
|---|---|---|---|
| 1 | El pipeline sigue siendo idempotente después de las correcciones D1-D3 | Dos corridas consecutivas de `33_generar_html.R` producen el mismo md5 | `cp` a `/tmp`, `Rscript -e 'source(here::here("30_procesamiento","33_generar_html.R"))'`, `cmp` |
| 2 | Excluir toda `marca` no nula equivale a excluir lo no representativo, también en la era de códigos numéricos | Las glosas del insumo definen los códigos 1 y 2 de `marca` y ambos implican exclusión | `grep -i "marca" 50_documentacion/activa/referencia_glosas_simce.md` y lectura de `20_insumos/auxiliares/glosas_simce_consolidado_simce.xlsx` |
| 3 | El error "Unsafe attempt to load URL" es una restricción del origen `file://` y no ocurre en el sitio publicado | La consola de `https://tomgc.github.io/slep_simce_adecuado/` no emite ese error al cargar | Abrir la URL publicada y revisar la consola |
| 4 | Los cuatro paquetes instalados sin registrar no afectan la reproducibilidad del motor publicado | `33_generar_html.R` y sus dependencias solo usan `here`, `arrow`, `dplyr` y `jsonlite`, los cuatro en `renv.lock` | `renv::status()` más `grep -n "library(\|::" 30_procesamiento/33_generar_html.R 10_utils/10_utils.R` |

### Auditoría de cierre (política 5.6)

- ¿Pipeline corre de cero sin intervención manual? → Sí, `33_generar_html.R`
  corrió limpio cuatro veces en la sesión.
- ¿Outputs reproducibles e idempotentes? → **Sí**, verificado por primera vez en
  el proyecto, con control positivo y respaldo. Acotado a esta máquina y este
  entorno.
- ¿Decisiones metodológicas como constantes nombradas? → Sí.
- ¿Nombres sin tildes, ñ ni espacios? → Sí, resuelto en esta sesión.
- ¿Guarda `asegurar_locale_utf8()` instalada? → **No.** El validador la
  referencia y la función no existe en el repositorio. Pendiente abajo.

### Inventario de pendientes

| Pendiente | Tipo | Complejidad | Contexto |
|---|---|---|---|
| Publicar `herramientas_dev` y registrar `suitedoc` con `git::` | bloqueante externo | Media | 20 commits sin publicar y 13 entradas sucias; sesión propia. Criterio de éxito: `renv::status()` sincronizado con `suitedoc` sin `Source: unknown` |
| Reparar `renv.lock` y regenerar la suite standalone | funcionalidad | Media | Encargo redactado y detenido: `encargo_entorno_y_suite_standalone.md`. Depende del anterior |
| Construir el panorama territorial | funcionalidad | Media-Alta | Especificado y medido, ver abajo |
| Reubicar dos encargos de `andamios/` a `activa/encargos/` | documentación | Trivial | Ver §9 |
| Desviación triple de taxonomía del backlog | decisión | Media | `D` al 1,4% (bajo el 2% de absorción); `UI` al 37,7% y `DOC` al 25,4% (sobre el 25% de subdivisión). Reclasificar choca con append-only |
| `.badge-traspaso` con `text-transform: uppercase` | decisión | Trivial | Commit condicional ya redactado en `encargo_deuda_tipografica_svg_y_codigo_muerto.md` |
| Guarda `asegurar_locale_utf8()` ausente | deuda | Baja | `10_validar_portabilidad.R:230` manda ejecutar una función inexistente; probablemente vive a nivel de cartera |
| `10_validar_portabilidad.R` no lo invoca nadie | deuda | Baja | Solo se ejecuta a mano vía `README.md:230` |
| Ampliar `50_diseno_ramas_deteccion.md` con A-s28-6 | documentación | Trivial | |
| `const sembradas` solo se usa dentro del `warn` | deuda técnica | Trivial | Código muerto introducido por `72372b0` |
| Los tres `verificar_*.R` en la raíz | decisión | Baja | Moverlos exige decidir su condición de ignorados |
| `D-color-nivel` no existe como identificador | deuda documental | Trivial | El traspaso v27 lo cita; el archivo real no lo menciona |
| Dos codificaciones de `marca` por época, sin diccionario | deuda documental | Baja | Texto en 2014/2016/2017, numérica en 2015 y 2018-2025 |
| Política de archivado de traspasos | decisión | Baja | El cierre archiva los 27 planos; queda decidir si `archivo/` se poda |
| Actualización anual SIMCE 2025/2026 | funcionalidad | Media-Alta | Bloqueada, insumos no cargados |

### Zonas frágiles

El motor concentra toda la lógica de presentación en un único archivo de 3.600
líneas que mezcla CSS, JSX y D3. Cada sesión que lo toca vuelve a pagar el costo
de localizar por contenido. No se propone dividirlo (la arquitectura de HTML
autocontenido es deliberada), pero conviene tenerlo presente al estimar.

### Especificación del panorama territorial (medida, no construida)

| Dimensión | Decisión |
|---|---|
| Pestañas | "Comparación entre territorios" (actual) y "Panorama territorial" (nueva). Abre en comparación |
| Selección | Un territorio a la vez, de cualquier tipo |
| Corte | Un nivel (4b o 2m) con sus dos pruebas lado a lado |
| Serie | Histórica completa |
| Gráfico | Barras apiladas al 100% por año, tres niveles de logro |
| Cifra | % y N |
| GSE | Combinado, ponderado por matrícula |
| Exportación | CSV, SVG y PNG |

**Fundamento metodológico.** Combinar todos los GSE está prohibido en la vista de
comparación y es legítimo aquí por la misma razón que invoca la Agencia: la
composición socioeconómica difiere entre territorios, así que una distribución
con GSE colapsado describe bien a uno y miente al ponerla al lado de otro. Por
eso "un solo territorio a la vez" no es una restricción de interfaz sino la
condición que hace válida la cifra.

**Hallazgos de la medición que condicionan el diseño:**

1. **No existe N publicado por nivel de logro.** Hay que derivarlo como
   `palu_eda_* × nalu / 100`. La reconstrucción es exacta al entero, pero **debe
   calcularse en precisión completa**: con el porcentaje redondeado a un decimal
   la suma se desvía hasta 4 estudiantes. El N se rotula como derivado.
2. **La supresión viene como tres ceros, no como `NA`.** 8.216 filas suman
   exactamente 0, todas con `nalu` entre 0 y 9. El filtro debe ser
   `is.na(suma) | suma == 0 | nalu < 10`.
3. **`nom_com_rbd` no es clave.** 1.018 nombres para 346 códigos, con
   truncamientos variables y **etiquetas de otra comuna**: el código 13113 (LA
   REINA) tiene filas rotuladas LAS CONDES y PROVIDENCIA. La clave es
   `cod_com_rbd`; los nombres legibles salen de `comunas_chile.parquet`.
4. **No hay que precalcular ni embeber nada.** Los payloads ya llevan los tres
   niveles y la matrícula; `getSeriesForEntity` ya devuelve `pct_ele` y
   `pct_ins`; `mkPunto` **ya normaliza a 100 exacto**. Falta una ruta de código:
   los generadores exigen un GSE válido, hay que iterar los cinco acumulando
   antes de llamar a `mkPunto`.
5. **Los tres colores ya existen**: `COLOR_ADEC`, `COLOR_ELEM`, `COLOR_INSUF`, y
   el motor ya apila.
6. **La vista necesita estado vacío explícito.** Siete comunas y 2.447
   establecimientos no tienen ninguna celda con dato en ningún año.
7. **GSE combinado no hace nada en establecimiento.** Cada celda es una fila con
   un solo GSE.
8. **Los siete tipos de territorio suman 100 ± 0,1** sin excepción.

**Sin medir:** el costo **en tiempo** del bucle de GSE combinado sobre 140.345
filas. Estimarlo sin ejecutar sería inventar.

### Ruta sugerida s29

1. **Publicar `herramientas_dev`.** Criterio de éxito: `suitedoc` instalable
   desde su remoto y `renv::status()` sincronizado. Desbloquea dos pendientes y
   no toca este repositorio.
2. **Construir el panorama territorial.** Criterio de éxito: la vista renderiza
   los siete tipos de territorio con estado vacío explícito, y la suma de los
   tres niveles da 100 en pantalla para una muestra verificada a mano.
3. **Encargo corto de decisiones triviales:** reubicar encargos, `sembradas`,
   `D-color-nivel`, A-s28-6.

**Conviene diferir:** la desviación de taxonomía y la política de archivado, que
son decisiones de portafolio y no urgen; y la actualización SIMCE, bloqueada.

---

## 11. Instrucciones específicas para la próxima sesión

- 🔒 `directorio_oficial_ee.csv`: no re-versionar con MRUN ni columnas de persona natural.
- 🔒 Estado por defecto = 4 comunas Costa Central · Servicio Local; el contador dice "4 de 5 activos".
- 🔒 Color por nivel, % Adecuado y corte de traspaso intocables.
- 🔒 Identificadores con raíz "entidad" permanecen; solo texto UI dice "territorio".
- 🔒 Escala de interfaz por `--fs-*`; escala del SVG por `FS_SVG`. Sin literales en ninguno.
- 🔒 El D3 minificado vendorizado no se toca: su `attr("font-size",10)` es la única ocurrencia legítima.
- 🔒 `cod_com_rbd` es la clave para agregar por comuna. **Nunca `nom_com_rbd`.**
- 🔒 El grupo personalizado no lleva tope de comunas (D-s28-1).
- 🔒 `backlog_acumulativo.md` conserva sus cinco secciones de POLITICA §10 y el detalle en `###`.
- ✅ `verificar = FALSE` y `standalone = TRUE` permanentes en `documentar.R`.
- ✅ `docs/index.html` se actualiza por **copia íntegra**, ejecutada por Claude Code, nunca por edición.
- ✅ Encargos y logs se versionan siempre (D-s28-5).
- ⚠️ NO declarar mal calibrada una herramienta sin comprobar antes si su referente es la historia del archivo o una norma externa (A-s28-6).
- ⚠️ `renv` desincronizado: cada `Rscript` emite el aviso. No es un fallo del pipeline.
- ⚠️ `suitedoc` no existe en ningún remoto. Nada de este repositorio lo arregla.
- ⚠️ Toda rama de detención se redacta según `50_diseno_ramas_deteccion.md` §3.
- ⚠️ `grep` de BSD: patrones con llaves exigen `-F`. `git log --reverse -1` devuelve el commit más reciente, no el primero.
- ⚠️ Contrastar `commit_cierre` contra los dos hashes del eco de cierre (§9).

---

## 12. Fragmentos de código de referencia

```js
// Escala tipográfica del SVG, s28. Valores preservados del estado previo:
// NO está sujeta al piso de 12px de la interfaz, porque las etiquetas de eje
// de un gráfico compacto son otro contexto que el texto de UI.
const FS_SVG = {
  sparkline:   { marcaTraspaso: 8, valorPunto: 10.5, anioEje: 9.5, marcaPreliminar: 10.5 },
  barras:      { tickEje: 9.5, valorSegmento: 11, valorBarra: 12, anioEje: 10.5, marcaPreliminar: 13 },
  exportacion: { titulo: 18, subtitulo: 11, nombreTerritorio: 14, metaTerritorio: 10,
                 rotuloGse: 9, valorGse: 13, celdaVacia: 11, subcabeceraCelda: 8 },
};
```

```bash
# Huella de invariante para una reestructuración que no debe alterar contenido.
# El conteo no sirve: pasa igual si el texto cambia. La igualdad de md5 si.
grep -E '^[0-9]+\. ' <archivo> > /tmp/huella_antes.txt && md5 -q /tmp/huella_antes.txt
# ...reestructurar...
grep -E '^[0-9]+\. ' <archivo> > /tmp/huella_despues.txt
cmp /tmp/huella_antes.txt /tmp/huella_despues.txt && echo "INTACTAS"
```

Los patrones estables del proyecto viven en
`50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.md`.

---

## 13. Errores del asistente (§2.2.15)

| # | Error | Consecuencia | Regla que lo evita |
|---|---|---|---|
| E-s28-1 | Redacté el encargo de ordenación afirmando que los tres `verificar_*.R` estaban versionados, citando el escáner | `git mv` falló en los tres; el encargo perdió su COMMIT 1 | El escáner lista el disco, no el índice (A20) |
| E-s28-2 | Propagué como medido que `nom_com_rbd` venía truncado a 5 caracteres | El problema real es de otra naturaleza y más grave | No repetir observaciones incidentales como medición |
| E-s28-3 | Escribí tres encargos con ramas que se disparaban en el escenario nominal, y un verificador de preservación ciego a cambios de valor | Detenciones falsas; una verificación habría pasado en verde con los valores alterados | A-s28-1 y A-s28-2 |
| E-s28-4 | Recomendé el cellar de `renv` sin verificar la semántica de `vcs.ignore.cellar` | Recomendación equivocada, corregida después | Verificar antes de opinar sobre configuración ajena |
| E-s28-5 | Ante la detención de `/cierre`, improvisé un procedimiento de cierre propio | Redacté un encargo que habría cementado la desviación y documentado el incumplimiento como "convención real" | El protocolo vive en la knowledge base; se lee, no se sustituye |
| E-s28-6 | Acepté sin contrastar el diagnóstico de que el instrumento estaba mal calibrado | Habría enmendado la herramienta correcta en vez del archivo desviado | A-s28-6 |
| E-s28-7 | Puse `git log --reverse -1` en el encargo de normalización | Habría fechado el origen del proyecto en agosto de 2026 en vez de mayo | A-s28-4 |
| E-s28-8 | Anuncié 29 eliminaciones esperadas olvidando las 9 filas de tabla que el propio encargo mandaba reescribir, y dije "cuatro columnas" enumerando cinco | Criterio de verificación incompleto y ambigüedad de redacción | Recorrer el camino nominal antes de entregar |

Ocho errores en una sesión de 19 entradas. Cinco son de la misma familia:
escribir sobre estado de archivo que no medí, o verificar el síntoma en vez de
la afirmación.

---

## 14. Reapertura

**Nombre del chat:** `slep_simce_adecuado, sesión 29`

**Mensaje de apertura:**
> Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo (POLÍTICA + SETTINGS vigentes) vive en la knowledge base; léelo desde ahí. Adjunto el traspaso v28 y el escáner actual.

**Documentos para la próxima sesión:**

*En knowledge base (no adjuntar):* `POLITICA_PROYECTO.md` v5.8,
`SETTINGS_Y_PROMPTS_OPERACIONALES.md` v34.

*Adjuntar:* `traspaso_cierre_v28.md`, `estructura_actual.md`.
