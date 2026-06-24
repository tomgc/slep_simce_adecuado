# Traspaso de cierre v22 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v22
- **Fecha:** 2026-06-23
- **Sesión:** 22 — regeneración de la suite de documentación como **standalone
  offline**, con actualización de la `cfg` para incorporar las decisiones formales
  de s20–s21 (D20-1, D21-1) y la gobernanza Ley 21.719. Foco único de desarrollo;
  precedido de la limpieza de working tree heredada del cierre de s21.
- **Entorno:** sesión web (Claude redactor) + Claude Code autónomo (patrón
  `encargo_autonomo_claude_code_v1`).
- **Archivos principales modificados:** `50_documentacion/suite/documentar.R`
  (cfg ampliada: 6 decisiones formales con `id`/`por_que`, gobernanza 21.719,
  diccionario del directorio, llamada `standalone=TRUE`); 4
  `*_standalone.html` (reemplazan a los enlazados); `activa/encargos/` (encargo
  saneado versionado); `backlog_historico.md` ya estaba en 1–113 desde s21.

## 2. Resumen ejecutivo

Sesión de desarrollo con foco único: regenerar la suite de documentación como
standalone offline. Se abrió cerrando el working tree pendiente del cierre de s21
(churn del escáner) y resolviendo dos incidentes: un encargo de suite standalone
cuya Fase A había quedado obsoleta (el backlog ya estaba en 1–113; correrla habría
duplicado entradas) se recortó a solo Fase B, y se verificó la API real de
`suitedoc` antes de redactar (la firma es `generar_suite(..., standalone=TRUE)`, que
internamente llama a `inlinar_suite(limpiar_enlazados=TRUE)`; no se invoca por
separado). La `cfg` del `documentar.R` se actualizó por merge: `cfg$gobernanza` pasó
de una línea genérica a un párrafo que refleja `gobernanza_datos.md` (Ley 21.719,
de-versionado del directorio, residual de historial); `cfg$decisiones` incorporó las
6 decisiones formales con su `id` y `por_que` extraídos de los archivos (no
inventados), sumando D20-1 y D21-1 que el documentar.R de s19 no tenía; el
diccionario marca `directorio_oficial_ee.csv` como insumo no versionado. Se regeneró
con `standalone=TRUE` (npm descargó lucide-static 1.21.0; todos los iconos
resolvieron sin sustituciones) produciendo 4 `*_standalone.html` 100% offline,
verificados empíricamente: 0 referencias de red por archivo, iconos como `<svg>`
embebido, fuentes como `data:` URIs, terminología SLEP correcta. El gate de revisión
normativa (que el doc general no expusiera el conteo 946 ni el hash del historial) se
aprobó: el general menciona el cumplimiento sin esos detalles. Todo pusheado.

> **Registro de ejecución detallado:**
> `50_documentacion/andamios/logs/20260622_suite_standalone_simce_log.md`.

## 3. Estado al cierre

**Qué funciona:**
- Suite de documentación en 4 `*_standalone.html` 100% offline (CSS/fuentes/logos
  base64, iconos lucide como SVG embebido), 0 referencias de red verificadas.
- `documentar.R` (50.6K) con cfg al día: 6 decisiones formales (con `id` y `por_que`
  del archivo), gobernanza Ley 21.719, directorio marcado no versionado, llamada
  `standalone=TRUE`. `verificar = FALSE` permanente.
- Backlog en 1–113 / 21 sesiones (sin cambios esta sesión; se cerró en s21).
- Motor, pipeline y datos sin cambios. Pages al día.
- Encargo saneado versionado en `activa/encargos/`.
- Rama `main` al día con `origin/main` (`c5b6a17`).

**Qué no funciona / pendiente:**
- Residual de historial (heredado, D21-1): los 946 `MRUN` persisten en el historial
  público hasta `61c3b9b`. Aceptado, revisable.
- `README.md` con una modificación del titular sin commitear (deliberada, fuera de
  los focos de esta sesión).
- 7 marcas `# REVISAR (voz)` en `documentar.R`: prosa de comunidad, afinamiento de
  tono del titular; no se cierran por encargo.

**Delta respecto a v21:**
- Suite enlazada → standalone offline (4 `*_standalone.html`; enlazados eliminados).
- `cfg$gobernanza` y `cfg$decisiones` actualizados (Ley 21.719 + 6 decisiones
  formales). `documentar.R` de 46.9K a 50.6K.
- Encargo de suite saneado a solo Fase B y versionado.
- Reorganización de encargos a `activa/encargos/` (de s21, ya pusheada `fb13548`).

## 4. Registro detallado de cambios (de la sesión)

1. **[Infra] Cierre de working tree heredado de s21.** Categoría: infraestructura.
   Commit del churn del escáner (`6c50496`, rotación de snapshots a retención 2:
   sellos `201059` + `211345`). Cierra el pendiente de cierre de s21.

2. **[Proceso] Saneamiento del encargo de suite standalone.** Categoría: proceso /
   encargo. El encargo original tenía Fase A (anexar backlog 110–113) obsoleta (el
   backlog ya estaba en 1–113); correrla habría duplicado entradas. Se recortó a solo
   Fase B y se verificó la API real de `suitedoc` antes de redactar (R3): firma
   `generar_suite(cfg, salida_dir, copiar_tema, verificar, standalone, verbose)`;
   `standalone=TRUE` orquesta `inlinar_suite` internamente; lucide-static fijado en
   1.21.0; `inlinar_suite` aborta si un icono no resuelve. Caveat detectado: la
   generación requiere `npm` + red (la suite resultante es offline, generarla no).

3. **[DOC/Gobernanza] Actualización de la cfg del `documentar.R`.** Categoría:
   documentación / gobernanza. `cfg$gobernanza`: de string genérico a párrafo desde
   `gobernanza_datos.md`. `cfg$decisiones`: 6 decisiones formales con `id` y `por_que`
   del archivo (se agregaron D20-1 celda único, D21-1 Ley 21.719, Apache y repo
   público; se cotejaron color por nivel y D-nombres). Diccionario:
   `directorio_oficial_ee.csv` marcado como insumo externo no versionado (D21-1).
   Terminología SLEP verificada (0 "colegio" genérico, 0 "EE" visible).

4. **[DOC] Regeneración standalone offline.** Categoría: documentación. Llamada
   cambiada a `standalone=TRUE`; regeneración produjo 4 `*_standalone.html` (442–456
   KB), enlazados intermedios eliminados por `limpiar_enlazados=TRUE`. Verificación
   empírica: 0 red por archivo, iconos SVG embebido, fuentes `data:` URIs, 6
   decisiones + gobernanza 21.719 presentes en el HTML. Commit `6f94729`.

5. **[DOC] Versionado de encargo saneado + log.** Categoría: documentación. Encargo
   recortado a Fase B versionado en `activa/encargos/`; log de la suite versionado.
   Commit `c5b6a17`, pusheado junto con `6f94729`.

## 5. Backlog acumulativo

El backlog (`50_documentacion/activa/backlog_historico.md`) está en **1–113 / 21
sesiones** (consolidado en s21; sin cambios esta sesión hasta el cierre).

**Delta de la sesión 22 (a anexar como entradas 114–116 en el barrido de cierre, o
en la apertura de s23):**

- **114. [Proceso]** Saneamiento del encargo de suite standalone: recorte a solo
  Fase B (Fase A obsoleta, backlog ya en 1–113) y verificación de la API real de
  `suitedoc` antes de redactar (firma `standalone=`, lucide 1.21.0). Sin commit de
  código (trabajo de análisis); materializado en el encargo versionado.
- **115. [DOC/Gobernanza]** Actualización de la cfg del `documentar.R`: gobernanza
  Ley 21.719 + 6 decisiones formales (con `id`/`por_que` del archivo, +D20-1 +D21-1)
  + directorio marcado no versionado. Commit `6f94729`.
- **116. [DOC]** Regeneración de la suite como standalone offline (4
  `*_standalone.html`, 0 red verificado) + versionado del encargo saneado y el log.
  Commits `6f94729`, `c5b6a17`.

> **Recomendación de cierre del ciclo backlog:** anexar 114–116 en el barrido de
> cierre de s22 (mismo criterio aplicado en s21, que cerró la deuda que v20 arrastró).
> Si se anexa ahora, actualizar esta sección a "anexado en s22", el total a 116, la
> cobertura a 1–22, y agregar la línea de Delta.

> Nota metodológica vigente (sin cambios): "cambio" = solicitud distinguible del
> usuario. Clasificación por intención primaria.

## 6. Bugs de la sesión

No hubo bugs de proyecto (sin cambios de pipeline ni motor).

**Incidentes de proceso (resueltos):**

- **Encargo con Fase A obsoleta a punto de ejecutarse.** Síntoma: un encargo de suite
  standalone (movido al repo en s21) tenía guarda "PARA si backlog no está en 1–109",
  pero el backlog ya estaba en 1–113; su Fase A habría anexado 110–113 duplicándolas.
  Detección: se cortó la ejecución al notar la guarda obsoleta; verificación confirmó
  cero daño (solo una lectura). Solución: recortar el encargo a solo Fase B. **Regla
  aprendida:** un encargo persistido en el repo se desactualiza respecto al estado
  vivo; antes de ejecutarlo, revalidar sus guardas contra el estado real (backlog,
  HEAD), no confiar en que siguen vigentes.

- **`documentar.R` sobrescrito por stub (heredado de s21, ya resuelto).** Re-verificado
  en Paso 0 de esta sesión: el de disco era el real (46.9K), no el stub.

## 7. Aprendizajes y restricciones descubiertas

- **Verificar la API real antes de redactar un encargo (R3).** El encargo asumía
  `generar_suite(standalone=TRUE)` e `inlinar_suite()` como pasos separados; la
  lectura de `generar.R`/`inline.R` confirmó que `standalone=TRUE` orquesta el
  inlining internamente. Redactar sobre la firma supuesta habría producido una llamada
  redundante o errónea.
- **Un encargo persistido en el repo es un andamio que se desactualiza.** Sus guardas
  (p. ej. "backlog en 1–109") reflejan el estado al redactarlo; al ejecutarlo en otra
  sesión hay que revalidarlas contra el estado vivo. La guarda obsoleta es la barrera
  que evitó la duplicación, pero solo si se respeta.
- **Generar offline puede requerir red.** `inlinar_suite()` descarga lucide-static vía
  npm en tiempo de generación. La suite resultante es 100% offline, pero su producción
  necesita `npm` + red. Verificar `npm` como precondición (Paso 0).
- **Un solo campo de cfg alimenta documentos de audiencias distintas.** `cfg$gobernanza`
  se renderiza igual en el manual técnico y en el general; el párrafo quedó algo
  técnico para el general (nombra `MRUN`, el insumo, D21-1) aunque sin filtrar el
  conteo 946 ni el hash. Aceptado; separar el campo por audiencia es mejora opcional.

## 8. Decisiones de diseño

- **D22-1 — Suite de documentación en formato standalone offline.** Se regeneró la
  suite con `standalone=TRUE` (reemplaza los HTML enlazados por `*_standalone.html`
  autocontenidos). Alternativa: mantener enlazados (descartada: dependen del tema en
  disco y de CDN para iconos; no son portables ni archivables como unidad). Elegida:
  standalone, alineada con el principio de HTML autocontenido del proyecto (igual que
  el motor). Versionado: los 4 `*_standalone.html` + `documentar.R` + CSS; `fonts/` y
  `assets/` siguen ignorados (el standalone ya los lleva embebidos).

## 9. Constantes y parámetros vigentes

Sin cambios de valores. Colores de nivel intocables: `COLOR_ADEC #0C4682`,
`COLOR_ELEM #6BA0CE`, `COLOR_INSUF #79204F`. Suite: `verificar = FALSE` y
`standalone = TRUE` permanentes en `documentar.R`. lucide-static fijado en 1.21.0
(en el paquete `suitedoc`). `directorio_oficial_ee.csv` ignorado por Git (descarga
anual desde MINEDUC).

## 10. Arquitectura de archivos

Escáner al cierre: sello 2026-06-23 16:10:31 (23 carpetas, 142 archivos). Cambios
estructurales de la sesión: suite con 4 `*_standalone.html` (los enlazados
desaparecieron); `documentar.R` 46.9K → 50.6K; nuevo log de suite; encargos en
`activa/encargos/` (2 archivos). El escáner debe re-correrse en el barrido de cierre
para podar a retención 2 (mostraba 3 timestamps). Sin desviaciones respecto a la
política.

## 11. Pendientes y ruta sugerida

### Inventario de pendientes

1. **Anexar el delta de la sesión 22 al backlog (entradas 114–116).**
   - Tipo: documentación. Contexto: §5. Impacto: bajo. Complejidad: baja. Enfoque:
     barrido de cierre de s22 o apertura de s23. Criterio: backlog en 1–116, cobertura
     1–22, línea de Delta presente.

2. **`README.md` modificado por el titular sin commitear.**
   - Tipo: pendiente del titular. El titular declaró el cambio como propio y válido;
     queda a su criterio cuándo commitearlo. No es deuda del asistente.

3. **Revisar periódicamente el residual de historial (D21-1).**
   - Heredado. Tipo: gobernanza. Sin acción inmediata.

4. **Marcas `# REVISAR (voz)` en `documentar.R` (7).**
   - Heredado. Afinamiento de tono del titular o texto de voz de referencia.

5. **Opcional: separar `cfg$gobernanza` por audiencia (técnico vs general).**
   - Nuevo. Mejora cosmética; el general queda algo técnico. Requiere tocar la cfg y
     posiblemente el builder. Diferible.

6. **Opcional: normalización del vocabulario de categorías del backlog (57+).**
   - Heredado (D20-3). Diferible.

### Deuda técnica / zonas frágiles
- Ninguna nueva en código.
- Riesgo de proceso registrado: encargos persistidos con guardas que se desactualizan
  (mitigación: revalidar contra estado vivo antes de ejecutar).

### Auditoría de cierre (política 5.6)
- Datos crudos aislados e inmutables → Sí (directorio fuera del índice desde s21).
- Pipeline corre de cero sin intervención → Sí (con la salvedad documentada del
  directorio descargable de MINEDUC).
- Outputs reproducibles → Sí.
- Nombres sin tildes/ñ/espacios → Sí en lo tocado (deuda trivial heredada
  `Motor SIMCE.html` en `prototipo_design/`, congelado).

### Ruta sugerida para la sesión 23
1. **Apertura:** anexar delta s22 (114–116) si no se cerró en s22.
2. **Sin foco obligado:** proyecto estable y desplegado. Focos posibles a criterio del
   titular (p. ej. afinamiento de voz de la suite, o un foco de datos/motor nuevo).
3. **Diferibles:** marcas de voz, separación de gobernanza por audiencia,
   normalización de categorías.

## 12. Instrucciones específicas para la próxima sesión

- ✅ ANTES de cualquier foco en s23, anexar el delta s22 al backlog (114–116) si no se
  cerró en el barrido de s22, verificando la numeración contra el estado real (A22).
- ✅ ANTES de ejecutar un encargo persistido en el repo, revalidar sus guardas contra
  el estado vivo (backlog, HEAD): un encargo es un andamio que se desactualiza.
- 🔒 NO re-versionar `directorio_oficial_ee.csv` ni derivados con `MRUN`,
  `RUT_SOSTENEDOR` de persona natural o geo de personas (D21-1).
- 🔒 NO implementar supresión de celdas por `n_estab` (D20-1 / D-nombres).
- 🔒 Color por nivel, % Adecuado y corte de traspaso intocables.
- ✅ `verificar = FALSE` y `standalone = TRUE` permanentes en `documentar.R`; regenerar
  con `setwd("<raiz>")` o desde el `.Rproj`. La regeneración requiere `npm` + red
  (descarga lucide-static 1.21.0).
- ✅ Verificar la API real de un paquete antes de redactar un encargo que la invoque
  (R3): no asumir firmas.
- ✅ Para afirmar qué está versionado usar `git ls-files`, no el escáner (A20).
- ⚠️ `SETTINGS_Y_PROMPTS_OPERACIONALES.md` se mantiene local (untracked) por diseño.
- ⚠️ `README.md` puede tener cambios del titular sin commitear; no descartarlos.

## 13. Fragmentos de código de referencia

Llamada canónica para regenerar la suite standalone offline (la forma correcta en
este proyecto):

```r
# Desde la raíz (here::i_am exige setwd a la raíz si se corre por Rscript):
# setwd("/Users/tomgc/Projects/slep_simce_adecuado")
suitedoc::generar_suite(
  cfg,
  salida_dir  = here::here("50_documentacion", "suite"),
  copiar_tema = TRUE,
  verificar   = FALSE,   # permanente: el ejemplo de fábrica marca términos de dominio
  standalone  = TRUE,    # produce *_standalone.html offline; limpia los enlazados
  verbose     = TRUE
)
# Requiere npm + red en tiempo de generación (descarga lucide-static 1.21.0).
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 23 (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  "Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo (POLÍTICA
  v6 + SETTINGS + DISCIPLINA_OPERATIVA) vive en la knowledge base; léelo desde ahí.
  Adjunto el traspaso v22 y el escáner actual. Primera acción sugerida: anexar el
  delta de la sesión 22 al backlog (entradas 114–116) si no se cerró en el barrido de
  s22, antes de proponer foco. No hay foco obligado; el proyecto está estable y
  desplegado."
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base* (NO adjuntar; verificar al día):
     `POLITICA_PROYECTO.md` (v6), `SETTINGS_Y_PROMPTS_OPERACIONALES.md`,
     `DISCIPLINA_OPERATIVA.md`.
  2. *Opcionales según foco:* `CLAUDE.md` si corre en Claude Code;
     `backlog_historico.md` para anexar el delta s22;
     `documentar.R` si se afina la voz de la suite.
  3. *Específicos (SÍ adjuntar):* `traspaso_cierre_v22.md`; `estructura_actual.md`.
- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la versión
  más actualizada al abrir y avisarlo.
