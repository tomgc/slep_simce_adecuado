# slep_simce_adecuado

Motor de comparación de resultados Simce por estándares de aprendizaje,
con foco en el % ponderado de estudiantes en nivel **Adecuado**, con opción de
desglosar la barra en los tres estándares (Adecuado / Elemental / Insuficiente).

Productos finales: dos archivos HTML standalone (JSON embebido, sin carga por
red) que el pipeline escribe en `40_salidas/` y que se publican en `docs/`:

- `motor_comparacion.html` (publicado como `docs/index.html`): el motor, que
  permite comparar entre comunas, SLEPs, regiones, establecimientos y el nivel
  nacional.
- `trayectorias_traspasos.html` (publicado como `docs/trayectorias.html`): la
  vista de trayectorias de los Servicios Locales.

GitHub Pages sirve `docs/` en https://tomgc.github.io/slep_simce_adecuado/.

## Stack

- R (Positron como entorno), con los paquetes fijados en `renv.lock` (`renv`).
- Lectura de xlsx: `readxl`.
- Almacenamiento intermedio: `arrow` (parquet).
- Manipulación: `dplyr`, `tidyr`, `purrr`.
- Rutas: `here`.
- JSON: `jsonlite`.
- Páginas: React y ReactDOM 18.3.1, D3 v7.9.0 y pako 2.1.0, vendorizados en
  `10_utils/` e incrustados en el motor. El JSX del motor se transpila en el
  build con Babel 7.29.0 dentro de `V8`, y `openssl` verifica el sha384 de
  React, ReactDOM y Babel. Las dos páginas incrustan la tipografía gobCL (ver
  `NOTICE`).
- Baterías de verificación: `chromote` con Google Chrome.

## Estructura

```
00_build.R                       # Orquestador del pipeline
00_escanear_proyecto.R           # Escáner canónico de estructura
10_utils/
  10_configuracion.R             # Guarda de locale, ruta_insumos() y años de la serie
  10_locale.R                    # Guarda de locale UTF-8
  10_utils.R                     # Funciones reutilizables
  10_html.R                      # Utilidades de los generadores de HTML (pasos 33 y 36)
  10_validar_portabilidad.R      # Validador de portabilidad (lo corre 00_build.R)
  d3.min.js                      # D3 v7 minificado (incrustado en el motor)
  pako.min.js                    # pako (descomprime el JSON del motor)
  react.production.min.js        # React 18 (incrustado en el motor)
  react-dom.production.min.js    # ReactDOM 18 (incrustado en el motor)
  babel.min.js                   # Babel (transpila el JSX en el build)
  fuentes/                       # Tipografía gobCL (ver NOTICE)
20_insumos/
  simce/4b/                      # xlsx por año (4° Básico)
  simce/2m/                      # xlsx por año (2° Medio)
  auxiliares/                    # directorio oficial, listado SLEP, etc.
30_procesamiento/
  30_construir_auxiliares.R      # Insumos auxiliares -> parquets de catálogo
  31_leer_normalizar.R           # xlsx Simce -> simce_rbd.parquet
  32_agregar_comunal.R           # Agregación comuna × GSE × dependencia × prueba × nivel × año
  33_generar_html.R              # JSON + motor_comparacion.html
  33_motor_template.html         # Plantilla React/D3 del motor
  33_fragmento_sitio.html        # Encabezado y menú comunes de las dos páginas
  33_verificar_motor.R           # Batería del motor
  34_historico_pct_adecuado_costa_central.R  # Histórico de Costa Central (no lo corre 00_build.R)
  36_funciones_trayectorias.R    # Funciones de la vista de trayectorias
  36_generar_trayectorias.R      # Datos + trayectorias_traspasos.html
  36_trayectorias_template.html  # Plantilla de la vista
  36_verificar_trayectorias.R    # Batería de la vista
40_salidas/
  intermedios/                   # parquets generados (no versionados)
  motor_comparacion.html         # Producto final (no versionado)
  trayectorias_traspasos.html    # Producto final de la vista (no versionado)
  historico_pct_adecuado_costa_central.xlsx  # Salida del paso 34
50_documentacion/
docs/                            # Lo publicado en GitHub Pages
  index.html                     # Copia de 40_salidas/motor_comparacion.html
  trayectorias.html              # Copia de 40_salidas/trayectorias_traspasos.html
```

## Datos de entrada

Los xlsx de Simce provienen del portal
[informacionestadistica.agenciaeducacion.cl](https://informacionestadistica.agenciaeducacion.cl)
y se versionan en el repo junto al código (son datos públicos, < 25 MB en total).
No se requiere configuración adicional de rutas.

El **directorio oficial MINEDUC** (`20_insumos/auxiliares/directorio_oficial_ee.csv`)
**no se versiona**: contiene la columna MRUN (RUN enmascarado de sostenedores
persona natural), un dato personal según la Ley 21.719 que el pipeline no utiliza.
Se descarga del portal de datos abiertos de MINEDUC (directorio oficial de
establecimientos educacionales) y se coloca en `20_insumos/auxiliares/`. Detalle en
[`50_documentacion/activa/gobernanza_datos.md`](50_documentacion/activa/gobernanza_datos.md).

## Cómo correr en una máquina nueva

1. Clonar el repo:
   ```bash
   git clone <url-del-repo>
   cd slep_simce_adecuado
   ```
2. Abrir `slep_simce_adecuado.Rproj` en Positron. Esto ancla `here::here()`
   a la raíz del proyecto automáticamente.
3. Descargar el **directorio oficial MINEDUC** (no versionado, ver "Datos de
   entrada") y colocarlo en `20_insumos/auxiliares/directorio_oficial_ee.csv`.
   Sin este archivo, los pasos 30 y 31 del pipeline fallan.
4. Restaurar los paquetes de `renv.lock` (una sola vez; ver "Portabilidad
   cross-OS"):
   ```r
   renv::restore()
   ```
5. Correr el pipeline:
   ```r
   source("00_build.R")
   ```
6. Las dos salidas quedan en `40_salidas/motor_comparacion.html` y
   `40_salidas/trayectorias_traspasos.html`.
7. Verificarlas con las dos baterías, que terminan con código 0 solo si todas
   sus pruebas pasan (necesitan Google Chrome):
   ```bash
   Rscript 30_procesamiento/33_verificar_motor.R
   Rscript 30_procesamiento/36_verificar_trayectorias.R
   ```
8. Publicar: correr antes las dos baterías (decisión D35-21 en
   `50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md`)
   y copiar las dos salidas, íntegras, a `docs/index.html` y
   `docs/trayectorias.html` (procedimiento en
   `50_documentacion/activa/publicacion_github_pages.md`).

## Reglas de cálculo

- **Indicador principal:** % ponderado de estudiantes en nivel Adecuado.
- **Desglose opcional:** el motor puede mostrar los tres estándares apilados
  (Adecuado / Elemental / Insuficiente) mediante un toggle. Cada nivel se
  agrega con la misma ponderación; los tres se normalizan a 100 en el apilado.
- **Fórmula de agregación** (idéntica para los tres niveles):
  ```
  % nivel = sum(nalu * palu_eda_<nivel> / 100) / sum(nalu) * 100
  ```
  donde `<nivel>` es `ade` (adecuado), `ele` (elemental) o `ins` (insuficiente).
- **Filtros de exclusión (umbral MINEDUC):**
  - Establecimientos con `nalu < 10` se excluyen.
  - Establecimientos con `marca_<prueba><nivel>_rbd` distinto de NA se excluyen.
  - Estos filtros gobiernan las filas para los tres niveles por igual, de modo
    que el % Adecuado es idéntico exista o no el desglose Elem/Insuf.
- **Segmentación por GSE:** en la vista de comparación del motor, todo
  resultado se reporta por GSE (Bajo / Medio bajo / Medio / Medio alto / Alto).
  El panorama territorial del motor combina los cinco grupos en una sola
  distribución ("GSE combinado") y la vista de trayectorias ofrece, junto a cada
  grupo, "Todos los grupos"; las dos pantallas lo indican.
- **No se mezclan** pruebas (Lectura / Matemática) ni niveles (4B / 2M)
  entre sí en el motor. La vista de trayectorias ofrece además una serie que
  los combina ("Todas las pruebas y niveles").
- **Vista de trayectorias:** usa la misma fórmula y los mismos filtros, y solo
  toma filas con los tres niveles publicados y una suma de niveles entre 99 y
  101.
- **Clasificación de dependencia (importante).** La dependencia de cada
  establecimiento es la **vigente** (del directorio oficial) y se aplica a toda
  la serie histórica. Un Servicio Local de Educación Pública (SLEP) agrupa a sus
  establecimientos también en los años previos a su traspaso, cuando la gestión
  era municipal; por eso las cifras anteriores al año de traspaso no son
  atribuibles a la gestión del SLEP. El motor lo advierte con un disclaimer en
  cada punto donde se selecciona dependencia SLEP.

## Responsabilidades por archivo

- **`00_build.R`**: orquesta el pipeline completo. Carga `10_configuracion.R`
  (guarda de locale) y `10_utils.R`, corre `validar_portabilidad()` (una falla
  crítica detiene el build) e invoca en orden los pasos 30, 31, 32, 33 y 36 de
  `30_procesamiento/`.
- **`00_escanear_proyecto.R`**: genera el snapshot de estructura en
  `50_documentacion/estructura/` y auto-poda los snapshots antiguos (retiene 2).
- **`10_utils/10_configuracion.R`**: guarda de locale UTF-8, `ruta_insumos()`
  (los insumos viven en el propio repositorio) y las constantes `ANIO_INICIO` y
  `ANIOS_SIN_SIMCE`. Lo cargan `00_build.R` y cada paso.
- **`10_utils/10_utils.R`**: `agregar_ponderado(df, group_vars)` aplica filtros
  MINEDUC y agrega el % ponderado por nº de evaluados. Devuelve `pct_adecuado`
  siempre, y `pct_elemental`/`pct_insuficiente` cuando las columnas
  `palu_eda_ele`/`palu_eda_ins` están presentes en `df`.
- **`30_construir_auxiliares.R`**: insumos auxiliares (xlsx y el directorio
  oficial) → parquets de catálogo (comunas, establecimientos, SLEPs).
- **`31_leer_normalizar.R`**: lee los xlsx crudos por nivel/año, normaliza,
  valida columnas y emite `simce_rbd.parquet` (formato largo: una fila por
  establecimiento × prueba × año × nivel).
- **`32_agregar_comunal.R`**: agrega `simce_rbd.parquet` a
  `comuna × GSE × dependencia × prueba × nivel × año` con `agregar_ponderado()`.
  Salida: `simce_comunal.parquet`.
- **`33_generar_html.R`**: construye el JSON consolidado y lo embebe en
  `33_motor_template.html` para producir el motor final.
- **`36_generar_trayectorias.R`**: calcula los datos de la vista con
  `36_funciones_trayectorias.R`, a partir de los intermedios y del catálogo de
  olas (`20_insumos/auxiliares/dim_slep_comunas.csv`); los inserta en
  `36_trayectorias_template.html` y escribe `40_salidas/trayectorias_traspasos.html`.
- **`33_verificar_motor.R`** y **`36_verificar_trayectorias.R`**: baterías del
  motor y de la vista. Leen las salidas de `40_salidas/` (las pruebas de
  navegador, con `chromote`) y terminan con código 0 solo si todas sus pruebas
  pasan. Se corren antes de cada copia a `docs/` (D35-21).

## Esquemas de datos

### simce_rbd.parquet (formato largo)

| Columna       | Tipo      | Notas                                |
|---------------|-----------|--------------------------------------|
| anio          | integer   | 2014–2018, 2022–2025                 |
| nivel         | character | "4b" o "2m"                          |
| prueba        | character | "lect" o "mate"                      |
| rbd           | character | ID establecimiento                   |
| cod_com_rbd   | character | Código comuna                        |
| nom_com_rbd   | character | Nombre comuna                        |
| cod_grupo     | character | "1".."5" (GSE)                       |
| cod_depe2     | character | Dependencia agrupada (1..5, actual)  |
| nalu          | integer   | N° evaluados                         |
| palu_eda_ade  | double    | % en estándar adecuado               |
| palu_eda_ele  | double    | % en estándar elemental              |
| palu_eda_ins  | double    | % en estándar insuficiente           |
| marca         | character | Marca de supresión (NA si válido)    |
| preliminar    | logical   | TRUE si viene de un `_preliminar`    |

### simce_comunal.parquet

| Columna       | Tipo      | Notas                                |
|---------------|-----------|--------------------------------------|
| anio          | integer   |                                      |
| nivel         | character |                                      |
| prueba        | character |                                      |
| cod_com_rbd   | character |                                      |
| nom_com_rbd   | character |                                      |
| cod_reg_rbd   | character | Código región                        |
| nom_reg_rbd   | character | Nombre región                        |
| cod_grupo     | character |                                      |
| cod_depe2     | character | Dependencia agrupada (1..5, actual)  |
| pct_adecuado  | double    | % ponderado agregado, adecuado       |
| pct_elemental | double    | % ponderado agregado, elemental      |
| pct_insuficiente | double | % ponderado agregado, insuficiente   |
| n_evaluados   | integer   | sum(nalu) tras filtros MINEDUC       |
| n_estab       | integer   | N° establecimientos en la agregación |

## Documentación

- La política del proyecto y sus convenciones canónicas no se versionan: viven
  fuera del repositorio (ver `.gitignore`).
- [`50_documentacion/suite/`](50_documentacion/suite/): suite de documentación
  del pipeline actual, en cuatro HTML autocontenidos (`*_standalone.html`:
  documentación general, documentación del proyecto y arquitectura general y
  técnica), que genera `50_documentacion/suite/documentar.R`.
- [`50_documentacion/activa/publicacion_github_pages.md`](50_documentacion/activa/publicacion_github_pages.md):
  cómo se publican las dos páginas en GitHub Pages.
- [`50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.md`](50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.md):
  presentación conceptual del proyecto para lectores internos (versión
  navegable en GitHub; existe también una versión HTML:
  `50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.html`).
  Es de junio de 2026, anterior a la vista de trayectorias; la suite trae la
  versión al día.
- [`50_documentacion/activa/arquitectura_slep_simce_adecuado.html`](50_documentacion/activa/arquitectura_slep_simce_adecuado.html):
  diagrama de arquitectura del pipeline de junio de 2026 (insumos → 30 → 31 →
  32 → 33 → motor), sin el paso 36; la suite trae la versión al día. Abrir
  localmente o vía vista previa del repo (no se publica en GitHub Pages, que
  solo sirve `docs/`).
- [`50_documentacion/activa/backlog_acumulativo.md`](50_documentacion/activa/backlog_acumulativo.md):
  registro acumulativo de cambios del proyecto (documento vivo).
- Estructura del repo y esquemas de datos: ver secciones "Responsabilidades por
  archivo" y "Esquemas de datos" más arriba. Snapshot autogenerado del árbol en
  `50_documentacion/estructura/estructura_actual.md` (vía `00_escanear_proyecto.R`).

## Licencia

El **código** de este proyecto (scripts R, pipeline, plantilla HTML/JS/CSS,
documentación técnica) está licenciado bajo la
[Apache License 2.0](LICENSE) (SPDX: `Apache-2.0`).

Los **datos** (resultados Simce e indicadores) provienen de la Agencia de
Calidad de la Educación de Chile y se rigen por sus Condiciones de Uso de Bases
de Datos, **no** por esta licencia. Quien reutilice este código debe obtener los
datos directamente de la fuente oficial
([agenciaeducacion.cl](https://www.agenciaeducacion.cl)) bajo sus propias
condiciones. Ver [`NOTICE`](NOTICE) para el alcance completo y los componentes
de terceros.

<!-- portabilidad-cross-os: bloque que se mantiene a mano desde s35o (2026-09-26) -->

## Portabilidad cross-OS

Este proyecto se clona, configura y ejecuta igual en macOS y en Windows. El contrato completo está en `gobernanza/protocolo_portabilidad_cross_os.md` del repositorio privado `herramientas_dev`.

### Configuración de una máquina nueva

1. Instalar Git, R y Positron.
2. Clonar el repositorio **fuera de OneDrive** (por ejemplo `~/Projects/slep_simce_adecuado`).
3. La raíz de datos es el propio repositorio (`ruta_insumos()` de `10_utils/10_configuracion.R`): no hay variable que declarar. Copiar a `~/.Renviron` la línea `LANG` de `.Renviron.example`, para que R arranque con locale UTF-8, y reiniciar R. Si la locale no es UTF-8, la guarda de `10_utils/10_locale.R` intenta corregirla y, si no puede, detiene el proceso.
4. Colocar el directorio oficial en `20_insumos/auxiliares/directorio_oficial_ee.csv` (no se versiona; ver "Datos de entrada").
5. Restaurar el entorno de paquetes:

   ```r
   renv::restore()
   ```

   `renv.lock` es la única fuente de verdad de paquetes y versiones. No instalar con `install.packages()` a mano.

### Validación del entorno

Antes de ejecutar nada, con la sesión de R abierta en la raíz del repo:

```r
source(here::here("10_utils", "10_validar_portabilidad.R"))
validar_portabilidad()
```

Debe quedar sin fallas críticas. Comprueba el ancla de `here`, la locale UTF-8, `renv.lock`, que `.Renviron` no esté versionado, que `.Renviron.example` exista, y que la raíz de datos resuelva y sea escribible. Para comprobar que el propio verificador detecta violaciones: `validar_portabilidad_autotest()`.

`00_build.R` corre esta misma validación al comenzar y se detiene si encuentra una falla crítica.

### Ejecutar el proyecto

```r
source(here::here("00_build.R"))
```

### Matriz de dependencias de sistema

Lo que `renv` no resuelve se instala en la máquina antes de ejecutar el pipeline.

| Dependencia | macOS | Windows | Necesaria |
|---|---|---|---|
| Git | sí | sí | sí |
| R (4.5; `renv.lock` registra 4.5.2) | sí | sí | sí |
| Positron | sí | sí | recomendado |
| Google Chrome | sí | sí | para las dos baterías (`chromote`) |

Si el proyecto necesita binarios externos (ODBC, Java, Ghostscript, LibreOffice, Quarto, Typst), declararlos en esta tabla con su versión: el protocolo prohíbe depender de que un comando esté "casualmente" en el `PATH`.

