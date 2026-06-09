# CLAUDE.md — slep_simce_adecuado

## Descripción

Motor de comparación de resultados SIMCE por estándares de aprendizaje
(% ponderado de estudiantes en nivel Adecuado, segmentado por GSE). Producto
final: `motor_comparacion.html` standalone con JSON embebido, publicado en
GitHub Pages (`https://tomgc.github.io/slep_simce_adecuado/`).

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
00_escanear_proyecto.R                  # Escáner canónico (auto-poda: retiene 2 sellos)
10_utils/
  10_utils.R                            # agregar_ponderado()
  d3.min.js                             # D3.js v7.9.0 minificado (versionado)
20_insumos/simce/{4b,2m}/*.xlsx         # Datos crudos (versionados; públicos Agencia de Calidad)
20_insumos/auxiliares/                  # directorio_oficial_ee.csv, diccionario_territorios.xlsx, etc.
30_procesamiento/
  30_construir_auxiliares.R             # Parquets auxiliares (bloques 0-5 completos)
  31_leer_normalizar.R                  # xlsx -> simce_rbd.parquet
  32_agregar_comunal.R                  # simce_rbd -> simce_comunal.parquet
  33_generar_html.R                     # JSON + 33_motor_template.html -> motor_comparacion.html
  33_motor_template.html                # Plantilla UI React/D3
40_salidas/
  intermedios/
    simce_rbd.parquet                   # Establecimiento × año × nivel × prueba × GSE
    simce_comunal.parquet               # Comuna × año × nivel × prueba × GSE
    slep_cc_establecimientos.parquet    # Establecimientos SLEP Costa Central
    comunas_chile.parquet               # Comunas con región
    sleps_chile.parquet                 # SLEPs × comunas × RBDs
    establecimientos_chile.parquet      # Catálogo completo de establecimientos
  motor_comparacion.html                # Producto final (no versionado; regenerable)
docs/
  index.html                            # Copia publicada en GitHub Pages (deploy desde main /docs)
50_documentacion/
  activa/
    referencia_glosas_simce.md          # Anomalías A1-A4 y reglas
    publicacion_github_pages.md         # Procedimiento de republicación
    arquitectura_slep_simce_adecuado.html # Diagrama de arquitectura y flujo
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
- Toda lógica de selección de series pasa por `SimceData.getSeriesForEntity`
  en el motor HTML — sin ternarios inline por `kind` en componentes.

## Anomalías de datos resueltas

Documentadas en `50_documentacion/activa/referencia_glosas_simce.md`:

- **A1** — Bug de sufijo en 2018/4b: columnas etiquetadas `_2m_` en lugar
  de `_4b_`. Resuelto al normalizar en `31_leer_normalizar.R`.
- **A2** — Columna `marca_eda_*` solo presente en 2014. Resto de años sin ella;
  se adopta marca genérica homogénea.
- **A3** — `cod_com_rbd` corrupto en 2015/2m, 2015/4b y 2017/4b (valores con
  <4 dígitos). Resuelto con join por RBD contra `directorio_oficial_ee.csv`.
- **A4** — Códigos pre-Ñuble 8401–8421 en años anteriores a la Ley 21.033/2017.
  Remapeados a códigos actuales 16101–16207 con vector explícito.

## Pendientes

| # | Título | Prioridad | Tipo |
|---|--------|-----------|------|
| P2 | Exportación de gráficos como imagen (PNG/SVG desde DOM) | Medio | UI |
| P3 | Quitar botón de ajustes; densidad fija en "cómoda" | Medio | UI |
| P4 | Párrafo de contacto con ofuscación anti-scraping (nivel B) | Bajo | UI |
| P5 | Optimización del peso del HTML (separar JSON por fetch) | Diferido | UI |
| D3 | Limpiar estado `region` sin uso en tab comuna del modal | Bajo | Deuda técnica |

**Notas para P3 y P4** (mismo archivo `33_motor_template.html`, agrupables;
requieren redeploy a `/docs` tras el cambio):
- **P3**: eliminar el panel de tweaks; densidad hardcodeada en "cómoda".
  Limpiar estado React y handlers que el botón deje sin uso.
- **P4**: agregar `**Contacto:**` + correo institucional al final del párrafo
  de intro, ensamblado por JS (el correo no debe existir como string literal
  completo en el HTML servido), `mailto:` clickeable.

## Últimos cambios

**Sesión 9 (despliegue y limpieza):**
1. Motor publicado en GitHub Pages (`docs/index.html`, branch `main` /docs).
2. `00_escanear_proyecto.R` reemplazado por versión con auto-poda de snapshots
   (`RETENER_SNAPSHOTS = 2`).
3. Limpieza del repo: eliminados 12 snapshots históricos, `sleps_chile_v2.xlsx`
   y `estructura_proyecto.md` (consolidado en README).
4. Diagrama de arquitectura HTML standalone en `50_documentacion/activa/`.

**Sesión 8 (fixes UX):**
5. Fix de tooltip: clamping al viewport en `33_motor_template.html`.
6. Fix de warning `pivot_wider` en `32_agregar_comunal.R` (summarise ponderado
   antes del pivot).

**Sesiones 4-7 (entidades y portabilidad):**
7. Cobertura completa de tipos de entidad: comuna, SLEP, región,
   establecimiento, nacional ("Chile") y grupos personalizados.
8. `SimceData.getSeriesForEntity` como punto de entrada único de la lógica
   de series (sin ternarios inline por `kind`).
9. Portabilidad cross-OS: `.Rproj` con UTF-8, `here::here()` exclusivo, xlsx
   versionados en el repo. Verificado en macOS y Windows.

**Sesión 3 (popup y supergrid):**
10. `30_construir_auxiliares.R`: bloque 5 → `establecimientos_chile.parquet`.
11. `33_motor_template.html`: popup de establecimientos universal filtrado por
    RBD × nivel × prueba; supergrid; exportación CSV (`;` + BOM UTF-8);
    semillas con `depe2="5"`.

**Sesiones 1-2 (base):**
12. Pipeline base 31 → 32 → 33; motor HTML standalone con JSON embebido;
    `cod_depe2` en el pipeline; UI rediseñada (React 18 + D3 v7).
