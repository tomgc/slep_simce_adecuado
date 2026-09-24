# Traspaso de cierre v33 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`, motor de comparación interactivo de resultados Simce por estándares de aprendizaje.
- **Versión del traspaso:** v33. **Fecha:** 2026-09-24. **Sesión:** 33.
- **Foco:** la vista de trayectorias: regla de filas del motor, identidad visual del motor con menú de vistas compartido, y los nueve defectos de forma heredados del mockup (más la leyenda del referente y los menús sin opciones vacías).
- **Entorno:** Cowork con puente a la estación macOS (lectura, edición de archivos y mediciones; git solo en lectura con `GIT_OPTIONAL_LOCKS=0`); R 4.3.3, arrow 25.0.1, V8 y Chromium en el contenedor del asistente, sobre una réplica del árbol; commits delegados a Claude Code en la estación, en tres instrucciones cortas. Lectura de `slep_central_datos` autorizada por el titular (solo lectura).
- **Normativos usados:** `POLITICA_PROYECTO.md` con encabezado `**Versión 5.8 — vigente.**` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` con encabezado `**Versión 38.**`, desde la knowledge base; iguales a las copias de `activa/`.
- **`main` previo al commit de cierre:** `1d6c4ce` (tres commits de la sesión sobre `562cfd8`, sin push; el push lo hace el cierre).
- **Archivos principales creados o modificados:** `30_procesamiento/36_funciones_trayectorias.R`, `36_generar_trayectorias.R`, `36_verificar_trayectorias.R`, `36_trayectorias_template.html`; `50_documentacion/activa/decisiones/20260924_decision_regla_filas_y_publicacion_trayectorias.md` (nuevo); `50_documentacion/activa/50_revision_safari_trayectorias.md` (nuevo, sin commit hasta este cierre); `50_documentacion/andamios/logs/20260924_sesion33_errores_asistente.md` (nuevo).

## 2. Resumen ejecutivo

La sesión abrió sin el eco de `/apertura`; el candado se midió a mano y `/apertura` corrió después (`562cfd8`), no sin que un `git fetch` desde el puente dejara candados huérfanos en `.git/` (ERR-33-01). El titular decidió, con una página de contexto y maquetas, tres cosas: la vista usa la regla de filas del motor (D33-1), se publica como tercera entrada del menú del motor (D33-2) y la revisión en Safari se hace después de corregir la forma (D33-5); además, que la vista adopte la identidad del motor sin tema oscuro (D33-3) y que todos los proyectos del equipo migren a gobCL (D33-4). Se ejecutaron tres bloques con commit: la regla de filas con las cifras de las notas calculadas desde los datos (`498981b`), la identidad visual con encabezado y menú compartidos (`3de223d`), y los diez defectos de forma más los menús sin opciones vacías (`1d6c4ce`). La batería pasó de 17 a 19 pruebas, todas en PASA en la estación, y el HTML es idéntico byte a byte en la estación y en el entorno del asistente. Al estudiar el pedido de futuros traspasos se descubrió que el referente no son municipales «nunca traspasados», sino las olas 2027 a 2029 (ERR-33-02), y el rótulo se corrigió antes del commit. Quedan para la próxima sesión la revisión en Safari (lista escrita), el enlace desde el motor y la publicación; los futuros traspasos, que obligan a redefinir el referente, quedan para una sesión propia.

## 3. Estado al cierre

**Qué funciona.**

- `Rscript 30_procesamiento/36_verificar_trayectorias.R`: 19 pruebas, 19 en PASA, código 0, en la estación (fuente: reporte de Claude Code del commit `1d6c4ce`).
- La vista es reproducible: md5 `ebee5acf417f9aebaa46366c167588d7` en la estación y en el entorno del asistente (fuente: `md5sum` en ambos, sesión 33).
- Sin red: 0 cargas externas (D12) y 0 errores de consola en los recorridos de Chromium sin conexión (540 estados antes del ajuste de menús; 250 combinaciones elegibles y 140 estados por ancho después) (fuente: scripts de recorrido del asistente, sesión 33).
- El motor publicado no cambió: `docs/index.html` sin tocar en la sesión.

**Qué no funciona o queda a medias.**

- La vista no se ha revisado en Safari (duda 1 de la compuerta; lista escrita).
- El enlace del motor a la vista no existe todavía: la vista ya tiene el menú con la tercera entrada, pero `index.html#panorama` no abre la pestaña Panorama hasta que el motor lea la dirección.
- A 375 px la vista desborda (675 px de ancho; el mockup desbordaba a 663) (fuente: medición en Chromium, sesión 33).
- `V8` y `openssl` siguen fuera de `renv.lock` (bloqueado por `suitedoc`).

**Delta respecto de v32.** La vista aplica la regla de filas del motor, tiene la identidad visual del motor y no trae los defectos de forma catalogados. El motor no cambió.

## 4. Registro detallado de cambios

**4.1 Apertura (REPO).** Sin eco de `/apertura`: el candado 0bis se midió a mano en lectura (4 comprobaciones en verde, `commit_cierre` `8fe8453` y `maquina` con valor real). El `git fetch` del bloque de 0bis y un `git status` sin `GIT_OPTIONAL_LOCKS=0`, corridos desde el puente, dejaron `.git/index.lock` (dos veces) y `.git/objects/maintenance.lock`, movidos a `_archivo/20260924/git_locks/` (ERR-33-01). `/apertura` corrió después (`562cfd8`).

**4.2 Decisiones con contexto (DOC).** El titular pidió contexto y maquetas para decidir: página de decisiones publicada como artifact con cifras medidas y tres trayectorias dibujadas con cada regla. Decisiones D33-1 a D33-6 en `activa/decisiones/20260924_decision_regla_filas_y_publicacion_trayectorias.md`.

**4.3 Regla de filas del motor (D).** `base_valida(simce, excluir_marcadas = TRUE)` descarta filas con marca de la Agencia y con menos de `UMBRAL_EVALUADOS = 10` evaluados. En la base de la vista hay 0 filas bajo el umbral: la diferencia real son 2.008 filas marcadas en el país y 610 en los Servicios Locales (2,1% de sus evaluados). El referente pasa de 1.333 a 1.299 establecimientos (fuente: D14 y D11 de la batería, sesión 33). `excluir_marcadas = FALSE` reproduce la regla del mockup y solo lo usa D10. Nuevas D14 y D14c (control positivo).

**4.4 Cifras de las notas desde los datos (P).** `cifras_notas()` calcula 17 cifras de las notas y el generador las inserta en marcadores `__NOTA_<NOMBRE>__`, con detención si queda alguno. Con la regla anterior reproduce exactas 11 cifras del mockup; la mediana del movimiento anual (2,9) y la correlación con el país (0,53) no se reproducen con ninguna definición medida sobre el DATA del mockup, y quedan definidas en el código (con la regla vigente, 2,2 y 0,51). D11 comprueba referente, nube, filas marcadas, el ejemplo de Palena (literal) y la ausencia de marcadores. Commit `498981b`.

**4.5 Identidad visual del motor (UI).** La vista toma el encabezado, la paleta institucional, los componentes y la fuente del sistema del motor; sin tema oscuro ni gobCL incrustada (la plantilla pasa de 209 KB a 56 KB). Menú de vistas con «Trayectorias de los Servicios Locales» como tercera entrada activa (enlaces a `index.html` e `index.html#panorama`). La página se desplaza; la vista ocupa la pantalla bajo el menú fijo; el modo presentación oculta encabezado y menú. Aprobado por el titular en el navegador. Commit `3de223d`.

**4.6 Diez defectos de forma (UI).** (a) «mediciones» y singular; (b) coma decimal en los tres tooltips; (c) aviso en el plano y conteos del grupo elegido; (d) cifras en capa propia con halo y reubicación al borde si chocan (0 superposiciones en 1280, 1440 y 1920 px, contra 85 a 108 antes), recorte al plano; (e) referente sobre las burbujas y con prioridad de tooltip (9 de 9 años, contra 2); (f) relleno de burbuja a 0,88 (cifra blanca 5,01:1; gris secundario 5,13:1 sobre crema); (h) el SVG dibuja en píxeles reales (texto de 18 px de caja en 1366 y en 1920, contra 12 y 20), marcas de eje según el espacio y burbujas escaladas al alto del plano; (g) filas compactas desde nueve Servicios Locales y sombra de desplazamiento; (i) cada título de las notas unido a su primer párrafo y modal que abre arriba; (j) leyenda «Referente: municipales por traspasar» y la nube cuenta sus comunas desde los datos. La fila de título de la vista se eliminó y sus botones pasaron a la barra de controles (como en la pestaña Comparación). Mediciones antes/después por script en Chromium sin red (fuente: `capturas.py` y `reg.py` del asistente, sesión 33).

**4.7 Menús sin opciones vacías (UI).** Pedido del titular: las opciones de grupo y de nivel sin datos para la cohorte, la otra opción elegida y la cobertura se desactivan con «(sin datos)»; si la elegida queda sin datos, vuelve a «Todos los grupos» o al primer nivel con datos. 250 combinaciones elegibles recorridas, 0 planos vacíos, con control positivo (forzar el grupo alto en 2025 vuelve a «Todos los grupos»). Commit `1d6c4ce`, junto con 4.6.

**4.8 Lista de revisión en Safari (DOC).** `activa/50_revision_safari_trayectorias.md`: 14 puntos con estado a preparar y resultado esperado, más la verificación del md5 del HTML revisado.

**Registro de ejecución detallado:** sin log de Claude Code en esta sesión; las tres instrucciones cortas y sus reportes literales están en la conversación, y los commits `498981b`, `3de223d` y `1d6c4ce` los contienen.

## 5. Backlog acumulativo

En `50_documentacion/activa/backlog_acumulativo.md`. Esta sesión agrega 5 entradas.

## 6. Bugs de la sesión

**B33-1: tooltip mal ubicado cuando la caja del gráfico cambia después de dibujar.** Síntoma: con el dibujo en píxeles reales, el tooltip del referente mostraba el de una burbuja vecina en varios años. Causa: `hover()` convertía el cursor con `ancho/W` y `alto/H`, válido solo si la caja del SVG seguía midiendo lo mismo que al dibujar; la leyenda y el contexto, que se reescriben después de `build()`, cambian esa caja y `preserveAspectRatio` desplazaba el dibujo (`36_trayectorias_template.html`, función `hover`). Solución: conversión con `getScreenCTM().inverse()` y `ResizeObserver` que redibuja si la caja cambia más de 2 px. Verificación: referente alcanzable en 9 de 9 años. **Patrón:** en un SVG interactivo, las coordenadas del cursor se convierten con la matriz del propio SVG, nunca con una proporción calculada al dibujar. Estado: resuelto.

## 7. Aprendizajes y restricciones descubiertas

1. **A33-1: `git status` desde el puente también escribe.** Refresca el índice y toma `.git/index.lock`, que el puente no puede borrar. Todo git del puente va con `GIT_OPTIONAL_LOCKS=0`, y solo en lectura. Ejemplo: ERR-33-01.
2. **A33-2: `device_commit_files` puede escribir una versión anterior si el nombre en `outputs/` ya se envió al chat.** Se usa un nombre nuevo por versión y se comprueba el md5 en la carpeta después de escribir. Ejemplo: la plantilla con el estilo quedó con el md5 viejo en el primer intento.
3. **A33-3: la Agencia no publica porcentajes por nivel bajo 10 evaluados.** En la base de la vista, el umbral del motor no descarta ninguna fila; lo que distingue las reglas son las marcas.
4. **A33-4: todas las comunas tienen año de traspaso.** Las 346 comunas del país pasan a un Servicio Local a más tardar en 2029 (catálogo de `slep_central_datos`); un referente «fuera del catálogo» son olas futuras, no municipales permanentes. Ejemplo: ERR-33-02.
5. **A33-5: las cifras de un texto metodológico se calculan, no se copian.** Una cifra literal queda obsoleta con cualquier cambio de regla o de año; la actualización Simce 2026 las habría desfasado todas.

## 8. Decisiones de diseño

- **D33-1: la vista usa la regla de filas del motor.** Alternativa descartada: mantener la diferencia declarada.
- **D33-2: la vista se publica en `docs/trayectorias.html`, enlazada como tercera entrada del menú del motor**, con el encabezado del motor y enlaces de vuelta. La instrucción ⚠️ de v32 se lee como «no incrustar la vista en el motor». Alternativas: página sin enlace, no publicar.
- **D33-3: la vista adopta la identidad visual del motor**, sin tema oscuro y con la fuente del sistema. Entrada del menú: «Trayectorias de los Servicios Locales».
- **D33-4: todos los sitios y proyectos del equipo migran a gobCL**; en este proyecto, motor y vista juntos, en un cambio propio.
- **D33-5: la revisión en Safari va después de corregir la forma.**
- **D33-6: las cifras de las notas se calculan desde los datos.**
- **D33-7 (del asistente, informada): se quita la fila de título de la vista** y sus botones van a la barra de controles, para dar alto al plano a 1366×768.

Todas en `activa/decisiones/20260924_decision_regla_filas_y_publicacion_trayectorias.md` salvo D33-7, que vive en este traspaso y en el comentario de la plantilla.

## 9. Constantes y parámetros

| Constante | Antes | Después | Archivo | Motivo |
|---|---|---|---|---|
| `UMBRAL_EVALUADOS` | no existía | `10` | `36_funciones_trayectorias.R` | regla del motor (D33-1) |
| `NP_NOTAS`, `UMBRAL_COMPOSICION` | no existían | `"4b_lect"`, `0.20` | idem | cifras de las notas (D33-6) |
| `PREFIJO_NOTA`, `PATRON_NOTA` | no existían | `"__NOTA_"`, `"__NOTA_[A-Z_]+__"` | `36_generar_trayectorias.R` | marcadores de notas |
| `LLENO_OPAC` | `.70` literal | `.88` | `36_trayectorias_template.html` | contraste (defecto f) |
| `REF_NUCLEO` | no existía | `10` px | idem | prioridad del tooltip del referente |
| `K`, `ALTO_PLANO_REF`, `ESCALA_MIN` | no existían | escala de burbujas, `420`, `.5` | idem | burbujas en planos bajos |
| `TICK_MIN_PX`, `PASOS` | no existían | `{x:46,y:24}`, `[5,10,20,25,50,100]` | idem | marcas de eje en píxeles |
| `FILAS_COMPACTAS` | no existía | `8` | idem | tabla densa (defecto g) |
| `ANGULOS`, `ANILLOS` | no existían | 8 ángulos, `3` | idem | reubicación de cifras (defecto d) |
| `SIN_DATOS`, `GSE_TOTAL_VISTA` | no existían | `" (sin datos)"`, `"T"` | idem | menús sin opciones vacías |

Fuente canónica de las vigentes: los scripts y la plantilla del paso 36.

## 10. Arquitectura de archivos

Sin cambios de estructura. Nuevos: `activa/decisiones/20260924_decision_regla_filas_y_publicacion_trayectorias.md`, `activa/50_revision_safari_trayectorias.md` y `andamios/logs/20260924_sesion33_errores_asistente.md`. Fuera de git: `_archivo/20260924/git_locks/` (tres candados movidos). Escáner regenerado por el ejecutor al cierre.

## 11. Pendientes y ruta sugerida

**Inventario.**

1. **Revisión en Safari sin red de la vista.** Tipo: verificación. Contexto: `activa/50_revision_safari_trayectorias.md`, 14 puntos, versión md5 `ebee5acf…`. Criterio de éxito: 14 de 14, o cada falla convertida en un defecto con estado reproducible. Precondición del pendiente 2.
2. **Enlace desde el motor y publicación de la vista (D33-2).** Tipo: funcionalidad y despliegue. Contexto: tercera entrada del menú en `33_motor_template.html` como enlace fuera de la lista de pestañas; el motor lee `#panorama` para abrir esa pestaña; la salida local pasa a `40_salidas/trayectorias.html` (generador, `RUTA_HTML` de la batería, `.gitignore`); copia íntegra a `docs/trayectorias.html`; `publicacion_github_pages.md` declara dos archivos expuestos y el paso 36. Complejidad: media. Precaución: operación de efecto público, con compuerta de dudas previa; 🔒 `docs/index.html` por copia íntegra; el md5 del motor cambia y hay que medir que nada más se movió. Criterio de éxito: Pages sirve las dos páginas, los enlaces van y vuelven (incluido `#panorama`), 0 cargas por red en ambas y la batería en verde.
3. **Futuros traspasos (cohortes 2027 a 2029) y nuevo referente.** Tipo: decisión metodológica y funcionalidad. Contexto: `slep_central_datos/30_procesamiento/catalogo/dim_slep_comunas.csv` trae 70 Servicios Locales por comuna (13 con ingreso en 2027, 11 en 2028 y 13 en 2029); 1.293 de los 1.299 establecimientos del referente están en esas comunas (fuente: cruce en la sesión 33). Decisiones: nuevo referente (p. ej., educación pública del país, como en `slep_central_datos`), asignación de establecimientos a Servicios Locales futuros (municipales de la comuna) y dependencia de un catálogo de otro repositorio. Criterio de éxito: decisión registrada que reemplace D32-2, y cohortes futuras en la vista con la batería ampliada.
4. **Contraste de las cifras rescatadas del motor** (`#6BA0CE`, 2,78:1; v31). Criterio: ≥ 4,5:1 medido en el panorama y en las barras.
5. **Migración de motor y vista a gobCL (D33-4).** Criterio: los tres pesos incrustados en ambos, sin carga por red, con el aspecto aprobado por el titular.
6. **La vista desborda bajo ~680 px de ancho** (heredado del mockup). Criterio: sin desborde horizontal a 375 px.
7. **Columna vacía en las notas metodológicas del motor.** Heredado.
8. **El panorama del motor desborda bajo ~540 px.** Heredado.
9. **Dudas 2 y 3 de v31 y dudas 2, 3 y 5 de v30.** Heredadas, sin cambio.
10. **`V8` y `openssl` en `renv.lock`, suite standalone, `documentar.R` y `34_historico`.** Bloqueados por `suitedoc` sin remoto.
11. **Guarda `asegurar_locale_utf8()` ausente** y `10_validar_portabilidad.R` sin invocador. Heredados.
12. **Ramas locales sin publicar** (`gobernanza/v16`, `respaldo_normativos_20260824`, `respaldo_prerebase_20260824`). Heredado.
13. **`_archivo/auditoria_agregacion_comunal.R` versionado.** Heredado.
14. **Destino del contrato de contexto** (`feat/contrato-contexto`). Decisión del titular; no bloquea.
15. **Actualización anual Simce 2026.** Bloqueada por insumos; las notas de la vista ya no requieren edición manual.

**Cerrado en esta sesión:** v32 pendiente 1 (defectos de forma), pendiente 3 (publicación, decidida; la ejecución es el pendiente 2) y pendiente 4 (regla de filas).

**Deuda técnica.** El encabezado del sitio está copiado en la plantilla de la vista desde `Header()` del motor: si cambia uno, hay que cambiar el otro (comentario en la plantilla); candidato a un fragmento común insertado por los generadores cuando se haga el pendiente 2. `reemplazar_literal_tray` sigue duplicando `reemplazar_literal` de `33_generar_html.R`.

**Auditoría de cierre (5.6).** Datos crudos aislados: sí. Pipeline de cero: sí para el paso 36 (generador y batería en la estación); `00_build.R` completo no se corrió en esta sesión. Check por transformación crítica: sí (19 pruebas). Reproducible e idempotente: sí, md5 igual en dos corridas y dos plataformas. Constantes nombradas: sí (tabla de §9). Nombres sin tildes: sí. Estructura conforme: **no** por `_archivo/auditoria_agregacion_comunal.R` → pendiente 13. Guarda de locale: **no** → pendiente 11.

### Compuerta de dudas (3 registradas)

| # | supuesto | predicado | medición |
|---|---|---|---|
| 1 | La vista corregida se ve y funciona en Safari de macOS, no solo en Chromium (incluidos `ResizeObserver`, `getScreenCTM` y las opciones desactivadas de `select`) | Los 14 puntos de `activa/50_revision_safari_trayectorias.md` pasan con el wifi apagado sobre el HTML de md5 `ebee5acf417f9aebaa46366c167588d7` | El titular recorre la lista en Safari y anota el resultado |
| 2 | La entrada de la lista de autorizados para el parquet de la rama no hace fallar I8 (duda 2 de v32: el log de cierres v32 no trae la salida de la compuerta de repositorio) | `95_verificar_cierre.R` da I8 en PASA en este cierre | La salida de I8 del verificador en el log o el eco de este cierre |
| 3 | El paso 36 produce el mismo HTML en otra estación (duda 3 de v32) | El md5 del HTML generado en la segunda estación es `ebee5acf417f9aebaa46366c167588d7` | `Rscript 30_procesamiento/36_generar_trayectorias.R` y `md5` del HTML en la segunda estación |

**Ruta sugerida.** Abrir con el resultado de Safari (pendiente 1). Si pasa, el enlace desde el motor y la publicación (pendiente 2), con la compuerta de dudas antes del push que publica. Diferir los futuros traspasos (pendiente 3) a una sesión propia que empiece por la decisión del referente.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 `cod_com_rbd` es la clave para agregar por comuna; nunca `nom_com_rbd`.
- 🔒 La segmentación por grupo socioeconómico de la vista de comparación es inviolable; el panorama combina porque es otra vista.
- 🔒 Color por nivel (`D-color-nivel`); `entity.color` nunca codifica el dato.
- 🔒 `docs/index.html` se actualiza por copia íntegra, jamás por edición.
- 🔒 El D3 minificado vendorizado no se toca, y tampoco React, ReactDOM ni Babel en `10_utils/`: el build verifica su sha384.
- 🔒 El motor no carga nada por red: `grep -c 'src="http' docs/index.html` = 0.
- 🔒 La escala del SVG del motor vive en `FS_SVG`; la de la interfaz en `--fs-*`; las medidas de las barras en `RECENT_DIMS`. Sin literales.
- 🔒 Una cifra va dentro de su franja solo si cabe; si no, baja bajo el año con la inicial del nivel.
- 🔒 Sin mayúsculas sostenidas en el texto salvo siglas.
- 🔒 El backlog conserva sus cinco secciones de POLITICA §10 y su detalle en `###`.
- 🔒 El grupo socioeconómico es atributo del par establecimiento-nivel.
- 🔒 La vista de trayectorias no depende de la red, y los períodos sin medición se dibujan como hueco.
- 🔒 La vista de trayectorias se edita en `30_procesamiento/36_trayectorias_template.html` y `36_funciones_trayectorias.R`; el mockup de `andamios/` queda congelado.
- 🔒 El referente y la nube son municipales fuera del catálogo con resultado en el primer año de la serie (D32-2), y son olas de traspaso posteriores a 2026, no municipales permanentes; los porcentajes se redondean en enteros con los empates hacia arriba (D32-3).
- 🔒 La vista usa la regla de filas del motor (D33-1) y las cifras de sus notas salen de `cifras_notas()` (D33-6): ninguna cifra literal nueva en las notas.
- 🔒 La vista no se incrusta en el motor: vive en su propio archivo y se enlaza desde el menú (D33-2).
- 🔒 Sin tema oscuro en la vista (D33-3).
- ✅ ANTES de entregar un archivo editado, cotejar su base contra `HEAD`.
- ✅ ANTES de dar por revisado algo visual, recorrer con una lista de forma cada estado afectado y cada exportación.
- ✅ ANTES de dar por buena una cifra de la vista de trayectorias, correr `Rscript 30_procesamiento/36_verificar_trayectorias.R` (19 pruebas, código 0).
- ✅ ANTES de enviar a Claude Code cualquier comando, incluso una verificación de una línea, correrlo en el entorno propio.
- ✅ ANTES de escribir un archivo a la carpeta con `device_commit_files`, usar un nombre nuevo en `outputs/`, y DESPUÉS medir su md5 en la carpeta.
- ✅ ANTES de afirmar algo sobre el futuro de un conjunto de establecimientos (traspaso, cierre), leer el catálogo que lo fija.
- ⚠️ NO correr ningún comando de git desde el puente sin `GIT_OPTIONAL_LOCKS=0`, y ninguno que escriba (commit, fetch, `restore`, `rm --cached`).
- ⚠️ NO publicar la vista sin la revisión de Safari aprobada.
- ⚠️ NO escribir en un encargo un comando que no se corrió antes.
- ⚠️ NO expresar criterios como cantidad de líneas de `diff`, de `status` ni de commits, ni como un conteo medido en otra plataforma.
- ⚠️ NO entregar archivos al chat entre la medición del estado de un encargo y su ejecución.

## 13. Fragmentos de código de referencia

```r
# 36_funciones_trayectorias.R: regla de filas del motor (D33-1).
if (excluir_marcadas) {
  base <- base |> dplyr::filter(is.na(marca), nalu >= UMBRAL_EVALUADOS)
}
```

```javascript
// 36_trayectorias_template.html: cursor a coordenadas del dibujo (B33-1).
var pt = P.svg.createSVGPoint(); pt.x = ev.clientX; pt.y = ev.clientY;
var loc = pt.matrixTransform(P.svg.getScreenCTM().inverse());
```

Los patrones estables siguen en los scripts del paso 36 y en `33_generar_html.R`.

## 14. Reapertura

Tipo de sesión: CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`) vive en la knowledge base del Project y se lee desde ahí; no se adjunta.

**Se adjuntan:** `traspaso_cierre_v33.md` y el resultado de `50_documentacion/activa/50_revision_safari_trayectorias.md` (los 14 puntos marcados, o la lista de los que fallaron). La plantilla y `33_motor_template.html` están en el repositorio y se leen desde la carpeta conectada. El backlog y el escáner no se adjuntan.

**Estado:** `main` en `1d6c4ce`, previo al commit de cierre. Vista de trayectorias con la regla del motor, su identidad visual y sin los defectos catalogados; batería en 19 de 19; motor sin cambios; nada publicado de la vista.

**Foco propuesto:** con la revisión de Safari aprobada, el enlace desde el motor y la publicación de la vista (pendiente 2), con la compuerta de dudas antes de publicar.

Si alguno de los archivos listados cambió entre sesiones, adjuntar la versión más actualizada al abrir y avisarlo en el mensaje de apertura.

## 15. Errores del asistente

Dos errores, registrados en el momento en que ocurrieron en `50_documentacion/andamios/logs/20260924_sesion33_errores_asistente.md`; se vuelcan con los diez campos de §2.2.15.

**ERR-33-01**
- `momento`: Fase A, medición a mano del candado 0bis antes de que corriera `/apertura` (primer turno de la sesión).
- `disparador`: asistente lo señaló espontáneamente (advertencias `unable to unlink` de `.git/objects/maintenance.lock` y `.git/index.lock` en la salida del puente).
- `que_paso`: corrí `git fetch` desde el puente siguiendo el bloque de 0bis de SETTINGS §1.2.2, y después un `git status` sin `GIT_OPTIONAL_LOCKS=0`; ambos crearon candados en `.git/` que el puente no puede borrar, y quedaron en la estación.
- `regla_violada`: traspaso v32 §12 (⚠️ NO correr ningún comando de git que escriba desde el puente de Cowork) y aviso 9 del mensaje de apertura de la sesión 33.
- `causa_raiz`: apliqué literal el bloque de 0bis como fallback sin propagarle la restricción del traspaso sobre el puente; además traté `git status` como lectura pura, sin medir que refresca el índice y toma `index.lock`.
- `salvaguarda_presente`: traspaso v32 §12, mensaje de apertura (aviso 9), ERR-32-04.
- `patron`: PAT-07, restricción leída no propagada al procedimiento de fallback de 0bis.
- `gatillo_observable`: restriccion-no-propagada: un bloque de comandos con `git fetch` a punto de correrse por el puente en una sesión cuyo traspaso prohíbe git que escriba desde el puente.
- `intentos_previos`: 0.
- `costo`: tres candados huérfanos movidos a `_archivo/20260924/git_locks/`; sin moverlos, `/apertura` habría fallado. Ningún cambio en el historial.

**ERR-33-02**
- `momento`: respuesta a la pregunta del titular sobre la cifra del referente y propuesta del nombre de la leyenda (defecto j).
- `disparador`: asistente lo señaló espontáneamente, al leer `dim_slep_comunas.csv` de `slep_central_datos` por el pedido de futuros traspasos.
- `que_paso`: afirmé que el referente son municipales «nunca traspasados» y propuse rotularlo así; 1.293 de sus 1.299 establecimientos están en comunas que se traspasan entre 2027 y 2029, y las 346 comunas del país tienen año de traspaso.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente en línea (premisa de hecho sin fuente leída en la sesión), y POLITICA 0.6.
- `causa_raiz`: deduje «nunca» de la definición del conjunto (fuera del catálogo de 36 Servicios Locales) sin medir qué pasa con esas comunas después de 2026; traté el catálogo del proyecto, que termina en la ola 2026, como el universo completo.
- `salvaguarda_presente`: SETTINGS §1.2.6 y POLITICA 0.6.
- `patron`: PAT-01, afirmación de dominio emitida sin fuente primaria.
- `gatillo_observable`: afirmar-sin-leer: un rótulo público que afirma un hecho futuro no medido en ningún insumo leído.
- `intentos_previos`: 0.
- `costo`: un rótulo falso aprobado por el titular sobre una explicación incorrecta; corregido antes del commit del bloque, sin nada publicado.

**Reincidencia.** PAT-07 (restricción no propagada) aparece por segunda sesión seguida (ERR-32-01, ERR-33-01). Clasificación §2.2.16: condición ambigua, porque el bloque de 0bis de SETTINGS no distingue si corre en Claude Code o desde el puente. La propuesta es un condicional en ese bloque: «si se ejecuta desde el puente de Cowork, solo lectura y con `GIT_OPTIONAL_LOCKS=0`; sin `fetch` ni `pull`».

### Fricciones

- `friccion: «necesito más contexto para tus preguntas y mockups» → las decisiones se presentan con una página de contexto, cifras medidas y maquetas, no como opciones sueltas.`
- `friccion: «qué es "regenera"?» → se evita jerga del pipeline sin explicarla en una línea.`
- `friccion: «dame los comandos … terminal o positron» → toda instrucción al titular dice dónde se corre.`
- `friccion: «lo dejaste en la carpeta?» → al entregar un archivo en la carpeta se dice la ruta y que ya está escrito, con su comprobación.`
