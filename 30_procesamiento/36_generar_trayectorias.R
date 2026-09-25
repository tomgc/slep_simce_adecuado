# 36_generar_trayectorias.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Construye la vista de trayectorias de los Servicios Locales:
# 40_salidas/trayectorias_traspasos.html, autocontenida y sin red.
#
# Traslada a 30_procesamiento/ el mockup auditado en la sesión 30
# (50_documentacion/andamios/mockup_trayectoria_traspasos.html, congelado):
# la plantilla es ese archivo con el bloque de datos reemplazado por el
# marcador __DATA_TRAYECTORIAS__, y los datos los calcula R desde los
# intermedios del pipeline (D-s30-6; traspaso v31, pendiente 2). Las cifras de
# las notas metodológicas también salen de los datos (marcadores __NOTA_*__,
# sesión 33).
#
# Flujo:
#   1. Lee simce_rbd, sleps_chile, comunas_chile y establecimientos_chile
#      (40_salidas/intermedios/) y el catálogo de olas dim_slep_comunas.csv
#      (20_insumos/auxiliares/).
#   2. Construye DATA con 36_funciones_trayectorias.R, con las cohortes por
#      traspasar (D35-2, sesión 35).
#   3. Inserta los botones de cohorte, las cifras de las notas y el JSON en
#      36_trayectorias_template.html.
#   4. Comprueba que el HTML no carga nada por red ni conserva marcadores.
#   5. Escribe el HTML de forma atómica (archivo temporal y renombre).
#
# Salida: 40_salidas/trayectorias_traspasos.html
#
# Verificación: Rscript 30_procesamiento/36_verificar_trayectorias.R
#
# Uso:
#   source(here::here("30_procesamiento", "36_generar_trayectorias.R"))
# ----------------------------------------------------------------------------

library(here)
source(here::here("10_utils", "10_configuracion.R"))  # guarda de locale UTF-8 (POLITICA 5.2bis)
source(here::here("10_utils", "10_html.R"))           # reemplazar_literal(), insertar_sitio()

source(here::here("30_procesamiento", "36_funciones_trayectorias.R"))


# ============================================================================
# Bloque 0 — Rutas y constantes
# ============================================================================

RUTA_PLANTILLA_TRAY <- here::here("30_procesamiento", "36_trayectorias_template.html")
RUTA_SALIDA_TRAY    <- here::here("40_salidas", "trayectorias_traspasos.html")
MARCADOR_DATA_TRAY  <- "__DATA_TRAYECTORIAS__"
# Marcadores de las cifras de las notas: __NOTA_<NOMBRE>__, uno por elemento de
# cifras_notas(). Ninguno puede quedar en el HTML escrito.
PREFIJO_NOTA <- "__NOTA_"
PATRON_NOTA  <- "__NOTA_[A-Z_]+__"

# Marcador de los botones de cohorte (#c-coh): uno por año de traspaso de las
# unidades de DATA, con su número de unidades, y el primero marcado (sesión 35:
# antes eran literales de la plantilla).
MARCADOR_COHORTES <- "<!--__COHORTES__-->"
# Los botones se separan en grupos donde entre dos cohortes consecutivas pasan
# más de SALTO_GRUPO_COHORTES años (hoy, de 2021 a 2024) y donde empiezan las
# cohortes por traspasar (OLAS_FUTURAS).
SALTO_GRUPO_COHORTES <- 2L

# Patrón de carga por red que el HTML no puede contener (invariante del traspaso
# v31: la vista de trayectorias no depende de la red).
PATRON_RED <- '(src|href)="https?:'

# Marcado de los botones de cohorte, con la sangría de la plantilla.
botones_cohortes <- function(DATA) {
  unidades <- DATA$meta[names(DATA$meta) != ID_REFERENTE]
  por_cohorte <- table(vapply(unidades, function(m) as.integer(m$tras), integer(1)))
  anios <- as.integer(names(por_cohorte))
  corte <- c(FALSE, diff(anios) > SALTO_GRUPO_COHORTES |
               diff(anios %in% OLAS_FUTURAS) != 0)
  botones <- sprintf('<button data-v="%d" aria-pressed="%s">%d <em>%d</em></button>',
                     anios, ifelse(seq_along(anios) == 1L, "true", "false"),
                     anios, as.integer(por_cohorte))
  lineas <- unlist(lapply(seq_along(botones), function(i) {
    c(if (corte[i]) '<span class="sep"></span>', botones[i])
  }))
  paste(lineas, collapse = "\n    ")
}


# ============================================================================
# Bloque 1 — Datos
# ============================================================================

message("[36] Vista de trayectorias: leyendo insumos...")
insumos_tray <- leer_insumos_trayectorias()
message(sprintf("    simce_rbd.parquet: %d filas; sleps_chile.parquet: %d filas; %s: %d filas",
                nrow(insumos_tray$simce), nrow(insumos_tray$sleps), ARCHIVO_OLAS,
                nrow(insumos_tray$olas)))

DATA_TRAY  <- construir_datos_trayectorias(insumos_tray)
json_tray  <- datos_a_json(DATA_TRAY)
notas_tray <- cifras_notas(insumos_tray, DATA_TRAY)

message(sprintf(
  "    DATA: %d años, %d entidades, %d filas en datos, %d en nube, %d comunas (%.1f MB)",
  length(DATA_TRAY$anios), length(DATA_TRAY$meta), nrow(DATA_TRAY$datos),
  nrow(DATA_TRAY$nube), length(DATA_TRAY$comunas),
  nchar(json_tray, type = "bytes") / 1e6
))


# ============================================================================
# Bloque 2 — HTML
# ============================================================================

message("[36] Insertando datos en la plantilla...")
plantilla_tray <- paste(readLines(RUTA_PLANTILLA_TRAY, encoding = "UTF-8", warn = FALSE),
                        collapse = "\n")
# Encabezado y menú de vistas desde la fuente única del sitio (s34).
html_tray <- insertar_sitio(plantilla_tray, "trayectorias")
html_tray <- reemplazar_literal(html_tray, MARCADOR_COHORTES, botones_cohortes(DATA_TRAY))
# Una cifra puede citarse en más de un lugar (sesión 35: el número de Servicios
# Locales vigentes aparece en las notas y en el tooltip del referente), así que
# se reemplazan todas las apariciones, de forma literal; cada marcador debe
# aparecer al menos una vez.
for (nombre in names(notas_tray)) {
  marcador_nota <- paste0(PREFIJO_NOTA, nombre, "__")
  pos_nota <- gregexpr(marcador_nota, html_tray, fixed = TRUE)
  if (pos_nota[[1]][1] < 0) stop("La plantilla no trae el marcador ", marcador_nota)
  regmatches(html_tray, pos_nota) <- list(rep(notas_tray[[nombre]], length(pos_nota[[1]])))
}
if (grepl(PATRON_NOTA, html_tray)) {
  stop("La plantilla trae marcadores de notas sin cifra: ",
       paste(unique(regmatches(html_tray, gregexpr(PATRON_NOTA, html_tray))[[1]]),
             collapse = ", "))
}
html_tray <- reemplazar_literal(html_tray, MARCADOR_DATA_TRAY, json_tray)

for (marcador in c(MARCADOR_DATA_TRAY, MARCADOR_COHORTES)) {
  if (grepl(marcador, html_tray, fixed = TRUE)) stop("El HTML conserva el marcador ", marcador)
}
cargas_red <- regmatches(html_tray, gregexpr(PATRON_RED, html_tray))[[1]]
if (length(cargas_red) > 0) {
  stop("El HTML carga recursos por red: ", length(cargas_red), " apariciones de ",
       PATRON_RED)
}


# ============================================================================
# Bloque 3 — Escritura atómica
# ============================================================================

tmp_tray <- paste0(RUTA_SALIDA_TRAY, ".tmp")
# Escritura binaria de los bytes UTF-8: no depende de la locale de la sesión.
con_tray <- file(tmp_tray, open = "wb")
writeBin(charToRaw(enc2utf8(paste0(html_tray, "\n"))), con_tray)
close(con_tray)
if (!file.rename(tmp_tray, RUTA_SALIDA_TRAY)) {
  stop("No se pudo renombrar ", tmp_tray, " a ", RUTA_SALIDA_TRAY)
}

message(sprintf("[36] Escrito %s (%.2f MB)",
                fs::path_rel(RUTA_SALIDA_TRAY, here::here()),
                file.size(RUTA_SALIDA_TRAY) / 1e6))
