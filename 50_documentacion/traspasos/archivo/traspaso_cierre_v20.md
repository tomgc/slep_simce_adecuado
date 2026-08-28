# Traspaso de cierre v20 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`
- **Versión:** v20
- **Fecha:** 2026-06-21
- **Sesión:** 20 — sesión de documentación y gobernanza, tres focos: (a)
  formalizar en archivo de decisión el cierre 4b/depe4 heredado de v19; (b)
  cotejar y corregir las marcas `# REVISAR (decisión)` del `documentar.R` de la
  suite; (c) reconstruir el backlog histórico 61–105, cerrando la deuda de
  actualización acumulada desde la sesión 14.
- **Entorno:** sesión en interfaz web (Claude conversacional como redactor);
  todas las operaciones de terminal, git y edición de archivos ejecutadas por
  Claude Code en modo autónomo (patrón `encargo_autonomo_claude_code_v1`).
- **Archivos principales creados/modificados:**
  `50_documentacion/activa/decisiones/20260620_decision_celda_unico_establecimiento.md`
  (nuevo); `50_documentacion/suite/documentar.R` +
  `documentacion_proyecto_slep_simce_adecuado.html` (corrección de marcas);
  `50_documentacion/activa/backlog_historico.md` (reconstrucción 61–105);
  dos logs de andamio nuevos en `50_documentacion/andamios/logs/`. Sin cambios
  de pipeline, motor ni constantes.

## 2. Resumen ejecutivo

Sesión de cierre documental, sin tocar pipeline ni motor, ejecutada íntegramente
mediante encargos autónomos a Claude Code. **(P1)** Se formalizó el cierre de
gobernanza 4b/depe4 (heredado de v19) en un archivo de decisión autocontenido,
corolario de D-nombres: las celdas con `n_estab=1` no se suprimen porque el motor
expone establecimientos individuales por diseño y la restricción de §6.4 aplica
solo a microdatos por estudiante. **(P2)** Se cotejaron las marcas
`# REVISAR (decisión)` del `documentar.R`: las anunciadas como "2 marcas" en v19
eran en realidad temas de contenido mal rotulados; se hallaron 3 marcas reales,
se corrigió una imprecisión real (el bloque de color atribuía el color "al
periodo", algo que la decisión de color s15 no contempla) y se confirmaron las
otras dos contra el backlog #57; suite regenerada y versionada. **(P3)** Se
descubrió que el backlog vivo estaba congelado en la entrada 60 / sesión 13: las
entradas 61–102 se documentaron en los traspasos v14–v18 pero nunca se anexaron
al archivo vivo. Se reconstruyeron las 45 entradas faltantes (61–105) desde el §4
de los traspasos v14–v19, se cotejaron las 19 categorías inferidas de las
sesiones 15–16, y el backlog quedó en 1–105 / 19 sesiones. Las tres prioridades
commiteadas y pusheadas a `origin/main`.

> **Registro de ejecución detallado:**
> `50_documentacion/andamios/logs/20260620_cotejo_marcas_suite_log.md` y
> `50_documentacion/andamios/logs/20260620_reconstruccion_backlog_log.md`
> (logs de las sesiones de Claude Code; detalle paso a paso no reproducido aquí).

## 3. Estado al cierre

**Qué funciona:**
- Decisión 4b/depe4 formalizada y versionada (`e0d4438`).
- Suite de documentación corregida y regenerada (`e14048f`); sin marcas
  `# REVISAR (decisión)` residuales (solo la cabecera explicativa de la
  convención).
- Backlog histórico vivo cubre 1–105 / 19 sesiones, sin huecos ni duplicados
  (`409b861`).
- Motor y pipeline sin cambios desde v18; build y Pages al día.
- Rama `main` al día con `origin/main` tras los pushes de la sesión.

**Qué no funciona / pendiente:**
- Las 6 marcas `# REVISAR (voz)` del `documentar.R` siguen abiertas por diseño
  (prosa de comunidad pendiente de afinar tono; revisable por el titular, no
  bloqueante).
- Vocabulario de categorías del backlog heterogéneo: 1–56 usan la taxonomía
  estricta de 7; 57–105 conservan tags compuestos del traspaso
  (`[Metodología/UI]`, `[Gobernanza/Auditoría]`, etc.). Decisión deliberada de
  no normalizar ahora (ver sección 8); queda como mantenimiento opcional.

**Delta respecto a v19:**
- Nuevo archivo de decisión 4b/depe4 (cierra el pendiente "sin formalizar" de v19).
- `documentar.R` corregido (cierra el pendiente "2 marcas sin cotejar" de v19).
- Backlog reconstruido 61–105 (cierra deuda de actualización desde s14).
- Nueva carpeta `50_documentacion/andamios/logs/` con 2 logs de ejecución.

## 4. Registro detallado de cambios (de la sesión)

1. **[DOC/Gobernanza] Archivo de decisión 4b/depe4.** Categoría: documentación /
   gobernanza. Se creó
   `20260620_decision_celda_unico_establecimiento.md`, corolario de D-nombres:
   formaliza que las celdas con `n_estab=1` no se suprimen, porque el riesgo de
   identificación de establecimiento individual es general y deliberado en el
   motor, y la restricción de §6.4 aplica solo a microdatos por estudiante.
   Documenta las dos alternativas descartadas (colapsar `depe2`; suprimir por
   `n_estab < k`) con su porqué. Commit `e0d4438`, pusheado.

2. **[REPO/Infra] Versionado del cierre v19 pendiente.** En el mismo barrido se
   versionaron el `traspaso_cierre_v19.md` (que había quedado sin trackear al
   cerrar v19) y la rotación de snapshots del escáner (retención 2). Commit
   `8214f39`, pusheado.

3. **[DOC] Corrección de marcas `# REVISAR (decisión)` en la suite.** Categoría:
   documentación. Cotejo de las 3 marcas reales del `documentar.R` contra sus
   fuentes: (i) bloque de color: se corrigió una imprecisión real (eliminada la
   atribución del color "al periodo", que la decisión de color s15 no contempla;
   añadido el mecanismo de identidad por nombre/swatch/borde que la fuente sí
   especifica); (ii) item A2 del diccionario e (iii) glosario de marca:
   confirmados fieles al backlog #57, solo se retiró la marca. Suite regenerada
   (4 HTML); commit `e14048f`, pusheado. Log de ejecución versionado en
   `2488a2f`.

4. **[DOC] Reconstrucción del backlog histórico 61–105.** Categoría:
   documentación. Se descubrió que el archivo vivo estaba congelado en la
   entrada 60 / sesión 13; las entradas 61–102 vivían solo en los §4 de los
   traspasos v14–v18, nunca anexadas. Se reconstruyeron las 45 entradas
   faltantes (61–105) desde el §4 de cada traspaso (no el §5, que es solo un
   puntero), respetando la numeración global de cada uno (v14 numera global
   directo; v15–v19 numeran local y declaran el rango global en su §5). Backlog
   en 1–105 / 19 sesiones, entradas 1–60 intactas. Commit `409b861`, pusheado.

5. **[DOC] Cotejo de las 19 categorías inferidas (entradas 80–98).** Categoría:
   documentación. Los §4 de v15/v16 no asignan categoría por entrada; las 19
   inferidas se cotejaron contra el texto verbatim y se retiraron las marcas
   `# REVISAR (categoría)`. Único cambio real de categoría: entrada 83
   (DOC/UI → UI/DOC). Las entradas 95 y 97 ya estaban correctas desde la
   reconstrucción. Incluido en el commit `409b861`.

## 5. Backlog acumulativo

El backlog vivo (`50_documentacion/activa/backlog_historico.md`) quedó
**reconstruido y al día en esta sesión**: cubre las entradas **1–105** en
**19 sesiones**, sin huecos ni duplicados. La deuda de actualización (sesiones
14–18 sin anexar) quedó cerrada.

**Delta de la sesión 20:** esta sesión produjo trabajo de documentación y
gobernanza cuyo registro como entradas de backlog (las correspondientes a la
sesión 20: decisión 4b/depe4, corrección de marcas de suite, reconstrucción del
backlog, cotejo de categorías) **debe agregarse al backlog vivo en la apertura
de la sesión 21 como entradas 106–109** (continuando la numeración), siguiendo
la regla de mantenimiento por delta. No se agregaron en esta sesión para no
mezclar la reconstrucción histórica (acción primaria de P3) con el delta de la
propia sesión en el mismo commit.

> Nota metodológica vigente (sin cambios): "cambio" = una solicitud distinguible
> del usuario, no las acciones técnicas que la implementan. Clasificación por
> intención primaria. Fuente del conteo: traspasos + este backlog.

## 6. Bugs de la sesión

No hubo bugs de proyecto (sesión sin cambios de pipeline ni motor).

**Incidente de ejecución (Claude Code, resuelto):**
- **Síntoma:** al retirar las 19 marcas `# REVISAR (categoría)` con un
  `replace_all` de reemplazo vacío, se colapsaron los saltos de línea,
  concatenando las entradas 80–91 en una línea y 92–98 en otra.
- **Causa raíz:** borrar una cadena-sufijo repetida por línea con reemplazo vacío
  arrastra el `\n` adyacente cuando el patrón lo incluye.
- **Detección:** la verificación de continuidad cayó a 88 entradas en vez de 105
  (la auto-auditoría lo cazó antes de reportar).
- **Solución:** reinserción de los saltos de línea en ambos bloques; descripciones
  intactas. Re-verificación: 1–105 íntegro.
- **Regla aprendida:** para borrar un sufijo repetido por línea, anclar el patrón
  al texto vecino (no reemplazar la cadena suelta con vacío), o validar el conteo
  de líneas inmediatamente después de la edición.

## 7. Aprendizajes y restricciones descubiertas

- **El §5 de los traspasos v14–v19 es un puntero, no el detalle.** Las entradas
  numeradas con detalle viven en el §4 (Registro detallado de cambios). Regla:
  al reconstruir backlog desde traspasos, leer el §4, no el §5. Conviene
  homogeneizar el formato de traspasos futuros para que el §5 sea la fuente
  canónica del backlog (como en v13).
- **Numeración local vs global en traspasos.** v15–v19 numeran localmente en su
  §4 (1, 2, 3…); el número global correcto lo declara el §5. Mapeo verificado:
  v15 +79, v16 +91, v17 +98, v18 →102, v19 +102. Al integrar, usar siempre el
  global declarado.
- **El backlog vivo puede quedar a la deriva sin que el traspaso lo note.** Cinco
  sesiones (14–18) declararon "se anexa al histórico" sin que ocurriera. Regla
  (refuerzo de A22): en cada apertura, verificar que la última entrada del
  backlog vivo coincida con la numeración que el traspaso da por sentada, antes
  de agregar el delta nuevo.
- **Aprendizaje de proceso (gate de revisión vs push):** en P2, el encargo dejó
  el log sin commitear para revisión, pero el código corregido ya se pusheó en
  el mismo turno. El contenido estaba validado, así que no hubo daño, pero
  cuando un encargo declara gate de revisión del usuario, el push también debería
  esperar a esa revisión, no solo el log. Regla: si hay gate de revisión, ningún
  artefacto (código ni log) se publica antes de la aprobación.
- **Contaminación cruzada entre proyectos (cuidado operativo).** Durante la
  sesión se pegaron por error dos artefactos de otro proyecto
  (`slep_aprendizajes_ep`): un backlog consolidado (1→335) y un output de Claude
  Code sobre un `traspaso-cierre-v77`. Ambos se detectaron por inconsistencia con
  el estado real de este proyecto (numeración, convención de nombres) y se
  descartaron sin contaminar el repo. Regla: verificar el encabezado/identidad de
  cualquier artefacto cargado contra el proyecto activo antes de usarlo como
  fuente.

## 8. Decisiones de diseño

- **D20-1 — Celdas con `n_estab=1` no se suprimen.** Formalizada en
  `20260620_decision_celda_unico_establecimiento.md` (corolario de D-nombres).
  Alternativas: colapsar `depe2` (rompe el filtro por dependencia); suprimir por
  umbral `n_estab < k` (contradice D-nombres, degrada utilidad, sesga agregados).
  Elegida: no suprimir. Invariante 🔒 ya vigente desde v19.
- **D20-2 — Backlog reconstruido desde traspasos, no desde el consolidado de
  chat.** Se descartó adoptar un `backlog_consolidado.md` externo como canónico
  (no estaba versionado; además el archivo cargado resultó ser de otro proyecto).
  Fuente elegida: los §4 de los traspasos v14–v19, versionados y auditables.
- **D20-3 — Tags de categoría compuestos se conservan, no se normalizan.** Las
  entradas 57–105 mantienen tags ricos del traspaso aunque excedan la taxonomía
  oficial de 7, siguiendo el precedente 57–60. Alternativa (normalizar 49
  entradas a las 7 oficiales) descartada por bajo retorno frente a la fidelidad.
  Implicancia: la tabla de clasificación temática del backlog sí debe usar las 7
  oficiales; los tags inline pueden ser más ricos. Homogeneizar todo el backlog
  queda como mantenimiento opcional futuro.

## 9. Constantes y parámetros vigentes

Sin cambios respecto a v19. Referencia (suite): `verificar = FALSE` permanente en
`documentar.R` (`suitedoc::generar_suite`). Colores de nivel (motor, intocables):
`COLOR_ADEC #0C4682`, `COLOR_ELEM #6BA0CE`, `COLOR_INSUF #79204F`.

## 10. Arquitectura de archivos

Escáner al cierre: `50_documentacion/estructura/estructura_actual.md`, sello
2026-06-21 09:37:49 (22 carpetas, 132 archivos). Cambios estructurales de la
sesión: nueva carpeta `50_documentacion/andamios/logs/` con 2 logs; nuevo archivo
de decisión; `backlog_historico.md` de 12.4K a 24.6K. Sin desviaciones respecto a
la política. Rotación de snapshots del escáner conforme a retención 2.

## 11. Pendientes y ruta sugerida

### Inventario de pendientes

1. **Agregar el delta de la sesión 20 al backlog (entradas 106–109).**
   - Tipo: documentación. Contexto: el trabajo de esta sesión (4 cambios
     conceptuales) no se anexó al backlog para no mezclar con la reconstrucción
     histórica. Impacto: bajo. Complejidad: baja. Enfoque sugerido: primera
     acción de la apertura de s21, antes de cualquier foco nuevo. Criterio de
     éxito: backlog en 1–109, con la sesión 20 documentada y su línea de Delta.

2. **Cotejar las 6 marcas `# REVISAR (voz)` del `documentar.R`.**
   - Tipo: documentación / afinamiento de tono. Contexto: prosa de comunidad
     redactada sin texto de voz de referencia. Impacto: bajo (cosmético).
     Complejidad: baja, pero requiere criterio editorial del titular o un texto
     de voz de referencia. Enfoque: aportar un documento ejecutivo/correo tipo
     como referencia de tono, o revisar las 6 a mano. Criterio de éxito: las 6
     marcas resueltas, suite regenerada.

3. **Normalización opcional del vocabulario de categorías del backlog.**
   - Tipo: deuda técnica / documentación. Contexto: 57–105 usan tags compuestos.
     Impacto: bajo. Complejidad: media (49 entradas). Diferible indefinidamente;
     solo si se quiere homogeneidad total. Criterio de éxito: todo el backlog en
     la taxonomía de 7.

4. **Actualizar la copia de `POLITICA_PROYECTO.md` en la knowledge base a v6.**
   - Tipo: gobernanza. Heredado (transcrito en backlog #101). Contexto: la copia
     del repo es v6; verificar que la knowledge base del Project esté al día.
     Impacto: medio (afecta a futuras sesiones). Complejidad: baja (tarea manual
     del titular). Criterio de éxito: knowledge base con v6.

### Deuda técnica / zonas frágiles
- Ninguna nueva en código (sesión sin cambios de pipeline/motor).
- El formato de traspasos (§5 puntero vs §4 detalle) es una fricción documental:
  homogeneizarlo evitaría futuras reconstrucciones.

### Auditoría de cierre (política 5.6)
- Datos crudos aislados e inmutables → Sí (sin cambios).
- Pipeline corre de cero sin intervención manual → Sí (sin cambios).
- Nombres sin tildes/ñ/espacios → Sí en lo tocado esta sesión (deuda heredada
  trivial: `Motor SIMCE.html` en `prototipo_design/`, congelado, no se toca).
- Outputs reproducibles → Sí (suite regenerable por comando).

### Ruta sugerida para la sesión 21
La sesión 20 cerró el foco documental completo. No hay foco obligado para s21;
candidatos, en orden de prioridad sugerida:
1. **Apertura:** anexar el delta s20 al backlog (pendiente 1, trivial, primero).
2. **Si se retoma desarrollo:** el proyecto está estable y desplegado; no hay
   bugs ni bloqueantes. Posibles focos nuevos los decide el titular (no hay deuda
   funcional pendiente en el motor).
3. **Cosmético/diferible:** marcas `# REVISAR (voz)` (pendiente 2).

## 12. Instrucciones específicas para la próxima sesión

- ✅ ANTES de cualquier foco nuevo en s21, anexar el delta de la sesión 20 al
  backlog (entradas 106–109) y verificar que la última entrada del backlog vivo
  coincida con la numeración esperada (refuerzo de A22).
- ✅ ANTES de reconstruir o auditar backlog desde traspasos, leer el §4 (detalle),
  no el §5 (puntero), y usar la numeración global declarada en el §5.
- ⚠️ NO normalizar los tags de categoría del backlog sin decisión explícita del
  titular (D20-3).
- 🔒 NO implementar supresión de celdas por `n_estab` (D20-1 / D-nombres).
- 🔒 Color por nivel, % Adecuado y corte de traspaso intocables; corte solo en
  `SimceData.anioCorteTraspaso()`.
- ✅ `verificar = FALSE` permanente en `documentar.R`; regenerar la suite con
  `setwd("<raiz>")` o desde el `.Rproj` (usa `here::i_am()`).
- ✅ Si se actualiza la suite: versionar `documentar.R` + 4 HTML + CSS; `fonts/` y
  `assets/` permanecen ignorados.
- ⚠️ Los `verificar_*.R` de la raíz son efímeros; no versionar.
- ⚠️ Verificar la identidad de todo artefacto cargado (encabezado, numeración,
  convención de nombres) contra el proyecto activo antes de usarlo como fuente
  (contaminación cruzada entre proyectos).
- ✅ Si un encargo declara gate de revisión del usuario, ningún artefacto (código
  ni log) se publica antes de la aprobación.

## 13. Fragmentos de código de referencia

Sin fragmentos nuevos esta sesión. Patrón vigente de regeneración de la suite
(la forma correcta en este proyecto):

```r
# Regenerar la suite documental (desde la raíz del proyecto; documentar.R usa here::i_am)
Rscript -e 'setwd("/Users/tomgc/Projects/slep_simce_adecuado"); source("/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite/documentar.R")'
```

## 14. Reapertura

- **Nombre del chat:** `slep_simce_adecuado, sesión 21 (Opus 4.8)`
- **Mensaje de apertura pre-armado:**
  "Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo
  (POLÍTICA v6 + SETTINGS) vive en la knowledge base; léelo desde ahí. Adjunto el
  traspaso v20 y el escáner actual. Primera acción sugerida: anexar el delta de la
  sesión 20 al backlog (entradas 106–109) antes de proponer foco nuevo. No hay
  foco obligado; el proyecto está estable y desplegado."
- **Documentos para la próxima sesión:**
  1. *Protocolo en knowledge base* (NO adjuntar; verificar que estén al día):
     `POLITICA_PROYECTO.md` (v6), `SETTINGS_Y_PROMPTS_OPERACIONALES.md`.
  2. *Opcionales según foco:* `CLAUDE.md` si corre en Claude Code;
     `backlog_historico.md` para anexar el delta s20;
     `encargo_autonomo_claude_code_v1.md` si se usan encargos autónomos.
  3. *Específicos (SÍ adjuntar):* `traspaso_cierre_v20.md`; `estructura_actual.md`.
- **Nota final:** si algún archivo listado cambió entre sesiones, adjuntar la
  versión más actualizada al abrir y avisarlo en el mensaje de apertura.
