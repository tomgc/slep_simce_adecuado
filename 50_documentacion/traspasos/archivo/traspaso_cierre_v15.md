# Traspaso de cierre v15 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v15
- **Fecha:** 2026-06-11
- **Sesión:** 15 — foco en ajustes finos de UI del motor (colores por nivel,
  leyenda, etiquetas apiladas, tipografía) + actualización de documentación al
  estado actual. En paralelo (BIBLIOTECA): dos prompts de apertura NEW PROJECT.
- **Entorno:** sesión de diseño en interfaz web; build y git ejecutados por el
  usuario en Positron / terminal (zsh, macOS).
- **Archivos principales modificados:** `30_procesamiento/33_motor_template.html`;
  documentación (`documentacion_proyecto_*.md/.html`,
  `arquitectura_slep_simce_adecuado.html`, `README.md`).

## 2. Resumen ejecutivo

Sesión de pulido visual del motor sobre una base ya estable y publicada. Se
ejecutaron varias rondas iterativas de ajuste UI guiadas por capturas del
usuario: el cambio de fondo fue redefinir el esquema de color del motor, pasando
de "color = entidad" (donde el color de cada entidad representaba su % Adecuado)
a **tres niveles de logro con color fijo por nivel** (Adecuado #0C4682,
Elemental #6BA0CE, Insuficiente #79204F), con la identidad de cada entidad
sostenida ahora por nombre, swatch y un borde de color que rodea su ficha. Se
añadieron etiquetas blancas a la base de cada segmento apilado, se reorganizó la
leyenda, el toggle pasó a default solo-Adecuado, se renombró su botón, se
estilizó "Simce" (antes "SIMCE") y se subió la tipografía del gráfico de línea.
Toda la documentación conceptual y técnica se actualizó como retrato del estado
actual (no como bitácora). El pipeline NO se tocó: el invariante del % Adecuado
se verificó idéntico contra el build previo (bloque Costa Central 4b/lect). Se
cerró deuda de versionado en 5 commits temáticos. Pendiente de la sesión: push a
origin y deploy a Pages (el usuario los hará), más la auditoría depe=4 que no se
abrió.

## 3. Estado al cierre

**Qué funciona:**
- Build completo corre limpio en ~3 s (última ejecución exitosa esta sesión).
  `motor_comparacion.html` regenerado (2.45 MB) y copiado a `docs/index.html`.
- Motor con los tres niveles de logro en color fijo, leyenda reorganizada,
  etiquetas apiladas y tipografía del sparkline ampliada.
- Documentación coherente con el estado actual del motor.

**Qué no funciona / pendiente operativo:**
- 5 commits locales **sin push** a origin/main (el usuario lo hará).
- Deploy a Pages: `docs/index.html` actualizado localmente, pero el push del
  commit del motor a GitHub está pendiente, así que el sitio público todavía no
  refleja los cambios de esta sesión hasta que se haga `git push`.

**Delta respecto a v14:**
- Esquema de color del motor redefinido (color por nivel, no por entidad).
- Documentación actualizada (en v14 estaba desfasada: decía "color de cada
  entidad", "SIMCE", default apilado).
- Deuda de versionado de v14 cerrada (pipeline de 3 niveles ahora commiteado).

## 4. Registro detallado de cambios (de la sesión)

Cada bloque es conceptualmente independiente. Todos sobre
`33_motor_template.html` salvo donde se indica.

1. **Default del toggle a solo-Adecuado.** `showElemInsuf` inicia en `false`. El
   motor abre mostrando solo el % Adecuado; el desglose es opt-in. Verificado:
   carga sin el área apilada.
2. **Renombre del botón** "Elem. + Insuf." → "Mostrar niveles Elemental e
   Insuficiente".
3. **Texto de nota gap 2019-2021** reescrito a la redacción del usuario ("La
   aplicación del Simce en 2019, 2020 y 2021 fue interrumpida...").
4. **"SIMCE" → "Simce"** en el motor (nota de gap + fuente) y en toda la
   documentación. Identificadores de código (`SimceData`) intactos.
5. **Tres niveles con color fijo por nivel** (decisión de diseño 8.1). Adecuado
   #0C4682, Elemental #6BA0CE, Insuficiente #79204F, iguales en todas las
   entidades. Se reescribieron todos los puntos donde el gráfico usaba
   `entity.color` para Adecuado (línea de trayectoria, puntos, etiquetas %,
   barras, swatches de tooltip) a `COLOR_ADEC`. `entity.color` permanece solo
   como identidad (swatch de tarjeta, encabezado, export, borde de ficha).
6. **Colores distintos en alta múltiple (causa raíz).** Al agregar 3 entidades de
   una vez, recibían el mismo color. Raíz: `handleSave` fijaba `color` una sola
   vez en las ramas multi (region/slep). Fix: esas ramas dejan `color: undefined`
   en alta múltiple y `saveEntities` asigna un color distinto por índice desde
   `ENTITY_PALETTE`. (Quedó parcialmente superado por el cambio 5, pero el fix de
   raíz permanece correcto para los swatches/bordes de identidad.)
7. **Borde de color por entidad en la ficha del gráfico.** Evolucionó en dos
   pasos: primero `border-bottom` 2px, luego (a pedido del usuario) borde de 1px
   que rodea toda la ficha. También se llevó el color de entidad a la línea bajo
   el nombre en el encabezado del supergrid (`borderBottomColor: ent.color`).
8. **Reorganización de la leyenda.** Salió de `section-actions` a una fila propia
   bajo el título; "2025 preliminar" eliminado (ya está en notas); orden Baja
   repr. · Adecuado · Elemental · Insuficiente. Iteró de "fila propia con
   space-between" a "fila única con controles, pegada a la izquierda"
   (`results-head-controls` con `flex-start`).
9. **Sin líneas entre segmentos apilados.** Se quitó el `stroke #C8BDA0`/
   `stroke-width 0.5` de los rects de Elem/Insuf y el inset de 0.5px que dejaba
   ver el fondo entre segmentos. Los segmentos se pegan sin gap.
10. **Etiquetas blancas en segmentos apilados.** Con el toggle activo, cada
    segmento (Elemental, Insuficiente) muestra su % en blanco a la base de su
    franja, solo si el alto ≥16px. La etiqueta de Adecuado también baja a la base
    en blanco en modo apilado; en modo solo-Adecuado se mantiene encima en azul.
11. **Tipografía del sparkline ampliada.** Etiqueta % 8.5→10.5, año 8→9.5,
    asterisco 9→10.5, radio de punto 2.2→2.6. Mapeo de tamaños hecho antes de
    decidir (criterio: acercar a la escala de las barras sin igualarlas).
12. **Documentación actualizada al estado actual** (md+html de presentación,
    arquitectura.html, README): "Simce", colores fijos por nivel, default
    solo-Adecuado, desglose de 3 niveles añadido al módulo del motor en el
    diagrama de arquitectura.

## 5. Backlog acumulativo

Mantenido en `50_documentacion/activa/backlog_historico.md` (documento vivo). El
backlog viene de sesiones 1–14 (entradas 1–79). **Esta sesión agrega las
entradas 80–91**, continuando la numeración. El detalle por entrada se anexa a
`backlog_historico.md` al cierre; resumen de la sesión 15:

- **80–91 (UI/DOC):** 11 ajustes de UI del motor + 1 bloque de actualización de
  documentación, según el registro de la sección 4 de este traspaso.
- Categoría dominante de la sesión: UI (10 de 12). DOC (1). El fix de colores en
  lote (entrada de raíz) cuenta como UI/DT.

**Delta del backlog:** 12 entradas nuevas (80–91). Sin reclasificación de
taxonomía. Total acumulado: 91.

## 6. Bugs de la sesión

- **Bug 15-1 (colores repetidos en alta múltiple).** Síntoma: 3 entidades
  agregadas de una vez quedaban del mismo color. Causa raíz: `handleSave` fijaba
  `color = availableColor` una sola vez para todo el lote en las ramas
  region/slep; `saveEntities` no podía reasignar porque `e.color` ya venía
  seteado. Solución: ramas multi dejan `color: undefined` en alta múltiple;
  `saveEntities` asigna por índice. Verificación: 3 entidades → 3 colores
  distintos. **Regla aprendida:** cuando una función aguas abajo es responsable
  de asignar un atributo por lote, las funciones aguas arriba no deben
  pre-asignarlo; un valor pre-seteado bloquea silenciosamente la lógica de lote.
- **Bug 15-2 (líneas entre segmentos apilados).** Síntoma: líneas finas entre
  los colores de cada nivel. Causa raíz: doble origen — `stroke` explícito en los
  rects de segmento + inset de 0.5px que descubría el fondo. Solución: eliminar
  ambos. **Regla aprendida:** un "borde" no deseado entre formas SVG contiguas
  puede venir de un stroke explícito o de un gap por inset; revisar ambos.

## 7. Aprendizajes y restricciones descubiertas

- **Color por nivel, no por entidad (nueva regla 🔒).** Un mismo nivel de logro
  se ve igual en todas las entidades (color fijo). La identidad de entidad se
  distingue por nombre + swatch + borde de ficha, nunca por el color del dato del
  gráfico. Deroga la regla de v14 ("color = entidad = Adecuado"). Si una sesión
  futura toca el dibujo de series, Adecuado va en `COLOR_ADEC`, no en
  `entity.color`.
- **Documentación = retrato del estado actual, no bitácora.** Los documentos
  conceptuales/técnicos describen cómo es el motor hoy; el historial de cambios
  vive en traspasos y backlog. Al actualizar, reescribir al estado vigente, no
  acumular "antes/después".
- **Mapear antes de ajustar tamaños** (refuerza R7 de memoria): el ajuste de
  tipografía del sparkline se hizo con un mapeo previo de todos los font-size y un
  criterio explícito (escala relativa a las barras), no por tanteo.

## 8. Decisiones de diseño

- **D15-1: Tres niveles con color fijo por nivel (Opción B).** Alternativa
  considerada: mantener "color = entidad" y solo cambiar Elem/Insuf (Opción A,
  statu quo de v14). El usuario eligió B explícitamente: "un mismo nivel no puede
  tener distintos colores si representa lo mismo". Implicancia: se sacrifica la
  distinción de entidad por color de línea, compensada con nombre + swatch +
  borde de ficha. Tensión resuelta: legibilidad semántica del nivel sobre
  densidad de identificación por color. Replicar en
  `decisiones/20260611_decision_color_por_nivel.md` (pendiente, ver auditoría de
  cierre).
- **D15-2: Default solo-Adecuado.** El motor abre en su indicador principal; el
  desglose es opt-in. Coherente con que el proyecto se llama "adecuado".
- **D15-3: Documentación como retrato del estado actual.** Decisión de alcance
  del usuario para esta y futuras actualizaciones de docs.

## 9. Constantes y parámetros vigentes (cambios de la sesión)

| Constante | Valor | Archivo | Nota |
|---|---|---|---|
| COLOR_ADEC | #0C4682 | 33_motor_template.html | NUEVO. Azul, Adecuado (antes era entity.color) |
| COLOR_ELEM | #6BA0CE | 33_motor_template.html | CAMBIO de valor (antes #D8C98E → #BCA493 → #6BA0CE) |
| COLOR_INSUF | #79204F | 33_motor_template.html | CAMBIO de valor (antes #B9A9A0 → #747474 → #79204F) |
| showElemInsuf (default) | false | 33_motor_template.html | CAMBIO (antes true) |
| MAX_ENTIDADES | 4 | 33_motor_template.html | sin cambio |
| sparkline font % / año / asterisco | 10.5 / 9.5 / 10.5 | 33_motor_template.html | CAMBIO (antes 8.5 / 8 / 9) |
| sparkline radio punto | 2.6 | 33_motor_template.html | CAMBIO (antes 2.2) |

## 10. Arquitectura de archivos

Referencia: escáner al cierre `estructura_actual.md` (2026-06-11 19:44:46,
17 carpetas / 101 archivos). Sin cambios estructurales en la sesión: solo
contenido de archivos existentes + snapshots del escáner. El template subió de
~140K a 143K por los ajustes. `docs/index.html` ya refleja el build nuevo
(2.45 MB) localmente.

## 11. Pendientes y ruta sugerida

**Inventario de pendientes:**

| Pendiente | Tipo | Complejidad | Notas |
|---|---|---|---|
| `git push` de los 5 commits a origin/main | operativo | trivial | El usuario lo hará |
| Deploy a Pages (push del commit del motor; el sitio público aún no refleja la sesión) | operativo | trivial | Depende del push |
| `decisiones/20260611_decision_color_por_nivel.md` | documentación | baja | Replicar D15-1 como archivo de decisión (auditoría de cierre) |
| Auditoría Corp. Admin. Delegada (depe=4) | verificación | baja-media | Foco secundario de v14, nunca abierto. Confirmar que el conteo bajo de EE depe=4 por prueba×nivel es real |
| Segmentación histórica por año de traspaso | funcionalidad de fondo | alta | Distinguir visualmente serie pre/post traspaso de un SLEP. Pipeline + lógica de series. Sesión dedicada |

**Auditoría de cierre (política 5.6, preguntas "Cierre"):**
- ¿Pipeline reproducible de cero? Sí (build limpio, invariante verificado).
- ¿Cada transformación crítica con check? Sí (heredado; sin cambios de pipeline).
- ¿Outputs reproducibles e idempotentes? Sí.
- ¿Decisiones metodológicas como constantes nombradas? Sí (COLOR_* nombradas).
- ¿Nombres sin tildes/ñ/espacios? Sí.
- **Hallazgo:** D15-1 (color por nivel) merece archivo de decisión propio →
  pendiente agregado arriba.

**Ruta sugerida para la sesión 16 (en orden):**
1. **Push + deploy** (cierra la sesión 15 en producción). Criterio de éxito:
   sitio público refleja colores por nivel y etiquetas apiladas.
2. **Auditoría depe=4** (pendiente acotado, con contexto fresco). Criterio:
   conteo depe=4 del pipeline cuadra con el directorio dentro de tolerancia;
   discrepancias explicadas.
3. **Archivo de decisión D15-1** (rápido, cierra deuda de gobernanza).
4. Diferir: segmentación histórica por traspaso (sesión dedicada).

## 12. Instrucciones específicas para la próxima sesión

- 🔒 **Color por nivel es invariable:** Adecuado/Elemental/Insuficiente tienen
  color fijo (`COLOR_ADEC`/`COLOR_ELEM`/`COLOR_INSUF`), igual en todas las
  entidades. NO volver a atar el color del dato a `entity.color`.
- 🔒 **% Adecuado intocable:** cualquier cambio que toque el pipeline debe
  verificar el bloque Costa Central 4b/lect idéntico al build previo.
- ✅ ANTES de tocar el dibujo de series: recordar que `entity.color` ahora es
  solo identidad (swatch/encabezado/export/borde), nunca color de Adecuado.
- ✅ ANTES de ajustar tamaños/posiciones: mapear los valores actuales y definir
  criterio de éxito (no tantear).
- ⚠️ NO mezclar la auditoría depe=4 (verificación de cifras) con cambios de UI en
  el mismo commit.
- ⚠️ Los `verificar_*.R` de la raíz son efímeros (sin trackear a propósito); no
  versionarlos salvo decisión explícita.

## 13. Fragmentos de código de referencia

```javascript
// Color fijo por nivel (la forma correcta). entity.color es SOLO identidad.
const COLOR_ADEC  = "#0C4682";  // Adecuado
const COLOR_ELEM  = "#6BA0CE";  // Elemental
const COLOR_INSUF = "#79204F";  // Insuficiente
// En el dibujo de series: .attr("stroke", COLOR_ADEC)  // NO entity.color
// entity.color solo en: swatch de tarjeta, encabezado, export, borde de ficha.
```

```javascript
// Asignación de color por lote: la rama multi NO fija color; saveEntities lo hace por índice.
// handleSave (rama region/slep, alta múltiple):
color: editing ? color : undefined,
// saveEntities:
const disponibles = ENTITY_PALETTE.filter(c => !usados.includes(c));
const conColor = aAgregar.map((e, i) => ({ ...e, color: e.color || disponibles[i] || ENTITY_PALETTE[i % ENTITY_PALETTE.length] }));
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 16 (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  > Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo
  > (POLÍTICA + SETTINGS) vive en la knowledge base; léelo desde ahí. Adjunto el
  > traspaso v15, el escáner actual y los archivos del foco. Foco de la sesión:
  > (1) confirmar push + deploy en producción; (2) auditoría Corp. Admin.
  > Delegada (depe=4); (3) archivo de decisión color por nivel.

- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base* (NO adjuntar; verificar que estén al día):
     `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `CLAUDE.md` si la sesión corre en Claude Code; para
     la auditoría depe=4, uno de los `verificar_*.R` como referencia de patrón y
     `directorio_oficial_ee.csv` para el cruce.
  3. *Específicos de la sesión (SÍ adjuntar):* `traspaso_cierre_v15.md`;
     `estructura_actual.md`; para la auditoría depe=4,
     `31_leer_normalizar.R`, `32_agregar_comunal.R` y el directorio oficial.

- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
  versión más actualizada al abrir y avisarlo en el mensaje de apertura.

---

### Artefactos BIBLIOTECA producidos en paralelo (sesión 15)

Dos prompts de apertura NEW PROJECT, candidatos a `herramientas_dev/`:
- `prompt_nuevo_proyecto_categoria_desempeno.md` — motor de Categoría de
  Desempeño (establecimiento, categórico, conteo, sin GSE).
- `prompt_nuevo_proyecto_idps.md` — motor de IDPS (índices 0–100 por RBD,
  3 tablas pre-agregadas, con GSE).
Ambos con Paso 0 obligatorio (scaffold + git local + repo GitHub privado + primer
escaneo antes de pipeline) y esquemas de datos reales ya inspeccionados.
