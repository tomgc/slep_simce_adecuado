# Traspaso de cierre v29 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado` — motor de comparación interactivo de resultados Simce por estándares de aprendizaje.
- **Versión del traspaso:** v29.
- **Fecha:** 2026-08-29.
- **Sesión:** 29. Foco: construir el panorama territorial especificado en v28, alinear su encabezado al patrón del motor IDPS y agotar la deuda que la propia construcción fue destapando.
- **Entorno:** macOS aarch64, R 4.5.x con `renv` desincronizado (intencional), Positron. `main` al cierre en `3b17b9b`.
- **Archivos principales modificados:** `30_procesamiento/33_motor_template.html`, `docs/index.html`, `50_documentacion/activa/50_diseno_ramas_deteccion.md`, `50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md`, `50_documentacion/activa/ESTADO.md`.

## 2. Resumen ejecutivo

La sesión abrió corrigiendo `commit_cierre`, que apuntaba dos commits atrás, y siguió con lo que v28 dejó especificado y sin construir: el panorama territorial, una segunda vista que combina los cinco grupos socioeconómicos en una sola distribución de los tres niveles de logro, con las dos pruebas del nivel activo lado a lado. Se construyó completo (capa de datos, dibujo, tres exportaciones, estado vacío) y después se le rehízo el encabezado dos veces hasta calzar con los valores literales del motor IDPS, que es la versión más pulida de la cartera. En el camino se agotaron cinco deudas triviales heredadas de v28, se resolvió la decisión `D-color-nivel` y se midieron cuatro dudas abiertas con encargos de solo lectura. Dos de esas mediciones cambiaron el trabajo: el 11,9% de los puntos comunales tenía una franja sin rótulo, y era casi siempre Adecuado (el número más grave de la serie), lo que obligó a rescatar la cifra bajo el eje; y el motor publicado resultó no ser autocontenido, porque carga React, ReactDOM y Babel desde `unpkg.com`. Lo segundo no se tocó: se auditó el precedente de `slep_categoria_desempeno`, que ya lo resolvió, y quedó documentado con riesgo MEDIO para una sesión propia. Se publicaron cuatro despliegues y quince commits. El motor publicado está al día y verificado por md5. La deuda viva es la dependencia de CDN, el desborde del panorama bajo 540px de viewport y tres rutas de exportación cuyo contenido está probado pero cuya descarga nadie ha ejercido.

## 3. Estado al cierre

**Qué funciona.**

- Pipeline completo, cuatro corridas limpias de `33_generar_html.R` en esta sesión, la última con exit 0 y md5 `c9747962e7f9cc8179de3a717f66f9af`.
- Panorama territorial en producción: siete tipos de territorio, GSE combinado ponderado por evaluados, dos pruebas lado a lado, estado vacío explícito, rescate de rótulos bajo el eje, tres exportaciones (CSV, SVG, PNG).
- Vista de comparación intacta: ningún `diff` de build de esta sesión tocó su código ni su CSS.
- `docs/index.html` byte a byte igual al build: md5 `c9747962e7f9cc8179de3a717f66f9af` en ambos.

**Qué no funciona.**

- El motor no abre sin red: tres `<script src>` a `unpkg.com` (React 18.3.1, ReactDOM 18.3.1, Babel standalone 7.29.0, con SRI). Síntoma observable: pantalla en blanco si el CDN no responde; y bajo origen `file://` en navegadores estrictos, el error "Unsafe attempt to load URL".
- El panorama desborda bajo ~540px de viewport: el piso de 460px de `grid-template-columns` no cede.

**Delta respecto de v28.** v28 entregó la especificación medida del panorama y no construyó nada. v29 lo construyó, lo publicó, y sumó el encabezado tipo IDPS, el rescate de rótulos, la corrección de la selección única y la eliminación de mayúsculas sostenidas. El backlog pasa de 157 a 174 entradas.

## 4. Registro detallado de cambios

**4.1 `commit_cierre` desviado (apertura).** `ESTADO.md` llevaba `542088c` cuando el cierre real fue `5306df2`. Se corrigió junto con `sesion_abierta`. Verificación: `merge-base --is-ancestor`. Commit `6de714a`.

**4.2 Panorama territorial.** `33_motor_template.html`. Categoría: funcionalidad. Se agregó `indicesPN()` (índice por nivel×prueba sin filtro de GSE) y `generateSeriesGseCombinado()`, que acumula en crudo y llama a `mkPunto` una sola vez por año: sumar puntos ya redondeados por GSE arrastraría hasta 4 estudiantes de desvío. Filtro de supresión propio (`filaSuprimida`), porque una fila con los tres porcentajes en 0 no es un territorio con 0% Adecuado sino una celda suprimida, y en una vista que reparte 100 entre tres niveles sí distorsiona. Dibujo en `dibujarPanoramaEnGrupo()`, una sola función que sirve a la pantalla y al SVG exportado para que no puedan divergir. Verificación: réplica en Node con payload sintético (los tres niveles suman 100, N derivado en precisión completa, fila suprimida excluida del denominador) y render en jsdom rasterizado. Commit `b93e9eb`.

**4.3 Encabezado tipo IDPS.** Pestañas blancas pegajosas con subrayado coral, regla coral al pie de `.app-header`, banner oscuro de identidad del territorio con el selector de nivel adentro, y picker de territorio tipo select. Segunda iteración con los valores literales de `35_motor_template.html` del motor IDPS (padding, tamaños, opacidades, `flex` del trigger). Consecuencia con costo: `.controls-bar` deja de ser pegajosa, porque dos elementos en `top: 0` se solapan. Commit `b93e9eb`.

**4.4 Deuda trivial de v28.** `const sembradas` eliminada e interpolada en su `warn` (`cab5b47`); `text-transform` retirado de `.badge-traspaso` y de `.hero-card-control-label`, con el texto escrito en su caja tipográfica (`b56f75e`); `D-color-nivel` declarado como `**ID:**` en su archivo de decisión y el tope corregido de 4 a 5 con el valor medido del código (`4f68d4b`); A-s28-6 incorporado a `50_diseno_ramas_deteccion.md` como `## 5`, con regla 9 y línea de comprobación (`2e75100`). La reubicación de encargos fuera de `activa/encargos/` resultó ya cumplida por `90bd736`.

**4.5 Verificación de cuatro dudas abiertas.** Encargo de solo lectura. Pages sirve byte a byte el build desplegado (`cmp` → idénticos). El panorama esconde el porcentaje de las franjas bajo 7,0093 puntos: 11,9% de los puntos comunales y 14,6% de los de SLEP tienen al menos una, y en 1.529 de 1.614 la franja muda es Adecuado. `construirSvgGraficos` fija `xmlns` a mano y además serializa con `XMLSerializer`: el patrón del duplicado está en el código, su efecto real no es observable sin navegador. El motor carga tres scripts desde `unpkg.com`.

**4.6 Rescate de rótulos.** Cuando una franja no admite su cifra adentro, el valor va bajo el año con la inicial del nivel en su color, hasta dos renglones (tres franjas bajo el umbral no pueden sumar 100). `PANORAMA_DIMS.H` 300→328 y `M.bottom` 46→74 para alojarlos sin comprimir el área de dibujo. El valor usa `fmtPct`, con un decimal: `fmtPctShort` habría escrito `A 0%` para el 0,2% de SLEP Barrancas y anulado justo lo que se rescata. Verificación: sobre el SVG exportado por el titular, 11 franjas bajo el umbral y 11 rótulos rescatados, 43 rótulos dentro de barra = 54 − 11. Commits `3b256e6` y `abf98c6`.

**4.7 Auditoría del precedente C3.** Solo lectura sobre `slep_categoria_desempeno`. React y ReactDOM vendorizados en `10_utils/` e inyectados por placeholders; Babel desaparece porque el JSX se transpiló una sola vez con `npx babel --preset-react runtime classic` y el template versiona el resultado (196 `React.createElement`); cero dependencias de entorno en build y runtime; decisión en `20260618_decision_plan_c3_eliminar_babel.md`. Su motor publicado no carga nada por red.

**4.8 Dependencias de los memos del panorama.** El modal conserva `editing?.id` al cambiar de territorio, así que `meta` y `hayDato`, que dependían solo del id, se quedaban con los valores del territorio anterior. Se les dio la misma lista de dependencias que ya usaba `PanoramaChart`. Commit `04d9523`.

**4.9 Selección única, reorden y mayúsculas sostenidas.** `bloqueado = !checked && lista.length >= maxSel` dejaba todas las filas deshabilitadas al editar con cupo 1: la lista se pintaba como radio y se comportaba como casilla con tope. `toggleSel` pasa a reemplazar cuando el cupo es 1. El selector de territorio se movió sobre el banner: primero se elige, después aparece la ficha. `NIVEL`→`Nivel`, `TRASPASO`→`Traspaso`, y `aNombrePropio()` convierte los nombres de comuna que la fuente entrega en mayúsculas sostenidas. Commit `d4e3017`.

**4.10 Gobernanza de encargos.** Reglas 10 y 11 en `50_diseno_ramas_deteccion.md` y un `## 6` que registra dos reincidencias de la sesión 29. Commit `4e8f946`.

## 5. Backlog acumulativo

Ver `50_documentacion/activa/backlog_acumulativo.md`. Cierra en 174 entradas tras 17 nuevas en esta sesión.

## 6. Bugs de la sesión

**B29-1 — Regresión por copia de trabajo desactualizada.** Síntoma: la plantilla entregada revertía `cab5b47` y `b56f75e` (reponía `text-transform`, devolvía `traspaso` en minúsculas y restauraba `const sembradas`). Causa raíz: el asistente editaba una copia anterior a esos commits, hechos por Claude Code directamente en el repositorio. Solución: reaplicar los seis fragmentos y volver a entregar. Verificación: `text-transform` 0, `sembradas` 0, `TRASPASO {s` 1. **Patrón general:** cuando dos agentes escriben sobre el mismo archivo, la base de toda entrega debe cotejarse contra `HEAD` antes de commitear; nació de aquí el gate de cotejo de base. Estado: resuelto, y el gate quedó incorporado a los encargos siguientes.

**B29-2 — Selección única que bloquea en vez de reemplazar.** Síntoma: en el modal de territorio del panorama, ningún SLEP distinto de Costa Central podía elegirse. Causa raíz: `bloqueado = !checked && lista.length >= maxSel`, con `maxSel = 1` al editar. Solución: `toggleSel` con rama de reemplazo para cupo 1 y `maxSel > 1` en las dos constantes `bloqueado`. **Patrón general:** si un control se pinta como radio, debe comportarse como radio; el tope de selección no es un candado cuando el tope es 1. Estado: resuelto en `d4e3017`. Afectaba también a la vista de comparación desde antes de esta sesión.

**B29-3 — Rótulo mudo en franjas delgadas.** Síntoma: el porcentaje de una franja bajo 7,0093 puntos no aparecía en pantalla. Causa raíz: el rótulo se dibuja solo si la franja alcanza 15px de alto. Solución: rescate bajo el eje con la inicial del nivel. **Patrón general:** una limitación declarada al entregar no es una limitación medida; medirla cambió su categoría de menor a defecto. Estado: resuelto en `3b256e6`.

## 7. Aprendizajes y restricciones descubiertas

- **A29-1 — La base de una entrega se coteja contra `HEAD`, no se supone.** Contexto: si no se coteja, una copia vieja revierte commits publicados sin que nadie lo note. Ejemplo: B29-1, atrapado por la rama de atribución del `diff`.
- **A29-2 — Ninguna magnitud del proceso sirve de criterio.** Líneas de `diff`, líneas de `status`, número de commits son subproductos. Cuatro detenciones falsas en esta sesión por incumplir una regla que ya estaba escrita. Quedó como regla 10 de `50_diseno_ramas_deteccion.md`.
- **A29-3 — Un patrón sobre prosa se ancla en una palabra, no en una frase.** `grep` opera línea a línea y el texto con ajuste parte las frases. Ejemplo: `grep -n "entidades simultáneas"` devolvió 0 sobre una frase que sí existía, partida entre dos líneas. Regla 11.
- **A29-4 — El alcance del instrumento debe igualar el alcance de la afirmación.** Tres verificadores de esta sesión midieron el archivo completo cuando su afirmación era local a un bloque (el esperado-0 de `fmtPctShort(seg.val)`, el estado esperado de T4, los `??` de FASE 0). No es que el patrón estuviera mal escrito: el universo de búsqueda era más ancho que lo afirmado. **Candidata a regla 12; no se redactó en esta sesión.**
- **A29-5 — Combinar puntos ya redondeados arrastra el redondeo.** Toda agregación entre segmentos acumula numeradores crudos y redondea una sola vez al final.
- **A29-6 — Una limitación declarada no es una limitación medida.** El rótulo mudo pasó de "menor" a "defecto" en cuanto se contó: 11,9% de los puntos comunales, y casi siempre el nivel más grave.

## 8. Decisiones de diseño

- **D29-1 — El panorama combina los cinco GSE.** Alternativa descartada: segmentar por GSE como la vista de comparación. Justificación: responde otra pregunta (cómo se reparte un territorio, no cómo se compara). Tensión resuelta: la segmentación GSE sigue siendo inviolable en la vista de comparación; el panorama es otra vista, no una excepción a la norma.
- **D29-2 — Un solo código de dibujo para pantalla y exportación.** `dibujarPanoramaEnGrupo` recibe un `<g>`. Alternativa descartada: reimplementar el layout en el constructor del SVG, que es lo que hace el supergrid y por lo que puede divergir.
- **D29-3 — El panorama tiene selección propia, independiente del tablero de comparación.** Son dos preguntas distintas; compartir estado obligaría a vaciar una para usar la otra.
- **D29-4 — `docs/index.html` solo se despliega tras gate visual del titular.** Se cumplió en los cuatro despliegues.
- **D29-5 — La dependencia de `unpkg.com` no se toca en esta sesión.** Alternativa descartada: vendorizar aquí mismo. Justificación: cambia el flujo de edición (el JSX deja de existir en el template), toca el archivo más grande del proyecto e introduce un paso manual que falla en silencio sin `runtime: "classic"`. Riesgo MEDIO medido contra el precedente.
- **D29-6 — El identificador canónico del archivo de decisión de color es `D-color-nivel`, con el campo `**ID:**`.** `D15-1` permanece como referencia de origen: son dos espacios de nombres, no un conflicto.

## 9. Constantes y parámetros

| Constante | Antes | Después | Archivo | Motivo |
|---|---|---|---|---|
| `PANORAMA_DIMS.H` | 300 | 328 | `33_motor_template.html` | alojar dos renglones de rescate sin comprimir el dibujo |
| `PANORAMA_DIMS.M.bottom` | 46 | 74 | idem | idem |
| `ALTO_MIN_ROTULO` | literal `15` | constante nombrada | idem | el umbral debía ser derivable sin leer tres sitios |
| `FS_SVG.panorama` | no existía | 8 tamaños | idem | la escala del SVG vive entera en `FS_SVG` |
| `MAX_ENTIDADES` (declarado en decisión) | 4 | 5 | `20260611_decision_color_por_nivel.md` | el archivo afirmaba un tope obsoleto |

Fuente canónica de las vigentes: `30_procesamiento/33_motor_template.html`.

## 10. Arquitectura de archivos

Sin cambios estructurales. Escáner regenerado al cierre. Los tres `verificar_*.R` siguen en la raíz, ignorados y no versionados.

## 11. Pendientes y ruta sugerida

**Inventario.**

1. **Dependencia de `unpkg.com`** — tipo: bloqueante técnico. El motor no abre sin red. Impacto: alto. Dependencias: ninguna externa; el precedente está auditado. Complejidad: media-alta. Precaución: sin `runtime: "classic"` la transpilación falla en silencio; versionar el JSX hermano desde el día uno. Criterio de éxito: `src="http"` en 0 sobre el HTML publicado, con control positivo.
2. **Panorama desborda bajo ~540px** — tipo: mejora visual. El piso de 460px del grid no cede. Complejidad: baja. Criterio: el grid pasa a una columna sin recorte en 375px.
3. **Descarga real de los tres exportadores** — tipo: verificación pendiente. Contenido y contrato probados; la descarga no. Complejidad: trivial (tres clics del titular).
4. **`xmlns` duplicado en `construirSvgGraficos`** — tipo: deuda técnica. Patrón confirmado en el código; efecto real no observado. Complejidad: baja.
5. **Regla 12 sin redactar** — tipo: documentación. A29-4 no llegó a `50_diseno_ramas_deteccion.md`.
6. **`renv` desincronizado, suite standalone desfasada** — bloqueados por `suitedoc` sin remoto, en `herramientas_dev`.
7. **Guarda `asegurar_locale_utf8()` ausente** y **`10_validar_portabilidad.R` sin invocador** — heredados, probablemente de cartera.
8. **Actualización anual SIMCE 2025/2026** — bloqueada por insumos.

**Deuda técnica.** `33_motor_template.html` llegó a 4.582 líneas y mezcla CSS, JSX y D3 en un solo archivo; es la zona frágil del proyecto y la que más creció esta sesión. Viola B.2 (simplicidad) por acumulación, no por decisión.

**Auditoría de cierre (5.6).** Datos crudos aislados: sí. Pipeline de cero sin intervención manual: sí. Nombres sin tildes ni espacios: sí. Estructura conforme: con las dos desviaciones heredadas ya inventariadas. Guarda de locale instalada: **no** → pendiente 7.

### Compuerta de dudas (5 registradas)

| # | supuesto | predicado | medición |
|---|---|---|---|
| 1 | GitHub Pages sirve el build final, igual que sirvió el anterior | El archivo que devuelve `https://tomgc.github.io/slep_simce_adecuado/` es byte a byte `docs/index.html`, md5 `c9747962e7f9cc8179de3a717f66f9af` | `curl -s -o /tmp/pages.html <URL>`, `md5 -q /tmp/pages.html`, `cmp /tmp/pages.html docs/index.html`; caché de 600 s, un solo reintento tras `sleep 90` |
| 2 | Las tres exportaciones descargan de verdad, no solo generan bien su contenido | Al pulsar CSV, SVG y PNG en el panorama y PNG en el supergrid, el navegador descarga cuatro archivos abribles y no vacíos | Abrir `docs/index.html`, pulsar los cuatro botones y abrir cada archivo descargado |
| 3 | El panorama es usable en pantalla estrecha | El grid pasa a una columna sin recorte horizontal a 375px de viewport | Abrir el motor con el inspector en 375px y comprobar que no hay barra de desplazamiento horizontal |
| 4 | `construirSvgGraficos` produce un `xmlns` duplicado en el SVG que exporta | El SVG exportado del supergrid abierto en un validador XML da error de atributo duplicado | Exportar SVG desde la vista de comparación y abrirlo en un validador XML o en el navegador |
| 5 | El badge de traspaso se lee correctamente tras escribirse en minúscula inicial | En la ficha de un SLEP prospectivo el badge muestra `Traspaso <año>`, legible y sin desbordar su caja | Abrir el modal de territorio, pestaña SLEP, y mirar la fila de un SLEP con traspaso futuro |

**Ruta sugerida.** Primero la dependencia de CDN, en sesión propia: es el único pendiente que hoy puede dejar la herramienta inutilizable. Después el desborde bajo 540px. Diferir el resto.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 `cod_com_rbd` es la clave para agregar por comuna; nunca `nom_com_rbd`.
- 🔒 La segmentación por GSE de la vista de comparación es inviolable; el panorama combina porque es otra vista.
- 🔒 Color por nivel (`D-color-nivel`); `entity.color` nunca codifica el dato.
- 🔒 `docs/index.html` se actualiza por copia íntegra, jamás por edición.
- 🔒 El D3 minificado vendorizado no se toca.
- 🔒 La escala del SVG vive en `FS_SVG`; la de la interfaz en `--fs-*`. Sin literales.
- 🔒 Sin mayúsculas sostenidas en el texto salvo siglas (`GSE`, `SLEP`, `RBD`, `CSV`, `SVG`, `PNG`, `N`).
- 🔒 El backlog conserva sus cinco secciones de POLITICA §10 y su detalle en `###`.
- ✅ ANTES de entregar un archivo editado, cotejar su base contra `HEAD`.
- ✅ ANTES de desplegar, gate visual del titular.
- ⚠️ NO expresar criterios como cantidad de líneas de `diff`, de `status` ni de commits.
- ⚠️ NO anclar un patrón de verificación en una frase que el ajuste de línea puede partir.
- ⚠️ NO medir el archivo completo para probar algo local a un bloque.

## 13. Fragmentos de código de referencia

Dos patrones nuevos de esta sesión, ambos en `33_motor_template.html`: `dibujarPanoramaEnGrupo(g, {series, iw, ih})`, que recibe un `<g>` y sirve a pantalla y exportación desde un solo código; y `aNombrePropio(txt)`, que solo transforma cadenas enteramente en mayúsculas y respeta los conectores. Los patrones estables viven en el propio template.

## 14. Reapertura

Sesión 30. Insumos: este traspaso y el escáner al cierre. `main` al cierre: `3b17b9b`. Foco propuesto: la dependencia de `unpkg.com`, con el precedente C3 ya auditado.

## 15. Errores del asistente

| # | Error | Regla incumplida | Consecuencia |
|---|---|---|---|
| 1 | Criterio "4 líneas eliminadas y 4 añadidas" en la corrección de `ESTADO.md` | regla 7 | detención falsa |
| 2 | Criterio "2 líneas modificadas en `status`" tras el build | regla 7 | detención falsa |
| 3 | Criterio "exactamente una línea" en FASE 0, sin contar el `??` del propio encargo | regla 1 | detención falsa |
| 4 | Criterio "tres commits nuevos" cuando eran dos | regla 10 | desvío reportado |
| 5 | Estado esperado de T4 escrito como apuesta ("categoría 3: ninguna") | regla 1 | hallazgo tratado como sorpresa |
| 6 | Esperado-0 de `fmtPctShort(seg.val)` medido sobre el archivo completo | A29-4 | duda que exigió cuatro mediciones para descartarse |
| 7 | Entrega de plantilla desde copia anterior a dos commits publicados | A29-1 | regresión, atrapada por el gate |
| 8 | Cláusula SLEP de T2 nombró la clave comunal en vez de los RBDs | A-s28-4 | corregido por el ejecutor |
| 9 | Prescribí el campo `**Identificador:**` sin medir la convención vigente (`**ID:**`) | A-s28-4 | T7 congelada una corrida |
| 10 | "sus tres interpolaciones" cuando eran cuatro | cifra sin medir | ninguna |
