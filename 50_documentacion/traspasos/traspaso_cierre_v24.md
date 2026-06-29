# Traspaso de cierre — slep_simce_adecuado v24

**Proyecto:** slep_simce_adecuado  
**Versión:** v24  
**Fecha:** 2026-06-29  
**Sesión:** 24 — Cierre de backlog y pendientes de documentación  
**Entorno:** macOS aarch64, Positron, R 4.5.x  
**Archivos principales modificados:** `backlog_historico.md`, `resena_slep_simce_adecuado.md`, `50_documentacion/suite/documentar.R`

---

## 1. Resumen ejecutivo

La sesión 24 fue íntegramente de mantenimiento documental: no hubo cambios al motor ni al pipeline. Se cerró el delta de backlog de la sesión 23 (entradas 117–120), se versionó la reseña final del proyecto tomando como fuente canónica el `data.js` del portafolio del Área, se retiraron las 7 marcas `# REVISAR (voz)` de `documentar.R`, y se normalizaron todos los tags del backlog histórico a la taxonomía canónica de 7 códigos (D20-3). El proyecto queda sin pendientes activos, con `origin/main = 572324a` y working tree limpio salvo `SETTINGS_Y_PROMPTS_OPERACIONALES.md` untracked por diseño.

---

## 2. Estado al cierre

**Funciona:** motor desplegado en GitHub Pages, pipeline reproducible, suite standalone offline (4 HTML), backlog 1–120 normalizado, reseña versionada.

**No funciona / pendiente:** nada activo.

**Delta respecto a v23:** 4 commits de documentación, 0 cambios al motor o pipeline.

---

## 3. Registro detallado de cambios

**Cambio 1 — Anexar delta s23 al backlog (entradas 117–120)**  
Archivo: `50_documentacion/activa/backlog_historico.md`  
Qué: sección "Sesión 23" con 4 entradas (117–120), actualización de cobertura de 1–22 a 1–23, línea de Delta.  
Verificado: conteo 116→120 sin saltos; cobertura actualizada.  
Commit: `8944c2e`

**Cambio 2 — Reseña final (espejo de data.js orden 3)**  
Archivo: `50_documentacion/activa/resena_slep_simce_adecuado.md`  
Qué: archivo nuevo versionado por primera vez, contenido espejo verbatim del bloque `orden: 3` de `data.js` (objetivo + 3 párrafos de síntesis). Reemplaza el borrador con variantes A/B/C y marcas `[PENDIENTE]`.  
Verificado: 0 marcas PENDIENTE; cotejo verbatim automático contra `data.js` (3/3 párrafos).  
Commit: `d4051d0`

**Cambio 3 — Retirar marcas `# REVISAR (voz)` de documentar.R**  
Archivo: `50_documentacion/suite/documentar.R`  
Qué: eliminadas 7 marcas (6 inline + nota explicativa de L23). La marca `# REVISAR (decisión)` restante se conservó intacta (convención distinta).  
Verificado: 0 marcas `REVISAR (voz)` restantes; 1 marca `REVISAR (decisión)` intacta.  
Commit: `ef2aded`

**Cambio 4 — Normalizar tags del backlog a taxonomía canónica (D20-3)**  
Archivo: `50_documentacion/activa/backlog_historico.md`  
Qué: unificación de todos los tags del detalle cronológico a los 7 códigos canónicos (`P`, `UI`, `D`, `DOC`, `REPO`, `Infra`, `DT`). Entradas 1–56 pasaron de `— CÓDIGO` a `[CÓDIGO]`; compuestos libres (`[Pipeline/Corrección]`, `[Frontend]`, `[Gobernanza/Auditoría]`, etc.) mapeados al canónico por intención primaria. 116 entradas, 0 tags fuera del canónico al cierre.  
Verificado: grep de tags no-canónicos = 0; suma de tags = 116.  
Commit: `572324a`

---

## 4. Backlog acumulativo

### Objetivo del proyecto
`slep_simce_adecuado` es un motor de comparación interactivo de los resultados de las pruebas Simce por estándares de aprendizaje (Adecuado, Elemental, Insuficiente), construido en React 18 + D3 v7 como HTML standalone, con pipeline en R. Permite comparar el % Adecuado entre establecimientos, comunas, SLEP, regiones y nivel nacional, segmentado por GSE, para 4° básico y 2° medio en Lectura y Matemática, a lo largo de 2014–2025. Publicado en GitHub Pages. Producido en el Área de Monitoreo y Seguimiento del SLEP Costa Central.

### Nota metodológica
Un "cambio" es una solicitud distinguible del usuario, no las acciones técnicas que la implementan. No cuentan errores del asistente corregidos de inmediato; sí cuentan bugfixes reportados por el usuario. La clasificación es por intención primaria.

### Clasificación temática

| Código | Categoría | N° | % |
|---|---|---|---|
| UI | Motor HTML / React / D3 | 49 | 40.8% |
| REPO | Gobernanza del repo / Despliegue | 18 | 15.0% |
| DOC | Documentación | 23 | 19.2% |
| P | Pipeline R | 12 | 10.0% |
| Infra | Infraestructura (escáner, orquestador, CI) | 6 | 5.0% |
| DT | Deuda técnica | 6 | 5.0% |
| D | Datos / Insumos | 2 | 1.7% |
| Motor | (absorbido en UI desde s24) | — | — |

### Resumen estadístico por sesión

| Sesión | Traspaso | N° cambios | Foco |
|---|---|---|---|
| 1 | v01 | 4 | Scaffold, pipeline, UI v2 |
| 2 | v02 | 4 | depe2, sleps_chile, rediseño UI |
| 3 | v03 | 4 | Bugs UI, CSV, UX tabla |
| 4 | v04 | 4 | Orquestador, región, establecimiento |
| 5 | v05 | 5 | SVG, tooltip, escáner |
| 6 | v06 | 3 | Auditoría agregación, Chile |
| 7 | v07 | 3 | Portabilidad cross-OS, deuda técnica |
| 8 | v08 | 5 | Bugs UX, warning pipeline |
| 9 | v09 | 5 | Deploy Pages, orquestador, documentación |
| 10 | v10 | 6 | CSS, exportación SVG/PNG, backlog |
| 11 | v11 | 5 | README, documentación conceptual |
| 12 | v12 | 5 | Compresión JSON, SLEP prospectivos |
| 13 | v13 | 9 | Auditoría pre-lanzamiento, correcciones |
| 14 | v14 | 5 | Gobernanza Ley 21.719, datos |
| 15 | v15 | 6 | Suite suitedoc, standalone offline |
| 16 | v16 | 5 | Refinamientos UI, suite |
| 17 | v17 | 6 | Estándares ele/ins, UI extendida |
| 18 | v18 | 4 | Bugs motor, deuda técnica |
| 19 | v19 | 5 | Refinamientos visuales |
| 20 | v20 | 6 | Reconstrucción backlog, auditoría suite |
| 21 | v21 | 5 | Gobernanza avanzada, MRUN |
| 22 | v22 | 3 | Auditoría Ley 21.719 |
| 23 | v23 | 4 | Estado por defecto motor, suite no-op |
| 24 | v24 | 4 | Backlog, reseña, documentar.R, tags |
| **Total** | | **120** | |

### Detalle cronológico

*(Las entradas 1–120 con sus tags normalizados viven en `50_documentacion/activa/backlog_historico.md`. El detalle no se reproduce aquí para evitar duplicación; el backlog es la fuente única de verdad del conteo.)*

**Delta del backlog s24:** 4 entradas nuevas (121–124 en la próxima sesión que las registre); la normalización D20-3 no genera entradas nuevas (es corrección cosmética). Total acumulado: **120**.

---

## 5. Bugs de la sesión

Ninguno.

---

## 6. Aprendizajes y restricciones

**A-s24-1 (corrección de conteo):** el traspaso v23 decía "8 marcas REVISAR (voz)"; el archivo real tenía 7 (la L23 es la nota explicativa, no una zona de prosa). Regla: siempre contar contra el archivo real (R3), no contra el traspaso heredado.

**A-s24-2 (DISCIPLINA_OPERATIVA v1 incorporada):** R5 deroga la "higiene de sesión" que empujaba al cierre proactivo. Claude solo señala degradación en una línea factual; nunca propone cerrar.

**A-s24-3 (política v5, no v6):** la cita "v6" en el traspaso v23 y en el mensaje de apertura era errónea. La política real en disco y en la knowledge base es v5. Corregido en este traspaso.

---

## 7. Decisiones de diseño

**D-s24-1 — Reseña como espejo de data.js (opción A)**  
`data.js` del portafolio es la fuente canónica de las reseñas finales; `resena_slep_simce_adecuado.md` es espejo verbatim. Las variantes A/B/C del borrador quedan descartadas.

**D-s24-2 — Marcas REVISAR (voz): retirar sin reescribir (opción A)**  
La prosa de comunidad en `documentar.R` ya cumplía registro y terminología. Las marcas eran recordatorio de revisión; se retiran sin tocar el contenido.

**D-s24-3 — Normalización de tags: canónico de 7 códigos (opción A)**  
Tags compuestos libres mapeados por intención primaria a los 7 canónicos. El mapeo completo está en el registro de cambio 4 de esta sesión.

---

## 8. Constantes y parámetros vigentes

| Constante | Valor | Archivo |
|---|---|---|
| Años cubiertos | 2014–2018, 2022–2025 | `31_leer_normalizar.R` |
| Año preliminar | 2025 | `33_generar_html.R` |
| Umbral mínimo alumnos | 10 | `33_generar_html.R` |
| Estado por defecto | 4 comunas Costa Central · depe2="5" | `33_motor_template.html` |
| Lucide-static | 1.21.0 | `documentar.R` |

---

## 9. Arquitectura de archivos

Escáner al cierre: `2026-06-29 06:30:24` (adjunto). Sin cambios estructurales en s24 (solo archivos modificados/nuevos dentro de `50_documentacion/`).

Untracked por diseño: `50_documentacion/activa/SETTINGS_Y_PROMPTS_OPERACIONALES.md` (local, no versionado).

---

## 10. Pendientes y ruta sugerida

No hay pendientes activos. El proyecto está estable y desplegado.

Candidatos a sesión futura si surge necesidad:
- Regenerar suite si cambia contenido de `documentar.R` (requiere `npm` + red).
- Actualización anual de insumos Simce (cuando la Agencia publique 2025 final o 2026).
- Incorporar entradas 121–124 del backlog en la próxima sesión que registre cambios.

---

## 11. Instrucciones específicas para la próxima sesión

- 🔒 `directorio_oficial_ee.csv`: no re-versionar con MRUN ni columnas de persona natural (D21-1).
- 🔒 Estado por defecto del motor = 4 comunas Costa Central · Servicio Local; el reset restaura ese estado (D23-1).
- 🔒 Color por nivel, % Adecuado y corte de traspaso intocables.
- ✅ ANTES de regenerar la suite, verificar `npm --version` (requiere npm + red para lucide-static 1.21.0).
- ✅ `verificar = FALSE` y `standalone = TRUE` permanentes en `documentar.R`.
- ✅ `docs/index.html` se actualiza por copia manual desde `40_salidas/motor_comparacion.html`; no editar directamente.
- ⚠️ Para afirmar qué está versionado usar `git ls-files`, no el escáner (A20).
- ⚠️ `SETTINGS_Y_PROMPTS_OPERACIONALES.md` se mantiene local (untracked) por diseño.
- ⚠️ La política vigente es v5 (no v6); DISCIPLINA_OPERATIVA v1 es el tercer documento de protocolo.

---

## 12. Fragmentos de código de referencia

```r
# Ejecución canónica del pipeline:
source("00_build.R")

# Deploy a Pages (manual, el pipeline no toca docs/):
# copiar 40_salidas/motor_comparacion.html a docs/index.html y git push.

# Regenerar suite standalone (requiere npm + red):
suitedoc::generar_suite(
  cfg,
  salida_dir  = here::here("50_documentacion", "suite"),
  copiar_tema = TRUE,
  verificar   = FALSE,
  standalone  = TRUE,
  verbose     = TRUE
)
```

---

## 13. Reapertura

**Nombre del chat:** `slep_simce_adecuado, sesión 25 (Claude Sonnet 4.6)`

**Mensaje de apertura:**
> Continuación de `slep_simce_adecuado`. Tipo: CONTINUATION. El protocolo (POLÍTICA v5 + SETTINGS v4 + DISCIPLINA_OPERATIVA v1) vive en la knowledge base; léelo desde ahí. Adjunto el traspaso v24 y el escáner actual.

**Documentos para la próxima sesión:**

*En knowledge base (no adjuntar):*
- `POLITICA_PROYECTO.md` (v5)
- `SETTINGS_Y_PROMPTS_OPERACIONALES.md` (v4)
- `DISCIPLINA_OPERATIVA.md` (v1)

*Adjuntar:*
- `traspaso_cierre_v24.md`
- `estructura_actual.md` (escáner al abrir)
