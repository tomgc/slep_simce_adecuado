# Traspaso de cierre v34 — slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`, motor de comparación interactivo de resultados Simce por estándares de aprendizaje.
- **Versión del traspaso:** v34. **Fecha:** 2026-09-24. **Sesión:** 34.
- **Foco:** publicación de la vista de trayectorias como tercera entrada del menú del motor (pendiente 2 de v33), más tres cambios que la sesión fue habilitando: guarda de locale UTF-8, encabezado y menú desde un fragmento común, y contraste de las cifras rescatadas del motor.
- **Entorno:** Cowork con puente a la estación macOS (lectura y edición de archivos; git solo en lectura con `GIT_OPTIONAL_LOCKS=0`); R 4.3.3, arrow 25.0.1, V8 y Chromium sin red en el contenedor del asistente, sobre una réplica parcial del árbol; commits, generación en la estación y push delegados a Claude Code. Lectura de `herramientas_dev/plantillas/` autorizada por el titular.
- **Normativos usados:** `POLITICA_PROYECTO.md` con encabezado `**Versión 5.8 — vigente.**` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` con encabezado `**Versión 38.**`, desde la knowledge base; iguales a las copias de `activa/` según el eco de `/apertura`.
- **`main` previo al commit de cierre:** `50323ab` (diez commits de la sesión sobre `e4dd005`, todos publicados).
- **Archivos principales creados o modificados:** `30_procesamiento/33_motor_template.html`, `33_generar_html.R`, `36_trayectorias_template.html`, `36_generar_trayectorias.R`, `33_fragmento_sitio.html` (nuevo); `10_utils/10_locale.R`, `10_configuracion.R` y `10_html.R` (nuevos); `00_build.R` y los ocho scripts ejecutables de `30_procesamiento/` (una línea); `docs/index.html` y `docs/trayectorias.html` (nuevo); `50_documentacion/activa/publicacion_github_pages.md`, `50_locale_utf8.md`, `50_revision_safari_trayectorias.md`; `50_documentacion/andamios/logs/20260924_sesion34_errores_asistente.md` (nuevo).

## 2. Resumen ejecutivo

La sesión abrió con el eco de `/apertura` (candado 5/5) y con la revisión de Safari de la vista aprobada por el titular (14 de 14), que quedó registrada en su lista. El motor ganó la tercera entrada del menú y lee `#panorama`, y la vista se publicó en `docs/trayectorias.html` (`cc7fd64`); Pages sirve las dos páginas y los enlaces van y vuelven en Safari. Una regeneración del motor en locale C destapó texto escapado en el JSON, y con eso el titular eligió instalar la guarda de locale en un `10_configuracion.R` canónico (`8b919df`, V1-V4 del verificador del kit en OK y vista fallar). El encabezado y el menú, copiados entre las dos plantillas, pasaron a un fragmento común que los generadores insertan, con 0 píxeles distintos de 768 a 1920 px frente a lo publicado (`a095a50`). Las cifras de Elemental rescatadas bajo el año pasaron de 2,78:1 a 4,95:1 (`50323ab`). Una pregunta del titular sobre el conteo del referente se investigó: el grupo es fijo y el número cambia por la publicación de resultados, no por traspasos; el rótulo y un eventual referente dinámico quedan para la sesión de futuros traspasos. `00_build.R` completo reproduce byte a byte lo publicado.

## 3. Estado al cierre

**Qué funciona.**

- Sitio publicado: motor y vista de trayectorias con encabezado y menú comunes; enlaces, `#panorama`, recarga y Atrás en 8 de 8 estados, 0 cargas por red y 0 errores (fuente: `prueba_enlaces2.py` del asistente sobre los archivos de la estación, sesión 34); Safari sobre Pages, 4 de 4 (revisión del titular, sesión 34).
- `Rscript 00_build.R`: código 0 y sus dos HTML idénticos byte a byte a `docs/` (`8deb04595510b0f15da8bb65813b7a38` y `267857a2962602bd9e6c5cc56effcb47`) (fuente: reporte de Claude Code, sesión 34).
- `Rscript 30_procesamiento/36_verificar_trayectorias.R`: 19 de 19, código 0 (fuente: reporte de Claude Code, sesión 34).
- Guarda de locale: `90_verificar_locale.R` del kit con V1-V4 en OK en la estación (V3 corrige `LANG=C` a es_ES.UTF-8) (fuente: reporte de Claude Code, sesión 34).
- Exportaciones del motor (SVG y PNG de barras; SVG, PNG y CSV del panorama) sin errores, con la tinta nueva (fuente: `export.py` del asistente, sesión 34).

**Qué no funciona o queda a medias.**

- La vista desborda bajo ~680 px y el panorama del motor bajo ~540 px (heredados).
- Con pocos evaluados, las cifras rescatadas llevan opacidad 0,7 y bajan de 4,5:1 (Adecuado 4,25:1; Elemental cerca de 2,8:1) (fuente: mezcla calculada por el asistente, sesión 34).
- `V8` y `openssl` siguen fuera de `renv.lock` (Claude Code muestra el aviso de `renv` desincronizado en cada corrida).

**Delta respecto de v33.** La vista está publicada y enlazada; el encabezado y el menú tienen una sola fuente; el proyecto tiene guarda de locale; el motor cambió de forma (menú estático, tinta de Elemental) sin cambiar ningún dato.

## 4. Registro detallado de cambios

**4.1 Apertura (REPO).** Eco de `/apertura`: candado 5/5, `HEAD` `8260a8a` igual a `origin/HEAD`, normativos al día, instrumento de cierre `cierre_sesion_autonomo_cc_v15.md`. Sin apertura de emergencia.

**4.2 Revisión de Safari registrada (DOC).** El titular aprobó 14 de 14 sobre el HTML `ebee5acf…`; se marcó la columna «Resultado» y la sección «Resultado global» de `activa/50_revision_safari_trayectorias.md` (versión de Safari no informada). Commit `f47374c`.

**4.3 Enlace desde el motor y publicación de la vista (REPO, UI).** En la plantilla del motor, la tercera entrada del menú como enlace a `trayectorias.html`, fuera del `tablist`, con `@media (max-width: 640px)` igual al de la vista; la vista inicial se lee de `#panorama` y escucha `hashchange`. `publicacion_github_pages.md` declara dos archivos expuestos, el paso 36, la batería y la validación de los enlaces. La salida local de la vista conserva su nombre y se copia a `docs/trayectorias.html` (D34-5). Verificación: réplica y estación con el mismo contenido (JSON igual salvo la fecha y el resto del HTML igual), 8 de 8 estados de enlaces, alturas iguales a lo publicado de 1280 a 1920 px. Commits `f47374c` y `cc7fd64`. Resuelve el pendiente 2 de v33.

**4.4 Guarda de locale UTF-8 (Infra).** Con R en locale C, el motor escribió «Educaci<c3><b3>n P<c3><ba>blica» en el JSON, sin error ni prueba que fallara (fuente: `cmp_motor.py`, sesión 34). El titular eligió la opción A (D34-1): `10_utils/10_locale.R` copiado idéntico del kit (md5 `dc900c1b0d2d252c9e5730875be5d632`) y `10_utils/10_configuracion.R` nuevo, con la guarda como primera línea ejecutable, invocado por `00_build.R` y por los ocho scripts ejecutables de `30_procesamiento/` en la línea siguiente a `library(here)`. Verificación: V1-V4 en OK en la réplica y en la estación; con la llamada comentada, V2-V4 fallan; `33` bajo `LANG=C` da el JSON correcto; `50_locale_utf8.md` gana la sección 5. Commit `8b919df`. Resuelve la guarda del pendiente 11 de v33.

**4.5 Fragmento común del encabezado y del menú (DT).** `30_procesamiento/33_fragmento_sitio.html` es la fuente única del estilo, el texto y los enlaces; `insertar_sitio()` de `10_utils/10_html.R` lo inserta en `/*__SITIO_CSS__*/` y `<!--__SITIO_HTML__-->` de cada plantilla, con los enlaces y la entrada activa de cada página, y se detiene si falta o sobra un marcador. `10_html.R` también reúne `reemplazar_literal()`, que ya no se duplica en el paso 36. En el motor, encabezado y menú salen de React y son marcado estático; las pestañas son enlaces `#comparacion` y `#panorama`, y un efecto marca la entrada activa (D34-2). Verificación: 0 píxeles distintos frente a lo publicado en las tres páginas de 768 a 1920 px; a 375 px el motor es 94 px más bajo porque toma el margen del encabezado de la vista; 8 de 8 estados de enlaces; el botón Atrás ahora recorre las vistas del motor. Commits `b919acf` y `a095a50`. Resuelve la deuda técnica de v33.

**4.6 Contraste de las cifras rescatadas (UI).** `TINTA_ELEM = "#3874A9"` y `tintaNivel()` en la plantilla del motor: las cifras de Elemental escritas bajo el año pasan de 2,78:1 a 4,95:1 sobre la celda blanca, y siguen más claras que las de Adecuado (9,48:1); las franjas conservan el color del nivel (D34-3). Verificación: 4 de 4 y 2 de 2 cifras de Elemental en dos estados apilados, 0 píxeles distintos en el resto del sitio, SVG exportado con la tinta nueva. Commits `07b860c` y `50323ab`. Resuelve el pendiente 4 de v33.

**4.7 Conteo del referente (D).** Pregunta del titular: por qué el número del referente sube y baja en vez de disminuir. El grupo es fijo: 1.299 municipales fuera del catálogo con resultado en 2014, que se traspasan entre 2027 y 2029; dentro de la serie solo pierde por cierres (de 1.299 a 1.282 presentes en el Simce). El número de la leyenda es el de los que tienen resultado válido ese año en el nivel elegido; en 4° básico Lectura varía entre 994 y 1.124 por cifras no publicadas o suprimidas por la Agencia (9 a 117 por año), marcas (0 a 16) y ausencia del nivel (166 a 177); 2014 sale inflado por construcción (fuente: `ref.R` y `ref2.R` del asistente sobre `simce_rbd.parquet`, sesión 34). El titular decidió no tocar el referente ni su rótulo en esta sesión (D34-4).

**4.8 Compuerta de dudas previa al cierre.** La duda «`00_build.R` completo corre con la guarda y el fragmento» se cerró: código 0 en 6 segundos y salidas idénticas a `docs/`.

**Registro de ejecución detallado:** sin log de Claude Code; las instrucciones cortas y sus reportes literales están en la conversación, y los commits `f47374c`, `cc7fd64`, `8b919df`, `b919acf`, `a095a50`, `07b860c` y `50323ab` los contienen.

## 5. Backlog acumulativo

En `50_documentacion/activa/backlog_acumulativo.md`. Esta sesión agrega 6 entradas.

## 6. Bugs de la sesión

Sin bugs de código en esta sesión. El texto escapado de 4.4 ocurrió en una regeneración del asistente en locale C; ningún archivo publicado lo trajo.

## 7. Aprendizajes y restricciones descubiertas

1. **A34-1: el md5 del motor no sirve para comparar entre plataformas ni entre días.** El HTML incrusta `fecha_generacion` y el JSON comprimido con gzip, que difiere entre zlib de macOS y de Linux con el mismo contenido. El criterio es el contenido: JSON sin la fecha y resto del HTML iguales. Ejemplo: réplica `f1e6aaa1…` y estación `32492074…` con contenido idéntico. La vista de trayectorias sí es reproducible por md5 entre plataformas.
2. **A34-2: un proceso R en locale C corrompe el JSON del motor sin avisar.** POLITICA 5.2bis dejó de ser teórica en este proyecto: todo script ejecutable nuevo carga `10_configuracion.R` después de `library(here)`.
3. **A34-3: `grep -c` sale con código 1 cuando cuenta 0.** En una cadena con `&&`, un conteo esperado de 0 detiene la cadena; esas comprobaciones van en líneas propias.
4. **A34-4: en el motor, la vista la fija la dirección.** Las pestañas son enlaces con `#`, así que recargar o copiar el enlace conserva la vista y el botón Atrás recorre las vistas. Un botón que cambie de vista sin cambiar la dirección rompe esa regla.
5. **A34-5: el número del referente en la leyenda no es el tamaño del grupo.** Es el conteo con resultado publicable en ese año y nivel; baja y sube con la supresión de establecimientos pequeños. Ejemplo: 4.7.

## 8. Decisiones de diseño

- **D34-1 (titular): la guarda de locale vive en `10_utils/10_configuracion.R` canónico**, invocado por `00_build.R` y por cada script ejecutable. Alternativas descartadas: guarda en `10_utils.R` (no cubría 33 ni 36, V2 fallaba) y solo `LANG` en `.Renviron` (sin aborto). Registrada en `50_locale_utf8.md` §5.
- **D34-2 (asistente, informada): encabezado y menú desde `33_fragmento_sitio.html`**, insertado por los dos generadores; en el motor, marcado estático fuera de React con pestañas como enlaces `#comparacion` y `#panorama`. Alternativa descartada: compartir solo el CSS y mantener el JSX (la duplicación del texto seguía).
- **D34-3 (asistente, informada): tinta propia para las cifras de Elemental escritas como texto** (`#3874A9`, mismo tono y más oscuro); las franjas no cambian (D-color-nivel).
- **D34-4 (titular): el referente no cambia en esta sesión.** El rótulo con el tamaño del grupo y un eventual referente dinámico se deciden con los futuros traspasos, sin tocar lo que muestra la vista sobre aprendizaje.
- **D34-5 (asistente, informada): la salida local de la vista conserva el nombre `trayectorias_traspasos.html`** y se copia a `docs/trayectorias.html`, igual que `motor_comparacion.html` → `docs/index.html`; el generador, `RUTA_HTML` y `.gitignore` no cambian.

Todas viven en este traspaso; D34-1 también en `50_locale_utf8.md` y D34-2 en los comentarios del fragmento y de las plantillas.

## 9. Constantes y parámetros

| Constante | Antes | Después | Archivo | Motivo |
|---|---|---|---|---|
| `TINTA_ELEM`, `tintaNivel()` | no existían | `"#3874A9"` | `33_motor_template.html` | contraste (D34-3) |
| `RUTA_FRAGMENTO_SITIO` | no existía | `30_procesamiento/33_fragmento_sitio.html` | `10_utils/10_html.R` | fuente única (D34-2) |
| `MARCADOR_SITIO_CSS`, `MARCADOR_SITIO_HTML` | no existían | `"/*__SITIO_CSS__*/"`, `"<!--__SITIO_HTML__-->"` | idem | marcadores de inserción |
| `PATRON_SITIO_RESTO` | no existía | `"__SITIO_[A-Z]+__|__HREF_[A-Z]+__"` | idem | detención si queda un marcador |
| `SITIO_PAGINAS` | no existía | motor: `#comparacion`, `#panorama`; trayectorias: `index.html`, `index.html#panorama` | idem | enlaces por página |
| `LOCALES_UTF8_CANDIDATAS` | no existía en el proyecto | la del kit | `10_utils/10_locale.R` (copia, no se edita) | D34-1 |

Fuente canónica de las vigentes: las plantillas y los scripts de los pasos 33 y 36, y `10_utils/`.

## 10. Arquitectura de archivos

Nuevos: `10_utils/10_locale.R`, `10_utils/10_configuracion.R`, `10_utils/10_html.R`, `30_procesamiento/33_fragmento_sitio.html`, `docs/trayectorias.html` y `andamios/logs/20260924_sesion34_errores_asistente.md`. Sin carpetas nuevas. Escáner regenerado por el ejecutor al cierre.

## 11. Pendientes y ruta sugerida

**Inventario.**

1. **Futuros traspasos (cohortes 2027 a 2029), nuevo referente y su rótulo.** Tipo: decisión metodológica y funcionalidad. Contexto: pendiente 3 de v33 (70 Servicios Locales por comuna en `slep_central_datos/30_procesamiento/catalogo/dim_slep_comunas.csv`) más la pregunta de la sesión 34: el titular espera un referente que disminuya con cada ola; hoy es un grupo fijo (4.7, A34-5). Opciones planteadas: (A) grupo fijo con rótulo que diga su tamaño y los que tienen resultado ese año; (B) referente dinámico de municipales aún no traspasados, que cambia de composición cada año. Precaución: la decisión no debe distorsionar lo que la vista muestra sobre aprendizaje (D34-4). Complejidad: alta. Criterio de éxito: decisión registrada que reemplace D32-2, con el rótulo resuelto y la batería ampliada.
2. **Opacidad 0,7 de las cifras rescatadas con pocos evaluados.** Tipo: mejora visual con decisión de diseño. Contexto: Adecuado baja a 4,25:1 y Elemental a cerca de 2,8:1; la atenuación es una señal intencional. Criterio: ≥ 4,5:1 medido con la señal de pocos evaluados conservada por otro medio, o decisión registrada de mantenerla.
3. **Migración de motor y vista a gobCL (D33-4).** Tipo: mejora visual. Ahora el encabezado y el menú se cambian en un solo archivo. Criterio: tres pesos incrustados en ambos, sin carga por red, aspecto aprobado por el titular.
4. **La vista desborda bajo ~680 px.** Heredado. Criterio: sin desborde horizontal a 375 px.
5. **Columna vacía en las notas metodológicas del motor.** Heredado.
6. **El panorama del motor desborda bajo ~540 px.** Heredado.
7. **Dudas 2 y 3 de v31 y dudas 2, 3 y 5 de v30.** Heredadas, sin cambio.
8. **`V8` y `openssl` en `renv.lock`, suite standalone, `documentar.R` y `34_historico`.** Bloqueados por `suitedoc` sin remoto.
9. **`10_validar_portabilidad.R` sin invocador.** Heredado (la guarda ya está instalada).
10. **Ramas locales sin publicar** (`gobernanza/v16`, `respaldo_normativos_20260824`, `respaldo_prerebase_20260824`). Heredado.
11. **`_archivo/auditoria_agregacion_comunal.R` versionado.** Heredado.
12. **Destino del contrato de contexto** (`feat/contrato-contexto`). Decisión del titular; no bloquea.
13. **Actualización anual Simce 2026.** Bloqueada por insumos.

**Cerrado en esta sesión:** pendientes 1, 2 y 4 de v33, la guarda del pendiente 11 de v33 y la deuda técnica de v33 (encabezado copiado y `reemplazar_literal_tray`).

**Deuda técnica.** `34_historico_pct_adecuado_costa_central.R` ganó la línea de la guarda pero no se corrió en la sesión (bloqueado por `suitedoc`). En el motor quedan reglas CSS sin uso de la cabecera antigua (`.app-header-right`, `.brand-*`), que no se tocaron.

**Auditoría de cierre (5.6).** Datos crudos aislados: sí. Pipeline de cero: sí, `00_build.R` completo en la estación con salidas idénticas a `docs/`. Check por transformación crítica: sí (19 pruebas; `insertar_sitio()` se detiene ante marcadores faltantes o sobrantes). Reproducible e idempotente: sí (build igual byte a byte a lo publicado; la vista con el mismo md5 en dos plataformas). Constantes nombradas: sí (§9). Nombres sin tildes: sí. Estructura conforme: **no** por `_archivo/auditoria_agregacion_comunal.R` → pendiente 11. Guarda de locale: **sí**, instalada, verificada con V1-V4 y vista fallar.

### Compuerta de dudas (2 registradas)

| # | supuesto | predicado | medición |
|---|---|---|---|
| 1 | El paso 36 produce el mismo HTML en otra estación (duda 3 de v33) | El md5 del HTML generado en la segunda estación es `267857a2962602bd9e6c5cc56effcb47` | `Rscript 30_procesamiento/36_generar_trayectorias.R` y `md5` del HTML en la segunda estación |
| 2 | La entrada de la lista de autorizados para el parquet de la rama no hace fallar I8 (duda 2 de v33) | `95_verificar_cierre.R` da I8 en PASA en este cierre | La salida de I8 del verificador en el log o el eco de este cierre |

**Ruta sugerida.** Abrir con la decisión del referente (pendiente 1), en una sesión que empiece por esa decisión con contexto y maquetas, como la sesión 33. Si el titular prefiere algo de forma, gobCL (pendiente 3), que ahora toca un solo archivo para el encabezado. Diferir los desbordes en pantallas angostas (4 y 6).

## 12. Instrucciones específicas para la próxima sesión

- 🔒 `cod_com_rbd` es la clave para agregar por comuna; nunca `nom_com_rbd`.
- 🔒 La segmentación por grupo socioeconómico de la vista de comparación es inviolable; el panorama combina porque es otra vista.
- 🔒 Color por nivel (`D-color-nivel`); `entity.color` nunca codifica el dato. El texto de una cifra puede usar la tinta del nivel (`tintaNivel()`), nunca otro color.
- 🔒 `docs/index.html` y `docs/trayectorias.html` se actualizan por copia íntegra, jamás por edición.
- 🔒 El D3 minificado vendorizado no se toca, y tampoco React, ReactDOM ni Babel en `10_utils/`: el build verifica su sha384.
- 🔒 El sitio no carga nada por red: `grep -c 'src="http'` da 0 en los dos archivos de `docs/`.
- 🔒 La escala del SVG del motor vive en `FS_SVG`; la de la interfaz en `--fs-*`; las medidas de las barras en `RECENT_DIMS`. Sin literales.
- 🔒 Una cifra va dentro de su franja solo si cabe; si no, baja bajo el año con la inicial del nivel.
- 🔒 Sin mayúsculas sostenidas en el texto salvo siglas.
- 🔒 El backlog conserva sus cinco secciones de POLITICA §10 y su detalle en `###`.
- 🔒 El grupo socioeconómico es atributo del par establecimiento-nivel.
- 🔒 La vista de trayectorias no depende de la red, y los períodos sin medición se dibujan como hueco.
- 🔒 La vista de trayectorias se edita en `36_trayectorias_template.html` y `36_funciones_trayectorias.R`; el mockup de `andamios/` queda congelado.
- 🔒 El referente y la nube son municipales fuera del catálogo con resultado en el primer año de la serie (D32-2), olas de traspaso posteriores a 2026; no se cambian sin la decisión del pendiente 1 (D34-4). Los porcentajes se redondean en enteros con los empates hacia arriba (D32-3).
- 🔒 La vista usa la regla de filas del motor (D33-1) y las cifras de sus notas salen de `cifras_notas()` (D33-6).
- 🔒 La vista no se incrusta en el motor: vive en su propio archivo y se enlaza desde el menú (D33-2). Sin tema oscuro en la vista (D33-3).
- 🔒 El encabezado y el menú del sitio se editan solo en `30_procesamiento/33_fragmento_sitio.html` (D34-2); en el motor, la vista la fija la dirección (A34-4).
- 🔒 `asegurar_locale_utf8()` es la primera línea ejecutable de `10_utils/10_configuracion.R`, y `10_utils/10_locale.R` es copia idéntica del kit (D34-1).
- ✅ ANTES de crear un script ejecutable nuevo, cargar `10_configuracion.R` en la línea siguiente a `library(here)`.
- ✅ ANTES de dar por bueno un motor regenerado en otra plataforma o en otro día, comparar contenido (JSON sin la fecha y resto del HTML), no md5 (A34-1).
- ✅ ANTES de entregar un archivo editado, cotejar su base contra `HEAD`.
- ✅ ANTES de dar por revisado algo visual, recorrer con una lista de forma cada estado afectado y cada exportación.
- ✅ ANTES de dar por buena una cifra de la vista de trayectorias, correr `Rscript 30_procesamiento/36_verificar_trayectorias.R` (19 pruebas, código 0).
- ✅ ANTES de enviar a Claude Code cualquier comando, correrlo en el entorno propio, y declarar en la instrucción qué archivos editó el asistente, con su md5 (ERR-34-01).
- ✅ ANTES de escribir un archivo a la carpeta con `device_commit_files`, usar un nombre nuevo en `outputs/`, y DESPUÉS medir su md5 en la carpeta.
- ✅ ANTES de afirmar algo sobre el futuro de un conjunto de establecimientos (traspaso, cierre), leer el catálogo que lo fija.
- ⚠️ NO entregar la instrucción de push en el mismo mensaje que la medición que la condiciona: primero el resultado de la compuerta, después el push (ERR-34-02).
- ⚠️ NO correr ningún comando de git desde el puente sin `GIT_OPTIONAL_LOCKS=0`, y ninguno que escriba (commit, fetch, `restore`, `rm --cached`).
- ⚠️ NO escribir en un encargo un comando que no se corrió antes.
- ⚠️ NO expresar criterios como cantidad de líneas de `diff`, de `status` ni de commits, ni como un conteo medido en otra plataforma.
- ⚠️ NO entregar archivos al chat entre la medición del estado de un encargo y su ejecución.

## 13. Fragmentos de código de referencia

```r
# 10_utils/10_html.R: encabezado y menú desde la fuente única (D34-2).
plantilla <- insertar_sitio(plantilla, "motor")          # 33_generar_html.R
html_tray <- insertar_sitio(plantilla_tray, "trayectorias")  # 36_generar_trayectorias.R
```

```javascript
// 33_motor_template.html: la vista la fija la dirección y el menú estático
// marca la entrada activa (A34-4).
React.useEffect(() => {
  document.querySelectorAll(".view-tab[data-vista]").forEach(a => {
    const activa = a.dataset.vista === vista;
    a.classList.toggle("is-active", activa);
    if (activa) a.setAttribute("aria-current", "page");
    else a.removeAttribute("aria-current");
  });
}, [vista]);
```

Los patrones estables siguen en los scripts de los pasos 33 y 36 y en `10_utils/`.

## 14. Reapertura

Tipo de sesión: CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`) vive en la knowledge base del Project y se lee desde ahí; no se adjunta.

**Se adjunta:** `traspaso_cierre_v34.md`. Las plantillas, los generadores y el fragmento del sitio están en el repositorio y se leen desde la carpeta conectada. El backlog y el escáner no se adjuntan.

**Estado:** `main` en `50323ab`, previo al commit de cierre. Vista de trayectorias publicada y enlazada desde el motor; encabezado y menú desde un fragmento común; guarda de locale instalada; contraste de Elemental corregido; `00_build.R` reproduce lo publicado byte a byte.

**Foco propuesto:** decisión del referente y de los futuros traspasos (pendiente 1), empezando por una página de contexto con cifras medidas y maquetas de las opciones A y B, sin cambiar lo que la vista muestra sobre aprendizaje hasta decidir.

Si alguno de los archivos listados cambió entre sesiones, adjuntar la versión más actualizada al abrir y avisarlo en el mensaje de apertura.

## 15. Errores del asistente

Dos errores, registrados en el momento en que se identificaron en `50_documentacion/andamios/logs/20260924_sesion34_errores_asistente.md`; se vuelcan con los diez campos de §2.2.15.

**ERR-34-01**
- `momento`: primera instrucción corta a Claude Code (regenerar el motor, batería, copia a `docs/`).
- `disparador`: usuario lo señaló sin nombrarlo error (Claude Code reportó dos archivos modificados sin autor conocido).
- `que_paso`: la instrucción no declaró que `33_motor_template.html` y `publicacion_github_pages.md` ya venían editados por el asistente en la carpeta, y el ejecutor tuvo que investigar su origen por la hora de modificación.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente en línea, tipo 4 (toda premisa de hecho de un encargo) y regla «Ningún comando asume el entorno».
- `causa_raiz`: traté el estado del árbol como contexto compartido porque lo había dicho en el chat al titular, sin llevarlo a la instrucción, que es lo único que el ejecutor lee.
- `salvaguarda_presente`: SETTINGS §1.2.6.
- `patron`: PAT-12, encargo sin la premisa de estado que el chat sí tenía.
- `gatillo_observable`: encargos-premisas: una instrucción a Claude Code que regenera desde archivos editados en la sesión sin nombrarlos ni dar su md5.
- `intentos_previos`: 0.
- `costo`: una verificación extra del ejecutor (`git diff --stat` y `ls -lT`); ningún archivo tocado de más.

**ERR-34-02**
- `momento`: compuertas de dudas previas a las dos publicaciones de la sesión (enlace de la vista, `cc7fd64`; fragmento común, `a095a50`).
- `disparador`: asistente lo señaló espontáneamente, al preparar el cierre.
- `que_paso`: entregué la instrucción de commit y push en el mismo mensaje que la comprobación de Safari que cerraba la duda 1, condicionada solo en prosa («si pasan»), y las dos veces el push corrió antes de que el resultado llegara al chat.
- `regla_violada`: SETTINGS §2.1, compuerta de dudas, gatillo 2 (antes de una operación de efecto público), y §1.2.6, «Generar, verificar, consumar: en ese orden».
- `causa_raiz`: optimicé turnos juntando medición y consumo en un solo mensaje; la condición quedó en una frase para el titular y no en la instrucción al ejecutor, que no puede evaluarla.
- `salvaguarda_presente`: SETTINGS §2.1 y §1.2.6.
- `patron`: PAT-02, consumo entregado antes de que llegara la verificación intermedia.
- `gatillo_observable`: costo-sobre-regla: un mensaje que contiene a la vez una medición pendiente del titular y la instrucción de push que depende de ella.
- `intentos_previos`: 1 (la segunda publicación repitió la forma de la primera).
- `costo`: dos publicaciones hechas antes de cerrar su duda; ambas verificadas después en Safari sobre Pages (4 de 4), sin cifra ni enlace erróneo publicado.

**Reincidencia.** PAT-07 no reaparece (el git del puente fue siempre de lectura con `GIT_OPTIONAL_LOCKS=0`). ERR-34-02 es de disciplina de orden y queda con su ⚠️ en §12.

### Fricciones

- `friccion: «dime paso a paso que necesitas» → los pedidos de verificación al titular van en pasos numerados, con dónde se hace y qué se debe ver en cada uno.`
