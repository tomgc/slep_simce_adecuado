# 30_construir_auxiliares.R
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
#        PENDIENTE. Fuente a proveer por el titular.
#
# Uso:
#   source(here::here("30_procesamiento", "30_construir_auxiliares.R"))
#
# Convención: paquetes prefijados (readxl::, readr::, dplyr::, arrow::).
# Solo library(here) por uso intensivo de rutas.
# ----------------------------------------------------------------------------

library(here)


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
  "AGNO", "RBD",
  "COD_COM_RBD", "NOM_COM_RBD",
  "COD_REG_RBD", "NOM_REG_RBD_A",
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

df_comunas <- df_dir_raw |>
  dplyr::filter(.data$ESTADO_ESTAB == 1, .data$MATRICULA == 1) |>
  dplyr::transmute(
    cod_com_rbd = as.character(COD_COM_RBD),
    nom_com_rbd = NOM_COM_RBD,
    cod_reg_rbd = as.character(COD_REG_RBD),
    nom_reg_rbd = NOM_REG_RBD_A
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
# Bloque 4 — sleps_chile.parquet  [PENDIENTE]
# ============================================================================
# El CSV directorio_oficial_ee.csv NO contiene columna NOMBRE_SLEP (verificado:
# las 58 columnas del archivo no incluyen ninguna que matchee 'slep'). El
# diccionario_territorios.xlsx tampoco. Esperando archivo fuente del titular.
#
# Esqueleto previsto (completar cuando llegue la fuente):
#
#   df_sleps_raw <- readxl::read_excel(
#     here::here("20_insumos", "auxiliares", "<archivo_sleps>.xlsx")
#   )
#
#   df_sleps <- df_sleps_raw |>
#     dplyr::transmute(
#       nombre_slep = NOMBRE_SLEP,
#       cod_com_rbd = as.character(<col_codigo_comuna>),
#       nom_com_rbd = <col_nombre_comuna>
#     ) |>
#     dplyr::distinct()
#
#   arrow::write_parquet(
#     df_sleps,
#     here::here("40_salidas", "intermedios", "sleps_chile.parquet")
#   )
#
#   message(sprintf(
#     "    OK: %d filas (%d SLEPs únicos).",
#     nrow(df_sleps),
#     dplyr::n_distinct(df_sleps$nombre_slep)
#   ))

message("[4] sleps_chile.parquet: PENDIENTE — fuente a proveer por el titular.")


# ============================================================================
# Resumen final
# ============================================================================

message("")
message("=== Resumen ===")
message(sprintf("  slep_cc_establecimientos.parquet: %d filas", nrow(df_estab)))
message(sprintf("  comunas_chile.parquet:            %d filas", nrow(df_comunas)))
message("  sleps_chile.parquet:              PENDIENTE")
message("")
message("30_construir_auxiliares.R: OK (parcial).")
