# Traspaso de cierre v36: slep_simce_adecuado

## 1. Identificación

- **Proyecto:** `slep_simce_adecuado`, motor de comparación interactivo de resultados Simce por estándares de aprendizaje, con la vista de trayectorias de los Servicios Locales.
- **Versión del traspaso:** v36. **Fecha:** 2026-11-11. **Sesión:** 36 (abierta el 2026-11-09 en `estacion_windows`, `d32ad14`).
- **Foco:** incluir todos los resultados que publica la Agencia, también los que trae con simbología adicional (D36-1), y dejar el modal de esos resultados igual que las cifras (D36-13); además, documentación pendiente de v35, ordenación de la raíz y mapa de las reescrituras de la historia. Siete expedientes de encargo (fuente: `ls 50_documentacion/encargos/202611/`, sesión 36).
- **Entorno:** Cowork con puente a la estación Windows (lectura y git solo de lectura con `GIT_OPTIONAL_LOCKS=0`); encargos ejecutados por Claude Code en la estación (Git Bash), cada uno con FASE 0, FASE R y FASE L y su log versionado; pushes del titular desde PowerShell.
- **Normativos usados:** `POLITICA_PROYECTO.md` con encabezado `> **Versión 6.1 — vigente.**` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md` con encabezado `> **Versión 44.** Emitida el 2026-11-04 con` (fuente: `grep -m1 Versión` sobre las copias de `50_documentacion/activa/`, sesión 36); protocolo de encargos `encargo_autonomo_claude_code_v1.md` v1.11 del kit.
- **`main` previo al commit de cierre:** `30c46a4`, publicado; 26 commits de la sesión sobre `d32ad14` (fuente: `git log --oneline d32ad14..HEAD | wc -l` da 26 más la apertura, sesión 36).
- **Archivos principales creados o modificados:** `10_utils/10_configuracion.R`, `10_utils/10_utils.R`, `30_procesamiento/31_leer_normalizar.R`, `32_agregar_comunal.R`, `33_generar_html.R`, `33_motor_template.html`, `33_verificar_motor.R`, `34_historico_pct_adecuado_costa_central.R`, `36_funciones_trayectorias.R`, `36_verificar_trayectorias.R`, `README.md`, `docs/index.html`, `50_documentacion/activa/50_excepciones_estructura.md` (nuevo), dos archivos de decisiones nuevos en `activa/decisiones/`.

## 2. Resumen ejecutivo

La sesión abrió con una urgencia del titular: el CSV de Costa Central mostraba 54 establecimientos y 1.184 evaluados donde la Agencia publica 55 y 1.194. La causa era general: el motor descartaba toda fila con marca de la Agencia. Con D36-1 entra todo resultado por estándar válido, el motor marca con «‡» las cifras que incluyen resultados con simbología adicional y una casilla los excluye y abre un modal por año con su motivo; la concordancia con la Agencia se verificó por tres caminos con 0 diferencias. El modal no ubicaba 25 resultados de establecimientos que ya no están en el directorio; D36-13 lo ubica con la comuna, la dependencia y el GSE de la fila Simce, como las cifras, y la prueba M12 lo garantiza en 2.946 combinaciones. Además: el README y el archivo de decisiones de v35 quedaron al día, la raíz no tiene desvíos estructurales (excepciones declaradas), y un mapa de hashes resuelve las citas a commits de antes de las reescrituras del 2026-08-24 y del 2026-11-04. Todo está publicado en Pages y verificado por md5. Queda un pendiente del titular (mirar el pie del modal), Simce 2026 con el directorio 2026 y seis puntos del kit.

## 3. Estado al cierre

**Qué funciona.**

- Sitio publicado: Pages sirve `index.html` con md5 `3734a83573e3e22b2f51edde3d65462d` y `trayectorias.html` con `e0681b9e486428a6ab3cc38e2c531cfc`, iguales a `docs/` en `30c46a4` (fuente: `curl` a la URL pública desde la estación, sesión 36).
- `Rscript 00_build.R` con código 0; batería del motor 12 de 12 (M12 `casos=2946 difieren=0 sin_directorio=25 sin_directorio_ubicadas=25 nacional_difieren=0 control=detectado`); batería de la vista 35 de 35; `.tests_agregar_ponderado()` 9 de 9 (fuente: log de `20261111_pie_y_publicacion_reemision`, FASE R, leído completo en la sesión 36).
- Censo de estructura: `estructurales: 0`, `exceptuados: 4`, `menores: 7` (fuente: log de `20261109_ordenacion_estructura`, R-09).
- Las siete fichas de log validan con `98_indexar_encargos.R` (fuente: logs de los encargos, FASE L; la de `ordenacion_estructura` la validó el titular con `rc 0`).

**Qué no funciona o queda a medias.**

- El pie del modal «Resultados excluidos del cálculo» no se miró en un navegador: las pruebas lo miden como texto (log de la reemisión, nota (a)).
- El clon del Mac quedó en `d501236`, sin la sesión 36, con un archivo sin versionar en `50_documentacion/auditorias_externas/202610/` (fuente: reporte de Claude Code lanzado por error en el Mac, sesión 36); la próxima `/apertura` en el Mac se detendría por árbol sucio (duda 2 de §11).

**Delta respecto de v35.** El motor replica las cifras de la Agencia (D36-1) con «‡», casilla y modal; el catálogo de simbología lleva comuna, dependencia, GSE y nombre de la base (D36-13); `simce_rbd.parquet` pasa de 16 a 17 columnas (`nom_rbd`); el referente de la vista cambió por D36-1 (R1/R3/R5/R6: 1333; 491, 417 y 408; 1316; 825); la batería del motor pasa de 8 a 12 pruebas.

## 4. Registro detallado de cambios

Cada bloque cita su expediente en `50_documentacion/encargos/202611/`; los hashes salen de `git log --format='%h %s' d32ad14~1..HEAD` (sesión 36).

**4.1 Apertura (REPO).** `/apertura` falló por el kit sucio (tres rutas sin versionar) y por un push rechazado (GH007); se resolvió desde el puente (ERR-36-02) y la sesión abrió en `d32ad14` en `estacion_windows`.

**4.2 Concordancia con la Agencia y regla de inclusión (P, UI, DOC; `20261109_inclusion_resultados_simbologia`).** `9d190b0` (pipeline: `agregar_ponderado()` incluye toda fila con los tres porcentajes sumando 99 a 101, con o sin marca; `MOTIVOS_SIMBOLOGIA` y `CODIGOS_LITERALES_SIMBOLOGIA`), `c36ae35` (vista), `f0b8ba5` (motor: «‡», casilla, modal por año, columnas `n_estab_simbologia` y `excluye_simbologia` del CSV, nota metodológica, M9 a M11), `e4652b6` (decisión, README y glosas). Verificación: Costa Central 4° básico Lectura 2025, 55 y 1.194 (54 y 1.184 con la casilla); la concordancia con las bases se verificó aparte por tres caminos (142.353 filas por RBD, 45.375 agregados comunales y 2.592 series del propio motor en Chromium), 0 diferencias. Publicado en `338e64f`.

**4.3 Documentación pendiente de v35 (DOC; `20261109_documentacion_s36`).** `317040d`: paso de `LANG` en «Cómo correr en una máquina nueva» del README, remisión a `herramientas_dev` aclarada, D35-7 a D35-27 separadas en `decisiones/20260925_decision_cierre_pendientes_v34.md` con sus citas (D36-5 a D36-7).

**4.4 Ordenación de la raíz (REPO; `20261109_ordenacion_estructura`).** `da56d29`: `50_excepciones_estructura.md` declara `00_build.R`, `docs/` y `NOTICE` (regla `raiz`), y se retira `traspasos/.gitkeep` (D36-8 a D36-10). Censo de 5 a 0 desvíos estructurales.

**4.5 Mapa de hashes (DOC; `20261109_mapa_hashes`).** `08d54d9`: `anexos/50_mapa_hashes.md` del expediente, 284 filas (277 de la reescritura del 2026-11-04 y 7 del rebase del 2026-08-24), verificado contra `HEAD` (D36-11). El par que el mapa no trae, `54404d9` → `a6c2eb0`, se obtuvo del reflog del Mac y vive en §7 de este traspaso.

**4.6 Modal de simbología (UI, Infra; `20261111_modal_simbologia_sin_directorio`).** `d32d433` (31 lee `nom_rbd`; el catálogo suma `com`, `depe`, `grupo` y `nom`) y `248ff75` (`filasSimbologia` reemplaza a `rbdsDeTerritorio`; M10 adaptada; M12 nueva). Verificación: M12 con 0 diferencias en 2.946 combinaciones; la regla anterior daba 62 (simulación de la auditoría de redacción); 🔒 de cifras con la sonda `50_sonda_json_igual.R`, `igual TRUE`.

**4.7 Pie del modal y publicación (UI, REPO; `20261111_pie_y_publicacion` y su reemisión).** El primer encargo congeló T1 por un patrón de verificación que el build transpilado no conserva (ERR-36-10); la reemisión commiteó las ediciones heredadas (`1223816`: pie de D36-15 y dos comentarios del esquema) y publicó (`1e6e707`). El titular hizo push en `30c46a4` y Pages sirve el md5 construido.

**4.8 Directorio 2026 (D).** Los cortes 2025 y 2026 del directorio, su estructura y sus frecuencias quedaron renombrados con prefijo de fecha en la carpeta de insumos de `slep_directorio_territorio` (OneDrive). Este proyecto sigue con el corte 2025 (D36-2).

**4.9 Compuerta de dudas previa al cierre.** Ver §11; 2 registradas.

## 5. Backlog acumulativo

En `50_documentacion/activa/backlog_acumulativo.md`. Esta sesión agrega 13 entradas.

## 6. Bugs de la sesión

- **B36-1. El motor no replicaba las cifras de la Agencia (publicado).** Síntoma: Costa Central 4° básico Lectura 2025 con 54 y 1.184 donde la Agencia publica 55 y 1.194 (reporte del titular). Causa raíz: `agregar_ponderado()` excluía toda fila con `marca` (decisión A2 de `referencia_glosas_simce.md`) y además aplicaba `nalu >= 10` como filtro. Solución: `9d190b0`, `c36ae35`, `f0b8ba5` (D36-1). Verificación: M9 y la concordancia por tres caminos. Patrón: una exclusión de filas se contrasta contra la cifra que publica la fuente, no solo contra la regla escrita. Estado: resuelto y publicado.
- **B36-2. El modal no listaba 25 resultados que el «‡» contaba (R-30, no publicado como defecto visible).** Causa raíz: el modal ubicaba por el directorio vigente y las cifras por la fila Simce. Solución: `d32d433` y `248ff75` (D36-13). Verificación: M12. Patrón: una lista que explica una cifra usa la misma regla de pertenencia que la cifra. Estado: resuelto y publicado.

## 7. Aprendizajes y restricciones descubiertas

- **A36-1: el motor construido no conserva el marcado de la plantilla.** `33_generar_html.R` transpila el JSX con Babel; un texto de la interfaz se busca en el motor como cadena de JavaScript (por ejemplo `base de la Agencia"`), no con `</span>`. Ejemplo: ERR-36-10.
- **A36-2: GitHub sirve por SHA los commits que una reescritura dejó fuera de `main`.** Una reescritura no borra nada del remoto; las citas viejas se resuelven con un mapa (`<PROT>` §2.1, v1.11). Mapa de este proyecto: `50_documentacion/encargos/202611/20261109_mapa_hashes/anexos/50_mapa_hashes.md`, más el par `54404d9` → `a6c2eb0` («docs(encargos): migra el legado de encargos a historico», 2026-10-07), que el kit cita en los encargos de migración del 2026-10-07.
- **A36-3: `40_salidas/` no está ignorada entera**: `.gitignore` ignora extensiones; un `.txt` escrito ahí aparece como archivo sin seguimiento (ERR-36-11). Antes de escribir en el repo, `git check-ignore`.
- **A36-4: los comandos para el titular van en PowerShell en la estación Windows** (rutas `C:\...` entre comillas, `Start-Process`); Git Bash es solo el entorno de Claude Code (ERR-36-07).
- **A36-5: la estación de trabajo se nombra en cada lanzamiento de encargo**: un encargo lanzado en el Mac encontró un clon atrasado y se detuvo sin daño.

## 8. Decisiones de diseño

Las de peso viven en `50_documentacion/activa/decisiones/20261109_decision_inclusion_resultados_simbologia.md` (D36-1) y en los encargos de la sesión. Resumen:

- **D36-1** (titular): se incluye todo resultado por estándar válido, con «‡», casilla de exclusión, modal por año, nota metodológica y columnas en los CSV. Descartadas: mantener la regla y explicar la diferencia; solo nota.
- **D36-2** (titular): el encargo usa el directorio 2025; el corte 2026 entra junto con el Simce 2026 (opción B).
- **D36-3** (titular): sin push ni copia a `docs/` en los encargos; el titular revisa y publica.
- **D36-4** (titular): se acepta el recuento de R-13 del encargo de D36-1.
- **D36-5** a **D36-7**: D35-7 a D35-27 en archivo propio (no renombrar); validador L280 para el kit; remisión a `herramientas_dev` aclarada.
- **D36-8** a **D36-10** (titular): excepciones de raíz para `00_build.R`, `docs/` y `NOTICE`; retiro del `.gitkeep`; los 7 desvíos menores fuera.
- **D36-11** (titular): mapa de hashes en el expediente; los registros que citan hashes viejos no se reescriben.
- **D36-12** (titular, modificada el 2026-11-11): no se pide purga a GitHub; la regla de no atribución cubre solo la historia de `main`.
- **D36-13** (titular, opción A): el modal ubica cada resultado con la comuna, la dependencia y el GSE de su fila Simce y lo nombra con el directorio o, si no está, con la base de la Agencia.
- **D36-14**: el popup «ver establecimientos» sigue con el directorio vigente.
- **D36-15** (titular): pie del modal «Fuente: Agencia de Calidad de la Educación, bases por establecimiento; nombres: directorio oficial MINEDUC o, para establecimientos que ya no figuran en él, base de la Agencia».
- **D36-16** (titular): publicación con el procedimiento de `publicacion_github_pages.md`; push del titular.

## 9. Constantes y parámetros

| Constante | Antes | Después | Archivo | Motivo |
|---|---|---|---|---|
| `SUMA_NIVELES_MIN`, `SUMA_NIVELES_MAX` | en `36_funciones_trayectorias.R` | `99`, `101` en `10_utils/10_configuracion.R` | `10_configuracion.R` | D36-1 |
| `MOTIVOS_SIMBOLOGIA` | no existía | códigos 1 a 4 con su texto | `10_configuracion.R` | D36-1 |
| `CODIGOS_LITERALES_SIMBOLOGIA` | no existía | literales de las bases antiguas a 1, 2 y 3 | `10_configuracion.R` | D36-1 |
| `UMBRAL_EVALUADOS` | filtro | aserción | `10_utils.R` | D36-1 |
| columnas de `simce_rbd.parquet` | 16 | 17 (`nom_rbd`) | `31_leer_normalizar.R` | D36-13 |

Fuente canónica de las vigentes: `10_utils/10_configuracion.R` y las plantillas de los pasos 33 y 36.

## 10. Arquitectura de archivos

Nuevos: `50_documentacion/activa/50_excepciones_estructura.md`, `decisiones/20261109_decision_inclusion_resultados_simbologia.md`, `decisiones/20260925_decision_cierre_pendientes_v34.md` y siete expedientes en `50_documentacion/encargos/202611/`. Retirado: `50_documentacion/traspasos/.gitkeep`. Escáner regenerado por el ejecutor al cierre.

## 11. Pendientes y ruta sugerida

**Inventario.**

1. **Pie del modal en el navegador.** Tipo: mejora visual (verificación). Contexto: D36-15 publicado sin mirada humana. Impacto: bajo. Complejidad: baja. Enfoque: abrir la URL pública, marcar la casilla, un territorio por comuna y un año antiguo. Criterio: el pie se lee completo y la lista muestra nombres en los resultados sin directorio.
2. **Clon del Mac (duda 2).** Tipo: deuda técnica. Contexto: `d501236`, sin la sesión 36, con un archivo sin versionar de `auditorias_externas/`. Precaución: no escribir desde el Mac sin `/apertura`; decidir antes qué hacer con el archivo. Criterio: `git status --porcelain` vacío y `HEAD` igual a `origin/main` en el Mac.
3. **Simce 2026 con el directorio 2026 (D36-2).** Bloqueado hasta que la Agencia publique (hacia abril de 2027). Al entrar el directorio 2026, `ANIO_DATOS_VIGENTE` de `30_construir_auxiliares.R` y las olas del referente cambian. Criterio: build con 2026 y las dos baterías en PASA.
4. **Glosario de la suite (Q-89).** Sin cambio desde v35: en la próxima regeneración de la suite.
5. **Pendientes del kit** (sesión del kit): `95_censar_estructura.R` acepta solo dos nombres `00_*` en la raíz (la excepción de `00_build.R` caduca al corregirlo); ERR-36-02 (`.git/info/exclude` del kit); `/apertura` sin `CLAUDE.md`; mensaje del validador L280 (D36-6); Q-99; falsos positivos E2 y E5 del verificador.
6. **Heredados sin cambio:** `feat/contrato-contexto` (D35-17), fin del referente y actualización anual del directorio, Q-70, dudas de v30 y v31, Museo Sans en la suite.

**Cerrado en esta sesión:** pendientes 2 y 3 de v35 (documentación y nombre del archivo de decisiones), R-30 y la ordenación de la raíz.

**Deuda técnica.** El popup «ver establecimientos» usa el directorio vigente (D36-14): un establecimiento cerrado cuenta en las cifras y no aparece en ese popup. Las baterías siguen siendo manuales (D35-21).

**Auditoría de cierre (5.6).** Datos crudos aislados: sí. Pipeline de cero: sí (`00_build.R` código 0 en la reemisión). Check por transformación crítica: sí (M9 a M12, 35 pruebas de la vista, 9 casos de `agregar_ponderado`). Reproducible: sí; el motor por contenido (A35-8). Constantes nombradas: sí (§9). Nombres sin tildes: sí. Estructura conforme: sí (censo 0 estructurales). Guarda de locale: sí. Sin atribución: sí (`<ATRIB>` `0 0` en cada encargo).

### Compuerta de dudas (2 registradas)

| # | supuesto | predicado | medición |
|---|---|---|---|
| 1 | El pie de D36-15 se ve completo en el modal publicado | Con la casilla marcada, el pie del modal muestra el texto de D36-15 completo a 375 px y a 1280 px | El titular abre https://tomgc.github.io/slep_simce_adecuado/, marca la casilla y mira el pie en las dos anchuras |
| 2 | El clon del Mac puede abrir la próxima sesión | `git -C ~/Projects/slep_simce_adecuado status --porcelain` está vacío y `HEAD` es ancestro de `origin/main` | En el Mac: `git -C ~/Projects/slep_simce_adecuado status --porcelain; git -C ~/Projects/slep_simce_adecuado fetch && git -C ~/Projects/slep_simce_adecuado merge-base --is-ancestor HEAD origin/main && echo ok` |

**Ruta sugerida.** (1) Pendiente 1 al abrir, en minutos. (2) Pendiente 2 antes de trabajar en el Mac. (3) Pendiente 5 en una sesión del kit. Diferir 3 y 4 hasta que haya datos o regeneración de la suite.

## 12. Instrucciones específicas para la próxima sesión

- 🔒 Todas las 🔒 de v35 §12 siguen vigentes.
- 🔒 Entra al cálculo toda fila con los tres porcentajes sumando entre `SUMA_NIVELES_MIN` y `SUMA_NIVELES_MAX`, con o sin marca; `nalu < 10` con resultado detiene el build (D36-1).
- 🔒 El modal de simbología usa la misma regla de pertenencia que las cifras (D36-13); M12 lo prueba y no se relaja.
- 🔒 Los registros que citan hashes anteriores a las reescrituras no se reescriben; se resuelven con el mapa y con el par de §7 (D36-11).
- ✅ ANTES de verificar un texto de la interfaz en el motor construido, buscarlo como cadena de JavaScript, no con marcado (A36-1).
- ✅ ANTES de escribir en el repo desde el puente, `git check-ignore` de la ruta (A36-3).
- ✅ ANTES de lanzar un encargo, nombrar la estación y la carpeta (A36-5).
- ⚠️ NO dar al titular comandos en sintaxis de Git Bash: en Windows, PowerShell (A36-4).
- ⚠️ NO correr git que escriba desde el puente, y todo git de lectura con `GIT_OPTIONAL_LOCKS=0`.
- ⚠️ NO pedir purga a GitHub de los commits viejos (D36-12).

## 13. Fragmentos de código de referencia

```bash
# Verificar en el motor construido un texto de la interfaz (A36-1), desde la raíz del repo.
command grep -c -F 'base de la Agencia"' 40_salidas/motor_comparacion.html
```

```powershell
# Push y apertura del motor desde PowerShell (A36-4).
git -C "C:\GitHub\slep_simce_adecuado" push
Start-Process "C:\GitHub\slep_simce_adecuado\40_salidas\motor_comparacion.html"
```

Los patrones estables siguen en `CLAUDE.md` (local), en los scripts de los pasos 33 y 36 y en `10_utils/`.

## 14. Reapertura

Tipo de sesión: CONTINUATION. El protocolo (`POLITICA_PROYECTO.md` y `SETTINGS_Y_PROMPTS_OPERACIONALES.md`) vive en la knowledge base del Project y se lee desde ahí; no se adjunta.

**Se adjunta:** `traspaso_cierre_v36.md`. El backlog y el escáner no se adjuntan.

**Estado:** `main` en `30c46a4`, previo al commit de cierre, publicado y verificado en Pages. D36-1 y D36-13 en producción; censo sin desvíos estructurales; quedan la mirada del pie del modal, el clon del Mac y los puntos del kit.

**Foco propuesto:** mirar el pie del modal publicado (pendiente 1) y, si la sesión es en el Mac, sincronizar su clon antes de trabajar (pendiente 2).

Si alguno de los archivos listados cambió entre sesiones, adjuntar la versión más actualizada al abrir y avisarlo en el mensaje de apertura.

## 15. Errores del asistente

12 errores, registrados en el momento en `claude/errores_s36.md` del Project y en `anexos/50_insumo_errores_s36.md.txt` del primer expediente (ERR-36-01 a 05). Van con los diez campos.

**ERR-36-01**
- `momento`: texto de inicio de la sesión 36, redactado tras el cierre v35 (2026-09-27).
- `disparador`: usuario lo corrigió.
- `que_paso`: el texto de inicio traía un hueco «[pega aquí el eco completo que imprime /apertura]», que le dejaba al titular armar el mensaje con textos de otra fuente.
- `regla_violada`: preferencia del Project «el mensaje de apertura se entrega como un solo bloque completo y autosuficiente, sin collage»; SETTINGS §1.2.6, entrega materializada (la autoría del artefacto es del asistente).
- `causa_raiz`: seguí la forma de SETTINGS §1.2.1 (el titular pega el eco de /apertura) sin contrastarla con la preferencia, que ya estaba en la memoria; el eco no existía aún y, en vez de diseñar un texto que no lo necesitara, dejé el hueco.
- `salvaguarda_presente`: memoria del Project (preferencias) y userPreferences (materialización).
- `patron`: PAT-07, preferencia leída no propagada a la forma del entregable.
- `gatillo_observable`: restriccion-no-propagada: un texto para el titular con un marcador entre corchetes que él debe reemplazar.
- `intentos_previos`: 0.
- `costo`: un turno del titular y una segunda emisión del texto.

**ERR-36-02**
- `momento`: apertura de emergencia, resolución del kit sucio que detenía `/apertura`.
- `disparador`: asistente lo señaló espontáneamente.
- `que_paso`: escribí tres rutas en `.git/info/exclude` de `herramientas_dev` desde el puente.
- `regla_violada`: traspaso v35 §12, «⚠️ NO correr git que escriba desde el puente».
- `causa_raiz`: actué sobre el kit antes de leer el traspaso, bajo la urgencia de abrir la sesión.
- `salvaguarda_presente`: traspaso v35.
- `patron`: PAT-09, costo sobre regla.
- `gatillo_observable`: costo-sobre-regla: escritura dentro de `.git/` desde el puente.
- `intentos_previos`: 0.
- `costo`: tres rutas del kit que hoy necesitan `git add -f` (o quitar las líneas) para versionarse.

**ERR-36-03**
- `momento`: diagnóstico de la discrepancia 55/54 en Costa Central.
- `disparador`: asistente lo señaló espontáneamente, al preparar la propuesta.
- `que_paso`: afirmé que 8.216 filas con resultados publicados quedaban fuera por el umbral de 10 evaluados; eran filas con los tres porcentajes en 0, que no son resultados, y recomendé la opción B sobre esa premisa.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente tipo 3 (la cifra se contó, pero su clasificación no se midió).
- `causa_raiz`: usé «porcentaje no vacío» como prueba de resultado publicado sin comprobar que los tres porcentajes sumaran 100.
- `salvaguarda_presente`: SETTINGS; la regla de suma ya existía en `36_funciones_trayectorias.R` (`SUMA_NIVELES_MIN`, `SUMA_NIVELES_MAX`).
- `patron`: PAT-13, criterio que mide un proxy (porcentaje no vacío) y no el riesgo (resultado publicado).
- `gatillo_observable`: cifras-datos: un conteo de «resultados publicados» sin condición de coherencia de los porcentajes.
- `intentos_previos`: 0.
- `costo`: una recomendación corregida en el turno siguiente.

**ERR-36-04**
- `momento`: propuesta de nota metodológica (primera y segunda versión).
- `disparador`: usuario lo corrigió.
- `que_paso`: afirmé que con la marca 2 la Agencia no muestra el puntaje promedio pero sí la distribución por estándares; las 2.008 filas con marca y resultado válido traen puntaje promedio publicado.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente tipo 1 y regla de estructura (la fuente de una conducta es el dato, no su descripción).
- `causa_raiz`: tomé el rótulo de la glosa («razón por la que no se muestra el puntaje promedio») como descripción de lo que la base trae, sin contarlo.
- `salvaguarda_presente`: SETTINGS; A35-1 y ERR-35-18 (documentación tomada como fuente del comportamiento).
- `patron`: PAT-01, afirmación desde la documentación y no desde los datos.
- `gatillo_observable`: afirmar-sin-leer: afirmación sobre lo que la Agencia publica sin recuento de `prom_*` en las filas marcadas.
- `intentos_previos`: 1 (ERR-36-03, misma familia en el mismo diagnóstico).
- `costo`: una nota metodológica reescrita y un turno del titular.

**ERR-36-05**
- `momento`: redacción del encargo `20261109_inclusion_resultados_simbologia`, inserción de los md5 en §4bis.
- `disparador`: asistente lo señaló espontáneamente, al leer el informe de la segunda ronda de auditoría.
- `que_paso`: un reemplazo global de dos comillas invertidas por una, pensado para los md5, colapsó las 17 cercas de código del encargo a una sola comilla.
- `regla_violada`: SETTINGS §1.2.6, «Generar, verificar, consumar» (el reemplazo no tuvo verificación intermedia del resto del archivo).
- `causa_raiz`: apliqué un reemplazo de texto a todo el archivo cuando su objetivo eran cuatro celdas, sin contar antes sus coincidencias.
- `salvaguarda_presente`: SETTINGS; la auditoría de segunda ronda lo detectó antes de la entrega.
- `patron`: PAT-02, edición global sin verificación intermedia.
- `gatillo_observable`: otro: reemplazo de texto sin recuento previo de coincidencias en el archivo completo.
- `intentos_previos`: 0.
- `costo`: una corrección del encargo; nada llegó a la ejecución.

**ERR-36-06**
- `momento`: redacción del encargo `20261109_inclusion_resultados_simbologia`, regla 9.
- `disparador`: asistente lo señaló espontáneamente, en la auditoría de redacción.
- `que_paso`: la regla 9 del encargo no nombraba los insumos de listado y olas que la tarea consumía.
- `regla_violada`: protocolo de encargos v1.11, INSUMOS como lista cerrada.
- `causa_raiz`: enumeré los insumos desde la tarea principal sin recorrer las dependencias de la vista.
- `salvaguarda_presente`: protocolo v1.11 y auditoría de redacción.
- `patron`: PAT-07, restricción leída no propagada a la forma del entregable.
- `gatillo_observable`: restriccion-no-propagada: insumo consumido por una tarea que no figura en INSUMOS.
- `intentos_previos`: 0.
- `costo`: una corrección del encargo antes del lanzamiento.

**ERR-36-07**
- `momento`: comandos para el titular (apertura del motor y push), dos veces en la sesión 36.
- `disparador`: usuario lo corrigió («por favor deja de cometer este error»).
- `que_paso`: entregué comandos con sintaxis de Git Bash (`/c/...`, `start ""`) a un titular que usa PowerShell.
- `regla_violada`: contexto de la estación (`estacion_windows`, titular en PowerShell); entrega materializada y ejecutable.
- `causa_raiz`: copié la sintaxis del entorno de Claude Code (Git Bash) a los comandos del titular sin distinguir quién los corre.
- `salvaguarda_presente`: ninguna escrita antes del error; ahora, preferencia en la memoria del Project.
- `patron`: PAT-07, restricción leída no propagada a la forma del entregable.
- `gatillo_observable`: restriccion-no-propagada: comando para el titular con ruta `/c/` o `start ""`.
- `intentos_previos`: 1 (la primera vez en la misma sesión).
- `costo`: dos errores de ejecución del titular y un turno de corrección.

**ERR-36-08**
- `momento`: redacción del encargo `20261109_ordenacion_estructura`, FASE L.
- `disparador`: asistente lo señaló espontáneamente, al leer el log del encargo.
- `que_paso`: el encargo no fijó la forma literal del punto 4 del Cierre («Verificación de invariantes», viñetas `- 🔒N <qué>: PASA (<evidencia>)`); el ejecutor la escribió con otra forma, el validador rechazó la ficha dos veces y quedó sin validar.
- `regla_violada`: SETTINGS §1.2.6, regla «Encargos a Claude Code» (lectura completa del log y aprendizaje de él): el log de `20261109_documentacion_s36` ya registraba el mismo tropiezo.
- `causa_raiz`: reutilicé la plantilla del encargo anterior sin incorporar el tropiezo que su propio log documentaba.
- `salvaguarda_presente`: log de `20261109_documentacion_s36`, `98_indexar_encargos.R --validar`.
- `patron`: PAT-07, aprendizaje leído no propagado a la forma del entregable.
- `gatillo_observable`: restriccion-no-propagada: encargo que remite al Cierre de `<PROT>` sin la forma literal del punto 4.
- `intentos_previos`: 1 (mismo tropiezo en `20261109_documentacion_s36`, registrado por el ejecutor).
- `costo`: dos validaciones y una ficha sin validar que el titular debe revalidar a mano.

**ERR-36-09**
- `momento`: redacción del encargo `20261111_modal_simbologia_sin_directorio`, §1.
- `disparador`: revisor de la auditoría de redacción, ronda 1.
- `que_paso`: afirmé que una fila de un RBD sin directorio trae `cod_depe2` NA y no entra en territorios con dependencia; `cod_depe2` sale del directorio completo y las 25 filas traen dependencia 1, 2 o 3.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente (marqué «fuente: lectura» una inferencia que no medí).
- `causa_raiz`: confundí el directorio completo que usa `31` con el subconjunto en funcionamiento que forma `DATA.establecimientos`, sin leer `30_construir_auxiliares.R`.
- `salvaguarda_presente`: auditoría de redacción.
- `patron`: PAT-01, afirmación desde una lectura parcial del código y no desde los datos.
- `gatillo_observable`: afirmar-sin-leer: premisa sobre valores de una columna sin recuento.
- `intentos_previos`: 2 (ERR-36-03 y ERR-36-04, misma familia).
- `costo`: una premisa y una exclusión reescritas antes de la entrega.

**ERR-36-10**
- `momento`: redacción del encargo `20261111_pie_y_publicacion`, §5 T1 paso 4 y §6 paso 2.
- `disparador`: el ejecutor (detención 2 de T1, FALLA de la verificación del pie sobre el motor construido).
- `que_paso`: pedí buscar `base de la Agencia</span>` en el motor construido; el build transpila el JSX con Babel y el pie queda como cadena de JavaScript sin `</span>`. T1 se congeló sin commit y no se publicó.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente (el esperado `1` no tenía medición: supuse que el motor construido conserva el marcado de la plantilla).
- `causa_raiz`: diseñé una verificación sobre el artefacto construido sin mirar cómo `33_generar_html.R` transforma la plantilla; las dos rondas de auditoría tampoco lo simularon con el build real.
- `salvaguarda_presente`: auditoría de redacción nivel 2 (sin build real en la simulación); regla de detención del encargo, que contuvo el daño.
- `patron`: PAT-13, criterio que mide un proxy (marcado de la plantilla) y no el riesgo (texto en el motor publicado).
- `gatillo_observable`: afirmar-sin-leer: esperado sobre una salida generada sin haberla inspeccionado.
- `intentos_previos`: 0.
- `costo`: un encargo completo de 16 minutos sin publicar y una reemisión.

**ERR-36-11**
- `momento`: preparación de la lista de SHA para la purga en GitHub (D36-12).
- `disparador`: asistente lo señaló espontáneamente, al medir `git status` después de la escritura.
- `que_paso`: escribí `40_salidas/shas_purga_github.txt` en el repo suponiendo que `40_salidas/` estaba ignorada entera; `.gitignore` ignora solo algunas extensiones y el `.txt` quedó como archivo sin seguimiento, que el puente no puede borrar.
- `regla_violada`: preferencia del titular de no dejarle archivos sin destino; disciplina de árbol limpio (git del puente solo de lectura, escrituras solo donde corresponde).
- `causa_raiz`: comprobé el ignore después de escribir y no antes (`git check-ignore` debía ir primero).
- `salvaguarda_presente`: `git check-ignore`, que corrí tarde.
- `patron`: PAT-02, escritura sin verificación previa del efecto.
- `gatillo_observable`: otro: escritura en el repo desde el puente fuera de un encargo.
- `intentos_previos`: 0.
- `costo`: un archivo sin seguimiento en el repo que el titular debe mover.
**ERR-36-12**
- `momento`: entrega del paquete de cierre v36.
- `disparador`: titular lo señaló («así no se cierra. se cierra solo con /cierre»).
- `que_paso`: di la instrucción `/cierre 50_documentacion/andamios/paquete_cierre_v36.md`; el comando se invoca sin argumentos y toma el paquete de `andamios/`.
- `regla_violada`: SETTINGS §2, protocolo de cierre (el titular guarda el paquete y corre `/cierre`); marcador de fuente sobre la forma del comando.
- `causa_raiz`: escribí la sintaxis del comando de memoria, sin releer §2 de SETTINGS v44 en la sesión.
- `salvaguarda_presente`: SETTINGS v44 §2 en la knowledge base, no releído antes de redactar.
- `patron`: PAT-01, afirmación sin fuente leída en la sesión.
- `gatillo_observable`: afirmar-sin-leer: sintaxis de un comando del kit dada sin leer su definición.
- `intentos_previos`: 0.
- `costo`: un turno del titular y una reentrega del paquete.


### Fricciones

- friccion: comandos en sintaxis de Git Bash para una PowerShell («por favor deja de cometer este error») → comandos solo en PowerShell, registrado como preferencia del Project.
- friccion: estimación de duración de un encargo (1,5 a 3 horas contra 33 minutos reales) → sin estimaciones de tiempo sin medición.
- friccion: encargo lanzado en el Mac por no nombrar la estación → la estación va en el mensaje de lanzamiento (A36-5).
