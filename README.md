# slep_simce_adecuado

Motor de comparación comunal de resultados SIMCE por estándares de aprendizaje,
con foco en el % ponderado de estudiantes en nivel **Adecuado**.

Producto final: un único archivo `motor_comparacion.html` standalone (JSON
embebido) que permite comparar entre comunas y SLEPs.

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
20_insumos/
  simce/4b/                      # xlsx por año (4° Básico)
  simce/2m/                      # xlsx por año (2° Medio)
  auxiliares/                    # comunas, sleps
30_procesamiento/
  31_leer_normalizar.R           # xlsx -> parquet largo normalizado
  32_agregar_comunal.R           # Agregación comuna × GSE × prueba × año
  33_generar_html.R              # JSON + HTML final
40_salidas/
  intermedios/                   # parquet generados
  motor_comparacion.html         # Producto final
50_documentacion/
```

## Datos de entrada

Los xlsx provienen del portal
[informacionestadistica.agenciaeducacion.cl](https://informacionestadistica.agenciaeducacion.cl).
Cada archivo corresponde a un nivel (4B o 2M) y un año (2023, 2024, 2025) en
formato `_rbd` (unidad establecimiento).

Los xlsx **no se versionan** en el repo (ver `.gitignore`). Deben copiarse
manualmente a:

- `20_insumos/simce/4b/`
- `20_insumos/simce/2m/`

## Reglas de cálculo

- **Indicador:** % ponderado de estudiantes en nivel Adecuado.
- **Fórmula de agregación:**
  ```
  % adecuado = sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100
  ```
- **Filtros de exclusión (umbral MINEDUC):**
  - Establecimientos con `nalu < 10` se excluyen.
  - Establecimientos con `marca_<prueba><nivel>_rbd` distinto de NA se excluyen.
- **Segmentación inviolable:** todo resultado se reporta por GSE (Bajo / Medio
  bajo / Medio / Medio alto / Alto).
- **No se mezclan** pruebas (Lectura / Matemática) ni niveles (4B / 2M)
  entre sí.

## Cómo correr

```r
source("00_build.R")
```

(El orquestador irá descomentando pasos a medida que se implementen.)

## Documentación

- `POLITICA_PROYECTO.md` — política y convenciones canónicas.
- `50_documentacion/estructura/estructura_proyecto.md` — mapa detallado.
