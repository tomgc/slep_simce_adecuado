# 32_agregar_comunal.R
# ----------------------------------------------------------------------------
# Construye la agregación a nivel comuna × GSE × prueba × nivel × año a
# partir de simce_rbd.parquet, joineando con comunas_chile.parquet para
# incluir nombres de comuna y región.
#
# Salida: 40_salidas/intermedios/simce_comunal.parquet
#
# Esquema final (12 columnas):
#   anio          integer
#   nivel         character    "4b" | "2m"
#   prueba        character    "lect" | "mate"
#   cod_com_rbd   character
#   nom_com_rbd   character    (join con comunas_chile.parquet)
#   cod_reg_rbd   character    (join)
#   nom_reg_rbd   character    (join)
#   cod_grupo     character    GSE "1".."5"  (filas con NA excluidas)
#   cod_depe2     character    dependencia agrupada "1".."5"
#   pct_adecuado  double       % ponderado adecuado
#   n_evaluados   integer      sum(nalu) tras filtros MINEDUC
#   n_estab       integer      n establecimientos en la agregación
#
# Filtros aplicados:
#   1. Pre-agregación: cod_grupo no-NA (establecimientos sin clasificar GSE
#      excluidos).
#   2. Aplicados por agregar_ponderado() internamente:
#        - nalu >= 10 (umbral MINEDUC)
#        - marca es NA (sin marca de supresión)
#        - palu_eda_ade no-NA (defensivo)
#
# Uso:
#   source(here::here("30_procesamiento", "32_agregar_comunal.R"))
#
# Convención: paquetes prefijados (dplyr::, tidyr::, arrow::, fs::).
# library() solo para here.
# ----------------------------------------------------------------------------

library(here)
source(here::here("10_utils", "10_utils.R"))


# ============================================================================
# Bloque 1 — Cargar insumos
# ============================================================================

message("[1] Cargando insumos...")

df_rbd <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "simce_rbd.parquet")
)
message(sprintf("    simce_rbd.parquet:     %d filas, %d columnas",
                nrow(df_rbd), ncol(df_rbd)))

df_comunas <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "comunas_chile.parquet")
)
message(sprintf("    comunas_chile.parquet: %d comunas, %d columnas",
                nrow(df_comunas), ncol(df_comunas)))

# Validar columnas requeridas.
cols_rbd_req <- c("anio", "nivel", "prueba", "rbd",
                  "cod_com_rbd", "cod_grupo", "cod_depe2",
                  "nalu", "palu_eda_ade", "marca")
faltan_rbd <- setdiff(cols_rbd_req, names(df_rbd))
if (length(faltan_rbd) > 0) {
  stop(sprintf("Faltan columnas en simce_rbd.parquet: %s",
               paste(faltan_rbd, collapse = ", ")))
}

cols_com_req <- c("cod_com_rbd", "nom_com_rbd", "cod_reg_rbd", "nom_reg_rbd")
faltan_com <- setdiff(cols_com_req, names(df_comunas))
if (length(faltan_com) > 0) {
  stop(sprintf("Faltan columnas en comunas_chile.parquet: %s",
               paste(faltan_com, collapse = ", ")))
}


# ============================================================================
# Bloque 2 — Filtrar cod_grupo NA y agregar comunalmente
# ============================================================================

message("[2] Filtrando cod_grupo NA y agregando...")

n_grupo_na <- sum(is.na(df_rbd$cod_grupo))
df_rbd_filt <- df_rbd |>
  dplyr::filter(!is.na(cod_grupo))

message(sprintf("    Filas con cod_grupo NA excluidas: %d (%.2f%%)",
                n_grupo_na, 100 * n_grupo_na / nrow(df_rbd)))

df_agg <- agregar_ponderado(
  df_rbd_filt,
  group_vars = c("anio", "nivel", "prueba", "cod_com_rbd", "cod_grupo", "cod_depe2")
)

message(sprintf("    Filas agregadas: %d", nrow(df_agg)))


# ============================================================================
# Bloque 3 — Join con comunas_chile.parquet
# ============================================================================

message("[3] Joineando con comunas_chile.parquet...")

df_comunal <- dplyr::left_join(df_agg, df_comunas, by = "cod_com_rbd")

# Validar cobertura del join.
n_sin_match <- sum(is.na(df_comunal$nom_com_rbd))
if (n_sin_match > 0) {
  cods_sin_match <- unique(df_comunal$cod_com_rbd[is.na(df_comunal$nom_com_rbd)])
  warning(sprintf(
    "%d filas (%d cod_com_rbd únicos) sin match en comunas_chile.parquet.",
    n_sin_match, length(cods_sin_match)
  ))
  message(sprintf("    cod_com_rbd sin match (muestra): %s",
                  paste(utils::head(cods_sin_match, 10), collapse = ", ")))
} else {
  message("    OK: 100% de cod_com_rbd con match en comunas_chile.")
}


# ============================================================================
# Bloque 4 — Validaciones globales
# ============================================================================

message("[4] Validaciones globales...")

# 4.1 — cod_com_rbd no NA.
n_cod_na <- sum(is.na(df_comunal$cod_com_rbd))
if (n_cod_na > 0) {
  warning(sprintf("    %d filas con cod_com_rbd NA.", n_cod_na))
} else {
  message("    OK: cod_com_rbd poblado en todas las filas.")
}

# 4.2 — Sin duplicados en la llave de agregación.
n_dups <- df_comunal |>
  dplyr::count(anio, nivel, prueba, cod_com_rbd, cod_depe2, cod_grupo, name = "n_dup") |>
  dplyr::filter(n_dup > 1) |>
  nrow()
if (n_dups > 0) {
  warning(sprintf("    %d combinaciones duplicadas en (anio,nivel,prueba,cod_com_rbd,cod_depe2,cod_grupo).",
                  n_dups))
} else {
  message("    OK: sin duplicados en llave de agregación.")
}


# ============================================================================
# Bloque 5 — Ordenar columnas y escribir
# ============================================================================

message("[5] Escribiendo simce_comunal.parquet...")

df_comunal <- df_comunal |>
  dplyr::select(
    anio, nivel, prueba,
    cod_com_rbd, nom_com_rbd, cod_reg_rbd, nom_reg_rbd,
    cod_grupo, cod_depe2,
    pct_adecuado, n_evaluados, n_estab
  ) |>
  dplyr::arrange(anio, nivel, prueba, cod_com_rbd, cod_depe2, cod_grupo)

ruta_salida <- here::here(
  "40_salidas", "intermedios", "simce_comunal.parquet"
)
arrow::write_parquet(df_comunal, ruta_salida)

message(sprintf("    OK: %d filas escritas en %s.",
                nrow(df_comunal),
                fs::path_rel(ruta_salida, here::here())))


# ============================================================================
# Bloque 6 — Resumen y sanity check
# ============================================================================

message("")
message("=== Cobertura por (anio × nivel × prueba) ===")
resumen <- df_comunal |>
  dplyr::count(anio, nivel, prueba) |>
  tidyr::pivot_wider(names_from = prueba, values_from = n)
print(resumen, n = Inf)

message("")
message("=== Costa Central — 4b/lect, % adecuado ponderado por GSE × año ===")
costa_central <- c("5103", "5105", "5107", "5109")
cc <- df_comunal |>
  dplyr::filter(
    nivel == "4b",
    prueba == "lect",
    cod_com_rbd %in% costa_central
  ) |>
  dplyr::mutate(pct = round(pct_adecuado, 1)) |>
  dplyr::select(nom_com_rbd, cod_grupo, anio, pct) |>
  tidyr::pivot_wider(names_from = anio, values_from = pct) |>
  dplyr::arrange(nom_com_rbd, cod_grupo)
print(cc, n = Inf, width = 200)

message("")
message(sprintf(
  "32_agregar_comunal.R: OK. Total %d filas en simce_comunal.parquet (12 columnas).",
  nrow(df_comunal)
))
