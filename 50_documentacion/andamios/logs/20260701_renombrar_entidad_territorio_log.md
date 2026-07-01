# Log — Renombrar "entidad" → "territorio" en texto UI y comentarios

**Fecha:** 2026-07-01
**Proyecto:** slep_simce_adecuado
**Encargo:** `50_documentacion/activa/encargos/encargo_renombrar_entidad_territorio.md`
**Archivo modificado:** `30_procesamiento/33_motor_template.html`
**Commit:** `0c70db0` — *style(motor): renombrar "entidad" a "territorio" en texto UI y comentarios*

---

## Fase 0 — Auditoría previa

`grep -n "[Ee]ntidad" 33_motor_template.html` arrojó las siguientes líneas. Todas
fueron clasificadas contra el inventario de la sección 3 del encargo antes de editar.

**Discrepancia detectada con el inventario:** la línea 3264 del inventario
(`"entidades" → "territorios"; NO TOCAR MAX_ENTIDADES`) no tiene el texto
esperado en el archivo real en disco. El contenido real de la L3264 es:
`// se localiza por coincidencia normalizada. Respeta el tope MAX_ENTIDADES.`
No contiene "entidades" como palabra independiente (solo `MAX_ENTIDADES` en
mayúsculas, que no matchea `[Ee]ntidad`). La discrepancia se debe a que el
inventario fue redactado sobre una versión anterior del comentario de
`entidadesPorDefecto()`. Acción: omitida correctamente; nada que cambiar.

---

## Implementación — 33 cambios aplicados

| # | Línea real | Tipo | Cambio aplicado |
|---|---|---|---|
| 1 | 472 | comentario CSS | "entidad (1px)" → "territorio (1px)" |
| 2 | 1005 | comentario CSS | "entidad chip" → "territorio chip" |
| 3 | 1371 | comentario JS | "entidades kind=\"slep\" YA traspasadas" → "territorios kind=\"slep\" YA traspasados" |
| 4 | 1387 | comentario JS | "Una entidad depende" → "Un territorio depende" |
| 5 | 1447 | comentario JS | "Paleta de entidades" → "Paleta de territorios" |
| 6 | 1456 | comentario JS | "color de la entidad" → "color del territorio" |
| 7 | 1457 | comentario JS | "no por entidad)" → "no por territorio)" |
| 8 | 1458 | comentario JS | "todas las entidades" → "todos los territorios"; "cada entidad" → "cada territorio" — "La identidad" preservada intacta (falso positivo del grep) |
| 9 | 1481 | texto UI (JSX) | `"entidades"` → `"territorios"` + concordancia: "diversas" → "diversos", "las cuales" → "los cuales" |
| 10 | 1599 | texto UI (`<h2>`) | "Entidades a comparar" → "Territorios a comparar" |
| 11 | 1617 | texto UI (botón) | "Agregar entidad" → "Agregar territorio" |
| 12 | 1622 | texto UI (title + aria-label) | "Restablecer entidades iniciales" → "Restablecer territorios iniciales" (2 atributos) |
| 13 | 1741 | comentario JS | "otra entidad/punto" → "otro territorio/punto" |
| 14 | 2019 | comentario JS | "no por entidad," → "no por territorio," |
| 15 | 2185 | texto UI (`<th>`) | "Entidad" → "Territorio" — `className="th-ent"` intacto |
| 16 | 2266 | texto UI (JSX) | "la entidad" → "el territorio" |
| 17 | 2329 | CSV export header | `"entidad"` → `"territorio"` |
| 18 | 2372 | comentario JS | "celda de entidad" → "celda de territorio" |
| 19 | 2374 | comentario JS | "encabezados de entidad" → "encabezados de territorio" |
| 20 | 2424 | comentario JS | "Encabezados de entidad" → "Encabezados de territorio" |
| 21 | 2486 | comentario JS | "Celdas de entidad" → "Celdas de territorio" |
| 22 | 2622 | comentario JS | "una entidad" → "un territorio" |
| 23 | 2625 | comentario JS | "entidad (kind, comunas…)" → "territorio (kind, comunas…)" — `entity` (parámetro) intacto |
| 24 | 2692 | comentario JS | "entidades se mantiene" → "territorios se mantiene" |
| 25 | 2748 | comentario JS | "Modal agregar entidad" → "Modal agregar territorio" |
| 26 | 2752 | comentario JS | "en entidades SLEP" → "en territorios SLEP" |
| 27 | 2926 | texto UI (`<h3>`) | "Editar entidad" → "Editar territorio"; "Agregar entidad" → "Agregar territorio" |
| 28 | 3117 | texto UI (field-label) | "Entidad" → "Territorio" |
| 29 | 3119 | texto UI (JSX) | "entidad de referencia nacional" → "territorio de referencia nacional" |
| 30 | 3239 | texto UI (alert) | "4 entidades. Elimina una" → "4 territorios. Elimina uno" |
| 31 | 3246 | comentario JS | "cada nueva entidad" → "cada nuevo territorio" |
| 32 | 3374 | texto UI (`<h2>`) | "Entidad × GSE × Año" → "Territorio × GSE × Año" |
| 33 | 3415 | texto UI (JSX) | "Para cada entidad," → "Para cada territorio," |

**Línea 3228** (`// comunas del SLEP Costa Central (ver entidadesPorDefecto()).`):
no tiene prosa en español con "entidad" como palabra independiente; solo el nombre
de función `entidadesPorDefecto`. No se modificó (correcto per encargo §3).

---

## Verificación post-edición

### Ocurrencias remanentes de `[Ee]ntidad` (8 — todas "NO TOCAR")

| Línea | Contenido | Razón |
|---|---|---|
| 1390 | `function entidadDependeSlep(entity)` | identificador 🔒-2 |
| 1397 | `entidadDependeSlep` en lista de exports | identificador 🔒-2 |
| 1458 | `La identidad de cada territorio` | falso positivo: "id**entidad**" en "identidad" — palabra correctamente preservada |
| 1576 | `SimceData.entidadDependeSlep(entity)` | invocación de identificador 🔒-2 |
| 3228 | `(ver entidadesPorDefecto())` | nombre de función 🔒-2 en comentario |
| 3230 | `entidadesPorDefecto()` en useEffect | invocación de identificador 🔒-2 |
| 3266 | `function entidadesPorDefecto()` | definición de identificador 🔒-2 |
| 3285 | `setEntities(entidadesPorDefecto())` | invocación de identificador 🔒-2 |

### Conteos de criterio de éxito

| Métrica | Valor | Criterio | Estado |
|---|---|---|---|
| `[Ee]ntidad` remanentes | 8 | solo "NO TOCAR" | ✅ |
| `[Tt]erritorio` apariciones | 33 | ≥ 33 | ✅ |

### Identificadores protegidos — diff nulo confirmado

| Identificador | Pre-edición | Post-edición | Estado |
|---|---|---|---|
| `entities` / `setEntities` / `entity` | 163 | 163 | ✅ sin cambio |
| `entidadDependeSlep` | 3 | 3 | ✅ sin cambio |
| `entidadesPorDefecto` | 4 | 4 | ✅ sin cambio |
| `MAX_ENTIDADES` | 8 | 8 | ✅ sin cambio |

### Caso L1600 (`entities-count`)

La clase CSS `className="entities-count"` **no fue modificada**. Es un selector
CSS interno (no texto visible al usuario) y no es un identificador de estado de
datos. Confirmado: la clase no contiene "entidad" y tampoco fue afectada por
ninguno de los 33 reemplazos.

### Sintaxis JS/JSX

No verificada con herramienta de lint (no hay bundler ni eslint disponible sin
ejecutar el pipeline). Verificación por inspección: todos los cambios son
sustituciones de strings de texto y comentarios; ninguno altera la estructura
de paréntesis, llaves o JSX. La verificación funcional (abrir el HTML compilado
y confirmar que el motor carga sin errores) queda para la regeneración posterior
con gate visual del usuario.

---

## Versionado

- **Archivo commiteado:** `30_procesamiento/33_motor_template.html`
- **Commit hash:** `0c70db0`
- **Mensaje:** `style(motor): renombrar "entidad" a "territorio" en texto UI y comentarios`
- **Diff:** 1 file changed, 33 insertions(+), 33 deletions(-)
- **Pipeline NO ejecutado** (per encargo §4): regeneración de `40_salidas/` y
  copia a `docs/` quedan para paso posterior con gate visual del usuario.
- **Push:** NO realizado.
