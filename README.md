# slep_simce_adecuado

Motor de comparación de resultados Simce por estándares de aprendizaje,
con foco en el % ponderado de estudiantes en nivel **Adecuado**, con opción de
desglosar la barra en los tres estándares (Adecuado / Elemental / Insuficiente).

Producto final: un único archivo `motor_comparacion.html` standalone (JSON
embebido) que permite comparar entre comunas, SLEPs, regiones, establecimientos
y el nivel nacional.

## Stack

- R (Positron como entorno).
- Lectura de xlsx: `readxl`.
- Almacenamiento intermedio: `arrow` (parquet).
- Manipulación: `dplyr`, `tidyr`, `purrr`.
- Rutas: `here`.

## Estructura

```
00_build.R                       # Orquestador del pipeline
00_escanear_proyecto.R           # Escáner canónico de estructura
10_utils/10_utils.R              # Funciones reutilizables
10_utils/d3.min.js               # D3 v7 minificado (incrustado en el HTML)
20_insumos/
  simce/4b/                      # xlsx por año (4° Básico)
  simce/2m/                      # xlsx por año (2° Medio)
  auxiliares/                    # directorio oficial, listado SLEP, etc.
30_procesamiento/
  30_construir_auxiliares.R      # xlsx auxiliares -> parquets de catálogo
  31_leer_normalizar.R           # xlsx Simce -> simce_rbd.parquet
  32_agregar_comunal.R           # Agregación comuna × GSE × prueba × año
  33_generar_html.R              # JSON + HTML final
  33_motor_template.html         # Plantilla React/D3 del motor
40_salidas/
  intermedios/                   # parquets generados (no versionados)
  motor_comparacion.html         # Producto final (no versionado)
50_documentacion/
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
4. Instalar los paquetes necesarios (una sola vez):
   ```r
   install.packages(c("here", "readxl", "readr", "dplyr", "tidyr",
                      "purrr", "arrow", "jsonlite", "fs", "tibble"))
   ```
5. Correr el pipeline:
   ```r
   source("00_build.R")
   ```
6. El producto final queda en `40_salidas/motor_comparacion.html`.

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
- **Segmentación inviolable:** todo resultado se reporta por GSE (Bajo / Medio
  bajo / Medio / Medio alto / Alto).
- **No se mezclan** pruebas (Lectura / Matemática) ni niveles (4B / 2M)
  entre sí.
- **Clasificación de dependencia (importante).** La dependencia de cada
  establecimiento es la **vigente** (del directorio oficial) y se aplica a toda
  la serie histórica. Un Servicio Local de Educación Pública (SLEP) agrupa a sus
  establecimientos también en los años previos a su traspaso, cuando la gestión
  era municipal; por eso las cifras anteriores al año de traspaso no son
  atribuibles a la gestión del SLEP. El motor lo advierte con un disclaimer en
  cada punto donde se selecciona dependencia SLEP.

## Responsabilidades por archivo

- **`00_build.R`** — orquesta el pipeline completo: carga `10_utils.R` e invoca
  los pasos de `30_procesamiento/` en orden numérico.
- **`00_escanear_proyecto.R`** — genera el snapshot de estructura en
  `50_documentacion/estructura/` y auto-poda los snapshots antiguos (retiene 2).
- **`10_utils/10_utils.R`** — `agregar_ponderado(df, group_vars)`: aplica filtros
  MINEDUC y agrega el % ponderado por nº de evaluados. Devuelve `pct_adecuado`
  siempre, y `pct_elemental`/`pct_insuficiente` cuando las columnas
  `palu_eda_ele`/`palu_eda_ins` están presentes en `df`.
- **`30_construir_auxiliares.R`** — xlsx auxiliares → parquets de catálogo
  (comunas, establecimientos, SLEPs).
- **`31_leer_normalizar.R`** — lee los xlsx crudos por nivel/año, normaliza,
  valida columnas y emite `simce_rbd.parquet` (formato largo: una fila por
  establecimiento × prueba × año × nivel).
- **`32_agregar_comunal.R`** — agrega `simce_rbd.parquet` a
  `comuna × GSE × prueba × nivel × año` con `agregar_ponderado()`.
  Salida: `simce_comunal.parquet`.
- **`33_generar_html.R`** — construye el JSON consolidado y lo embebe en
  `33_motor_template.html` para producir el motor final.

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
| preliminar    | logical   | TRUE solo para 2025                  |

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

- `POLITICA_PROYECTO.md` — política y convenciones canónicas.
- [`50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.md`](50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.md)
  — presentación conceptual del proyecto para lectores internos (versión
  navegable en GitHub; existe también una versión HTML:
  `50_documentacion/activa/documentacion_proyecto_slep_simce_adecuado.html`).
- [`50_documentacion/activa/arquitectura_slep_simce_adecuado.html`](50_documentacion/activa/arquitectura_slep_simce_adecuado.html)
  — diagrama de arquitectura del pipeline (insumos → 30 → 31 → 32 → 33 → motor).
  Abrir localmente o vía vista previa del repo (no se publica en GitHub Pages,
  que solo sirve `docs/`).
- [`50_documentacion/activa/backlog_historico.md`](50_documentacion/activa/backlog_historico.md)
  — registro acumulativo de cambios del proyecto (documento vivo).
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
