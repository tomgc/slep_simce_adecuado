# Estructura actual — slep_simce_adecuado

- **Raiz:** `/Users/tomgc/Projects/slep_simce_adecuado`
- **Fecha:** 2026-08-28 14:26:29
- **Totales:** 23 carpetas, 175 archivos
- **Nota:** todos los datos son publicos (Agencia de Calidad) y se versionan en el repo.

## Arbol

```
slep_simce_adecuado/
├── .claude/
│   └── settings.local.json  (3.12K)
├── 10_utils/
│   ├── 10_utils.R  (8.67K)
│   ├── 10_validar_portabilidad.R  (16.4K)
│   ├── d3.min.js  (273K)
│   └── pako.min.js  (45.8K)
├── 20_insumos/
│   ├── auxiliares/
│   │   ├── prototipo_design/
│   │   │   ├── app.jsx  (13.5K)
│   │   │   ├── charts.jsx  (11.9K)
│   │   │   ├── colors_and_type.css  (8.31K)
│   │   │   ├── data.js  (4.48K)
│   │   │   ├── main.jsx  (10.3K)
│   │   │   ├── motor_simce.html  (1.42K)
│   │   │   ├── styles.css  (27.7K)
│   │   │   ├── table.jsx  (7.22K)
│   │   │   └── tweaks-panel.jsx  (23.3K)
│   │   ├── .gitkeep  (0)
│   │   ├── anexo_indicadores_simce.xlsx  (81.1K)
│   │   ├── caracterizacion_establecimientos.xlsx  (16.5K)
│   │   ├── diccionario_territorios.xlsx  (16.8K)
│   │   ├── directorio_oficial_ee.csv  (3.6M)
│   │   ├── glosas_directorio_oficial_ee.pdf  (457K)
│   │   ├── glosas_simce_consolidado_simce.xlsx  (59.4K)
│   │   ├── glosas_simce_resumen_cambios_simce_rbd_2014_2025.csv  (844)
│   │   ├── glosas_simce_tabla_comparativa_simce_rbd_2014_2025.csv  (18K)
│   │   └── listado_slep_2026.xlsx  (55.5K)
│   ├── simce/
│   │   ├── 2m/
│   │   │   ├── .gitkeep  (0)
│   │   │   ├── simce2m2014_rbd_final.xlsx  (745K)
│   │   │   ├── simce2m2015_rbd_final.xlsx  (674K)
│   │   │   ├── simce2m2016_rbd_final.xlsx  (703K)
│   │   │   ├── simce2m2017_rbd_final.xlsx  (711K)
│   │   │   ├── simce2m2018_rbd_final.xlsx  (543K)
│   │   │   ├── simce2m2022_rbd_final.xlsx  (587K)
│   │   │   ├── simce2m2023_rbd_final.xlsx  (509K)
│   │   │   ├── simce2m2024_rbd_final.xlsx  (509K)
│   │   │   └── simce2m2025_rbd_preliminar.xlsx  (528K)
│   │   ├── 4b/
│   │   │   ├── .gitkeep  (0)
│   │   │   ├── simce4b2014_rbd_final.xlsx  (1.97M)
│   │   │   ├── simce4b2015_rbd_final.xlsx  (1.39M)
│   │   │   ├── simce4b2016_rbd_final.xlsx  (1.38M)
│   │   │   ├── simce4b2017_rbd_final.xlsx  (1.31M)
│   │   │   ├── simce4b2018_rbd_final.xlsx  (1.08M)
│   │   │   ├── simce4b2022_rbd_final.xlsx  (1.34M)
│   │   │   ├── simce4b2023_rbd_final.xlsx  (1.11M)
│   │   │   ├── simce4b2024_rbd_final.xlsx  (1.09M)
│   │   │   └── simce4b2025_rbd_preliminar.xlsx  (1.05M)
│   │   └── .DS_Store  (8K)
│   └── .DS_Store  (8K)
├── 30_procesamiento/
│   ├── 30_construir_auxiliares.R  (15.6K)
│   ├── 31_leer_normalizar.R  (16.2K)
│   ├── 32_agregar_comunal.R  (7.64K)
│   ├── 33_generar_html.R  (15.4K)
│   ├── 33_motor_template.html  (155K)
│   └── 34_historico_pct_adecuado_costa_central.R  (6.09K)
├── 40_salidas/
│   ├── intermedios/
│   │   ├── .gitkeep  (0)
│   │   ├── comunas_chile.parquet  (7.18K)
│   │   ├── establecimientos_chile.parquet  (260K)
│   │   ├── simce_comunal.parquet  (988K)
│   │   ├── simce_rbd.parquet  (2.23M)
│   │   ├── slep_cc_establecimientos.parquet  (5.68K)
│   │   └── sleps_chile.parquet  (58.7K)
│   ├── historico_pct_adecuado_costa_central.xlsx  (12K)
│   └── motor_comparacion.html  (2.46M)
├── 50_documentacion/
│   ├── activa/
│   │   ├── decisiones/
│   │   │   ├── 20260611_decision_color_por_nivel.md  (2.99K)
│   │   │   ├── 20260611_decision_licencia_apache.md  (3.17K)
│   │   │   ├── 20260611_decision_nombres_establecimientos.md  (1.85K)
│   │   │   ├── 20260611_decision_repo_publico.md  (1.32K)
│   │   │   ├── 20260620_decision_celda_unico_establecimiento.md  (3.77K)
│   │   │   └── 20260622_decision_cumplimiento_ley_21719.md  (5.35K)
│   │   ├── encargos/
│   │   │   ├── encargo_auditoria_slep_simce_adecuado.md  (9.39K)
│   │   │   ├── encargo_claude_code_simce_suite_standalone.md  (10.5K)
│   │   │   ├── encargo_correcciones_d1_d3.md  (13.7K)
│   │   │   ├── encargo_deuda_tipografica_svg_y_codigo_muerto.md  (10.7K)
│   │   │   ├── encargo_entorno_y_suite_standalone.md  (9.04K)
│   │   │   ├── encargo_homogeneidad_y_quinto_territorio.md  (13.7K)
│   │   │   ├── encargo_normalizar_backlog_politica10.md  (14.1K)
│   │   │   ├── encargo_ordenacion_repositorio.md  (10.1K)
│   │   │   └── encargo_renombrar_entidad_territorio.md  (11.2K)
│   │   ├── .DS_Store  (8K)
│   │   ├── .gitkeep  (0)
│   │   ├── 50_datos_versionados_autorizados.md  (5.44K)
│   │   ├── 50_diseno_ramas_deteccion.md  (7.45K)
│   │   ├── 50_locale_utf8.md  (4.12K)
│   │   ├── 50_ordenacion_repositorio.md  (4.51K)
│   │   ├── arquitectura_slep_simce_adecuado.html  (20K)
│   │   ├── backlog_acumulativo.md  (40.2K)
│   │   ├── documentacion_proyecto_slep_simce_adecuado.html  (18K)
│   │   ├── documentacion_proyecto_slep_simce_adecuado.md  (9.77K)
│   │   ├── ESTADO.md  (1.16K)
│   │   ├── gobernanza_datos.md  (6.96K)
│   │   ├── informe_auditoria_prelanzamiento.md  (10.6K)
│   │   ├── manifiesto_insumos.md  (2.78K)
│   │   ├── POLITICA_PROYECTO.md  (42.8K)
│   │   ├── publicacion_github_pages.md  (2.62K)
│   │   ├── referencia_glosas_simce.md  (9.28K)
│   │   ├── resena_slep_simce_adecuado.md  (1.4K)
│   │   └── SETTINGS_Y_PROMPTS_OPERACIONALES.md  (137K)
│   ├── andamios/
│   │   ├── logs/
│   │   │   ├── 20260620_cotejo_marcas_suite_log.md  (6.69K)
│   │   │   ├── 20260620_reconstruccion_backlog_log.md  (9.44K)
│   │   │   ├── 20260622_anexo_delta_s20_backlog_log.md  (4.71K)
│   │   │   ├── 20260622_auditoria_ley21719_log.md  (8.43K)
│   │   │   ├── 20260622_suite_standalone_simce_log.md  (5.48K)
│   │   │   ├── 20260701_renombrar_entidad_territorio_log.md  (7.02K)
│   │   │   ├── 20260826_homogeneidad_y_quinto_territorio_log.md  (11.2K)
│   │   │   ├── 20260827_correcciones_d1_d3_log.md  (29.4K)
│   │   │   ├── 20260827_entorno_y_suite_standalone_log.md  (29K)
│   │   │   ├── 20260827_medicion_panorama_territorial_log.md  (65.1K)
│   │   │   ├── 20260827_ordenacion_repositorio_log.md  (25.5K)
│   │   │   ├── 20260827_tipografia_svg_y_codigo_muerto_log.md  (23.3K)
│   │   │   └── 20260828_normalizacion_backlog_log.md  (21.6K)
│   │   ├── .DS_Store  (8K)
│   │   └── paquete_cierre_v28.md  (36.5K)
│   ├── estructura/
│   │   ├── 20260826_092120_estructura.md  (9.45K)
│   │   ├── 20260826_092120_estructura.txt  (9.55K)
│   │   ├── 20260827_103911_estructura.md  (10.2K)
│   │   ├── 20260827_103911_estructura.txt  (10.3K)
│   │   ├── estructura_actual.md  (10.2K)
│   │   └── estructura_actual.txt  (10.3K)
│   ├── suite/
│   │   ├── assets/
│   │   │   ├── logo-color-stacked.png  (126K)
│   │   │   ├── logo-mark-cc.png  (118K)
│   │   │   └── logo-white-stacked.png  (143K)
│   │   ├── fonts/
│   │   │   ├── gobCL_Heavy.otf  (43.7K)
│   │   │   ├── gobCL_Light.otf  (37.1K)
│   │   │   ├── gobCL_Regular.otf  (35.7K)
│   │   │   ├── MuseoSans_500.otf  (61K)
│   │   │   ├── MuseoSans_700.otf  (62.1K)
│   │   │   └── MuseoSans-300.otf  (61.5K)
│   │   ├── arquitectura_general_slep_simce_adecuado_standalone.html  (442K)
│   │   ├── arquitectura_slep_simce_adecuado_standalone.html  (445K)
│   │   ├── documentacion_general_slep_simce_adecuado_standalone.html  (434K)
│   │   ├── documentacion_proyecto_slep_simce_adecuado_standalone.html  (441K)
│   │   ├── documentar.R  (50.2K)
│   │   └── suite_estilos.css  (21.7K)
│   ├── traspasos/
│   │   ├── .gitkeep  (0)
│   │   ├── traspaso_cierre_v01.md  (17.8K)
│   │   ├── traspaso_cierre_v02.md  (30.9K)
│   │   ├── traspaso_cierre_v03.md  (26.7K)
│   │   ├── traspaso_cierre_v04.md  (23.1K)
│   │   ├── traspaso_cierre_v05.md  (19.3K)
│   │   ├── traspaso_cierre_v06.md  (16.6K)
│   │   ├── traspaso_cierre_v07.md  (13.5K)
│   │   ├── traspaso_cierre_v08.md  (15K)
│   │   ├── traspaso_cierre_v09.md  (27.8K)
│   │   ├── traspaso_cierre_v10.md  (28.2K)
│   │   ├── traspaso_cierre_v11.md  (28.1K)
│   │   ├── traspaso_cierre_v12.md  (14.1K)
│   │   ├── traspaso_cierre_v13.md  (16.4K)
│   │   ├── traspaso_cierre_v14.md  (17.4K)
│   │   ├── traspaso_cierre_v15.md  (16.4K)
│   │   ├── traspaso_cierre_v16.md  (15.6K)
│   │   ├── traspaso_cierre_v17.md  (19.8K)
│   │   ├── traspaso_cierre_v18.md  (11.5K)
│   │   ├── traspaso_cierre_v19.md  (16.3K)
│   │   ├── traspaso_cierre_v20.md  (18.4K)
│   │   ├── traspaso_cierre_v21.md  (19.1K)
│   │   ├── traspaso_cierre_v22.md  (16.4K)
│   │   ├── traspaso_cierre_v23.md  (20.1K)
│   │   ├── traspaso_cierre_v24.md  (10.6K)
│   │   ├── traspaso_cierre_v25.md  (16.8K)
│   │   ├── traspaso_cierre_v26.md  (12.5K)
│   │   └── traspaso_cierre_v27.md  (14.8K)
│   └── .DS_Store  (14K)
├── docs/
│   └── index.html  (2.46M)
├── .DS_Store  (10K)
├── .gitignore  (1.18K)
├── .Renviron.example  (1.9K)
├── .Rprofile  (26)
├── 00_build.R  (1.24K)
├── 00_escanear_proyecto.R  (9.31K)
├── LICENSE  (11.1K)
├── NOTICE  (1.76K)
├── README.md  (12.2K)
├── renv.lock  (76.8K)
├── slep_simce_adecuado.Rproj  (220)
├── verificar_depe4.R  (6.46K)
├── verificar_elem_insuf_2023_2024.R  (4.07K)
└── verificar_elem_insuf.R  (6.15K)
```

## Conteo por extension

| Extension | Archivos |
|---|---|
| md | 75 |
| xlsx | 24 |
| (sin extension) | 16 |
| r | 13 |
| html | 10 |
| otf | 6 |
| parquet | 6 |
| jsx | 5 |
| css | 3 |
| csv | 3 |
| js | 3 |
| png | 3 |
| txt | 3 |
| example | 1 |
| json | 1 |
| lock | 1 |
| pdf | 1 |
| rproj | 1 |
