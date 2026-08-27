# Log — Medición de insumos para el "Panorama territorial"

**Fecha:** 2026-08-27
**Naturaleza:** medición de **solo lectura**. No se editó código, no se regeneró
el motor, no se tocó `docs/index.html`. La única escritura en el repositorio es
este log.
**Objetivo:** decidir si es construible una vista de distribución histórica entre
los tres niveles de logro (insuficiente / elemental / adecuado), en barras
apiladas al 100% por año, con % y N, GSE combinado, ponderación por matrícula,
para un nivel (4b o 2m) con sus dos pruebas lado a lado.

**Estado de partida.** Árbol limpio y sincronizado:

```
## main...origin/main
```
```
64bab61 deploy(pages): publica correcciones de enlace, exportacion PNG y siembra por defecto
```
```
2026-08-27 11:45:53 -04
```

Nada sin commitear. El estado esperado se cumplió.

---

## M1 — Estructura del insumo

### `Rscript -e '… simce_rbd.parquet … names() … str()'` (salida literal)

```
FILAS: 185378 

 [1] "anio"         "nivel"        "prueba"       "rbd"          "cod_com_rbd" 
 [6] "nom_com_rbd"  "cod_grupo"    "cod_depe2"    "nalu"         "palu_eda_ade"
[11] "palu_eda_ele" "palu_eda_ins" "marca"        "preliminar"   "prom"        
[16] "dif"          "difgru"       "sigdif"       "siggru"      

'data.frame':	185378 obs. of  19 variables:
 $ anio        : int  2014 2014 2014 2014 2014 2014 2014 2014 2014 2014 ...
 $ nivel       : chr  "2m" "2m" "2m" "2m" ...
 $ prueba      : chr  "lect" "lect" "lect" "lect" ...
 $ rbd         : chr  "1" "4" "5" "7" ...
 $ cod_com_rbd : chr  "15101" "15101" "15101" "15101" ...
 $ nom_com_rbd : chr  "ARICA" "ARICA" "ARICA" "ARICA" ...
 $ cod_grupo   : chr  "1" "2" "3" "1" ...
 $ cod_depe2   : chr  "5" "5" "5" "5" ...
 $ nalu        : int  77 130 56 97 46 23 31 49 41 302 ...
 $ palu_eda_ade: num  3.9 26.9 32.1 3.1 8.7 0 19.4 34.7 29.3 17.9 ...
 $ palu_eda_ele: num  16.9 39.2 41.1 13.4 23.9 4.3 16.1 49 36.6 23.5 ...
 $ palu_eda_ins: num  79.2 33.8 26.8 83.5 67.4 95.7 64.5 16.3 34.1 58.6 ...
 $ marca       : chr  NA "Ajenas a la Agencia: Resultados no representativos" ...
 $ preliminar  : logi  FALSE FALSE FALSE FALSE FALSE FALSE ...
 $ prom        : num  210 267 275 206 230 190 228 282 268 241 ...
 $ dif         : num  24 -9 11 2 11 -24 -4 19 -24 5 ...
 $ difgru      : num  -13 27 11 -17 7 -50 5 4 4 1 ...
 $ sigdif      : int  1 0 0 0 0 -1 0 1 -1 0 ...
 $ siggru      : int  -1 1 1 -1 0 -1 0 0 0 0 ...
```

### `Rscript -e '… simce_comunal.parquet … names() … str()'` (salida literal)

```
FILAS: 44975 
 [1] "anio"             "nivel"            "prueba"           "cod_com_rbd"     
 [5] "nom_com_rbd"      "cod_reg_rbd"      "nom_reg_rbd"      "cod_grupo"       
 [9] "cod_depe2"        "pct_adecuado"     "pct_elemental"    "pct_insuficiente"
[13] "n_evaluados"      "n_estab"         

'data.frame':	44975 obs. of  14 variables:
 $ anio            : int  2014 2014 2014 2014 2014 2014 2014 2014 2014 2014 ...
 $ nivel           : chr  "2m" "2m" "2m" "2m" ...
 $ prueba          : chr  "lect" "lect" "lect" "lect" ...
 $ cod_com_rbd     : chr  "10101" "10101" "10101" "10101" ...
 $ nom_com_rbd     : chr  "PUERTO MONTT" "PUERTO MONTT" "PUERTO MONTT" "PUERTO MONTT" ...
 $ cod_reg_rbd     : chr  "10" "10" "10" "10" ...
 $ nom_reg_rbd     : chr  "Los Lagos" "Los Lagos" "Los Lagos" "Los Lagos" ...
 $ cod_grupo       : chr  "3" "1" "2" "3" ...
 $ cod_depe2       : chr  "1" "2" "2" "2" ...
 $ pct_adecuado    : num  29.7 3.5 16.5 31.5 38.1 ...
 $ pct_elemental   : num  40.6 28.9 32.7 34.5 34.2 ...
 $ pct_insuficiente: num  29.7 67.6 50.7 34 27.7 ...
 $ n_evaluados     : int  175 142 544 479 386 105 97 86 52 29 ...
 $ n_estab         : int  1 1 8 4 9 2 2 1 1 1 ...
```

### Respuestas explícitas

**a) ¿Número de estudiantes por nivel, o solo porcentaje?**

**Solo PORCENTAJE.** No existe ninguna columna con el número de estudiantes en
cada nivel de logro, en ninguno de los dos archivos.

- En `simce_rbd.parquet`: `palu_eda_ade`, `palu_eda_ele`, `palu_eda_ins`, las
  tres `num`, en escala 0–100 (`str()` muestra valores como 3.9, 16.9, 79.2 que
  suman ~100).
- En `simce_comunal.parquet`: `pct_adecuado`, `pct_elemental`,
  `pct_insuficiente`, las tres `num`, mismo formato.

**b) ¿Existe matrícula o evaluados? ¿Cómo se llama?**

**Sí, y se llama distinto en cada archivo:**

- `simce_rbd.parquet` → **`nalu`**, `int` (`str()`: 77, 130, 56, 97…). Es el
  número de alumnos evaluados del establecimiento en ese año × nivel × prueba ×
  GSE.
- `simce_comunal.parquet` → **`n_evaluados`**, `int` (`str()`: 175, 142, 544…).
  Además trae **`n_estab`**, `int`, el número de establecimientos agregados en
  esa celda, que no existe en el archivo por RBD y hay que derivarlo.

**c) ¿El N se puede reconstruir como porcentaje × matrícula?**

**Sí, y es la única vía.** `N_nivel = pct_nivel × matrícula / 100`. La precisión
de esa reconstrucción se midió en M3 y resulta exacta al entero. La salvedad no
es la aritmética sino la procedencia: el N sería **derivado**, no publicado por
la Agencia, y eso conviene que quede dicho en la interfaz o en su nota
metodológica.

### Tabla de M1

| Medición | Valor | Comando |
|---|---|---|
| Filas de `simce_rbd.parquet` | 185.378 | `Rscript -e 'cat("FILAS:", nrow(x))'` |
| Columnas de `simce_rbd.parquet` | 19 | `print(names(x))` |
| Filas de `simce_comunal.parquet` | 44.975 | `Rscript -e 'cat("FILAS:", nrow(x))'` |
| Columnas de `simce_comunal.parquet` | 14 | `print(names(x))` |
| Columnas con N por nivel | **0** | inspección de `names()` en ambos |
| Columnas de matrícula | 2 (`nalu`, `n_evaluados`) | inspección de `names()` |

---

## M2 — ¿Los tres niveles suman 100?

### Salida literal

```
=============== simce_rbd.parquet ===============
filas totales: 185378 
filas con los TRES niveles NA a la vez: 34809 
filas con la suma NA (algun nivel NA): 34809 
filas con suma calculable: 150569 
rango de la suma: [ 0.000000 , 100.100000 ]
filas que se desvian mas de 0.5 puntos de 100: 8216 
desviacion absoluta maxima respecto de 100: 100.000000 
percentiles de |suma-100|:
 50%  95%  99% 100% 
   0  100  100  100 

=============== simce_comunal.parquet ===============
filas totales: 44975 
filas con los TRES niveles NA a la vez: 0 
filas con la suma NA: 0 
filas con suma calculable: 44975 
rango de la suma: [ 99.900000 , 100.100000 ]
filas que se desvian mas de 0.5 puntos de 100: 0 
desviacion absoluta maxima respecto de 100: 0.100000 
percentiles de |suma-100|:
 50%  95%  99% 100% 
 0.0  0.1  0.1  0.1 
```

Una desviación máxima de **100** obligaba a mirar qué son esas filas antes de
concluir nada. Segunda medición:

```
filas con suma calculable: 150569 
filas con suma EXACTAMENTE 0: 8216 
filas que se desvian >0.5 de 100: 8216 
filas que se desvian >0.5 de 100 Y NO son suma 0: 0 

rango de la suma EXCLUYENDO las filas de suma 0:
  [ 99.9 , 100.1 ]  filas: 142353 
  filas que se desvian >0.5 de 100 en ese subconjunto: 0 

=== que son las filas de suma 0: nalu y marca ===
nalu: min 0 max 9 | NA: 0 
  marca    n
1  <NA> 6130
2     1 1954
3     2  132

distribucion de nalu en filas de suma 0:
    0   1-4   5-9 10-19   20+ 
   58  5065  3093     0     0 
```

### Conclusión de M2

**Sí suman 100**, dentro de ±0,1 por redondeo a un decimal, **una vez excluida la
supresión**. El cálculo de barras apiladas al 100% no requiere renormalizar.

El matiz que sí cambia el diseño: **la supresión viene codificada como tres
ceros, no como NA**. Las 8.216 filas de suma 0 tienen `nalu` entre 0 y 9
(`min 0 max 9`, `Rscript … cat("nalu: min", min(z$nalu)…)`), es decir todas por
debajo del umbral de 10 del proyecto, y ninguna llega a 10. Si la vista tratara
esos ceros como dato, dibujaría una barra vacía donde corresponde decir "sin
dato". La condición de exclusión debe ser explícita:
`is.na(suma) | suma == 0 | nalu < 10`.

### Tabla de M2

| Medición | Valor esperado | Valor medido | Comando |
|---|---|---|---|
| Rango de la suma, `simce_rbd` crudo | ~100 | [0 , 100,1] | `cat("rango de la suma: [", min(sv), ",", max(sv), "]")` |
| Rango excluyendo suma 0 | ~100 | **[99,9 , 100,1]** | mismo, sobre `s[ok & s != 0]` |
| Filas que se desvían >0,5 de 100 | 0 | 8.216 crudo → **0** excluyendo suma 0 | `sum(abs(sv - 100) > 0.5)` |
| Filas de suma exactamente 0 | — | 8.216 | `sum(ok & s == 0)` |
| Desviaciones que NO son suma 0 | — | **0** | `sum(ok & abs(s-100) > 0.5 & s != 0)` |
| `nalu` máximo en filas de suma 0 | <10 | **9** | `max(z$nalu, na.rm=TRUE)` |
| Filas con los tres NA a la vez, `simce_rbd` | — | 34.809 | `sum(tres_na)` |
| Filas con los tres NA a la vez, `simce_comunal` | — | **0** | `sum(tres_na2)` |
| Rango de la suma, `simce_comunal` | ~100 | **[99,9 , 100,1]**, 0 desviaciones | `min/max` y `sum(abs(sv2-100) > 0.5)` |

---

## M3 — Reconstrucción del N y su error

Se ejecutó sobre **142.353 filas** de `simce_rbd` con dato completo y `nalu ≥ 10`
(`cat("filas con datos completos y nalu>=10:", nrow(d))`) y sobre las **44.975**
filas de `simce_comunal` con `n_evaluados > 0`, muy por encima del mínimo de
5.000 pedido.

### Salida literal

```
=============== simce_rbd.parquet ===============
filas con datos completos y nalu>=10 (umbral del proyecto): 142353 

-- desviacion ABSOLUTA en estudiantes: |sum(N reconstruidos) - nalu| --
  50%   95%  100% 
0.000 0.075 0.584 

-- desviacion RELATIVA: |dev| / nalu * 100 (puntos porcentuales) --
 50%  95% 100% 
 0.0  0.1  0.1 

-- si ademas se REDONDEA cada N a entero --
filas donde la suma de los 3 enteros != nalu: 0 ( 0 % )
 50%  95% 100% 
   0    0    0 

=============== simce_comunal.parquet ===============
filas con n_evaluados > 0: 44975 

-- desviacion ABSOLUTA en estudiantes --
  50%   95%  100% 
0.000 0.129 1.103 

-- desviacion RELATIVA (puntos porcentuales) --
 50%  95% 100% 
 0.0  0.1  0.1 

-- redondeando cada N a entero --
filas donde la suma de los 3 enteros != n_evaluados: 2 ( 0 % )
 50%  95% 100% 
   0    0    1 
```

### Conclusión de M3

**El N se puede rotular como exacto, con una nota.** En `simce_rbd`, redondeando
cada N a entero, los tres suman exactamente la matrícula en **142.353 de 142.353
filas** — cero excepciones (`sum(r != d$nalu)` = 0). En `simce_comunal` fallan
**2 de 44.975** filas, y por **1 estudiante** (`max |r2 - n_evaluados|` = 1).

Antes de redondear, la desviación mediana es 0 y la máxima 0,584 estudiantes en
`simce_rbd` y 1,103 en `simce_comunal` (percentil 100 de `abs(dev)`). Es puro
redondeo del porcentaje a un decimal en origen.

**Salvedad de implementación, medida.** El N debe calcularse desde el porcentaje
en **precisión completa**, no desde el porcentaje ya redondeado para mostrar. En
el ejemplo de la medición adicional, usando `round(pct, 1)` antes de multiplicar,
la suma de los tres N se desvía hasta **4 estudiantes** de la matrícula
(3.486 contra 3.482, Viña del Mar 2014). Con precisión completa, cero.

---

## M4 — Supresión y cobertura por año

### Salida literal

```
  anio filas sin_nivel sin_matricula estab_completos pct_sin_nivel
1 2014 20838      5380          5380            5915          25.8
2 2015 20868      5383          5383            5870          25.8
3 2016 20818      5144          5144            5949          24.7
4 2017 20734      4886          4886            5997          23.6
5 2018 20698      4753          4753            5992          23.0
6 2022 20372      4486          4486            5877          22.0
7 2023 20390      4578          4578            5824          22.5
8 2024 20370      4248          4248            5952          20.9
9 2025 20290      4167          4167            5953          20.5

TOTAL: 185378 filas | 43025 sin nivel | 43025 sin matricula | 6731 estab completos
```

### Años presentes

```
[1] 2014 2015 2016 2017 2018 2022 2023 2024 2025
```

Nueve años, con el hueco **2019–2021** (pandemia), idéntico en
`simce_comunal.parquet` (`print(sort(unique(y$anio)))`). La vista debe cortar la
serie ahí, como ya hace el sparkline del motor.

### 2025 y la marca de preliminar

```
  anio preliminar_TRUE preliminar_FALSE
1 2014               0            20838
2 2015               0            20868
3 2016               0            20818
4 2017               0            20734
5 2018               0            20698
6 2022               0            20372
7 2023               0            20390
8 2024               0            20370
9 2025           20290                0
```

**Sí: 2025 viene marcado como preliminar, y de forma total** — las 20.290 filas
del año, sin excepción (`summarise(.by = anio, preliminar_TRUE = sum(preliminar))`).
La columna se llama `preliminar` y es `logi`.

**Pero solo existe en `simce_rbd.parquet`.** En `simce_comunal.parquet` no hay
ninguna columna con esa raíz:

```
columnas de simce_comunal que contienen preliminar:  | ninguna si vacio
```

(`paste(grep("prelim", names(y), value=TRUE, ignore.case=TRUE), collapse=", ")`.)
Si la vista se alimenta del archivo comunal, la marca de preliminar hay que
derivarla del año o traerla por join.

### Hallazgo: las dos causas de falta coinciden exactamente

```
         sin_matricula
sin_nivel  FALSE   TRUE
    FALSE 142353      0
    TRUE       0  43025
filas donde difieren: 0 
```

No hay ni una sola fila con nivel de logro pero sin matrícula utilizable, ni al
revés (`sum(sin_nivel != sin_mat)` = 0). El filtro de la vista es uno solo, no
dos.

### Tabla de M4

| Medición | Valor medido | Comando |
|---|---|---|
| Años presentes | 9: 2014-2018, 2022-2025 | `sort(unique(x$anio))` |
| Hueco de la serie | 2019-2021 | mismo |
| Filas totales | 185.378 | `nrow(x)` |
| Filas sin nivel de logro | 43.025 (23,2%) | `sum(x$sin_nivel)` |
| Filas sin matrícula utilizable | 43.025 | `sum(x$sin_matricula)` |
| Coincidencia de ambas causas | exacta, 0 discrepancias | `table(sin_nivel, sin_matricula)` |
| Establecimientos distintos con dato completo | 6.731 | `n_distinct(x$rbd[x$completa])` |
| Supresión más alta | 25,8% en 2014 | columna `pct_sin_nivel` |
| Supresión más baja | 20,5% en 2025 | columna `pct_sin_nivel` |
| 2025 preliminar | 20.290 de 20.290 | `sum(preliminar)` por año |

---

## M5 — Desagregación disponible

### Respuestas explícitas

**¿Qué columna separa por prueba?** **`prueba`**, `chr`, con exactamente dos
valores:

```
valores unicos de prueba: lect, mate 
```

**¿Qué columna separa por nivel?** **`nivel`**, `chr`, con exactamente dos
valores:

```
valores unicos de nivel : 2m, 4b 
```

Ambas existen con el mismo nombre y los mismos valores en `simce_comunal.parquet`
(`cat("valores unicos en simce_comunal -> nivel:", …, "| prueba:", …)`), así que
la vista puede alimentarse de cualquiera de los dos archivos sin traducir claves.

Complementariamente, **`cod_grupo`** separa por GSE con cinco valores
(`1, 2, 3, 4, 5`) y **`cod_depe2`** por dependencia, también cinco (`1..5`). La
vista pide **GSE combinado**, o sea agregar sobre `cod_grupo` ponderando por
matrícula; los cinco niveles están todos presentes.

### Filas por combinación (salida literal, versión corregida)

```
=== M5 corregido: filas por nivel x prueba (simce_rbd) ===
  nivel prueba filas completas pct_completas
1    2m   lect 26357     25706          97.5
2    2m   mate 26357     25727          97.6
3    4b   lect 66332     45429          68.5
4    4b   mate 66332     45491          68.6

control: suma de filas = 185378 | total del archivo = 185378 
control: suma de completas = 142353 | esperado 142353 

=== establecimientos distintos con dato completo, por nivel x prueba ===
  nivel prueba estab
1    2m   lect  3145
2    2m   mate  3149
3    4b   lect  5849
4    4b   mate  5847
```

```
filas por combinacion nivel x prueba (simce_comunal):
  nivel prueba filas
1    2m   lect 10062
2    2m   mate 10075
3    4b   lect 12419
4    4b   mate 12419
```

### Serie por año, para ver el ciclo

```
=== 4b x lect: filas por anio ===
  anio filas completas
1 2014  7667      5047
2 2015  7558      4940
3 2016  7507      5013
4 2017  7444      5069
5 2018  7414      5116
6 2022  7210      5035
7 2023  7204      4978
8 2024  7185      5118
9 2025  7143      5113

=== 2m x lect: filas por anio ===
  anio filas completas
1 2014  2752      2673
2 2015  2876      2797
3 2016  2902      2827
4 2017  2923      2850
5 2018  2935      2861
6 2022  2976      2895
7 2023  2991      2922
8 2024  3000      2936
9 2025  3002      2945
```

**Asimetría relevante para el diseño:** 4b tiene 66.332 filas pero solo **68,5%**
completas; 2m tiene 26.357 y **97,5%**. La diferencia es estructural: 4b se rinde
en muchas escuelas pequeñas que caen bajo el umbral de 10, y 2m se concentra en
liceos más grandes. Una vista de 4b para una comuna rural tendrá muchos más
establecimientos suprimidos que la misma vista en 2m, y conviene que el N y el
conteo de establecimientos estén a la vista para que eso se note.

### Error propio, corregido

La primera versión de esta medición dio `completas = 138947` sobre `filas = 26357`,
un imposible. Causa: calculé el vector `s` **fuera** del data frame y `dplyr` lo
recicló por grupo; R emitió el aviso *"longitud de objeto mayor no es múltiplo de
la longitud de uno menor"*. Se rehízo con `mutate(suma = …, completa = …)` dentro
del data frame y se añadieron dos controles que antes no existían: la suma de
filas por grupo contra `nrow(x)` (185.378 = 185.378) y la suma de completas
contra el total de M3 (142.353 = 142.353). Ambos cuadran.

---

## M6 — Identificación del territorio, y el truncamiento

### La premisa previa era incorrecta, y por partida doble

Una medición anterior de esta misma sesión afirmó que `nom_com_rbd` "viene
truncado a 5 caracteres". **Esa afirmación es falsa como generalización**, y el
problema real es más grave que el truncamiento.

### Salida literal

```
=============== simce_rbd.parquet ===============
longitud maxima de nom_com_rbd: 20 
longitud minima: 4 
distribucion de longitudes:
    4     5     6     7     8     9    10    11    12    13    14    15    16 
 3320 31118 19736 21238 25218 23260 20904 16182 12618  6218   790  2144   790 
   17    19    20 
  278  1218   346 

nombres distintos: 1018 | codigos distintos: 346 

5 casos con MAS codigos por nombre:
  nom_com_rbd n_codigos                   codigos
1       San P         4  10307, 13505, 2203, 8108
2       Santa         4    5706, 6310, 8109, 8311
3       San J         4 10306, 13129, 13203, 7406
4 PROVIDENCIA         3       13113, 13120, 13123
5   San Pedro         3         13505, 2203, 8108
```

**Longitud máxima 20, no 5.** El truncamiento existe pero es de **longitud
variable**, y convive con otras dos patologías. La señal más clara es que hay
**1.018 nombres distintos para solo 346 códigos**: más etiquetas que entidades,
lo que solo puede ocurrir si un mismo código se escribe de varias formas.

```
=== cuantas VARIANTES DE NOMBRE tiene cada codigo en simce_rbd ===
  1   2   3   4   5   6 
  1  46 230  56  11   2 
codigos con mas de una variante: 345 de 346 

5 codigos con MAS variantes de nombre:
  cod_com_rbd n                                       variantes
1       10306 6  San J | San Juan | SAN JUAN DE L | SAN JUAN DE LA C | SAN JUAN DE LA COST | SAN JUAN DE LA COSTA
2        2203 6  San P | San Pedro | SAN PEDRO DE | SAN PEDRO DE ATA | SAN PEDRO DE ATACAM | SAN PEDRO DE ATACAMA
3        5601 5  San A | SAN A | San Anton | SAN ANTON | SAN ANTONIO
4        6114 5  Quint | Quinta De | QUINTA DE TIL | QUINTA DE TILCOC | QUINTA DE TILCOCO
5        7109 5  San C | SAN C | San Cleme | SAN CLEMENTE | TALCA
```

**345 de 346 códigos tienen más de una variante de nombre.** Solo uno es
consistente.

### Tres patologías distintas, no una

1. **Truncamiento de longitud variable.** El código 10306 aparece como `San J`,
   `San Juan`, `SAN JUAN DE L`, `SAN JUAN DE LA C`, `SAN JUAN DE LA COST` y
   `SAN JUAN DE LA COSTA`: seis cortes distintos del mismo nombre.
2. **Inconsistencia de mayúsculas.** `SAN A` / `San A`, `ÑUÑOA` / `Ñuñoa`,
   `LA REINA` / `La Reina`.
3. **Nombres derechamente equivocados.** No son cortes: son etiquetas de otra
   comuna. El código 7109 (SAN CLEMENTE) aparece 
   como `TALCA`. Y el caso de Providencia:

```
=== el caso PROVIDENCIA: que son 13113, 13120, 13123 segun el catalogo ===
  cod_com_rbd nom_com_rbd   nom_reg_rbd
1       13123 PROVIDENCIA Metropolitana
2       13120       ÑUÑOA Metropolitana
3       13113    LA REINA Metropolitana

y que nombres les da simce_rbd:
   cod_com_rbd nom_com_rbd    n
1        13113    LA REINA  906
2        13113       La Re   62
3        13113    La Reina   46
4        13113  LAS CONDES    6
5        13113 PROVIDENCIA    6
6        13120       ÑUÑOA 1434
7        13120       Ñuñoa  184
8        13120 PROVIDENCIA    2
9        13123 PROVIDENCIA  930
10       13123   Providenc   62
11       13123       Provi   60
```

El código 13113 es LA REINA, y tiene **6 filas etiquetadas LAS CONDES** y **6
etiquetadas PROVIDENCIA**. El 13120 es ÑUÑOA y tiene **2 etiquetadas
PROVIDENCIA**. Agregar por nombre no solo fusionaría comunas: les atribuiría
estudiantes de otra.

### Los otros dos archivos están limpios

```
=============== simce_comunal.parquet ===============
longitud maxima de nom_com_rbd: 20 
nombres distintos: 338 | codigos distintos: 338 
5 casos con mas codigos por nombre:
   nom_com_rbd n_codigos
1 PUERTO MONTT         1
...

=============== comunas_chile.parquet (catalogo) ===============
filas: 345 | longitud maxima de nom_com_rbd: 20 
nombres distintos: 345 | codigos distintos: 345 
los codigos que en simce_rbd caen bajo Puert:
  cod_com_rbd  nom_com_rbd nom_reg_rbd
1       10101 PUERTO MONTT   Los Lagos
2       10109 PUERTO VARAS   Los Lagos
3       10302 PUERTO OCTAY   Los Lagos
```

Relación **1:1** en ambos. `simce_comunal.parquet` ya resolvió el problema aguas
arriba.

### Un código huérfano

```
=== el codigo 12202, ausente del catalogo ===
filas: 4 | nombres: ANTÁRTICA 
rbd distintos: 1 | anios: 2014, 2015 
filas con dato completo: 0 
aparece 12202 en simce_comunal? NO 
```

```
codigos de simce_rbd ausentes del catalogo: 1 12202 
codigos del catalogo ausentes de simce_rbd: 0 
```

El código **12202 (ANTÁRTICA)** existe en `simce_rbd` pero no en
`comunas_chile.parquet`. Son 4 filas, 1 establecimiento, años 2014 y 2015, y
**cero con dato completo** (`sum(w2$completa)` = 0). Tampoco llega a
`simce_comunal`. Es inocuo para esta vista, pero conviene saber que un selector
construido desde el catálogo no lo ofrecerá jamás, y que eso es correcto: no hay
nada que mostrar.

### Respuestas explícitas

**¿Cuál es la clave fiable para agregar por comuna?**

**`cod_com_rbd`, sin ninguna duda.** Es la única columna con relación 1:1 con la
entidad. `nom_com_rbd` de `simce_rbd.parquet` **no debe usarse jamás como clave
de agregación**: produciría fusiones silenciosas —"San P" une 4 comunas de 4
regiones distintas— y atribuciones erróneas.

**¿De dónde salen los nombres legibles que el motor ya muestra?**

De **`comunas_chile.parquet`**, vía el catálogo que arma
`30_procesamiento/33_generar_html.R` líneas 61-68:

```r
# --- Catálogo de comunas (compactado: cod, nom, cod_reg, nom_reg) ---
comunas_lst <- df_comunas |>
  dplyr::transmute(
    cod     = cod_com_rbd,
    nom     = nom_com_rbd,
    cod_reg = cod_reg_rbd,
    nom_reg = nom_reg_rbd
  ) |>
  dplyr::arrange(nom)
```

Y ese parquet no se deriva del archivo de resultados, sino del **directorio
oficial de MINEDUC**, en `30_construir_auxiliares.R` bloque 3:

```r
df_comunas <- df_dir_raw |>
  dplyr::filter(.data$ESTADO_ESTAB == 1, .data$MATRICULA == 1) |>
  dplyr::transmute(
    cod_com_rbd = as.character(COD_COM_RBD),
    nom_com_rbd = NOM_COM_RBD,
    ...
  ) |>
  dplyr::distinct()
```

Es una fuente **independiente** del archivo de resultados, y esa es la razón de
que esté limpia. El motor ya hace lo correcto; la vista nueva debe hacer lo
mismo: **agregar por `cod_com_rbd`, rotular con el catálogo.**

---

## M7 — El patrón de pestañas del proyecto hermano

`/Users/tomgc/Projects/slep_idps` **existe**. Se leyó, sin escribir nada y sin
ejecutar git en ese repositorio.

```
drwxr-xr-x  22 tomgc  staff    704 Aug 24 10:40 .
-rw-r--r--@  1 tomgc  staff   7072 Jul 29 09:00 00_build.R
drwxr-xr-x  14 tomgc  staff    448 Aug 26 20:27 .git
drwxr-xr-x   8 tomgc  staff    256 Aug 24 10:40 10_utils
drwxr-xr-x  35 tomgc  staff   1120 Jul 27 14:45 20_insumos
drwxr-xr-x   9 tomgc  staff    288 Jul 29 09:00 30_procesamiento
drwxr-xr-x   4 tomgc  staff    128 Aug 24 10:40 40_salidas
drwxr-xr-x   8 tomgc  staff    256 Aug 22 09:00 50_documentacion
drwxr-xr-x@  3 tomgc  staff    96 Jul 27 14:45 docs
```

El componente está en `30_procesamiento/35_motor_template.html` (128 KB) y su
copia desplegada en `docs/index.html`. Tiene **tres** pantallas, no dos.

### JSX — definición de las pantallas (líneas 1439-1441)

```jsx
  const PANTALLAS=[["territorio","Panorama territorial"],
                   ["ficha","Panorama IDPS por establecimiento"],
                   ["comparar","Comparación entre territorios"]];
```

### JSX — la barra de pestañas (líneas 1541-1552)

```jsx
        {/* Nav de pantallas: barra blanca sticky full-width bajo el header (#4) */}
        <nav className="app-nav" aria-label="Pantallas del motor">
          <div className="app-nav-inner">
            <div className="screen-tabs" role="tablist">
              {PANTALLAS.map(([k,lbl])=>(
                <button key={k} role="tab" aria-selected={pantalla===k}
                  className={"screen-tab"+(pantalla===k?" is-active":"")}
                  onClick={()=>setPantalla(k)}>{lbl}</button>))}
            </div>
          </div>
        </nav>
```

### JSX — el router de pantalla (línea 1560 y siguientes)

```jsx
          {/* Router de pantalla. Sin cifra agregada: el territorio acota, no promedia. */}
          {pantalla==="comparar" && <Comparador cmpTerr={cmpTerr} cmpGrado={cmpGrado} … />}
```

### CSS — las cuatro reglas (líneas 77-82)

```css
  .app-nav{background:var(--paper);position:sticky;top:0;z-index:40;border-bottom:1px solid var(--linea);box-shadow:0 1px 0 rgba(74,39,70,.04);}
  .app-nav-inner{max-width:1200px;margin:0 auto;padding:0 24px;display:flex;gap:2px;flex-wrap:wrap;}
  .screen-tabs{display:flex;gap:0;flex-wrap:wrap;}
  .screen-tab{appearance:none;background:none;border:none;padding:14px 18px;font-family:var(--font-body);font-weight:var(--fw-bold);font-size:var(--fs-body-lg);color:var(--gris);cursor:pointer;border-bottom:3px solid transparent;white-space:nowrap;}
  .screen-tab:hover{color:var(--tinta);}
  .screen-tab.is-active{color:var(--azul);border-bottom-color:var(--coral);}
```

### Notas de portabilidad

- El patrón es **enteramente replicable**: un array de pares `[clave, rótulo]`, un
  `useState` de pantalla, un `map` a `<button role="tab">` y un router de
  cortocircuito. No usa librería de routing.
- Accesibilidad ya resuelta: `role="tablist"`, `role="tab"`, `aria-selected`,
  `aria-label` en el `<nav>`. Conviene copiar eso tal cual.
- Las variables CSS que usa —`--paper`, `--linea`, `--gris`, `--tinta`, `--azul`,
  `--coral`, `--fw-bold`, `--fs-body-lg`— son del sistema de `slep_idps`. **No
  se verificó** cuáles existen en `33_motor_template.html` de este proyecto; hay
  que mapearlas antes de reutilizar el bloque.
- `.screen-tab` usa `padding:14px 18px` en píxeles literales dentro de una regla
  CSS. Este proyecto tiene el invariante 🔒 de **cero literales `px` en CSS
  declarativo**, así que el bloque **no se puede copiar tal cual**: habría que
  expresarlo con las variables de espaciado locales.
- **No se copió nada** al proyecto. Esta sección es solo exhibición.

---

## M8 — Colisión de paleta

### Salida literal

```
### grep -rn "D-color-nivel" 50_documentacion/activa/decisiones/
(fin)
```

**El identificador `D-color-nivel` no aparece en la carpeta de decisiones.** La
decisión existe, pero bajo otro nombre de archivo:

```
-rw-r--r--@  1 tomgc  staff  3066 Jun 11 20:07 20260611_decision_color_por_nivel.md
```

```
### grep -n "Insuficiente\|Elemental\|insuficiente\|elemental" 33_motor_template.html | head -20
1477:    // Colores fijos para los segmentos Elemental e Insuficiente (modo apilado).
1484:    const COLOR_ELEM  = "#6BA0CE";  // azul claro (Elemental)
1485:    const COLOR_INSUF = "#79204F";  // vino (Insuficiente)
1728:              <span class="tt-seg-lbl">Elemental</span>
1733:              <span class="tt-seg-lbl">Insuficiente</span>
2090:            // Dos segmentos apilados sobre Adecuado: Elemental (medio) e
2091:            // Insuficiente (arriba). Colores fijos, no por territorio, para que la
2094:              { key: "ele", val: s.pct_ele, fill: COLOR_ELEM, label: "Elemental" },
2095:              { key: "ins", val: s.pct_ins, fill: COLOR_INSUF, label: "Insuficiente" },
2145:          // para no caer sobre el segmento Elemental. En modo solo-Adecuado
2374:            <span>Elemental</span>
2378:            <span>Insuficiente</span>
3445:                      title="Mostrar u ocultar el área Elemental + Insuficiente">
3446:                      Mostrar niveles Elemental e Insuficiente
3524:                      <p><b>Elemental:</b> Estudiantes que han logrado lo exigido en el currículum …</p>
3525:                      <p><b>Insuficiente:</b> Estudiantes que no logran demostrar consistentemente …</p>
```

### Respuestas explícitas

**¿El motor ya define colores para los tres niveles, o solo para Adecuado?**

**Para los tres, y desde hace tiempo.** Están declarados juntos en
`30_procesamiento/33_motor_template.html`:

| Nivel | Constante | Color | Línea |
|---|---|---|---|
| Adecuado | `COLOR_ADEC` | `#0C4682` (azul) | 1483 |
| Elemental | `COLOR_ELEM` | `#6BA0CE` (azul claro) | **1484** |
| Insuficiente | `COLOR_INSUF` | `#79204F` (vino) | **1485** |

Y ya se usan en un apilado: líneas 2094-2095 construyen los segmentos
`{ key: "ele", fill: COLOR_ELEM }` y `{ key: "ins", fill: COLOR_INSUF }` sobre
Adecuado, en el subgráfico de barras. El motor **ya tiene** una barra apilada de
tres niveles; lo que la vista nueva agrega es normalizarla al 100%, extenderla a
toda la serie histórica y ponerle N.

**Conclusión práctica: no hay colisión de paleta que resolver.** La vista nueva
debe reutilizar las tres constantes existentes. Inventar una paleta nueva sería
el error que la decisión de junio vino a corregir.

**¿Qué restringe la decisión?**

`20260611_decision_color_por_nivel.md`, estado **vigente**, establece:

- **Color fijo por nivel de logro, idéntico en todas las entidades.** El motivo
  registrado: *"un mismo nivel no puede tener distintos colores si representa lo
  mismo"*.
- **`entity.color` queda reducido a identidad de entidad únicamente**: swatch de
  tarjeta, encabezado del supergrid, exportación y borde de ficha. Cito
  textualmente: *"Nunca vuelve a codificar el valor del dato en el dibujo de
  series."*
- **Invariante 🔒 explícito:** *"cualquier sesión futura que toque el dibujo de
  series usa `COLOR_ADEC` para Adecuado, jamás `entity.color`."*

Para el "Panorama territorial", que muestra **un territorio a la vez**, la
restricción se aplica sin fricción: las barras apiladas van con las tres
constantes de nivel, y el color del territorio solo puede aparecer en su
identificación (título, swatch, borde), nunca en los segmentos.

Nota lateral: la decisión menciona *"el tope de 4 entidades simultáneas
(`MAX_ENTIDADES`)"*, pero `MAX_ENTIDADES` vale **5**
(`grep -n "const MAX_ENTIDADES"` → línea 1476). El documento quedó
desactualizado en esa cifra cuando el tope subió a 5. No afecta la decisión.

---

## Medición adicional — ¿la ponderación por matrícula preserva el 100%?

No está en la lista M1–M8, pero es la que decide directamente si la vista es
construible: la agregación que pide —GSE combinado, ponderado por matrícula— es
justamente donde una suma al 100% podría romperse. Se hizo con la fórmula de
ponderación que el proyecto ya usa, extendida a los tres niveles.

```
celdas comuna x anio x nivel x prueba con GSE combinado: 11837 
rango de la suma de los tres niveles: [ 99.9 , 100.1 ]
celdas que se desvian mas de 0.5 de 100: 0 
desviacion absoluta maxima: 0.1 
```

```
=== ejemplo: VIÑA DEL MAR (5109), 4b lect, serie completa ===
  anio n_estab nalu_total pct_ins pct_ele pct_ade N_ins N_ele N_ade suma_N
1 2014     103       3482    28.9    30.0    41.2  1006  1045  1435   3486
2 2015     104       3496    28.9    30.4    40.8  1010  1063  1426   3499
3 2016     106       3505    28.0    28.3    43.7   981   992  1532   3505
4 2017     103       3552    28.7    29.7    41.7  1019  1055  1481   3555
5 2018     103       3724    28.3    25.5    46.2  1054   950  1720   3724
6 2022     101       3525    30.7    27.5    41.8  1082   969  1473   3524
7 2023     100       3418    29.6    28.5    42.0  1012   974  1436   3422
8 2024      98       3386    25.0    27.0    48.0   846   914  1625   3385
9 2025     102       3319    27.1    27.1    45.8   899   899  1520   3318
```

**La agregación funciona:** 11.837 celdas comuna × año × nivel × prueba, todas
sumando 100 ± 0,1, cero desviaciones. La serie de ejemplo es exactamente la que
la vista dibujaría para una comuna, con el hueco 2019-2021 visible.

La columna `suma_N` de este ejemplo se desvía hasta 4 estudiantes de
`nalu_total` **porque la construí desde el porcentaje redondeado a un decimal**,
a propósito, para exhibir el efecto. Es la salvedad de implementación registrada
en M3.

---

## Lo que no se pudo medir, y por qué

- **Nada visual.** No se abre navegador. El patrón de pestañas de M7 se
  transcribió del código fuente; no se vio funcionando, ni en `slep_idps` ni
  aquí.
- **Correspondencia de variables CSS entre proyectos.** No se verificó cuáles de
  `--paper`, `--linea`, `--gris`, `--tinta`, `--azul`, `--coral`, `--fw-bold`,
  `--fs-body-lg` existen en `33_motor_template.html`. Queda como trabajo previo a
  cualquier reutilización del bloque.
- **Si `docs/index.html` de `slep_idps` difiere de su plantilla.** Los `grep`
  encontraron el mismo contenido en ambos, en líneas distintas, pero no se
  compararon los archivos. Irrelevante para el patrón.
- **Semántica de la columna `marca`.** Tiene al menos cuatro valores (`NA`, `1`,
  `2`, y el texto *"Ajenas a la Agencia: Resultados no representativos"*). No se
  investigó qué significan ni si alguno obliga a excluir filas además del umbral
  de matrícula. **Es la laguna más relevante que queda**: podría haber filas con
  `nalu ≥ 10` que igualmente no deban mostrarse.
- **El comportamiento para territorios que no son comuna** (SLEP, región, grupo,
  establecimiento). Todas las mediciones de agregación se hicieron por
  `cod_com_rbd`. La vista dice "UN territorio a la vez" sin precisar el tipo; si
  admite SLEP o región, la agregación es la misma fórmula sobre otro conjunto de
  RBD, pero no se midió.
- **Rendimiento.** No se midió cuánto pesa ni cuánto tarda calcular estas series
  en el cliente. El motor ya embebe los datos por RBD (140.345 filas según el
  generador), así que el insumo está; el costo de la agregación en navegador, no.
- **La cifra "4 entidades" de la decisión de color** no se corrigió: este encargo
  no edita documentos de decisión. Queda anotado que dice 4 y `MAX_ENTIDADES`
  vale 5.

---

## Qué falló o sorprendió

1. **Falló una medición mía, y la corregí.** El primer `summarise` de M5 dio
   `completas = 138947` sobre `filas = 26357`. Causa: vector calculado fuera del
   data frame y reciclado por grupo; R avisó y el aviso era correcto. Rehecho con
   `mutate` dentro del data frame y con dos controles de cuadratura que antes no
   existían.

2. **Sorpresa mayor: la supresión viene como tres ceros, no como NA.** 8.216
   filas con suma exactamente 0, todas con `nalu` entre 0 y 9. Una barra apilada
   al 100% que no las excluya dibujará una barra vacía en vez de un hueco.

3. **Sorpresa mayor: mi propio hallazgo previo sobre `nom_com_rbd` estaba mal.**
   Había afirmado "truncado a 5 caracteres". La longitud máxima es 20, y el
   problema real es peor y triple: truncamiento de longitud variable,
   inconsistencia de mayúsculas, y **nombres de otra comuna** (el código de LA
   REINA etiquetado como LAS CONDES y como PROVIDENCIA; el de SAN CLEMENTE como
   TALCA). 345 de 346 códigos tienen más de una variante. La conclusión operativa
   no cambia —agregar por código— pero la razón es mucho más fuerte de lo que
   creía.

4. **Sorpresa: el identificador `D-color-nivel` no existe en el repositorio.** El
   `grep` que el encargo indica devuelve vacío. La decisión existe y está
   vigente, pero el archivo se llama `20260611_decision_color_por_nivel.md` y no
   contiene ese identificador en ninguna parte. Quien redactó el encargo lo citó
   de memoria.

5. **Sorpresa grata: el motor ya tiene los tres colores y ya apila.** Las tres
   constantes existen desde junio y el subgráfico de barras ya dibuja segmentos
   apilados con ellas. La vista nueva no necesita paleta nueva.

6. **Sorpresa menor: hay un código de comuna huérfano**, 12202 (ANTÁRTICA), en
   `simce_rbd` pero no en el catálogo. Cuatro filas, ninguna con dato completo.
   Inocuo.

7. **El resto salió como se esperaba.** Los tres niveles suman 100, el N se
   reconstruye exacto al entero, la ponderación por matrícula preserva el 100%
   en las 11.837 celdas, y las columnas de desagregación existen con los mismos
   nombres en ambos archivos.

---
---

# Segunda medición — 2026-08-27, cierre de las dos lagunas

**Fecha:** 2026-08-27 (`date "+%Y-%m-%d %H:%M:%S %Z"` → `2026-08-27 12:09:31 -04`)
**Motivo:** cerrar las dos lagunas declaradas en la sección "Lo que no se pudo
medir" de la primera medición: la semántica de la columna `marca`, y la
agregación para territorios que no son comuna. Se añade una tercera cuestión, el
costo en el navegador.
**Naturaleza:** solo lectura. No se editó código, no se regeneró nada.
**Estado de partida:** árbol limpio, `## main...origin/main [ahead 1]`, HEAD en
`2ecad9d`.

> Esta sección **corrige** un dato de la primera medición. Ver N1, apartado
> "Consecuencia sobre lo ya escrito".

---

## N1 — La columna `marca`

### N1a — Valores únicos y presencia en cada archivo

```
=== N1a: aparece marca en ambos archivos? ===
simce_rbd tiene columna marca:     TRUE 
simce_comunal tiene columna marca: FALSE 
columnas de simce_comunal: anio, nivel, prueba, cod_com_rbd, nom_com_rbd, cod_reg_rbd, nom_reg_rbd, cod_grupo, cod_depe2, pct_adecuado, pct_elemental, pct_insuficiente, n_evaluados, n_estab 

=== N1a: valores unicos de marca con frecuencia (simce_rbd) ===
                                                     marca  filas   pct
1                                                     <NA> 173100 93.38
2                                                        1   6151  3.32
3                                                        2   1559  0.84
4                                                        3   1326  0.72
5                                    Alumnos insuficientes   1250  0.67
6                          Ajenas a la Agencia: No reporte   1183  0.64
7       Ajenas a la Agencia: Resultados no representativos    670  0.36
8 Ajenas al Establecimiento: Resultados no representativos     97  0.05
9                                                        4     42  0.02

clase de la columna marca: character 
total filas: 185378 
```

**Solo existe en `simce_rbd.parquet`.** `simce_comunal.parquet` no la tiene, y la
razón se descubre más abajo: ese archivo ya viene filtrado por ella.

**Ocho valores no nulos, en dos codificaciones distintas** que conviven: cuatro
códigos numéricos como texto (`"1"`, `"2"`, `"3"`, `"4"`) y cuatro etiquetas
literales. La columna es `character`.

### Las dos codificaciones se reparten por época

```
=== marca por anio: se mezclan las dos codificaciones? ===
                                                     marca 2014 2015 2016 2017
1                          Ajenas a la Agencia: No reporte 1183    0    0    0
2       Ajenas a la Agencia: Resultados no representativos  306    0  266   98
3                                    Alumnos insuficientes   46    0 1201    3
4                                                        1    0   27    0 1118
5                                                        2    0  115    0   46
6                                                        3    0 1273    0    9
7                                                        4    0   42    0    0
8 Ajenas al Establecimiento: Resultados no representativos    0    0   87   10
  2018 2022 2023 2024 2025
1    0    0    0    0    0
2    0    0    0    0    0
3    0    0    0    0    0
4 1101 1051 1014  940  900
5   27  440  279  265  387
6   10   22   12    0    0
7    0    0    0    0    0
8    0    0    0    0    0
```

Las etiquetas de texto solo aparecen en **2014, 2016 y 2017**; los códigos
numéricos en **2015 y 2017–2025**. **2017 es año de transición y trae ambas.**
No se encontró en el repositorio ningún diccionario que traduzca `"1"`…`"4"` a
las etiquetas, así que **no se puede afirmar cuál código numérico equivale a
"Resultados no representativos"**. Queda declarado como no verificado.

### N1b — Cruce contra `nalu` y dato completo

```
=== N1b: marca x nalu>=10 x dato completo ===
                                                     marca  filas nalu_ge10 dato_completo USABLES
1                                                     <NA> 173100    140345        140345  140345
2                                                        1   6151        17            17      17
3                                                        2   1559      1203          1203    1203
4                                                        3   1326        47            47      47
5                                    Alumnos insuficientes   1250        44            44      44
6                          Ajenas a la Agencia: No reporte   1183         0             0       0
7       Ajenas a la Agencia: Resultados no representativos    670       566           566     566
8 Ajenas al Establecimiento: Resultados no representativos     97        94            94      94
9                                                        4     42        37            37      37

control: suma de USABLES = 142353 | esperado 142353 
```

Dos observaciones:

- **`nalu >= 10` y "dato completo" coinciden fila a fila también dentro de cada
  valor de `marca`** (las columnas `nalu_ge10` y `dato_completo` son idénticas en
  las nueve filas). Refuerza el hallazgo de M4.
- **"Ajenas a la Agencia: No reporte" desaparece por completo** con el umbral:
  0 de 1.183 filas sobreviven. El resto sí sobrevive en parte.

### N1c — Filas que sobreviven al umbral llevando marca

```
=== N1c: de las 142353 filas USABLES, que marca llevan ===
                                                     marca  filas pct_de_usables
1                                                     <NA> 140345         98.589
2                                                        2   1203          0.845
3       Ajenas a la Agencia: Resultados no representativos    566          0.398
4 Ajenas al Establecimiento: Resultados no representativos     94          0.066
5                                                        3     47          0.033
6                                    Alumnos insuficientes     44          0.031
7                                                        4     37          0.026
8                                                        1     17          0.012
```

**2.008 filas** (1,411%) pasan el filtro de umbral llevando marca. De ellas,
**660 dicen literalmente "Resultados no representativos"** (566 + 94).

### N1d — Distribución de esas filas

```
=== N1d: filas USABLES con marca (total 2008 ) por anio ===
  anio filas
1 2014   309
2 2015   136
3 2016   301
4 2017   128
5 2018    27
6 2022   382
7 2023   229
8 2024   195
9 2025   301

=== por dependencia (cod_depe2) ===
  cod_depe2 filas
1         1   565
2         2   770
3         3   157
4         4    20
5         5   496
```

```
=== solo las que dicen literalmente no representativos ===
filas: 660 
  anio                                                    marca filas
1 2014       Ajenas a la Agencia: Resultados no representativos   265
2 2016       Ajenas a la Agencia: Resultados no representativos   217
3 2016 Ajenas al Establecimiento: Resultados no representativos    84
4 2017       Ajenas a la Agencia: Resultados no representativos    84
5 2017 Ajenas al Establecimiento: Resultados no representativos    10

dependencia:
  cod_depe2 filas
1         1   212
2         2   185
3         3    53
4         4     8
5         5   202

nivel x prueba:
  nivel prueba filas
1    2m   lect   275
2    2m   mate   250
3    4b   lect    63
4    4b   mate    72

comunas distintas afectadas: 145 | establecimientos: 384 

nalu de esas filas: min 10 mediana 30 max 267 
```

Las 660 filas "no representativas" **solo existen en 2014, 2016 y 2017**, o sea
en la era de codificación textual. Afectan a 145 comunas y 384 establecimientos,
con matrículas de 10 a 267 estudiantes (mediana 30). Se concentran en 2m (525 de
660). La dependencia 5 (SLEP) aporta 202.

**Esto importa para la vista.** Si alguien excluyera por la etiqueta de texto,
excluiría 2014/2016/2017 y **conservaría** las filas equivalentes de 2018–2025,
que vienen con código numérico. El resultado sería un escalón artificial en la
serie histórica justo en el punto donde cambia la codificación — el peor
artefacto posible en un gráfico cuyo propósito es mostrar evolución temporal.

### ¿Algún script del pipeline filtra por `marca`?

**Sí, en cuatro lugares, y con el mismo criterio.**

`10_utils/10_utils.R`, dentro de `agregar_ponderado()`, líneas 64-69:

```r
  base <- df |>
    dplyr::filter(
      !is.na(nalu),
      nalu >= 10,
      is.na(marca),
      !is.na(palu_eda_ade)
    ) |>
```

con la documentación de la función, líneas 24-27:

```
#'   1. nalu no NA
#'   2. nalu >= 10           (umbral MINEDUC)
#'   3. marca es NA          (sin marca de supresión)
#'   4. palu_eda_ade no NA   (defensivo)
```

y el comentario de la línea 59, decisivo para esta vista:

```
  # (nalu < 10, o marca presente) quedan fuera por igual para los tres niveles.
```

`30_procesamiento/33_generar_html.R` repite el filtro **tres veces**, en las
líneas 166, 187 y 208:

```r
  dplyr::filter(
    !is.na(.data$palu_eda_ade),
    !is.na(.data$nalu), .data$nalu >= 10,
    is.na(.data$marca)
  ) |>
```

`30_procesamiento/32_agregar_comunal.R` líneas 34-37 documenta que
`simce_comunal.parquet` hereda el filtro vía `agregar_ponderado()`:

```
#   2. Aplicados por agregar_ponderado() internamente:
#        - nalu >= 10 (umbral MINEDUC)
#        - marca es NA (sin marca de supresión)
#        - palu_eda_ade no-NA (defensivo)
```

Y el comentario de `33_generar_html.R` líneas 194-200 explica **por qué el filtro
se aplica en R y no en el navegador**:

```
# 8 columnas necesarias para graficar; excluye marca, nom_com_rbd, preliminar
# (recuperables desde otros catálogos). Formato columnar para compacidad.
# Filtro COMPLETO de producción (auditoría A2, s13): generateSeriesByRbd y
# los conteos del motor consumen esta tabla SIN poder reaplicar el umbral
# MINEDUC ni la marca (marca no viaja en el JSON). Si acá entran filas con
# nalu < 10 o marca no-NA, los % de SLEP divergen del resto del motor
# (divergencias de hasta 42.6 pp medidas en la auditoría). La regla del
# invariante 5 se aplica una sola vez, acá, en R.
```

Contraste registrado: `34_historico_pct_adecuado_costa_central.R` línea 19
declara la decisión **contraria**, y de forma deliberada:

```
#   - Filas con 'marca' no vacío (no representativas): SE INCLUYEN.
```

Es un script de exportación histórica a Excel, con metodología propia acordada en
la sesión 26. No alimenta el motor.

### Respuesta explícita a la pregunta final de N1

**El motor actual YA excluye esas filas. No las está mostrando hoy en la vista de
comparación.**

La evidencia es triple y concordante:

1. El filtro `is.na(marca)` se aplica en `10_utils.R:67` y en tres puntos de
   `33_generar_html.R` (166, 187, 208).
2. **`marca` no viaja en el JSON** (`33_generar_html.R:198`, textual). El
   navegador no podría reaplicar el filtro aunque quisiera: la exclusión se
   resuelve una sola vez, en R.
3. La cifra cuadra al entero. El filtro de producción deja **140.345 filas**, que
   es exactamente lo que el generador reporta en su resumen (`simce_rbd: 140345
   filas`):

```
filas crudas: 185378 
filas tras el filtro de PRODUCCION (palu no-NA, nalu>=10, marca NA): 140345 
el generador reporta: 140345 -> coincide? TRUE 
de esas, con los tres niveles presentes y suma != 0: 140345 
filas con palu_eda_ade no-NA pero ele o ins NA: 0 
```

**La vista nueva no necesita decidir nada sobre `marca`**: si se alimenta de
`DATA.simce_rbd` o de `DATA.datos`, la exclusión ya viene hecha. Lo que sí debe
hacer es **no volver a leer el parquet crudo por su cuenta**, porque ahí las
2.008 filas siguen presentes.

### Consecuencia sobre lo ya escrito: corrección a la primera medición

La primera medición definió el universo utilizable como
`!(is.na(suma) | suma == 0) & nalu >= 10`, y contó **142.353 filas**. Ese criterio
**omite `is.na(marca)`** y es por tanto **más permisivo que el de producción en
2.008 filas**.

| Criterio | Filas | Dónde se usó |
|---|---|---|
| Mío en la primera medición (sin `marca`) | 142.353 | M3, M4, M5 y la medición adicional de ponderación |
| De producción (`10_utils.R:67`) | **140.345** | el motor, y el generador lo confirma |

Qué cambia y qué no:

- **M2 no cambia:** las 8.216 filas de suma 0 siguen siendo el hallazgo, y las
  2.008 filas con marca tienen dato completo, así que no alteran el rango de la
  suma.
- **M3 no cambia en su conclusión:** la reconstrucción del N era exacta sobre
  142.353 filas; sobre un subconjunto de 140.345 sigue siéndolo.
- **M4 sí cambia en las cifras:** las columnas `sin_nivel` y `sin_matricula` de la
  tabla por año están calculadas con el criterio permisivo. Con el de producción,
  la supresión es mayor: 45.033 filas fuera en vez de 43.025.
- **M5 sí cambia:** los conteos de `completas` por nivel × prueba están
  sobreestimados en total 2.008 filas.
- **La medición adicional de ponderación se rehace en N2** con el criterio
  correcto, y el resultado se sostiene.

Las tablas de la primera medición **no se reescriben**, por instrucción: quedan
como estaban, con esta nota como corrección.

---

## N2 — Agregación para territorios que no son comuna

Todas las celdas se calcularon sobre el universo de producción de 140.345 filas,
con la fórmula de ponderación del proyecto extendida a los tres niveles y con GSE
**combinado** (agregando sobre `cod_grupo`):

```r
pct_X = sum(nalu * palu_eda_X / 100) / sum(nalu) * 100
```

Universo de cada tipo: comuna por `cod_com_rbd`; región por `cod_reg_rbd` unido
desde `comunas_chile.parquet`; SLEP por `cod_slep` unido desde
`sleps_chile.parquet`; nacional agrupando todo; grupo personalizado como unión
arbitraria de comunas (se midieron dos casos, el mínimo real del proyecto y el
máximo posible); establecimiento por `rbd`.

`celdas_posibles` = territorios × 9 años × 2 niveles × 2 pruebas = territorios × 36.

### Tabla completa (salida literal)

```
=== N2: agregacion por tipo de territorio ===
                             tipo territorios celdas_con_dato celdas_posibles
                           comuna         345           11783           12420
                           region          16             576             576
                             SLEP          36            1296            1296
                         nacional           1              36              36
 grupo (4 comunas, Costa Central)           1              36              36
     grupo (345 comunas = maximo)           1              36              36
                  establecimiento        6729          140345          242244
 celdas_sin_dato pct_sin_dato suma_min suma_max   max_desv fuera_de_rango
             637          5.1   99.900  100.100 0.10000000              0
               0          0.0   99.970  100.027 0.03028790              0
               0          0.0   99.900  100.075 0.10000000              0
               0          0.0   99.998  100.004 0.00405922              0
               0          0.0   99.988  100.021 0.02059770              0
               0          0.0   99.998  100.004 0.00405922              0
          101899         42.1   99.900  100.100 0.10000000              0
```

### N2a — ¿Suman 100 ± 0,1 en todas las celdas?

**Sí, en los siete casos, sin una sola excepción.** La columna `fuera_de_rango`
—celdas con `|suma − 100| > 0,1 + 1e-9`— da **0** para todos los tipos, y la
desviación máxima nunca supera `0.10000000`.

Los tipos agregados quedan **mejor** que los individuales, como cabía esperar: la
región tiene desviación máxima 0,0303 y el nacional 0,0041, porque el redondeo de
±0,05 de cada establecimiento se promedia al ponderar por matrícula.

### N2b — Celdas por tipo y celdas sin dato

| Tipo | Territorios | Celdas con dato | Celdas posibles | Sin dato | % sin dato |
|---|---|---|---|---|---|
| Comuna | 345 | 11.783 | 12.420 | 637 | **5,1%** |
| Región | 16 | 576 | 576 | 0 | **0%** |
| SLEP | 36 | 1.296 | 1.296 | 0 | **0%** |
| Nacional | 1 | 36 | 36 | 0 | **0%** |
| Grupo (4 comunas, Costa Central) | 1 | 36 | 36 | 0 | **0%** |
| Grupo (345 comunas, máximo) | 1 | 36 | 36 | 0 | **0%** |
| Establecimiento | 6.729 | 140.345 | 242.244 | 101.899 | **42,1%** |

**Región, SLEP, nacional y grupo nunca tienen hueco**: los 36 puntos de la serie
existen siempre. Un panorama de esos tipos siempre se dibuja completo.

Las 637 celdas faltantes de comuna se concentran:

```
celdas faltantes: 637 
comunas con al menos una celda faltante: 64 de 345
comunas SIN NINGUNA celda (nunca tienen dato): 7 

faltantes por nivel:
  nivel celdas
1    2m    400
2    4b    237

top 5 comunas con mas celdas faltantes:
  cod_com_rbd celdas      nom_com_rbd nom_reg_rbd
1       12102     36    LAGUNA BLANCA  Magallanes
2       12103     36        RÍO VERDE  Magallanes
3       12104     36     SAN GREGORIO  Magallanes
4       12303     36         TIMAUKEL  Magallanes
5       12402     36 TORRES DEL PAINE  Magallanes
```

**Siete comunas no tienen ni una sola celda con dato** en ningún año, nivel ni
prueba. Las cinco primeras son comunas rurales de Magallanes con muy pocos
establecimientos, todos bajo el umbral. El selector de territorio las ofrecerá
igual, porque se construye desde el catálogo de 345: **la vista necesita un
estado vacío explícito** para ese caso, no una pantalla en blanco.

Nótese también que 2m concentra 400 de las 637 faltantes pese a tener menos
filas: hay comunas sin enseñanza media.

### N2c — El establecimiento individual

```
=== control: una celda de establecimiento es UNA fila? ===
     1 
140345 
```

**Cada celda de establecimiento es exactamente una fila**: las 140.345 celdas
`rbd × año × nivel × prueba` tienen una y solo una fila de GSE. Un RBD pertenece
a un solo grupo socioeconómico por año, así que para este tipo de territorio "GSE
combinado" es una operación vacía. El propio motor ya lo declara, en el
comentario de `generateSeriesByEstab`:

```
// gse aquí es el GSE del establecimiento en el año más reciente — se ignora como filtro
// porque un RBD pertenece a un solo GSE por año; mostramos todos los años disponibles.
```

Sobre la proporción sin dato, la cifra depende del denominador y conviene dar las
dos:

```
=== N2c: establecimiento, denominador realista ===
celdas rbd x anio x nivel x prueba que EXISTEN en el archivo crudo: 185378 
celdas con dato tras el filtro de produccion: 140345 
proporcion sin dato sobre lo que existe: 24.3 %
establecimientos distintos: crudo 9176 | con dato 6729 
```

| Denominador | Sin dato | Lectura |
|---|---|---|
| 6.729 × 36 = 242.244 | 101.899 → **42,1%** | Sobreestima: un liceo que solo imparte 2m nunca tendrá celdas de 4b, y eso no es "falta de dato" |
| Celdas que existen en el archivo crudo: 185.378 | 45.033 → **24,3%** | **Es la cifra honesta**: de las combinaciones que la Agencia sí reporta, una de cada cuatro queda suprimida |

Además, **2.447 establecimientos** (9.176 − 6.729) no tienen ni una sola celda
con dato. Para el tipo "establecimiento" el estado vacío no es un borde: es
frecuente.

---

## N3 — Costo en el navegador

### N3a — Volumen de una tabla larga

```
=== N3a: filas de una tabla larga territorio x anio x nivel x prueba x nivel_de_logro ===
celdas CON DATO   : comuna 11783 + region 576 + SLEP 1296 = 13655 
  x 3 niveles de logro = 40965 filas
celdas POSIBLES   : comuna 12420 + region 576 + SLEP 1296 = 14292 
  x 3 niveles de logro = 42876 filas

comparacion con lo que YA viaja embebido:
  DATA.simce_rbd : 140345 filas x 10 columnas
  DATA.datos     :  44975 filas x 12 columnas
  suma           : 185320 filas
  la tabla larga del panorama seria 22.1 % de ese volumen
```

**40.965 filas** con dato, **42.876** si se materializan también las celdas
vacías. Es el **22,1%** de lo que el motor ya embebe.

Para dimensionar: el JSON plano son 13,6 MB y comprimido 2,1 MB (gzip+base64,
15,4% del plano), y el HTML final pesa 2.582.039 bytes (`ls -la
40_salidas/motor_comparacion.html`). Añadir 40.965 filas de 6 columnas cortas
crecería el payload en el orden de un 10–20%, si hubiera que añadirlas. **No hay
que añadirlas.**

### N3b — ¿Se puede derivar en runtime? Respuesta con evidencia

**Sí. No hace falta precalcular ni embeber absolutamente nada nuevo.**

Evidencia de qué contiene hoy el JSON, tomada de `33_generar_html.R` en el punto
donde serializa.

**Payload por establecimiento** (`simce_rbd_lst`, líneas 219-231), 140.345 filas:

```r
simce_rbd_lst <- list(
  rows       = nrow(df_simce_rbd),
  rbd        = df_simce_rbd$rbd,
  nivel      = df_simce_rbd$nivel,
  prueba     = df_simce_rbd$prueba,
  cod_grupo  = df_simce_rbd$cod_grupo,
  anio       = as.integer(df_simce_rbd$anio),
  nalu       = as.integer(df_simce_rbd$nalu),
  palu       = df_simce_rbd$palu_eda_ade,
  palu_ele   = df_simce_rbd$palu_eda_ele,
  palu_ins   = df_simce_rbd$palu_eda_ins,
  cod_depe2  = df_simce_rbd$cod_depe2
)
```

**Payload comunal** (`datos_lst`, líneas 131-144), 44.975 filas:

```r
datos_lst <- list(
  rows        = nrow(df_ord),
  cod_com     = df_ord$cod_com_rbd,
  nivel       = df_ord$nivel,
  prueba      = df_ord$prueba,
  cod_grupo   = df_ord$cod_grupo,
  cod_depe2   = df_ord$cod_depe2,
  anio        = as.integer(df_ord$anio),
  pct         = round(df_ord$pct_adecuado, 2),
  pct_ele     = round(df_ord$pct_elemental, 2),
  pct_ins     = round(df_ord$pct_insuficiente, 2),
  n_evaluados = as.integer(df_ord$n_evaluados),
  n_estab     = as.integer(df_ord$n_estab)
)
```

**Los dos payloads ya llevan los tres niveles y la matrícula**: `palu`,
`palu_ele`, `palu_ins`, `nalu` en uno; `pct`, `pct_ele`, `pct_ins`,
`n_evaluados`, `n_estab` en el otro. Y los dos vienen ya filtrados por el
criterio de producción.

Más aún: **la capa de series del motor ya devuelve los tres niveles**. La firma de
`mkPunto` (línea 1197):

```js
return { year, pct, pct_ele: pe, pct_ins: pi, n_eval: acc.den, n_estab: acc.n_estab, preliminar };
```

y `getSeriesForEntity` (1369-1380) enruta los cinco tipos de territorio a cuatro
generadores especializados, todos devolviendo esa misma forma:

```js
      function getSeriesForEntity(entity, gse, nivel, prueba) {
        if (entity.kind === "slep") {
          return generateSeriesByRbd({ rbds: entity.rbds, gse, nivel, prueba });
        }
        if (entity.kind === "estab") {
          return generateSeriesByEstab({ rbd: entity.rbd, gse, nivel, prueba });
        }
        if (entity.kind === "nacional") {
          return generateSeriesByNacional({ gse, nivel, prueba, depe2: entity.depe2 });
        }
        return generateSeriesByDepe({ comunas: entity.comunas, depe2: entity.depe2, gse, nivel, prueba });
      }
```

**Hallazgo que ahorra trabajo:** `mkPunto` ya resuelve el ±0,1 de redondeo que
esta medición documentó. Su comentario, líneas 1180-1184:

```
      // Construye un punto de serie desde un acumulador {num,num_ele,num_ins,den,n_estab}.
      // Normaliza los tres niveles a 100 para el apilado: Adecuado se conserva
      // exacto (no cambia respecto al modo solo-Adecuado); Elem e Insuf se ajustan
      // proporcionalmente para absorber el ±0.1 de redondeo de la fuente, de modo
      // que ningún gráfico apilado sume 99.9 ni 100.1.
```

Una barra apilada construida sobre esa serie suma **exactamente 100**, sin que la
vista tenga que renormalizar.

**Lo único que falta es una ruta de código, no un dato.** Los cuatro generadores
exigen un GSE válido y devuelven una serie de nulos si no lo reciben. Por ejemplo
`generateSeriesByDepe`, línea 1246:

```js
        const cg = GSE_LABEL_TO_COD[gse];
        const nv = NIVEL_LABEL_TO_COD[nivel];
        const pr = PRUEBA_LABEL_TO_COD[prueba];
        if (!cg || !nv || !pr) return YEARS.map(y => ({ year: y, pct: null, n_eval: null, n_estab: null, preliminar: PRELIMINAR_YEARS.includes(y) }));
```

Pasar `gse` nulo **no** devuelve la serie combinada: devuelve nulos. El GSE
combinado hay que construirlo iterando los cinco códigos y acumulando en el mismo
`{num, num_ele, num_ins, den, n_estab}` antes de llamar a `mkPunto` — que es
precisamente lo que ya hace el bucle interno de cada generador, extendido a un
nivel más. Es reutilización, no invención.

**Conclusión de N3b:** cero datos nuevos que precalcular, cero datos nuevos que
embeber, cero crecimiento del payload. Una función de agregación de GSE que
reutiliza `indicesPCG` y `mkPunto`.

---

## Lo que no se pudo medir en esta segunda vuelta, y por qué

- **El significado de los códigos numéricos de `marca`.** No hay diccionario en el
  repositorio. No se puede afirmar que `"2"` sea el equivalente numérico de
  "Resultados no representativos", ni descartarlo. **No afecta a la vista**,
  porque el pipeline excluye toda marca no nula sea cual sea, pero sí impide
  responder qué proporción de las exclusiones corresponde a cada causa.
- **Nada visual.** No se abre navegador. El patrón de pestañas, el apilado y el
  estado vacío siguen sin verse funcionando.
- **El costo real en el navegador.** N3 estimó volúmenes de datos, no tiempos. No
  se midió cuánto tarda `getSeriesForEntity` ni cuánto tardaría el bucle de GSE
  combinado sobre 140.345 filas. Estimar eso sin ejecutar sería inventar.
- **El comportamiento del grupo personalizado con comunas de regiones distintas.**
  Se midieron dos casos (4 comunas contiguas y las 345), ambos correctos, pero no
  se exploró si algún subconjunto intermedio produce algo distinto. La fórmula es
  la misma, así que no hay motivo para esperarlo.
- **La cifra de M4/M5 no se recalculó con el filtro de producción.** Se declaró la
  corrección y la diferencia (2.008 filas), pero no se rehicieron las tablas por
  año ni por nivel × prueba, porque la instrucción prohíbe reescribir lo ya
  escrito y el dato corregido no cambia ninguna conclusión de diseño.

---

## Qué falló o sorprendió en esta segunda medición

1. **Sorpresa mayor, y corrige mi propio trabajo: el motor YA excluye las filas
   con `marca`.** La laguna que declaré en la primera medición —"podría haber
   filas con `nalu ≥ 10` que igualmente no deban mostrarse"— era real como
   pregunta, pero la respuesta es que el pipeline la resolvió hace tiempo, en la
   auditoría A2 de la sesión 13, con una divergencia medida entonces de hasta
   42,6 pp. Mi universo de 142.353 filas era **más permisivo que el de producción
   en 2.008 filas**. La cifra correcta es 140.345, y cuadra al entero con lo que
   reporta el generador.

2. **Sorpresa: `marca` tiene dos codificaciones que se reparten por época.**
   Etiquetas de texto en 2014/2016/2017, códigos numéricos en 2015 y 2018-2025,
   con 2017 mezclando ambas. Excluir por la etiqueta de texto produciría un
   escalón artificial en la serie histórica exactamente donde cambia la
   codificación. El pipeline lo evita porque excluye **toda** marca no nula, sin
   interpretarla.

3. **Falló un umbral mío por coma flotante.** La primera versión de la tabla de N2
   reportó 109 celdas de comuna y 10.892 de establecimiento "fuera de rango" con
   un `> 0.1` estricto. Medido el exceso: entre **8,5e-15 y 2,3e-14** sobre 0,1,
   con desviación máxima real `0.10000000000002273737`. Es ruido de suma en punto
   flotante, no un dato fuera de rango. Con tolerancia `> 0.1 + 1e-9` el conteo es
   0 en los siete tipos. Registro además que mi primer control fue insuficiente:
   probé `abs(99.9-100)` y `abs(100.1-100)`, que en `double` caen *por debajo* de
   0,1, y por eso no reprodujeron el fenómeno; el exceso venía de sumas ponderadas
   de muchas filas, no de esos dos literales.

4. **Sorpresa grata: `mkPunto` ya normaliza los tres niveles a exactamente 100.**
   El problema del ±0,1 que documenté en M2 como algo a resolver en la vista está
   resuelto en el cliente desde antes, y con un criterio explícito: Adecuado se
   conserva exacto y Elemental/Insuficiente absorben el ajuste.

5. **Sorpresa: región, SLEP, nacional y grupo no tienen ni un hueco.** Los 36
   puntos de la serie existen siempre para los cuatro tipos agregados. El hueco es
   un problema de comuna (5,1%) y sobre todo de establecimiento (24,3% sobre lo
   que existe).

6. **Sorpresa: siete comunas no tienen ni una sola celda con dato**, y 2.447
   establecimientos tampoco. El selector los ofrecerá igual porque se construye
   desde el catálogo. La vista necesita un estado vacío explícito.

7. **Sorpresa menor: una celda de establecimiento es siempre una sola fila.** Las
   140.345 celdas tienen exactamente un GSE. Para ese tipo, "GSE combinado" no
   hace nada, y el motor ya lo tenía documentado.
