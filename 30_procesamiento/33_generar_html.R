# 33_generar_html.R
# ----------------------------------------------------------------------------
# Construye el producto final: motor_comparacion.html standalone.
#
# Flujo:
#   1. Lee simce_comunal.parquet y comunas_chile.parquet.
#   2. Construye el JSON con meta + catálogos + datos columnares.
#   3. Lee la plantilla motor_template.html y el D3 minificado.
#   4. Reemplaza placeholders __D3_INLINE__ y __JSON_DATA__.
#   5. Escribe 40_salidas/motor_comparacion.html (UTF-8).
#
# Salida: 40_salidas/motor_comparacion.html
#
# Uso:
#   source(here::here("30_procesamiento", "33_generar_html.R"))
# ----------------------------------------------------------------------------

library(here)


# ============================================================================
# Bloque 1 — Cargar insumos
# ============================================================================

message("[1] Cargando insumos...")

df_comunal <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "simce_comunal.parquet")
)
df_comunas <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "comunas_chile.parquet")
)

message(sprintf("    simce_comunal.parquet: %d filas", nrow(df_comunal)))
message(sprintf("    comunas_chile.parquet: %d comunas", nrow(df_comunas)))


# ============================================================================
# Bloque 2 — Construir estructura del JSON
# ============================================================================

message("[2] Construyendo JSON...")

# --- Catálogo de comunas (compactado: cod, nom, cod_reg, nom_reg) ---
comunas_lst <- df_comunas |>
  dplyr::transmute(
    cod     = cod_com_rbd,
    nom     = nom_com_rbd,
    cod_reg = cod_reg_rbd,
    nom_reg = nom_reg_rbd
  ) |>
  dplyr::arrange(nom)

# --- Catálogo de regiones (distinct) ---
regiones_lst <- df_comunas |>
  dplyr::distinct(cod_reg_rbd, nom_reg_rbd) |>
  dplyr::transmute(cod = cod_reg_rbd, nom = nom_reg_rbd) |>
  dplyr::arrange(as.integer(cod))

# --- Meta ---
# Lookup de nombre de comuna por código (para seed entidades).
nom_de <- function(cod) {
  v <- df_comunas$nom_com_rbd[df_comunas$cod_com_rbd == cod]
  if (length(v) == 0) NA_character_ else v[1]
}

# Construcción de strings con intToUtf8() para evitar literales no-ASCII.
# En locale C los literales no-ASCII quedan con Encoding="unknown" y
# jsonlite los serializa como bytes escapados (p. ej. "2<c2><b0> Medio").
# intToUtf8() produce strings con encoding UTF-8 explícito.
deg_char     <- intToUtf8(0x00B0)  # ° (grado)
a_acute_char <- intToUtf8(0x00E1)  # á

meta <- list(
  fecha_generacion = format(Sys.Date()),
  anios = sort(unique(as.integer(df_comunal$anio))),
  # Importante: I() fuerza que se serialice como array [2025], no escalar.
  anios_preliminar = I(c(2025L)),
  anios_sin_simce = c(2019L, 2020L, 2021L),
  # Niveles y pruebas: un solo objeto {codigo: label} cada uno.
  niveles = list(
    "2m" = paste0("2", deg_char, " Medio"),
    "4b" = paste0("4", deg_char, " B", a_acute_char, "sico")
  ),
  pruebas = list(
    "lect" = "Lectura",
    "mate" = paste0("Matem", a_acute_char, "tica")
  ),
  # GSE: array de códigos + diccionario separado de labels.
  gse = c("1", "2", "3", "4", "5"),
  gse_labels = list(
    "1" = "Bajo",
    "2" = "Medio bajo",
    "3" = "Medio",
    "4" = "Medio alto",
    "5" = "Alto"
  )
)

# --- Datos en formato columnar ---
# Ordenar por anio, nivel, prueba para que sea predecible.
df_ord <- df_comunal |>
  dplyr::arrange(anio, nivel, prueba, cod_com_rbd, cod_grupo)

datos_lst <- list(
  rows        = nrow(df_ord),
  cod_com     = df_ord$cod_com_rbd,
  nivel       = df_ord$nivel,
  prueba      = df_ord$prueba,
  cod_grupo   = df_ord$cod_grupo,
  anio        = as.integer(df_ord$anio),
  pct         = round(df_ord$pct_adecuado, 2),
  n_evaluados = as.integer(df_ord$n_evaluados),
  n_estab     = as.integer(df_ord$n_estab)
)

# --- Estructura raíz ---
json_root <- list(
  meta     = meta,
  regiones = regiones_lst,
  comunas  = comunas_lst,
  datos    = datos_lst
)

# Serialización: auto_unbox=TRUE para que escalares (anios_preliminar=2025L)
# no queden como arrays de un elemento.
json_str <- jsonlite::toJSON(
  json_root,
  auto_unbox = TRUE,
  na = "null",
  dataframe = "rows",
  digits = NA  # preservar precisión
)

# Forzar encoding UTF-8 (necesario para que ñ/tildes se serialicen bien).
json_str <- enc2utf8(json_str)

message(sprintf("    JSON listo: %d caracteres (%.1f MB).",
                nchar(json_str), nchar(json_str) / 1e6))


# ============================================================================
# Bloque 3 — Cargar plantilla y D3
# ============================================================================

message("[3] Leyendo plantilla y D3...")

plantilla_path <- here::here("30_procesamiento", "motor_template.html")
d3_path        <- here::here("10_utils", "d3.min.js")

if (!file.exists(plantilla_path)) {
  stop("No existe la plantilla: ", plantilla_path)
}
if (!file.exists(d3_path)) {
  stop("No existe D3.min.js: ", d3_path,
       "\n  Descargar con: curl -fsSL https://d3js.org/d3.v7.min.js -o ",
       "10_utils/d3.min.js")
}

plantilla <- paste(readLines(plantilla_path, encoding = "UTF-8"),
                   collapse = "\n")
d3_code <- paste(readLines(d3_path, encoding = "UTF-8"),
                 collapse = "\n")

message(sprintf("    Plantilla: %d caracteres", nchar(plantilla)))
message(sprintf("    D3:        %d caracteres (%.0f KB)",
                nchar(d3_code), nchar(d3_code) / 1024))


# ============================================================================
# Bloque 4 — Reemplazar placeholders y escribir HTML
# ============================================================================

message("[4] Construyendo HTML final...")

# Validación: placeholders presentes.
if (!grepl("__D3_INLINE__", plantilla, fixed = TRUE)) {
  stop("La plantilla no contiene el placeholder __D3_INLINE__.")
}
if (!grepl("__JSON_DATA__", plantilla, fixed = TRUE)) {
  stop("La plantilla no contiene el placeholder __JSON_DATA__.")
}

# Reemplazo. Usar sub() con fixed=TRUE para evitar interpretación regex
# (los nombres de comuna pueden contener caracteres que regex confundiría).
html <- sub("__D3_INLINE__", d3_code, plantilla, fixed = TRUE)
html <- sub("__JSON_DATA__", json_str, html, fixed = TRUE)

# Escribir como UTF-8.
ruta_salida <- here::here("40_salidas", "motor_comparacion.html")
con <- file(ruta_salida, open = "wb", encoding = "UTF-8")
writeBin(charToRaw(enc2utf8(html)), con)
close(con)

tamano_kb <- file.info(ruta_salida)$size / 1024
message(sprintf("    OK: %s (%.0f KB)",
                fs::path_rel(ruta_salida, here::here()),
                tamano_kb))


# ============================================================================
# Bloque 5 — Resumen
# ============================================================================

message("")
message("=== Resumen ===")
message(sprintf("  Filas en JSON: %d", datos_lst$rows))
message(sprintf("  Comunas:       %d", nrow(comunas_lst)))
message(sprintf("  Regiones:      %d", nrow(regiones_lst)))
message(sprintf("  Años:          %d (%s)", length(meta$anios),
                paste(meta$anios, collapse = ", ")))
message(sprintf("  Peso HTML:     %.1f KB", tamano_kb))
message("")
message(sprintf("33_generar_html.R: OK. Producto en %s",
                fs::path_rel(ruta_salida, here::here())))
