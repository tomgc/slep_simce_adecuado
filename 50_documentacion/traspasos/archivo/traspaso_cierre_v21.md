# Traspaso de cierre v21 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v21
- **Fecha:** 2026-06-22
- **Sesión:** 21 — mantenimiento documental y cumplimiento normativo, tres focos:
  (a) anexar al backlog vivo el delta de la sesión 20 (entradas 106–109,
  pendiente heredado de v20); (b) auditoría de cumplimiento Ley 21.719 sobre
  insumos y producto, con mitigación del hallazgo; (c) limpieza de working tree
  para el cierre (restaurar un `documentar.R` sobrescrito por stub, versionar el
  traspaso v20, ignorar scratch efímero).
- **Entorno:** sesión en interfaz web (Claude conversacional como redactor);
  todas las operaciones de terminal, git y edición de archivos ejecutadas por
  Claude Code en modo autónomo (patrón `encargo_autonomo_claude_code_v1`).
- **Archivos principales creados/modificados:**
  `50_documentacion/activa/backlog_historico.md` (anexo s20: entradas 106–109 +
  cobertura 1–20); `50_documentacion/activa/gobernanza_datos.md` (nuevo, primer
  archivo de gobernanza del proyecto); `50_documentacion/activa/decisiones/20260622_decision_cumplimiento_ley_21719.md`
  (nuevo); `.gitignore` (de-versionado del directorio crudo + bloque
  `verificar_*.R`); `README.md` (directorio no versionado, setup de máquina
  nueva); cuatro logs de andamio nuevos. Insumo `directorio_oficial_ee.csv`
  retirado del índice de Git (`git rm --cached`; intacto en disco). Sin cambios
  de pipeline, motor ni constantes.

## 2. Resumen ejecutivo

Sesión de mantenimiento documental y cumplimiento normativo, sin tocar pipeline
ni motor, ejecutada mediante encargos autónomos a Claude Code. **(P1)** Se anexó
al backlog vivo el delta de la sesión 20 (entradas 106–109) que v20 había dejado
pendiente, dejando el backlog en 1–109 / 20 sesiones y la cobertura actualizada a
1–20. **(P2)** Se auditó el cumplimiento de la Ley 21.719 (vigente dic-2026): el
producto publicado quedó verificado limpio por dos caminos independientes (trazado
de código + panel adversarial que escaneó claves y valores del JSON), pero la
Fase 1 determinista detectó que el insumo crudo `directorio_oficial_ee.csv`,
versionado en el repo público, exponía la columna `MRUN` poblada en 946 filas
(⟺ sostenedores persona natural, dato personal). El gate se activó; el titular
decidió de-versionar el CSV crudo going-forward (regenerable 1×/año desde MINEDUC)
y aceptar el residual de historial como riesgo documentado. Se redactaron
`gobernanza_datos.md` y la decisión de cumplimiento. **(P3)** En la limpieza de
cierre se detectó que `documentar.R` en disco había sido sobrescrito por el stub
de fábrica de `suitedoc`; el archivo real (46.9K) estaba intacto en HEAD y se
restauró. Se versionó el traspaso v20 (untracked) y se ignoraron los tres
`verificar_*.R` efímeros. Hallazgo metodológico: el riesgo real estaba en `MRUN`,
no en `RUT_SOSTENEDOR` (todos jurídicos) como anticipaba el encargo; la auditoría
con conteos reales corrigió el supuesto.

> **Registro de ejecución detallado:**
> `50_documentacion/andamios/logs/20260622_anexo_delta_s20_backlog_log.md` y
> `50_documentacion/andamios/logs/20260622_auditoria_ley21719_log.md`
> (logs de las sesiones de Claude Code; detalle paso a paso no reproducido aquí).

## 3. Estado al cierre

**Qué funciona:**
- Backlog histórico vivo en 1–109 / 20 sesiones, cobertura 1–20, sin huecos ni
  duplicados (`0e9d275`).
- Cumplimiento Ley 21.719 documentado: `gobernanza_datos.md` y decisión 21.719
  versionados; directorio crudo fuera del índice de Git e ignorado (`1edc787`).
- Producto publicado verificado limpio (sin dato personal) por dos caminos
  independientes.
- `documentar.R` real (46.9K) restaurado y confirmado idéntico a HEAD.
- Motor y pipeline sin cambios desde v18; build y Pages al día.
- Rama `main` al día con `origin/main`.

**Qué no funciona / pendiente:**
- Residual de historial: el CSV con los 946 `MRUN` permanece recuperable del
  historial público hasta el commit `61c3b9b`. Aceptado como riesgo residual
  documentado (dato de rol público, descargable de MINEDUC, desproporción de
  reescribir historial con Pages activo); revisable si cambia la naturaleza del
  dato.
- Vocabulario de categorías del backlog heterogéneo (heredado de v20, sin
  cambios): 1–56 taxonomía estricta de 7; 57+ tags compuestos. Mantenimiento
  opcional (D20-3).

**Delta respecto a v20:**
- Backlog vivo al día con la sesión 20 (cierra el pendiente 1 de v20).
- Nuevo `gobernanza_datos.md` (primer archivo de gobernanza del proyecto;
  obligatorio según política §10 una vez identificado dato personal en insumo).
- Nueva decisión 21.719; nuevo estándar: el directorio MINEDUC no se versiona.
- `directorio_oficial_ee.csv` retirado del índice; `.gitignore` ampliado.
- README actualizado (setup de máquina nueva incluye descargar el directorio).
- Cuatro logs de andamio nuevos.

## 4. Registro detallado de cambios (de la sesión)

1. **[DOC] Anexo del delta de la sesión 20 al backlog (entradas 106–109).**
   Categoría: documentación. El backlog vivo estaba en 105; se anexó la sesión 20
   con sus 4 entradas (decisión 4b/depe4, corrección de marcas de suite,
   reconstrucción 61–105, cotejo de categorías) y se actualizó la cobertura de
   1–19 a 1–20. Anexo con ancla-a-texto (evitó el bug de colapso de saltos de
   v20). Backlog en 1–109 / 20 sesiones. Commit `0e9d275`; log de ejecución
   `ed00cd6`.

2. **[Gobernanza/Auditoría] Auditoría de cumplimiento Ley 21.719.** Categoría:
   gobernanza / auditoría. Fase 1 (16.768 filas, conteos reales):
   `RUT_SOSTENEDOR` 14.819 poblados, todos persona jurídica (riesgo nulo);
   `MRUN` 946 poblados ⟺ `P_JURIDICA==0` (persona natural) exacto = dato
   personal. Fase 2: el JSON publicado contiene solo claves institucionales
   (`rbd, nom_rbd, cod_com_rbd, nom_com_rbd, cod_depe2`); producto limpio
   confirmado por trazado de código (`transmute`/`select` en 30/33) y panel
   adversarial independiente (0 RUT, 0 email, 0 coordenadas en claves y valores).
   Gate activado por la condición (a): `MRUN` en insumo versionado. Sin cambios
   de código.

3. **[REPO/Gobernanza] Mitigación: de-versionado del directorio crudo.**
   Categoría: gobernanza del repo. `git rm --cached directorio_oficial_ee.csv`
   (archivo intacto en disco, md5 `80be2b37…`); regla añadida al `.gitignore`;
   README actualizado (sección Datos de entrada + setup de máquina nueva: el
   directorio se descarga de MINEDUC, no se versiona). Incluido en `1edc787`.

4. **[DOC/Gobernanza] Documentación de cumplimiento.** Categoría: documentación /
   gobernanza. `gobernanza_datos.md` (categoría de datos por insumo y producto,
   base de licitud, qué se publica, retención, procedimiento ante incidente,
   §8 con el residual de historial) y `20260622_decision_cumplimiento_ley_21719.md`
   (Opción 1 elegida —de-versionado going-forward + aceptar residual—, Opción 2
   reescritura descartada por desproporción). Incluido en `1edc787`; log de
   auditoría `a1271c7`, actualizado a estado final en `fdece26`.

5. **[Infra/DOC] Limpieza de cierre.** Categoría: infraestructura / documentación.
   `documentar.R` en disco había sido sobrescrito por el stub de fábrica de
   `suitedoc` (2.6K); el real (46.9K) estaba intacto en HEAD `e14048f` y se
   restauró con `git restore`. Se versionó `traspaso_cierre_v20.md` (untracked,
   A38) y se añadió el bloque `verificar_*.R` al `.gitignore` (scratch efímero,
   no a `_archivo/`). [Commit del barrido de cierre: ver reapertura.]

## 5. Backlog acumulativo

El backlog vivo (`50_documentacion/activa/backlog_historico.md`) quedó al día con
la sesión 20 durante esta sesión (entradas 106–109; 1–109 / 20 sesiones).

**Delta de la sesión 21:** esta sesión produjo trabajo de documentación,
auditoría y gobernanza que **se anexó al backlog vivo en la sesión 21 como
entradas 110–113** (continuando la numeración), siguiendo la regla de
mantenimiento por delta. Entradas anexadas:

- **110. [DOC]** Anexo del delta de la sesión 20 al backlog (entradas 106–109) y
  actualización de cobertura a 1–20. Commit `0e9d275`.
- **111. [Gobernanza/Auditoría]** Auditoría Ley 21.719: producto publicado
  verificado limpio por dos caminos (código + panel adversarial); hallazgo
  `MRUN` (946 filas, persona natural) en insumo versionado. Sin cambios de código.
- **112. [REPO/Gobernanza]** Mitigación: de-versionado de `directorio_oficial_ee.csv`
  going-forward (`git rm --cached` + `.gitignore` + README), residual de historial
  aceptado. Commit `1edc787`.
- **113. [DOC/Gobernanza]** `gobernanza_datos.md` (primer archivo de gobernanza
  del proyecto) + decisión 21.719. Commit `1edc787`.

> **Nota de cierre del ciclo backlog:** v20 dejó su delta para anexar en s21 y se
> cumplió. Para no repetir esa deuda, **el delta s21 (110–113) se anexó en la
> sesión 21**, en el mismo barrido de cierre. Backlog vivo: **1–113 / 21
> sesiones**; `**Delta del backlog:** 4 entradas nuevas (110–113)… Total
> acumulado: 113`.

> Nota metodológica vigente (sin cambios): "cambio" = una solicitud distinguible
> del usuario, no las acciones técnicas que la implementan. Clasificación por
> intención primaria. Fuente del conteo: traspasos + este backlog.

## 6. Bugs de la sesión

No hubo bugs de proyecto (sesión sin cambios de pipeline ni motor).

**Incidentes de ejecución (Claude Code, resueltos):**

- **`documentar.R` sobrescrito por stub.** Síntoma: el escáner mostró
  `documentar.R` en 2.55K (vs 45.8K en v20). Causa raíz: la copia en disco fue
  sobrescrita por el stub de fábrica de `suitedoc` (`cfg_ejemplo()`,
  `generar_suite()` comentado), casi con certeza por re-correr un scaffold o
  copiar el archivo equivocado. Detección: verificación working-tree vs HEAD
  antes de cerrar (el archivo real, 46.9K, estaba íntegro en HEAD `e14048f`).
  Solución: `git restore`; confirmado idéntico a HEAD. **Regla aprendida:** antes
  de cerrar, verificar el working tree contra HEAD; un escáner que lista el
  filesystem puede ocultar que un archivo versionado fue sobrescrito en disco.
  Commitear a ciegas habría regresado `documentar.R` al stub.

- **Lectura inicial del CSV truncada a 26 filas.** Síntoma: el primer
  `read_delim` del directorio truncó con warning de input inválido. Causa raíz:
  artefacto de parsing en la línea del BOM. Solución: re-lectura robusta;
  16.768 filas correctas. Sin impacto en los conteos finales.

## 7. Aprendizajes y restricciones descubiertas

- **El riesgo de dato personal no siempre está donde se anticipa.** El encargo
  apuntó a `RUT_SOSTENEDOR` de persona natural (resultó 0 — todos jurídicos); el
  dato personal vivía en `MRUN` (946, ⟺ persona natural exacto). Regla: la
  auditoría determinista con conteos reales (Fase 1) precede y puede corregir el
  supuesto del encargo; nunca documentar gobernanza sobre el supuesto sin
  verificarlo (B.1).
- **El escáner lista el filesystem, no el índice de Git (refuerzo de A20).** Tras
  `git rm --cached`, `directorio_oficial_ee.csv` sigue apareciendo en el árbol del
  escáner (está en disco) aunque ya no esté versionado. Verificar con
  `git ls-files`, no con el escáner, para afirmar qué está versionado.
- **Un andamio o documento no se congela a mitad de ejecución.** Tanto el log de
  auditoría como la cabecera de la decisión 21.719 quedaron con texto previo al
  cierre del gate ("Pendiente") mientras su cuerpo ya registraba la resolución.
  Regla: al cerrar un gate, actualizar también la línea de estado de cabecera y el
  log a su estado final, no solo el cuerpo.
- **De-versionar no purga el historial.** `git rm --cached` corta going-forward;
  el dato persiste en commits pasados. En repo público, esto exige una decisión
  explícita sobre el historial (reescribir vs aceptar residual), no es
  automático.

## 8. Decisiones de diseño

- **D21-1 — De-versionado del directorio crudo + residual de historial aceptado.**
  Formalizada en `20260622_decision_cumplimiento_ley_21719.md`. La columna `MRUN`
  (946 RUN de sostenedores persona natural) en `directorio_oficial_ee.csv`
  versionado es dato personal bajo Ley 21.719. Alternativas: (1) CSV filtrado a
  columnas no-personales (descartada: mantiene un derivado del directorio, costo
  de mantención anual); (2) reescritura de historial + force-push (descartada:
  destructiva sobre repo público con Pages activo, desproporcionada para dato de
  rol público ya publicado por MINEDUC); (3) mantener (descartada: contradice
  `repo_publico`). Elegida: de-versionar going-forward + aceptar el residual de
  historial como riesgo documentado y revisable. Coherente con `repo_publico`
  ("nada se versiona si no es publicable") y con el modelo de la política (lo no
  publicable sale del repo, no se transforma).

## 9. Constantes y parámetros vigentes

Sin cambios respecto a v20. Colores de nivel (motor, intocables): `COLOR_ADEC
#0C4682`, `COLOR_ELEM #6BA0CE`, `COLOR_INSUF #79204F`. Suite: `verificar = FALSE`
permanente en `documentar.R`. Nuevo: `directorio_oficial_ee.csv` ignorado por Git
(insumo externo, descarga anual desde MINEDUC).

## 10. Arquitectura de archivos

Escáner al cierre: `50_documentacion/estructura/estructura_actual.md`, sello
2026-06-22 20:07:10 (22 carpetas, 138 archivos), poda a retención 2
(`191156` + `200710`). Cambios estructurales de la sesión: nuevo
`gobernanza_datos.md` y nueva decisión 21.719 en `activa/`; cuatro logs en
`andamios/logs/`; `directorio_oficial_ee.csv` fuera del índice (sigue en disco);
`backlog_historico.md` de 24.6K a 26.7K. `documentar.R` restaurado a su tamaño
real (46.9K). Sin desviaciones respecto a la política.

## 11. Pendientes y ruta sugerida

### Inventario de pendientes

1. **Anexar el delta de la sesión 21 al backlog (entradas 110–113).**
   - Tipo: documentación. Contexto: ver §5. Impacto: bajo. Complejidad: baja.
     Enfoque: primera acción de la apertura de s22 (o en el barrido de cierre de
     s21). Criterio de éxito: backlog en 1–113, sesión 21 documentada con su
     línea de Delta.

2. **Revisar periódicamente el residual de historial (D21-1).**
   - Tipo: gobernanza. Contexto: los 946 `MRUN` persisten en el historial público
     hasta `61c3b9b`. Aceptado como residual, pero revisable si cambia la
     naturaleza del dato o la postura institucional. Impacto: bajo en condiciones
     actuales. Sin acción inmediata.

3. **Cotejar las 6 marcas `# REVISAR (voz)` del `documentar.R`.**
   - Heredado de v20 (pendiente 2). Tipo: documentación / afinamiento de tono.
     Impacto: bajo. Requiere criterio editorial del titular o texto de voz de
     referencia.

4. **Actualizar la copia de `POLITICA_PROYECTO.md` y `SETTINGS_…` en la knowledge
   base a la versión vigente.**
   - Heredado de v20 (pendiente 4). Tipo: gobernanza. Tarea manual del titular.

5. **Normalización opcional del vocabulario de categorías del backlog (57+).**
   - Heredado de v20 (pendiente 3). Diferible indefinidamente (D20-3).

### Deuda técnica / zonas frágiles
- Ninguna nueva en código (sesión sin cambios de pipeline/motor).
- Riesgo operativo registrado: un scaffold de `suitedoc` mal corrido puede
  sobrescribir el `documentar.R` real en disco. Verificar working tree vs HEAD
  antes de cerrar es la barrera.

### Auditoría de cierre (política 5.6)
- Datos crudos aislados e inmutables → Sí (sin cambios; el directorio crudo ahora
  fuera del índice refuerza el aislamiento).
- Pipeline corre de cero sin intervención manual → Sí, con la salvedad ahora
  documentada de que el directorio debe descargarse de MINEDUC en una máquina
  nueva (README actualizado).
- Outputs reproducibles → Sí.
- Nombres sin tildes/ñ/espacios → Sí en lo tocado (deuda heredada trivial
  `Motor SIMCE.html` en `prototipo_design/`, congelado, no se toca).

### Ruta sugerida para la sesión 22
1. **Apertura:** anexar el delta s21 al backlog (pendiente 1, trivial) si no se
   cerró en s21.
2. **Si se retoma desarrollo:** el proyecto está estable y desplegado; sin bugs
   ni bloqueantes. Posibles focos los decide el titular.
3. **Diferibles:** marcas `# REVISAR (voz)`, normalización de categorías.

## 12. Instrucciones específicas para la próxima sesión

- ✅ ANTES de cualquier foco nuevo en s22, anexar el delta de la sesión 21 al
  backlog (entradas 110–113) si no se cerró en el barrido de s21, y verificar que
  la última entrada del backlog vivo coincida con la numeración esperada (A22).
- 🔒 NO re-versionar `directorio_oficial_ee.csv` ni ningún derivado con `MRUN`,
  `RUT_SOSTENEDOR` de persona natural o geo de personas (D21-1). El directorio es
  insumo externo, se descarga de MINEDUC.
- 🔒 NO implementar supresión de celdas por `n_estab` (D20-1 / D-nombres).
- 🔒 Color por nivel, % Adecuado y corte de traspaso intocables; corte solo en
  `SimceData.anioCorteTraspaso()`.
- ✅ ANTES de cerrar una sesión, verificar el working tree contra HEAD
  (`git status` + `git diff` sobre archivos clave): un escáner que lista el
  filesystem no detecta que un archivo versionado fue sobrescrito en disco.
- ✅ Para afirmar qué está versionado, usar `git ls-files`, no el escáner (A20):
  el CSV de-versionado sigue apareciendo en el árbol del escáner.
- ✅ `verificar = FALSE` permanente en `documentar.R`; regenerar la suite con
  `setwd("<raiz>")` o desde el `.Rproj`.
- ⚠️ Los `verificar_*.R` de la raíz son efímeros y ahora ignorados por `.gitignore`;
  no versionar.
- ⚠️ `SETTINGS_Y_PROMPTS_OPERACIONALES.md` se mantiene local (untracked) por
  diseño; no versionar en el repo público.
- ✅ Si un encargo declara gate de revisión del titular, ningún artefacto (código,
  log ni datos) se publica antes de la aprobación.

## 13. Fragmentos de código de referencia

Sin fragmentos nuevos esta sesión. Patrón vigente de de-versionado de un insumo
sensible conservándolo en disco (la forma correcta en este proyecto):

```bash
# De-versionar un insumo del repo público sin borrarlo del disco
git -C /Users/tomgc/Projects/slep_simce_adecuado rm --cached 20_insumos/auxiliares/directorio_oficial_ee.csv
# + añadir la ruta al .gitignore + documentar en README que se descarga de la fuente
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 22 (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  "Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo
  (POLÍTICA v6 + SETTINGS) vive en la knowledge base; léelo desde ahí. Adjunto el
  traspaso v21 y el escáner actual. Primera acción sugerida: anexar el delta de la
  sesión 21 al backlog (entradas 110–113) si no se cerró en el barrido de s21,
  antes de proponer foco nuevo. No hay foco obligado; el proyecto está estable y
  desplegado."
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base* (NO adjuntar; verificar que estén al día):
     `POLITICA_PROYECTO.md` (v6), `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `CLAUDE.md` si corre en Claude Code;
     `backlog_historico.md` para anexar el delta s21;
     `encargo_autonomo_claude_code_v1.md` si se usan encargos autónomos.
  3. *Específicos (SÍ adjuntar):* `traspaso_cierre_v21.md`; `estructura_actual.md`.
- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
  versión más actualizada al abrir y avisarlo en el mensaje de apertura.
