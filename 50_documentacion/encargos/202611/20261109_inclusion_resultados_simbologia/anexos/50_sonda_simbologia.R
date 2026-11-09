source(file.path("10_utils", "10_locale.R"))
asegurar_locale_utf8("50_sonda_simbologia")
# Sonda S1 (encargo 20261109_inclusion_resultados_simbologia). Solo lectura.
# Cuenta, desde los 18 xlsx y el directorio, sin usar funciones del pipeline:
#   validas: filas establecimiento x prueba con los tres porcentajes y suma 99-101
#   simb:    de esas, las que traen marca de la Agencia (simbologia adicional)
#   ceros:   filas con los tres porcentajes en 0 (no son resultados)
#   cc_<nivel>_<prueba>_<anio>: Costa Central (4 comunas, COD_DEPE2 5 del
#            directorio), establecimientos y evaluados, con y sin simbologia
#   codigos: valores distintos de la marca entre las filas validas con marca
archivos <- sort(list.files(file.path("20_insumos", "simce"), pattern = "^simce(2m|4b)[0-9]{4}_rbd_final[.]xlsx$",
                            recursive = TRUE, full.names = TRUE))
stopifnot(length(archivos) == 18L)
dir_ee <- utils::read.delim(file.path("20_insumos", "auxiliares", "directorio_oficial_ee.csv"), sep = ";",
                            fileEncoding = "UTF-8-BOM", colClasses = "character")
stopifnot(nrow(dir_ee) == length(readLines(file.path("20_insumos", "auxiliares", "directorio_oficial_ee.csv"),
                                           warn = FALSE)) - 1L)
cc <- dir_ee$RBD[dir_ee$COD_COM_RBD %in% c("5103", "5105", "5107", "5109") & dir_ee$COD_DEPE2 == "5"]
num <- function(x) suppressWarnings(as.numeric(gsub(",", ".", as.character(x), fixed = TRUE)))
validas <- 0L; simb <- 0L; ceros <- 0L; codigos <- character(0); cc_lineas <- character(0)
for (f in archivos) {
  m <- regmatches(basename(f), regexec("^simce(2m|4b)([0-9]{4})_", basename(f)))[[1]]
  nv <- m[2]; an <- m[3]
  d <- readxl::read_excel(f)
  names(d) <- trimws(tolower(names(d)))
  if (an == "2018" && nv == "4b") names(d) <- gsub("_2m_", "_4b_", names(d), fixed = TRUE)
  for (p in c("lect", "mate")) {
    sf <- paste0(p, nv, "_rbd")
    a <- num(d[[paste0("palu_eda_ade_", sf)]]); e <- num(d[[paste0("palu_eda_ele_", sf)]])
    i <- num(d[[paste0("palu_eda_ins_", sf)]]); n <- num(d[[paste0("nalu_", sf)]])
    mk <- d[[paste0("marca_", sf)]]
    s <- a + e + i
    v <- !is.na(s) & s >= 99 & s <= 101
    con_m <- v & !is.na(mk)
    validas <- validas + sum(v); simb <- simb + sum(con_m)
    ceros <- ceros + sum(!is.na(s) & s == 0)
    codigos <- union(codigos, unique(as.character(mk[con_m])))
    if (an == "2025" && nv == "4b") {
      en_cc <- v & as.character(d$rbd) %in% cc
      sin <- en_cc & is.na(mk)
      cc_lineas <- c(cc_lineas, sprintf("cc_%s_%s_%s %d %d %d %d", nv, p, an,
                                        sum(en_cc), as.integer(sum(n[en_cc])), sum(sin), as.integer(sum(n[sin]))))
    }
  }
}
cat(sprintf("validas %d\nsimb %d\nceros %d\n", validas, simb, ceros))
cat(cc_lineas, sep = "\n")
cat("codigos ", paste(sort(codigos), collapse = " | "), "\n", sep = "")
