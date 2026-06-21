# Log de cierre — Cotejo de marcas REVISAR (decisión) en la suite documental

- **Fecha:** 2026-06-20
- **Proyecto:** slep_simce_adecuado
- **Encargo:** Corrección de las 3 marcas `# REVISAR (decisión)` en
  `50_documentacion/suite/documentar.R`, regeneración de la suite y commit
  atómico. Modo autónomo, secuencial.
- **Modelo:** Claude Opus 4.8

---

## 1. Resumen

Se retiraron las 3 marcas `# REVISAR (decisión)` de los bloques de
configuración de `documentar.R`, según el cotejo previo ya cerrado por el
asistente:

- **Bloque de color** (decisión metodológica): además de retirar la marca, se
  **corrigió una imprecisión real** — se eliminó la atribución del color "al
  periodo" (que la fuente de decisión s15 no contempla) y se añadió el mecanismo
  de identidad del territorio por **nombre, swatch y borde de ficha** que la
  fuente sí especifica.
- **Item A2 del diccionario** y **glosario de marca**: las dos eran fieles al
  backlog #57 / a la fuente, de modo que solo se retiró el comentario de cola,
  sin tocar el texto.

La suite se regeneró sin error (4 HTML) y se publicó en `origin/main` en un
único commit atómico. Las marcas `# REVISAR (voz)` (6) y las 2 líneas de
cabecera que explican la convención quedaron intactas.

---

## 2. Inventario de commits

| Hash | Mensaje | Archivos |
|------|---------|----------|
| `e14048f` | `docs(suite): precisa color por estándar y cierra cotejo de marcas REVISAR (decisión)` | `documentar.R`, `documentacion_proyecto_slep_simce_adecuado.html` |

Pusheado: `8214f39..e14048f  main -> main`.

> **Nota de honestidad (lo que costó / desvío del criterio literal):** el
> encargo anticipaba "exactamente 6 rutas en stage". En la práctica solo
> **2 archivos** cambiaron: `documentar.R` y `documentacion_proyecto_…html`.
> El bloque de decisiones (donde vive el texto de color) se renderiza **solo**
> en ese HTML; los otros 3 HTML y `suite_estilos.css` se regeneraron
> **byte-idénticos**, por lo que `git add` fue no-op para ellos. El resultado
> es correcto: un commit surgical que toca exactamente lo que cambió. No se
> forzó el versionado de archivos sin diff.

---

## 3. Cambios por bloque (con causa)

### Cambio 1 — Bloque "Color fijo por estándar" (`decisiones`, ≈L195-197)
- **Qué:** reemplazo completo del `list()`. Se retiró la marca y el
  `cuerpo`/`por_que` se reescribieron.
- **Causa:** imprecisión real detectada en el cotejo. El texto previo atribuía
  la modulación "al territorio ni al periodo"; la fuente de decisión (s15) no
  contempla el "periodo" como dimensión de la decisión de color. El texto nuevo:
  (a) afirma color fijo por estándar idéntico para todas las entidades;
  (b) ancla la identidad del territorio en nombre/swatch/borde de ficha
  (mecanismo que la fuente sí especifica); (c) mantiene que el corte de traspaso
  modula opacidad/estilo de trazo, nunca el color.

### Cambio 2 — Item A2 del diccionario de anomalías (≈L131)
- **Qué:** se eliminó **solo** el comentario de cola
  `# REVISAR (decisión): el matiz "opción a" … confirmar.`
- **Causa:** el texto del item es fiel al backlog #57; el cotejo concluyó que la
  marca no correspondía a una imprecisión, solo a una duda ya resuelta. Texto
  intacto.

### Cambio 3 — Glosario de marca (`anomalias`, item A2 corto, ≈L207)
- **Qué:** se eliminó **solo** el comentario de cola
  `# REVISAR (decisión): confirmar el detalle del manejo de marca …`
- **Causa:** ídem — texto fiel a la fuente; solo se retira la marca. Texto
  intacto.

---

## 4. Verificación de invariantes (🔒)

| # | Invariante | Resultado | Evidencia |
|---|-----------|-----------|-----------|
| 1 | NO tocar las 6 marcas `# REVISAR (voz)` | **PASA** | `grep "REVISAR (voz)"` → 7 coincidencias: cabecera L23 + 6 reales (L259, L287, L298, L308, L320, L328), sin cambios. |
| 2 | NO tocar las 2 cabeceras explicativas (L23, L25) | **PASA** | L23 (cabecera voz) y L25 (cabecera decisión) intactas; la única coincidencia residual de `REVISAR (decisión)` es la cabecera L25. |
| 3 | `verificar = FALSE` intocado en `generar_suite` | **PASA** | `documentar.R:413  verificar = FALSE,` dentro de `suitedoc::generar_suite()`. No se editó. |
| 4 | Versionado: solo `documentar.R` + HTML + CSS; `fonts/` y `assets/` ignorados | **PASA** | `git status` tras `add`: solo `documentar.R` + `documentacion_proyecto_…html` staged. `git check-ignore` confirma `fonts/` y `assets/` ignorados; no aparecen en stage. |
| 5 | No tocar pipeline, motor ni constantes | **PASA** | Byte-sanidad: `git show --name-only HEAD \| grep -E "30_\|31_\|32_\|33_\|motor_template"` → vacío. El commit solo toca `50_documentacion/suite/`. |

### Criterios de éxito verificables
- `grep "REVISAR (decisión)"` deja **solo la cabecera** (1 coincidencia, L25). ✔
- `grep "REVISAR (voz)"` sigue mostrando las **6 marcas** + cabecera. ✔
- Regeneración produce los **4 HTML sin error** (exit 0). ✔
- `git add`: sin `fonts/` ni `assets/` en stage. ✔ (2 rutas con diff real, no 6 — ver nota §2)
- Push aceptado por `origin/main`. ✔

### Auto-auditoría del render
- `grep "REVISAR" *.html` → vacío (ninguna marca visible en los HTML). ✔
- Bloque de color en `documentacion_proyecto_…html` muestra el texto nuevo
  ("idéntico para todas las entidades", "nombre, swatch y borde de ficha"). ✔
- `grep "al periodo" *.html` → vacío (sin residuo del texto anterior). ✔

---

## 5. Contingencias resueltas (1 línea c/u)
- **Warning de encoding** al regenerar (`strings not representable in native
  encoding will be translated to UTF-8`): benigno, propio del locale; los HTML
  se escriben en UTF-8 correctamente. Sin acción.
- **Solo 1 de 4 HTML con diff:** esperado por la ubicación del bloque editado
  (ver nota §2). Sin acción.

---

## 6. Pendientes
- Ninguno derivado de este encargo. Las marcas `# REVISAR (voz)` (6) siguen
  abiertas por diseño: prosa de comunidad pendiente de tono, fuera de alcance.
- Working tree con churn de snapshots de estructura (`20260619_213924` borrado,
  `20260620_224630` nuevo, `estructura_actual` modificado) y 3 scripts scratch
  (`verificar_depe4.R`, `verificar_elem_insuf.R`,
  `verificar_elem_insuf_2023_2024.R`) **preexistentes, ajenos a este encargo**;
  no se tocaron ni versionaron.

---

## 7. Notas para el revisor
- Este log se deja **sin commitear** para revisión previa, según el encargo.
- El desvío del criterio "6 rutas en stage" → "2 rutas" es esperado y correcto
  (commit surgical; sin forzar archivos sin diff). Si la política exige que las
  4 vistas y el CSS se re-commiteen aunque no cambien, avísese y se fuerza con
  `git add` + commit vacío de contenido (no recomendado).
- El commit `e14048f` ya está en `origin/main`; revertirlo requeriría
  `git revert` (no force-push).
