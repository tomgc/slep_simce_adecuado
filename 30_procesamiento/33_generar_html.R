# 33_generar_html.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Construye el producto final: motor_comparacion.html standalone.
#
# Flujo:
#   1. Lee simce_comunal.parquet y comunas_chile.parquet.
#   2. Construye el JSON con meta + catálogos + datos columnares.
#   3. Comprime el JSON (gzip + base64); el template lo descomprime en cliente
#      con pako.inflate. Lee la plantilla, el D3 minificado y pako.
#   4. Reemplaza placeholders __D3_INLINE__, __PAKO_INLINE__, __JSON_DATA__,
#      __REACT_INLINE__ y __REACTDOM_INLINE__, y transpila el bloque JSX de la
#      app con Babel standalone dentro de V8 (s31). El HTML resultante no
#      carga nada por red: React y ReactDOM van inline y Babel no viaja.
#   5. Escribe 40_salidas/motor_comparacion.html (UTF-8).
#
# Salida: 40_salidas/motor_comparacion.html
#
# Uso:
#   source(here::here("30_procesamiento", "33_generar_html.R"))
# ----------------------------------------------------------------------------

library(here)


# ============================================================================
# Bloque 0 — Constantes y funciones auxiliares (s31, retiro de unpkg.com)
# ============================================================================

# Dependencias JavaScript vendorizadas en 10_utils/. El sha384 (base64) es el
# mismo SRI que la plantilla usaba contra unpkg.com hasta la sesión 30: si el
# archivo en disco no lo reproduce, el build se detiene. La URL solo sirve
# para volver a descargarlo a mano; el build no usa la red.
VENDOR_JS <- list(
  react = list(
    ruta = here::here("10_utils", "react.production.min.js"),
    sri  = "DGyLxAyjq0f9SPpVevD6IgztCFlnMF6oW/XQGmfe+IsZ8TqEiDrcHkMLKI6fiB/Z",
    url  = "https://unpkg.com/react@18.3.1/umd/react.production.min.js"
  ),
  reactdom = list(
    ruta = here::here("10_utils", "react-dom.production.min.js"),
    sri  = "gTGxhz21lVGYNMcdJOyq01Edg0jhn/c22nsx0kyqP0TxaV5WVdsSH1fSDUf5YJj1",
    url  = "https://unpkg.com/react-dom@18.3.1/umd/react-dom.production.min.js"
  ),
  babel = list(
    ruta = here::here("10_utils", "babel.min.js"),
    sri  = "m08KidiNqLdpJqLq95G/LEi8Qvjl/xUYll3QILypMoQ65QorJ9Lvtp2RXYGBFj1y",
    url  = "https://unpkg.com/@babel/standalone@7.29.0/babel.min.js"
  )
)

# Ancla del bloque de la app en la plantilla. Se edita como JSX; el generador
# lo reemplaza por su transpilado. Presets iguales a los que Babel usaba en el
# navegador (env, react), con runtime "classic" fijado: el automático emite
# _jsx(), que el motor inline no resuelve (A34 de slep_categoria_desempeno).
ANCLA_JSX_APERTURA <- '<script type="text/babel" data-presets="env,react">'
ANCLA_JSX_CIERRE   <- "</script>"
OPCIONES_BABEL <- paste0(
  "{presets: ['env', ['react', {runtime: 'classic'}]], ",
  "sourceType: 'script', comments: true, compact: false}"
)

for (paquete in c("V8", "openssl")) {
  if (!requireNamespace(paquete, quietly = TRUE)) {
    stop("Falta el paquete ", paquete, ". Instalar con: install.packages(\"",
         paquete, "\")")
  }
}

# Lee un archivo de texto completo como una sola cadena UTF-8.
leer_texto <- function(ruta) {
  paste(readLines(ruta, encoding = "UTF-8", warn = FALSE), collapse = "\n")
}

# Verifica que el archivo exista y que su sha384 sea el declarado.
verificar_vendor <- function(dep) {
  if (!file.exists(dep$ruta)) {
    stop("No existe ", dep$ruta, "\n  Descargar con: curl -fsSL ", dep$url,
         " -o ", fs::path_rel(dep$ruta, here::here()))
  }
  con <- file(dep$ruta, open = "rb")
  on.exit(close(con))
  sri <- openssl::base64_encode(openssl::sha384(con))
  if (!identical(sri, dep$sri)) {
    stop("sha384 inesperado en ", dep$ruta, "\n  esperado: ", dep$sri,
         "\n  obtenido: ", sri)
  }
  invisible(TRUE)
}

# Reemplaza la única aparición de `marcador` por `valor`, sin interpretar
# barras invertidas ni expresiones regulares en `valor` (el código minificado
# las contiene). Se detiene si el marcador no aparece exactamente una vez.
reemplazar_literal <- function(texto, marcador, valor) {
  pos <- gregexpr(marcador, texto, fixed = TRUE)[[1]]
  if (length(pos) != 1L || pos[1] < 0) {
    stop("El marcador debe aparecer exactamente una vez: ", marcador,
         " (apariciones: ", sum(pos > 0), ")")
  }
  paste0(substr(texto, 1L, pos - 1L), valor,
         substr(texto, pos + nchar(marcador), nchar(texto)))
}

# Transpila JSX a JavaScript con Babel standalone dentro de V8. Devuelve el
# código; se detiene si la salida no es JavaScript válido o conserva rastros
# del runtime automático.
transpilar_jsx <- function(jsx, babel_code) {
  ctx <- V8::v8()
  ctx$eval(babel_code)
  ctx$assign("fuente_jsx", jsx)
  ctx$eval(paste0("var salida_babel = Babel.transform(fuente_jsx, ",
                  OPCIONES_BABEL, ").code;"))
  salida <- ctx$get("salida_babel")
  if (!isTRUE(ctx$validate(salida))) {
    stop("La salida de Babel no es JavaScript válido.")
  }
  if (grepl("_jsx(", salida, fixed = TRUE) ||
      grepl("react/jsx-runtime", salida, fixed = TRUE)) {
    stop("La salida usa el runtime automático de JSX; se esperaba classic.")
  }
  salida
}


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
df_sleps <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "sleps_chile.parquet")
)
df_rbd <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "establecimientos_chile.parquet")
)

message(sprintf("    simce_comunal.parquet: %d filas", nrow(df_comunal)))
message(sprintf("    comunas_chile.parquet: %d comunas", nrow(df_comunas)))
message(sprintf("    sleps_chile.parquet:   %d filas (%d SLEPs)",
                nrow(df_sleps), dplyr::n_distinct(df_sleps$cod_slep)))
message(sprintf("    establecimientos_chile.parquet: %d establecimientos",
                nrow(df_rbd)))


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

# Años preliminares: los que 31_leer_normalizar.R leyó desde un archivo
# *_preliminar.xlsx (columna `preliminar` de simce_rbd.parquet). Se derivan de
# los insumos para que el asterisco desaparezca solo cuando la Agencia publica
# la base final (s31; antes era el literal 2025L).
anios_preliminar <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "simce_rbd.parquet"),
  col_select = c("anio", "preliminar")
) |>
  dplyr::filter(preliminar) |>
  dplyr::pull(anio) |>
  unique() |>
  as.integer() |>
  sort()
message(sprintf("    Años preliminares: %s",
                if (length(anios_preliminar) == 0) "ninguno"
                else paste(anios_preliminar, collapse = ", ")))

meta <- list(
  fecha_generacion = format(Sys.Date()),
  anios = sort(unique(as.integer(df_comunal$anio))),
  # Importante: I() fuerza que se serialice como array ([2025] o []), no escalar.
  anios_preliminar = I(anios_preliminar),
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
  ),
  # Dependencia agrupada (COD_DEPE2 del directorio oficial MINEDUC).
  depe2 = c("1", "2", "3", "4", "5"),
  depe2_labels = list(
    "1" = "Municipal",
    "2" = "Particular Subvencionado",
    "3" = "Particular Pagado",
    "4" = "Corp. Admin. Delegada",
    "5" = "Servicio Local de Educación Pública (SLEP)"
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
  cod_depe2   = df_ord$cod_depe2,
  anio        = as.integer(df_ord$anio),
  pct         = round(df_ord$pct_adecuado, 2),
  pct_ele     = round(df_ord$pct_elemental, 2),
  pct_ins     = round(df_ord$pct_insuficiente, 2),
  n_evaluados = as.integer(df_ord$n_evaluados),
  n_estab     = as.integer(df_ord$n_estab)
)

# --- Catálogo de establecimientos (RBDs únicos con nombre y dependencia) ---
# Fuente: establecimientos_chile.parquet — todos los establecimientos
# operativos del directorio oficial. Se usa en el popup "ver establecimientos"
# del motor HTML para cualquier tipo de entidad.
establecimientos_lst <- df_rbd |>
  dplyr::select(rbd, nom_rbd, cod_com_rbd, nom_com_rbd, cod_depe2) |>
  dplyr::arrange(cod_com_rbd, nom_rbd)

# --- RBDs por nivel × prueba (para filtrar popup de establecimientos) ---
# Fuente: simce_rbd.parquet — qué RBDs rindieron cada combinación nivel×prueba.
# Filtro COMPLETO de producción (auditoría A2, s13): mismo criterio que
# agregar_ponderado() — palu publicado, umbral MINEDUC (nalu >= 10) y sin
# marca de supresión. Solo palu no-NA es insuficiente: listaría RBDs que no
# aportan al % mostrado.
df_rbd_np <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "simce_rbd.parquet")
) |>
  dplyr::filter(
    !is.na(.data$palu_eda_ade),
    !is.na(.data$nalu), .data$nalu >= 10,
    is.na(.data$marca)
  ) |>
  dplyr::distinct(rbd, nivel, prueba) |>
  dplyr::mutate(rbd = as.character(rbd)) |>
  dplyr::arrange(nivel, prueba, rbd)

# --- RBDs por nivel × prueba × GSE (para filtro GSE en popup de celda) ---
# Distinct de rbd × nivel × prueba × cod_grupo. Se usa en EstabPopup cuando
# se abre desde una celda de la tabla (P7) para mostrar solo los establecimientos
# del GSE clicado. ~15-20k filas vs 185k del parquet completo.
# Solo combinaciones que APORTAN al cálculo (auditoría A2, s13): palu no-NA,
# nalu >= 10 (umbral MINEDUC) y marca NA — el mismo criterio de
# agregar_ponderado(). La Agencia suprime resultados (palu = NA aunque
# nalu > 0) y además producción excluye nalu < 10 y marcas de supresión;
# un RBD que no cumple cualquiera de las tres condiciones no debe listarse.
df_rbd_gse <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "simce_rbd.parquet")
) |>
  dplyr::filter(
    !is.na(.data$palu_eda_ade),
    !is.na(.data$nalu), .data$nalu >= 10,
    is.na(.data$marca)
  ) |>
  dplyr::distinct(rbd, nivel, prueba, cod_grupo) |>
  dplyr::mutate(rbd = as.character(rbd)) |>
  dplyr::arrange(nivel, prueba, cod_grupo, rbd)

# --- Datos por establecimiento (para entidades tipo establecimiento) ---
# 8 columnas necesarias para graficar; excluye marca, nom_com_rbd, preliminar
# (recuperables desde otros catálogos). Formato columnar para compacidad.
# Filtro COMPLETO de producción (auditoría A2, s13): generateSeriesByRbd y
# los conteos del motor consumen esta tabla SIN poder reaplicar el umbral
# MINEDUC ni la marca (marca no viaja en el JSON). Si acá entran filas con
# nalu < 10 o marca no-NA, los % de SLEP divergen del resto del motor
# (divergencias de hasta 42.6 pp medidas en la auditoría). La regla del
# invariante 5 se aplica una sola vez, acá, en R.
df_simce_rbd <- arrow::read_parquet(
  here::here("40_salidas", "intermedios", "simce_rbd.parquet")
) |>
  dplyr::filter(
    !is.na(.data$palu_eda_ade),
    !is.na(.data$nalu), .data$nalu >= 10,
    is.na(.data$marca)
  ) |>
  dplyr::select(rbd, nivel, prueba, cod_grupo, anio, nalu, palu_eda_ade, palu_eda_ele, palu_eda_ins, cod_depe2) |>
  dplyr::mutate(
    rbd       = as.character(rbd),
    palu_eda_ade = round(palu_eda_ade, 2),
    palu_eda_ele = round(palu_eda_ele, 2),
    palu_eda_ins = round(palu_eda_ins, 2)
  ) |>
  dplyr::arrange(rbd, nivel, prueba, anio, cod_grupo)

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

# --- Catálogo de SLEPs (una fila por SLEP × RBD) ---
sleps_lst <- df_sleps |>
  dplyr::transmute(
    cod_slep      = cod_slep,
    nombre_slep   = nombre_slep,
    anio_traspaso = as.integer(anio_traspaso),
    cod_com_rbd   = cod_com_rbd,
    nom_com_rbd   = nom_com_rbd,
    rbd           = rbd,
    nom_rbd       = nom_rbd
  )

# --- Estructura raíz ---
json_root <- list(
  meta             = meta,
  regiones         = regiones_lst,
  comunas          = comunas_lst,
  datos            = datos_lst,
  sleps            = sleps_lst,
  establecimientos = establecimientos_lst,
  rbds_por_nivel   = df_rbd_np,
  rbd_gse          = df_rbd_gse,
  simce_rbd        = simce_rbd_lst
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

bytes_plano <- nchar(json_str, type = "bytes")
message(sprintf("    JSON listo: %d caracteres (%.1f MB sin comprimir).",
                nchar(json_str), bytes_plano / 1e6))

# --- Compresión gzip + base64 ---
# El template descomprime en cliente: JSON.parse(pako.inflate(atob(...))).
# memCompress(type="gzip") produce formato gzip que pako.inflate decodifica
# byte a byte idéntico (validado contra zlib/pako). base64_enc evita romper
# el string literal del HTML con comillas o caracteres de control del binario.
json_gzip <- memCompress(charToRaw(json_str), type = "gzip")
# base64_enc() emite formato MIME con saltos de línea cada 64 caracteres.
# Esos \n literales romperían el string JS dentro de atob("..."), así que se
# eliminan: el base64 queda en una sola línea continua.
json_b64  <- gsub("\n", "", jsonlite::base64_enc(json_gzip), fixed = TRUE)

bytes_b64 <- nchar(json_b64, type = "bytes")
message(sprintf("    JSON comprimido: %.1f MB (gzip+base64, %.1f%% del plano).",
                bytes_b64 / 1e6, 100 * bytes_b64 / bytes_plano))


# ============================================================================
# Bloque 3 — Cargar plantilla y D3
# ============================================================================

message("[3] Leyendo plantilla, D3 y pako...")

plantilla_path <- here::here("30_procesamiento", "33_motor_template.html")
d3_path        <- here::here("10_utils", "d3.min.js")
pako_path      <- here::here("10_utils", "pako.min.js")

if (!file.exists(plantilla_path)) {
  stop("No existe la plantilla: ", plantilla_path)
}
if (!file.exists(d3_path)) {
  stop("No existe D3.min.js: ", d3_path,
       "\n  Descargar con: curl -fsSL https://d3js.org/d3.v7.min.js -o ",
       "10_utils/d3.min.js")
}
if (!file.exists(pako_path)) {
  stop("No existe pako.min.js: ", pako_path,
       "\n  Descargar con: curl -fsSL ",
       "https://cdn.jsdelivr.net/npm/pako@2.1.0/dist/pako.min.js -o ",
       "10_utils/pako.min.js")
}

plantilla <- paste(readLines(plantilla_path, encoding = "UTF-8"),
                   collapse = "\n")
d3_code <- paste(readLines(d3_path, encoding = "UTF-8"),
                 collapse = "\n")
pako_code <- paste(readLines(pako_path, encoding = "UTF-8"),
                   collapse = "\n")

message(sprintf("    Plantilla: %d caracteres", nchar(plantilla)))
message(sprintf("    D3:        %d caracteres (%.0f KB)",
                nchar(d3_code), nchar(d3_code) / 1024))
message(sprintf("    pako:      %d caracteres (%.0f KB)",
                nchar(pako_code), nchar(pako_code) / 1024))


# ============================================================================
# Bloque 3b — React vendorizado y transpilación de la app (s31)
# ============================================================================

message("[3b] Verificando dependencias vendorizadas y transpilando la app...")

invisible(lapply(VENDOR_JS, verificar_vendor))
react_code    <- leer_texto(VENDOR_JS$react$ruta)
reactdom_code <- leer_texto(VENDOR_JS$reactdom$ruta)
babel_code    <- leer_texto(VENDOR_JS$babel$ruta)

ini_jsx <- gregexpr(ANCLA_JSX_APERTURA, plantilla, fixed = TRUE)[[1]]
if (length(ini_jsx) != 1L || ini_jsx[1] < 0) {
  stop("La plantilla debe contener una sola vez: ", ANCLA_JSX_APERTURA)
}
cuerpo_desde <- ini_jsx[1] + nchar(ANCLA_JSX_APERTURA)
resto        <- substr(plantilla, cuerpo_desde, nchar(plantilla))
fin_rel      <- regexpr(ANCLA_JSX_CIERRE, resto, fixed = TRUE)
if (fin_rel < 0) stop("El bloque JSX de la plantilla no tiene cierre.")
app_jsx <- substr(resto, 1L, fin_rel - 1L)
app_js  <- transpilar_jsx(app_jsx, babel_code)

plantilla <- paste0(
  substr(plantilla, 1L, ini_jsx[1] - 1L),
  "<script>\n", app_js, "\n  ",
  substr(resto, fin_rel, nchar(resto))
)

message(sprintf("    React:     %d caracteres", nchar(react_code)))
message(sprintf("    ReactDOM:  %d caracteres", nchar(reactdom_code)))
message(sprintf("    App JSX:   %d caracteres -> JS %d caracteres",
                nchar(app_jsx), nchar(app_js)))


# ============================================================================
# Bloque 4 — Reemplazar placeholders y escribir HTML
# ============================================================================

message("[4] Construyendo HTML final...")

# Validación: placeholders presentes.
if (!grepl("__D3_INLINE__", plantilla, fixed = TRUE)) {
  stop("La plantilla no contiene el placeholder __D3_INLINE__.")
}
if (!grepl("__PAKO_INLINE__", plantilla, fixed = TRUE)) {
  stop("La plantilla no contiene el placeholder __PAKO_INLINE__.")
}
if (!grepl("__JSON_DATA__", plantilla, fixed = TRUE)) {
  stop("La plantilla no contiene el placeholder __JSON_DATA__.")
}

# Reemplazo. Usar sub() con fixed=TRUE para evitar interpretación regex
# (los nombres de comuna pueden contener caracteres que regex confundiría).
# json_b64 es ASCII puro (base64), seguro dentro del literal "__JSON_DATA__".
html <- sub("__D3_INLINE__",   d3_code,   plantilla, fixed = TRUE)
html <- sub("__PAKO_INLINE__", pako_code, html,      fixed = TRUE)
html <- sub("__JSON_DATA__",   json_b64,  html,      fixed = TRUE)
html <- reemplazar_literal(html, "__REACT_INLINE__",    react_code)
html <- reemplazar_literal(html, "__REACTDOM_INLINE__", reactdom_code)

# Escribir como UTF-8.
ruta_salida <- here::here("40_salidas", "motor_comparacion.html")
con <- file(ruta_salida, open = "wb", encoding = "UTF-8")
writeBin(charToRaw(enc2utf8(html)), con)
close(con)

tamano_kb <- file.info(ruta_salida)$size / 1024
message(sprintf("    OK: %s (%.0f KB)",
                fs::path_rel(ruta_salida, here::here()),
                tamano_kb))

# Guardar métricas del resumen antes de liberar objetos grandes.
n_simce_rbd <- nrow(df_simce_rbd)

# Liberar objetos grandes antes del GC automático para evitar C stack overflow.
# json_str, json_b64 y html pueden superar 14 MB combinados en memoria.
rm(json_str, json_gzip, json_b64, html, d3_code, pako_code, plantilla,
   react_code, reactdom_code, babel_code, app_jsx, app_js, resto,
   simce_rbd_lst, df_simce_rbd)
gc(verbose = FALSE)


# ============================================================================
# Bloque 5 — Resumen
# ============================================================================

message("")
message("=== Resumen ===")
message(sprintf("  Filas en JSON: %d", datos_lst$rows))
message(sprintf("  Comunas:       %d", nrow(comunas_lst)))
message(sprintf("  Regiones:      %d", nrow(regiones_lst)))
message(sprintf("  SLEPs:         %d (%d RBDs)", dplyr::n_distinct(sleps_lst$cod_slep), nrow(sleps_lst)))
message(sprintf("  Establec.:     %d RBDs distintos", nrow(establecimientos_lst)))
message(sprintf("  RBDs×nivel:    %d filas (catálogo popup)", nrow(df_rbd_np)))
message(sprintf("  RBDs×GSE:      %d filas (catálogo popup celda)", nrow(df_rbd_gse)))
message(sprintf("  simce_rbd:     %d filas (datos por establecimiento)", n_simce_rbd))
message(sprintf("  Años:          %d (%s)", length(meta$anios),
                paste(meta$anios, collapse = ", ")))
message(sprintf("  Peso HTML:     %.1f KB", tamano_kb))
message("")
message(sprintf("33_generar_html.R: OK. Producto en %s",
                fs::path_rel(ruta_salida, here::here())))
