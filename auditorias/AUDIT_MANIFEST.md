# AUDIT_MANIFEST: Auditoría integral slep_simce_adecuado

## Identificación

| Campo | Valor |
|---|---|
| Fecha de auditoría | 2026-10-02 |
| Inicio | 2026-10-02 19:07 UTC (primer comando); marca registrada 19:10:39 UTC |
| Término | 2026-10-02 19:46 UTC |
| Commit auditado | `75014460eed610827bb2c9fdc8a29ee48945f80b` (2026-09-27 00:00:18 -0300, «docs(cierre): estado de sesion v35») |
| Rama de trabajo | `claude/nice-shannon-kmkdc7` |
| Estado del working tree al inicio | limpio (`git status`: «nothing to commit, working tree clean») |
| Clon | superficial: `git rev-parse --is-shallow-repository` = `true`; 50 commits visibles |
| Escrituras en el proyecto | solo `auditorias/` (los cuatro archivos de esta auditoría). Ningún otro archivo del repositorio fue modificado. |

## Entorno de ejecución

| Componente | Versión |
|---|---|
| Sistema operativo | Ubuntu 24.04.4 LTS, kernel Linux 6.18.44 (contenedor en la nube, usuario root) |
| R | 4.5.3 (2026-03-11), instalado desde conda-forge con micromamba 2.9.0 en el scratchpad (fuera del proyecto) |
| R declarado en `renv.lock` | 4.5.2 |
| renv | 1.3.0 instalado; 1.1.4 declarado. `renv::restore()` NO ejecutado: CRAN (`cloud.r-project.org`) bloqueado por la política de red del entorno (403 del proxy). |
| Chromium | 141.0.7390.37 (`/opt/pw-browsers/chromium-1194`), lanzado con un envoltorio `--no-sandbox` (el contenedor corre como root) |
| Locale | proceso lanzado con `LANG` vacío; la guarda del proyecto corrigió en caliente a `C.UTF-8` (es_ES.UTF-8 y en_US.UTF-8 no existen en el contenedor) |

Paquetes R usados por el pipeline (lock vs instalado):

| Paquete | renv.lock | Instalado |
|---|---|---|
| arrow | 24.0.0 | 25.0.0 |
| V8 | 8.2.0 | 8.2.0 |
| chromote | 0.5.1 | 0.5.1 |
| dplyr | 1.2.0 | 1.2.1 |
| here | 1.0.1 | 1.0.2 |
| fs | 2.1.0 | 2.1.0 |
| readxl | 1.4.5 | 1.5.0.1 |
| openxlsx | 4.2.8.1 | 4.2.9 |
| jsonlite | 2.0.0 | 2.0.0 |
| readr | 2.1.5 | 2.2.0 |
| tidyr | 1.3.1 | 1.3.2 |
| tibble | 3.3.0 | 3.3.1 |
| purrr | 1.0.4 | 1.2.2 |
| stringr | 1.5.1 | 1.6.0 |
| openssl | 2.4.2 | 2.4.2 |
| renv | 1.1.4 | 1.3.0 |
| processx | 3.9.0 | 3.9.0 |
| websocket | 1.4.4 | 1.4.4 |

Dependencias JavaScript vendorizadas (medidas con `openssl dgst -sha384 -binary | openssl base64 -A`):

| Archivo | Versión en el archivo | sha384 (base64) | ¿Verificado por el build? | ¿Incrustado en el HTML publicado? |
|---|---|---|---|---|
| react.production.min.js | 18.3.1 | DGyLxAyjq0f9SPpVevD6IgztCFlnMF6oW/XQGmfe+IsZ8TqEiDrcHkMLKI6fiB/Z | sí (coincide con `VENDOR_JS`) | sí (motor) |
| react-dom.production.min.js | 18.3.1 | gTGxhz21lVGYNMcdJOyq01Edg0jhn/c22nsx0kyqP0TxaV5WVdsSH1fSDUf5YJj1 | sí | sí (motor) |
| babel.min.js | 7.29.0 | m08KidiNqLdpJqLq95G/LEi8Qvjl/xUYll3QILypMoQ65QorJ9Lvtp2RXYGBFj1y | sí | no (solo transpila en V8 durante el build) |
| d3.min.js | 7.9.0 | CjloA8y00+1SDAUkjs099PVfnY2KmDC2BZnws9kh8D/lX1s46w6EPhpXdqMfjK6i | **no** (solo existencia) | sí (motor) |
| pako.min.js | 2.1.0 | rNlaE5fs9dGIjmxWDALQh/RBAaGRYT5ChrzHo6tRfgrZ36iRFAiquP5g41Jsv+0j | **no** (solo existencia) | sí (motor) |
| fuentes/gobCL_Regular.otf |: | md5 0257bb4b62d5ec557627aa0136f1e1dc | sí (md5) | sí (ambas páginas) |
| fuentes/gobCL_Bold.otf |: | md5 a7407ed6a70160cdb96021f83808a94c | sí (md5) | sí (ambas páginas) |

## Condición que limita la reproducibilidad de esta auditoría

`20_insumos/auxiliares/directorio_oficial_ee.csv` no está versionado (`.gitignore:44`) y no estaba en el contenedor. El portal de MINEDUC estaba bloqueado por la red. Para ejecutar el pipeline se construyó, **fuera del proyecto**, un directorio SUSTITUTO derivado del producto publicado (catálogo `establecimientos`, `sleps`, `comunas` y `simce_rbd` del JSON de `docs/index.html`) más los XLSX. Ese sustituto:

- no contiene MRUN ni ningún dato personal;
- reproduce las 11 columnas que exige el paso 30;
- tiene 10.945 operativos más 256 RBD no operativos con resultado;
- **no es independiente** del producto: sirve para probar que el código del commit reproduce `docs/` y para las pruebas de idempotencia, adversariales y de baterías. NO sirve para verificar la clasificación de dependencia ni el catálogo SLEP contra MINEDUC.

Todas las ejecuciones se hicieron en copias del repositorio en el scratchpad (`work_A`, `work_B`, `adv/w_ADVnn`), nunca en el proyecto.

## Archivos auditados (lectura)

- Raíz: `README.md`, `NOTICE`, `LICENSE`, `.gitignore`, `.Renviron.example`, `.Rprofile`, `renv.lock`, `renv/settings.json`, `renv/activate.R` (cabecera), `slep_simce_adecuado.Rproj`, `00_build.R`, `00_escanear_proyecto.R`.
- `10_utils/`: `10_configuracion.R`, `10_locale.R`, `10_utils.R`, `10_html.R`, `10_validar_portabilidad.R`, los cinco JS vendorizados y las dos fuentes.
- `30_procesamiento/`: `30_construir_auxiliares.R`, `31_leer_normalizar.R`, `32_agregar_comunal.R`, `33_generar_html.R`, `33_motor_template.html` (lógica JS completa de `SimceData`, exportación, avisos), `33_fragmento_sitio.html`, `33_verificar_motor.R`, `34_historico_pct_adecuado_costa_central.R`, `36_funciones_trayectorias.R`, `36_generar_trayectorias.R`, `36_trayectorias_template.html`, `36_verificar_trayectorias.R`.
- `20_insumos/simce/{2m,4b}/`: los 18 XLSX (todas sus hojas y columnas).
- `20_insumos/auxiliares/`: listado de archivos; `dim_slep_comunas.csv` vía el paso 36.
- `40_salidas/historico_pct_adecuado_costa_central.xlsx`.
- `docs/index.html`, `docs/trayectorias.html` (incluido el JSON embebido).
- `50_documentacion/`: `activa/backlog_acumulativo.md`, `publicacion_github_pages.md`, `gobernanza_datos.md`, `manifiesto_insumos.md`, `ESTADO.md`, `referencia_glosas_simce.md`, `informe_auditoria_prelanzamiento.md`, `50_datos_versionados_autorizados.md`, `decisiones/*.md`, `estructura/estructura_actual.md`, `traspasos/traspaso_cierre_v35.md`, `suite/*` (búsqueda de afirmaciones). La lectura documental extensa la hizo un subagente de solo lectura; sus afirmaciones usadas en hallazgos se reverificaron contra el código (ver AUDIT_EVIDENCE.md §E14).
- GitHub (solo metadatos, sin contenido): commit `61c3b9b` del repositorio `tomgc/slep_simce_adecuado`.

## Tests y controles ejecutados

| Control | Dónde | Resultado |
|---|---|---|
| `00_build.R` (corrida A1, locale C) | copia work_A | exit 0, 17 s |
| `00_build.R` (corridas A2, A3 sin limpiar) | work_A | exit 0; salidas byte a byte iguales a A1 |
| `00_build.R` (corrida B1, copia limpia, `LANG=C.UTF-8`) | work_B | exit 0; salidas byte a byte iguales a A1 |
| `33_verificar_motor.R` sin envoltorio de Chromium | work_A | 3 PASA, 5 FALLA (Chromium no arranca como root), exit 1 |
| `36_verificar_trayectorias.R` sin envoltorio | work_A | 29 PASA, 6 FALLA (mismo motivo), exit 1 |
| `33_verificar_motor.R` con envoltorio | work_A | 8/8 PASA, exit 0, 81 s |
| `36_verificar_trayectorias.R` con envoltorio | work_A | 35/35 PASA, exit 0, 37 s |
| `validar_portabilidad_autotest()` | copia | «Violación sembrada detectada: SI»; «Limpieza verificada: SI» |
| `validar_portabilidad()` con 7 violaciones sembradas | copia | detecta 5 de 7 (ver E9) |
| `34_historico_pct_adecuado_costa_central.R` | copia | exit 0; xlsx idéntico (valores) al versionado |
| `00_escanear_proyecto.R` | copia | exit 0; reescribe y poda archivos versionados de `50_documentacion/estructura/` |
| Casos sintéticos de borde B1–B12 | copia (funciones del proyecto) | ver E8 |
| 15 mutaciones adversariales (build + 2 baterías cada una) | copias `adv/w_ADVnn` | ver E10 |
| Apertura sin red de `docs/index.html` y `docs/trayectorias.html` | Chromium offline | render OK, 0 solicitudes no locales, 0 errores JS |
| Trazabilidad de 72 cifras del motor (SimceData en Chromium) | `docs/index.html` | 72/72 coinciden con recálculo independiente |

## Comandos y scripts ejecutados

Todos los scripts auxiliares de la auditoría están escritos en R, salvo el arnés adversarial (Bash) y una comparación HTML que se rehízo en R. Vivieron en el scratchpad y no se versionan. Su contenido esencial está transcrito en AUDIT_EVIDENCE.md:

| Script (scratchpad/aud) | Propósito |
|---|---|
| `extraer_json.R` | extrae el JSON de ambos HTML (gzip+base64 del motor; literal `var DATA=` de la vista) |
| `inspeccion_xlsx.R`, `anomalias.R` | esquema, hojas, marcas, A1–A4 de los 18 XLSX |
| `reconstruccion_xlsx.R` | lectura independiente con openxlsx y formato largo propio |
| `cotejo_simce_rbd.R` | JSON `simce_rbd` vs XLSX |
| `cotejo_comunal.R` | agregación comunal recalculada vs JSON `datos` |
| `cotejo_tray.R` | `nac`, 36 SLEP y referente recalculados vs DATA de la vista |
| `directorio_sustituto.R` | directorio sustituto sin datos personales (para ejecutar en copias) |
| `comparar_html.R` | comparación de HTML con y sin el bloque base64 |
| `navegador_publicado.R`, `traza_muestra.R` | apertura offline y trazabilidad de 72 cifras |
| `bordes.R` | casos sintéticos de borde |
| `patrones_red.R` | qué detectan los patrones de red de M1 y D12 |
| `universo.R` | cascada de exclusiones y conteos |
| `adv/mutar.sh`, `adv/correr.sh` | arnés de mutaciones adversariales |

## Outputs inspeccionados

- `docs/index.html` (sha256 `fac6f07f…8820`, 2.934.457 bytes) y `docs/trayectorias.html` (sha256 `c29ab878…7b1d`, 2.212.989 bytes).
- Salidas reconstruidas en work_A: `motor_comparacion.html` (sha256 `7d4ccd58…fa66`), `trayectorias_traspasos.html` (sha256 `c29ab878…7b1d`) y los seis parquet intermedios.

## Limitaciones

1. Sin `directorio_oficial_ee.csv` real: la clasificación de dependencia, el catálogo SLEP, la comuna de los años A3 y los catálogos de comunas y establecimientos se verificaron solo por consistencia interna con el producto publicado, no contra MINEDUC.
2. Sin `renv::restore()`: versiones de paquetes distintas del lock (tabla de arriba).
3. Solo Linux: el contrato macOS/Windows no se pudo ejecutar.
4. Clon superficial: el historial anterior a los 50 commits visibles no se inspeccionó localmente. El commit `61c3b9b` se consultó por la API de GitHub (solo metadatos).
5. Chromium como root exigió `--no-sandbox` (envoltorio en el scratchpad); no altera la lógica de las baterías.
6. No se midió el rendimiento en equipos del equipo (solo en el contenedor).

Término de la auditoría: 2026-10-02 19:46 UTC, tras la verificación de consistencia entre los cuatro artefactos (AUDIT_EVIDENCE.md §E15).
