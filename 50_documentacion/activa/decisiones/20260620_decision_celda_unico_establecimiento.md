# Decisión: celdas con un único establecimiento (`n_estab = 1`) no se suprimen

- **ID:** D-celda-unico-establecimiento
- **Fecha:** 2026-06-20
- **Origen:** pendiente de gobernanza 4b/depe4 heredado de v18, evaluado y
  cerrado en la sesión 19 (backlog #103); este archivo formaliza ese cierre.
- **Decisión vinculada:** `20260611_decision_nombres_establecimientos.md`
  (D-nombres, sesión 13), de la que esta decisión es corolario.
- **Estado:** vigente.

## Contexto

Durante la auditoría de prelanzamiento se observó que una celda del motor
(cruce comuna × GSE en 4° básico, filtrada a una dependencia con un solo
establecimiento, `n_estab = 1`) podría permitir identificar a ese
establecimiento individual. La observación se planteó como posible riesgo de
gobernanza y quedó como pendiente al cierre de v18.

Al evaluarla en la sesión 19 se constató que el supuesto subyacente (que el caso
4b/depe4 era una exposición singular) es incorrecto: el motor muestra resultados
por establecimiento **por diseño y de forma general**, no solo en esa celda.

## Hallazgo

Leído el motor (`33_motor_template.html`):

- `cod_depe2` es un eje de segmentación real (selector "Dependencia" +
  `generateSeriesByDepe`), no un artefacto.
- Cualquier punto de serie con `n_estab === 1` (en cualquier nivel, no solo
  4b/depe4) ya expone el RBD vía tooltip ("un solo establecimiento (RBD …)") y
  el nombre vía el popup "Ver establecimientos".

El riesgo de identificación de un establecimiento individual, por tanto, no es
una propiedad de la celda observada: es una propiedad **general** del motor,
deliberada y transversal.

## Decisión

No se implementa supresión de celdas por `n_estab`. Mostrar resultados por
establecimiento individual es deliberado y normativamente fundado.

## Justificación

D-nombres ya estableció que la restricción de §6.4 de la política (Condiciones
de Uso de Bases de Datos de la Agencia: no identificar establecimientos por
nombre) aplica a las **bases por estudiante** (microdatos enmascarados), que
este proyecto no usa, y **no** a las **bases por establecimiento**, que son
públicas y que la propia Agencia difunde nominalmente. Bajo ese marco, exhibir
el nombre y el RBD de un establecimiento a partir de datos públicos por
establecimiento es legítimo.

Implementar una salvaguarda por `n_estab` contradiría D-nombres, sería
incoherente (suprimir una celda mientras el resto del motor expone lo mismo) y
degradaría utilidad sin reducir ningún riesgo real.

## Alternativas consideradas

1. **Colapsar `cod_depe2` en `datos_lst`.** Descartada: `depe2` es eje de
   segmentación real del motor; eliminarlo rompería la funcionalidad de filtro
   por dependencia.
2. **Suprimir celdas con `n_estab < k_min`.** Descartada: contradice D-nombres,
   degrada utilidad, y la supresión estática a nivel de fila comunal sesgaría
   los agregados ponderados (el cruce nacional × dependencia sí reúne muchos
   establecimientos, de modo que la supresión local distorsionaría totales
   superiores).

## Implicancia

- El caso 4b/depe4 queda cerrado a nivel metodológico y formal.
- Invariante operativo (ya registrado en el traspaso v19, sección 12):
  🔒 no implementar supresión de celdas por `n_estab` en futuras sesiones.
- No se modificó código en esta decisión ni en su evaluación.

## Marco normativo de referencia

- Política del proyecto §6.4 (Condiciones de Uso de Bases de Datos de la
  Agencia de Calidad).
- `20260611_decision_nombres_establecimientos.md` (acotación de §6.4 a
  microdatos por estudiante).

> Nota de mejora pendiente (no bloqueante, fuera de esta decisión): §6.4 de la
> política canónica generaliza en exceso la restricción de nombres. Su
> corrección corresponde a una sesión BIBLIOTECA sobre el documento
> multi-proyecto, no a este proyecto.
