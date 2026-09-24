# =============================================================================
# 10_html.R — Utilidades comunes de los generadores de HTML (pasos 33 y 36)
# -----------------------------------------------------------------------------
# Las cargan 33_generar_html.R y 36_generar_trayectorias.R. Reúne lo que antes
# estaba copiado en ambos: el reemplazo literal de marcadores y la inserción del
# encabezado y el menú de vistas del sitio desde 30_procesamiento/
# 33_fragmento_sitio.html, su fuente única (deuda técnica de v33).
# =============================================================================

RUTA_FRAGMENTO_SITIO <- here::here("30_procesamiento", "33_fragmento_sitio.html")
MARCADOR_SITIO_CSS   <- "/*__SITIO_CSS__*/"
MARCADOR_SITIO_HTML  <- "<!--__SITIO_HTML__-->"
PATRON_SITIO_RESTO   <- "__SITIO_[A-Z]+__|__HREF_[A-Z]+__"

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

# Inserta el estilo y el marcado del encabezado y del menú en `plantilla`,
# con los enlaces y la entrada activa de `pagina` ("motor" o "trayectorias").
# Se detiene si falta un marcador o si queda alguno sin reemplazar.
insertar_sitio <- function(plantilla, pagina) {
  cfg <- SITIO_PAGINAS[[pagina]]
  if (is.null(cfg)) stop("Página desconocida para el fragmento del sitio: ", pagina)

  fragmento <- paste(readLines(RUTA_FRAGMENTO_SITIO, encoding = "UTF-8", warn = FALSE),
                     collapse = "\n")
  css      <- bloque_fragmento(fragmento, "CSS")
  marcado  <- bloque_fragmento(fragmento, "HTML")

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
