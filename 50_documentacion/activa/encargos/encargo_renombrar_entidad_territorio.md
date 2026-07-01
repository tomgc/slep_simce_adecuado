# Encargo autónomo — Renombrar "entidad" → "territorio" en texto UI

**Proyecto:** slep_simce_adecuado
**Tipo:** encargo autónomo dirigido por meta (patrón v1)
**Modo:** autónomo, secuencial, ejecuta todo en este turno.
**Regla de detención:** PARAR y reportar solo si (a) una ocurrencia de "entidad"
no está en el inventario de la sección 3 y no es evidente si es texto o
identificador, (b) el archivo real difiere del inventariado (líneas movidas,
contenido distinto), (c) tocar una ocurrencia rompería una referencia de
código (ver invariante 🔒-2).

## 1. Contexto mínimo suficiente

Archivo único a modificar:
`/Users/tomgc/Projects/slep_simce_adecuado/30_procesamiento/33_motor_template.html`

Este es el **template fuente** desde el cual `33_generar_html.R` produce
`40_salidas/motor_comparacion.html`, que luego se copia manualmente a
`docs/index.html` (NO tocar `docs/index.html` ni `40_salidas/` en este
encargo; se regeneran después vía pipeline).

Cambio: renombrar el concepto de UI "entidad" a "territorio" en todo el texto
visible al usuario, comentarios de código y el header de la columna CSV
exportada. Los identificadores de código (nombres de función, variable,
constante) NO cambian — quedan en español con raíz "entidad" por diseño,
según decisión explícita del usuario.

## 2. Invariantes 🔒

- 🔒-1: NO modificar `entities`, `setEntities`, `entity` (prop/parámetro JSX),
  `entity.rbds`, ni ningún otro identificador del estado React. Son la fuente
  de verdad del componente; renombrarlos es fuera de alcance.
- 🔒-2: NO modificar los siguientes identificadores de código, aunque
  contengan "entidad": `entidadDependeSlep` (función), `entidadesPorDefecto`
  (función), `MAX_ENTIDADES` (constante). Sí se pueden modificar los
  comentarios que los rodean o mencionan, pero nunca el nombre del símbolo
  ni sus invocaciones.
- 🔒-3: NO tocar `docs/index.html` ni `40_salidas/motor_comparacion.html`.
  Este encargo es solo sobre el template fuente.
- 🔒-4: NO tocar `40_salidas/intermedios/*.parquet` ni ningún pipeline de R.
- 🔒-5: Preservar mayúscula/minúscula según contexto ("Entidad" → "Territorio"
  en títulos/labels; "entidad" → "territorio" en prosa/comentarios/CSV header).
- 🔒-6: Preservar plurales y conjugaciones correctamente ("entidades" →
  "territorios", NO "territorias" ni "territorios" mal declinado en frases
  como "Máximo de comparación: 4 entidades" → "Máximo de comparación: 4
  territorios").

## 3. Inventario exhaustivo de ocurrencias (líneas verificadas sobre el
archivo subido; Claude Code debe re-verificar contra el archivo real en
disco antes de editar, por si difiere)

Total: 33 líneas con "entidad"/"Entidad"/"entidades"/"Entidades" en texto,
comentario o header CSV. Ninguna de estas líneas debe dejar rastro de
"entidad" salvo donde el propio identificador de código (🔒-2) aparezca
mencionado dentro de un comentario técnico que describe el símbolo mismo
(ver línea 1397, 3230, 3266, 3285 abajo: ahí "entidad" aparece SOLO como
parte del nombre del símbolo referenciado, no como prosa — no se toca el
nombre, pero el comentario circundante si tiene prosa en español sí se
renombra).

| Línea | Tipo | Acción |
|---|---|---|
| 472 | comentario CSS | "entidad" → "territorio" |
| 1005 | comentario CSS | "entidad" → "territorio" |
| 1371 | comentario JS | "entidades" → "territorios" |
| 1387 | comentario JS | "entidad" → "territorio" (NO tocar `entidadDependeSlep` si aparece) |
| 1390 | código | NO TOCAR — `function entidadDependeSlep(entity)` es identificador (🔒-2) |
| 1397 | código | NO TOCAR — lista de símbolos exportados/destructurados |
| 1447 | comentario JS | "entidades" → "territorios" |
| 1456 | comentario JS | "entidad" → "territorio" |
| 1457 | comentario JS | "entidad" → "territorio" (dos ocurrencias en la línea) |
| 1458 | comentario JS | "entidades" → "territorios", "entidad" → "territorio" |
| 1481 | texto UI (JSX, prosa "acerca de") | "entidades" → "territorios" (dentro de comillas tipográficas: `"entidades"` → `"territorios"`) |
| 1576 | código | NO TOCAR — `SimceData.entidadDependeSlep(entity)` es invocación del identificador (🔒-2) |
| 1599 | texto UI (JSX, `<h2>`) | "Entidades a comparar" → "Territorios a comparar" |
| 1600 | código | NO TOCAR — `className="entities-count"` es un identificador CSS/JS (verificar si es clase o prop antes de decidir; si es solo un className de CSS, evaluar si el proyecto quiere renombrar clases CSS — por defecto NO, ya que 🔒-1 cubre el estado, y clases CSS no son texto visible) |
| 1614 | código | NO TOCAR — comparación con `MAX_ENTIDADES` |
| 1617 | texto UI (JSX, botón) | "Agregar entidad" → "Agregar territorio" |
| 1622 | texto UI (JSX, title/aria-label) | "Restablecer entidades iniciales" → "Restablecer territorios iniciales" (dos atributos en la línea) |
| 1741 | comentario JS | "entidad" → "territorio" |
| 2019 | comentario JS | "entidad" → "territorio" |
| 2185 | texto UI (JSX, `<th>`) | "Entidad" → "Territorio" (NO tocar `className="th-ent"`) |
| 2266 | texto UI (JSX, prosa ayuda) | "entidad" → "territorio" |
| 2329 | texto UI (CSV export header) | `"entidad"` → `"territorio"` dentro del array de headers |
| 2372 | comentario JS | "entidad" → "territorio" |
| 2374 | comentario JS | "entidad" → "territorio" |
| 2424 | comentario JS | "entidad" → "territorio" |
| 2486 | comentario JS | "entidad" → "territorio" |
| 2622 | comentario JS | "entidad" → "territorio" |
| 2625 | comentario JS | "entidad" → "territorio" (NO tocar la palabra `entity` que refiere al parámetro) |
| 2692 | comentario JS | "entidades" → "territorios" |
| 2748 | comentario JS | "Modal agregar entidad" → "Modal agregar territorio" |
| 2752 | comentario JS | "entidades" → "territorios" |
| 2926 | texto UI (JSX, título modal) | "Editar entidad" → "Editar territorio"; "Agregar entidad" → "Agregar territorio" |
| 3117 | texto UI (JSX, field-label) | "Entidad" → "Territorio" |
| 3119 | texto UI (JSX, prosa) | "entidad de referencia nacional" → "territorio de referencia nacional" |
| 3228 | comentario JS | "ver entidadesPorDefecto()" — NO TOCAR el nombre de función; si hay prosa adicional en la línea, renombrar solo la prosa |
| 3230 | código | NO TOCAR — `entidadesPorDefecto()` es invocación del identificador (🔒-2) |
| 3239 | texto UI (JSX, alert) + código | El string `"Máximo de comparación: 4 entidades. Elimina una antes de agregar otra."` → `"Máximo de comparación: 4 territorios. Elimina una antes de agregar otra."`. NO TOCAR `MAX_ENTIDADES` |
| 3246 | comentario JS | "entidad" → "territorio" |
| 3264 | comentario JS | "entidades" → "territorios"; NO TOCAR `MAX_ENTIDADES` si aparece |
| 3266 | código | NO TOCAR — `function entidadesPorDefecto()` (🔒-2) |
| 3271 | código | NO TOCAR — invocación `MAX_ENTIDADES` |
| 3285 | código | NO TOCAR — invocación `entidadesPorDefecto()` |
| 3374 | texto UI (JSX, `<h2>`) | "Entidad × GSE × Año" → "Territorio × GSE × Año" |
| 3415 | texto UI (JSX, prosa fórmula) | "Para cada entidad, GSE y año" → "Para cada territorio, GSE y año" |
| 3475 | código | NO TOCAR — prop `slotsLibres={MAX_ENTIDADES - entities.length}` |

**Nota sobre L1600 (`entities-count`):** es un `className`. Por defecto NO se
renombra (es un selector CSS interno, no texto visible ni identificador de
estado de datos). Si al revisar el archivo real se confirma que es solo una
clase de estilo sin otras implicancias, dejarla intacta. Si genera duda,
tratarla como caso de detención (b) y reportar antes de decidir.

## 4. Fases

**Fase única** (cambio de bajo riesgo, sin dependencia de datos):

1. **Paso 0 — leer estado real.** `grep -n "[Ee]ntidad" 33_motor_template.html`
   sobre el archivo real en disco. Comparar contra el inventario de la
   sección 3. Si hay líneas nuevas o líneas movidas respecto al inventario,
   detenerse y reportar antes de editar.
2. **Implementación.** Aplicar cada reemplazo de la tabla, uno por uno,
   respetando mayúscula/minúscula y declinación (🔒-5, 🔒-6). No usar un
   único `sed` global de "entidad"→"territorio" sin revisión — el inventario
   ya distingue qué SÍ y qué NO se toca; un reemplazo ciego violaría 🔒-1/🔒-2.
3. **Verificación.** Repetir `grep -n "[Ee]ntidad" 33_motor_template.html`
   tras la edición: las únicas ocurrencias remanentes deben ser las marcadas
   "NO TOCAR" en la tabla (identificadores de código: `entidadDependeSlep`,
   `entidadesPorDefecto`, `MAX_ENTIDADES`, y comentarios que los nombran).
   Contar y listar esas ocurrencias remanentes en el log.
4. **Commit atómico.**
   `git -C /Users/tomgc/Projects/slep_simce_adecuado add 30_procesamiento/33_motor_template.html`
   Mensaje: `style(motor): renombrar "entidad" a "territorio" en texto UI y comentarios`

**NO ejecutar el pipeline** (`00_build.R`) en este encargo — la regeneración
de `40_salidas/` y la copia a `docs/` quedan para un paso posterior separado,
con gate visual del usuario (regla canónica: no push/deploy sin gate visual).

## 5. Criterios de éxito verificables

- `grep -c "[Ee]ntidad" 33_motor_template.html` tras el cambio: el conteo debe
  coincidir exactamente con el número de ocurrencias "NO TOCAR" listadas en
  la sección 3 (identificadores + comentarios que los nombran). Reportar el
  número exacto encontrado.
- `grep -c "[Tt]erritorio" 33_motor_template.html`: debe ser ≥ 33 (una por
  cada línea de texto/comentario/CSV-header convertida; algunas líneas tienen
  2 ocurrencias).
- Ningún cambio en `entities`, `setEntities`, `entity`, `entidadDependeSlep`,
  `entidadesPorDefecto`, `MAX_ENTIDADES` como identificadores (verificar con
  `grep -n` de cada uno, contar ocurrencias antes/después — deben ser iguales).
- El archivo sigue siendo JS/JSX válido (verificación de balance de llaves o,
  si hay entorno de build disponible, un lint rápido; si no hay forma de
  verificar sintaxis sin ejecutar el pipeline completo, reportar como
  "sintaxis no verificada por herramienta, solo por inspección visual").

## 6. Mandato de auto-auditoría

No hay riesgo de datos ni invariantes de gobernanza en este encargo (es texto
de UI). Basta el principio general: releer el diff completo línea por línea
contra la tabla de la sección 3 antes de comitear, confirmando que cada
"NO TOCAR" sigue intacto y cada reemplazo programado se aplicó.

## 7. Mandato del log

Generar log en
`50_documentacion/andamios/logs/20260701_renombrar_entidad_territorio_log.md`
con la plantilla fija (sección 4 del patrón v1). Incluir explícitamente:
- Tabla final de ocurrencias remanentes de "entidad" (deben ser solo las
  "NO TOCAR").
- Confirmación de que `MAX_ENTIDADES`, `entidadDependeSlep`,
  `entidadesPorDefecto`, `entities`/`entity` no cambiaron (diff nulo en esos
  símbolos).
- Cualquier línea del inventario que no coincidiera con el archivo real.

## 8. Reporte final

Al terminar: confirmar commit hash, adjuntar el conteo de verificación de la
sección 5, y señalar explícitamente el caso L1600 (`entities-count`) y cómo
se resolvió.

---

**Recomendación:** ejecutar tal cual este encargo — el inventario ya resolvió
la ambigüedad línea por línea, así que no debería requerir preguntas
adicionales salvo discrepancia con el archivo real.
