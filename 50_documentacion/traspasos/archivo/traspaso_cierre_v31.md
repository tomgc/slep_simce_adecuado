# Traspaso de cierre v31 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`, motor de comparación interactivo de resultados Simce por estándares de aprendizaje.
- **Versión del traspaso:** v31. **Fecha:** 2026-09-23. **Sesión:** 31.
- **Foco:** cerrar el cierre v30 que no había corrido (apertura de emergencia), retirar la dependencia de `unpkg.com`, reemplazar la base Simce 2025 preliminar por la final, y corregir los rótulos encimados de las barras de la vista de comparación con la regla de `slep_idps`.
- **Entorno:** Cowork con puente a la estación macOS (lectura, edición y pruebas de render en Chromium desde el contenedor); todo commit delegado a Claude Code en la estación.
- **Normativos usados:** `POLITICA_PROYECTO.md` con encabezado `**Versión 5.8 — vigente.**` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` con encabezado `**Versión 38.**`, desde la knowledge base.
- **`main` previo al commit de cierre:** `5608f9b`.
- **Archivos principales modificados:** `30_procesamiento/33_motor_template.html`, `30_procesamiento/33_generar_html.R`, `30_procesamiento/31_leer_normalizar.R`, `10_utils/` (tres dependencias vendorizadas), `20_insumos/simce/{4b,2m}/` (bases 2025 finales), `docs/index.html`, `50_documentacion/activa/50_diseno_ramas_deteccion.md`, `50_documentacion/activa/manifiesto_insumos.md`, `50_documentacion/activa/50_datos_versionados_autorizados.md`, `README.md`.

## 2. Resumen ejecutivo

La sesión abrió en emergencia: el cierre v30 nunca se había ejecutado, porque el paquete estaba en `andamios/` sin versionar, `ESTADO.md` estaba modificado en el índice y un `.git/index.lock` huérfano del 2026-09-09 bloqueaba git. Se corrigió el paquete (versión de SETTINGS, formato de `patron`, autorización del xlsx en I8), se liberó el árbol y el cierre v30 corrió y se publicó. Con la sesión abierta, se redactó la regla 12 y se retiró `unpkg.com` con la opción C: el generador transpila el JSX con Babel dentro de V8 y React va inline, así que el motor abre sin red y el titular sigue editando JSX. Después se reemplazaron las bases 2025 preliminares por las finales, que la Agencia publicó sin ningún cambio de datos, y el asterisco de preliminar pasó a derivarse de los insumos. Por último, a pedido del titular, se aplicó a las barras de la vista de comparación la regla de rotulado de `slep_idps`, que eliminó 56 cifras encimadas. Hubo tres despliegues, todos verificados por md5 contra lo que sirve GitHub Pages. Quedan pendientes el traslado de la vista de trayectorias (con la corrección del grupo 5), una rama local sin publicar que reclama el paso 35, y el contraste de las cifras rescatadas en azul claro.

## 3. Estado al cierre

**Qué funciona.**

- El motor publicado abre sin red: 0 pedidos externos y 1.665 elementos renderizados con la red cortada, contra 0 del motor anterior (fuente: Playwright en esta sesión).
- GitHub Pages sirve `5fcb5d9a4baa052f28010d31923c1855`, igual a `docs/index.html` y a `40_salidas/motor_comparacion.html` (fuente: curl de Claude Code tras el push de `5608f9b`).
- 2025 aparece como definitivo: sin asteriscos, sin la leyenda ni la nota de preliminares, con cifras idénticas a las publicadas antes (fuente: comparación de texto y de rótulos en Chromium).
- Las barras de «Últimas 3 aplicaciones» no tienen cifras encimadas en ninguna de las cuatro combinaciones de nivel y prueba, ni en el SVG exportado (fuente: medición de solapes en Chromium).
- Última ejecución completa del pipeline: `Rscript 00_build.R`, código 0, en el encargo `encargo_simce2025_final.md`.

**Qué no funciona o queda a medias.**

- La vista de trayectorias sigue en `andamios/` y excluye el grupo 5 del total `T` de la nube y del referente (B31-4).
- Las cifras rescatadas de Elemental se escriben en `#6BA0CE`, con contraste 2,78:1 sobre blanco (fuente: cálculo WCAG en esta sesión); vale para el panorama y para las barras.
- `V8` y `openssl` no están en `renv.lock`: otra estación sin esos paquetes no puede construir el motor.

**Delta respecto de v30.** v30 construyó una tercera vista sin tocar el motor. v31 no tocó esa vista y cerró la deuda principal del motor: ya no depende de la red, 2025 es definitivo y las barras dejaron de encimar cifras.

## 4. Registro detallado de cambios

**4.1 Apertura de emergencia y cierre v30 (REPO).** El cierre v30 no había corrido: `origin/main` estaba en `f7279eb` (log de cierre v29), `paquete_cierre_v30.md` estaba sin versionar y `ESTADO.md` modificado en el índice. Correcciones antes de `/cierre`: `settings_version` de 37 a 38 (el kit ya estaba en 38 y F0.6 habría bloqueado), `patron` de ERR-30-02 al formato de la v38, entrada del xlsx de filas anómalas en `50_datos_versionados_autorizados.md` (I8 habría fallado), `ESTADO.md` restaurado a `HEAD` con `git show`, y dos `.git/index.lock` movidos a `_archivo/20260923/`: el del 2026-09-09 y uno nuevo que generó un `git restore` desde el puente (ERR-31-01). El cierre v30 terminó en `24cff4e` y `/apertura` abrió en `9908180`.

**4.2 Regla 12 (DOC).** `50_diseno_ramas_deteccion.md`: regla 12, «el alcance del instrumento iguala el alcance de la afirmación», con su línea de comprobación y `## 7` con A29-4. Commit `2ab9927`.

**4.3 Retiro de `unpkg.com` (UI).** Opción C, decidida por el titular (D31-1, archivo en `decisiones/20260923_decision_transpilacion_en_build.md`). En `10_utils/` quedaron React, ReactDOM y Babel standalone, verificados por sha384 contra los SRI anteriores (`65e5e4a`). El generador gana el Bloque 0 (`VENDOR_JS`, `verificar_vendor`, `reemplazar_literal`, `transpilar_jsx`) y el Bloque 3b; la plantilla cambia los tres `<script src>` por `__REACT_INLINE__` y `__REACTDOM_INLINE__` (`02daaf7`). Verificación: 0 `src="http`, transpilado idéntico al del navegador (175.217 caracteres), render sin red con 0 píxeles distintos al publicado a 1440 y 375 px. Publicado en `232960c`; el titular hizo su checklist de cinco puntos en Safari, sin fallas. Ejecutado por dos encargos: `encargo_retiro_cdn_v8.md` (log en `bb53c8c`) y su adenda (log en `cd061a6`).

**4.4 Diagnóstico del grupo 5 en la vista de trayectorias (D).** Solo lectura. En el catálogo SLEP, las 22 filas del grupo 5 (9 RBD) quedan fuera por el filtro de supresión: 0 a 4 evaluados y porcentajes en 0 o vacíos. En cambio, el script que ensambló la vista descartó el grupo 5 antes de agregar, y por eso el `T` de la nube y del referente lo excluye: en Las Condes, 4° básico Lectura 2023, `T` n=271 contra 344 en el parquet (73 del grupo 5, RBD 41617). Corrección pendiente en el generador R del traslado.

**4.5 Bases Simce 2025 finales (D).** El titular dejó `simce{4b,2m}2025_rbd_final.xlsx` en `20_insumos/simce/`. Comparación celda a celda contra las preliminares, con control positivo: mismas 7.143 × 42 y 3.002 × 42, mismos RBD, 0 celdas distintas en las 40 columnas de datos; solo cambian `codigo_bbdd` (v12025 → v22025) y `fecha_bbdd` (2026-04-27 → 2026-06-22). Las preliminares salieron del índice y se movieron a `_archivo/20260923/20_insumos/simce/`, con md5 verificado contra git (opción A del titular). Commit `9bad097`.

**4.6 Año preliminar derivado de los insumos (UI).** `anios_preliminar` deja de ser el literal `2025L` y sale de `simce_rbd.parquet`; la leyenda del mapa de calor y la nota metodológica pasan a mostrarse solo si hay algún año preliminar; el tooltip usa el año del dato. `44dfb07`. Verificación: parquets `identical()` en las 13 columnas que escribe `main`, JSON idéntico salvo `anios_preliminar`. Publicado en `7e7b294`. Encargo `encargo_simce2025_final.md` (log en `49185eb`).

**4.7 Rotulado de barras con la regla de `slep_idps` (UI).** A pedido del titular, tras su captura. Causa: en `RecentBarsSubchart` la cifra de Adecuado se dibujaba siempre, 16 px bajo su borde, y caía sobre la de Elemental cuando Adecuado era delgado. La regla única de IDPS (s29): una cifra va dentro de su franja solo si cabe entera; si no, baja completa bajo el año, con la inicial del nivel en su color y un decimal, como ya hacía el panorama. `RECENT_DIMS` (320 × 189) pasa a ser la fuente única de las medidas para pantalla y exportación, y `ALTO_MIN_ROTULO_BARRAS` = 16 (`cdae5b8`). La revisión de la exportación encontró que la celda del SVG compuesto quedaba 6 px corta y cortaba el segundo renglón; se corrigió `CELL_H` (`88dc7af`). Verificación: cifras encimadas 56 → 0 en las cuatro combinaciones, 0 de 137 textos fuera de su gráfico, SVG exportado XML válido sin solapes. Publicado en `5608f9b`.

**4.8 Registro de errores del redactor (DOC).** `50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md`, con ocho entradas escritas en el momento en que ocurrieron (commits `005753c`, `6d715a5`, `2a1debb` y los de los logs de encargo).

## 5. Backlog acumulativo

En `50_documentacion/activa/backlog_acumulativo.md`. Esta sesión agrega 7 entradas.

## 6. Bugs de la sesión

**B31-1: el motor no abría sin red** (heredado de v29). Causa: React, ReactDOM y Babel se cargaban desde `unpkg.com`. Solución: 4.3. Verificación: 0 `src="http` y render sin red. **Patrón:** una dependencia de CDN es una dependencia de disponibilidad ajena; un producto que se publica se construye autocontenido. Estado: resuelto.

**B31-2: cifras encimadas en las barras de «Últimas 3 aplicaciones».** Síntoma: con Elemental e Insuficiente a la vista, «13%» y «2%» superpuestos. Causa: `33_motor_template.html`, el rótulo de Adecuado sin umbral y en posición fija. Solución: 4.7. **Patrón:** toda cifra dentro de una franja se somete a la misma regla de espacio; una excepción por nivel es un solape latente. Estado: resuelto; estaba publicado desde antes de esta sesión.

**B31-3: segundo renglón rescatado cortado en el SVG exportado.** Causa: `construirSvgGraficos` clona las barras en `y = SPARK_H + 36`, pero `CELL_H` sumaba 30. Solución: `CELL_H = SPARK_H + 36 + BARS_H + 6`. **Patrón:** el constructor que reposiciona un SVG clonado debe derivar su caja de la misma posición que usa, no de un margen escrito aparte. Estado: resuelto.

**B31-4: la vista de trayectorias excluye el grupo 5 de su total `T`.** Causa: el script auxiliar de ensamblado filtraba por grupo antes de agregar (4.4). Estado: pendiente, en el traslado.

## 7. Aprendizajes y restricciones descubiertas

1. **A31-1: una comparación de píxeles contra lo publicado prueba que no hubo regresión, no que la forma esté bien.** La revisión visual recorre cada tipo de gráfico y cada exportación con una lista de forma. Ejemplo: B31-2 estaba publicado y pasó dos revisiones de píxeles; B31-3 solo apareció al mirar la exportación (ERR-31-08).
2. **A31-2: los artefactos ignorados por git son compartidos entre ramas.** Una línea base sobre `40_salidas/intermedios/` exige medir su procedencia (fecha y columnas) antes de usarla. Ejemplo: `simce_rbd.parquet` del 2026-07-11 venía de `feat/contrato-contexto` (ERR-31-07).
3. **A31-3: un criterio de presencia sobre una página que embebe código de terceros usa el marcador exacto.** `__REACT` aparecía dentro de ReactDOM (ERR-31-02). Es un caso de la regla 12.
4. **A31-4: un invariante byte a byte sobre un artefacto con marca temporal falla por diseño.** Se compara el contenido sin el campo temporal (`fecha_generacion`).
5. **A31-5: el puente de Cowork no puede borrar, y git necesita borrar su propio candado.** Toda escritura de git va delegada a Claude Code, incluidos `restore` y `rm --cached` (ERR-31-01).
6. **A31-6: la Agencia identifica la versión de la base por `codigo_bbdd`.** La base final de 2025 (v22025) no cambió datos respecto de la v12025.

## 8. Decisiones de diseño

- **D31-1: transpilación del JSX en el build con V8** (opción C, contra el precedente C3 y contra incrustar Babel). Archivo `decisiones/20260923_decision_transpilacion_en_build.md`.
- **D31-2: el invariante del payload excluye `meta.fecha_generacion`.** Alternativa descartada: volver determinista el generador, que cambiaría el producto para satisfacer un criterio.
- **D31-3: las bases preliminares salen de git a `_archivo/<fecha>/`** cuando llega la final (opción A del titular); quedan en el historial de git y en disco. Alternativa descartada: una subcarpeta versionada dentro de `20_insumos/`.
- **D31-4: la regla de rotulado de `slep_idps` se aplica con la inicial del nivel, no con los glifos ▼ ▲**, que en IDPS significan «bajo» o «sobre su GSE». Consistente con el panorama (s29).
- **D31-5: `RECENT_DIMS` es la fuente única de las medidas de las barras** para pantalla y exportación.

## 9. Constantes y parámetros

| Constante | Antes | Después | Archivo | Motivo |
|---|---|---|---|---|
| `anios_preliminar` | `I(c(2025L))` | derivado de `simce_rbd.parquet` | `33_generar_html.R` | el asterisco sigue a los insumos |
| `VENDOR_JS` | no existía | React, ReactDOM y Babel con sha384 | `33_generar_html.R` | build sin red y verificable |
| `OPCIONES_BABEL` | no existía | presets `env` y `react` (runtime `classic`) | `33_generar_html.R` | mismo transpilado que el navegador |
| `RECENT_DIMS` | `W 320, H 165, M.bottom 24` en dos sitios | `W 320, H 189, M.bottom 48`, fuente única | `33_motor_template.html` | dos renglones de cifras rescatadas |
| `ALTO_MIN_ROTULO_BARRAS` | literal `16`, solo para Elemental e Insuficiente | constante, para los tres niveles | idem | regla única de rotulado |
| `FS_SVG.barras.valorFuera` | no existía | 10 | idem | escala de la cifra rescatada |
| `CELL_H` (exportación) | `SPARK_H + BARS_H + 30` | `SPARK_H + 36 + BARS_H + 6` | idem | B31-3 |

Fuente canónica de las vigentes: `30_procesamiento/33_motor_template.html` y `30_procesamiento/33_generar_html.R`.

## 10. Arquitectura de archivos

Sin cambios de estructura. Nuevos: tres `.js` en `10_utils/`, las dos bases 2025 finales, un archivo de decisión y los logs de encargo. Las preliminares salieron del árbol hacia `_archivo/` (fuera de git). Escáner regenerado por el ejecutor al cierre.

## 11. Pendientes y ruta sugerida

**Inventario.**

1. **Rama local `feat/contrato-contexto`**. Tipo: bloqueante de numeración. Existe solo en la estación macOS, nunca se publicó (fuente: `git branch -r --contains 6e00830` vacío). Su último commit, `31befa2` del 2026-07-11, se titula «paso 35», el número reservado para la vista de trayectorias, y versiona `40_salidas/publico/contexto_simce.parquet`. Impacto: si se pierde la máquina, se pierde el trabajo; si se ignora, choca con la numeración. Complejidad: baja para decidir. Precaución: contiene además commits de cierre de la sesión 26 que no están en `main` (duda 4). Criterio de éxito: la rama queda publicada, integrada o archivada, por decisión del titular, y el número del traslado queda fijado.
2. **Trasladar la vista de trayectorias a `30_procesamiento/`** (D-s30-6), con la corrección de B31-4 y una prueba D9 (`T` = suma de todos los grupos del parquet). Tipo: deuda técnica. Complejidad: media. Principios: política §1.2; regla de herramientas (generador en R); invariante sin red. Criterio: el generador R regenera el HTML desde el repositorio; D1 a D9 pasan en verde; el `T` de Las Condes, 4° básico Lectura 2023, da 344.
3. **Contraste de las cifras rescatadas**. Tipo: mejora visual. `#6BA0CE` sobre blanco da 2,78:1. Enfoque: un token de texto más oscuro para lo que va fuera de la barra, como hizo IDPS en s29c, aplicado al panorama y a las barras. Complejidad: baja. Criterio: contraste ≥ 4,5:1 medido, en ambos sitios.
4. **Columna vacía en las notas metodológicas**. Tipo: cosmética; ya existía antes de esta sesión. Complejidad: baja.
5. **El panorama desborda bajo ~540 px**. Heredado. Criterio: una columna sin recorte a 375 px.
6. **Dudas 2, 3 y 5 de v30** (comparabilidad 2018-2022, las 652 filas sin grupo, batería Playwright sin versionar). Heredadas, sin cambio.
7. **`V8` y `openssl` en `renv.lock`, suite standalone, `documentar.R` y `34_historico`**. Bloqueados por `suitedoc` sin remoto.
8. **Guarda `asegurar_locale_utf8()` ausente** y `10_validar_portabilidad.R` sin invocador. Heredados.
9. **Actualización anual Simce 2026**. Bloqueada por insumos.

**Cerrado en esta sesión:** la dependencia de CDN (v29 pendiente 1), la regla 12 (v29 pendiente 5), la duda 4 de v30 (existen los cuatro repositorios de destino) y el `xmlns` duplicado (v29 pendiente 4): el SVG exportado se parsea como XML válido (fuente: `xml.dom.minidom` sobre la exportación de esta sesión) y el titular no vio error en su checklist.

**Deuda técnica.** `33_motor_template.html` pasó de 4.582 a 4.621 líneas (fuente: `wc -l`). La exportación del supergrid todavía reposiciona los SVG clonados con literales propios (`SPARK_H + 36`); B31-3 salió de ahí.

**Auditoría de cierre (5.6).** Datos crudos aislados: sí. Pipeline de cero: sí (`00_build.R`, código 0). Check por transformación crítica: sí. Reproducible e idempotente: sí en contenido; el HTML cambia de bytes entre días por `fecha_generacion`, por diseño (D31-2). Constantes nombradas: sí. Nombres sin tildes: sí. Estructura conforme: **no**, la vista de trayectorias sigue en `andamios/` → pendiente 2. Guarda de locale: **no** → pendiente 8.

### Compuerta de dudas (4 registradas)

| # | supuesto | predicado | medición |
|---|---|---|---|
| 1 | Otra estación puede construir el motor | `V8` y `openssl` están instalados en toda estación que corra `33_generar_html.R` | En cada estación: `Rscript -e 'cat(sapply(c("V8","openssl"), requireNamespace, quietly=TRUE))'` → `TRUE TRUE` |
| 2 | Las cifras rescatadas no se enciman en pantallas estrechas | Con Elemental e Insuficiente a la vista, 0 textos superpuestos en `svg.bars-svg` a 375 px | Inspector a 375 px, 2° medio Matemática, recorrer las tarjetas; o la medición de solapes de esta sesión con `viewport` 375 |
| 3 | La exportación PNG del supergrid hereda la celda corregida | El PNG exportado muestra completo el segundo renglón bajo el año | Exportar PNG en 2° medio Matemática con Elemental e Insuficiente, y mirar Concón, GSE Bajo |
| 4 | La rama `feat/contrato-contexto` no contiene trabajo que `main` necesite | `git log --oneline main..feat/contrato-contexto` solo lista commits reemplazados en `main` | Ese comando más `git diff --stat main...feat/contrato-contexto`, leídos contra el backlog de las sesiones 26 y 27 |

**Ruta sugerida.** Primero, decidir la rama `feat/contrato-contexto` (pendiente 1): son minutos y fija el número del traslado. Después, el traslado de la vista con la corrección del grupo 5 (pendiente 2). Si queda espacio, el contraste (pendiente 3). Diferir el resto.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 `cod_com_rbd` es la clave para agregar por comuna; nunca `nom_com_rbd`.
- 🔒 La segmentación por grupo socioeconómico de la vista de comparación es inviolable; el panorama combina porque es otra vista.
- 🔒 Color por nivel (`D-color-nivel`); `entity.color` nunca codifica el dato.
- 🔒 `docs/index.html` se actualiza por copia íntegra, jamás por edición.
- 🔒 El D3 minificado vendorizado no se toca, y tampoco React, ReactDOM ni Babel en `10_utils/`: el build verifica su sha384.
- 🔒 El motor no carga nada por red: `grep -c 'src="http' docs/index.html` = 0.
- 🔒 La escala del SVG vive en `FS_SVG`; la de la interfaz en `--fs-*`; las medidas de las barras en `RECENT_DIMS`. Sin literales.
- 🔒 Una cifra va dentro de su franja solo si cabe; si no, baja bajo el año con la inicial del nivel.
- 🔒 Sin mayúsculas sostenidas en el texto salvo siglas.
- 🔒 El backlog conserva sus cinco secciones de POLITICA §10 y su detalle en `###`.
- 🔒 El grupo socioeconómico es atributo del par establecimiento-nivel.
- 🔒 La vista de trayectorias no depende de la red, y los períodos sin medición se dibujan como hueco.
- ✅ ANTES de entregar un archivo editado, cotejar su base contra `HEAD`.
- ✅ ANTES de dar por revisado algo visual, recorrer con una lista de forma cada tipo de gráfico **y cada exportación**, no solo comparar píxeles contra lo publicado.
- ✅ ANTES de usar `40_salidas/intermedios/` como línea base, medir su fecha y sus columnas: lo comparten todas las ramas.
- ✅ ANTES de dar por buena una cifra de la vista de trayectorias, correr `verificar_trayectorias.R` y comprobar que D8 detecta su perturbación.
- ⚠️ NO correr ningún comando de git que escriba (commit, `restore`, `rm --cached`) desde el puente de Cowork.
- ⚠️ NO iterar sobre `mockup_trayectoria_traspasos.html` en `andamios/`; el traslado va primero.
- ⚠️ NO integrar la vista de trayectorias como pestaña de `33_motor_template.html`.
- ⚠️ NO escribir en un encargo un comando que no se corrió antes.
- ⚠️ NO expresar criterios como cantidad de líneas de `diff`, de `status` ni de commits.

## 13. Fragmentos de código de referencia

```r
# 33_generar_html.R: transpila el bloque JSX de la plantilla dentro de V8.
transpilar_jsx <- function(jsx, babel_code) {
  ctx <- V8::v8()
  ctx$eval(babel_code)
  ctx$assign("fuente_jsx", jsx)
  ctx$eval(paste0("var salida_babel = Babel.transform(fuente_jsx, ",
                  OPCIONES_BABEL, ").code;"))
  salida <- ctx$get("salida_babel")
  if (!isTRUE(ctx$validate(salida))) stop("La salida de Babel no es JavaScript válido.")
  salida
}
```

```js
// 33_motor_template.html, RecentBarsSubchart: regla única de rotulado.
// Dentro solo si cabe; si no, bajo el año con la inicial y un decimal.
if (h >= ALTO_MIN_ROTULO_BARRAS) { /* rótulo interno */ } else { rescatadas.push(seg); }
rescatadas.forEach((seg, k) => g.append("text")
  .attr("x", xPos + bw / 2).attr("y", ih + 28 + k * 12)
  .attr("fill", seg.fill).text(seg.sigla + " " + fmtPct(seg.val)));
```

Los patrones estables siguen en la propia plantilla y en el generador.

## 14. Reapertura

Tipo de sesión: CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`) vive en la knowledge base del Project y se lee desde ahí; no se adjunta.

**Se adjuntan:** `traspaso_cierre_v31.md`; y `50_documentacion/andamios/mockup_trayectoria_traspasos.html` (voluminoso, 1,6 MB, y crítico para el traslado). El backlog y el escáner no se adjuntan.

**Estado:** `main` en `5608f9b`, previo al commit de cierre. Motor publicado sin red, con 2025 definitivo y barras sin cifras encimadas.

**Foco propuesto:** decidir el destino de la rama local `feat/contrato-contexto`, que reclama el paso 35; después, trasladar la vista de trayectorias a `30_procesamiento/`, corrigiendo la exclusión del grupo 5.

Si alguno de los archivos listados cambió entre sesiones, adjuntar la versión más actualizada al abrir y avisarlo en el mensaje de apertura.

## 15. Errores del asistente

Ocho errores, registrados en el momento en que ocurrieron en `50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md`. Se vuelcan aquí con los diez campos de §2.2.15 en layout de bloque. Los errores propios de Claude Code en los tres encargos (4, 0 y 3) están en sus logs.

**ERR-31-01**
- `momento`: apertura de emergencia, al preparar el árbol para el cierre v30.
- `disparador`: asistente lo señaló espontáneamente.
- `que_paso`: ejecuté `git restore --staged --worktree` desde el puente de Cowork, que no puede borrar archivos, y el comando dejó un `.git/index.lock` huérfano nuevo, del mismo tipo que el que acababa de retirar.
- `regla_violada`: SETTINGS §1.2.6, «ningún comando asume el entorno»; instrucción ⚠️ del traspaso v30 sobre operar git desde el puente.
- `causa_raiz`: leí la restricción del puente como «sin credenciales» (lo que impide commitear) y no como «sin permiso de borrado» (lo que impide a git soltar su propio candado), aunque el candado de 2026-09-09 era evidencia directa de lo segundo.
- `salvaguarda_presente`: SETTINGS y traspaso v30.
- `patron`: PAT-03, sobre capacidades de escritura de git en el puente.
- `gatillo_observable`: comando-entorno: un comando de git que escribe el índice se lanzó en una máquina donde `rm` falla con «Operation not permitted».
- `intentos_previos`: 0.
- `costo`: un candado huérfano más, retirado con `mv` a `_archivo/20260923/`; ESTADO.md restaurado con `git show HEAD:` en vez de `git restore`.

**ERR-31-02**
- `momento`: redacción de `encargo_retiro_cdn_v8.md`, criterio de T2 sobre marcadores.
- `disparador`: el ejecutor lo detectó (T2 congelada, duda D1).
- `que_paso`: escribí `grep -c -F '__REACT'` sobre la página entera para afirmar que se reemplazaron dos marcadores, y el prefijo aparece dentro de ReactDOM (`__REACT_DEVTOOLS_GLOBAL_HOOK__`).
- `regla_violada`: regla 12 de `50_diseno_ramas_deteccion.md`, redactada por mí en la misma sesión, minutos antes.
- `causa_raiz`: apliqué la regla 12 a los criterios que marqué con universo explícito y no a este, que escribí como abreviatura del par de marcadores; abreviar el patrón amplió el universo sin que lo viera.
- `salvaguarda_presente`: `50_diseno_ramas_deteccion.md` (regla 12) y SETTINGS §1.2.6.
- `patron`: PAT-13, criterio que mide un proxy (un prefijo) y no la afirmación (dos marcadores).
- `gatillo_observable`: encargos-premisas: un patrón abreviado sobre un archivo que incluye código de terceros.
- `intentos_previos`: 0.
- `costo`: T2 congelada, una vuelta de dudas con el titular.

**ERR-31-03**
- `momento`: redacción del encargo, tercer 🔒 (payload idéntico).
- `disparador`: el ejecutor lo detectó (🔒 3 en FALLA, duda D2).
- `que_paso`: exigí md5 idéntico del payload comprimido sin inspeccionar que el generador escribe `fecha_generacion = format(Sys.Date())` dentro del JSON.
- `regla_violada`: SETTINGS §1.2.6, «fuente primaria de una estructura es su inspección».
- `causa_raiz`: supuse que el payload dependía solo de los parquet porque los datos no cambiaron; no leí el bloque del generador que arma `meta`.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, sobre la forma de un objeto supuesta y no inspeccionada.
- `gatillo_observable`: afirmar-sin-leer: se fijó un invariante byte a byte sobre un artefacto cuyo constructor no se leyó.
- `intentos_previos`: 0.
- `costo`: 🔒 en FALLA falso y T2 sin commit.

**ERR-31-04**
- `momento`: redacción del encargo, FASE 0.
- `disparador`: el ejecutor lo detectó.
- `que_paso`: escribí `git rev-parse --short HEAD origin/main`, que no corre porque `--short` implica `--verify` y admite una sola revisión.
- `regla_violada`: SETTINGS §1.2.6, «ningún comando asume el entorno»; encargo v1.6 §2.10 ítem 13 por analogía (comando no probado).
- `causa_raiz`: combiné dos mediciones en un comando sin correrlo, pese a tener un shell disponible donde probarlo.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-03, sobre la sintaxis de una herramienta no probada.
- `gatillo_observable`: comando-entorno: un comando del encargo que nunca se ejecutó antes de enviarlo.
- `intentos_previos`: 0.
- `costo`: una re-medición por dos vías del ejecutor; ninguno hacia fuera.

**ERR-31-05**
- `momento`: edición de `33_generar_html.R` antes del encargo.
- `disparador`: el ejecutor lo detectó y lo corrigió.
- `que_paso`: el reemplazo que insertó el Bloque 3b duplicó la línea separadora que abre el Bloque 4.
- `regla_violada`: SETTINGS §1.2.6, «generar, verificar, consumar»: no miré el `diff` del generador antes de entregarlo.
- `causa_raiz`: verifiqué la plantilla con su `diff` y el generador solo con `grep` de marcadores.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-02, sobre entregar sin revisar el `diff` completo.
- `gatillo_observable`: otro: archivo editado entregado sin leer su `diff`.
- `intentos_previos`: 0.
- `costo`: una línea corregida por el ejecutor.

**ERR-31-06**
- `momento`: redacción de `encargo_retiro_cdn_v8_adenda.md`.
- `disparador`: el ejecutor lo detectó (Duda 1 de la adenda, ADVIERTE R-16).
- `que_paso`: agregué al ALCANCE de la adenda el registro de errores, que vive en `andamios/`, y dejé heredado sin cambio el 🔒 5 que admitía solo el LOG en esa carpeta.
- `regla_violada`: `50_diseno_ramas_deteccion.md`, regla 8 (recorrer el camino nominal antes de entregar).
- `causa_raiz`: edité el ALCANCE en un segundo paso, para cuadrar FASE 0, y no volví a leer los invariantes heredados contra el cambio.
- `salvaguarda_presente`: `50_diseno_ramas_deteccion.md`.
- `patron`: PAT-07, sobre una restricción propia no propagada a otra sección del mismo encargo.
- `gatillo_observable`: encargos-premisas: una ruta nueva en ALCANCE cae bajo un 🔒 heredado que la excluye.
- `intentos_previos`: 0.
- `costo`: una duda abierta; el ejecutor aplicó la lectura correcta y no hubo rehecho.

**ERR-31-07**
- `momento`: redacción de `encargo_simce2025_final.md`, 🔒 2.
- `disparador`: el ejecutor lo detectó (T2 congelada, R-11 BLOQUEA).
- `que_paso`: tomé como línea base los parquet de `40_salidas/intermedios/` sin comprobar de qué build venían; `simce_rbd.parquet` era del 2026-07-11 y salió de la rama local `feat/contrato-contexto`, con cinco columnas que `main` no escribe.
- `regla_violada`: SETTINGS §1.2.6, marcador S-01 tipo 4 (premisa de hecho de un encargo) y «fuente primaria de una estructura es su inspección».
- `causa_raiz`: la carpeta está ignorada por git y la traté como si fuera producto de `HEAD`; la fecha del parquet (11 de julio, anterior a sesiones de `main` que no lo reconstruyeron) estaba a la vista en el `ls -la` que yo mismo corrí al inicio de la sesión.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, sobre el origen de un artefacto ignorado por git supuesto y no medido.
- `gatillo_observable`: encargos-premisas: un 🔒 byte a byte contra un archivo no versionado cuya procedencia no se midió.
- `intentos_previos`: 0.
- `costo`: T2 congelada, push retenido, una vuelta de dudas.

**ERR-31-08**
- `momento`: gates visuales en Chromium del retiro del CDN y de la base 2025 final.
- `disparador`: usuario lo señaló sin nombrarlo error (captura con rótulos superpuestos en la vista de comparación).
- `que_paso`: di por revisado el render comparando píxeles contra la versión publicada y mirando solo la captura del panorama; nunca miré las barras «Últimas 3 aplicaciones» de la vista de comparación, donde los rótulos de Adecuado y Elemental se pisan cuando Adecuado es delgado.
- `regla_violada`: aviso 9 del mensaje de apertura de esta sesión (mirar lo visual renderizado con una lista de forma, no solo de datos); aprendizaje 6 del traspaso v30.
- `causa_raiz`: una comparación de píxeles contra el publicado prueba que no hubo regresión, no que la forma esté bien; la usé como si probara lo segundo, y la lista de forma no existió.
- `salvaguarda_presente`: mensaje de apertura del titular y traspaso v30 §7.6.
- `patron`: PAT-NUEVO-revision-visual-sin-lista, segunda sesión con el mismo mecanismo (propuesta del traspaso v30).
- `gatillo_observable`: otro: gate visual declarado sin recorrer cada tipo de gráfico con una lista de forma.
- `intentos_previos`: 0.
- `costo`: un defecto de forma publicado llegó al titular por segunda sesión seguida.

**Reincidencia.** `PAT-NUEVO-revision-visual-sin-lista` aparece por segunda sesión consecutiva (ERR-30-02, ERR-30-10, ERR-31-08). La propuesta de v30 queda reforzada: un paso obligatorio de lista de forma, que cubre pantalla y exportación, en la plantilla de entrega de artefactos visuales. Clasificación §2.2.16: omisión.

### Fricciones

- `friccion: «200 mil tokens para un cierre?» → se explicó que el costo venía del agente relanzado sin contexto; la revisión de /cierre queda para una sesión BIBLIOTECA.`
- `friccion: el titular preguntó si los encargos dejaban logs → se listaron los tres logs con su commit.`
- `friccion: «qué está ocurriendo que no queda listo?» → cada revisión encontraba algo que la anterior había saltado; desde entonces, pantalla y exportación se revisan en la misma pasada.`
- `friccion: «en una línea, sintetiza» → la respuesta sobre IDPS excedía el tope de forma.`
