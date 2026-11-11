source(file.path("10_utils", "10_locale.R"))
asegurar_locale_utf8("50_sonda_json_igual")
# Sonda del encargo 20261111_modal_simbologia_sin_directorio. Solo lectura.
# Compara el JSON de dos motores (argumentos 1 y 2) sin el catalogo
# `simbologia` ni meta$fecha_generacion, e imprime "igual TRUE" si coinciden.
# Prueba que el encargo no cambia ninguna cifra (🔒1). Argumento 3 opcional,
# "plantar": suma 1 al primer n_estab de `datos` del segundo motor en memoria
# antes de comparar (control positivo: tiene que imprimir "igual FALSE").
args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) %in% 2:3, all(file.exists(args[1:2])))
leer <- function(ruta) {
  html <- paste(readLines(ruta, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
  b64 <- regmatches(html, regexpr('atob\\("[A-Za-z0-9+/=]+"\\)', html))
  stopifnot(length(b64) == 1L)
  b64 <- sub('^atob\\("', "", sub('"\\)$', "", b64))
  J <- jsonlite::fromJSON(rawToChar(memDecompress(jsonlite::base64_dec(b64), type = "gzip")),
                          simplifyVector = FALSE)
  J$simbologia <- NULL
  J$meta$fecha_generacion <- NULL
  J
}
a <- leer(args[1]); b <- leer(args[2])
if (length(args) == 3L && args[3] == "plantar") b$datos$n_estab[[1]] <- b$datos$n_estab[[1]] + 1
cat(sprintf("igual %s\n", identical(a, b)))
cat(sprintf("claves %s\n", paste(sort(names(a)), collapse = ",")))
