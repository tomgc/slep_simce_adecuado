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
  30_construir_auxiliares.R             # Parquets auxiliares (bloques 0-5 completos)
  31_leer_normalizar.R                  # xlsx -> simce_rbd.parquet (185 378 filas)
  32_agregar_comunal.R                  # simce_rbd -> simce_comunal.parquet (44 975 filas)
  33_generar_html.R                     # JSON + 33_motor_template.html -> motor_comparacion.html
  33_motor_template.html                # Plantilla UI React/D3 (v3 post-sesión 3)
40_salidas/
  intermedios/
    simce_rbd.parquet                   # Establecimiento × año × nivel × prueba × GSE
    simce_comunal.parquet               # Comuna × año × nivel × prueba × GSE
    slep_cc_establecimientos.parquet    # 73 establecimientos SLEP Costa Central
    comunas_chile.parquet               # 345 comunas con región
    sleps_chile.parquet                 # 26 SLEPs × comunas × RBDs
    establecimientos_chile.parquet      # Catálogo completo (~10 945 establecimientos)
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

| # | Título | Prioridad | Tipo |
|---|--------|-----------|------|
| P2 | Exportación de gráficos como imagen (PNG/SVG desde DOM) | Medio | UI |
| P5 | `00_escanear_proyecto.R` adaptado al proyecto | Bajo | Infraestructura |
| P6 | Entidades tipo establecimiento y región | **Alto** | UI + Pipeline |
| P7 | Clic en celda de tabla abre popup de establecimientos filtrado por GSE × nivel × prueba | **Alto** | UI |
| D3 | Limpiar estado `region` sin uso en tab comuna del modal | Bajo | Deuda técnica |
| — | Entidad tipo "nacional" | Diferido | UI + Pipeline |

**Notas de diseño para P6:**
- **Establecimiento**: datos desde `simce_rbd.parquet` (no desde `simce_comunal`).
  El establecimiento aparece en la fila del GSE al que pertenece.
  Agregación ponderada igual que cualquier otra entidad:
  `sum(nalu × palu_eda_ade / 100) / sum(nalu) × 100`.
- **Región**: agrupación de todas las comunas de una región, ponderada desde
  `simce_comunal.parquet` usando `cod_reg_rbd`. No requiere nuevo parquet.
- **Jerarquía completa**: establecimiento → comuna → SLEP → región.
  "Nacional" diferido por complejidad.

**Notas de diseño para P7:**
- Reutiliza lógica de `contarOFiltrarEstablecimientos` ya existente.
- Filtro adicional: `cod_grupo` (GSE) de la celda clicada.
- El tooltip sigue mostrando solo el conteo (sin lista); la lista aparece al clic.

## Últimos cambios

**Sesión 3 (cambios 19–33):**
1. `30_construir_auxiliares.R`: Bloque 5 añadido → `establecimientos_chile.parquet`
   (catálogo completo ~10 945 establecimientos con `rbd`, `nom_rbd`, `cod_com_rbd`,
   `nom_com_rbd`, `cod_depe2`).
2. `33_generar_html.R`: carga `establecimientos_chile.parquet` y `simce_rbd.parquet`
   (para `rbds_por_nivel`); ambos inyectados en `json_root`.
3. `33_motor_template.html` v3: popup establecimientos universal (cualquier entidad),
   filtrado por RBD × nivel × prueba, conteo `(N)` en chip, supergrid 4 columnas
   fijas con placeholders, exportación CSV (`;` + BOM UTF-8), etiquetas de barras
   siempre encima, semillas con `depe2="5"`, búsqueda libre de comuna en modal,
   límite 4 entidades, corrección header y leyenda tabla.

**Sesión 2 (cambios 12–18):**
4. `cod_depe2` añadido al pipeline completo; `sleps_chile.parquet` implementado.
5. UI v2 → v3: rediseño basado en prototipo Claude Design, React 18 + D3 v7.

**Sesión 1 (cambios 1–11):**
6. Pipeline base: `31_leer_normalizar.R` → `32_agregar_comunal.R` →
   `33_generar_html.R`. Motor HTML standalone con JSON embebido.
