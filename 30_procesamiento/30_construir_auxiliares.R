# 30_construir_auxiliares.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Construye los parquets auxiliares del proyecto a partir de los insumos
# en 20_insumos/auxiliares/. Salidas en 40_salidas/intermedios/:
#
#   1. slep_cc_establecimientos.parquet
#        Desde caracterizacion_establecimientos.xlsx + flag rinde_simce
#        derivado de anexo_indicadores_simce.xlsx (hoja 00_RBDs_no_SIMCE).
#
#   2. comunas_chile.parquet
#        Desde directorio_oficial_ee.csv (filtrado por establecimientos
#        operativos con matrícula).
#
#   3. sleps_chile.parquet
#        Desde 202602_Listado_SLEP_2026_vf.xlsx + directorio oficial.
#
# Uso:
#   source(here::here("30_procesamiento", "30_construir_auxiliares.R"))
#
# Convención: paquetes prefijados (readxl::, readr::, dplyr::, arrow::).
# Solo library(here) por uso intensivo de rutas.
# ----------------------------------------------------------------------------

library(here)

# ----------------------------------------------------------------------------
# Constantes de configuración
# ----------------------------------------------------------------------------
# Último año con datos SIMCE en el proyecto. El directorio oficial de
# establecimientos tiene corte al 30 de abril de este año, por lo que los SLEP
# con AGNO_TRASPASO_EDUC <= ANIO_DATOS_VIGENTE ya figuran con COD_DEPE == 6
# (Servicio Local) en el directorio. Los SLEP cuyo traspaso es el año siguiente
# (ANIO_DATOS_VIGENTE + 1) administran desde ya sus establecimientos, pero en el
# directorio aún aparecen como municipales (COD_DEPE 1/2): se incluyen vía la
# rama prospectiva de la sección 4.2 y se marcan en el motor.
ANIO_DATOS_VIGENTE <- 2025L


# ============================================================================
# Bloque 0 — RBDs que no rinden SIMCE
# ============================================================================

message("[0] Cargando lista de RBDs no-SIMCE...")

rbds_no_simce_df <- readxl::read_excel(
  here::here("20_insumos", "auxiliares", "anexo_indicadores_simce.xlsx"),
  sheet = "00_RBDs_no_SIMCE"
)

rbds_no_simce <- as.character(rbds_no_simce_df$rbd)

# Validación: los 5 RBDs esperados deben estar presentes.
rbds_esperados <- c("1666", "1668", "1669", "1710", "14829")
stopifnot(
  "Lista de RBDs no-SIMCE difiere de la esperada (1666, 1668, 1669, 1710, 14829)" =
    setequal(rbds_no_simce, rbds_esperados)
)

message(sprintf(
  "    OK: %d RBDs no-SIMCE cargados (%s).",
  length(rbds_no_simce),
  paste(sort(rbds_no_simce), collapse = ", ")
))


# ============================================================================
# Bloque 1 — slep_cc_establecimientos.parquet
# ============================================================================

message("[1] Construyendo slep_cc_establecimientos.parquet...")

df_estab_raw <- readxl::read_excel(
  here::here("20_insumos", "auxiliares", "caracterizacion_establecimientos.xlsx")
)

# El xlsx tiene una columna con ñ ("Niveles de enseñanza") que rompe la
# comparación textual cuando el locale del proceso no es UTF-8. Para no
# depender del locale, validamos solo las columnas con nombres ASCII puros
# y renombramos TODAS las columnas por POSICIÓN.
stopifnot(
  "El xlsx debería tener 8 columnas" = ncol(df_estab_raw) == 8L,
  "Pos 1 debe ser 'RBD'"                          = names(df_estab_raw)[1] == "RBD",
  "Pos 2 debe ser 'DV'"                           = names(df_estab_raw)[2] == "DV",
  "Pos 3 debe ser 'Nombre del establecimiento'"   =
    names(df_estab_raw)[3] == "Nombre del establecimiento",
  "Pos 5 debe ser 'Comuna'"                       = names(df_estab_raw)[5] == "Comuna",
  "Pos 6 debe ser 'Macrozona'"                    = names(df_estab_raw)[6] == "Macrozona",
  "Pos 7 debe ser 'Emplazamiento'"                = names(df_estab_raw)[7] == "Emplazamiento",
  "Pos 8 debe ser 'Grupo prioritario IVE 2026'"   =
    names(df_estab_raw)[8] == "Grupo prioritario IVE 2026"
)

# Renombrar todas las columnas por posición (snake_case).
names(df_estab_raw) <- c(
  "rbd", "dv", "nom_rbd", "niveles_ensenanza",
  "comuna", "macrozona", "emplazamiento", "ive_2026"
)

# Coerciones e indicadores.
df_estab <- df_estab_raw |>
  dplyr::mutate(
    rbd      = as.character(rbd),
    ive_2026 = dplyr::if_else(
      ive_2026 == "No aplica",
      NA_real_,
      suppressWarnings(as.numeric(ive_2026))
    ),
    rinde_simce = !(rbd %in% rbds_no_simce)
  ) |>
  dplyr::select(
    rbd, nom_rbd, comuna, macrozona, emplazamiento,
    ive_2026, niveles_ensenanza, rinde_simce
  )

# Escritura.
ruta_estab <- here::here(
  "40_salidas", "intermedios", "slep_cc_establecimientos.parquet"
)
arrow::write_parquet(df_estab, ruta_estab)

message(sprintf(
  "    OK: %d establecimientos (%d con rinde_simce=FALSE).",
  nrow(df_estab),
  sum(!df_estab$rinde_simce)
))


# ============================================================================
# Bloque 2 — Carga del directorio oficial (CSV grande)
# ============================================================================

message("[2] Leyendo directorio_oficial_ee.csv...")

ruta_directorio <- here::here(
  "20_insumos", "auxiliares", "directorio_oficial_ee.csv"
)

# Separador `;`, decimal `,`, encoding UTF-8 (readr maneja BOM auto).
df_dir_raw <- readr::read_delim(
  ruta_directorio,
  delim = ";",
  locale = readr::locale(encoding = "UTF-8", decimal_mark = ","),
  show_col_types = FALSE,
  progress = FALSE
)

# Los nombres del CSV son ASCII puros (sin tildes ni ñ) — no requieren
# normalización de encoding.

# Validación de columnas requeridas para los parquets aguas abajo.
cols_csv_esperadas <- c(
  "AGNO", "RBD", "NOM_RBD",
  "COD_COM_RBD", "NOM_COM_RBD",
  "COD_REG_RBD", "NOM_REG_RBD_A",
  "COD_DEPE2",
  "MATRICULA", "ESTADO_ESTAB"
)
faltan_csv <- setdiff(cols_csv_esperadas, names(df_dir_raw))
stopifnot(
  "Faltan columnas en directorio_oficial_ee.csv" = length(faltan_csv) == 0
)

message(sprintf(
  "    OK: %d filas leídas. Año(s) en AGNO: %s.",
  nrow(df_dir_raw),
  paste(sort(unique(df_dir_raw$AGNO)), collapse = ", ")
))


# ============================================================================
# Bloque 3 — comunas_chile.parquet
# ============================================================================

message("[3] Construyendo comunas_chile.parquet...")

# Tabla de nombres oficiales de región (fuente: abreviaturas del CSV MINEDUC)
nombres_region <- c(
  "1"  = "Tarapacá",
  "2"  = "Antofagasta",
  "3"  = "Atacama",
  "4"  = "Coquimbo",
  "5"  = "Valparaíso",
  "6"  = "O'Higgins",
  "7"  = "Maule",
  "8"  = "Biobío",
  "9"  = "La Araucanía",
  "10" = "Los Lagos",
  "11" = "Aysén",
  "12" = "Magallanes",
  "13" = "Metropolitana",
  "14" = "Los Ríos",
  "15" = "Arica y Parinacota",
  "16" = "Ñuble"
)

df_comunas <- df_dir_raw |>
  dplyr::filter(.data$ESTADO_ESTAB == 1, .data$MATRICULA == 1) |>
  dplyr::transmute(
    cod_com_rbd = as.character(COD_COM_RBD),
    nom_com_rbd = NOM_COM_RBD,
    cod_reg_rbd = as.character(COD_REG_RBD),
    nom_reg_rbd = dplyr::recode(
      as.character(COD_REG_RBD),
      !!!nombres_region,
      .default = NOM_REG_RBD_A
    )
  ) |>
  dplyr::distinct()

ruta_comunas <- here::here(
  "40_salidas", "intermedios", "comunas_chile.parquet"
)
arrow::write_parquet(df_comunas, ruta_comunas)

message(sprintf(
  "    OK: %d comunas únicas.",
  nrow(df_comunas)
))


# ============================================================================
# Bloque 4 — sleps_chile.parquet
# ============================================================================
# Fuente: 202602_Listado_SLEP_2026_vf.xlsx (hoja "Listado SLEP"), provisto
# por el titular. Contiene una fila por SLEP x comuna, con COD_COM_RBD ya
# disponible. Se joineara con el directorio oficial para obtener los RBDs
# que pertenecen a cada SLEP.
#
# Esquema del parquet resultante (8 columnas):
#   cod_slep      character   codigo numerico del SLEP (ej. "503")
#   nombre_slep   character   nombre formateado (ej. "Costa Central")
#   anio_traspaso integer     anio en que el SLEP tomo cargo de la educacion
#   cod_com_rbd   character   codigo de comuna
#   nom_com_rbd   character   nombre de la comuna
#   rbd           character   RBD del establecimiento
#   nom_rbd       character   nombre del establecimiento
# (7 columnas: sin cod_depe — parquet contiene solo establecimientos SLEP)
#
# Solo RBDs con COD_DEPE == 6 en directorio 2025. El join con SIMCE por RBD
# garantiza cobertura historica: los mismos establecimientos existian con
# COD_DEPE == 1 antes del traspaso.

message("[4] Construyendo sleps_chile.parquet...")

# ---- 4.1 Leer hoja Listado SLEP ----
ruta_sleps <- here::here(
  "20_insumos", "auxiliares", "202602_Listado_SLEP_2026_vf.xlsx"
)

df_sleps_raw <- readxl::read_excel(
  ruta_sleps,
  sheet = "Listado SLEP",
  col_types = "text"
)

cols_slep_req <- c(
  "COD_SLEP", "NOMBRE_SLEP_FORMATO", "AGNO_TRASPASO_EDUC", "COD_COM_RBD"
)
faltan_slep <- setdiff(cols_slep_req, names(df_sleps_raw))
stopifnot(
  "Faltan columnas en 202602_Listado_SLEP_2026_vf.xlsx" =
    length(faltan_slep) == 0
)

df_slep_comunas <- df_sleps_raw |>
  dplyr::transmute(
    cod_slep      = as.character(COD_SLEP),
    nombre_slep   = NOMBRE_SLEP_FORMATO,
    anio_traspaso = suppressWarnings(as.integer(AGNO_TRASPASO_EDUC)),
    cod_com_rbd   = as.character(COD_COM_RBD)
  ) |>
  dplyr::distinct()

message(sprintf(
  "    Listado SLEP leido: %d SLEPs, %d combinaciones SLEP x comuna.",
  dplyr::n_distinct(df_slep_comunas$cod_slep),
  nrow(df_slep_comunas)
))

# ---- 4.2 Join con directorio para obtener RBDs ----
# Usar df_dir_raw ya cargado en bloque 2.
#
# Dos ramas según el año de traspaso de cada SLEP:
#
# (a) SLEP ya traspasados (anio_traspaso <= ANIO_DATOS_VIGENTE): sus
#     establecimientos figuran con COD_DEPE == 6 (Servicio Local) en el
#     directorio. El join con SIMCE por RBD garantiza la cobertura histórica
#     previa al traspaso (esos RBDs existían con COD_DEPE 1/2 antes y son los
#     mismos establecimientos).
#
# (b) SLEP con traspaso prospectivo (anio_traspaso == ANIO_DATOS_VIGENTE + 1):
#     administran sus establecimientos desde este año, pero en el directorio
#     (corte 30-abr del año vigente) aún aparecen como municipales
#     (COD_DEPE 1 = Corp. Municipal, 2 = DAEM). Se incluyen esos RBDs para que
#     el SLEP pueda hacer diagnóstico sobre los establecimientos que ya
#     administra. El motor los marca: sus resultados corresponden íntegramente
#     a la administración municipal previa al traspaso.
#
# SLEP con anio_traspaso > ANIO_DATOS_VIGENTE + 1 NO se incluyen: su traspaso
# es demasiado futuro para considerar los establecimientos como propios.

# Comunas según rama, derivadas del listado SLEP.
comunas_traspasadas <- df_slep_comunas |>
  dplyr::filter(.data$anio_traspaso <= ANIO_DATOS_VIGENTE) |>
  dplyr::pull(cod_com_rbd) |>
  unique()

comunas_prospectivas <- df_slep_comunas |>
  dplyr::filter(.data$anio_traspaso == ANIO_DATOS_VIGENTE + 1L) |>
  dplyr::pull(cod_com_rbd) |>
  unique()

# RBDs públicos: depe 6 en comunas ya traspasadas, o depe 1/2 (municipal) en
# comunas con traspaso prospectivo. Un mismo RBD se asigna por su comuna.
df_dir_slep <- df_dir_raw |>
  dplyr::filter(
    .data$ESTADO_ESTAB == 1,
    .data$MATRICULA == 1
  ) |>
  dplyr::mutate(cod_com_rbd = as.character(COD_COM_RBD)) |>
  dplyr::filter(
    (.data$COD_DEPE == 6 & .data$cod_com_rbd %in% comunas_traspasadas) |
      (.data$COD_DEPE %in% c(1, 2) & .data$cod_com_rbd %in% comunas_prospectivas)
  ) |>
  dplyr::transmute(
    cod_com_rbd = cod_com_rbd,
    rbd         = as.character(RBD),
    nom_rbd     = NOM_RBD
  )

# Expandir SLEP x comuna a SLEP x RBD mediante inner_join.
# Solo se conservan las combinaciones SLEP x comuna de las dos ramas; el
# inner_join descarta automáticamente los SLEP con traspaso demasiado futuro,
# porque sus comunas no tienen RBDs en df_dir_slep.
df_sleps <- dplyr::inner_join(
  df_slep_comunas,
  df_dir_slep,
  by = "cod_com_rbd"
) |>
  dplyr::left_join(
    dplyr::select(df_comunas, cod_com_rbd, nom_com_rbd),
    by = "cod_com_rbd"
  ) |>
  dplyr::select(
    cod_slep, nombre_slep, anio_traspaso,
    cod_com_rbd, nom_com_rbd,
    rbd, nom_rbd
  ) |>
  dplyr::arrange(cod_slep, cod_com_rbd, rbd)

if (nrow(df_sleps) == 0) {
  stop("Join SLEP x directorio devolvio 0 filas. Verificar cod_com_rbd.")
}

n_prospectivos <- dplyr::n_distinct(
  df_sleps$cod_slep[df_sleps$anio_traspaso == ANIO_DATOS_VIGENTE + 1L]
)

message(sprintf(
  "    OK: %d SLEPs - %d comunas - %d establecimientos.",
  dplyr::n_distinct(df_sleps$cod_slep),
  dplyr::n_distinct(df_sleps$cod_com_rbd),
  dplyr::n_distinct(df_sleps$rbd)
))
message(sprintf(
  "    Incluye %d SLEP(s) con traspaso prospectivo %d (RBDs municipales).",
  n_prospectivos, ANIO_DATOS_VIGENTE + 1L
))

# Sanity check Costa Central
cc_check <- df_sleps |>
  dplyr::filter(nombre_slep == "Costa Central") |>
  dplyr::distinct(nom_com_rbd)
message(sprintf(
  "    Costa Central: %d comunas (%s).",
  nrow(cc_check),
  paste(cc_check$nom_com_rbd, collapse = ", ")
))

# ---- 4.3 Escritura ----
ruta_sleps_out <- here::here(
  "40_salidas", "intermedios", "sleps_chile.parquet"
)
arrow::write_parquet(df_sleps, ruta_sleps_out)

message(sprintf(
  "    OK: %d filas escritas en %s.",
  nrow(df_sleps),
  fs::path_rel(ruta_sleps_out, here::here())
))


# ============================================================================
# Bloque 5 — establecimientos_chile.parquet
# ============================================================================
# Catálogo completo de establecimientos con nombre, comuna y dependencia.
# Fuente: directorio_oficial_ee.csv (df_dir_raw, ya cargado en Bloque 2).
# Incluye todos los establecimientos operativos con matrícula,
# independientemente de su dependencia. Se usa en el popup "ver
# establecimientos" del motor de comparación HTML para cualquier entidad.
#
# Esquema (5 columnas):
#   rbd           character   RBD del establecimiento
#   nom_rbd       character   nombre del establecimiento
#   cod_com_rbd   character   código de comuna
#   nom_com_rbd   character   nombre de la comuna
#   cod_depe2     character   dependencia agrupada (1–5)

message("[5] Construyendo establecimientos_chile.parquet...")

df_establecimientos <- df_dir_raw |>
  dplyr::filter(.data$ESTADO_ESTAB == 1, .data$MATRICULA == 1) |>
  dplyr::transmute(
    rbd         = as.character(RBD),
    nom_rbd     = NOM_RBD,
    cod_com_rbd = as.character(COD_COM_RBD),
    nom_com_rbd = NOM_COM_RBD,
    cod_depe2   = as.character(COD_DEPE2)
  ) |>
  dplyr::distinct() |>
  dplyr::arrange(cod_com_rbd, nom_rbd)

ruta_estab_chile <- here::here(
  "40_salidas", "intermedios", "establecimientos_chile.parquet"
)
arrow::write_parquet(df_establecimientos, ruta_estab_chile)

message(sprintf(
  "    OK: %d establecimientos (%d comunas, %d dependencias distintas).",
  nrow(df_establecimientos),
  dplyr::n_distinct(df_establecimientos$cod_com_rbd),
  dplyr::n_distinct(df_establecimientos$cod_depe2)
))


# ============================================================================
# Resumen final
# ============================================================================

message("")
message("=== Resumen ===")
message(sprintf("  slep_cc_establecimientos.parquet: %d filas", nrow(df_estab)))
message(sprintf("  comunas_chile.parquet:            %d filas", nrow(df_comunas)))
message(sprintf("  sleps_chile.parquet:              %d filas", nrow(df_sleps)))
message(sprintf("  establecimientos_chile.parquet:   %d filas", nrow(df_establecimientos)))
message("")
message("30_construir_auxiliares.R: OK.")
