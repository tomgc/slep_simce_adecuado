# =============================================================================
# 10_html.R — Utilidades comunes de los generadores de HTML (pasos 33 y 36)
# -----------------------------------------------------------------------------
# Las cargan 33_generar_html.R y 36_generar_trayectorias.R. Reúne lo que antes
# estaba copiado en ambos: el reemplazo literal de marcadores y la inserción del
# encabezado y el menú de vistas del sitio desde 30_procesamiento/
# 33_fragmento_sitio.html, su fuente única (deuda técnica de v33). Desde el
# encargo pendientes s35b también incrusta la tipografía gobCL (D33-4).
# =============================================================================

RUTA_FRAGMENTO_SITIO <- here::here("30_procesamiento", "33_fragmento_sitio.html")
MARCADOR_SITIO_CSS   <- "/*__SITIO_CSS__*/"
MARCADOR_SITIO_HTML  <- "<!--__SITIO_HTML__-->"
MARCADOR_FUENTES     <- "/*__FUENTES__*/"
PATRON_SITIO_RESTO   <- "__SITIO_[A-Z]+__|__HREF_[A-Z]+__|__FUENTES__"

# Tipografía del sitio (D33-4, pendiente 3 de v34): tres .otf de gobCL,
# vendorizados de terceros en 10_utils/fuentes/ con su nombre original. Cada
# uno se incrusta en base64 como una regla @font-face de la familia "gobCL" con
# su peso; insertar_sitio() se detiene si el md5 de un archivo no coincide con
# el declarado aquí (un .otf cambiado o corrupto no llega a las páginas).
CARPETA_FUENTES <- here::here("10_utils", "fuentes")
FUENTES_GOBCL <- data.frame(
  archivo = c("gobCL_Light.otf", "gobCL_Regular.otf", "gobCL_Heavy.otf"),
  peso    = c(300L, 400L, 700L),
  md5     = c("f5a622b0b5f209c9197b2acfd2e1e299",
              "0257bb4b62d5ec557627aa0136f1e1dc",
              "6f435f30d6a13092b7d5db5255dcca1b"),
  stringsAsFactors = FALSE
)
# Regla @font-face de cada archivo (peso, base64), terminada en salto de línea.
FORMATO_FONT_FACE <- paste0(
  '@font-face { font-family: "gobCL"; font-style: normal; font-weight: %d;\n',
  '  font-display: swap; src: url(data:font/otf;base64,%s) format("opentype"); }\n'
)

# Enlaces de las dos primeras entradas del menú según la página. En el motor
# cambian la dirección de la misma página; en la vista de trayectorias abren el
# motor (D33-2). La tercera entrada siempre abre trayectorias.html.
SITIO_PAGINAS <- list(
  motor = list(
    activa = "comparacion",
    hrefs  = c(COMPARACION = "#comparacion", PANORAMA = "#panorama")
  ),
  trayectorias = list(
    activa = "trayectorias",
    hrefs  = c(COMPARACION = "index.html", PANORAMA = "index.html#panorama")
  )
)

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

# Devuelve el texto entre los comentarios SITIO_<bloque>_INICIO y _FIN del
# fragmento, sin las líneas de los propios comentarios.
bloque_fragmento <- function(fragmento, bloque) {
  ini <- paste0("<!-- SITIO_", bloque, "_INICIO -->\n")
  fin <- paste0("\n<!-- SITIO_", bloque, "_FIN -->")
  p_ini <- gregexpr(ini, fragmento, fixed = TRUE)[[1]]
  p_fin <- gregexpr(fin, fragmento, fixed = TRUE)[[1]]
  if (length(p_ini) != 1L || p_ini[1] < 0 || length(p_fin) != 1L || p_fin[1] < p_ini[1]) {
    stop("El fragmento del sitio no trae una sola vez el bloque ", bloque)
  }
  substr(fragmento, p_ini + nchar(ini), p_fin - 1L)
}

# Devuelve las reglas @font-face de `fuentes` (por omisión FUENTES_GOBCL), una
# por archivo, con el .otf incrustado como data:font/otf;base64 en una sola
# línea. Se detiene, nombrando el archivo, si falta o si su md5 no coincide.
css_fuentes_gobcl <- function(carpeta = CARPETA_FUENTES, fuentes = FUENTES_GOBCL) {
  reglas <- vapply(seq_len(nrow(fuentes)), function(i) {
    archivo <- fuentes$archivo[[i]]
    ruta <- file.path(carpeta, archivo)
    if (!file.exists(ruta)) stop("Falta la fuente ", archivo, " en ", carpeta)
    md5 <- unname(tools::md5sum(ruta))
    if (!identical(md5, fuentes$md5[[i]])) {
      stop("md5 inesperado en la fuente ", archivo, ": ", md5,
           " (se esperaba ", fuentes$md5[[i]], ")")
    }
    # jsonlite::base64_enc() parte el resultado en líneas: se unen, y se
    # comprueba que solo quede el alfabeto base64.
    b64 <- gsub("[\r\n]", "", jsonlite::base64_enc(readBin(ruta, "raw", file.size(ruta))))
    if (grepl("[^A-Za-z0-9+/=]", b64)) stop("base64 inválido para la fuente ", archivo)
    sprintf(FORMATO_FONT_FACE, fuentes$peso[[i]], b64)
  }, character(1))
  paste(reglas, collapse = "")
}

# Inserta el estilo y el marcado del encabezado y del menú en `plantilla`,
# con los enlaces y la entrada activa de `pagina` ("motor" o "trayectorias"),
# y la tipografía gobCL en el marcador de fuentes del bloque CSS. Se detiene
# si falta un marcador, si queda alguno sin reemplazar o si una fuente no
# pasa la verificación de md5.
insertar_sitio <- function(plantilla, pagina) {
  cfg <- SITIO_PAGINAS[[pagina]]
  if (is.null(cfg)) stop("Página desconocida para el fragmento del sitio: ", pagina)

  fragmento <- paste(readLines(RUTA_FRAGMENTO_SITIO, encoding = "UTF-8", warn = FALSE),
                     collapse = "\n")
  css      <- bloque_fragmento(fragmento, "CSS")
  marcado  <- bloque_fragmento(fragmento, "HTML")
  css      <- reemplazar_literal(css, MARCADOR_FUENTES, css_fuentes_gobcl())

  for (nombre in names(cfg$hrefs)) {
    marcado <- reemplazar_literal(marcado, paste0("__HREF_", nombre, "__"), cfg$hrefs[[nombre]])
  }
  marcado <- reemplazar_literal(
    marcado,
    sprintf('class="view-tab" data-vista="%s"', cfg$activa),
    sprintf('class="view-tab is-active" aria-current="page" data-vista="%s"', cfg$activa)
  )

  html <- reemplazar_literal(plantilla, MARCADOR_SITIO_CSS, css)
  html <- reemplazar_literal(html, MARCADOR_SITIO_HTML, marcado)
  if (grepl(PATRON_SITIO_RESTO, html)) {
    stop("Quedaron marcadores del sitio sin reemplazar: ",
         paste(unique(regmatches(html, gregexpr(PATRON_SITIO_RESTO, html))[[1]]),
               collapse = ", "))
  }
  html
}
