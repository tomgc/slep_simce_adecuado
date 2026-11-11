source(file.path("10_utils", "10_locale.R"))
asegurar_locale_utf8("50_sonda_catalogo_alt")
# Re-derivacion de FASE R (encargo 20261111_modal_simbologia_sin_directorio).
# Solo lectura. Misma salida que 50_sonda_catalogo.R, por otra via: el JSON se
# lee sin simplificar (listas) y cada conteo se hace elemento por elemento.
args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) >= 1L, file.exists(args[1]))
html <- paste(readLines(args[1], warn = FALSE, encoding = "UTF-8"), collapse = "\n")
stopifnot(grepl('atob("', html, fixed = TRUE))
b64 <- sub('(?s)^.*?atob\\("([^"]+)"\\).*$', "\\1", html, perl = TRUE)
J <- jsonlite::fromJSON(rawToChar(memDecompress(jsonlite::base64_dec(b64), type = "gzip")),
                        simplifyVector = FALSE)
C <- J$simbologia
n <- as.integer(C$rows)
no_nulos <- function(v) if (is.null(v)) "ausente" else as.character(sum(!vapply(v, is.null, logical(1))))
vecs <- C[setdiff(names(C), "rows")]
largos <- all(vapply(vecs, length, integer(1)) == n)
dir_rbd <- vapply(J$establecimientos, function(r) as.character(r$rbd), character(1))
cat_rbd <- vapply(C$rbd, as.character, character(1))
cat(sprintf("cat: rows=%d com=%s depe=%s grupo=%s nom=%s largos_iguales=%s sin_directorio=%d\n",
            n, no_nulos(C$com), no_nulos(C$depe), no_nulos(C$grupo), no_nulos(C$nom),
            largos, sum(!(cat_rbd %in% dir_rbd))))
