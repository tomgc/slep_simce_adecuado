# Referencia de glosas SIMCE — slep_simce_adecuado

Fuente: `20_insumos/auxiliares/glosas_simce_consolidado_simce.xlsx`
(18 hojas: 9 años × 2 niveles).

Documentos derivados (preprocesados, también en `20_insumos/auxiliares/`):

- `glosas_simce_tabla_comparativa_simce_rbd_2014_2025.csv` — variables
  presentes por año y nivel.
- `glosas_simce_resumen_cambios_simce_rbd_2014_2025.csv` — diffs
  interanuales (variables agregadas, eliminadas, conservadas).

---

## 1. Disponibilidad de variables críticas por año / nivel

Las columnas indican variables **base** (sin sufijo de nivel/prueba). En
2° medio los nombres reales llevan sufijo `_lect2m_rbd` / `_mate2m_rbd`;
en 4° básico, `_lect4b_rbd` / `_mate4b_rbd`. Notación:

- ✓ presente con sufijo canónico esperado.
- ✗ ausente.
- ⚠ presente pero con sufijo anómalo — ver Anomalías.

### 2° medio

| Año  | cod_grupo | nalu_lect | nalu_mate | palu_eda_ade_lect | palu_eda_ade_mate | marca_eda_lect | marca_eda_mate |
|------|:---------:|:---------:|:---------:|:------------------:|:------------------:|:---------------:|:---------------:|
| 2014 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| 2015 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2016 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2017 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2018 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2022 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2023 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2024 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2025 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |

### 4° básico

| Año  | cod_grupo | nalu_lect | nalu_mate | palu_eda_ade_lect | palu_eda_ade_mate | marca_eda_lect | marca_eda_mate |
|------|:---------:|:---------:|:---------:|:------------------:|:------------------:|:---------------:|:---------------:|
| 2014 | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ | ✓ |
| 2015 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2016 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2017 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2018 | ✓ | ⚠ | ⚠ | ⚠ | ⚠ | ✗ | ✗ |
| 2022 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2023 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2024 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |
| 2025 | ✓ | ✓ | ✓ | ✓ | ✓ | ✗ | ✗ |

### Hallazgos clave

- **`cod_grupo` (GSE)** está presente en los 18 años / niveles. Sin embargo,
  su valor para un mismo RBD **cambia entre años** — ver R1.
- **`marca_eda_*`** (marca específica de estándares de aprendizaje) **solo
  existe en 2014** (ambos niveles). En 2015–2025 la glosa solo lista
  `marca_<prueba><nivel>_rbd` (marca genérica de puntaje). Esto requiere
  decisión metodológica antes de implementar `31_leer_normalizar.R` — ver
  Anomalía A2.
- **2018 / 4° básico** tiene los sufijos anómalos `_2m_` en lugar de
  `_4b_` — ver Anomalía A1.

---

## 2. Conteo de variables por hoja

| Año  | 2° medio | 4° básico |
|------|:--------:|:---------:|
| 2014 | 61 | 68 |
| 2015 | 55 | 48 |
| 2016 | 55 | 47 |
| 2017 | 55 | 63 |
| 2018 | 71 | 62 |
| 2022 | 66 | 66 |
| 2023 | 66 | 66 |
| 2024 | 66 | 66 |
| 2025 | 66 | 66 |

La glosa **se estabiliza en 66 variables desde 2022** en ambos niveles, y
se mantiene así hasta 2025. Antes de 2022 hay alta variabilidad (47–71). Para
los diffs interanuales detallados ver
`glosas_simce_resumen_cambios_simce_rbd_2014_2025.csv`.

---

## 3. Reglas de negocio obligatorias

### R1 — GSE dinámico

El campo `cod_grupo` está indexado a la llave compuesta
`[anio + nivel + rbd]`. Prohibido imputar GSE histórico fijo, arrastrar
el último año hacia atrás o promediar. En series históricas, los cambios
de GSE de un establecimiento deben ser visibles.

### R2 — Laguna 2019-2021

La serie presenta discontinuidad completa entre 2019 y 2021 por
estallido social y COVID-19. El pipeline trata este vacío como
interrupción metodológica controlada, no como error de carga. Los
gráficos históricos deben mostrar un espacio explícito en esos años.

### R3 — Madurez del dato

Años 2014–2024 son datos **finales** (cerrados por la Agencia). Año 2025
son datos **preliminares**: pueden cambiar hasta su versión definitiva,
el código debe ser flexible ante NaN y cambios menores de nomenclatura,
y toda visualización debe indicar explícitamente el carácter preliminar
de estos datos.

---

## 4. Anomalías conocidas

### A1 — 2018 / 4° básico: sufijo anómalo `_2m_`

En la hoja `2018_4b_rbd` (y en el xlsx fuente
`simce4b2018_rbd_final.xlsx`), las columnas de número de evaluados,
porcentajes por estándar de aprendizaje y marcas usan sufijo `_2m_` en
lugar de `_4b_`. Columnas afectadas (lista completa observada en la
glosa):

- `nalu_lect2m_rbd` → debe interpretarse como `nalu_lect4b_rbd`
- `nalu_mate2m_rbd` → debe interpretarse como `nalu_mate4b_rbd`
- `palu_eda_ins_lect2m_rbd`, `palu_eda_ele_lect2m_rbd`, `palu_eda_ade_lect2m_rbd`
- `palu_eda_ins_mate2m_rbd`, `palu_eda_ele_mate2m_rbd`, `palu_eda_ade_mate2m_rbd`
- `marca_lect2m_rbd`, `marca_mate2m_rbd`
- `prom_lect2m_rbd`, `prom_mate2m_rbd`, `dif_lect2m_rbd`, `dif_mate2m_rbd`,
  y demás derivadas

`31_leer_normalizar.R` debe detectar este caso por nombre de archivo
(coincidencia con `simce4b2018_*`) y reescribir los sufijos `_2m_` a
`_4b_` antes de proseguir con la normalización general.

### A4 — `cod_com_rbd` pre-Ñuble en 2014, 2016, 2017

Antes de septiembre 2017 (Ley 21.033), las 21 comunas que hoy forman la
Región de Ñuble (código 16) eran parte de la Región del Bío Bío (8) con
códigos `8401-8421`. Desde 2018 se identifican como `16101-16207`.

Los xlsx SIMCE 2014, 2016 y 2017 traen los códigos antiguos
`8401-8421`. Esto rompe el join con el directorio oficial 2025, donde
solo existen los códigos `16xxx`.

**Decisión metodológica:** retroaplicar el código nuevo a todos los
años. Chillán en 2014 aparece bajo Región 16 (Ñuble) aunque
administrativamente en 2014 era Región 8 (Bío Bío). Esto permite
series históricas sin saltos artificiales.

**Implementación en `31_leer_normalizar.R`:** vector nombrado
`mapa_pre_nuble` con los 21 pares (`8401→16101`, `8402→16102`, ...,
`8421→16109`). Se aplica en `leer_un_xlsx()` después del fix A3.
Importante: el indexing usa `as.character()` explícito sobre el
cod_com_rbd antes de mirar el mapa nombrado (sino R indexa por
posición y devuelve NA).

**Sutilezas ortográficas:** dos nombres cambiaron entre las dos eras:
- `RÁNQUIL` (con tilde, pre-2018) → `RANQUIL` (sin tilde, post-2018).
- `TREGUACO` (pre-2018) → `TREHUACO` (post-2018).

Por eso el mapping debe ser explícito por código, no por nombre.

**RBDs afectados por archivo:**
- `simce2m2014`: 81 RBDs (162 filas).
- `simce2m2016`: 89 RBDs (178 filas).
- `simce2m2017`: 91 RBDs (182 filas).
- `simce4b2014`: 317 RBDs (634 filas).
- `simce4b2016`: 314 RBDs (628 filas).
- (`simce4b2017` no aparece porque entra primero a A3 — la corrección
  vía directorio ya entrega códigos canónicos `16xxx`.)

Total: ~892 RBDs remapeados, ~1,784 filas afectadas.

### A3 — `cod_com_rbd` con formato no canónico en 3 archivos

En tres xlsx, la columna `cod_com_rbd` viene con valores de 1-2 dígitos
(ej. `1, 2, 4, 5, 7`) en lugar del formato canónico de 4-5 dígitos
`RPCC` (ej. `5109` para Viña del Mar):

- `simce2m2015_rbd_final.xlsx` — 100% de valores con < 4 dígitos.
- `simce4b2015_rbd_final.xlsx` — 100% de valores con < 4 dígitos.
- `simce4b2017_rbd_final.xlsx` — 100% de valores con < 4 dígitos.

Las columnas `rbd` y `nom_com_rbd` están bien pobladas en los mismos
archivos — el problema es específico al campo de código.

**Detección y remediación en `31_leer_normalizar.R`:** se detecta cuando
más del 50% de los valores tiene menos de 4 dígitos. En esos casos se
recupera `cod_com_rbd` haciendo lookup contra el directorio oficial
(`20_insumos/auxiliares/directorio_oficial_ee.csv`, snapshot 2025) usando
`rbd` como llave. Los tres archivos recuperan al 100% de sus RBDs.

**Asunción operativa:** un mismo RBD no cambia de comuna entre años. Es
cierto en general (la comuna del establecimiento no suele cambiar);
pueden existir excepciones por reubicaciones administrativas raras pero
no se validan en este pipeline.

**Impacto:** sin esta remediación, las agregaciones comuna × GSE en los
años afectados colapsan dramáticamente (de ~800 a ~240 grupos por
año/nivel/prueba). Con la remediación, la cobertura queda alineada con
los años baseline (~800-1000 grupos).

### A2 — `marca_eda_*` solo disponible en 2014 (pregunta abierta)

El briefing original del proyecto define el filtro de exclusión como
`marca_<prueba><nivel>_rbd != NA`. La glosa confirma que
`marca_lect/mate_<nivel>_rbd` (marca genérica de puntaje) **sí** existe
en todos los años. En cambio, `marca_eda_*` (marca específica de
estándares de aprendizaje) **solo aparece en 2014**.

**Decisión pendiente** antes de implementar `31_leer_normalizar.R`:
¿qué marca aplica el pipeline como filtro de exclusión?

- (a) `marca_<prueba><nivel>_rbd` (genérica de puntaje) — disponible en
  todos los años. Compatible con el briefing original.
- (b) `marca_eda_<prueba><nivel>_rbd` (específica de adecuado) — solo
  disponible en 2014; en 2015–2025, asumir NA implícito.
- (c) Híbrido: usar la específica si está, caer en la genérica si no.

La elección afecta directamente cuáles establecimientos se incluyen en
cada agregación de `% adecuado`.
