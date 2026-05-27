# Estructura actual — slep_simce_adecuado

_Generado por `00_escanear_proyecto.R` el 2026-05-27 18:24._
_Los `.parquet` y `.min.js` se omiten del árbol (binarios pesados)._

## Árbol de archivos versionados

```
/Users/tomgc/Projects/slep_simce_adecuado
+-- 00_build.R
+-- 00_escanear_proyecto.R
+-- 10_utils
|   +-- 10_utils.R
+-- 20_insumos
|   +-- auxiliares
|   |   +-- anexo_indicadores_simce.xlsx
|   |   +-- caracterizacion_establecimientos.xlsx
|   |   +-- diccionario_territorios.xlsx
|   |   +-- directorio_oficial_ee.csv
|   |   +-- glosas_directorio_oficial_ee.pdf
|   |   +-- glosas_simce_consolidado_simce.xlsx
|   |   +-- glosas_simce_resumen_cambios_simce_rbd_2014_2025.csv
|   |   +-- glosas_simce_tabla_comparativa_simce_rbd_2014_2025.csv
|   |   \-- prototipo_design
|   |       +-- Motor SIMCE.html
|   |       +-- app.jsx
|   |       +-- charts.jsx
|   |       +-- colors_and_type.css
|   |       +-- data.js
|   |       +-- main.jsx
|   |       +-- styles.css
|   |       +-- table.jsx
|   |       \-- tweaks-panel.jsx
|   \-- simce
|       +-- 2m
|       |   +-- simce2m2014_rbd_final.xlsx
|       |   +-- simce2m2015_rbd_final.xlsx
|       |   +-- simce2m2016_rbd_final.xlsx
|       |   +-- simce2m2017_rbd_final.xlsx
|       |   +-- simce2m2018_rbd_final.xlsx
|       |   +-- simce2m2022_rbd_final.xlsx
|       |   +-- simce2m2023_rbd_final.xlsx
|       |   +-- simce2m2024_rbd_final.xlsx
|       |   \-- simce2m2025_rbd_preliminar.xlsx
|       \-- 4b
|           +-- simce4b2014_rbd_final.xlsx
|           +-- simce4b2015_rbd_final.xlsx
|           +-- simce4b2016_rbd_final.xlsx
|           +-- simce4b2017_rbd_final.xlsx
|           +-- simce4b2018_rbd_final.xlsx
|           +-- simce4b2022_rbd_final.xlsx
|           +-- simce4b2023_rbd_final.xlsx
|           +-- simce4b2024_rbd_final.xlsx
|           \-- simce4b2025_rbd_preliminar.xlsx
+-- 30_procesamiento
|   +-- 30_construir_auxiliares.R
|   +-- 31_leer_normalizar.R
|   +-- 32_agregar_comunal.R
|   +-- 33_generar_html.R
|   \-- motor_template.html
+-- 40_salidas
|   +-- intermedios
|   \-- motor_comparacion.html
+-- 50_documentacion
|   +-- activa
|   |   \-- referencia_glosas_simce.md
|   +-- estructura
|   |   +-- estructura_actual.md
|   |   +-- estructura_proyecto.md
|   |   \-- manifiesto_insumos.md
|   \-- traspasos
|       \-- traspaso_cierre_v01.md
+-- CLAUDE.md
+-- POLITICA_PROYECTO.md
\-- README.md
```

## Intermedios en disco (no versionados)

_Parquets presentes en `40_salidas/intermedios/`:_

| Archivo | Tamaño |
|---------|--------|
| `comunas_chile.parquet` | 7 KB |
| `simce_comunal.parquet` | 367 KB |
| `simce_rbd.parquet` | 1171 KB |
| `slep_cc_establecimientos.parquet` | 6 KB |

_Salidas HTML en `40_salidas/`:_

- `motor_comparacion.html`

## Últimos 5 commits

```
40d15d4 Actualizar CLAUDE.md con estado post-v2
e5c2166 Versionar D3.js v7.9.0 minificado en 10_utils/
654a354 Rediseño completo UI v2 basado en prototipo Claude Design
7c8e4fe Implementar 32_agregar_comunal.R y manejar anomalía A4 (pre-Ñuble)
2bfedcc Corregir cod_com_rbd anómalo en 2015 y 2017/4b (Anomalía A3)
```

