source(file.path("10_utils", "10_locale.R"))
asegurar_locale_utf8("50_sonda_catalogo")
# Sonda del encargo 20261111_modal_simbologia_sin_directorio. Solo lectura.
# Lee el JSON incrustado en un motor generado (argumento 1) y cuenta, sin usar
# funciones del pipeline, sobre el catalogo `simbologia`:
#   rows: filas declaradas; com, depe, grupo, nom: valores no nulos de cada
#   vector nuevo ("ausente" si el vector no existe); largos_iguales: TRUE si
#   todos los vectores del catalogo miden `rows`; sin_directorio: filas cuyo
#   RBD no esta en `establecimientos` del mismo JSON.
# Argumento 2 opcional, "plantar": quita en memoria el ultimo elemento de
# `nom` antes de contar (control positivo de FASE R).
args <- commandArgs(trailingOnly = TRUE)
stopifnot(length(args) >= 1L, file.exists(args[1]))
html <- paste(readLines(args[1], warn = FALSE, encoding = "UTF-8"), collapse = "\n")
b64 <- regmatches(html, regexpr('atob\\("[A-Za-z0-9+/=]+"\\)', html))
stopifnot(length(b64) == 1L)
b64 <- sub('^atob\\("', "", sub('"\\)$', "", b64))
J <- jsonlite::fromJSON(rawToChar(memDecompress(jsonlite::base64_dec(b64), type = "gzip")),
                        simplifyVector = TRUE)
C <- J$simbologia
stopifnot(!is.null(C), length(C$rbd) == C$rows)
if (length(args) >= 2L && args[2] == "plantar" && !is.null(C$nom)) C$nom <- C$nom[-length(C$nom)]
cuenta <- function(v) if (is.null(v)) "ausente" else as.character(sum(!is.na(v)))
vecs <- C[setdiff(names(C), "rows")]
largos <- all(vapply(vecs, length, integer(1)) == C$rows)
sin_dir <- sum(!(as.character(C$rbd) %in% as.character(J$establecimientos$rbd)))
cat(sprintf("cat: rows=%d com=%s depe=%s grupo=%s nom=%s largos_iguales=%s sin_directorio=%d\n",
            as.integer(C$rows), cuenta(C$com), cuenta(C$depe), cuenta(C$grupo), cuenta(C$nom),
            largos, sin_dir))
