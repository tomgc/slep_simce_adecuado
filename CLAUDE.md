# CLAUDE.md — slep_simce_adecuado

## Descripción

Motor de comparación comunal de resultados SIMCE por estándares de aprendizaje
(% ponderado de estudiantes en nivel Adecuado). Producto final:
`motor_comparacion.html` standalone con JSON embebido.

## Stack tecnológico

- R en Positron.
- Paquetes: `readxl`, `arrow`, `dplyr`, `tidyr`, `purrr`, `here`, `jsonlite`.
- Rutas relativas con `here::here()`. Cero rutas absolutas.

## Estructura de archivos relevantes

```
00_build.R                              # Orquestador
00_escanear_proyecto.R                  # Escáner canónico
10_utils/10_utils.R                     # agregar_ponderado(), json_motor()
20_insumos/simce/{4b,2m}/*.xlsx         # Datos crudos (no versionados)
20_insumos/auxiliares/                  # sleps.csv, comunas
30_procesamiento/
  31_leer_normalizar.R                  # xlsx -> parquet largo
  32_agregar_comunal.R                  # comuna × GSE × prueba × año
  33_generar_html.R                     # JSON + HTML final
40_salidas/intermedios/simce_rbd.parquet
40_salidas/motor_comparacion.html       # Producto final
50_documentacion/
```

## Convenciones del proyecto

- snake_case en todo.
- IDs numéricos (rbd, cod_com, cod_grupo) como `character`.
- Mensajes de commit y comentarios de código en español.
- GSE siempre presente en toda vista de resultados — segmentación inviolable.
- Umbral mínimo de 10 estudiantes evaluados por establecimiento.
- Excluir establecimientos con `marca_<prueba><nivel>_rbd` distinto de NA.
- Pruebas (Lectura / Matemática) y niveles (4B / 2M) nunca se mezclan.
- Convenciones numéricas chilenas en la UI: coma decimal, punto de miles,
  formato `XX,X% (N)`.
- HTML final es standalone (JSON embebido, sin servidor).
- Fórmula de agregación única:
  `% adecuado = sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100`

## Últimos cambios

1. Scaffold inicial del proyecto: estructura de directorios, .gitignore,
   stubs de scripts, POLITICA_PROYECTO.md y documentación mínima.
