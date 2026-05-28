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
10_utils/d3.min.js               # D3 v7 minificado (incrustado en el HTML)
20_insumos/
  simce/4b/                      # xlsx por año (4° Básico)
  simce/2m/                      # xlsx por año (2° Medio)
  auxiliares/                    # directorio oficial, listado SLEP, etc.
30_procesamiento/
  30_construir_auxiliares.R      # xlsx auxiliares -> parquets de catálogo
  31_leer_normalizar.R           # xlsx SIMCE -> simce_rbd.parquet
  32_agregar_comunal.R           # Agregación comuna × GSE × prueba × año
  33_generar_html.R              # JSON + HTML final
  33_motor_template.html         # Plantilla React/D3 del motor
40_salidas/
  intermedios/                   # parquets generados (no versionados)
  motor_comparacion.html         # Producto final (no versionado)
50_documentacion/
```

## Datos de entrada

Los xlsx de SIMCE provienen del portal
[informacionestadistica.agenciaeducacion.cl](https://informacionestadistica.agenciaeducacion.cl)
y se versionan en el repo junto al código (son datos públicos, < 25 MB en total).
No se requiere configuración adicional de rutas.

## Cómo correr en una máquina nueva

1. Clonar el repo:
   ```bash
   git clone <url-del-repo>
   cd slep_simce_adecuado
   ```
2. Abrir `slep_simce_adecuado.Rproj` en Positron. Esto ancla `here::here()`
   a la raíz del proyecto automáticamente.
3. Instalar los paquetes necesarios (una sola vez):
   ```r
   install.packages(c("here", "readxl", "readr", "dplyr", "tidyr",
                      "purrr", "arrow", "jsonlite", "fs", "tibble"))
   ```
4. Correr el pipeline:
   ```r
   source("00_build.R")
   ```
5. El producto final queda en `40_salidas/motor_comparacion.html`.

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

## Documentación

- `POLITICA_PROYECTO.md` — política y convenciones canónicas.
- `50_documentacion/estructura/estructura_proyecto.md` — mapa detallado.
