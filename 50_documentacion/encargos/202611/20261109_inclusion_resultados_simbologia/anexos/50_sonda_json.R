source(file.path("10_utils", "10_locale.R"))
asegurar_locale_utf8("50_sonda_json")
# Sonda S2 (encargo 20261109_inclusion_resultados_simbologia). Solo lectura.
# Lee el JSON incrustado en un motor generado (argumento 1; por omision
# 40_salidas/motor_comparacion.html) y cuenta, sin usar funciones del pipeline:
#   cc_4b_<prueba>_2025: Costa Central en `datos` (cod_com 5103, 5105, 5107,
#     5109; cod_depe2 "5"; nivel 4b; anio 2025): suma de n_estab y n_evaluados
#   simce_rbd: filas de la tabla por establecimiento
#   simb: filas de simce_rbd con simb == 1 (o "ausente" si la columna no existe)
#   catalogo: filas del catalogo `simbologia` (o "ausente")
#   ceros_json: filas de simce_rbd con palu + palu_ele + palu_ins == 0
args <- commandArgs(trailingOnly = TRUE)
ruta <- if (length(args) >= 1L) args[1] else file.path("40_salidas", "motor_comparacion.html")
html <- paste(readLines(ruta, warn = FALSE, encoding = "UTF-8"), collapse = "\n")
b64 <- regmatches(html, regexpr('atob\\("[A-Za-z0-9+/=]+"\\)', html))
stopifnot(length(b64) == 1L)
b64 <- sub('^atob\\("', "", sub('"\\)$', "", b64))
crudo <- memDecompress(jsonlite::base64_dec(b64), type = "gzip")
J <- jsonlite::fromJSON(rawToChar(crudo), simplifyVector = TRUE)
d <- J$datos
stopifnot(length(d$cod_com) == d$rows)
filtro_cc <- d$cod_com %in% c("5103", "5105", "5107", "5109") & d$cod_depe2 == "5" &
  d$nivel == "4b" & d$anio == 2025L
for (p in c("lect", "mate")) {
  k <- filtro_cc & d$prueba == p
  cat(sprintf("cc_4b_%s_2025 %d %d\n", p, as.integer(sum(d$n_estab[k])), as.integer(sum(d$n_evaluados[k]))))
}
r <- J$simce_rbd
stopifnot(length(r$rbd) == r$rows)
cat(sprintf("simce_rbd %d\n", r$rows))
cat("simb ", if (is.null(r$simb)) "ausente" else as.character(sum(r$simb == 1L)), "\n", sep = "")
cat("catalogo ", if (is.null(J$simbologia)) "ausente" else as.character(length(J$simbologia$rbd)), "\n", sep = "")
cat(sprintf("ceros_json %d\n", sum((r$palu + r$palu_ele + r$palu_ins) == 0, na.rm = TRUE)))
