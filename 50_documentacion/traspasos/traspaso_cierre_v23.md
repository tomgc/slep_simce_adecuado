# Traspaso de cierre v23 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v23
- **Fecha:** 2026-06-26
- **Sesión:** 23 — dos focos: (a) **estado por defecto del motor** = las 4 comunas
  del SLEP Costa Central con dependencia Servicio Local (depe2="5"), en montaje y
  reset; (b) **regeneración y auditoría minuciosa** de la suite de documentación
  standalone offline (la regeneración resultó no-op de versionado; la auditoría
  arrojó dos hallazgos heredados, no bloqueantes). Cierre de deuda de versionado
  trivial (README).
- **Entorno:** sesión web (Claude redactor, Opus 4.8) + Claude Code autónomo
  (patrón `encargo_autonomo_claude_code_v1`).
- **Archivos principales modificados:** `30_procesamiento/33_motor_template.html`
  (función `entidadesPorDefecto()` + seed de montaje + reset); `docs/index.html`
  (mirror publicado, propagado por copia); `README.md` (subtítulo, 1 línea).

## 2. Resumen ejecutivo

Sesión de dos focos. **Foco 1 (feature del motor):** el motor abría con el tablero
de comparación vacío (`useState([])`); se cambió el estado por defecto a las 4
comunas del SLEP Costa Central (Viña del Mar, Concón, Quintero, Puchuncaví; cod_com
5103/5105/5107/5109) filtradas a dependencia Servicio Local (depe2="5"), tanto al
montar como al pulsar "limpiar". La derivación es en runtime desde
`SimceData.SLEPS` (match normalizado por nombre "costa central"), sin hardcodear
cod_slep ni cod_com; entidad idéntica en forma a la del modal (kind="comuna"). Build
vía `00_build.R`, propagación a `docs/index.html` por copia (mirror de Pages),
verificación empírica sobre ambos HTML, commit `4d647df`, pusheado. **Foco 2
(auditoría de suite):** a pedido del titular se regeneró la suite standalone
offline; la regeneración fue determinista y reprodujo bytes idénticos (no-op de
versionado, sin commit). La auditoría minuciosa sobre los 4 `*_standalone.html`
confirmó 0 referencias de red reales (las coincidencias `http` son namespace SVG),
fuentes base64, iconos SVG embebidos, 0 fetch externo de cualquier tipo; y detectó
dos hallazgos heredados de s22, ninguno regresión ni bloqueante: (i) el `MRUN` sí
aparece 1 vez en el par general (publicable) —ya estaba aceptado en s22— y (ii) el
conteo `946` en el general es **falso positivo** (subcadena de un base64 de fuente),
no filtración. Cierre del README (quita "comunal" del subtítulo; `f87a3f7`,
pusheado).

## 3. Estado al cierre

**Qué funciona:**
- Motor: abre con las 4 comunas del SLEP Costa Central · Servicio Local precargadas;
  "limpiar" las restaura (no vacía). Derivación en runtime, sin hardcodear códigos.
- Suite de documentación en 4 `*_standalone.html` 100% offline (sin cambios reales
  esta sesión: la regeneración fue byte-idéntica).
- Backlog en 1–116 / 22 sesiones (cerrado en el barrido de s22, confirmado en la
  apertura de s23).
- Pipeline y datos sin cambios. Pages al día (redespliega `docs/index.html`).
- Rama `main` al día con `origin/main` (`f87a3f7`).

**Qué no funciona / pendiente:**
- Verificación funcional en navegador del precargado (las 4 comunas se ven al abrir,
  "limpiar" las restaura): **gate del titular**, no confirmado por el asistente.
- `resena_slep_simce_adecuado.md` (untracked): borrador de texto de difusión con
  marcas `[PENDIENTE: a definir por editor]`. No versionado a propósito (borrador
  abierto).
- 8 marcas `# REVISAR (voz)` en `documentar.R` (heredado; afinamiento de tono).
- Residual de historial D21-1 (heredado; sin acción inmediata).

**Delta respecto a v22:**
- Motor: estado por defecto vacío → 4 comunas Costa Central · SLEP (montaje + reset).
  Nueva función `entidadesPorDefecto()` en `33_motor_template.html`.
- README: subtítulo "Motor de comparación comunal" → "Motor de comparación" (el
  motor compara entidades de todo nivel, no solo comunal).
- Suite: sin cambio real (regeneración no-op). Auditoría minuciosa registrada.

## 4. Registro detallado de cambios (de la sesión)

1. **[Motor/Feature] Estado por defecto = 4 comunas SLEP Costa Central · Servicio
   Local.** Categoría: motor / visualización. Archivos: `33_motor_template.html`
   (fuente), `docs/index.html` (mirror). Qué: nueva función `entidadesPorDefecto()`
   que localiza el SLEP por `norm(s.nombre).includes("costa central")` en
   `SimceData.SLEPS`, deriva sus `comunas` (cod_com) y construye una entidad
   `kind:"comuna"` por cada una con `depe2:"5"`, `name = "<comuna> · " +
   DEPE2_LABELS["5"]`, `id:"default_cc_<cod>"`, color por índice de
   `ENTITY_PALETTE`, respetando `MAX_ENTIDADES` (4). Montaje:
   `useEffect(() => setEntities(prev => prev.length ? prev : entidadesPorDefecto()), [])`.
   Reset: `resetEntities()` pasó de `setEntities([])` a
   `setEntities(entidadesPorDefecto())`. Por qué (C.11): el motor es herramienta
   interna del SLEP Costa Central; el estado por defecto debe reflejar su universo,
   no un lienzo en blanco. Cómo se verificó (B.4): grep sobre ambos HTML
   (`entidadesPorDefecto` presente, reset usa el default, 0 residuo de
   `setEntities([])` en `resetEntities`); valores de cod_com confirmados contra el
   parquet por Claude Code (5103/5105/5107/5109 = 4 comunas, = MAX_ENTIDADES);
   auditoría del cuerpo del seed por el redactor sobre el template real (forma de
   entidad idéntica a la del modal; montaje y reset no se pisan; `firstRender` es de
   otro `useEffect`). Commit `4d647df`. Decisión de diseño: ver D23-1.

2. **[DOC] Regeneración de la suite standalone offline (no-op de versionado).**
   Categoría: documentación. Se regeneró a pedido del titular (regenerar suite
   existente = actualización deliberada, no churn). Precondición verificada
   (`documentar.R` 51.831 bytes, no stub; npm 11.12.1; `generar_suite` expone
   `standalone=`). La llamada ya traía `standalone = TRUE` y `verificar = FALSE`; no
   se editó. La regeneración reprodujo bytes idénticos a lo versionado en s22
   (`6f94729`): `git diff --cached --stat` vacío tras el add path-scoped. **No se
   creó commit vacío.** Sin push.

3. **[DOC/Auditoría] Auditoría minuciosa de los 4 `*_standalone.html`.** Categoría:
   documentación / auditoría. Veredicto: offline sólido. Red real = 0 en los 4 (las
   16/5 coincidencias `http` de los generales son exclusivamente
   `http://www.w3.org/2000/svg`, namespace XML, nunca fetch). 0 `<i data-lucide>`
   residuales; iconos como `<svg>` embebido; 6 fuentes `url(data:font;base64)` por
   archivo; 0 `<script src>`, 0 `<link stylesheet>`, 0 `<img>` externos. Dos
   hallazgos heredados (no regresión): (i) `MRUN` aparece 1 vez en el par general
   (publicable) — ya aceptado en s22 §7; (ii) el `946` en el general es **falso
   positivo** (subcadena dentro de un base64 de fuente, no el conteo de MRUN); hash
   `61c3b9b` ausente del HTML (correcto). Observación de diseño anotada: 0 logos PNG
   embebidos como `data:image` en los 4 (branding va por fuentes/SVG, no PNG);
   pregunta de diseño, no bug. Cierre con opción 1 del titular: no tocar nada,
   anotar como pendientes de contenido.

4. **[DOC] README: quitar "comunal" del subtítulo.** Categoría: documentación.
   `README.md` L3: "Motor de comparación comunal de resultados Simce…" → "Motor de
   comparación de resultados Simce…". Por qué: el motor compara establecimientos,
   comunas, SLEPs, regiones y país, no solo comunal. Cambio del titular preexistente
   (arrastrado desde antes de s23), cerrado esta sesión. Commit `f87a3f7`, pusheado.

## 5. Backlog acumulativo

El backlog (`50_documentacion/activa/backlog_historico.md`) está en **1–116 / 22
sesiones** (delta s22 anexado en el barrido de cierre de s22; confirmado en la
apertura de s23).

**Delta de la sesión 23 (a anexar como entradas 117–120 en el barrido de cierre):**

- **117. [Motor]** Estado por defecto del motor = 4 comunas del SLEP Costa Central
  con dependencia Servicio Local (depe2="5"), en montaje y reset; derivación en
  runtime sin hardcodear códigos (`entidadesPorDefecto()`). Commit `4d647df`.
- **118. [DOC]** Regeneración de la suite standalone offline a pedido del titular;
  resultó determinista byte-idéntica (no-op de versionado, sin commit).
- **119. [DOC/Auditoría]** Auditoría minuciosa de los 4 `*_standalone.html`: red real
  0 verificada, `946` en general identificado como falso positivo (base64 de
  fuente), `MRUN` en general confirmado heredado/aceptado. Sin commit (análisis).
- **120. [DOC]** README: subtítulo sin "comunal" (el motor compara entidades de todo
  nivel). Commit `f87a3f7`.

> **Recomendación de cierre del ciclo backlog:** anexar 117–120 en el barrido de
> cierre de s23. Si se anexa, actualizar el total a 120, la cobertura a 1–23, y
> agregar la línea de Delta.

> Nota metodológica vigente (sin cambios): "cambio" = solicitud distinguible del
> usuario. Clasificación por intención primaria. Los ítems 118 y 119 cuentan como
> un cambio cada uno (solicitud del titular: regenerar y auditar).

## 6. Bugs de la sesión

No hubo bugs de proyecto. El cambio del motor se verificó sin reintroducir
regresiones; la auditoría de suite no detectó defectos nuevos.

**Detalle de proceso de Edit A (resuelto, no es bug de proyecto):** al escribir el
regex de normalización del seed, el harness de Claude Code colapsaba `\u0300` al
carácter Unicode real al pasar por `Rscript -e`. Se resolvió construyendo el
backslash literal con `intToUtf8(92)`, dejando el rango en forma ASCII-escapada
`[\u0300-\u036f]` consistente con la línea 2811 del archivo. Funcionalmente
idéntico; quedó en la forma idiomática del proyecto.

## 7. Aprendizajes y restricciones descubiertas

- **Regenerar una suite/documentación existente = actualización deliberada, no
  churn.** Cuando el titular pide generar la suite y ya existe, es porque el proyecto
  cambió y la documentación debe reflejarlo; se procede sin objetar. (Registrado
  también como preferencia persistente.) El no-op de versionado de esta sesión no
  invalida la regla: la próxima vez puede haber diff real.
- **Seed de estado por defecto: derivar del dato, no hardcodear.** El estado inicial
  de las 4 comunas se deriva del propio SLEP en runtime (`SimceData.SLEPS` →
  `slep.comunas`), no de 4 códigos literales. Si el universo cambiara, el seed sigue
  correcto. Forma de la entidad idéntica a la del modal para no divergir.
- **Montaje con guard + reset directo no se pisan.** El seed de montaje usa
  `prev.length ? prev : entidadesPorDefecto()` (siembra solo si vacío); el reset
  llama `entidadesPorDefecto()` directo (restaura siempre). Son dos `useEffect`/
  funciones distintas; el `firstRender` del `useEffect` de loading no interfiere.
- **Coincidencia `http` no es referencia de red.** En auditorías de standalone
  offline, separar el namespace SVG `http://www.w3.org/2000/svg` (identificador XML,
  nunca se descarga) del fetch real. Un grep de `http` crudo sobrecuenta; el check
  correcto excluye `www.w3.org`.
- **Una subcadena en base64 puede simular una filtración.** El `946` apareció en el
  general por estar embebido en el base64 de una fuente, no por exponer el conteo de
  MRUN. Verificar el contexto (±120 chars) antes de declarar filtración.
- **El template que el redactor tiene en su sandbox puede ser una versión vieja.**
  Tras un cambio de Claude Code, el archivo subido al chat para redactar el encargo
  ya no refleja el disco; para auditar el resultado real hay que pedir el archivo
  actualizado o el `sed/grep` sobre el disco vivo (B.1: no auditar sobre estado
  supuesto).

## 8. Decisiones de diseño

- **D23-1 — Estado por defecto del motor = 4 comunas Costa Central · Servicio
  Local, en montaje y reset.** Se evaluaron: (A) 4 comunas filtradas a depe2="5";
  (B) 4 comunas sin filtro + entidad SLEP agregada; (C) solo la entidad SLEP.
  Elegida **A** (lo confirmó el titular), reforzada por `MAX_ENTIDADES=4`: las 4
  comunas con sostenedor SLEP llenan el tope exacto, no cabe una 5ª entidad. Sub-
  decisión: el reset restaura el default (no vacía) — el titular eligió que
  "limpiar" devuelva a Costa Central, coherente con "que vengan por defecto".
  Implementación: derivación en runtime, sin hardcodear códigos.

## 9. Constantes y parámetros vigentes

Sin cambios de valores. Colores de nivel intocables: `COLOR_ADEC #0C4682`,
`COLOR_ELEM #6BA0CE`, `COLOR_INSUF #79204F`. `MAX_ENTIDADES = 4`. Suite:
`verificar = FALSE` y `standalone = TRUE` permanentes. lucide-static 1.21.0.
`directorio_oficial_ee.csv` ignorado por Git. Nuevo: dependencia por defecto del
motor = `"5"` (Servicio Local), derivada de `DEPE2_LABELS["5"]`, no literal.

## 10. Arquitectura de archivos

Sin cambios estructurales. Archivos modificados: `33_motor_template.html` (fuente
del motor), `docs/index.html` (mirror de Pages, por copia desde
`40_salidas/motor_comparacion.html`, que sigue gitignored), `README.md`. El escáner
debe re-correrse en el barrido de cierre para sellar el estado y podar a retención 2.
Sin desviaciones respecto a la política.

## 11. Pendientes y ruta sugerida

### Inventario de pendientes

1. **Verificación funcional en navegador del precargado del motor.**
   - Tipo: gate del titular. Contexto: §3. Abrir `docs/index.html`, confirmar las 4
     comunas Costa Central · SLEP al abrir y que "limpiar" las restaura. Criterio:
     visto bueno visual del titular. (El código está auditado; falta solo el gate
     visual.)

2. **Anexar el delta de la sesión 23 al backlog (entradas 117–120).**
   - Tipo: documentación. Contexto: §5. Impacto: bajo. Complejidad: baja. Enfoque:
     barrido de cierre de s23 o apertura de s24. Criterio: backlog en 1–120,
     cobertura 1–23, línea de Delta presente. Verificar numeración contra el estado
     real (A22).

3. **`resena_slep_simce_adecuado.md` (untracked): borrador de texto de difusión.**
   - Tipo: pendiente del titular. Borrador con marcas `[PENDIENTE: a definir por
     editor]` (snippet/síntesis/reseña, variantes A/B/C). Versionarlo cuando el
     titular elija las variantes; ahora capturaría un borrador a medias.

4. **Marcas `# REVISAR (voz)` en `documentar.R` (8).**
   - Heredado. Afinamiento de tono del titular o texto de voz de referencia.

5. **Opcional: separar `cfg$gobernanza` por audiencia (técnico vs general).**
   - Heredado de s22. El general nombra `MRUN`/insumo/D21-1 (aceptado). La auditoría
     de s23 confirmó que el `MRUN` sigue presente en el general; el `946` NO es
     filtración (falso positivo de base64). Si se aborda, hacerlo junto a una sesión
     de contenido de la cfg, no como activación de standalone.

6. **Observación de diseño: logos institucionales no embebidos en la suite.**
   - Nuevo. 0 `data:image` en los 4 `*_standalone.html`; el branding va por
     fuentes/SVG, no por PNG. Pregunta de diseño (¿deberían embeberse los
     `logo-*.png` del tema?), no bug. Diferible; investigar en `suitedoc` si se
     retoma.

7. **Opcional: normalización del vocabulario de categorías del backlog.**
   - Heredado (D20-3). Diferible.

### Deuda técnica / zonas frágiles
- Ninguna nueva en código. El seed del motor depende del match por nombre
  "costa central"; robusto ante variantes (usa `includes`), pero si el nombre del
  SLEP cambiara radicalmente en los datos habría que ajustar el criterio.

### Auditoría de cierre (política 5.6)
- Datos crudos aislados e inmutables → Sí.
- Pipeline corre de cero sin intervención → Sí (salvedad del directorio descargable).
- Outputs reproducibles → Sí (la regeneración de suite fue byte-idéntica;
  determinismo confirmado).
- Decisiones metodológicas como constantes nombradas → Sí (depe2 default vía
  `DEPE2_LABELS["5"]`, no literal).
- Nombres sin tildes/ñ/espacios → Sí en lo tocado.

### Ruta sugerida para la sesión 24
1. **Apertura:** anexar delta s23 (117–120) si no se cerró en s23.
2. **Sin foco obligado:** proyecto estable y desplegado. Focos posibles a criterio
   del titular: cerrar la reseña de difusión y versionarla; afinar voz de la suite;
   separar gobernanza por audiencia; un foco nuevo de datos/motor.
3. **Diferibles:** marcas de voz, logos de la suite, normalización de categorías.

## 12. Instrucciones específicas para la próxima sesión

- ✅ ANTES de cualquier foco en s24, anexar el delta s23 al backlog (117–120) si no
  se cerró en el barrido de s23, verificando la numeración contra el estado real
  (A22).
- ✅ Al regenerar una suite/documentación que ya existe: es actualización
  deliberada, proceder sin objetar (puede haber diff real o no; ambos son válidos).
- ✅ Para sembrar estado por defecto en el motor, derivar del dato en runtime
  (`SimceData.*`), nunca hardcodear códigos comunales o de SLEP.
- ✅ En auditorías de standalone offline, excluir `www.w3.org` del conteo de `http`
  (namespace SVG, no fetch). Verificar contexto antes de declarar filtración.
- ✅ Para auditar un archivo que Claude Code modificó, pedir el archivo del disco
  vivo (o `sed/grep` sobre él); el subido al chat puede ser una versión vieja.
- 🔒 NO re-versionar `directorio_oficial_ee.csv` ni derivados con `MRUN`,
  `RUT_SOSTENEDOR` de persona natural o geo de personas (D21-1).
- 🔒 NO implementar supresión de celdas por `n_estab` (D20-1 / D-nombres).
- 🔒 Color por nivel, % Adecuado y corte de traspaso intocables.
- 🔒 Estado por defecto del motor = 4 comunas Costa Central · Servicio Local
  (D23-1); el reset restaura ese estado, no vacía. No revertir sin decisión del
  titular.
- ✅ `verificar = FALSE` y `standalone = TRUE` permanentes en `documentar.R`;
  regenerar requiere `npm` + red (lucide-static 1.21.0).
- ✅ `docs/index.html` es el mirror de Pages; se actualiza por copia desde
  `40_salidas/motor_comparacion.html` (este último gitignored).
- ✅ Para afirmar qué está versionado usar `git ls-files`, no el escáner (A20).
- ⚠️ `SETTINGS_Y_PROMPTS_OPERACIONALES.md` se mantiene local (untracked) por diseño.
- ⚠️ `resena_slep_simce_adecuado.md` es un borrador untracked del titular; no
  descartarlo ni versionarlo sin que elija las variantes.

## 13. Fragmentos de código de referencia

Estado por defecto del motor (la forma correcta en este proyecto):

```javascript
// En el scope del componente App(), donde SimceData está disponible.
function entidadesPorDefecto() {
  const norm = s => String(s).toLowerCase().normalize("NFD").replace(/[\u0300-\u036f]/g, "");
  const slep = SimceData.SLEPS.find(s => norm(s.nombre).includes("costa central"));
  if (!slep) return [];
  const depeLabel = SimceData.DEPE2_LABELS["5"];
  return slep.comunas.slice(0, MAX_ENTIDADES).map((cod, i) => {
    const c = SimceData.COMUNA_BY_COD.get(cod);
    return {
      id: "default_cc_" + cod,
      name: (c ? c.nom : cod) + " · " + depeLabel,
      kind: "comuna",
      comunas: [cod],
      depe2: "5",
      color: ENTITY_PALETTE[i % ENTITY_PALETTE.length],
    };
  });
}

// Montaje: siembra solo si el tablero está vacío.
React.useEffect(() => {
  setEntities(prev => prev.length ? prev : entidadesPorDefecto());
}, []);

// Reset: restaura el default (no vacía).
function resetEntities() {
  setEntities(entidadesPorDefecto());
}
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 24 (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  "Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo (POLÍTICA
  v6 + SETTINGS v4 + DISCIPLINA_OPERATIVA) vive en la knowledge base; léelo desde
  ahí. Adjunto el traspaso v23 y el escáner actual. Primera acción sugerida: anexar
  el delta de la sesión 23 al backlog (entradas 117–120) si no se cerró en el
  barrido de s23, antes de proponer foco. No hay foco obligado; el proyecto está
  estable y desplegado."
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base* (NO adjuntar; verificar al día):
     `POLITICA_PROYECTO.md`, `SETTINGS_Y_PROMPTS_OPERACIONALES.md`,
     `DISCIPLINA_OPERATIVA.md`.
  2. *Opcionales según foco:* `CLAUDE.md` si corre en Claude Code;
     `backlog_historico.md` para anexar el delta s23;
     `33_motor_template.html` si se itera el motor;
     `documentar.R` si se afina la voz de la suite o se separa la gobernanza.
  3. *Específicos (SÍ adjuntar):* `traspaso_cierre_v23.md`; `estructura_actual.md`.
- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
  versión más actualizada al abrir y avisarlo.
