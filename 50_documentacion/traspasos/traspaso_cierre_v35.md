# Traspaso de cierre v35: slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`, motor de comparación interactivo de resultados Simce por estándares de aprendizaje, con la vista de trayectorias de los Servicios Locales.
- **Versión del traspaso:** v35. **Fecha:** 2026-09-26. **Sesión:** 35 (abierta el 2026-09-24).
- **Foco:** decisión del referente y de los futuros traspasos (pendiente 1 de v34) y, a partir de ella, el cierre de todos los pendientes heredados de v34, ejecutados en 16 encargos autónomos a Claude Code (fuente: `ls 50_documentacion/activa/encargos | grep -c s35`, sesión 35).
- **Entorno:** Cowork con puente a la estación macOS (lectura, edición y git solo de lectura con `GIT_OPTIONAL_LOCKS=0`); encargos ejecutados por Claude Code en la estación tras `/clear`, cada uno con FASE 0, FASE R y FASE L, y su log versionado.
- **Normativos usados:** `POLITICA_PROYECTO.md` con encabezado `**Versión 5.8 — vigente.**` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` con encabezado `**Versión 38.**` (fuente: `grep -m1 Versión` sobre las copias de `50_documentacion/activa/`, sesión 35); instrumento de encargos `encargo_autonomo_claude_code_v1.md` v1.6 (knowledge base).
- **`main` previo al commit de cierre:** `6944cc7` más el commit de D35-27 que el titular hace antes de `/cierre`; 119 commits de la sesión sobre `b8c8e1a` (fuente: `git log --oneline b8c8e1a..HEAD | wc -l`, sesión 35).
- **Archivos principales creados o modificados:** `30_procesamiento/33_motor_template.html`, `33_fragmento_sitio.html`, `36_trayectorias_template.html`, `36_funciones_trayectorias.R`, `36_generar_trayectorias.R`, `36_verificar_trayectorias.R`, `33_verificar_motor.R` (nuevo), `30_construir_auxiliares.R`, `31_leer_normalizar.R`, `32_agregar_comunal.R`; `10_utils/10_configuracion.R`, `10_html.R`, `10_utils.R`, `10_validar_portabilidad.R`; `00_build.R`; `20_insumos/auxiliares/dim_slep_comunas.csv` (nuevo); `docs/index.html`, `docs/trayectorias.html`; `renv.lock`, `renv/settings.json`; `README.md`, `NOTICE`, `.Renviron.example`; `50_documentacion/suite/`; `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` (nuevo, D35-1 a D35-27); 16 encargos en `activa/encargos/` y sus logs en `andamios/logs/`; `CLAUDE.md` local e ignorado (nuevo).

## 2. Resumen ejecutivo

La sesión abrió con el eco de `/apertura` y el pendiente 1 de v34. Con una página de contexto medida, el titular decidió mantener el referente anclado en 2014 con rótulo explícito y marca de ola (D35-1, contado por ola con el directorio en D35-4) y sumar a la vista las 37 unidades de las olas 2027 a 2029 con su itinerario previo al traspaso (D35-2). Desde ahí la sesión se organizó en olas de encargos autónomos, cada una evaluada leyendo su log, con las dudas del ejecutor decididas por el titular y registradas como D35-3 a D35-27. Se cerraron todos los pendientes de v34 salvo los que dependen de terceros: pantallas angostas en el motor y la vista, gobCL incrustada con NOTICE, contraste y marcas de cifras, sparkline con orden por valor, tooltip dentro de la ventana, centrado óptico, baterías del motor (8) y de la vista (35) con controles positivos, `renv.lock` completo sin `suitedoc`, ramas limpiadas, años y rangos derivados de los insumos, suite, README y comentarios al día. Todo quedó publicado: `HEAD` igual a `origin/main` en `6944cc7`, Pages sirve ese estado. Quedan tres detalles de documentación (D35-27), dos dudas sobre una segunda estación y Simce 2026, bloqueado hasta que la Agencia publique.

## 3. Estado al cierre

**Qué funciona.**

- Sitio publicado: `docs/index.html` `42ab93003e722f9bb6c725fec2d348bd` y `docs/trayectorias.html` `883f76bcefc89d93f2d1e753fc4d75c3` (fuente: `md5sum`, sesión 35); Pages sirve `6944cc7` (fuente: verificación independiente del log de s35q, sesión 35).
- `Rscript 00_build.R`: código 0, 0 fallas críticas y 7 advertencias; baterías del motor 8 de 8 y de la vista 35 de 35, dos veces (fuente: log de s35q L374, leído en la sesión 35).
- Revisión del titular en Safari y en un teléfono de lo publicado por s35h y s35i, aprobada (D35-23).
- `renv.lock` restaura desde cero con `suitedoc` ignorado (D35-18, D35-21).
- Ramas: `main` y `feat/contrato-contexto` locales y publicadas; las tres de respaldo y gobernanza borradas, con bundle en `_archivo/20260926_respaldo_ramas_s35k/` (fuente: `git branch -a` y `ls -d _archivo/2026092*`, sesión 35).

**Qué no funciona o queda a medias.**

- La sección «Cómo correr en una máquina nueva» del README (L92) no pide copiar `LANG` a `~/.Renviron`; sí lo pide la de portabilidad (L276) (fuente: `grep -n` sobre `README.md`, sesión 35).
- El README remite a un protocolo del repositorio privado `herramientas_dev` (L270) y el mensaje de `10_validar_portabilidad.R` L280 sugiere declarar `<PROYECTO>_DATA_ROOT`, que este proyecto no usa (fuente: `grep -n`, sesión 35).
- El nombre del archivo de decisiones (`..._referente_traspasos.md`) ya no describe su contenido, que llega a D35-27.

**Delta respecto de v34.** Referente con rótulo y marcas de ola; 37 unidades futuras en la vista; tipografía institucional incrustada; sitio legible a 375 px; dos baterías versionadas; entorno reproducible desde el lock; años sin literales; documentación al día con el código. Ninguna cifra de aprendizaje publicada cambió.

## 4. Registro detallado de cambios

Cada bloque cita su encargo y su log en `50_documentacion/andamios/logs/`; los hashes salen de `git log --oneline b8c8e1a..HEAD` (sesión 35).

**4.1 Apertura (REPO).** Eco de `/apertura` con candado en verde; `b8c8e1a` abre la sesión en `MacBook-Pro-de-Tomas.local`.

**4.2 Referente y cohortes futuras (D, UI, P).** Página de contexto `andamios/20260924_contexto_referente_trayectorias.html`; decisiones D35-1 y D35-2 (`f4bd59e`). Encargo `encargo_pendientes_s35.md`: catálogo de olas copiado a `20_insumos/auxiliares/` (`6d7c757`), cohortes futuras (`34c6553`), rótulo y marca de ola (`291093f`). FASE R quedó en BLOQUEADO por I-7, escrito sin correr (ERR-35-05); el titular lo reevaluó como no regresión (D35-3) y autorizó el push. El conteo por ola con el directorio y el rótulo de tres cifras entraron en s35b (`f8e7870`, D35-4).

**4.3 Pendientes heredados de v34 (UI, DT, REPO, Infra).** En s35 y s35b: un solo establecimiento marcado (`5a0ec3f`, luego «†» en `b346b40`, D35-6); notas sin columna vacía (`5c0994b`); panorama sin desborde bajo 540 px (`84860ea`); CSS sin uso (`dd7fe76`); `_archivo/` fuera del índice (`00a8cdd`); diagnóstico de Costa Central por código de comuna (`eb77b28`); validación de portabilidad al inicio del build (`7cdedfc`); cifra en la franja Elemental con tinta oscura (`01cdee0`, D35-5); vista sin desborde bajo 680 px (`df88fab`).

**4.4 gobCL (UI, REPO).** Incrustación (`271c04f`) sin revisar la licencia (ERR-35-15); el titular decidió publicarla con declaración en NOTICE (`d900bb1`, D35-7) y dos caras con familia propia `gobCL-sitio` (`41de233`, D35-9). El PNG exportado la incrusta (`206cb3a`, s35h).

**4.5 Sparkline y cifras rescatadas (UI).** La regla de choque de s35b invertía 627 pares (R-48, ERR-35-13); la regla C conserva el orden por valor (`674522d`, D35-8). En s35c, las cifras rescatadas de las barras apiladas con `RECENT_DIMS.rescate` (`7273760`, R-22).

**4.6 Vista de trayectorias, forma (UI).** s35c y s35d: plano sin colapso entre 680 y 800 px y en ventanas bajas (`86319b6`, `77017cd`), tabla de cohortes futuras sin desplazamiento (`7765547`), tooltip del referente y año del ancla desde los datos (`28caa7f`, `f3c20cf`). s35h e s35i: tarjeta medida de nuevo al cambiar el ancho y la cohorte, una columna al dejar el plano angosto (`1458285`, `0f06bc8`, `0e4b544`); texto de los botones de cohorte desde el generador (`ba1b4be`).

**4.7 Publicación y tooltip (REPO, UI).** Publicación de la sesión (`41cd636`). El titular encontró el tooltip cortado en el borde derecho (ERR-35-18); s35f lo ubica dentro de la ventana (`476b1e1`, `6f74d70`) y agrega el centrado óptico con `text-box` (`fa89e7c`), acotado a `@supports` en s35g (`50bb730`), con el tooltip que no tapa el punto a 375 px (`c8964b6`). Publicaciones: `2a719b1`, `9ef4f2b`, `78abd6b`, `823e3d3`.

**4.8 Pantallas angostas del motor (UI).** s35h: modal de territorio (`df73a45`), supergrid legible (`a653259`), centrado de pestañas, campo, exportar y tooltip (`52bab39`). s35i: supergrid con ancho mínimo bajo 670 px (`0ec0d41`, D35-16).

**4.9 Baterías (Infra).** Vista: cubre las cuatro familias de la auditoría de la sesión 30 (`14c9fb3`, s35i) y llega a 35 pruebas. Motor: `33_verificar_motor.R` con M1 a M8 y control positivo (`611852a`, s35l). Ambas manuales antes de cada copia a `docs/` (D35-21). El build se detiene ante una falla de portabilidad también en modo interactivo (`90542fb`).

**4.10 Ramas y entorno (REPO, Infra).** s35j diagnosticó ramas y bloqueos; s35k rescató a `main` el log del contrato de contexto y la suite standalone de `gobernanza/v16` (`1c1cd18`), borró tres ramas con bundle (D35-17) y registró en el lock los paquetes de CRAN, con `suitedoc` fuera (`03c8c6a`, D35-18).

**4.11 Años y rangos (P).** Los años y rangos se derivan de los insumos (`184208a`, D35-19); la serie debe empezar en `ANIO_INICIO` (`29947ce`); años sin Simce en un solo lugar (`6efefc5`) y en los textos visibles (`3cbb42c`); año inicial de la vista desde los datos (`e41ee1e`). Manifiesto: los 18 xlsx se versionan (`4ac0433`, Q-72).

**4.12 Suite y documentación (DOC).** Suite regenerada con el pipeline actual y 2025 como base final (`f40bbfb`, `ba3671d`, reparaciones `9652cfc`, `aa2a5f0`, `88edc0f`); README y comentarios al día (`60ba5e2`, `9d8aa9e`, `00a1b4b`); `publicacion_github_pages.md` con la regla del GSE y las dos baterías (`8dc85dc`); documentos de junio archivados (`0836a50`), lo que dejó tres enlaces rotos en el README (ERR-35-29), quitados en s35q (`d8ba99d`); `.Renviron.example` sin raíz de datos (`43aede2`); el paso 30 valida `COD_DEPE` (`a238458`).

**4.13 CLAUDE.md (Infra).** Creado en la raíz, local e ignorado (`.gitignore` L49) (D35-20); cada encargo agrega su línea a «Últimos cambios» y recorta a 5 (D35-22, D35-24).

**4.14 Compuerta de dudas previa al cierre.** Ver §11; 2 registradas.

## 5. Backlog acumulativo

En `50_documentacion/activa/backlog_acumulativo.md`. Esta sesión agrega 37 entradas.

## 6. Bugs de la sesión

- **B35-1. Tooltip del motor cortado en el borde derecho (publicado).** Síntoma: capturas del titular en Pages. Causa raíz: el ajuste a la ventana descrito en el traspaso v08 nunca llegó a un commit, y la revisión de Safari no lo incluía. Solución: `476b1e1` y `6f74d70` (s35f). Verificación: posiciones medidas en tres tamaños. Patrón: la conducta del producto se verifica en el código, no en su documentación. Estado: resuelto.
- **B35-2. Sparkline con cifras en orden invertido (no publicado).** Síntoma: 627 pares invertidos tras la regla de choque de s35b (R-48). Causa raíz: criterio «sin superposición» sin condición de orden. Solución: regla C (`674522d`, D35-8). Verificación: 0 inversiones, 0 superposiciones y 0 cifras fuera del SVG. Estado: resuelto.
- **B35-3. Enlaces rotos en el README publicado.** Síntoma: tres entradas de «Documentación» apuntaban a documentos archivados en s35p. Causa raíz: la premisa de s35p se apoyó en un `grep` truncado con `head` (ERR-35-29). Solución: `d8ba99d` (s35q). Estado: resuelto.
- **B35-4. JSON y serie con años no contiguos sin detención.** Síntoma: el paso 31 aceptaba una serie que no empezaba en el año inicial. Solución: `29947ce` (Q-74). Estado: resuelto.

## 7. Aprendizajes y restricciones descubiertas

1. **A35-1: una búsqueda que respalda una ausencia se lee completa.** Nunca con `head`. Ejemplo: B35-3.
2. **A35-2: en una cadena de tareas, cada criterio se mide contra el estado que dejan las anteriores**, no contra la base de FASE 0. Ejemplo: ERR-35-09 y ERR-35-22.
3. **A35-3: un control positivo debe alcanzar la regla que prueba.** Si altera una constante que lee más de un paso, se sigue el recorrido del build. Ejemplo: ERR-35-27.
4. **A35-4: `document.fonts.check()` no discrimina una fuente incrustada de una instalada.** La familia incrustada lleva nombre propio (`gobCL-sitio`) y el criterio es la lista de caras cargadas (D35-9).
5. **A35-5: `git update-index --chmod` cambia el índice, no el archivo en disco.** Ejemplo: ERR-35-17.
6. **A35-6: `text-box` va dentro de `@supports`.** Un navegador sin soporte salta el bloque completo (D35-11).
7. **A35-7: los encargos leen `CLAUDE.md` primero y ese archivo no viaja por git.** En otra estación hay que crearlo o el encargo no lo encuentra (duda 2 de §11).
8. **A35-8: el md5 del motor cambia con la fecha de generación** (refuerza A34-1). Un esperado de md5 del motor vale solo el mismo día; entre días se compara por contenido (ERR-35-21).

## 8. Decisiones de diseño

Las 27 decisiones de la sesión viven en `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md` con su contexto y alternativas. Resumen:

- **D35-1** (titular): referente anclado en 2014 (opción A), rótulo con el tamaño del grupo y el conteo con resultado, marca de ola. Descartada: referente dinámico (B).
- **D35-2** (titular y asistente): 37 unidades de las olas 2027 a 2029 en la vista, identificador `<cod_slep>_<año>`, itinerario previo al traspaso. Descartado: ampliar `sleps_chile.parquet`.
- **D35-3**: I-7 como no regresión en ese encargo; desde ahí, absoluto.
- **D35-4**: referente contado por ola con el directorio (475, 406 y 401) y rótulo de tres cifras; corrige ERR-35-08.
- **D35-5** y **D35-6**: tinta `#2E2230` dentro de la franja Elemental; «†» para un solo establecimiento.
- **D35-7** y **D35-9** (titular): gobCL publicada con NOTICE; dos caras en la familia `gobCL-sitio`.
- **D35-8**: regla C de la sparkline (orden por valor y ocultamiento de respaldo).
- **D35-10** a **D35-16**: criterios y cierres de dudas de los encargos (píxeles entre cargas, tope de 5 territorios, `ANCHO_PLANO_MIN` 384, corte del supergrid en 670 px, `--supergrid-col-min` 112 px).
- **D35-17** a **D35-19** (titular): ramas, `suitedoc` fuera del lock, Simce 2026 bloqueado y años derivados de los insumos.
- **D35-20** a **D35-24**: CLAUDE.md local, lock con instantáneas de Posit, baterías manuales, textos de años, suite y README.
- **D35-25** a **D35-27**: últimos textos de documentación, `COD_DEPE`, Q-99 al kit, Q-100 y los tres detalles pendientes.

## 9. Constantes y parámetros

| Constante | Antes | Después | Archivo | Motivo |
|---|---|---|---|---|
| `ANIO_INICIO` | no existía | `2014L` | `10_utils/10_configuracion.R` L32 | D35-19, Q-74 |
| `ANIOS_SIN_SIMCE` | literales repartidos | `c(2019L, 2020L, 2021L)` | `10_utils/10_configuracion.R` L33 | Q-75, Q-80 |
| `TINTA_SOBRE_ELEM` | no existía | `"#2E2230"` | `33_motor_template.html` L1878 | D35-5 |
| `ASTERISCO_UNICO` | `"*"` | `"†"` | `33_motor_template.html` L2782 | D35-6 |
| `--supergrid-col-min` | no existía | `112px` bajo `max-width: 670px` | `33_motor_template.html` L1250-1251 | D35-16 |
| familia incrustada | `gobCL` | `gobCL-sitio` (400 y 700) | `33_fragmento_sitio.html` | D35-9 |

Sin cambio y confirmadas: `MAX_ENTIDADES = 5` (L1857) y `ANCHO_PLANO_MIN=384` (`36_trayectorias_template.html` L907) (fuente: `grep -no`, sesión 35). Fuente canónica de las vigentes: `10_utils/10_configuracion.R` y las plantillas de los pasos 33 y 36.

## 10. Arquitectura de archivos

Nuevos: `30_procesamiento/33_verificar_motor.R`, `20_insumos/auxiliares/dim_slep_comunas.csv`, el archivo de decisiones de la sesión, 16 encargos y sus logs. Archivados a `_archivo/` (ignorado): los tres documentos de junio de `activa/`, capturas de siete encargos y el bundle de ramas. Sin carpetas nuevas versionadas. Escáner regenerado por el ejecutor al cierre.

## 11. Pendientes y ruta sugerida

**Inventario.**

1. **Segunda estación (dudas 1 y 2 de la compuerta).** Tipo: deuda técnica. Contexto: nada de la sesión se corrió fuera de la estación macOS; `CLAUDE.md` es local. Impacto: un encargo o un build en otra máquina puede fallar o diferir. Dependencias: acceso a la segunda estación. Complejidad: baja. Precaución: no escribir en el repositorio desde esa estación sin `/apertura`. Enfoque: `git clone`, crear `CLAUDE.md` desde el de la estación, `Rscript 00_build.R` y md5 de la vista. Criterio: el de las dudas 1 y 2.
2. **Tres detalles de documentación (D35-27).** Tipo: documentación. README L92 sin el paso de `LANG`; README L270 remite a `herramientas_dev` privado; `10_validar_portabilidad.R` L280 nombra `DATA_ROOT`. Complejidad: baja. Precaución: el validador es plantilla de la cartera; el mensaje se ajusta en el kit o se acota aquí con decisión. Criterio: README con `LANG` en las dos secciones, sin remisión a un repositorio privado o con la aclaración, y decisión registrada sobre L280.
3. **Nombre del archivo de decisiones.** Tipo: documentación. Contexto: `20260924_decision_referente_traspasos.md` contiene D35-1 a D35-27. Enfoque: renombrar con `git mv` o separar D35-10 en adelante en un archivo propio, actualizando referencias en el mismo commit (grep previo en POLITICA y SETTINGS). Criterio: `git grep` del nombre viejo fuera de `andamios/` da 0.
4. **Glosario de la suite en «término: definición» (Q-89).** Tipo: documentación. Se hace en la próxima regeneración de la suite, que requiere `npm` y red. Criterio: `grep -c '—'` en el glosario regenerado da 0.
5. **Q-99 en el kit.** Tipo: documentación de cartera. Anotar en el protocolo de portabilidad de `herramientas_dev` que el `.Renviron.example` con raíz de datos aplica solo a la Rama B. Se hace en una sesión del kit.
6. **Museo Sans en la suite (D35-7).** Tipo: gobernanza, sesión BIBLIOTECA de cartera.
7. **`feat/contrato-contexto`.** Se integra por cherry-pick cuando el consumidor programe P-CTX-4 (D35-17). No bloquea.
8. **Simce 2026.** Bloqueado hasta que la Agencia publique la base (se espera hacia abril de 2027). Criterio: build con 2026 y las dos baterías en PASA; los años se derivan solos (D35-19).
9. **Fin del referente y actualización anual del directorio** (pendientes derivados de D35-2 y D35-4). Se deciden con datos del Simce 2028 y con cada directorio nuevo.
10. **Q-70.** El proceso R huérfano de `slep-central-datos` lo detiene el titular.
11. **Dudas heredadas de v30 y v31** (2 y 3 de v31; 2, 3 y 5 de v30). Sin cambio.

**Cerrado en esta sesión:** pendientes 1 a 6 y 8 a 11 de v34; el 12 quedó decidido (rama sin integrar), el 13 sigue bloqueado y el 7 sigue abierto (pendiente 11 de esta lista); la duda 2 de v34 (I8) queda cerrada porque el cierre v34 terminó con `cierre_incompleto: no` (fuente: `ESTADO.md`, sesión 35). Q-71: `suitedoc` vive en un remoto privado (`herramientas_dev`), no «sin remoto».

**Deuda técnica.** Las baterías son manuales (D35-21): una copia a `docs/` sin correrlas no deja rastro. `34_historico_pct_adecuado_costa_central.R` no se corrió en la sesión.

**Auditoría de cierre (5.6).** Datos crudos aislados: sí. Pipeline de cero: sí (`00_build.R` código 0 en s35q). Check por transformación crítica: sí (35 y 8 pruebas con control positivo). Reproducible: sí para la vista; el motor por contenido (A34-1). Constantes nombradas: sí (§9). Nombres sin tildes: sí. Estructura conforme: sí (`_archivo/` fuera del índice, `00a8cdd`). Guarda de locale: sí. Documentación coherente con el código: **no** en tres detalles → pendiente 2.

### Compuerta de dudas (2 registradas)

| # | supuesto | predicado | medición |
|---|---|---|---|
| 1 | El paso 36 produce el mismo HTML en otra estación (heredada de v34) | El md5 de `40_salidas/trayectorias_traspasos.html` generado en la segunda estación es `883f76bcefc89d93f2d1e753fc4d75c3` | En la segunda estación: `Rscript 30_procesamiento/36_generar_trayectorias.R` y `md5` del HTML |
| 2 | Un encargo corre en otra estación aunque `CLAUDE.md` no viaja por git | `CLAUDE.md` existe en la raíz de la segunda estación antes del primer encargo | En la segunda estación: `ls /ruta/al/repo/CLAUDE.md` |

**Ruta sugerida.** (1) Pendientes 2 y 3 en un encargo corto de documentación, con `grep` completos (A35-1). (2) Pendiente 1 cuando se use la segunda estación. (3) Pendiente 4 al regenerar la suite. Diferir 5 y 6 a sesiones del kit; 8 y 9 esperan datos.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 Todas las 🔒 de v34 §12 siguen vigentes, con estas precisiones: el referente sigue el universo de D32-2 con el rótulo y las marcas de D35-1 y D35-4; «†» marca un solo establecimiento y «*» el dato preliminar (D35-6).
- 🔒 Las unidades futuras usan el identificador `<cod_slep>_<año>` y nunca el de una unidad vigente (D35-2).
- 🔒 La familia incrustada es `gobCL-sitio` con dos caras; NOTICE declara que no está bajo Apache 2.0 (D35-7, D35-9).
- 🔒 Los años y rangos salen de `ANIO_INICIO`, `ANIOS_SIN_SIMCE` y los insumos; ningún texto visible lleva un rango escrito a mano (D35-19, Q-80). 2018 y 2022 quedan fijos donde D35-22 lo dice.
- 🔒 `suitedoc` queda fuera de `renv.lock` (D35-18).
- ✅ ANTES de copiar a `docs/`, correr `Rscript 30_procesamiento/33_verificar_motor.R` y `Rscript 30_procesamiento/36_verificar_trayectorias.R`, ambas con código 0.
- ✅ ANTES de escribir en un encargo una premisa de ausencia, leer la búsqueda completa, sin `head` (A35-1).
- ✅ ANTES de fijar el criterio de una tarea que no es la primera, revisar qué cambian las anteriores del mismo encargo (A35-2).
- ✅ ANTES de usar un control positivo, seguir el recorrido del build hasta la regla que prueba (A35-3).
- ✅ ANTES de un encargo en otra estación, crear `CLAUDE.md` en su raíz (A35-7).
- ⚠️ NO escribir en un encargo un comando, un número de autorización ni una lista de líneas que no salga de un comando corrido en el mismo turno.
- ⚠️ NO correr git que escriba desde el puente, y todo git de lectura con `GIT_OPTIONAL_LOCKS=0`.
- ⚠️ NO usar un md5 esperado del motor de otro día (A35-8).

## 13. Fragmentos de código de referencia

```r
# 10_utils/10_configuracion.R: los años del proyecto viven aquí (D35-19).
ANIO_INICIO     <- 2014L
ANIOS_SIN_SIMCE <- c(2019L, 2020L, 2021L)
```

```bash
# Baterías antes de copiar a docs/ (D35-21), desde la raíz del repositorio.
cd /Users/tomgc/Projects/slep_simce_adecuado && Rscript 30_procesamiento/33_verificar_motor.R
cd /Users/tomgc/Projects/slep_simce_adecuado && Rscript 30_procesamiento/36_verificar_trayectorias.R
```

Los patrones estables siguen en `CLAUDE.md` (local), en los scripts de los pasos 33 y 36 y en `10_utils/`.

## 14. Reapertura

Tipo de sesión: CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`) vive en la knowledge base del Project y se lee desde ahí; no se adjunta.

**Se adjunta:** `traspaso_cierre_v35.md`. `README.md`, `10_utils/10_validar_portabilidad.R` y el archivo de decisiones se leen desde la carpeta conectada. El backlog y el escáner no se adjuntan.

**Estado:** `main` en `6944cc7` más el commit de D35-27, previo al commit de cierre. Todos los pendientes de v34 cerrados salvo Simce 2026 (bloqueado); sitio publicado con las dos baterías en PASA; quedan tres detalles de documentación y dos dudas sobre una segunda estación.

**Foco propuesto:** un encargo corto de documentación con los pendientes 2 y 3 (README con `LANG`, remisión a `herramientas_dev`, mensaje del validador y nombre del archivo de decisiones).

Si alguno de los archivos listados cambió entre sesiones, adjuntar la versión más actualizada al abrir y avisarlo en el mensaje de apertura.

## 15. Errores del asistente

29 errores, registrados en el momento en `50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md`. Aquí van con los diez campos. En ERR-35-19 a 29 se agregan `momento` y `disparador`, que el registro omitía, y se reclasifican los `patron` que el registro asignó fuera del catálogo (PAT-04, PAT-05 y PAT-06 usados para criterios mal calibrados o texto reutilizado); la clasificación válida es la de esta tabla.

**ERR-35-01**
- `momento`: entrega del archivo de decisiones (prioridad 2).
- `disparador`: asistente lo señaló espontáneamente.
- `que_paso`: lancé la corrección de una cifra y la escritura a la carpeta en el mismo bloque paralelo, y llegó la versión sin corregir.
- `regla_violada`: SETTINGS §1.2.6, «Generar, verificar, consumar»; v34 §12 sobre `device_commit_files`.
- `causa_raiz`: traté dos operaciones dependientes como independientes para ahorrar un turno.
- `salvaguarda_presente`: SETTINGS y traspaso v34.
- `patron`: PAT-02, consumo en paralelo con el paso que lo condicionaba.
- `gatillo_observable`: costo-sobre-regla: escritura a la carpeta en el mismo bloque que la edición del archivo.
- `intentos_previos`: 0.
- `costo`: una reescritura; nada commiteado con la versión errada.

**ERR-35-02**
- `momento`: la misma verificación.
- `disparador`: asistente lo señaló espontáneamente.
- `que_paso`: usé `md5 -q` sin respaldo `md5sum` en una cadena `&&` del puente.
- `regla_violada`: SETTINGS §1.2.6, «Ningún comando asume el entorno».
- `causa_raiz`: omití el respaldo que había usado antes.
- `salvaguarda_presente`: SETTINGS; A34-3.
- `patron`: PAT-03, comando del puente sin respaldo.
- `gatillo_observable`: comando-entorno: `md5` sin respaldo en una cadena del puente.
- `intentos_previos`: 0.
- `costo`: una llamada repetida.

**ERR-35-03**
- `momento`: reporte de la prioridad 2, cuarto intercambio.
- `disparador`: usuario lo corrigió.
- `que_paso`: recomendé cerrar la sesión sin síntoma de degradación.
- `regla_violada`: userPreferences y SETTINGS §3 y §1.2.6 («El turno termina proponiendo»).
- `causa_raiz`: confundí el fin de la ruta con el fin de la sesión.
- `salvaguarda_presente`: userPreferences y SETTINGS.
- `patron`: PAT-04, ceder la iniciativa al cierre.
- `gatillo_observable`: otro: recomendación de cierre sin síntoma de §3 nombrado.
- `intentos_previos`: 0.
- `costo`: un turno del titular.

**ERR-35-04**
- `momento`: reescritura del archivo de decisiones con D35-2.
- `disparador`: asistente lo señaló espontáneamente (md5 en la carpeta sin cambio).
- `que_paso`: reenvié a la carpeta un archivo de `outputs/` con el mismo nombre y llegó la versión anterior.
- `regla_violada`: traspaso v34 §12, nombre nuevo en `outputs/`.
- `causa_raiz`: la instrucción estaba leída pero no la apliqué a un archivo ya enviado.
- `salvaguarda_presente`: traspaso v34.
- `patron`: PAT-07, restricción leída no propagada.
- `gatillo_observable`: restriccion-no-propagada: `device_commit_files` con un `stagedPath` ya enviado.
- `intentos_previos`: 0.
- `costo`: un reenvío.

**ERR-35-05**
- `momento`: `encargo_pendientes_s35.md`, invariante I-7.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: escribí I-7 con esperado «vacío» sin correrlo; ya daba un acierto y FASE R quedó en BLOQUEADO.
- `regla_violada`: traspaso v34 §12 y SETTINGS §1.2.6, marcador tipo 4.
- `causa_raiz`: traté los 🔒 heredados como verdaderos por construcción.
- `salvaguarda_presente`: traspaso v34 y SETTINGS.
- `patron`: PAT-01, esperado sin medición previa.
- `gatillo_observable`: encargos-premisas: invariante con esperado y sin salida del redactor.
- `intentos_previos`: 0.
- `costo`: push retenido y una decisión del titular (D35-3).

**ERR-35-06**
- `momento`: mismo encargo, FASE 0 H3.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: `git rev-parse --short HEAD origin/main` falla por sintaxis.
- `regla_violada`: traspaso v34 §12.
- `causa_raiz`: compuse el comando de memoria.
- `salvaguarda_presente`: traspaso v34.
- `patron`: PAT-01, comando no ejecutado antes.
- `gatillo_observable`: encargos-premisas: comando de FASE 0 sin salida del redactor.
- `intentos_previos`: 0.
- `costo`: una desviación del ejecutor.

**ERR-35-07**
- `momento`: mismo encargo, T4.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: afirmé que los puntos de la sparkline no llevan texto; llevan una cifra.
- `regla_violada`: SETTINGS §1.2.6, leer antes de modificar, marcador tipo 4.
- `causa_raiz`: extendí la lectura de un bloque a otro sin abrirlo.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, premisa sobre código no leído.
- `gatillo_observable`: afirmar-sin-leer: premisa sobre un rango de código no leído.
- `intentos_previos`: 0.
- `costo`: una cifra con contraste bajo y una duda.

**ERR-35-08**
- `momento`: redacción de D35-1.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: atribuí un reparto calculado sobre 1.299 a los 1.282 del directorio.
- `regla_violada`: SETTINGS §1.2.6, marcador tipo 3.
- `causa_raiz`: combiné recuentos de dos universos sin recontar.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, cifra de un universo aplicada a otro.
- `gatillo_observable`: cifras-datos: un total y un reparto que no lo suma.
- `intentos_previos`: 0.
- `costo`: una frase falsa commiteada, corregida por D35-4.

**ERR-35-09**
- `momento`: mismo encargo, criterios de T1 y T3.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: pedí en T3 identidad de píxeles contra el estado previo a T1, que cambiaba esa zona.
- `regla_violada`: encargo_autonomo v1.6 §2.5 y §2.6.
- `causa_raiz`: fijé el criterio contra la base y no contra lo que deja T1.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-07, efecto de una tarea no propagado al criterio de la siguiente.
- `gatillo_observable`: restriccion-no-propagada: criterio de píxeles sobre una zona que una tarea previa modifica.
- `intentos_previos`: 0.
- `costo`: dos tareas congeladas y un encargo más.

**ERR-35-10**
- `momento`: mismo encargo, calibración de C5.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: el caso malo de calibración no existía en los datos.
- `regla_violada`: encargo_autonomo v1.6 §2.6.
- `causa_raiz`: elegí el caso por plausibilidad sin contarlo.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-13, calibración que no mide el riesgo.
- `gatillo_observable`: iteracion-sin-criterio: caso de calibración sin recuento previo.
- `intentos_previos`: 0.
- `costo`: una desviación y una duda.

**ERR-35-11**
- `momento`: opciones sobre la opacidad y T4.
- `disparador`: asistente lo señaló espontáneamente, al verificar Q-08.
- `que_paso`: propuse «*» sin buscar sus usos; ya marcaba el dato preliminar.
- `regla_violada`: SETTINGS §1.2.6.
- `causa_raiz`: diseñé el signo sin `grep` de la plantilla.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, signo diseñado sin leer sus usos.
- `gatillo_observable`: afirmar-sin-leer: símbolo nuevo sin `grep` previo.
- `intentos_previos`: 0.
- `costo`: un signo reemplazado en el encargo siguiente.

**ERR-35-12**
- `momento`: encargo s35b, criterio de G.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: usé `document.fonts.check()` como criterio sin calibrarlo.
- `regla_violada`: encargo_autonomo v1.6 §2.6.
- `causa_raiz`: di por evidente la semántica de una API.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-13, criterio que mide un proxy.
- `gatillo_observable`: iteracion-sin-criterio: criterio sin caso malo declarado.
- `intentos_previos`: 0.
- `costo`: una tarea más en el encargo siguiente.

**ERR-35-13**
- `momento`: encargo s35b, criterio de M2.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: pedí «0 superposiciones» sin exigir el orden de los valores; quedaron 627 pares invertidos.
- `regla_violada`: encargo_autonomo v1.6 §2.6.
- `causa_raiz`: traduje «legible» a «sin superposición».
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-13, criterio que mide un proxy de la lectura correcta.
- `gatillo_observable`: iteracion-sin-criterio: criterio de posición de rótulos sin condición de orden.
- `intentos_previos`: 0.
- `costo`: tres intentos de reparación, veredicto OBSERVADO y push retenido.

**ERR-35-14**
- `momento`: encargo s35b, autorizaciones.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: la lista no autorizaba descartar un intento sin commitear.
- `regla_violada`: encargo_autonomo v1.6 §2.1.
- `causa_raiz`: no previ intentos que no llegan a commit.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-07, restricción no propagada al ciclo de reparación.
- `gatillo_observable`: encargos-premisas: ciclo de intentos sin comando de retorno autorizado.
- `intentos_previos`: 0.
- `costo`: una operación fuera de la lista, sin daño medido.

**ERR-35-15**
- `momento`: encargo s35b, tarea G.
- `disparador`: asistente lo señaló espontáneamente, al evaluar Q-35.
- `que_paso`: ordené versionar fuentes de terceros sin verificar su licencia.
- `regla_violada`: POLITICA §6 y la decisión de licencia Apache del proyecto.
- `causa_raiz`: tomé D33-4 como autorización de redistribuir.
- `salvaguarda_presente`: POLITICA y la decisión de licencia.
- `patron`: PAT-01, premisa de gobernanza sin fuente.
- `gatillo_observable`: afirmar-sin-leer: archivo de terceros versionado sin licencia leída.
- `intentos_previos`: 0.
- `costo`: una decisión del titular (D35-7).

**ERR-35-16**
- `momento`: `encargo_riesgos_s35d.md`, Q46.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: afirmé que las tres cohortes desbordaban; solo la 2027, y la calibración no podía disparar.
- `regla_violada`: SETTINGS §1.2.6 y encargo_autonomo v1.6 §2.6.
- `causa_raiz`: usé un resumen como medición por cohorte.
- `salvaguarda_presente`: SETTINGS y encargo_autonomo v1.6.
- `patron`: PAT-01, premisa desde un resumen secundario.
- `gatillo_observable`: encargos-premisas: premisa sobre tres casos con una frase agregada.
- `intentos_previos`: 0.
- `costo`: una desviación y una duda.

**ERR-35-17**
- `momento`: encargo s35d, autorización 2.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: autoricé `git update-index --chmod=-x`, que no cambia el disco.
- `regla_violada`: traspaso v34 §12.
- `causa_raiz`: no probé el efecto del comando.
- `salvaguarda_presente`: traspaso v34.
- `patron`: PAT-01, comando no ejecutado antes.
- `gatillo_observable`: encargos-premisas: autorización sin efecto medido en `git status`.
- `intentos_previos`: 0.
- `costo`: una autorización usada fuera de su propósito.

**ERR-35-18**
- `momento`: validación posterior a la publicación.
- `disparador`: usuario lo señaló sin nombrarlo error (capturas).
- `que_paso`: pedí verificar un ajuste del tooltip copiado de la documentación que el código nunca tuvo.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente.
- `causa_raiz`: traté la documentación como fuente del comportamiento.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, conducta afirmada desde la documentación.
- `gatillo_observable`: afirmar-sin-leer: paso de validación sin `grep` del código.
- `intentos_previos`: 0.
- `costo`: un defecto publicado y una publicación más.

**ERR-35-19**
- `momento`: encargo s35g, orden de FASE L.
- `disparador`: asistente lo señaló espontáneamente, al leer el reporte.
- `que_paso`: P3 corrió después del último commit y su evidencia quedó fuera del log.
- `regla_violada`: encargo_autonomo v1.6, FASE L.
- `causa_raiz`: ordené por dependencia sin prever dónde queda escrito el resultado.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-02, evidencia fuera del artefacto versionado.
- `gatillo_observable`: otro: una fase que corre después del último commit autorizado.
- `intentos_previos`: 0.
- `costo`: una medición extra del asistente.

**ERR-35-20**
- `momento`: encargo s35h, casos del supergrid.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: pedí medir con 6 territorios; el tope es 5.
- `regla_violada`: SETTINGS §1.2.6, marcador tipo 4.
- `causa_raiz`: elegí los casos por simetría sin leer el límite.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, caso de prueba sin leer el tope del producto.
- `gatillo_observable`: encargos-premisas: cantidad en un criterio sin `grep` de su tope.
- `intentos_previos`: 0.
- `costo`: una desviación y una duda.

**ERR-35-21**
- `momento`: encargo s35h, H6.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: esperé el md5 del motor igual a `docs/` en otro día.
- `regla_violada`: encargo_autonomo v1.6 y A34-1 del traspaso v34.
- `causa_raiz`: copié el esperado de un encargo del mismo día del build.
- `salvaguarda_presente`: encargo_autonomo v1.6 y traspaso v34.
- `patron`: PAT-13, esperado que mide un proxy (md5) y no el contenido.
- `gatillo_observable`: encargos-premisas: md5 esperado de un artefacto con fecha de generación.
- `intentos_previos`: 0.
- `costo`: una decisión autónoma del ejecutor.

**ERR-35-22**
- `momento`: encargo s35h, M3.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: comparé 90 controles con la base aunque M1 y M2 los movían.
- `regla_violada`: encargo_autonomo v1.6.
- `causa_raiz`: escribí cada criterio contra la base de FASE 0.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-07, efecto de tareas previas no propagado al criterio.
- `gatillo_observable`: restriccion-no-propagada: tarea no primera comparada contra la base en una zona tocada.
- `intentos_previos`: 1 (ERR-35-09, misma forma).
- `costo`: una desviación.

**ERR-35-23**
- `momento`: encargo s35j, FASE L paso 6.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: el push citaba la autorización 4; era la 6.
- `regla_violada`: encargo_autonomo v1.6.
- `causa_raiz`: reutilicé la cola de otro encargo sin renumerar.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-12, texto de otro encargo con referencias desfasadas.
- `gatillo_observable`: encargos-premisas: cola copiada que nombra una autorización por número.
- `intentos_previos`: 0.
- `costo`: una nota del ejecutor.

**ERR-35-24**
- `momento`: encargo s35k, K3.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: el criterio del hueco de años era ambiguo y el ALCANCE omitía textos que s35j ya listaba.
- `regla_violada`: encargo_autonomo v1.6.
- `causa_raiz`: no decidí si 2014 era piso y armé el ALCANCE solo con el build.
- `salvaguarda_presente`: encargo_autonomo v1.6 y log de s35j.
- `patron`: PAT-07, diagnóstico previo no propagado al ALCANCE.
- `gatillo_observable`: restriccion-no-propagada: lista de archivos de un log previo que el ALCANCE no cita.
- `intentos_previos`: 0.
- `costo`: dos dudas y un encargo más.

**ERR-35-25**
- `momento`: encargo s35l, primera emisión, H1.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: esperé una batería versionada y había dos; faltaban además premisas que el ejecutor halló.
- `regla_violada`: SETTINGS §1.2.6 y la regla de correr cada comando antes.
- `causa_raiz`: escribí la premisa de memoria.
- `salvaguarda_presente`: SETTINGS; la detención de H1 funcionó.
- `patron`: PAT-01, premisa de memoria.
- `gatillo_observable`: encargos-premisas: esperado de FASE 0 marcado hipótesis.
- `intentos_previos`: 0.
- `costo`: un encargo detenido y una segunda emisión.

**ERR-35-26**
- `momento`: encargo s35l, segunda emisión.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: copié del log anterior las coincidencias sin repetir la búsqueda; eran 11 y no 9.
- `regla_violada`: SETTINGS §1.2.6.
- `causa_raiz`: traté un log como inventario completo.
- `salvaguarda_presente`: el criterio de L3 registró lo no previsto.
- `patron`: PAT-01, premisa desde un documento previo y no desde un comando.
- `gatillo_observable`: encargos-premisas: lista de líneas que proviene de otro documento.
- `intentos_previos`: 1 (ERR-35-25).
- `costo`: una duda y un encargo corto más.

**ERR-35-27**
- `momento`: encargo s35m, control de N1.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: el control del rango no llegaba al paso 33: el 31 lo detenía antes.
- `regla_violada`: encargo_autonomo v1.6 §2.6.
- `causa_raiz`: miré solo `10_html.R` sin seguir el build.
- `salvaguarda_presente`: el criterio pedía anotar la salida.
- `patron`: PAT-13, control positivo que no alcanza el riesgo.
- `gatillo_observable`: iteracion-sin-criterio: control que altera una constante leída por más de un paso.
- `intentos_previos`: 0.
- `costo`: una desviación.

**ERR-35-28**
- `momento`: encargo s35n, criterios de la suite.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: no pedí medir la suite a 375 px, aunque s35h ya lo exigía para lo publicado; desbordaba.
- `regla_violada`: encargo_autonomo v1.6.
- `causa_raiz`: traté la suite como texto y no como páginas.
- `salvaguarda_presente`: FASE R del ejecutor.
- `patron`: PAT-07, criterio de pantallas angostas no propagado a la suite.
- `gatillo_observable`: restriccion-no-propagada: encargo que regenera HTML sin criterio a 375 px.
- `intentos_previos`: 0.
- `costo`: una reparación en FASE R.

**ERR-35-29**
- `momento`: encargo s35p, premisas P1, P4 y P5.
- `disparador`: asistente lo señaló espontáneamente, al leer el log.
- `que_paso`: una búsqueda truncada con `head` ocultó que el README enlazaba los documentos archivados; además dos criterios de `grep` sin correr.
- `regla_violada`: SETTINGS §1.2.6 y la regla de correr cada comando antes.
- `causa_raiz`: traté el recorte de una búsqueda como resultado completo.
- `salvaguarda_presente`: la detención de P1 y el registro de P5.
- `patron`: PAT-01, premisa de ausencia sin fuente completa.
- `gatillo_observable`: encargos-premisas: premisa de ausencia respaldada por una salida con `head`.
- `intentos_previos`: 3 (ERR-35-25, 26 y 27).
- `costo`: tres enlaces rotos publicados y un encargo más.

**Reincidencia.** PAT-01 concentra 13 de los 29 registros (fuente: `grep -c` sobre esta tabla, sesión 35), casi todos en premisas de encargo (encargos-premisas); la salvaguarda vigente es de disciplina y reincidió en la misma sesión. Por §2.2.16 la falla es de forma del output: la forma correcta es un slot obligatorio en el encargo, junto a cada premisa, con el comando y su salida del mismo turno. Propuesta para una sesión del kit (instrumento de encargos).

### Fricciones

- `friccion: se mencionó 2025 como preliminar → confirmado final (solo xlsx _final y manifiesto) y textos corregidos en s35n.`
- `friccion: preguntas sobre capturas en Downloads → aclarado que las capturas están en _archivo/, ignoradas por git.`
