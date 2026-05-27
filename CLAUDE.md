# CLAUDE.md — slep_simce_adecuado

## Descripción

Motor de comparación comunal de resultados SIMCE por estándares de aprendizaje
(% ponderado de estudiantes en nivel Adecuado). Producto final:
`motor_comparacion.html` standalone con JSON embebido.

## Stack tecnológico

**Pipeline de datos (R)**
- R en Positron.
- Paquetes: `readxl`, `arrow`, `dplyr`, `tidyr`, `purrr`, `here`, `jsonlite`.
- Rutas relativas con `here::here()`. Cero rutas absolutas.

**Frontend (HTML standalone)**
- React 18 + Babel Standalone (CDN — requiere internet solo en primera carga).
- D3.js v7.9.0 inlineado en el HTML (offline tras primera carga).
- Sin bundler, sin servidor: un único archivo `.html` autocontenido.
- JSON de datos embebido en el mismo HTML (generado por `33_generar_html.R`).

## Estructura de archivos relevantes

```
00_build.R                              # Orquestador
00_escanear_proyecto.R                  # Escáner canónico
10_utils/
  10_utils.R                            # agregar_ponderado()
  d3.min.js                             # D3.js v7.9.0 minificado (versionado)
20_insumos/simce/{4b,2m}/*.xlsx         # Datos crudos (no versionados)
20_insumos/auxiliares/                  # directorio_oficial_ee.csv, etc.
30_procesamiento/
  30_construir_auxiliares.R             # Parquets auxiliares (bloques 1-3 OK, bloque 4 pendiente)
  31_leer_normalizar.R                  # xlsx -> simce_rbd.parquet (185 378 filas)
  32_agregar_comunal.R                  # simce_rbd -> simce_comunal.parquet (32 134 filas)
  33_generar_html.R                     # JSON + motor_template.html -> motor_comparacion.html
  motor_template.html                   # Plantilla UI React/D3 (prototipo Claude Design v2)
40_salidas/
  intermedios/
    simce_rbd.parquet                   # Establecimiento × año × nivel × prueba × GSE
    simce_comunal.parquet               # Comuna × año × nivel × prueba × GSE
    slep_cc_establecimientos.parquet    # 73 establecimientos SLEP Costa Central
    comunas_chile.parquet               # 345 comunas con región
    sleps_chile.parquet                 # PENDIENTE (requiere fuente SLEP→comunas)
  motor_comparacion.html                # Producto final (no versionado)
50_documentacion/
  activa/referencia_glosas_simce.md    # Anomalías A1-A4 y reglas R1-R3
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
- dplyr:: prefijado en todo (sin `library(dplyr)`). Ídem para demás paquetes.
- Strings no-ASCII en R construidos con `intToUtf8()` para evitar bug de locale C.
- Columnas con ñ/tildes renombradas por posición (no por nombre) en locale C.

## Anomalías de datos resueltas

Documentadas en `50_documentacion/activa/referencia_glosas_simce.md`:

- **A1** — Bug de sufijo en 2018/4b: archivos xlsx etiquetados `_2m_` en lugar
  de `_4b_`. Resuelto con `gsub("_2m_", "_4b_", ...)` al leer.
- **A2** — Columna `marca_eda_*` solo presente en 2014. Resto de años sin ella;
  se trata como NA (sin exclusión adicional).
- **A3** — `cod_com_rbd` corrupto en 2015/2m, 2015/4b y 2017/4b (>50% de
  valores con <4 dígitos). Resuelto con join por RBD contra
  `directorio_oficial_ee.csv`. Cobertura 100%.
- **A4** — Códigos pre-Ñuble 8401–8421 en años anteriores a la Ley 21.033/2017.
  Remapeados a códigos actuales 16101–16207 con vector explícito.

## Pendientes

- **Bloque 4 de `30_construir_auxiliares.R`**: generar `sleps_chile.parquet`
  (mapeo SLEP → comunas). Requiere que Tomás provea la fuente con NOMBRE_SLEP.
- **Exportación en UI**: PNG para gráficos y CSV para tabla muestran alerta
  placeholder. Implementación pendiente.

## Últimos cambios

1. `motor_template.html` v2: rediseño completo UI basado en prototipo Claude
   Design. React 18 + D3 v7. SimceData adapter sobre JSON real. Seeds con 4
   comunas SLEP Costa Central (5103/5105/5107/5109).
2. `33_generar_html.R`: JSON con catálogos por código (`niveles`, `pruebas`,
   `gse_labels`), datos columnares, `intToUtf8()` para tildes/grado,
   `I(c(2025L))` para forzar array en `anios_preliminar`.
3. `32_agregar_comunal.R`: agrega simce_rbd → simce_comunal (32 134 filas),
   filtra cod_grupo NA, left_join con comunas_chile.
4. `31_leer_normalizar.R`: 18 xlsx → 185 378 filas; maneja A1, A3, A4 y
   normalización de cod_grupo (literales → códigos "1"–"5").
5. `10_utils/d3.min.js`: D3.js v7.9.0 minificado versionado en el repo.
