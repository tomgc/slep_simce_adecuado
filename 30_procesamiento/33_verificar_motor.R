# 33_verificar_motor.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Batería de verificación del motor de comparación (paso 33).
#
# Hasta el encargo s35l, lo que las sesiones s35f a s35i midieron en el motor
# (desborde a 375 px, modal, supergrid, tooltip y PNG con gobCL) se midió con
# scripts verificar_*.R que git ignora: una regresión no la detectaba ninguna
# prueba del repositorio. Esta batería convierte esos criterios en pruebas
# versionadas, con la estructura de 36_verificar_trayectorias.R.
#
# Cada prueba lleva su control positivo dentro: pasa solo si el motor cumple su
# regla y si la misma medición detecta un defecto plantado (un valor, un cambio
# en la página abierta o un HTML de control en tempdir()). El detalle de cada
# línea dice las dos cosas.
#
#   M1  Sin carga por red (patrón de I-2 del encargo s35h).
#   M2  Ningún marcador del proyecto sin sustituir; la lista se lee de las
#       fuentes, porque la salida trae __PURE__ y __REACT_DEVTOOLS_GLOBAL_HOOK__.
#   M3  meta$anios es la lista de años de los nombres de archivo de
#       20_insumos/simce/, sin ANIOS_SIN_SIMCE.
#   M4  Sin desborde horizontal en #comparacion y #panorama a 375, 768 y
#       1280 px (I-8 de s35h).
#   M5  El modal «Agregar territorio» cabe en la ventana a 375 px en sus 6
#       pestañas (Q-55; M1 de s35h).
#   M6  Con 5 territorios, ningún texto del supergrid sale de su celda a 375,
#       641, 670 y 700 px (Q-34 y Q-66; M2 de s35h y M5 de s35i).
#   M7  A 375 px, el tooltip no tapa el punto en los casos de G3 de s35g (Q-54).
#   M8  El PNG exportado del supergrid usa gobCL-sitio (Q-31; M4 de s35h).
#
# Insumos:  40_salidas/motor_comparacion.html (correr antes el paso 33), o la
#           ruta que se pase como primer argumento;
#           20_insumos/simce/{2m,4b}/ (M3);
#           30_procesamiento/33_motor_template.html, 33_fragmento_sitio.html y
#           10_utils/10_html.R (M2).
# Requiere: chromote y Chrome (M4 a M8 leen el motor en el navegador).
# Salida:   el informe en consola, una línea por prueba. No escribe archivos en
#           el árbol; M7 y M8 escriben un HTML de control en tempdir() y lo
#           borran al leerlo.
#
# Uso:      Rscript 30_procesamiento/33_verificar_motor.R [ruta_del_motor]
#           (código de salida 1 si alguna prueba falla)
# ----------------------------------------------------------------------------

suppressPackageStartupMessages(library(here))
source(here::here("10_utils", "10_configuracion.R"))  # guarda de locale UTF-8 (POLITICA 5.2bis), ANIOS_SIN_SIMCE
source(here::here("10_utils", "10_html.R"))           # PATRON_ANIO_RESTO, PATRON_SITIO_RESTO (M2)

inicio_bateria <- Sys.time()
args <- commandArgs(trailingOnly = TRUE)
RUTA_MOTOR <- if (length(args) >= 1) args[[1]] else
  here::here("40_salidas", "motor_comparacion.html")
if (!file.exists(RUTA_MOTOR)) stop("No existe el motor: ", RUTA_MOTOR)

# ---- Constantes ----------------------------------------------------------------

# M1: los dos patrones de carga por red de I-2 (encargo s35h).
PATRONES_RED <- c(src = "src=[\"']?(https?:)?//", url = "url\\(http")
# M2: fuentes de los marcadores del motor y forma de un marcador.
FUENTES_MARCADORES <- c(here::here("30_procesamiento", "33_motor_template.html"),
                        here::here("30_procesamiento", "33_fragmento_sitio.html"))
PATRON_MARCADOR <- "__[A-Z0-9_]+__"
# M3: nombre de los xlsx Simce (el del paso 31) y el bloque de datos del motor.
CARPETA_SIMCE        <- here::here("20_insumos", "simce")
PATRON_ARCHIVO_SIMCE <- "^simce(2m|4b)(\\d{4})_rbd_(final|preliminar)\\.xlsx$"
PATRON_JSON_MOTOR    <- 'Uint8Array\\.from\\(atob\\("([A-Za-z0-9+/=]+)"\\)'
# Navegador: alto por omisión, esperas y condiciones de «el motor dibujó».
ALTO_VENTANA           <- 900L
ESPERA_MAX_S           <- 20
# Bajo este ancho los medidores de s35h y s35i esperaban más tras cargar, hasta
# que el supergrid y las sparklines se asientan.
CORTE_ANGOSTA_PX       <- 640L
ESPERA_CARGA_ANGOSTA_S <- 6
ESPERA_CARGA_ANCHA_S   <- 2
ESPERA_CAMBIO_ANCHO_S  <- 0.6
ESPERA_CLIC_S          <- 0.5
TOL_PX                 <- 0.01   # px CSS: ruido de coma flotante de getBoundingClientRect
JS_ESPERA_COMPARACION  <- "document.querySelectorAll('svg.sparkline-svg circle').length > 0"
JS_ESPERA_PANORAMA     <- "!!document.querySelector('.hero-card')"
# M4
ANCHOS_DESBORDE     <- c(375L, 768L, 1280L)
ANCHO_CONTROL_DESBORDE <- 3000L   # ancho del bloque plantado en el control
# M5
ANCHO_MODAL     <- 375L
ALTO_MODAL      <- 740L
PESTANAS_MODAL  <- c("Establecimiento", "Comuna", "SLEP", "Región", "Nacional", "Grupo personalizado")
MIN_ANCHO_MODAL_CONTROL <- "540px"   # el min-width del modal antes de Q-55
# M6
N_TERRITORIOS    <- 5L                # tope del motor (D35-14)
PESTANA_AGREGAR  <- "SLEP"
ANCHOS_SUPERGRID <- c(375L, 641L, 670L, 700L)
ANCHO_CONTROL_SUPERGRID <- 641L       # primer ancho sobre el corte de 640 px de antes de Q-66
# M7
ANCHO_TOOLTIP <- 375L
ALTO_TOOLTIP  <- 740L
MARGEN_TAPA   <- 4       # px: el punto no puede quedar a menos de esto del tooltip (G3 de s35g)
MARGEN_ABAJO  <- 20      # px: la barra «de abajo» queda con su centro a esto del borde inferior
PATRON_TOOLTIP_DIMS <- "TOOLTIP_DIMS = \\{\\s*desplaz:\\s*([0-9.]+),\\s*margen:\\s*([0-9.]+)\\s*\\}"
CASOS_TOOLTIP <- list(   # caso, columna, fila, elemento, ubicación (G3 de s35g)
  list("spark_ult", "ult", "pri", "spark", "centro"),
  list("barra_ult", "ult", "pri", "barra", "centro"),
  list("spark_pri", "pri", "pri", "spark", "centro"),
  list("barra_pri", "pri", "pri", "barra", "centro"),
  list("barra_abajo_pri", "pri", "ult", "barra", "abajo"),
  list("barra_abajo_ult", "ult", "ult", "barra", "abajo"))
CASOS_TOOLTIP_CONTROL <- "barra_pri"   # el caso que tapaba el punto antes de G3
FRAGMENTO_REGLA_G3 <- "if (!cabeDer && !cabeIzq) {"
# M8
ANCHO_PNG <- 1280L
TOL_TINTA_PX <- 2        # px de PNG
FRAGMENTO_FUENTE_PNG <- "new Blob([svgConFuenteSitio(svgStr)]"
ESPERA_EXPORTAR_S <- 20

# ---- Informe ---------------------------------------------------------------------

resultados <- new.env(parent = emptyenv())
resultados$filas <- list()

comprobar <- function(id, descripcion, condicion, detalle = "") {
  estado <- if (isTRUE(condicion)) "PASA" else "FALLA"
  resultados$filas[[length(resultados$filas) + 1]] <-
    data.frame(id = id, estado = estado, descripcion = descripcion, detalle = detalle)
  cat(sprintf("%-6s %-5s %s%s\n", id, estado, descripcion,
              if (nzchar(detalle)) paste0(" (", detalle, ")") else ""))
  invisible(isTRUE(condicion))
}

intentar <- function(expr) tryCatch(expr, error = function(e) e)
es_error <- function(x) inherits(x, "error")
mensaje  <- function(x) if (es_error(x)) paste("error:", conditionMessage(x)) else ""

leer_texto <- function(ruta) paste(readLines(ruta, encoding = "UTF-8", warn = FALSE), collapse = "\n")
html <- leer_texto(RUTA_MOTOR)
cat(sprintf("Motor: %s (%d caracteres)\n\n", RUTA_MOTOR, nchar(html)))

# Escribe en tempdir() una copia del motor con `buscar` (que debe aparecer una
# sola vez) cambiado por `reemplazo`, y devuelve su ruta.
motor_de_control <- function(buscar, reemplazo) {
  pos <- gregexpr(buscar, html, fixed = TRUE)[[1]]
  if (length(pos) != 1L || pos[1] < 0) {
    stop("el fragmento a cambiar no aparece una sola vez en el motor: ", buscar)
  }
  ruta <- tempfile(fileext = ".html")
  writeBin(charToRaw(enc2utf8(paste0(
    substr(html, 1L, pos - 1L), reemplazo, substr(html, pos + nchar(buscar), nchar(html))
  ))), ruta)
  ruta
}
# Aplica `f` a un motor de control (motor_de_control()) y lo borra al terminar.
con_control <- function(buscar, reemplazo, f) {
  ruta_ctl <- motor_de_control(buscar, reemplazo)
  on.exit(unlink(ruta_ctl), add = TRUE)
  f(ruta_ctl)
}

# ---- Navegador (chromote) ----------------------------------------------------------

js <- function(s, expr, await = TRUE) {
  r <- s$Runtime$evaluate(expr, returnByValue = TRUE, awaitPromise = await)
  if (!is.null(r$exceptionDetails)) {
    stop("JavaScript: ", r$exceptionDetails$exception$description %||% r$exceptionDetails$text)
  }
  r$result$value
}
`%||%` <- function(a, b) if (is.null(a)) b else a
js_json <- function(s, expr) jsonlite::fromJSON(js(s, expr), simplifyVector = TRUE)
cuadro <- function(s) js(s, "new Promise(r => requestAnimationFrame(() => requestAnimationFrame(() => r(true))))")
esperar <- function(s, expr, max_s = ESPERA_MAX_S) {
  t0 <- Sys.time()
  repeat {
    if (isTRUE(tryCatch(js(s, expr), error = function(e) FALSE))) return(invisible(TRUE))
    if (as.numeric(difftime(Sys.time(), t0, units = "secs")) > max_s) stop("tiempo agotado esperando: ", expr)
    Sys.sleep(0.1)
  }
}
# Ventana de `ancho` × `alto` px CSS, escala 1, no móvil y barras de
# desplazamiento ocultas: Chrome sin interfaz reserva 15 px para una barra
# clásica, y macOS usa barras superpuestas, que no restan ancho.
fijar_ventana <- function(s, ancho, alto) {
  s$Emulation$setScrollbarsHidden(hidden = TRUE)
  s$Emulation$setDeviceMetricsOverride(width = as.integer(ancho), height = as.integer(alto),
                                       deviceScaleFactor = 1, mobile = FALSE)
  invisible(s)
}
cambiar_ancho <- function(s, ancho, alto) {
  fijar_ventana(s, ancho, alto); cuadro(s); Sys.sleep(ESPERA_CAMBIO_ANCHO_S); cuadro(s)
}
# Abre `ruta` (con `hash`) a un tamaño dado y espera a que el motor dibuje y
# cargue sus fuentes. Hay que cerrarla con s$close().
abrir_motor <- function(ruta, ancho, alto = ALTO_VENTANA, hash = "", esperar_js = JS_ESPERA_COMPARACION) {
  if (!requireNamespace("chromote", quietly = TRUE)) stop("falta el paquete chromote")
  s <- chromote::ChromoteSession$new(width = as.integer(ancho), height = as.integer(alto))
  ok <- FALSE
  on.exit(if (!ok) try(s$close(), silent = TRUE), add = TRUE)
  fijar_ventana(s, ancho, alto)
  cargada <- s$Page$loadEventFired(wait_ = FALSE)
  s$Page$navigate(paste0("file://", normalizePath(ruta, mustWork = TRUE), hash), wait_ = FALSE)
  s$wait_for(cargada)
  esperar(s, esperar_js)
  js(s, "document.fonts.ready.then(() => true)")
  Sys.sleep(if (ancho <= CORTE_ANGOSTA_PX) ESPERA_CARGA_ANGOSTA_S else ESPERA_CARGA_ANCHA_S)
  cuadro(s)
  ok <- TRUE
  s
}
con_motor <- function(ruta, ancho, alto, f, ...) {
  s <- abrir_motor(ruta, ancho, alto, ...)
  on.exit(try(s$close(), silent = TRUE), add = TRUE)
  f(s)
}
# Clic real (Input.dispatchMouseEvent) en un punto de la ventana.
mover <- function(s, x, y) { s$Input$dispatchMouseEvent(type = "mouseMoved", x = x, y = y); cuadro(s) }
clic <- function(s, x, y) {
  s$Input$dispatchMouseEvent(type = "mouseMoved", x = x, y = y)
  s$Input$dispatchMouseEvent(type = "mousePressed", x = x, y = y, button = "left", clickCount = 1L)
  s$Input$dispatchMouseEvent(type = "mouseReleased", x = x, y = y, button = "left", clickCount = 1L)
  cuadro(s)
}

# ---- M1. Sin carga por red ---------------------------------------------------------

contar_red <- function(texto) {
  vapply(PATRONES_RED, function(p) length(regmatches(texto, gregexpr(p, texto, perl = TRUE))[[1]]), integer(1))
}
m1_real <- contar_red(html)
m1_ctl  <- contar_red(paste0('<script src="https://x.y/z.js"></script>',
                             '<style>a{background:url(http://x.y/f.png)}</style>'))
m1_ok_real <- all(m1_real == 0L)
m1_ctl_detecta <- all(m1_ctl >= 1L)
comprobar(
  "M1", "El motor no carga nada por red",
  m1_ok_real && m1_ctl_detecta,
  sprintf("src=//: %d, url(http: %d; control con un <script src=\"https://…\"> y un url(http://…) plantados: %d y %d, %s",
          m1_real[["src"]], m1_real[["url"]], m1_ctl[["src"]], m1_ctl[["url"]],
          if (m1_ctl_detecta) "FALLA, detectado" else "no detectado")
)

# ---- M2. Ningún marcador del proyecto sin sustituir ---------------------------------

marcadores <- sort(unique(unlist(lapply(FUENTES_MARCADORES, function(r) {
  t <- leer_texto(r); regmatches(t, gregexpr(PATRON_MARCADOR, t))[[1]]
}))))
patrones_resto <- c(PATRON_ANIO_RESTO = PATRON_ANIO_RESTO, PATRON_SITIO_RESTO = PATRON_SITIO_RESTO)
marcadores_en <- function(texto) {
  c(marcadores[vapply(marcadores, function(m) grepl(m, texto, fixed = TRUE), logical(1))],
    names(patrones_resto)[vapply(patrones_resto, function(p) grepl(p, texto), logical(1))])
}
m2_real <- marcadores_en(html)
m2_ctl  <- marcadores_en("__JSON_DATA__ __ANIO_MIN_ __HREF_X__")
ajenos <- table(regmatches(html, gregexpr(PATRON_MARCADOR, html))[[1]])
ajenos <- ajenos[!names(ajenos) %in% marcadores]
m2_ctl_detecta <- all(c("__JSON_DATA__", "PATRON_ANIO_RESTO", "PATRON_SITIO_RESTO") %in% m2_ctl)
comprobar(
  "M2", "Ningún marcador del proyecto queda sin sustituir (lista leída de la plantilla, el fragmento y 10_html.R)",
  length(marcadores) > 0 && length(m2_real) == 0 && m2_ctl_detecta,
  sprintf("%d marcadores de las fuentes y 2 patrones de resto; en el motor: %s; control con __JSON_DATA__, __ANIO_MIN_ y __HREF_X__ plantados: %s; ajenos presentes, fuera de la lista: %s",
          length(marcadores), if (length(m2_real)) paste(m2_real, collapse = ", ") else "ninguno",
          if (m2_ctl_detecta) paste("FALLA, detectados", paste(m2_ctl, collapse = ", ")) else "no detectado",
          if (length(ajenos)) paste(sprintf("%s %d", names(ajenos), as.integer(ajenos)), collapse = ", ") else "ninguno")
)

# ---- M3. meta$anios sale de los nombres de archivo -----------------------------------

extraer_json_motor <- function(texto) {
  m <- regmatches(texto, gregexpr(PATRON_JSON_MOTOR, texto))[[1]]
  if (length(m) != 1L) stop("se esperaba un bloque de datos en el motor; hay ", length(m))
  t <- rawToChar(memDecompress(jsonlite::base64_dec(sub(PATRON_JSON_MOTOR, "\\1", m)), type = "gzip"))
  Encoding(t) <- "UTF-8"
  jsonlite::fromJSON(t, simplifyVector = FALSE)
}
nombres_xlsx <- basename(list.files(CARPETA_SIMCE, pattern = "\\.xlsx$", recursive = TRUE))
anios_archivos <- sort(unique(as.integer(sub(PATRON_ARCHIVO_SIMCE, "\\2",
                                             grep(PATRON_ARCHIVO_SIMCE, nombres_xlsx, value = TRUE)))))
anios_esperados <- setdiff(anios_archivos, ANIOS_SIN_SIMCE)
anios_correctos <- function(a) identical(as.integer(a), anios_esperados) && !any(a %in% ANIOS_SIN_SIMCE)
meta_motor <- intentar(extraer_json_motor(html)$meta)
m3_anios <- if (es_error(meta_motor)) integer() else as.integer(unlist(meta_motor$anios))
m3_ctl <- list(sin_simce = sort(c(m3_anios, ANIOS_SIN_SIMCE[1])), falta = utils::head(m3_anios, -1))
m3_ctl_detecta <- !anios_correctos(m3_ctl$sin_simce) && !anios_correctos(m3_ctl$falta)
comprobar(
  "M3", "meta$anios es la lista de años de los nombres de archivo de 20_insumos/simce/, sin ANIOS_SIN_SIMCE",
  !es_error(meta_motor) && length(anios_esperados) > 0 && anios_correctos(m3_anios) && m3_ctl_detecta,
  sprintf("%d xlsx, años %s; meta$anios %s%s; control con %d agregado y con el último quitado: %s",
          length(nombres_xlsx), paste(anios_esperados, collapse = ", "),
          if (length(m3_anios)) paste(m3_anios, collapse = ", ") else "(vacío)", mensaje(meta_motor),
          ANIOS_SIN_SIMCE[1], if (m3_ctl_detecta) "FALLA, detectado" else "no detectado")
)

# ---- M4. Sin desborde horizontal a 375, 768 y 1280 px --------------------------------

JS_DESBORDE <- paste0("JSON.stringify({sw: document.documentElement.scrollWidth, ",
                      "cw: document.documentElement.clientWidth, vw: window.innerWidth})")
JS_PLANTAR_DESBORDE <- sprintf(paste0(
  "(() => { const d = document.createElement('div'); d.id = 'control-desborde'; ",
  "d.style.cssText = 'width:%dpx;height:1px'; document.body.appendChild(d); return true; })()"),
  ANCHO_CONTROL_DESBORDE)
JS_QUITAR_DESBORDE <- "(() => { document.getElementById('control-desborde').remove(); return true; })()"
desborda <- function(m) m$sw > m$vw || m$sw > m$cw
m4 <- list(); m4_ctl <- NULL
for (vista in c("comparacion", "panorama")) {
  for (ancho in ANCHOS_DESBORDE) {
    r <- intentar(con_motor(RUTA_MOTOR, ancho, ALTO_VENTANA, function(s) {
      m <- js_json(s, JS_DESBORDE)
      if (vista == "comparacion" && ancho == min(ANCHOS_DESBORDE)) {
        js(s, JS_PLANTAR_DESBORDE); cuadro(s)
        m4_ctl <<- js_json(s, JS_DESBORDE)
        js(s, JS_QUITAR_DESBORDE)
      }
      m
    }, hash = if (vista == "panorama") "#panorama" else "",
       esperar_js = if (vista == "panorama") JS_ESPERA_PANORAMA else JS_ESPERA_COMPARACION))
    m4[[length(m4) + 1]] <- list(vista = vista, ancho = ancho, m = r)
  }
}
m4_desc <- vapply(m4, function(x) {
  if (es_error(x$m)) sprintf("%s %d: %s", x$vista, x$ancho, mensaje(x$m))
  else sprintf("%s %d: %d/%d", x$vista, x$ancho, x$m$sw, x$m$vw)
}, character(1))
m4_ok_real <- all(vapply(m4, function(x) !es_error(x$m) && !desborda(x$m), logical(1)))
m4_ctl_detecta <- !is.null(m4_ctl) && desborda(m4_ctl)
comprobar(
  "M4", "Sin desborde horizontal en #comparacion y #panorama a 375, 768 y 1280 px (scrollWidth del documento = ancho de la ventana)",
  m4_ok_real && m4_ctl_detecta,
  sprintf("%s; control con un bloque de %d px plantado (comparacion %d): %s",
          paste(m4_desc, collapse = "; "), ANCHO_CONTROL_DESBORDE, min(ANCHOS_DESBORDE),
          if (is.null(m4_ctl)) "sin medida" else sprintf("%d/%d, %s", m4_ctl$sw, m4_ctl$vw,
                                                          if (m4_ctl_detecta) "FALLA, detectado" else "no detectado"))
)

# ---- M5. El modal cabe en la ventana a 375 px ------------------------------------------

# Elementos del modal (el .modal y sus descendientes con caja) cuya caja visible
# (recortada por los antepasados del modal que recortan su desborde) sale de la
# ventana; una caja recortada del todo (oculta en un contenedor con
# desplazamiento) no cuenta. Pie: «Cancelar» y «Agregar…» dentro del modal y de
# la ventana. Medidor de M1 del encargo s35h.
JS_MODAL <- sprintf("(() => {
  const TOL = %s, vw = window.innerWidth, vh = window.innerHeight;
  const modal = document.querySelector('.modal');
  if (!modal) return JSON.stringify({ modal: false });
  const recorte = (e) => {
    const r = e.getBoundingClientRect(); let x0 = r.left, x1 = r.right, y0 = r.top, y1 = r.bottom;
    for (let p = e.parentElement; p && modal.contains(p); p = p.parentElement) {
      const cs = getComputedStyle(p);
      if (cs.overflowX !== 'visible' || cs.overflowY !== 'visible') {
        const q = p.getBoundingClientRect();
        if (cs.overflowX !== 'visible') { x0 = Math.max(x0, q.left); x1 = Math.min(x1, q.right); }
        if (cs.overflowY !== 'visible') { y0 = Math.max(y0, q.top); y1 = Math.min(y1, q.bottom); }
      }
    }
    return { x0, x1, vacio: x1 - x0 <= 0 || y1 - y0 <= 0 };
  };
  let n = 0, fuera = 0;
  for (const e of [modal, ...modal.querySelectorAll('*')]) {
    const r = e.getBoundingClientRect();
    if ((r.width === 0 && r.height === 0) || getComputedStyle(e).display === 'none') continue;
    n++; const v = recorte(e);
    if (!v.vacio && (v.x0 < -TOL || v.x1 > vw + TOL)) fuera++;
  }
  const m = modal.getBoundingClientRect();
  const pie = Array.from(document.querySelectorAll('.modal-footer .btn')).map(b => { const r = b.getBoundingClientRect();
    return r.left >= m.left - TOL && r.right <= m.right + TOL && r.top >= m.top - TOL && r.bottom <= m.bottom + TOL &&
           r.left >= -TOL && r.right <= vw + TOL && r.top >= -TOL && r.bottom <= vh + TOL; });
  return JSON.stringify({ modal: true, n, fuera, pie_ok: pie.length === 2 && pie.every(x => x),
                          izq: m.left, der: m.right });
})()", TOL_PX)
js_pestana <- function(p) sprintf("Array.from(document.querySelectorAll('.modal .modal-tab')).find(b => b.textContent.trim() === %s)",
                                  jsonlite::toJSON(p, auto_unbox = TRUE))
abrir_modal <- function(s) {
  js(s, "window.scrollTo(0, 0)"); cuadro(s)
  js(s, "document.querySelector('.entities-actions .btn-primary').click()")
  esperar(s, "!!document.querySelector('.modal .modal-tab')", 10)
  Sys.sleep(ESPERA_CLIC_S); cuadro(s)
}
m5_ctl <- NULL
m5 <- intentar(con_motor(RUTA_MOTOR, ANCHO_MODAL, ALTO_MODAL, function(s) {
  abrir_modal(s)
  filas <- lapply(PESTANAS_MODAL, function(p) {
    q <- js_pestana(p)
    js(s, sprintf("%s.scrollIntoView({ block: 'nearest', inline: 'nearest' })", q)); cuadro(s)
    c0 <- js_json(s, sprintf("(() => { const r = %s.getBoundingClientRect(); return JSON.stringify({ x: r.left + r.width / 2, y: r.top + r.height / 2 }); })()", q))
    en_ventana <- c0$x >= 0 && c0$x <= ANCHO_MODAL && c0$y >= 0 && c0$y <= ALTO_MODAL
    if (en_ventana) clic(s, c0$x, c0$y)
    Sys.sleep(ESPERA_CLIC_S); cuadro(s)
    m <- js_json(s, JS_MODAL)
    data.frame(pestana = p, activa = isTRUE(js(s, sprintf("%s.classList.contains('is-active')", q))),
               fuera = m$fuera, pie_ok = isTRUE(m$pie_ok), izq = round(m$izq, 2), der = round(m$der, 2))
  })
  # Control: el min-width de antes de Q-55, plantado en la página abierta.
  js(s, sprintf("document.querySelector('.modal').style.minWidth = '%s'", MIN_ANCHO_MODAL_CONTROL)); cuadro(s)
  m5_ctl <<- js_json(s, JS_MODAL)
  js(s, "document.querySelector('.modal').style.minWidth = ''")
  do.call(rbind, filas)
}))
m5_ok_real <- !es_error(m5) && nrow(m5) == length(PESTANAS_MODAL) &&
  all(m5$activa) && all(m5$fuera == 0) && all(m5$pie_ok)
m5_ctl_detecta <- !is.null(m5_ctl) && isTRUE(m5_ctl$fuera > 0)
comprobar(
  "M5", "El modal «Agregar territorio» cabe en la ventana a 375 px en sus 6 pestañas",
  m5_ok_real && m5_ctl_detecta,
  if (es_error(m5)) mensaje(m5) else sprintf(
    "pestañas activas tras el clic %d/%d; elementos fuera de la ventana %s; pie visible %d/%d; modal de %.2f a %.2f px; control con min-width %s plantado: %s",
    sum(m5$activa), nrow(m5), paste(m5$fuera, collapse = "/"), sum(m5$pie_ok), nrow(m5),
    min(m5$izq), max(m5$der), MIN_ANCHO_MODAL_CONTROL,
    if (is.null(m5_ctl)) "sin medida" else sprintf("%d elementos fuera, %s", m5_ctl$fuera,
                                                    if (m5_ctl_detecta) "FALLA, detectado" else "no detectado"))
)

# ---- M6. Con 5 territorios, ningún texto del supergrid sale de su celda ------------------

# Nodos de texto HTML del supergrid (fuera de los SVG) con alguna caja de línea
# que sale de su celda (el hijo directo de .supergrid que lo contiene). Medidor
# de M2 del encargo s35h y M5 de s35i.
JS_SUPERGRID <- sprintf("(() => {
  const TOL = %s, sg = document.querySelector('.supergrid');
  const celdaDe = (n) => { let e = n.parentElement; while (e && e.parentElement !== sg) e = e.parentElement; return e; };
  const w = document.createTreeWalker(sg, NodeFilter.SHOW_TEXT); const rg = document.createRange();
  let textos = 0; const fuera = [];
  for (let n = w.nextNode(); n; n = w.nextNode()) {
    if (!n.textContent.trim() || n.parentElement.closest('svg')) continue;
    const c = celdaDe(n); if (!c) continue;
    const cr = c.getBoundingClientRect(); rg.selectNodeContents(n); textos++;
    let sobra = -1e9, sale = false;
    for (const q of Array.from(rg.getClientRects()).filter(q => q.width > 0)) {
      if (q.right > cr.right + TOL || q.left < cr.left - TOL) sale = true;
      sobra = Math.max(sobra, q.right - cr.right);
    }
    if (sale) fuera.push(n.textContent.trim().slice(0, 30) + ' (+' + sobra.toFixed(2) + ')');
  }
  return JSON.stringify({ textos, fuera, vw: innerWidth,
    territorios: document.querySelectorAll('.supergrid-entity-head').length,
    nombres: Array.from(document.querySelectorAll('.sg-ent-name')).map(e => e.textContent).join(' | ') });
})()", TOL_PX)
# Agrega territorios hasta `n` por el modal, pestaña PESTANA_AGREGAR, con las
# primeras casillas habilitadas (el camino de los medidores de s35h y s35i).
fijar_territorios <- function(s, n) {
  n0 <- js(s, "document.querySelectorAll('.supergrid-entity-head').length")
  if (n > n0) {
    abrir_modal(s)
    js(s, sprintf("%s.click()", js_pestana(PESTANA_AGREGAR)))
    esperar(s, "document.querySelectorAll('.modal .check-row input').length > 0", 10); cuadro(s)
    js(s, sprintf("(() => { const c = Array.from(document.querySelectorAll('.modal .check-row input')).filter(i => !i.disabled && !i.checked).slice(0, %d); c.forEach(i => i.click()); return c.length; })()", n - n0))
    cuadro(s); Sys.sleep(ESPERA_CLIC_S)
    js(s, "Array.from(document.querySelectorAll('.modal .btn')).find(b => /Agregar al an/.test(b.textContent)).click()")
    cuadro(s); Sys.sleep(ESPERA_CLIC_S)
  }
  esperar(s, sprintf("document.querySelectorAll('.supergrid-entity-head').length === %d", n), 10)
  Sys.sleep(ESPERA_CARGA_ANCHA_S); cuadro(s)
}
m6_ctl <- NULL
m6 <- intentar(con_motor(RUTA_MOTOR, ANCHOS_SUPERGRID[1], ALTO_VENTANA, function(s) {
  fijar_territorios(s, N_TERRITORIOS)
  filas <- lapply(ANCHOS_SUPERGRID, function(w) {
    cambiar_ancho(s, w, ALTO_VENTANA)
    m <- js_json(s, JS_SUPERGRID)
    if (w == ANCHO_CONTROL_SUPERGRID) {
      # Control: el supergrid sin su ancho mínimo de columna (antes de Q-66, sobre 640 px).
      js(s, "document.documentElement.style.setProperty('--supergrid-col-min', '0px')"); cuadro(s)
      m6_ctl <<- js_json(s, JS_SUPERGRID)
      js(s, "document.documentElement.style.removeProperty('--supergrid-col-min')"); cuadro(s)
    }
    data.frame(ancho = w, vw = m$vw, territorios = m$territorios, textos = m$textos,
               salen = length(m$fuera), fuera = paste(m$fuera, collapse = "; "), nombres = m$nombres)
  })
  do.call(rbind, filas)
}))
m6_ok_real <- !es_error(m6) && nrow(m6) == length(ANCHOS_SUPERGRID) &&
  all(m6$territorios == N_TERRITORIOS) && all(m6$vw == ANCHOS_SUPERGRID) && all(m6$salen == 0)
m6_ctl_detecta <- !is.null(m6_ctl) && length(m6_ctl$fuera) > 0
comprobar(
  "M6", "Con 5 territorios, ningún texto del supergrid sale de su celda a 375, 641, 670 y 700 px",
  m6_ok_real && m6_ctl_detecta,
  if (es_error(m6)) mensaje(m6) else sprintf(
    "%s; territorios %s; control sin ancho mínimo de columna a %d px: %s",
    paste(sprintf("%d px: %d territorios, %d de %d textos fuera%s", m6$ancho, m6$territorios, m6$salen, m6$textos,
                  ifelse(nzchar(m6$fuera), paste0(" [", m6$fuera, "]"), "")), collapse = "; "),
    m6$nombres[1], ANCHO_CONTROL_SUPERGRID,
    if (is.null(m6_ctl)) "sin medida" else sprintf("%d textos fuera (%s), %s", length(m6_ctl$fuera),
                                                    paste(m6_ctl$fuera, collapse = "; "),
                                                    if (m6_ctl_detecta) "FALLA, detectado" else "no detectado"))
)

# ---- M7. A 375 px, el tooltip no tapa el punto ------------------------------------------

# Casos de G3 del encargo s35g (medidor tt_g3.R): el punto de sparkline y la barra
# más a la derecha de la tarjeta de la primera y de la última columna, y la barra
# de una tarjeta de la última fila puesta junto al borde inferior; en hover y en
# clic. El punto (ptX, ptY) es el del evento que recibe el SVG.
JS_PREP_TOOLTIP <- "(() => {
  window.__TT = { ultimo: null };
  ['mouseover', 'click'].forEach(tipo => document.addEventListener(tipo, e => {
    const svg = e.target && e.target.closest ? e.target.closest('svg') : null;
    if (!svg) return;
    const r = svg.getBoundingClientRect();
    window.__TT.ultimo = { ptX: r.left + (e.offsetX !== undefined ? e.offsetX : e.layerX),
                           ptY: r.top + (e.offsetY !== undefined ? e.offsetY : e.layerY) };
  }, true));
  const celdas = () => {
    const cs = Array.from(document.querySelectorAll('.chart-cell:not(.is-empty)'))
      .filter(c => c.querySelector('svg.sparkline-svg') && c.querySelector('svg.bars-svg'));
    const L = [...new Set(cs.map(c => Math.round(c.getBoundingClientRect().left)))].sort((a, b) => a - b);
    const T = [...new Set(cs.map(c => Math.round(c.getBoundingClientRect().top + scrollY)))].sort((a, b) => a - b);
    return cs.map(c => ({ c, col: L.indexOf(Math.round(c.getBoundingClientRect().left)),
                          fila: T.indexOf(Math.round(c.getBoundingClientRect().top + scrollY)), ncol: L.length }));
  };
  const activos = (celda, tipo) => {
    const sel = tipo === 'spark' ? 'svg.sparkline-svg circle' : 'svg.bars-svg rect';
    return Array.from(celda.querySelectorAll(sel)).filter(e => e.style.cursor === 'pointer')
      .sort((a, b) => a.getBoundingClientRect().left - b.getBoundingClientRect().left ||
                      b.getBoundingClientRect().height - a.getBoundingClientRect().height);
  };
  window.__TTsel = (col, fila, tipo, modo, margenAbajo) => {
    const cs = celdas(); const ci = col === 'pri' ? 0 : cs[0].ncol - 1;
    const filas = cs.filter(x => x.col === ci).map(x => x.fila);
    const fi = fila === 'pri' ? Math.min(...filas) : Math.max(...filas);
    const celda = cs.find(x => x.col === ci && x.fila === fi).c;
    const els = activos(celda, tipo); const el = els[els.length - 1];
    // Desde Q-34 (s35h), bajo 670 px el supergrid se desplaza en horizontal dentro
    // de sí mismo: la celda se trae primero a la vista y después se ubica en vertical.
    if (modo === 'centro') celda.scrollIntoView({ block: 'center' });
    else { celda.scrollIntoView({ block: 'nearest', inline: 'nearest' });
           const r = el.getBoundingClientRect();
           window.scrollBy(0, (r.top + r.height / 2) - (document.documentElement.clientHeight - margenAbajo)); }
    const r = el.getBoundingClientRect(); const x = r.left + r.width / 2, y = r.top + r.height / 2;
    return JSON.stringify({ x, y, hit: document.elementFromPoint(x, y) === el });
  };
  window.__TTleer = () => {
    const t = document.getElementById('global-tooltip'); const r = t.getBoundingClientRect(); const u = window.__TT.ultimo || {};
    return JSON.stringify({ disp: t.style.display, l: r.left, t: r.top, r: r.right, b: r.bottom,
      cw: document.documentElement.clientWidth, ch: document.documentElement.clientHeight,
      ptX: u.ptX ?? null, ptY: u.ptY ?? null });
  };
  return true;
})()"
dims_tooltip <- regmatches(html, regexec(PATRON_TOOLTIP_DIMS, html))[[1]]
MARGEN_TOOLTIP <- if (length(dims_tooltip) == 3L) as.numeric(dims_tooltip[3]) else NA_real_
medir_tooltip <- function(ruta, casos) {
  con_motor(ruta, ANCHO_TOOLTIP, ALTO_TOOLTIP, function(s) {
    js(s, JS_PREP_TOOLTIP)
    filas <- list()
    for (cs in casos) for (accion in c("hover", "clic")) {
      mover(s, 4, ALTO_TOOLTIP / 2)                     # posición neutra: margen izquierdo
      p <- js_json(s, sprintf("window.__TTsel('%s', '%s', '%s', '%s', %d)", cs[[2]], cs[[3]], cs[[4]], cs[[5]], MARGEN_ABAJO))
      cuadro(s)
      if (accion == "hover") mover(s, p$x, p$y) else clic(s, p$x, p$y)
      m <- js_json(s, "window.__TTleer()")
      desfijado <- TRUE
      if (accion == "clic") {                           # desfija con un clic en el velo
        clic(s, 4, ALTO_TOOLTIP / 2); Sys.sleep(ESPERA_CLIC_S / 2)
        desfijado <- !identical(js_json(s, "window.__TTleer()")$disp, "block")
      }
      visible <- identical(m$disp, "block") && !is.null(m$ptX)
      filas[[length(filas) + 1]] <- data.frame(
        caso = cs[[1]], accion = accion, hit = isTRUE(p$hit), visible = visible, desfijado = desfijado,
        dentro = visible && m$l >= MARGEN_TOOLTIP - TOL_PX && m$r <= m$cw - MARGEN_TOOLTIP + TOL_PX &&
          m$t >= MARGEN_TOOLTIP - TOL_PX && m$b <= m$ch - MARGEN_TOOLTIP + TOL_PX,
        tapa = visible && m$ptX >= m$l - MARGEN_TAPA && m$ptX <= m$r + MARGEN_TAPA &&
          m$ptY >= m$t - MARGEN_TAPA && m$ptY <= m$b + MARGEN_TAPA)
    }
    do.call(rbind, filas)
  })
}
m7 <- intentar(medir_tooltip(RUTA_MOTOR, CASOS_TOOLTIP))
m7_ctl <- intentar(con_control(FRAGMENTO_REGLA_G3, "if (false) {", function(r) {
  medir_tooltip(r, Filter(function(cs) cs[[1]] %in% CASOS_TOOLTIP_CONTROL, CASOS_TOOLTIP))
}))
m7_ok_real <- !is.na(MARGEN_TOOLTIP) && !es_error(m7) && nrow(m7) == 2L * length(CASOS_TOOLTIP) &&
  all(m7$hit) && all(m7$visible) && all(m7$desfijado) && all(m7$dentro) && !any(m7$tapa)
m7_ctl_detecta <- !es_error(m7_ctl) && any(m7_ctl$tapa)
comprobar(
  "M7", "A 375 px, el tooltip no tapa el punto en los 12 casos de G3 y queda dentro de la ventana",
  m7_ok_real && m7_ctl_detecta,
  sprintf("%s; control sin la regla de G3 (%s → if (false) {), %s: %s",
          if (es_error(m7)) mensaje(m7) else sprintf(
            "margen de TOOLTIP_DIMS %s; %d casos, con acierto %d, tooltip visible %d, desfijado tras el clic %d, dentro %d, tapan %d%s",
            MARGEN_TOOLTIP, nrow(m7), sum(m7$hit), sum(m7$visible), sum(m7$desfijado), sum(m7$dentro), sum(m7$tapa),
            if (any(m7$tapa)) paste0(" [", paste(m7$caso[m7$tapa], m7$accion[m7$tapa], collapse = ", "), "]") else ""),
          FRAGMENTO_REGLA_G3, CASOS_TOOLTIP_CONTROL,
          if (es_error(m7_ctl)) mensaje(m7_ctl) else sprintf(
            "tapan %d de %d, %s", sum(m7_ctl$tapa), nrow(m7_ctl), if (m7_ctl_detecta) "FALLA, detectado" else "no detectado"))
)

# ---- M8. El PNG exportado del supergrid usa gobCL-sitio ------------------------------------

# Medidor de M4 del encargo s35h: se guarda cada Blob que crea la página (el SVG
# interno que se rasteriza y el PNG), se rasteriza el SVG interno sin el <text> de
# referencia y la caja de los píxeles distintos es la tinta de ese texto en el PNG;
# se compara con la tinta del mismo texto dibujado en un lienzo con gobCL-sitio y
# con system-ui.
JS_GANCHO <- "(() => { if (window.__blobs) return true; window.__blobs = [];
  const o = URL.createObjectURL.bind(URL);
  URL.createObjectURL = (b) => { window.__blobs.push(b); return o(b); };
  window.__dialogos = []; window.alert = (m) => { window.__dialogos.push(String(m)); };
  return true; })()"
JS_AYUDAS_PNG <- "(() => {
  window.__rasterizar = (svgStr, W, H, esc) => new Promise((res, rej) => {
    const u = URL.createObjectURL(new Blob([svgStr], { type: 'image/svg+xml;charset=utf-8' }));
    const img = new Image();
    img.onload = async () => { try { if (img.decode) await img.decode(); } catch (e) {}
      const c = document.createElement('canvas'); c.width = W * esc; c.height = H * esc;
      const x = c.getContext('2d'); x.scale(esc, esc); x.drawImage(img, 0, 0, W, H);
      res(x.getImageData(0, 0, c.width, c.height)); };
    img.onerror = () => rej('onerror'); img.src = u; });
  window.__pixeles = async (blob) => { const bm = await createImageBitmap(blob);
    const c = document.createElement('canvas'); c.width = bm.width; c.height = bm.height;
    const x = c.getContext('2d'); x.drawImage(bm, 0, 0); return x.getImageData(0, 0, c.width, c.height); };
  window.__cajaDif = (A, B, v) => { let x0 = 1e9, x1 = -1, n = 0; const w = A.width;
    for (let i = 0; i < A.data.length; i += 4) {
      if (A.data[i] !== B.data[i] || A.data[i + 1] !== B.data[i + 1] || A.data[i + 2] !== B.data[i + 2] || A.data[i + 3] !== B.data[i + 3]) {
        const p = i / 4, x = p % w, y = (p - x) / w;
        if (x < v.x0 || x > v.x1 || y < v.y0 || y > v.y1) continue;
        n++; if (x < x0) x0 = x; if (x > x1) x1 = x; } }
    return n ? { n, ancho: x1 - x0 + 1 } : { n: 0 }; };
  window.__tinta = (texto, peso, tam, familia, esc) => {
    const c = document.createElement('canvas'); c.width = Math.ceil(texto.length * tam * 1.2 * esc) + 40; c.height = Math.ceil(tam * 2 * esc);
    const x = c.getContext('2d'); x.fillStyle = '#fff'; x.fillRect(0, 0, c.width, c.height);
    x.scale(esc, esc); x.fillStyle = '#000'; x.font = peso + ' ' + tam + 'px ' + familia; x.textBaseline = 'alphabetic';
    x.fillText(texto, 10, tam * 1.3);
    const d = x.getImageData(0, 0, c.width, c.height).data; let x0 = 1e9, x1 = -1;
    for (let i = 0; i < d.length; i += 4) if (d[i] < 255 || d[i + 1] < 255 || d[i + 2] < 255) { const xx = (i / 4) % c.width; if (xx < x0) x0 = xx; if (xx > x1) x1 = xx; }
    return x1 - x0 + 1; };
  return true; })()"
JS_MEDIR_PNG <- "(async (iPng, iSvg) => {
  const png = window.__blobs[iPng], svgTxt = await window.__blobs[iSvg].text();
  const doc = new DOMParser().parseFromString(svgTxt, 'image/svg+xml'); const raiz = doc.documentElement;
  const W = +raiz.getAttribute('width'), H = +raiz.getAttribute('height');
  const A = await window.__pixeles(png); const esc = A.width / W;
  const textos = Array.from(doc.querySelectorAll('text'));
  const nombres = Array.from(document.querySelectorAll('.sg-ent-name')).map(e => e.textContent);
  const largo = nombres.slice().sort((a, b) => b.length - a.length)[0];
  const ref = { nombre: textos.find(t => t.textContent === largo && t.getAttribute('font-weight') === '800'), titulo: textos[0] };
  const res = [];
  for (const [rol, t] of Object.entries(ref)) {
    if (!t) { res.push({ rol, falta: true }); continue; }
    const tam = +t.getAttribute('font-size'), peso = t.getAttribute('font-weight') || '400', texto = t.textContent;
    const vivo = document.importNode(raiz, true); vivo.style.cssText = 'position:absolute;left:0;top:0;visibility:hidden';
    document.body.appendChild(vivo); const tv = vivo.querySelectorAll('text')[textos.indexOf(t)];
    const bb = tv.getBBox(), ctm = tv.getCTM();
    const ven = { x0: Math.floor((ctm.e + bb.x - tam) * esc), x1: Math.ceil((ctm.e + bb.x + 1.6 * bb.width + tam) * esc),
                  y0: Math.floor((ctm.f + bb.y - tam / 2) * esc), y1: Math.ceil((ctm.f + bb.y + bb.height + tam / 2) * esc) };
    vivo.remove();
    const padre = t.parentNode, sig = t.nextSibling; padre.removeChild(t);
    const B = await window.__rasterizar(new XMLSerializer().serializeToString(doc), W, H, esc);
    padre.insertBefore(t, sig);
    const caja = window.__cajaDif(A, B, ven);
    await document.fonts.load(peso + ' ' + tam + 'px \"gobCL-sitio\"');
    res.push({ rol, texto, png: caja.n ? caja.ancho : null,
               gob: window.__tinta(texto, peso, tam, '\"gobCL-sitio\"', esc), sys: window.__tinta(texto, peso, tam, 'system-ui', esc) });
  }
  return JSON.stringify(res);
})"
tipos_blob <- function(s) unlist(js(s, "window.__blobs.map(b => b.type)"))
medir_png <- function(ruta) {
  con_motor(ruta, ANCHO_PNG, ALTO_VENTANA, function(s) {
    js(s, JS_GANCHO); js(s, JS_AYUDAS_PNG)
    js(s, "document.querySelector('.icon-export[aria-label=\"Exportar PNG\"]').click()")
    t0 <- Sys.time()
    repeat {
      ti <- tipos_blob(s)
      if (any(startsWith(ti, "image/png"))) break
      if (as.numeric(difftime(Sys.time(), t0, units = "secs")) > ESPERA_EXPORTAR_S) stop("sin PNG tras «Exportar PNG»")
      Sys.sleep(0.2)
    }
    ti <- tipos_blob(s)
    i_png <- which(startsWith(ti, "image/png"))[1] - 1L
    i_svg <- which(startsWith(ti, "image/svg"))[1] - 1L
    r <- js_json(s, sprintf("(%s)(%d, %d)", JS_MEDIR_PNG, i_png, i_svg))
    r$dialogos <- length(unlist(js(s, "window.__dialogos")))
    r
  })
}
coincide_gob <- function(r) !is.null(r$png) && all(!is.na(r$png)) &&
  all(abs(r$png - r$gob) <= TOL_TINTA_PX) && all(abs(r$png - r$sys) > TOL_TINTA_PX)
describir_png <- function(r) paste(sprintf("%s «%s»: PNG %s, gobCL-sitio %d, system-ui %d", r$rol, r$texto,
                                           ifelse(is.na(r$png), "sin tinta", as.character(r$png)), r$gob, r$sys), collapse = "; ")
m8 <- intentar(medir_png(RUTA_MOTOR))
m8_ctl <- intentar(con_control(FRAGMENTO_FUENTE_PNG, "new Blob([svgStr]", medir_png))
m8_ok_real <- !es_error(m8) && nrow(m8) == 2L && coincide_gob(m8)
m8_ctl_detecta <- !es_error(m8_ctl) && !coincide_gob(m8_ctl)
comprobar(
  "M8", "El PNG exportado del supergrid usa gobCL-sitio (tinta del nombre más largo y del título)",
  m8_ok_real && m8_ctl_detecta,
  sprintf("%s; control sin la fuente incrustada (new Blob([svgStr]): %s",
          if (es_error(m8)) mensaje(m8) else describir_png(m8),
          if (es_error(m8_ctl)) mensaje(m8_ctl) else paste0(describir_png(m8_ctl), ", ",
                                                            if (m8_ctl_detecta) "FALLA, detectado" else "no detectado"))
)

# Cierra el navegador que abrió chromote para M4 a M8.
if (requireNamespace("chromote", quietly = TRUE) && chromote::has_default_chromote_object()) {
  try(chromote::default_chromote_object()$close(), silent = TRUE)
}

# ---- Salida ----------------------------------------------------------------

tabla <- do.call(rbind, resultados$filas)
fallan <- sum(tabla$estado == "FALLA")

cat("\n")
cat(sprintf("Resultado: %d pruebas, %d pasan, %d fallan (en %.0f segundos)\n",
            nrow(tabla), sum(tabla$estado == "PASA"), fallan,
            as.numeric(difftime(Sys.time(), inicio_bateria, units = "secs"))))

if (fallan > 0) quit(status = 1)
