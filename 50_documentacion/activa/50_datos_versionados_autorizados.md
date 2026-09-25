# Datos versionados autorizados

**Invariante:** I8 de la compuerta de repositorio, `SETTINGS_Y_PROMPTS_OPERACIONALES.md` v34 §2.1.
**Fecha de la enumeración:** 2026-08-27, sesión 28.
**Log de la medición:** el reporte de enumeración de esta sesión, recogido en el traspaso v28.
**Corrección:** 2026-09-25, sesión 35 (Q-36; hallazgos R-54 y R-55 del log de s35b): alcance real de los
globs en el verificador y líneas vigentes de `.gitignore`.

`slep_simce_adecuado` es un proyecto **100% público**: sus insumos son
publicaciones de la Agencia de Calidad de la Educación y catálogos oficiales del
MINEDUC, todos a nivel de establecimiento. `POLITICA_PROYECTO.md` §6.2 lo
contempla de forma expresa: los proyectos 100% públicos usan raíz unificada, con
`20_insumos/` y `40_salidas/` dentro del repositorio y versionados si el tamaño
lo permite.

Este archivo declara esa práctica. No la introduce.

---

## Entradas

```
20_insumos/auxiliares/*.xlsx    # catalogos y glosas publicas: anexo de indicadores, caracterizacion de establecimientos, diccionario de territorios, consolidado de glosas SIMCE y listado de SLEP 2026; granularidad de establecimiento, sin persona natural
20_insumos/auxiliares/*.csv     # metadatos del propio SIMCE: resumen de cambios y tabla comparativa de variables 2014-2025; describen columnas, no personas; y el catalogo publico de comunas por Servicio Local y anio de traspaso (dim_slep_comunas.csv, copia de slep_central_datos); territorio e institucion, sin persona natural
20_insumos/simce/2m/*.xlsx      # resultados SIMCE de II medio por RBD publicados por la Agencia, 2014-2018 y 2022-2025; nivel establecimiento
20_insumos/simce/4b/*.xlsx      # resultados SIMCE de 4o basico por RBD publicados por la Agencia, 2014-2018 y 2022-2025; nivel establecimiento
40_salidas/*.xlsx               # historico ponderado de % Adecuado de Costa Central; agregados por anio, sin desagregacion siquiera a comuna
renv/settings.json              # configuracion del gestor de dependencias; sin datos del proyecto
50_documentacion/andamios/20260911_filas_anomalas_simce_rbd.xlsx   # diagnostico de filas anomalas de simce_rbd.parquet (sesion 30); hojas Resumen, Sin nalu y Nalu cero; nivel establecimiento, sin persona natural
40_salidas/publico/contexto_simce.parquet   # contrato de contexto v1 (paso 35), solo en la rama feat/contrato-contexto (31befa2); 61.853 filas de senales por RBD, anio y eje; nivel establecimiento, sin persona natural
```

Al 2026-09-25 (sesión 35) estas ocho entradas cubren 28 rutas versionadas con
extensión de datos tabulares (25 `.xlsx` y 3 `.csv`) y, aparte,
`renv/settings.json` (1 `.json`): 29 rutas con el comando de abajo.

Verificación de la cobertura, reproducible:

```bash
git ls-files | grep -Ei '\.(xlsx|xls|xlsm|xlsb|csv|tsv|parquet|rds|rdata|sav|dta|db|sqlite|sqlite3|json|geojson)$' | sort
```

---

## Qué se revisó antes de autorizar

Cada una de las 28 rutas, más `renv/settings.json`, se inspeccionó, no se autorizó por su carpeta:

| Grupo | Qué se miró | Resultado |
|---|---|---|
| 2 `.csv` de `auxiliares/` | Cabeceras completas | Metadatos de variables SIMCE; ninguna columna de persona |
| 5 `.xlsx` de `auxiliares/` | Nombres de columna de la primera hoja | Institución y territorio. `Nombre.del.establecimiento` es un establecimiento, no una persona |
| 18 `.xlsx` de SIMCE crudo | Esquema completo de cada año | Siempre a nivel RBD: `rbd`, `dvrbd`, `nom_rbd`, códigos geográficos, `cod_depe1/2`, `cod_grupo`, `nalu_*`, `prom_*`, `palu_eda_*`, `marca_*`. Ni RUT, ni MRUN, ni nombre de estudiante o de sostenedor en ninguno |
| Hojas adicionales | 16 hojas `Hoja2`/`Hoja3` en 7 de los 18 archivos | Vacías o ilegibles. Se revisaron porque el archivo se versiona entero, aunque el pipeline lea solo la primera hoja |
| 1 `.xlsx` de `40_salidas/` | Las 4 hojas | `anio`, `n_rbds`, `n_estudiantes_evaluados`, `n_estudiantes_adecuado`, `pct_adecuado`; agregados por año |
| `renv/settings.json` | Contenido completo | Ajustes de `renv`: `bioconductor.version`, `external.libraries`, `snapshot.type`, reglas `vcs.ignore` |
| `andamios/20260911_filas_anomalas_simce_rbd.xlsx` (2026-09-23, sesión 31) | Las 3 hojas | `Resumen`: texto y conteos por situación. `Sin nalu` y `Nalu cero`: `Año`, `Nivel`, `Prueba`, `RBD`, `Nombre del establecimiento`, `Código comuna`, `Comuna`, `Dependencia`, `GSE`, `Evaluados`, tres porcentajes de nivel y `Puntaje promedio`. Ni RUT, ni MRUN, ni nombre de persona |
| `40_salidas/publico/contexto_simce.parquet` (2026-09-23, sesión 32) | Las 15 columnas, leídas del blob de `31befa2` | `rbd`, `anio`, `eje`, `eje_etiqueta`, `segmento`, `escala`, `valor`, `desvio_gse`, `mejora_sobre_gse`, `mejora_ano_ano`, `cod_grupo`, `proyecto_origen`, `periodo`, `fecha_calculo`, `version_contrato`. Ni RUT, ni MRUN, ni nombre de persona. Solo existe en la rama `feat/contrato-contexto`; la entrada va en `main` porque el verificador lee la lista del árbol de trabajo desde el que se publica |
| `auxiliares/dim_slep_comunas.csv` (2026-09-25, sesión 35; copia de `slep_central_datos`, commit de origen `d7a8ec6`; cae bajo `20_insumos/auxiliares/*.csv`) | Las 15 columnas y los textos libres de `decreto` y `precisiones` | `cod_comuna`, `comuna`, `cod_slep`, `slep`, `slep_formato`, `region`, `num_region`, `deprov`, `cod_deprov`, `anio_inicio_funciones`, `anio_traspaso`, `decreto`, `comuna_cabecera`, `referencial`, `precisiones`. Catálogo público de territorio e institución, sin persona natural; `precisiones` anota decretos, postergaciones y fechas de inicio, sin nombres de persona. Ni RUT, ni MRUN |

---

## Lo que esta lista NO autoriza

**No relaja la gobernanza.** Declara que la *extensión* de estos archivos no es
motivo de alarma, no que su contenido quede exento de revisión. La revisión de la
tabla anterior es lo que funda la autorización; el glob solo la expresa.

**No autoriza a `directorio_oficial_ee.csv`, aunque el verificador lo alcanzaría.**
Ese archivo contiene `MRUN` y columnas de persona natural, y su exclusión tiene
decisión propia documentada bajo la Ley 21.719
(`50_documentacion/activa/decisiones/20260622_decision_cumplimiento_ley_21719.md`).
La entrada `20_insumos/auxiliares/*.csv` **sí** lo alcanza en el verificador I8
(`glob2rx()` la convierte en `^20_insumos/auxiliares/.*\.csv$`): si se versionara,
I8 no lo marcaría. El archivo se mantiene fuera del repositorio **solo** porque lo
ignora `.gitignore` (línea 44). Esa línea no debe quitarse ni relajarse, y
ninguna revisión de la tabla anterior lo cubre.

**No cubre los `.parquet` de `40_salidas/intermedios/`.** No están versionados
(`.gitignore`, línea 10) y por eso no le conciernen a I8. Si alguna vez se
versionaran, exigen su propia revisión y su propia entrada: `simce_rbd.parquet`
tiene 185.378 filas a nivel de establecimiento.

**No autoriza subcarpetas, aunque el verificador las alcanzaría.** `glob2rx()` ancla
en ambos extremos, pero convierte `*` en `.*`, que sí cruza `/`:
`20_insumos/auxiliares/*.xlsx` alcanza a `20_insumos/auxiliares/algo/x.xlsx` en el
verificador. Cada nivel se enumera por separado para describir lo revisado; un
archivo nuevo en una subcarpeta pasaría I8 sin revisión, así que se inspecciona
igual, como pide la sección siguiente.

---

## Cómo se amplía

Una entrada nueva exige, en este orden:

1. Inspeccionar el contenido real del archivo, no su nombre ni su carpeta: para
   tabulares, los nombres de columna de **todas** las hojas; para el resto, el
   contenido completo.
2. Comprobar que no hay columnas de persona natural (RUT, MRUN, nombres de
   estudiantes, apoderados o sostenedores).
3. Agregar la línea al bloque cercado con su justificación tras el `#`, en la
   misma línea.
4. Registrar la ampliación en el traspaso de la sesión que la hace.

**Ampliar un glob existente para que cubra rutas que no se miraron es la forma en
que una lista de autorización deja de medir.** Si un archivo nuevo cae bajo un
glob ya declarado, igual se inspecciona: el glob describe lo revisado, no
autoriza por anticipado.

---

## Nota sobre el parser

El verificador lee **solo el primer bloque cercado** del archivo, una entrada por
línea, descartando todo lo que sigue a un `#`. Un archivo presente pero sin dos
cercas produce una lista vacía y falla igual que un archivo ausente, con otro
mensaje. Al editar, conservar el bloque cercado de la sección **Entradas** como
el primero del documento.
