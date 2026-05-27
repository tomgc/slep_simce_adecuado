# 31_leer_normalizar.R
# ----------------------------------------------------------------------------
# Lee los 18 xlsx en 20_insumos/simce/{4b,2m}/, normaliza nombres de
# columnas, los lleva a formato largo (una fila por rbd × prueba × año
# × nivel) y emite el parquet único:
#
#   40_salidas/intermedios/simce_rbd.parquet
#
# Esquema final (11 columnas):
#   anio          integer    2014-2018, 2022-2025
#   nivel         character  "4b" | "2m"
#   prueba        character  "lect" | "mate"
#   rbd           character
#   cod_com_rbd   character
#   nom_com_rbd   character
#   cod_grupo     character  GSE "1".."5"
#   nalu          integer    n° evaluados
#   palu_eda_ade  double     % en estándar adecuado
#   marca         character  marca genérica de puntaje (decisión A2 opción a)
#   preliminar    logical    TRUE solo para anio == 2025 (regla R3)
#
# Anomalía A1 manejada: en simce4b2018, los sufijos vienen como "_2m_"
# en lugar de "_4b_". Se reescriben antes de la normalización general.
#
# Uso:
#   source(here::here("30_procesamiento", "31_leer_normalizar.R"))
#
# Convención: paquetes prefijados. library() solo para here y fs (uso
# intensivo).
# ----------------------------------------------------------------------------

library(here)
library(fs)


# ============================================================================
# Bloque 1 — Manifiesto de archivos esperados
# ============================================================================

message("[1] Construyendo manifiesto de xlsx...")

niveles <- c("2m", "4b")
anios_esperados <- c(2014:2018, 2022:2025)

# Patrón de nombre: simce<nivel><anio>_rbd_<estado>.xlsx
patron_archivo <- "^simce(2m|4b)(\\d{4})_rbd_(final|preliminar)\\.xlsx$"

manifiesto <- purrr::map_dfr(niveles, function(nv) {
  paths <- fs::dir_ls(
    here::here("20_insumos", "simce", nv),
    glob = "*.xlsx"
  )
  nombres <- basename(paths)
  m <- regmatches(nombres, regexec(patron_archivo, nombres))

  tibble::tibble(
    path    = as.character(paths),
    archivo = nombres,
    nivel   = vapply(m, function(x) if (length(x) >= 2) x[2] else NA_character_,
                     character(1)),
    anio    = vapply(m, function(x) if (length(x) >= 3) as.integer(x[3]) else NA_integer_,
                     integer(1)),
    estado  = vapply(m, function(x) if (length(x) >= 4) x[4] else NA_character_,
                     character(1))
  )
})

# Validar que parse fue exitoso para todos.
stopifnot(
  "Algún xlsx no cumple el patrón simce<nivel><anio>_rbd_<estado>.xlsx" =
    !any(is.na(manifiesto$nivel) | is.na(manifiesto$anio))
)

# Validar 9 años × 2 niveles = 18 archivos, con los años esperados.
for (nv in niveles) {
  anios_presentes <- sort(manifiesto$anio[manifiesto$nivel == nv])
  faltan <- setdiff(anios_esperados, anios_presentes)
  sobran <- setdiff(anios_presentes, anios_esperados)
  if (length(faltan) > 0) {
    stop(sprintf("Nivel %s: faltan años %s",
                 nv, paste(faltan, collapse = ", ")))
  }
  if (length(sobran) > 0) {
    stop(sprintf("Nivel %s: años inesperados %s",
                 nv, paste(sobran, collapse = ", ")))
  }
}

message(sprintf("    OK: %d archivos detectados (%d por nivel).",
                nrow(manifiesto), nrow(manifiesto) / 2))


# ============================================================================
# Bloque 2 — Helper: extraer formato largo para una prueba
# ============================================================================

# Extrae las 7 columnas base + asigna prueba="lect" o "mate".
extraer_prueba <- function(df_raw, nivel, prueba) {
  sufijo <- paste0(prueba, nivel)  # p. ej. "lect2m" o "mate4b"

  col_nalu  <- paste0("nalu_",         sufijo, "_rbd")
  col_palu  <- paste0("palu_eda_ade_", sufijo, "_rbd")
  col_marca <- paste0("marca_",        sufijo, "_rbd")

  # Coerción defensiva: si el valor viene con coma decimal, normalizar
  # antes de as.numeric/as.integer.
  to_num <- function(x) {
    suppressWarnings(as.numeric(gsub(",", ".", as.character(x), fixed = TRUE)))
  }

  tibble::tibble(
    rbd          = as.character(df_raw$rbd),
    cod_com_rbd  = as.character(df_raw$cod_com_rbd),
    nom_com_rbd  = as.character(df_raw$nom_com_rbd),
    cod_grupo    = as.character(df_raw$cod_grupo),
    nalu         = as.integer(to_num(df_raw[[col_nalu]])),
    palu_eda_ade = to_num(df_raw[[col_palu]]),
    marca        = as.character(df_raw[[col_marca]]),
    prueba       = prueba
  )
}


# ============================================================================
# Bloque 3 — Función principal: leer y normalizar un xlsx
# ============================================================================

leer_un_xlsx <- function(path, nivel, anio, estado, archivo) {

  df_raw <- readxl::read_excel(path)

  # Normalizar nombres: minúsculas + trim. Los nombres SIMCE son ASCII puros,
  # no hay problema de encoding.
  names(df_raw) <- trimws(tolower(names(df_raw)))

  # --- Anomalía A1: 2018/4b usa sufijos _2m_ en lugar de _4b_ ---
  if (anio == 2018L && nivel == "4b") {
    names(df_raw) <- gsub("_2m_", "_4b_", names(df_raw), fixed = TRUE)
  }

  # --- Validación de columnas requeridas para este nivel ---
  cols_base <- c("rbd", "cod_com_rbd", "nom_com_rbd", "cod_grupo")
  cols_por_prueba <- c(
    paste0("nalu_lect", nivel, "_rbd"),
    paste0("nalu_mate", nivel, "_rbd"),
    paste0("palu_eda_ade_lect", nivel, "_rbd"),
    paste0("palu_eda_ade_mate", nivel, "_rbd"),
    paste0("marca_lect", nivel, "_rbd"),
    paste0("marca_mate", nivel, "_rbd")
  )
  cols_requeridas <- c(cols_base, cols_por_prueba)
  faltan <- setdiff(cols_requeridas, names(df_raw))
  if (length(faltan) > 0) {
    stop(sprintf(
      "Faltan columnas en %s: %s",
      archivo, paste(faltan, collapse = ", ")
    ))
  }

  # --- Normalizar cod_grupo a códigos "1".."5" ---
  # Años antiguos (2014-2017 según nivel) traen literales "Bajo".."Alto".
  # Mapeo al código numérico canónico para preservar comparabilidad
  # longitudinal (regla R1: GSE indexado a [anio + nivel + rbd]).
  cod_grupo_chr <- as.character(df_raw$cod_grupo)
  df_raw$cod_grupo <- dplyr::case_when(
    cod_grupo_chr == "Bajo"       ~ "1",
    cod_grupo_chr == "Medio bajo" ~ "2",
    cod_grupo_chr == "Medio"      ~ "3",
    cod_grupo_chr == "Medio alto" ~ "4",
    cod_grupo_chr == "Alto"       ~ "5",
    TRUE                          ~ cod_grupo_chr
  )

  # --- Cross-check: año interno vs año del nombre de archivo ---
  if ("agno" %in% names(df_raw)) {
    agnos_internos <- unique(as.integer(df_raw$agno))
    agnos_internos <- agnos_internos[!is.na(agnos_internos)]
    if (length(agnos_internos) == 1 && agnos_internos != anio) {
      warning(sprintf(
        "%s: año interno (%d) difiere del nombre (%d).",
        archivo, agnos_internos, anio
      ))
    }
  }

  # --- Construir formato largo: lect + mate ---
  df_lect <- extraer_prueba(df_raw, nivel, "lect")
  df_mate <- extraer_prueba(df_raw, nivel, "mate")
  df_largo <- dplyr::bind_rows(df_lect, df_mate)

  # --- Columnas constantes del archivo ---
  df_largo$anio       <- as.integer(anio)
  df_largo$nivel      <- nivel
  df_largo$preliminar <- (estado == "preliminar")

  # Orden de columnas final.
  df_largo <- df_largo[, c(
    "anio", "nivel", "prueba", "rbd",
    "cod_com_rbd", "nom_com_rbd", "cod_grupo",
    "nalu", "palu_eda_ade", "marca", "preliminar"
  )]

  df_largo
}


# ============================================================================
# Bloque 4 — Iterar sobre los 18 archivos
# ============================================================================

message("[2] Procesando 18 xlsx...")

df_simce_rbd <- purrr::pmap_dfr(
  manifiesto,
  function(path, archivo, nivel, anio, estado) {
    df <- leer_un_xlsx(path, nivel, anio, estado, archivo)
    message(sprintf(
      "    %s%d/%s — %d filas (%d rbds × 2 pruebas)",
      ifelse(estado == "preliminar", "*", " "),
      anio, nivel, nrow(df), nrow(df) / 2L
    ))
    df
  }
)


# ============================================================================
# Bloque 5 — Validaciones globales
# ============================================================================

message("[3] Validaciones globales...")

# 5.1 — cod_grupo dentro del rango esperado.
valores_gse <- unique(df_simce_rbd$cod_grupo)
valores_gse_validos <- c("1", "2", "3", "4", "5", NA)
valores_anomalos <- setdiff(valores_gse, valores_gse_validos)
if (length(valores_anomalos) > 0) {
  warning(sprintf(
    "cod_grupo con valores inesperados: %s (esperados: 1-5 o NA).",
    paste(valores_anomalos, collapse = ", ")
  ))
  tbl_anomalos <- dplyr::count(
    df_simce_rbd[df_simce_rbd$cod_grupo %in% valores_anomalos, ],
    anio, nivel, cod_grupo
  )
  message("    Detalle de cod_grupo anómalos:")
  print(tbl_anomalos)
} else {
  message("    OK: cod_grupo ∈ {1..5, NA}.")
}

# 5.2 — Cada (anio, nivel, rbd) debe tener exactamente 2 filas (lect+mate).
filas_por_rbd <- dplyr::count(df_simce_rbd, anio, nivel, rbd, name = "n_filas")
rbds_anomalos <- filas_por_rbd[filas_por_rbd$n_filas != 2L, ]
if (nrow(rbds_anomalos) > 0) {
  warning(sprintf(
    "%d (anio,nivel,rbd) con != 2 filas. Muestra:",
    nrow(rbds_anomalos)
  ))
  print(utils::head(rbds_anomalos, 10))
} else {
  message("    OK: cada (anio, nivel, rbd) tiene exactamente 2 filas (lect+mate).")
}

# 5.3 — Conteo de NAs en columnas críticas.
message("    NAs por columna crítica:")
for (col in c("nalu", "palu_eda_ade", "marca", "cod_grupo")) {
  n_na <- sum(is.na(df_simce_rbd[[col]]))
  message(sprintf("      %-15s %6d NAs (%.1f%%)",
                  col, n_na, 100 * n_na / nrow(df_simce_rbd)))
}


# ============================================================================
# Bloque 6 — Escritura del parquet
# ============================================================================

message("[4] Escribiendo simce_rbd.parquet...")

ruta_salida <- here::here("40_salidas", "intermedios", "simce_rbd.parquet")
arrow::write_parquet(df_simce_rbd, ruta_salida)

message(sprintf("    OK: %d filas escritas en %s.",
                nrow(df_simce_rbd),
                fs::path_rel(ruta_salida, here::here())))


# ============================================================================
# Bloque 7 — Resumen final
# ============================================================================

message("")
message("=== Resumen filas por (anio × nivel × prueba) ===")
resumen <- df_simce_rbd |>
  dplyr::count(anio, nivel, prueba, name = "n_rbds") |>
  dplyr::arrange(nivel, anio, prueba)
print(resumen, n = Inf)

message("")
message(sprintf(
  "31_leer_normalizar.R: OK. Total %d filas en simce_rbd.parquet.",
  nrow(df_simce_rbd)
))
