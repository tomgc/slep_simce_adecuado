# Decisión: color fijo por nivel de logro (no por entidad)

- **Fecha:** 2026-06-11
- **Sesión:** 15 (replicada como archivo de decisión en sesión 16)
- **Estado:** vigente
- **Componente afectado:** `30_procesamiento/33_motor_template.html` (motor de comparación)
- **Referencia:** traspaso v15, decisión D15-1; instrucción 🔒 §12

## Contexto

Hasta v14, el motor de comparación usaba un esquema **"color = entidad"**: el
color asignado a cada entidad (comuna, SLEP, región o grupo personalizado)
representaba simultáneamente su identidad y su % en estándar Adecuado. La línea
de trayectoria, los puntos, las etiquetas de porcentaje, las barras y los
swatches del tooltip se dibujaban con `entity.color`.

Al introducirse el desglose de tres niveles de logro (Adecuado, Elemental,
Insuficiente), ese esquema generaba una incoherencia semántica: un mismo nivel
de logro aparecía en colores distintos según la entidad, pese a representar lo
mismo. El usuario lo expresó directamente: "un mismo nivel no puede tener
distintos colores si representa lo mismo".

## Decisión

Adoptar **color fijo por nivel de logro**, idéntico en todas las entidades:

| Nivel | Constante | Color |
|---|---|---|
| Adecuado | `COLOR_ADEC` | `#0C4682` |
| Elemental | `COLOR_ELEM` | `#6BA0CE` |
| Insuficiente | `COLOR_INSUF` | `#79204F` |

`entity.color` queda reducido a **identidad de entidad únicamente**: swatch de
tarjeta, encabezado del supergrid, exportación y borde de ficha. Nunca vuelve a
codificar el valor del dato en el dibujo de series.

## Alternativas consideradas

- **Opción A (statu quo de v14):** mantener "color = entidad = Adecuado" y solo
  diferenciar Elemental/Insuficiente con otros colores. Descartada: preserva la
  incoherencia semántica (el mismo nivel Adecuado se vería distinto por
  entidad) y mezcla dos ejes de significado (identidad y logro) en una sola
  variable visual.
- **Opción B (elegida):** color fijo por nivel; identidad sostenida por nombre,
  swatch y borde de ficha.

## Justificación

La legibilidad semántica del nivel de logro prima sobre la densidad de
identificación por color. El lector compara desempeño entre entidades: que el
azul de Adecuado sea siempre el mismo permite leer el nivel de un vistazo sin
recalibrar por entidad. La identidad no se pierde: se redistribuye a nombre,
swatch y borde de ficha, canales suficientes con el tope de 4 entidades
simultáneas (`MAX_ENTIDADES`).

## Tensión resuelta

Legibilidad semántica del nivel (favorecida) vs. distinción de entidad por color
de línea (sacrificada). La compensación (nombre + swatch + borde de ficha)
mantiene la distinción de entidad por canales no cromáticos en el trazo del
dato.

## Implicancia

- Invariante 🔒: cualquier sesión futura que toque el dibujo de series usa
  `COLOR_ADEC` para Adecuado, jamás `entity.color`.
- El fix de asignación de color por lote (bug 15-1) permanece válido para los
  swatches y bordes de identidad, aunque el cambio de esquema lo haya superado
  parcialmente en el trazo de series.
