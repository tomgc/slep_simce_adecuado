# AUDIT_EVIDENCE: Auditoría integral slep_simce_adecuado

Commit auditado: `75014460eed610827bb2c9fdc8a29ee48945f80b`. Entorno y limitaciones: ver AUDIT_MANIFEST.md.

Convenciones:
- `SP` = scratchpad de la sesión, fuera del proyecto.
- `work_A` = copia del repositorio en `SP` con el directorio SUSTITUTO (ver manifiesto).
- Toda cifra de este archivo sale de un comando ejecutado en esta sesión.
- No se copia aquí ningún dato personal ni contenido de `directorio_oficial_ee.csv`.

---

## E1. Estado del repositorio y del entorno

```bash
git status                          # nothing to commit, working tree clean
git rev-parse HEAD                  # 75014460eed610827bb2c9fdc8a29ee48945f80b
git rev-parse --is-shallow-repository   # true
git rev-list --count HEAD           # 50
git ls-files | wc -l                # 243
git check-ignore -v 20_insumos/auxiliares/directorio_oficial_ee.csv
#   .gitignore:44:20_insumos/auxiliares/directorio_oficial_ee.csv
ls 20_insumos/auxiliares/           # sin directorio_oficial_ee.csv
sha256sum docs/*.html
#   fac6f07fec613e2bc71f879cecd495003a4c1442bb570ffefd8428a386128820  docs/index.html
#   c29ab878726f79395efca79581cc6df2b21ade4ca8056d466ccd60aeacad7b1d  docs/trayectorias.html
```

Red:
- `curl https://cloud.r-project.org/...` → 403 del proxy.
- `datosabiertos.mineduc.cl`, `www.mineduc.cl` y `informacionestadistica.agenciaeducacion.cl` → sin conexión.
- `conda.anaconda.org` → accesible. R 4.5.3 y los paquetes se instalaron desde allí, en `SP`.

Arranque de R dentro del proyecto (`.Rprofile` → `renv/activate.R`):

```
# Bootstrapping renv 1.1.4 ---
- Downloading renv ... Warning: unable to access index for repository https://cloud.r-project.org/src/contrib
Error in h(simpleError(msg, call)) : failed to download
```

Por eso todas las ejecuciones usaron `R_PROFILE_USER=<archivo vacío>`. Esa variable evita el `.Rprofile` del proyecto; es la única desviación respecto del arranque normal.

---

## E2. Pipeline reconstruido (lectura de código)

`00_build.R` (50 líneas):
1. `source()` de `10_configuracion.R` (guarda de locale, `ruta_insumos()`, `ANIO_INICIO`, `ANIOS_SIN_SIMCE`) y de `10_utils.R`.
2. `validar_portabilidad(detener_si_falla = TRUE)`.
3. `source()` en orden de 30 → 31 → 32 → 33 → 36.

Contrato verificado: los cinco pasos se ejecutan en ese orden, con estas salvedades:
- Cada paso depende de archivos escritos por el anterior en `40_salidas/intermedios/`, no de objetos en memoria. Los pasos se cargan con `source()` en el Global Environment compartido.
- El paso 31 vuelve a leer `directorio_oficial_ee.csv` por su cuenta.
- El paso 33 relee `simce_rbd.parquet` tres veces.
- El paso 34 (`historico_pct_adecuado_costa_central.xlsx`, versionado) **no** lo ejecuta `00_build.R`.
- Las baterías `33_verificar_motor.R` y `36_verificar_trayectorias.R` **no** se ejecutan en el build.

Productores:

| Salida | Script | Insumos |
|---|---|---|
| `slep_cc_establecimientos.parquet` | 30 (bloque 1) | caracterizacion_establecimientos.xlsx, anexo_indicadores_simce.xlsx. Sin consumidor en el código: grep solo lo encuentra en `50_documentacion/suite/documentar.R`. |
| `comunas_chile.parquet` | 30 (bloque 3) | directorio (ESTADO_ESTAB==1 & MATRICULA==1) |
| `sleps_chile.parquet` | 30 (bloque 4) | listado_slep_2026.xlsx + directorio: COD_DEPE==6 en comunas con traspaso ≤ `ANIO_DATOS_VIGENTE` (2025L, literal en 30:47), o COD_DEPE 1/2 en comunas con traspaso = 2026 |
| `establecimientos_chile.parquet` | 30 (bloque 5) | directorio (operativos con matrícula) |
| `simce_rbd.parquet` | 31 | 18 XLSX + directorio completo: mapas RBD→comuna (A3) y RBD→COD_DEPE2 (todas las filas del CSV) |
| `simce_comunal.parquet` | 32 | simce_rbd (cod_grupo no NA) → `agregar_ponderado()` por anio×nivel×prueba×comuna×GSE×depe2 |
| `motor_comparacion.html` | 33 | simce_comunal, comunas, sleps, establecimientos, simce_rbd (filtrado nalu≥10, marca NA, palu no NA), plantilla, fragmento, JS vendorizados |
| `trayectorias_traspasos.html` | 36 | simce_rbd, sleps, comunas, establecimientos, `dim_slep_comunas.csv` |

Indicadores:
- Comuna, región, nacional y dependencia: `agregar_ponderado()` (`10_utils.R:43-94`) en R. Luego `generateSeriesByDepe` / `generateSeriesByNacional` en JS reponderan `datos.pct × n_evaluados`.
- SLEP y establecimiento: `generateSeriesByRbd` / `generateSeriesByEstab` en JS, sobre `simce_rbd`.
- Punto mostrado: `mkPunto` (plantilla 1456-1471). Redondea Adecuado a 0,1 y reescala Elemental e Insuficiente para que sumen 100 − Adecuado.
- Trayectorias: `agregar_trayectorias()` / `redondear_exacto()` (`36_funciones_trayectorias.R:254-272`), aritmética entera con empates hacia arriba.

Filtros MINEDUC (nalu ≥ 10, marca NA, palu_ade no NA): escritos en cuatro lugares.
- `10_utils.R:66-71`
- `33_generar_html.R:275-278`, `296-299` y `317-320`
- `36_funciones_trayectorias.R:238`, que además exige los tres niveles no NA y suma de niveles en [99, 101] (líneas 229-236).

Valores hardcodeados relevantes:
- `ANIO_INICIO <- 2014L` y `ANIOS_SIN_SIMCE <- c(2019L,2020L,2021L)` (`10_configuracion.R:32-33`)
- `ANIO_DATOS_VIGENTE <- 2025L` (`30:47`)
- nombre `listado_slep_2026.xlsx` (`30:259`)
- `rbds_esperados` (`30:64`)
- `nombres_region` (`30:188-205`)
- `mapa_pre_nuble` (`31:90-112`)
- `if (anio == 2018L && nivel == "4b")` (`31:273`)
- `costa_central` (`32:196`, solo diagnóstico impreso)
- `OLAS_FUTURAS <- c(2027L,2028L,2029L)`, `ORDEN_SLEP` (36 códigos), `ORDEN_REGIONES` (`36_funciones:120-136`)
- `s.year <= 2018` / `s.year >= 2022` (plantilla del motor 2644-2645)
- `tx(2018)` / `tx(2022)` (plantilla de trayectorias 1028-1030)
- «nueve años» (plantilla de trayectorias 453)
- esperados de la batería 36: 13/11/13, 2.564, 1.299, 1.282, 475/406/401 (`36_verificar_trayectorias.R:532`, `704-706`)

---

## E3. Insumos crudos (XLSX)

Script `inspeccion_xlsx.R` y `anomalias.R` (readxl, todas las hojas):

| Hecho medido | Resultado |
|---|---|
| Archivos | 18: `simce{2m,4b}{2014..2018,2022..2025}_rbd_final.xlsx`. Ninguno preliminar. |
| Hojas | 2014-2017: Hoja1, Hoja2, Hoja3; Hoja2 y Hoja3 vacías (0×0). El resto, una hoja. El pipeline lee la primera. |
| Columnas por archivo | entre 38 y 62; todas traen las 14 columnas que exige el paso 31 |
| Duplicados de RBD dentro de un archivo | 0 en los 18 |
| RBD NA | 0 |
| A1 (`_2m_` en 4b/2018) | **0 columnas** con `_2m_` en `simce4b2018_rbd_final.xlsx`: la rama de `31:273-275` hoy no hace nada |
| A3 (cod_com corto) | 100% de códigos < 4 dígitos en 2m/2015, 4b/2015 y 4b/2017; 0% en el resto |
| A4 (pre-Ñuble 8401-8421) | 2m: 81 (2014), 89 (2016), 91 (2017); 4b: 317 (2014), 314 (2016) |
| cod_grupo | texto Bajo..Alto en 2014-2016 (ambos niveles); códigos 1..5 desde 2017 (4b) y 2018 (2m) |
| marca | texto (2014, 2016, 2017) o códigos 1..4 (2015 y desde 2018) |
| `marca_eda_*` (solo 2014) | 2m: 53/48 filas con marca NA y marca_eda presente; 4b: 1.908/1.903. **Ninguna** tiene palu publicado y nalu ≥ 10. Hoy, ignorarla (decisión A2 opción a) no cambia filas. |
| Celdas `marca` como cadena vacía | 14.517 con openxlsx: 2m/2018 (2.932 lect + 2.931 mate), 2m/2024 (2.903 mate), 2m/2025 (2.894 lect + 2.857 mate). readxl las lee como NA (0 blancos en las 36 columnas). 14.253 de ellas tienen palu publicado y nalu ≥ 10. |

Reconstrucción independiente (`reconstruccion_xlsx.R`, lector openxlsx, sin código del proyecto):

```
filas largo: 185378   clave (anio,nivel,prueba,rbd) única: TRUE
nalu no entero: 0  nalu<0: 0  nalu==0: 1073  nalu NA: 1524
ade/ele/ins: <0 0, >100 0, NA 34809, más de 1 decimal 0
suma de niveles (3 no NA): 150569 filas; ==0: 8216; [99,101]: 142353; fuera y >0: 0
ade no NA con ele o ins NA: 0
palu no NA con nalu<10: 8216 (todas con los tres niveles en 0: celdas suprimidas)
```

---

## E4. Universo y filtros

`universo.R` (reconstrucción independiente, `""` → NA en marca):

```
total XLSX 185378 | nalu NA -1524 | nalu<10 -41501 | marca -2008 | palu_ade NA -0 | => 140345 | cod_grupo NA -0
nalu<10: con los tres niveles en 0: 8216; con palu NA: 33285
marca con nalu>=10: todas (2008) tienen palu publicado
```

Bordes reales: filas con palu publicado y marca NA con nalu = 9: 534; = 10: 2.554; = 11: 2.390.

Establecimientos incluidos por año × nivel × prueba:

| anio | 2m lect | 2m mate | 4b lect | 4b mate |
|---|---|---|---|---|
| 2014 | 2514 | 2571 | 5034 | 5030 |
| 2015 | 2757 | 2766 | 4910 | 4916 |
| 2016 | 2753 | 2728 | 4950 | 4942 |
| 2017 | 2797 | 2812 | 5053 | 5058 |
| 2018 | 2861 | 2855 | 5105 | 5097 |
| 2022 | 2762 | 2768 | 4978 | 4996 |
| 2023 | 2859 | 2844 | 4930 | 4950 |
| 2024 | 2879 | 2856 | 5089 | 5103 |
| 2025 | 2857 | 2824 | 5063 | 5078 |

Evaluados incluidos:

| anio | 2m lect | 2m mate | 4b lect | 4b mate |
|---|---|---|---|---|
| 2014 | 168782 | 175911 | 202198 | 202352 |
| 2015 | 190747 | 195128 | 197711 | 198710 |
| 2016 | 190450 | 191127 | 199654 | 200539 |
| 2017 | 191661 | 196158 | 209737 | 210751 |
| 2018 | 194977 | 197558 | 218294 | 218767 |
| 2022 | 181174 | 183656 | 201200 | 203394 |
| 2023 | 196863 | 196655 | 199449 | 201084 |
| 2024 | 201706 | 200566 | 208938 | 211200 |
| 2025 | 199234 | 195871 | 202914 | 205875 |

Otros conteos:
- GSE de las filas incluidas: 1 = 22.924; 2 = 47.234; 3 = 38.043; 4 = 17.684; 5 = 14.460; NA = 0.
- Dependencia vigente de los RBD incluidos: 1 = 2.038; 2 = 2.963; 3 = 531; 4 = 70; 5 = 1.127.
- RBD en los XLSX: 9.176. RBD incluidos: 6.729. De ellos, 256 ausentes del catálogo de operativos (cerrados o no operativos).
- Operativos del directorio sin ninguna fila Simce: 2.639 de 10.945.
- Comunas con datos: 338 de 345. Regiones: 16.
- SLEP: 36. Catálogo de 2.337 filas, una por RBD; 0 RBD en más de un SLEP; 0 comunas en más de un SLEP.
- SLEP por año de traspaso: 2018 = 4, 2020 = 3, 2021 = 4, 2024 = 4, 2025 = 11, 2026 = 10.
- GSE constante por rbd×año×nivel entre pruebas: TRUE.

---

## E5. Cotejo del JSON publicado contra los XLSX

`extraer_json.R`: el JSON del motor pesa 13.602.975 bytes sin comprimir y 2.096.892 caracteres en base64; el de la vista, 2.018.141 bytes.

`cotejo_simce_rbd.R` (JSON `simce_rbd` de `docs/index.html` contra la reconstrucción con el filtro MINEDUC):

```
JSON simce_rbd filas: 140345 (= rows declarado); clave única: TRUE
reconstrucción filtro MINEDUC: 140345
en XLSX filtrado y no en JSON: 0   en JSON y no en XLSX filtrado: 0
nalu distinto: 0  ade distinto: 0  ele distinto: 0  ins distinto: 0  gse distinto: 0  gse NA: 0
rbd con >1 cod_depe2: 0   cod_depe2 NA: 0
cod_depe2 del XLSX del año distinto del vigente: 64937 de 140345 filas
  (p. ej. municipal en su año → SLEP vigente: 7.471 + 6.818 filas)
```

`cotejo_comunal.R`: agregación comunal recalculada con código propio, sin `agregar_ponderado()`. La comuna de los años A3 sale de otro año de los XLSX del mismo RBD.

```
JSON datos filas: 44975 (= rows); recálculo: 44975; clave única: TRUE; NA en cod_com/cod_depe2/cod_grupo: 0
solo en recálculo: 0  solo en JSON: 0
n_evaluados distinto: 0  n_estab distinto: 0
pct distinto de round(recálculo, 2): 78 (máx |dif| = 0,005: empates de redondeo); ele: 82; ins: 68
```

Las 78 diferencias son todas de 0,005: el recálculo da x,xx5 y R redondea en binario. Por ejemplo, 12,475 → 12,48 en el JSON.

`cotejo_tray.R`: DATA de `docs/trayectorias.html` contra el recálculo con la regla de la vista.

```
base trayectorias: 140345 filas = filas del motor (0 diferencias en ambos sentidos); cod_grupo NA: 0
nac: 270 celdas, 0 distintas
SLEP vigentes, panel 0: 36 unidades, 6323 filas, 0 distintas (ade, ins, n, e)
referente: 1299 RBD = meta$REF$cat; panel 0: 225 filas, 0 distintas
```

---

## E6. Ejecución del pipeline, reproducibilidad e idempotencia

```bash
cp -a <repo>/. $SP/work_A/
Rscript aud/directorio_sustituto.R ...   # operativos: 10945; no operativos con resultado: 256
cd $SP/work_A && unset LANG LC_ALL LC_CTYPE && R_PROFILE_USER=<vacío> Rscript 00_build.R   # A1
```

Log A1:
- `[ locale ] 10_configuracion: locale corregida en caliente a C.UTF-8 (el proceso arranco con C)`
- Validación de portabilidad: «Fallas criticas: 0 | Advertencias: 7».
- A3: recuperados 2.871/2.876 (2m/2015), 7.179/7.558 (4b/2015) y 7.183/7.444 (4b/2017) desde el directorio. Con el sustituto: el real no está disponible.
- Paso 32: «Filas con cod_grupo NA excluidas: 2330 (1.26%)», «Filas agregadas: 44975», «OK: 100% de cod_com_rbd con match».
- Paso 33: «JSON listo: 13597249 caracteres», «simce_rbd: 140345 filas».
- Paso 36: «DATA: 9 años, 74 entidades, 24745 filas en datos, 20948 en nube».
- «=== 00_build.R: OK en 17 segundos ===».

Salida A1 contra `docs/` (`comparar_html.R`, `extraer_json.R`):

```
index.html vs motor_comparacion.html | idénticos: FALSE | idénticos sin el bloque JSON: TRUE
trayectorias.html vs trayectorias_traspasos.html | idénticos: TRUE
JSON del motor: regiones, comunas, sleps, establecimientos, rbds_por_nivel, rbd_gse, simce_rbd idénticos;
  meta difiere solo en fecha_generacion (2026-09-26 publicado / 2026-10-02 A1);
  datos: pct difiere en 3 celdas, pct_ele en 16, pct_ins en 7, todas en 0,01 (empates de redondeo a 2 decimales)
```

Idempotencia: `snap()` = sha256 de todo `40_salidas/`.

```
A2 (build sobre A1, sin limpiar) == A1 ; A3 == A2      # byte a byte, incluidos los 6 parquet
B1 (copia limpia, LANG=C.UTF-8) == A1                  # byte a byte
```

Los parquet no incrustan marcas de tiempo (sha256 iguales). La única fuente de variación entre días es `meta$fecha_generacion = format(Sys.Date())` (`33_generar_html.R:203`).

---

## E7. Matemática del indicador

Fórmula implementada:

```
pct = sum(nalu * palu / 100) / sum(nalu) * 100
```

Se aplica a ade, ele e ins por separado, en `10_utils.R:78-85`.

Doble ponderación: no existe.
- El JS repondera `datos.pct` por `n_evaluados`, y `n_evaluados = sum(nalu)` de las mismas filas. Eso equivale algebraicamente a ponderar por nalu, salvo el redondeo a 2 decimales del JSON.
- Comprobado empíricamente: las 72 cifras de E11 coinciden exactamente.

---

## E8. Casos sintéticos de borde (`bordes.R`, funciones del proyecto cargadas desde la copia)

```
B1   OK    ponderado = 74.0000 (promedio simple sería 50)            # 10×20% + 90×80%
B2   OK    n_estab=2 n_eval=21 pct=0.0 (nalu=9 excluido, 10 y 11 conservados)
B3   OK    n_estab=1: marca '' (cadena vacía) se EXCLUYE como si fuera marca
B4   FALLA pct_elemental=15.0 (esperado 30): una fila con ele NA entra al denominador
B5   OK    ade con desglose 45.000000 = sin desglose 45.000000; suma niveles 100
B6a  OK    palu 150 y -10 aceptados sin aviso: pct=70.0
B6b  OK    palu Inf aceptado: pct=Inf
B6c  OK    palu NaN excluido por !is.na
B7   OK    grupo sin filas válidas: 0 filas, sin NaN (no hay división por cero)
B8   OK    regla de trayectorias: entran sumas 100, 99, 101; salen 98.9, 101.1 y 0
B9   OK    base_valida: nalu=9 sale, nalu=10 entra, marca sale
B10  OK    redondeo entero de trayectorias con empates hacia arriba
B11  OK    1 establecimiento = su palu; 5000 establecimientos: dif con fórmula directa 0
B12  OK    n_evaluados de clase integer
```

«OK» significa que la función se comporta como describe la línea; en B6a y B6b eso implica que acepta valores imposibles. B4 es un defecto latente: hoy hay 0 filas con ade publicado y ele/ins NA (E3).

---

## E9. Portabilidad

```r
source(here::here("10_utils","10_validar_portabilidad.R")); validar_portabilidad_autotest()
# == Autotest de sabotaje positivo ==  Violacion sembrada detectada: SI   Limpieza verificada: SI
```

Siembra propia en una copia: `30_procesamiento/99_plantado.R` con siete líneas, más un `fetch("C:/Users/...")` en `33_fragmento_sitio.html`.

| Línea sembrada | Detectada |
|---|---|
| `read.csv("C:/Users/ana/...")` | sí (ruta_usuario_windows, letra_unidad) |
| `setwd("/Users/ana/proyecto")` | sí (setwd, ruta_usuario_macos) |
| `readRDS("~/datos/...")` | sí (tilde_como_raiz) |
| `file.path(normalizePath("."), ...)` | **no** (no hay patrón) |
| `file.path(getwd(), ...)` | sí (advertencia getwd) |
| `read.csv("D:\\datos\\x.csv")` | sí (letra_unidad) |
| `"/home/ana/datos/x.csv"` | **no** (fuera del alcance declarado macOS/Windows) |
| ruta en `33_fragmento_sitio.html` | **no** (el validador solo escanea `.R/.Rmd/.qmd/.yml`) |

Salida de los checks de entorno: la columna `detalle` imprime el texto de falla incluso con estado OK. Por ejemplo, `renv_lock OK: "renv.lock ausente; renv es obligatorio..."`. La causa es que `.vp_check()` recibe un único `detalle` (`10_validar_portabilidad.R`, función `.vp_check`).

No se ejecutó en macOS ni en Windows.

---

## E10. Pruebas adversariales (15 mutaciones)

Arnés: `adv/correr.sh <id>`.
1. Copia `work_A`.
2. Aplica la mutación con `adv/mutar.sh`; si `git diff` del archivo no muestra cambios, aborta.
3. Borra las salidas y corre `00_build.R`.
4. Si el build termina bien, corre las dos baterías con Chromium `--no-sandbox`.
5. Borra la copia.

Ninguna mutación se aplicó al proyecto.

| ID | Mutación (archivo) | Build | Batería motor | Batería trayectorias | ¿Detectada? |
|---|---|---|---|---|---|
| ADV01 | `agregar_ponderado`: `pct_adecuado = mean(palu_eda_ade)`, promedio simple (`10_utils.R`) | OK | 8/8 PASA | 35/35 PASA | **NO** |
| ADV02 | umbral `nalu >= 9` (`10_utils.R`, `33_generar_html.R`) | OK | 8/8 | 35/35 | **NO** |
| ADV03 | marca tomada de la otra prueba (`31`, `col_marca`) | OK | 8/8 | FALLA R1, R3, R5, R6 | sí, solo en trayectorias y por conteos fijos del referente (1.299; 475/406/401) |
| ADV04 | GSE textual invertido Bajo↔Alto en 2014-2016 (`31`) | OK | 8/8 | FALLA D10, D10c | sí, solo por el cotejo con el mockup congelado |
| ADV05 | 50 filas duplicadas en 4b/2025 (`31`) | OK (solo warning «!= 2 filas») | 8/8 | FALLA D10, D10c | sí, solo por el mockup |
| ADV06 | `<link rel="stylesheet" href="https://fonts.googleapis.com/...">` en la plantilla del motor | OK | 8/8 (M1 PASA) | 35/35 | **NO** |
| ADV07 | `pct = round(pct_adecuado, 2) + 5` en el JSON del motor (`33`) | OK | 8/8 | 35/35 | **NO** |
| ADV08 | `gse_labels` del motor «1»=Alto, «5»=Bajo (`33`) | OK | 8/8 | 35/35 | **NO** |
| ADV09 | `COD_DEPE2 %% 5 + 1`, dependencia corrida (`31`) | OK | FALLA M4-M8 (la vista por defecto, Costa Central con depe 5, queda sin datos y las esperas agotan el tiempo; confirmado en corrida en serie) | FALLA D10, D10c, D11, R1, R3, R4, R5, R6 | sí; en el motor solo de forma incidental (render vacío, no prueba de datos) |
| ADV10 | GSE 5 excluido de la agregación comunal (`32`) | OK | 8/8 | 35/35 | **NO** |
| ADV11 | `d3.min.js` y `pako.min.js` con código agregado | OK | 8/8 | 35/35 | **NO** |
| ADV12 | año 2026 falso: copia de los XLSX 2025 como `*2026*` | OK (10 años; sin aviso) | 8/8 (M3 PASA: los años salen de los nombres) | FALLA D10 (filas sin pareja contra el mockup) | sí, incidental (snapshot); el build no advierte datos duplicados entre años |
| ADV13 | ponderación de trayectorias: `ade_num = sum(p_ade) * sum(nalu) / n()` (`36_funciones`) | OK | 8/8 | FALLA D10, D10c | sí (D10) |
| ADV14 | lect↔mate intercambiadas (`31`, `prueba`) | OK | FALLA M7 (geometría del tooltip, 10/12 aciertos; repetido en serie) | FALLA D10, D10c | sí; en el motor solo incidental (prueba de maquetación) |
| ADV15 | join duplicado en el catálogo SLEP: `df_dir_slep` repetido (`30`) | OK | 8/8 | 35/35 | **NO**. Efecto medido: `sleps_chile.parquet` con 4.674 filas (2.337 RBD distintos); `trayectorias_traspasos.html` idéntico; `motor_comparacion.html` distinto (catálogo duplicado en el JSON); las series no cambian porque `generateSeriesByRbd` usa `Set` y la vista usa `distinct` |

Resumen:
- 7 de 15 mutaciones no las detecta ninguna batería: ADV01, 02, 06, 07, 08, 10 y 11. Con ADV15, que tampoco se detecta, son 8, aunque ADV15 no altera cifras.
- La batería del motor no detectó ninguna mutación de datos o cálculo por una prueba de datos.
- Las detecciones de trayectorias dependen de D10, el cotejo con el mockup de la sesión 30, y de conteos esperados fijos.

Controles negativos, sin mutación (sección E6): 8/8 y 35/35 PASA. Corrida sin `--no-sandbox`: 5 y 6 FALLA con exit 1. Las baterías no producen falso PASS cuando el navegador no arranca.

---

## E11. Trazabilidad cifra visible → XLSX

`navegador_publicado.R`:
- Abre `docs/index.html` en Chromium con `Network.emulateNetworkConditions(offline = TRUE)`.
- Llama a las funciones del motor publicado (`SimceData.getSeriesForEntity`, `generateSeriesGseCombinado`), con etiquetas tomadas de `DATA.meta`.

`traza_muestra.R` compara esas cifras con el cálculo directo sobre las filas de los XLSX (openxlsx, filtro MINEDUC, comuna y dependencia como en E5).

Casos, cada uno con 9 años (2014-2018 y 2022-2025):

| Caso | Tipo |
|---|---|
| SLEP Costa Central (503; 73 RBD; comunas 5103, 5105, 5107, 5109; traspaso 2025), GSE Medio, 4° básico Lectura | SLEP + GSE |
| Comuna 5109, GSE Medio bajo, 2° medio Matemática | comuna |
| Región 13, GSE Bajo, 4° básico Matemática | región |
| Nacional, GSE Alto, 2° medio Lectura | nacional |
| Nacional con dependencia SLEP (depe2 = 5), GSE Bajo, 4° básico Lectura | dependencia |
| GSE combinado de la comuna 5109, 4° básico Lectura | todos los grupos |
| GSE combinado del SLEP 503, 4° básico Lectura | todos los grupos (SLEP) |
| GSE combinado nacional, 2° medio Matemática | todos los grupos (nacional) |

```
cifras cotejadas: 72  con valor JS: 72  pct distintos: 0  n_eval distintos: 0  n_estab distintos: 0
max |Elemental mostrado − Elemental ponderado crudo|: 0.07 pp ; Insuficiente: 0.07 pp
```

La diferencia en Elemental e Insuficiente viene de `mkPunto`, que reescala los dos niveles para que sumen 100 − Adecuado.

En la primera corrida las etiquetas con tilde llegaron mal a JS: las 72 series volvieron vacías y una comparación mal escrita las contó como coincidencias. Se corrigieron las etiquetas (tomadas de `DATA.meta`) y la comparación (NA contra valor = discrepancia). Solo vale el resultado de la segunda corrida.

Cadena trazada para cada cifra:

```
cifra JS (mkPunto)
  ← DATA (JSON del HTML publicado)
  ← simce_comunal / simce_rbd (reconstruidos en work_A, idénticos al JSON publicado, E6)
  ← agregación (recálculo independiente, E5)
  ← fila del XLSX original
```

Trazabilidad completa en % Adecuado y n para los 8 casos. El eslabón de clasificación (comuna A3 y dependencia) depende del directorio no disponible (manifiesto).

Vista de trayectorias: E5 (`cotejo_tray.R`) cubre `nac`, los 36 SLEP y el referente.

---

## E12. HTML standalone y red

Apertura offline (`navegador_publicado.R`):

```
motor: render OK en 2,7 s; solicitudes no locales: 0; errores JS: 0
trayectorias: render OK en 2,2 s; solicitudes no locales: 0; errores JS: 0; fuentes: gobCL-sitio:loaded ×2
```

- Incrustación (búsqueda literal del archivo vendorizado en `docs/index.html`): React, ReactDOM, D3 y pako: sí. Babel: no.
- `type="text/babel"` en el HTML publicado: no aparece.
- La vista de trayectorias no usa React ni D3.

`patrones_red.R` (qué reconoce cada patrón):

| Carga | M1 (motor) | D12 / autocontrol paso 36 |
|---|---|---|
| `<script src="https://...">` | sí | sí |
| `<link href="https://...">` | **no** | sí |
| `fetch("https://...")` | **no** | **no** |
| `XMLHttpRequest` | **no** | **no** |
| `import("https://...")` | **no** | **no** |
| `@import url(https://...)` | sí | **no** |
| `<img src='https://...'>` (comillas simples) | sí | **no** |
| `url(http://...)` | sí | **no** |

En el texto de `docs/index.html`, `mrun` aparece una vez dentro del base64 (secuencia aleatoria). No hay patrones RUN ni correos en claro. El pie arma en JS el correo institucional de una persona natural (plantilla 5075); el correo no se transcribe aquí.

---

## E13. Privacidad e historial

- `git ls-files | grep -i "directorio\|mrun"`: solo `glosas_directorio_oficial_ee.pdf`.
- `.gitignore:44` ignora el CSV.
- `git log --all -- 20_insumos/auxiliares/directorio_oficial_ee.csv`: vacío en el clon superficial.
- GitHub API (`get_commit`, solo metadatos) para `tomgc/slep_simce_adecuado@61c3b9b`:
  - sha 61c3b9b2ae2744beab73d1de1ecff79c8c328a0c, 2026-05-27;
  - `20_insumos/auxiliares/directorio_oficial_ee.csv` con status `added` y 16.769 líneas.
  - No se descargó el contenido.
  - `decisiones/20260622_decision_cumplimiento_ley_21719.md:85-86` declara que ese CSV trae 946 MRUN y que «permanece recuperable desde el historial»; §6 lo acepta como residual.
- Directorio sustituto: generado solo en `SP`, sin MRUN; nunca se copió al proyecto.

---

## E14. Documentación, backlog y paso 34

Un subagente de solo lectura hizo la lectura documental. Las afirmaciones usadas en hallazgos se reverificaron con estos comandos:

```bash
sed -n 104,110p 50_documentacion/activa/referencia_glosas_simce.md   # «Año 2025 son datos preliminares»; los 18 XLSX son *_final
grep -n "Decisión pendiente" referencia_glosas_simce.md               # :212 (A2), implementada como opción a (31:28, 237)
grep -n -i babel NOTICE                                             # 0 líneas (Babel vendorizado y versionado)
grep -n "index.html" gobernanza_datos.md                            # :27, :62, :79; no menciona docs/trayectorias.html
grep -n -i directorio decisiones/20260611_decision_repo_publico.md  # :23 «Insumos versionados: ... directorio MINEDUC»
grep -n "sin editar código" manifiesto_insumos.md                   # :93
grep -n "1.333" 30_procesamiento/36_funciones_trayectorias.R         # :56 (el referente medido es 1.299)
sed -n 151,153p README.md                                           # «usa la misma fórmula y los mismos filtros»
grep -ci prelim 36_funciones_trayectorias.R 36_generar_trayectorias.R 36_trayectorias_template.html   # 0 0 0
sed -n 162,172p 30_procesamiento/30_construir_auxiliares.R           # Q-98: solo setdiff de nombres de columna
sed -n 3216,3240p 30_procesamiento/33_motor_template.html            # exportarCSV recorre los 5 GSE para toda entidad
sed -n 1996,2017p 30_procesamiento/33_motor_template.html            # contarEstablecimientos: estab cuenta comuna+depe
sed -n 655,712p 30_procesamiento/36_trayectorias_template.html; sed -n 1126,1131p ...   # tooltip lee dataset interpolado
sed -n 843,902p 30_procesamiento/36_verificar_trayectorias.R         # R3 cambia cod_depe2 solo en las filas del año sintético
grep -n "no mide el efecto" 36_trayectorias_template.html           # :447, dentro de <div class="velo" id="velo" hidden>
```

Paso 34, en una copia: `Rscript 30_procesamiento/34_historico_pct_adecuado_costa_central.R`.
- exit 0.
- Las cuatro hojas son idénticas en valores al xlsx versionado.
- El filtro es solo `!is.na(nalu), !is.na(palu_eda_ade)` (líneas 88-89).
- Contra la regla del motor, en el universo Costa Central (4 comunas, depe2 = 5):
  - 4b lect 2023: 30,5 vs 32,7 (13 filas suprimidas con los tres niveles en 0)
  - 4b lect 2024: 34,4 vs 36,3 (11 filas)
  - 4b mate 2023: 13,2 vs 14,0 (11 filas)
  - 4b mate 2024: 14,4 vs 15,2 (10 filas)
  - máx |dif| = 2,2 pp
- El encabezado del script documenta que incluye filas marcadas, pero no menciona las celdas suprimidas con nalu < 10.

`00_escanear_proyecto.R` en una copia:
- exit 0.
- Reescribe `estructura_actual.{md,txt}`, crea un snapshot nuevo y **borra** 2 snapshots versionados («Poda: 2 archivo(s)»).

`renv::dependencies()` en una copia: usados y fuera del lock solo `suitedoc` (ignorado en `renv/settings.json`, decisión D35-18).

Incidente durante la propia auditoría, que confirma la justificación de la guarda de locale del proyecto (`10_locale.R`, H1):
- La primera generación de `AUDIT_FINDINGS.csv` corrió con `readr::write_delim` en un proceso R con locale C, sin la guarda.
- Escribió las tildes escapadas («decisi<c3><b3>n»).
- Se regeneró con `LANG=C.UTF-8`. Verificación: `grep -c '<c3>' AUDIT_FINDINGS.csv` = 0; `file` → «UTF-8 (with BOM)».

---

## E15. Consistencia entre artefactos

Script `consistencia.R` (R, scratchpad), ejecutado al cierre con `LANG=C.UTF-8`:

```
IDs CSV: 30  únicos: TRUE  IDs en informe: 30  iguales: TRUE
severidad ALTO: TRUE  MEDIO: TRUE  BAJO: TRUE  INFORMACIONAL: TRUE
todos los IDs del CSV clasificados en el informe: TRUE  (n = 30)
críticos en CSV: 0
secciones de evidencia: E1,E2,E3,E4,E5,E6,E7,E8,E9,E10,E11,E12,E13,E14,E15
referencias E# sin sección: (ninguna)
cada hallazgo cita evidencia E#: TRUE
tests de la evidencia declarados en el manifiesto: TRUE
posibles MRUN/RUN en artefactos: 0
```

Lo que se comprobó:
- La severidad de cada ID en AUDIT_REPORT.md (sección «Hallazgos altos», «medios», «bajos» e «Informacionales») es la misma que en AUDIT_FINDINGS.csv.
- Todo E# citado existe en este archivo.
- Los tests citados aquí figuran en AUDIT_MANIFEST.md.

Verificación complementaria: `md5sum 20_insumos/auxiliares/dim_slep_comunas.csv` = `fdb3015da12264d370a9d670c6886c0b`, igual a `manifiesto_insumos.md:79`.
