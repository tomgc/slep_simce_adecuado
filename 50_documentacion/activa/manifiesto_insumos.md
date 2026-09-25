# Manifiesto de insumos — slep_simce_adecuado

## Convención canónica de nombres de xlsx SIMCE

Patrón: `simce<nivel><anio>_rbd_<estado>.xlsx`

- `<nivel>`: `2m` o `4b` (siempre minúscula).
- `<anio>`: 4 dígitos.
- `<estado>`:
  - `final` para datos cerrados por la Agencia (hoy, todos los años 2014–2025).
  - `preliminar` para datos sujetos a revisión. Cuando llega la base final de
    ese año, el preliminar sale de `20_insumos/` (a `_archivo/<fecha>/`,
    fuera de git) y el asterisco desaparece solo, porque el generador lo
    deriva de los archivos leídos. La base final de 2025 (v22025, 2026-06-22)
    no cambió ningún dato respecto de la preliminar (v12025, 2026-04-27):
    comparación celda a celda de la sesión 31.
- Sin tildes, sin mayúsculas, sin variantes (no `_publica_`, no `_público_`).

## Archivos esperados

### 2° Medio (`20_insumos/simce/2m/`)

| Año  | Archivo                          | Estado     |
|------|----------------------------------|------------|
| 2014 | simce2m2014_rbd_final.xlsx       | final      |
| 2015 | simce2m2015_rbd_final.xlsx       | final      |
| 2016 | simce2m2016_rbd_final.xlsx       | final      |
| 2017 | simce2m2017_rbd_final.xlsx       | final      |
| 2018 | simce2m2018_rbd_final.xlsx       | final      |
| 2022 | simce2m2022_rbd_final.xlsx       | final      |
| 2023 | simce2m2023_rbd_final.xlsx       | final      |
| 2024 | simce2m2024_rbd_final.xlsx       | final      |
| 2025 | simce2m2025_rbd_final.xlsx       | final      |

### 4° Básico (`20_insumos/simce/4b/`)

| Año  | Archivo                          | Estado     |
|------|----------------------------------|------------|
| 2014 | simce4b2014_rbd_final.xlsx       | final      |
| 2015 | simce4b2015_rbd_final.xlsx       | final      |
| 2016 | simce4b2016_rbd_final.xlsx       | final      |
| 2017 | simce4b2017_rbd_final.xlsx       | final      |
| 2018 | simce4b2018_rbd_final.xlsx       | final      |
| 2022 | simce4b2022_rbd_final.xlsx       | final      |
| 2023 | simce4b2023_rbd_final.xlsx       | final      |
| 2024 | simce4b2024_rbd_final.xlsx       | final      |
| 2025 | simce4b2025_rbd_final.xlsx       | final      |

## Años ausentes (sin SIMCE aplicado o sin datos liberados)

- **2019**: estallido social — SIMCE no aplicado.
- **2020**: pandemia COVID-19 — SIMCE no aplicado.
- **2021**: pandemia COVID-19 — SIMCE no aplicado.

El pipeline trata esta discontinuidad como interrupción metodológica
controlada (ver R2 en `50_documentacion/activa/referencia_glosas_simce.md`),
no como error de carga.

## Glosas oficiales

`20_insumos/auxiliares/glosas_simce_consolidado_simce.xlsx` contiene la
documentación oficial de variables por año y nivel, consolidada por la
Agencia. Es la fuente de verdad para nomenclatura y semántica de columnas.
Su lectura y reglas de negocio derivadas están documentadas en
`50_documentacion/activa/referencia_glosas_simce.md`.

## Catálogo de olas de traspaso

`20_insumos/auxiliares/dim_slep_comunas.csv` es el catálogo público de comunas
por Servicio Local y año de traspaso: una fila por comuna (346 más el
encabezado), separado por `;`, en UTF-8. La vista de trayectorias lo usa para
armar las cohortes de las olas 2027 a 2029 (decisión D35-2,
`decisiones/20260924_decision_referente_traspasos.md`).

- **Origen:** repositorio `slep_central_datos`, archivo
  `30_procesamiento/catalogo/dim_slep_comunas.csv`, en el commit `d7a8ec6`
  (último que lo modifica).
- **md5:** `fdb3015da12264d370a9d670c6886c0b` (igual en el origen y en la copia).
- **Fecha de copia:** 2026-09-25 (sesión 35).
- **Regla de actualización:** se recopia cuando cambie el catálogo de origen, y
  se actualizan aquí el commit, el md5 y la fecha. El build no lee el otro
  repositorio: solo esta copia (POLITICA §5.2).
- **Versionado:** se versiona. Es un catálogo público de territorio e
  institución, sin persona natural, cubierto por la entrada
  `20_insumos/auxiliares/*.csv` de `50_datos_versionados_autorizados.md`.

## Política de versionado

- Los xlsx SIMCE crudos **no** se versionan (`.gitignore`). Se mantienen
  localmente.
- El xlsx de glosas **sí** se versiona — es metadata estable y pequeña.
- Este manifiesto se versiona. Actualizarlo cuando se agregue un año
  nuevo o cambie la convención.
