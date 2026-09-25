# 36_verificar_trayectorias.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Batería de verificación de la vista de trayectorias (paso 36).
#
# Adapta 50_documentacion/andamios/verificar_trayectorias.R (sesión 30, que
# queda congelado): D1 a D8 se conservan con su cálculo independiente sobre el
# parquet; se agregan D9 a D13, que comprueban el DATA que produce el
# generador y el HTML escrito, y D14, que comprueba la regla de filas del motor
# adoptada en la sesión 33 (sin marca de la Agencia y al menos 10 evaluados).
# C1 a C5 (sesión 35) comprueban las cohortes por traspasar de la decisión
# D35-2 (20260924_decision_referente_traspasos.md), R1 a R4, el rótulo y la
# marca de ola del referente de la decisión D35-1 (misma decisión), y R5 y R6
# (encargo pendientes s35b), el conteo del referente por ola con el directorio
# de la enmienda D35-4; el mismo encargo extiende a las unidades futuras el
# recuento independiente de D9, con su control positivo D9f. R7 (encargo
# pendientes s35c, Q-26) comprueba que el tooltip del referente dice sus
# cifras desde DATA.
# Cada prueba mide la afirmación, no un síntoma cercano, y las de ausencia
# llevan control positivo.
#
# Insumos:  40_salidas/intermedios/{simce_rbd,sleps_chile,establecimientos_chile}.parquet
#           20_insumos/auxiliares/dim_slep_comunas.csv
#           40_salidas/trayectorias_traspasos.html (correr antes el paso 36)
#           50_documentacion/andamios/mockup_trayectoria_traspasos.html
# Requiere: chromote y Chrome (R2, R4, R6 y R7 leen la vista en el navegador).
# Salida:   el informe en consola, una línea por prueba. No escribe archivos en
#           el árbol: el log del encargo o de la sesión lo recoge literal (un
#           CSV en el árbol sería un archivo de datos sin autorizar, I8). R4 y
#           R6 escriben un HTML de control en tempdir() y lo borran al leerlo.
#
# Uso:      Rscript 30_procesamiento/36_verificar_trayectorias.R
#           (código de salida 1 si alguna prueba falla)
# ----------------------------------------------------------------------------

suppressPackageStartupMessages({
  library(arrow); library(dplyr); library(here)
})
source(here::here("10_utils", "10_configuracion.R"))  # guarda de locale UTF-8 (POLITICA 5.2bis)

source(here::here("30_procesamiento", "36_funciones_trayectorias.R"))

RUTA        <- here::here("40_salidas", "intermedios")
RUTA_HTML   <- here::here("40_salidas", "trayectorias_traspasos.html")
RUTA_MOCKUP <- here::here("50_documentacion", "andamios",
                          "mockup_trayectoria_traspasos.html")
TOL         <- 0.15   # puntos porcentuales admitidos por redondeo (D1-D8)
PASO_PCT    <- 10^-DECIMALES_PCT

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

# Extrae el literal JSON asignado a `var DATA=` en un HTML.
extraer_data <- function(ruta) {
  html <- paste(readLines(ruta, encoding = "UTF-8", warn = FALSE), collapse = "\n")
  ini <- regexpr("var DATA=", html, fixed = TRUE)
  if (ini < 0) stop("No hay 'var DATA=' en ", ruta)
  ini <- ini + nchar("var DATA=")
  resto <- substr(html, ini, nchar(html))
  fin <- regexpr(";\n</script>", resto, fixed = TRUE)
  if (fin < 0) stop("No se encontró el cierre de DATA en ", ruta)
  substr(resto, 1L, fin - 1L)
}

# ---- Lectura y reconstrucción independiente de los agregados (D1-D8) --------

simce <- read_parquet(file.path(RUTA, "simce_rbd.parquet"))
sleps <- read_parquet(file.path(RUTA, "sleps_chile.parquet"))
stopifnot(nrow(simce) > 0, nrow(sleps) > 0)

base <- simce |>
  filter(!is.na(palu_eda_ade), !is.na(palu_eda_ele), !is.na(palu_eda_ins),
         !is.na(nalu), !is.na(cod_grupo),
         is.na(marca), nalu >= 10) |>
  mutate(suma_niveles = palu_eda_ade + palu_eda_ele + palu_eda_ins) |>
  filter(suma_niveles >= 99, suma_niveles <= 101) |>
  mutate(np      = paste0(nivel, "_", prueba),
         num_ade = nalu * palu_eda_ade / 100,
         num_ins = nalu * palu_eda_ins / 100)

catalogo <- sleps |> distinct(cod_slep, rbd)
slep <- base |> inner_join(catalogo, by = "rbd")

agregar <- function(datos, ...) {
  datos |>
    summarise(.by = c(...),
              ade = round(sum(num_ade) / sum(nalu) * 100, 1),
              ins = round(sum(num_ins) / sum(nalu) * 100, 1),
              n   = as.integer(round(sum(nalu))),
              e   = n_distinct(rbd))
}

consolidado <- agregar(slep, cod_slep, anio, np)
por_grupo   <- agregar(slep, cod_slep, anio, np, cod_grupo)

# ---- D1. Frontera de lo posible --------------------------------------------

comprobar(
  "D1", "Ningún agregado supera Adecuado + Insuficiente = 100",
  all(consolidado$ade + consolidado$ins <= 100 + TOL),
  sprintf("máximo observado %.1f", max(consolidado$ade + consolidado$ins))
)

# ---- D2. El consolidado equivale a los cinco grupos ponderados --------------

recombinado <- por_grupo |>
  summarise(.by = c(cod_slep, anio, np),
            ade_g = sum(n * ade / 100) / sum(n) * 100,
            n_g   = sum(n),
            e_g   = sum(e))

cotejo <- consolidado |> inner_join(recombinado, by = c("cod_slep", "anio", "np"))

comprobar(
  "D2", "El consolidado equivale a los cinco grupos combinados y ponderados",
  all(abs(cotejo$ade_g - cotejo$ade) < TOL),
  sprintf("desviación máxima %.2f puntos en %d combinaciones",
          max(abs(cotejo$ade_g - cotejo$ade)), nrow(cotejo))
)

comprobar(
  "D3", "Los estudiantes evaluados del consolidado igualan la suma por grupo",
  all(cotejo$n == cotejo$n_g),
  sprintf("%d desajustes", sum(cotejo$n != cotejo$n_g))
)

# ---- D4. El grupo socioeconómico se asigna por nivel, no por escuela --------

grupos_por_escuela_anio <- base |>
  summarise(.by = c(rbd, anio), grupos = n_distinct(cod_grupo))

comprobar(
  "D4", "Dentro de un mismo nivel y prueba, cada escuela tiene un solo grupo",
  all(base |> summarise(.by = c(rbd, anio, np), g = n_distinct(cod_grupo)) |> pull(g) == 1),
  "condición que sí debe cumplirse siempre"
)

mezclan <- sum(grupos_por_escuela_anio$grupos > 1)
comprobar(
  "D5", "Se declara cuántas escuelas cambian de grupo entre niveles",
  mezclan > 0,
  sprintf("%d de %d pares escuela-año, es decir %.1f%%; por eso el desglose no suma el total en la vista combinada",
          mezclan, nrow(grupos_por_escuela_anio), 100 * mezclan / nrow(grupos_por_escuela_anio))
)

# ---- D6-D7. Panel de serie completa contenido en el panel total ------------

anios <- sort(unique(base$anio))
completos <- slep |>
  summarise(.by = c(rbd, np), anios_con_dato = n_distinct(anio)) |>
  filter(anios_con_dato == length(anios))

panel_fijo_ind <- slep |> semi_join(completos, by = c("rbd", "np")) |>
  agregar(cod_slep, anio, np)

cotejo_panel <- panel_fijo_ind |>
  inner_join(consolidado, by = c("cod_slep", "anio", "np"), suffix = c("_f", "_c"))

comprobar(
  "D6", "El panel de serie completa nunca tiene más establecimientos que el total",
  all(cotejo_panel$e_f <= cotejo_panel$e_c),
  sprintf("%d violaciones", sum(cotejo_panel$e_f > cotejo_panel$e_c))
)

comprobar(
  "D7", "Toda combinación del panel de serie completa existe en el panel total",
  nrow(panel_fijo_ind) == nrow(cotejo_panel),
  sprintf("%d combinaciones sin contraparte", nrow(panel_fijo_ind) - nrow(cotejo_panel))
)

# ---- D8. Control positivo: la batería detecta un error introducido ----------

adulterado <- cotejo
adulterado$ade[1] <- adulterado$ade[1] + 0.5
detectados <- sum(abs(adulterado$ade_g - adulterado$ade) >= TOL)

comprobar(
  "D8", "Control positivo: alterar una cifra en 0,5 puntos dispara exactamente un hallazgo",
  detectados == 1,
  sprintf("detectados %d", detectados)
)

# ---- DATA del generador, con los porcentajes sin redondear -----------------

insumos <- leer_insumos_trayectorias()
DATA    <- construir_datos_trayectorias(insumos, conservar_brutos = TRUE)
base_g  <- base_valida(insumos$simce)

# ---- Catálogo de olas, leído por cuenta propia (D35-2) ---------------------
# Las olas de traspaso posteriores a la última cohorte del catálogo de
# Servicios Locales, leídas sin pasar por 36_funciones_trayectorias.R. Las usan
# el recuento de D9 y las pruebas de las cohortes futuras y del referente. Un
# error de lectura queda guardado: C1 a R6 lo informan como FALLA y D9 se
# detiene, igual que la lectura de insumos de arriba.

intentar <- function(expr) tryCatch(expr, error = function(e) e)
exigir   <- function(x) if (inherits(x, "error")) stop(conditionMessage(x), call. = FALSE) else x

ultima_vigente <- max(as.integer(sleps$anio_traspaso))
olas_ind <- intentar(
  readr::read_delim(
    here::here("20_insumos", "auxiliares", "dim_slep_comunas.csv"), delim = ";",
    col_types = readr::cols(.default = readr::col_character()),
    locale = readr::locale(encoding = "UTF-8"), show_col_types = FALSE, progress = FALSE
  ) |>
    filter(as.integer(anio_traspaso) > ultima_vigente)
)

# ---- D9. El total T es la suma de todos los grupos del parquet --------------
# Recuento independiente: evaluados por universo, año y nivel-prueba, sumando
# las filas válidas del parquet de todos los grupos socioeconómicos, contra el
# `n` del total que publica la vista. Cubre Servicios Locales, referente,
# unidades futuras y nube, en el panel 0, y toda fila del total de la vista en
# ese panel tiene su recuento. B31-4 atribuía al mockup la exclusión del grupo
# 5 del total; esta prueba es la que lo habría detectado. Las unidades futuras
# (D35-2) se recuentan con el catálogo de olas y el directorio leídos por cuenta
# propia: los establecimientos que el directorio registra como municipales en
# las comunas de cada par (Servicio Local, ola), con sus filas de cualquier
# dependencia (encargo pendientes s35b, Q-23).

anio_ancla <- min(base_g$anio)
rbd_ancla  <- unique(base_g$rbd[base_g$anio == anio_ancla])
municipal_ind <- base_g |>
  filter(cod_depe2 == DEPE_MUNICIPAL,
         !rbd %in% as.character(sleps$rbd),
         rbd %in% rbd_ancla)

rbd_fut_ind <- read_parquet(file.path(RUTA, "establecimientos_chile.parquet")) |>
  filter(cod_depe2 == DEPE_MUNICIPAL) |>
  transmute(rbd = as.character(rbd), cod_comuna = as.character(cod_com_rbd)) |>
  inner_join(distinct(exigir(olas_ind), cod_comuna, cod_slep, anio_traspaso),
             by = "cod_comuna") |>
  transmute(id = paste0(cod_slep, SEP_ID_FUTURO, anio_traspaso), rbd) |>
  distinct()
recuento_fut <- base_g |> inner_join(rbd_fut_ind, by = "rbd") |>
  summarise(.by = c(id, anio, np), n_ind = sum(nalu))

recuento <- bind_rows(
  base_g |> inner_join(mutate(catalogo, rbd = as.character(rbd)), by = "rbd") |>
    summarise(.by = c(cod_slep, anio, np), n_ind = sum(nalu)) |>
    rename(id = cod_slep),
  municipal_ind |> summarise(.by = c(anio, np), n_ind = sum(nalu)) |>
    mutate(id = ID_REFERENTE),
  recuento_fut
)
filas_t <- DATA$datos |> filter(g == GSE_TOTAL, panel == 0L, np != NP_TODO)
totales <- filas_t |> inner_join(recuento, by = c("id", "anio", "np"))
es_futura <- totales$id %in% recuento_fut$id

recuento_nube <- municipal_ind |>
  summarise(.by = c(cod_com_rbd, anio, np), n_ind = sum(nalu)) |>
  rename(com = cod_com_rbd)
totales_nube <- DATA$nube |> filter(g == GSE_TOTAL, np != NP_TODO) |>
  inner_join(recuento_nube, by = c("com", "anio", "np"))

suma_grupos <- bind_rows(
  DATA$datos |> filter(g != GSE_TOTAL) |>
    summarise(.by = c(id, anio, np, panel), n_g = sum(n)) |>
    inner_join(filter(DATA$datos, g == GSE_TOTAL), by = c("id", "anio", "np", "panel")) |>
    transmute(n, n_g),
  DATA$nube |> filter(g != GSE_TOTAL) |>
    summarise(.by = c(com, anio, np), n_g = sum(n)) |>
    inner_join(filter(DATA$nube, g == GSE_TOTAL), by = c("com", "anio", "np")) |>
    transmute(n, n_g)
)

desajustes_d9 <- function(tot, tot_nube, sg) {
  sum(tot$n != round(tot$n_ind)) + sum(tot_nube$n != round(tot_nube$n_ind)) +
    sum(sg$n != sg$n_g)
}
sin_pareja_d9 <- (nrow(filas_t) - nrow(totales)) + (nrow(recuento) - nrow(totales)) +
  (nrow(recuento_nube) - nrow(totales_nube))
comprobar(
  "D9", "El n del total T iguala la suma de todos los grupos del parquet (Servicios Locales, referente, unidades futuras y nube)",
  desajustes_d9(totales, totales_nube, suma_grupos) == 0 && sin_pareja_d9 == 0,
  sprintf(paste0("%d desajustes en %d + %d + %d combinaciones (total: %d de las vigentes y el referente ",
                 "y %d de %d unidades futuras; nube; suma de grupos); sin pareja %d"),
          desajustes_d9(totales, totales_nube, suma_grupos),
          nrow(totales), nrow(totales_nube), nrow(suma_grupos),
          sum(!es_futura), sum(es_futura), n_distinct(totales$id[es_futura]), sin_pareja_d9)
)

# Control positivo de D9: restar un evaluado al total de una unidad vigente o
# del referente dispara un hallazgo.
plantado <- totales
k_vig <- which(!es_futura)[1]
plantado$n[k_vig] <- plantado$n[k_vig] - 1L
comprobar(
  "D9c", "Control positivo: un total con un evaluado de menos dispara exactamente un hallazgo",
  desajustes_d9(plantado, totales_nube, suma_grupos) == 1,
  sprintf("detectados %d en %s", desajustes_d9(plantado, totales_nube, suma_grupos), plantado$id[k_vig])
)

# Control positivo de la extensión a las unidades futuras: restar un evaluado
# al total de una unidad futura dispara un hallazgo.
plantado_fut <- totales
k_fut <- which(es_futura)[1]
plantado_fut$n[k_fut] <- plantado_fut$n[k_fut] - 1L
comprobar(
  "D9f", "Control positivo: el total de una unidad futura con un evaluado de menos dispara exactamente un hallazgo",
  desajustes_d9(plantado_fut, totales_nube, suma_grupos) == 1,
  sprintf("detectados %d en %s", desajustes_d9(plantado_fut, totales_nube, suma_grupos),
          plantado_fut$id[k_fut])
)

# ---- D10. Fidelidad al mockup auditado de la sesión 30 ----------------------
# Coteja la maquinaria de agregación con la regla de filas del mockup, que
# incluía las filas marcadas (excluir_marcadas = FALSE): la regla vigente la
# comprueba D14. Las mismas filas y claves que el mockup; toda cifra distinta debe ser un
# empate exacto de redondeo (el mockup los resolvía en coma flotante; el
# generador, hacia arriba en aritmética entera) y distar un décimo. El número de
# empates que difieren depende de la plataforma que construyó el mockup: no es
# criterio (ERR-32-03). El mockup trae solo los 36 Servicios Locales y el
# referente: el cotejo se hace sin las unidades futuras (incluir_futuras =
# FALSE, sesión 35), sobre el mismo universo de siempre; C3 comprueba que
# agregarlas no cambia esas filas.

M <- jsonlite::fromJSON(extraer_data(RUTA_MOCKUP), simplifyVector = TRUE)
a_df <- function(m, columnas) {
  d <- as.data.frame(m, stringsAsFactors = FALSE)
  names(d) <- columnas
  d
}
mock_datos <- a_df(M$datos, c("id", "anio", "np", "g", "panel", "ade", "ins", "n", "e")) |>
  mutate(across(c(anio, panel, n, e), as.integer), across(c(ade, ins), as.numeric))
mock_nube <- a_df(M$nube, c("com", "anio", "np", "g", "ade", "ins", "n")) |>
  mutate(across(c(anio, n), as.integer), across(c(ade, ins), as.numeric))

# Empate exacto: num / den (porcentaje × ESCALA_PCT) termina justo en ,5.
es_empate <- function(num, den) (2 * num) %% (2 * den) == den
cotejar <- function(gen, mock, claves) {
  x <- inner_join(gen, mock, by = claves, suffix = c("", "_m"))
  dif_ade <- x$ade != x$ade_m
  dif_ins <- x$ins != x$ins_m
  list(
    faltan  = nrow(gen) + nrow(mock) - 2L * nrow(x),
    n_dif   = sum(x$n != x$n_m) + if ("e" %in% names(x)) sum(x$e != x$e_m) else 0L,
    pct_dif = sum(dif_ade) + sum(dif_ins),
    no_empate = sum(dif_ade & !(es_empate(x$ade_num, x$den) & abs(x$ade - x$ade_m) < 1.5 * PASO_PCT)) +
                sum(dif_ins & !(es_empate(x$ins_num, x$den) & abs(x$ins - x$ins_m) < 1.5 * PASO_PCT))
  )
}
DATA_M  <- construir_datos_trayectorias(insumos, conservar_brutos = TRUE,
                                        excluir_marcadas = FALSE,
                                        incluir_futuras = FALSE)
c_datos <- cotejar(DATA_M$datos, mock_datos, c("id", "anio", "np", "g", "panel"))
c_nube  <- cotejar(DATA_M$nube, mock_nube, c("com", "anio", "np", "g"))

ctx <- V8::v8()
ctx$assign("a", extraer_data(RUTA_MOCKUP))
ctx$assign("b", datos_a_json(construir_datos_trayectorias(insumos, excluir_marcadas = FALSE,
                                                          incluir_futuras = FALSE)))
ctx$assign("r", datos_a_json(construir_datos_trayectorias(insumos)))
ctx$eval("var A=JSON.parse(a), B=JSON.parse(b), R=JSON.parse(r);")
iguales_js <- vapply(c("anios", "meta", "nac", "comunas"), function(k) {
  isTRUE(ctx$eval(sprintf("JSON.stringify(A.%s)===JSON.stringify(B.%s)", k, k)) == "true")
}, logical(1))

comprobar(
  "D10", "Fidelidad al mockup de la sesión 30: mismas filas; solo difieren empates de redondeo",
  all(iguales_js) && c_datos$faltan == 0 && c_nube$faltan == 0 &&
    c_datos$n_dif == 0 && c_nube$n_dif == 0 &&
    c_datos$no_empate == 0 && c_nube$no_empate == 0,
  sprintf("anios/meta/nac/comunas idénticos: %s; filas sin pareja %d; conteos distintos %d; cifras distintas %d, de ellas sin empate %d",
          paste(names(iguales_js)[iguales_js], collapse = ","),
          c_datos$faltan + c_nube$faltan, c_datos$n_dif + c_nube$n_dif,
          c_datos$pct_dif + c_nube$pct_dif, c_datos$no_empate + c_nube$no_empate)
)

# Control positivo de D10: una cifra movida un décimo fuera de un empate.
mock_plantado <- mock_datos
no_empate_idx <- which(!es_empate(DATA_M$datos$ade_num, DATA_M$datos$den))[1]
fila_p <- DATA_M$datos[no_empate_idx, c("id", "anio", "np", "g", "panel")]
k <- which(mock_plantado$id == fila_p$id & mock_plantado$anio == fila_p$anio &
           mock_plantado$np == fila_p$np & mock_plantado$g == fila_p$g &
           mock_plantado$panel == fila_p$panel)
mock_plantado$ade[k] <- mock_plantado$ade[k] + PASO_PCT
comprobar(
  "D10c", "Control positivo: una cifra movida un décimo sin empate dispara exactamente un hallazgo",
  cotejar(DATA_M$datos, mock_plantado, c("id", "anio", "np", "g", "panel"))$no_empate == 1,
  sprintf("detectados %d", cotejar(DATA_M$datos, mock_plantado, c("id", "anio", "np", "g", "panel"))$no_empate)
)

# ---- D11. Las cifras escritas en las notas coinciden con los datos ----------

html <- paste(readLines(RUTA_HTML, encoding = "UTF-8", warn = FALSE), collapse = "\n")
n_ref_txt <- format(DATA$meta[[ID_REFERENTE]]$cat, big.mark = ".", decimal.mark = ",")
n_com_txt <- sprintf("(%d en total)", length(DATA$comunas))
# Recuento independiente de las filas marcadas que excluye la regla del motor.
marcadas_ind <- simce |>
  filter(rbd %in% as.character(sleps$rbd),
         !is.na(palu_eda_ade), !is.na(palu_eda_ele), !is.na(palu_eda_ins),
         !is.na(nalu),
         palu_eda_ade + palu_eda_ele + palu_eda_ins >= 99,
         palu_eda_ade + palu_eda_ele + palu_eda_ins <= 101,
         !is.na(marca) | nalu < 10) |>
  nrow()
marcadas_txt <- sprintf("y %s filas con marca de la Agencia",
                        format(marcadas_ind, big.mark = ".", decimal.mark = ","))
# El ejemplo de la nube es literal en la plantilla: debe seguir en los datos.
cod_palena <- names(DATA$comunas)[unlist(DATA$comunas) == "Palena"]
palena_ok <- grepl("Palena aparece con 72,7% en Adecuado sobre 11 estudiantes", html, fixed = TRUE) &&
  nrow(filter(DATA$nube, com %in% cod_palena, g == GSE_TOTAL, np != NP_TODO,
              ade == 72.7, n == 11L)) == 1
sin_marcador <- !grepl("__NOTA_", html, fixed = TRUE)
# El año ancla del referente sale de los datos (Q-47, encargo s35d): el primer
# año de la serie.
ancla_txt <- sprintf("que en %d eran municipales", min(as.integer(unlist(DATA$anios))))
ancla_ok <- grepl(ancla_txt, html, fixed = TRUE)
comprobar(
  "D11", "Las notas declaran el referente, su año ancla, la nube, las filas excluidas y el ejemplo que traen los datos",
  grepl(sprintf("los %s establecimientos", n_ref_txt), html, fixed = TRUE) &&
    grepl(n_com_txt, html, fixed = TRUE) && grepl(marcadas_txt, html, fixed = TRUE) &&
    palena_ok && sin_marcador && ancla_ok,
  sprintf("referente %s, año ancla «%s»: %s, nube %s, filas marcadas %d, ejemplo de la nube: %s, sin marcadores: %s",
          n_ref_txt, ancla_txt, ancla_ok, n_com_txt, marcadas_ind, palena_ok, sin_marcador)
)

# ---- D12. El HTML escrito no depende de la red y trae el DATA del generador --

cargas_red <- lengths(regmatches(html, gregexpr('(src|href)="https?:', html)))
ctx$assign("h", extraer_data(RUTA_HTML))
data_igual <- ctx$eval("JSON.stringify(JSON.parse(h))===JSON.stringify(R)") == "true"
comprobar(
  "D12", "El HTML no carga nada por red y su DATA es el que construye el generador",
  cargas_red == 0 && data_igual && !grepl("__DATA_TRAYECTORIAS__", html, fixed = TRUE),
  sprintf("cargas por red %d; DATA idéntico: %s", cargas_red, data_igual)
)

# Control positivo de D12: el patrón encuentra una carga plantada.
comprobar(
  "D12c", "Control positivo: el patrón de red detecta un <script src=\"https:...\"> plantado",
  lengths(regmatches('<script src="https://x.y/z.js">', gregexpr('(src|href)="https?:', '<script src="https://x.y/z.js">'))) == 1
)

# ---- D13. El DATA no depende del orden de las filas del parquet -------------
# Con el redondeo en aritmética entera, invertir el orden de las filas no puede
# mover ninguna cifra (en coma flotante movía 14; sesión 32, R-16).

insumos_inv <- insumos
insumos_inv$simce <- insumos$simce[rev(seq_len(nrow(insumos$simce))), ]
DATA_inv  <- construir_datos_trayectorias(insumos_inv)
json_base <- datos_a_json(construir_datos_trayectorias(insumos))
comprobar(
  "D13", "Invertir el orden de las filas del parquet deja el DATA idéntico byte a byte",
  identical(datos_a_json(DATA_inv), json_base),
  sprintf("%d bytes", nchar(json_base, type = "bytes"))
)

# Control positivo de D13: el mismo cotejo detecta un DATA con una cifra movida.
DATA_plantado <- DATA_inv
DATA_plantado$datos$ade[1] <- DATA_plantado$datos$ade[1] + PASO_PCT
comprobar(
  "D13c", "Control positivo: un DATA con una cifra movida un décimo no pasa el cotejo",
  !identical(datos_a_json(DATA_plantado), json_base)
)

# ---- D14. La regla de filas es la del motor --------------------------------
# Ninguna fila de la base tiene marca de la Agencia ni menos de 10 evaluados, y
# la regla excluye exactamente las filas que cumplen alguna de las dos
# condiciones (recuento independiente sobre el parquet).

base_sin_regla <- base_valida(insumos$simce, excluir_marcadas = FALSE)
excluidas_ind  <- sum(!is.na(base_sin_regla$marca) | base_sin_regla$nalu < 10)
comprobar(
  "D14", "La base no trae filas con marca ni con menos de 10 evaluados, y excluye exactamente esas",
  sum(!is.na(base_g$marca)) == 0 && sum(base_g$nalu < 10) == 0 &&
    nrow(base_sin_regla) - nrow(base_g) == excluidas_ind && excluidas_ind > 0,
  sprintf("excluidas %d de %d filas coherentes", nrow(base_sin_regla) - nrow(base_g),
          nrow(base_sin_regla))
)

# Control positivo de D14: marcar una fila válida la saca de la base.
simce_plantado <- insumos$simce
idx_valida <- which(is.na(simce_plantado$marca) & !is.na(simce_plantado$palu_eda_ade) &
                      simce_plantado$nalu >= 10)
idx_valida <- idx_valida[as.character(simce_plantado$rbd[idx_valida]) %in% base_g$rbd][1]
simce_plantado$marca[idx_valida] <- "plantada"
comprobar(
  "D14c", "Control positivo: marcar una fila válida la saca de la base, exactamente una",
  nrow(base_g) - nrow(base_valida(simce_plantado)) == 1,
  sprintf("filas que salen %d", nrow(base_g) - nrow(base_valida(simce_plantado)))
)

# ---- Cohortes futuras (D35-2): insumos y recuentos independientes -----------
# Las olas de traspaso posteriores a la última cohorte del catálogo de
# Servicios Locales entran a la vista como unidades propias
# (50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md).
# Una unidad futura se reconoce por su año de traspaso, no por su
# identificador: así C2 puede detectar un identificador reutilizado. Los
# recuentos independientes leen el catálogo de olas (olas_ind, leído antes de
# D9) y el directorio sin pasar por 36_funciones_trayectorias.R. Las pruebas se
# escribieron antes del código (sesión 35): un error de construcción se informa
# como FALLA de la prueba y no detiene la batería.

# Valores esperados con los insumos vigentes (catálogo de slep_central_datos en
# d7a8ec6 y directorio de establecimientos_chile.parquet). Cambian solo cuando
# se recopia el catálogo o se actualiza el directorio (decisión D35-2).
ESPERADO_POR_OLA     <- c("2027" = 13L, "2028" = 11L, "2029" = 13L)
ESPERADO_EST_FUTURAS <- 2564L

evaluar <- function(expr) {
  tryCatch(expr, error = function(e) list(ok = FALSE, detalle = paste("error:", conditionMessage(e))))
}

est_fut_ind <- intentar(
  read_parquet(file.path(RUTA, "establecimientos_chile.parquet")) |>
    filter(cod_depe2 == "1", cod_com_rbd %in% exigir(olas_ind)$cod_comuna) |>
    pull(rbd) |>
    n_distinct()
)

DATA_T <- intentar(construir_datos_trayectorias(insumos, incluir_futuras = TRUE))
DATA_F <- intentar(construir_datos_trayectorias(insumos, incluir_futuras = FALSE))

# Identificadores de las unidades futuras de un `meta`: las de traspaso
# posterior a la última cohorte del catálogo de Servicios Locales.
ids_futuras <- function(meta) {
  tras <- vapply(meta, function(m) as.integer(m$tras), integer(1))
  names(meta)[tras > ultima_vigente]
}
campo_futuras <- function(meta, campo) {
  vapply(meta[ids_futuras(meta)], function(m) as.integer(m[[campo]]), integer(1))
}
a_texto <- function(x) paste(names(x), x, sep = "=", collapse = ", ")

# ---- C1. Hay 37 unidades futuras, con 13, 11 y 13 por ola -------------------
# Además, las unidades son exactamente los pares (Servicio Local, ola) del
# catálogo.

c1 <- evaluar({
  meta  <- exigir(DATA_T)$meta
  pares <- distinct(exigir(olas_ind), cod_slep, anio_traspaso)
  por_ola     <- table(campo_futuras(meta, "tras"))
  por_ola     <- stats::setNames(as.integer(por_ola), names(por_ola))
  por_ola_ind <- table(pares$anio_traspaso)
  por_ola_ind <- stats::setNames(as.integer(por_ola_ind), names(por_ola_ind))
  mismos_pares <- setequal(ids_futuras(meta),
                           paste0(pares$cod_slep, SEP_ID_FUTURO, pares$anio_traspaso))
  list(ok = identical(por_ola, ESPERADO_POR_OLA) && identical(por_ola_ind, ESPERADO_POR_OLA) &&
         mismos_pares,
       detalle = sprintf("%d unidades futuras; por ola en DATA %s; en el catálogo %s; mismos pares: %s",
                         length(ids_futuras(meta)), a_texto(por_ola), a_texto(por_ola_ind),
                         mismos_pares))
})
comprobar("C1", "Hay 37 unidades futuras, con 13, 11 y 13 por ola", c1$ok, c1$detalle)

# ---- C2. Ningún identificador futuro coincide con uno vigente ---------------
# Tampoco se repiten entre sí, y las unidades vigentes siguen siendo las de
# ORDEN_SLEP. Control positivo: un identificador futuro plantado igual a uno
# vigente se detecta.

choques <- function(fut, vig) sum(fut %in% c(vig, ID_REFERENTE)) + sum(duplicated(fut))
c2 <- evaluar({
  meta <- exigir(DATA_T)$meta
  fut  <- ids_futuras(meta)
  tras <- vapply(meta, function(m) as.integer(m$tras), integer(1))
  vig  <- names(meta)[tras > 0L & tras <= ultima_vigente]
  n_choques <- choques(fut, vig) + anyDuplicated(names(meta))
  control   <- choques(c(fut, vig[1]), vig)
  list(ok = length(fut) > 0 && n_choques == 0 && setequal(vig, ORDEN_SLEP) && control == 1,
       detalle = sprintf("%d futuros contra %d vigentes: %d coincidencias; control plantado detectado %d",
                         length(fut), length(vig), n_choques, control))
})
comprobar("C2", "Ningún identificador futuro coincide con uno vigente", c2$ok, c2$detalle)

# ---- C3. Las filas de las 36 vigentes y del referente no cambian ------------
# Autocontenida: el DATA con las unidades futuras, filtrado a las vigentes y al
# referente, es idéntico al DATA sin ellas. Control positivo: una cifra vigente
# movida un décimo rompe la identidad.

c3 <- evaluar({
  ids_c3 <- c(ORDEN_SLEP, ID_REFERENTE)
  con    <- filter(exigir(DATA_T)$datos, id %in% ids_c3)
  sin    <- filter(exigir(DATA_F)$datos, id %in% ids_c3)
  plantado <- con
  k <- which(plantado$id %in% ORDEN_SLEP)[1]
  plantado$ade[k] <- plantado$ade[k] + PASO_PCT
  list(ok = nrow(sin) > 0 && all(ids_c3 %in% sin$id) && identical(con, sin) &&
         !identical(plantado, sin),
       detalle = sprintf("%d filas de %d unidades; idénticas: %s; control plantado detectado: %s",
                         nrow(sin), length(ids_c3), identical(con, sin), !identical(plantado, sin)))
})
comprobar("C3", "Las filas de datos de las 36 unidades vigentes y del referente no cambian",
          c3$ok, c3$detalle)

# ---- C4. Toda unidad futura tiene post == 0 con los datos actuales ----------

c4 <- evaluar({
  meta <- exigir(DATA_T)$meta
  post <- campo_futuras(meta, "post")
  list(ok = length(post) > 0 && all(post == 0L),
       detalle = sprintf("%d unidades futuras; con post distinto de 0: %d; último año con datos %d",
                         length(post), sum(post != 0L), max(exigir(DATA_T)$anios)))
})
comprobar("C4", "Toda unidad futura tiene post == 0 con los datos actuales", c4$ok, c4$detalle)

# ---- C5. Las unidades futuras suman 2.564 establecimientos ------------------
# Recuento independiente: RBD que el directorio registra con cod_depe2 == "1"
# en las comunas de las olas futuras del catálogo.

c5 <- evaluar({
  suma <- sum(campo_futuras(exigir(DATA_T)$meta, "cat"))
  ind  <- exigir(est_fut_ind)
  list(ok = suma == ESPERADO_EST_FUTURAS && ind == ESPERADO_EST_FUTURAS,
       detalle = sprintf("suma en DATA %s; recuento independiente del directorio %s; esperado %s",
                         format(suma, big.mark = ".", decimal.mark = ","),
                         format(ind, big.mark = ".", decimal.mark = ","),
                         format(ESPERADO_EST_FUTURAS, big.mark = ".", decimal.mark = ",")))
})
comprobar("C5", "La suma de establecimientos de las unidades futuras es 2.564", c5$ok, c5$detalle)

# ---- Referente (D35-1): rótulo y marca de ola -------------------------------
# El referente sigue anclado en el primer año de la serie (decisión D35-1 en
# 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md).
# Su rótulo dice el tamaño del grupo y, aparte, cuántos tienen resultado en el
# año y la prueba en pantalla; cuando la serie llegue a una ola de traspaso, una
# marca en la pista anuncia que el grupo cambia de composición. R2, R4 y R6
# leen la vista en Chrome sin interfaz (chromote). R1 a R4 se escribieron antes
# del código (sesión 35); R5 y R6, antes del código de la enmienda D35-4, que
# cuenta el referente por ola con el directorio (encargo pendientes s35b).

# Valores esperados con los insumos vigentes (enmienda D35-4): el referente,
# cuántos de sus establecimientos están presentes en el directorio y cuántos
# traspasa cada ola, según la comuna que el directorio les registra y el
# catálogo de olas. Los 17 que faltan para 1.299 cerraron antes de su traspaso y
# no están en el directorio. Hasta el encargo pendientes s35b, las olas se
# contaban por la comuna de la fila más reciente en simce_rbd (479, 407 y 408,
# con 12 de los 17 cerrados dentro).
ESPERADO_REF_CAT  <- 1299L
ESPERADO_REF_VIG  <- 1282L
ESPERADO_REF_OLAS <- c("2027" = 475L, "2028" = 406L, "2029" = 401L)
# R3 agrega un año sintético que copia el último año publicado del referente;
# los establecimientos de OLA_SINTETICA pasan a la dependencia de un Servicio
# Local (cod_depe2 "5"), como si se hubieran traspasado.
ANIO_SINTETICO <- 2027L
OLA_SINTETICA  <- 2027L
DEPE_SLEP      <- "5"
# Vista en el navegador: ancho de escritorio, selector de las marcas de ola y la
# espera a que la vista termine de dibujar (redibuja cuando cargan las fuentes).
ANCHO_NAVEGADOR  <- 1280L
ALTO_NAVEGADOR   <- 900L
SELECTOR_MARCA   <- ".marca-ola"
TEXTO_AUN_MUNICIPALES <- "aún municipales"
ESPERA_DIBUJO_JS <- paste0(
  "(document.fonts ? document.fonts.ready : Promise.resolve()).then(() => new Promise(r => ",
  "setTimeout(() => requestAnimationFrame(() => requestAnimationFrame(() => r(true))), 100)))"
)

# Abre un HTML local en Chrome sin interfaz, espera a que la vista dibuje, corre
# `antes` si se pide (un clic, por ejemplo) y devuelve el objeto que `expr`
# (JavaScript) serializa con JSON.stringify.
leer_vista <- function(ruta, expr, antes = NULL) {
  if (!requireNamespace("chromote", quietly = TRUE)) stop("falta el paquete chromote")
  s <- chromote::ChromoteSession$new(width = ANCHO_NAVEGADOR, height = ALTO_NAVEGADOR)
  on.exit(s$close(), add = TRUE)
  s$Emulation$setDeviceMetricsOverride(width = ANCHO_NAVEGADOR, height = ALTO_NAVEGADOR,
                                       deviceScaleFactor = 1, mobile = FALSE)
  cargada <- s$Page$loadEventFired(wait_ = FALSE)
  s$Page$navigate(paste0("file://", normalizePath(ruta, mustWork = TRUE)), wait_ = FALSE)
  s$wait_for(cargada)
  en_pagina <- function(js) {
    r <- s$Runtime$evaluate(js, returnByValue = TRUE, awaitPromise = TRUE)
    if (!is.null(r$exceptionDetails)) stop("JavaScript: ", r$exceptionDetails$text)
    r$result$value
  }
  en_pagina(ESPERA_DIBUJO_JS)
  if (!is.null(antes)) {
    en_pagina(antes)
    en_pagina(ESPERA_DIBUJO_JS)
  }
  jsonlite::fromJSON(en_pagina(sprintf("JSON.stringify(%s)", expr)))
}
JS_ESTADO <- paste0(
  "{lg: document.getElementById('lg').textContent, yr: document.getElementById('yr').textContent, ",
  "np: document.getElementById('c-np').value, gse: document.getElementById('c-gse').value, ",
  "panel: document.getElementById('c-panel').checked ? 1 : 0, ",
  "marcas: Array.from(document.querySelectorAll('", SELECTOR_MARCA, "')).map(m => m.textContent)}"
)
# Clic en el último año de la pista: la vista pasa a ese año.
JS_ULTIMO_ANIO <- paste0(
  "(function(){var c=document.querySelectorAll('#tk [data-tk]');",
  "c[c.length-1].parentNode.dispatchEvent(new MouseEvent('click',{bubbles:true}));return true;})()"
)

# Escribe la vista con otro DATA en tempdir(), la lee en Chrome (tras `antes`)
# y borra el HTML al terminar. La usan los controles de R4 y R6.
leer_vista_con_data <- function(D, expr, antes = NULL) {
  html_control <- tempfile(fileext = ".html")
  json_actual  <- extraer_data(RUTA_HTML)
  pos <- regexpr(json_actual, html, fixed = TRUE)
  if (pos < 0) stop("no se encontró el DATA en la vista escrita")
  writeBin(charToRaw(enc2utf8(paste0(
    substr(html, 1L, pos - 1L), datos_a_json(D),
    substr(html, pos + nchar(json_actual), nchar(html))
  ))), html_control)
  tryCatch(leer_vista(html_control, expr, antes = antes), finally = unlink(html_control))
}

# Establecimientos del referente (recuento independiente de D9) presentes en el
# directorio, leído del parquet sin pasar por 36_funciones_trayectorias.R y sin
# filtrar por dependencia, con la comuna que el directorio les registra; y la
# ola de cada uno: el año que el catálogo de olas (olas_ind) da a esa comuna
# (enmienda D35-4).
ref_ind <- unique(municipal_ind$rbd)
presentes_ind <- intentar({
  p <- read_parquet(file.path(RUTA, "establecimientos_chile.parquet")) |>
    transmute(rbd = as.character(rbd), cod_com_rbd = as.character(cod_com_rbd)) |>
    filter(rbd %in% ref_ind) |>
    distinct()
  if (anyDuplicated(p$rbd) > 0) stop("establecimientos del referente con dos comunas en el directorio")
  p
})
ola_ref_ind <- intentar(
  exigir(presentes_ind) |>
    inner_join(distinct(exigir(olas_ind), cod_comuna, anio_traspaso),
               by = c(cod_com_rbd = "cod_comuna")) |>
    transmute(rbd, ola = as.integer(anio_traspaso))
)
por_ola <- function(ola) {
  t <- table(ola)
  stats::setNames(as.integer(t), names(t))
}
olas_de <- function(meta_ref) {
  o <- meta_ref$olas
  stats::setNames(as.integer(unlist(o)), names(o))
}

# ---- R1. El referente tiene 1.299 establecimientos --------------------------
# Control positivo: un tamaño plantado con uno de más se detecta.

r1_ok <- function(cat_ref) identical(as.integer(cat_ref), ESPERADO_REF_CAT)
r1 <- evaluar({
  cat_ref <- exigir(DATA_T)$meta[[ID_REFERENTE]]$cat
  list(ok = r1_ok(cat_ref) && length(ref_ind) == ESPERADO_REF_CAT && !r1_ok(cat_ref + 1L),
       detalle = sprintf("meta$REF$cat %s; recuento independiente %s; esperado %s; control plantado detectado: %s",
                         fmt_entero(cat_ref), fmt_entero(length(ref_ind)),
                         fmt_entero(ESPERADO_REF_CAT), !r1_ok(cat_ref + 1L)))
})
comprobar("R1", "El referente tiene 1.299 establecimientos con los insumos vigentes", r1$ok, r1$detalle)

# ---- R2. El rótulo dice el tamaño del grupo y cuántos tienen resultado -------
# En la vista escrita, en su estado inicial, la leyenda del referente trae
# meta$REF$cat formateado y el `e` del referente en el año, la prueba, el grupo
# y la cobertura que la página tiene en pantalla; el `e` esperado se lee de DATA.
# Control positivo: el mismo texto no pasa con un `e` plantado con uno de más.

rotulo_ok <- function(lg, cat_ref, anio, e) {
  grepl(sprintf("Referente: %s municipales", fmt_entero(cat_ref)), lg, fixed = TRUE) &&
    grepl(sprintf("con resultado en %s: %s", anio, fmt_entero(e)), lg, fixed = TRUE)
}
r2 <- evaluar({
  D   <- exigir(DATA_T)
  est <- leer_vista(RUTA_HTML, JS_ESTADO)
  e_esp <- D$datos |>
    filter(id == ID_REFERENTE, anio == as.integer(est$yr), np == est$np, g == est$gse,
           panel == as.integer(est$panel)) |>
    pull(e)
  if (length(e_esp) != 1L) stop("el referente no tiene una fila para el estado inicial")
  cat_ref <- D$meta[[ID_REFERENTE]]$cat
  list(ok = rotulo_ok(est$lg, cat_ref, est$yr, e_esp) && !rotulo_ok(est$lg, cat_ref, est$yr, e_esp + 1L),
       detalle = sprintf("estado %s, %s, grupo %s, panel %s; esperado %s y %s; leyenda «%s»",
                         est$yr, est$np, est$gse, est$panel, fmt_entero(cat_ref),
                         fmt_entero(e_esp), est$lg))
})
comprobar("R2", "La leyenda del referente dice el tamaño del grupo y cuántos tienen resultado en pantalla",
          r2$ok, r2$detalle)

# ---- R3. Con datos de una ola, el referente pierde exactamente esos RBD -------
# Copia en memoria de simce_rbd con un año sintético que repite el último año
# publicado del referente, con los establecimientos de OLA_SINTETICA en
# cod_depe2 "5": el referente de ese año pierde exactamente esos
# establecimientos (y sus evaluados) en cada nivel y prueba y en la serie
# combinada. Además, meta$REF$olas cuenta los establecimientos de cada ola igual
# que el recuento independiente por el directorio (enmienda D35-4). Control
# positivo: la misma comparación con un establecimiento de menos en la lista de
# los que salen no pasa.

ultimo_anio <- max(base_g$anio)
copia_r3 <- intentar({
  rbd_ola <- exigir(ola_ref_ind) |> filter(ola == OLA_SINTETICA) |> pull(rbd)
  sinteticas <- insumos$simce |>
    filter(anio == ultimo_anio, rbd %in% ref_ind) |>
    mutate(anio = ANIO_SINTETICO,
           cod_depe2 = if_else(rbd %in% rbd_ola, DEPE_SLEP, cod_depe2))
  insumos_r3 <- insumos
  insumos_r3$simce <- bind_rows(insumos$simce, sinteticas)
  list(DATA = construir_datos_trayectorias(insumos_r3), rbd_ola = rbd_ola)
})
# Diferencia de establecimientos y evaluados del referente entre el último año
# publicado y el sintético, contra la que dejan los `rbd_quitados`.
perdida_exacta <- function(D, rbd_quitados) {
  ref <- D$datos |> filter(id == ID_REFERENTE, g == GSE_TOTAL, panel == 0L)
  obs <- full_join(
    ref |> filter(anio == ultimo_anio) |> select(np, e, n),
    ref |> filter(anio == ANIO_SINTETICO) |> select(np, e_s = e, n_s = n),
    by = "np"
  ) |>
    mutate(e_s = coalesce(e_s, 0L), n_s = coalesce(n_s, 0L), de = e - e_s, dn = n - n_s)
  quitadas <- municipal_ind |> filter(anio == ultimo_anio, rbd %in% rbd_quitados)
  esp <- bind_rows(quitadas, mutate(quitadas, np = NP_TODO)) |>
    summarise(.by = np, de_esp = n_distinct(rbd), dn_esp = as.integer(round(sum(nalu))))
  x <- inner_join(obs, esp, by = "np")
  nrow(x) == nrow(obs) && nrow(x) == nrow(esp) && nrow(x) > 0 &&
    all(x$de == x$de_esp) && all(x$dn == x$dn_esp)
}
r3 <- evaluar({
  cr3 <- exigir(copia_r3)
  olas_datos <- olas_de(exigir(DATA_T)$meta[[ID_REFERENTE]])
  olas_ind_r <- por_ola(exigir(ola_ref_ind)$ola)
  olas_ok <- identical(olas_datos, ESPERADO_REF_OLAS) && identical(olas_ind_r, ESPERADO_REF_OLAS)
  exacta  <- perdida_exacta(cr3$DATA, cr3$rbd_ola)
  con_resultado <- intersect(cr3$rbd_ola, municipal_ind$rbd[municipal_ind$anio == ultimo_anio])
  control <- !perdida_exacta(cr3$DATA, setdiff(cr3$rbd_ola, con_resultado[1]))
  todo <- cr3$DATA$datos |>
    filter(id == ID_REFERENTE, g == GSE_TOTAL, panel == 0L, np == NP_TODO,
           anio %in% c(ultimo_anio, ANIO_SINTETICO)) |>
    arrange(anio)
  list(ok = olas_ok && exacta && control,
       detalle = sprintf(paste0("olas en DATA %s; recuento independiente por el directorio %s; ola %d: %d establecimientos, ",
                                "%d con resultado en %d; serie combinada %s; pérdida exacta: %s; ",
                                "control plantado detectado: %s"),
                         if (length(olas_datos)) a_texto(olas_datos) else "(sin olas)",
                         a_texto(olas_ind_r), OLA_SINTETICA, length(cr3$rbd_ola),
                         length(con_resultado), ultimo_anio,
                         paste(todo$anio, todo$e, sep = ": ", collapse = " -> "), exacta, control))
})
comprobar("R3", "Con un año sintético de la ola 2027 traspasada, el referente pierde exactamente esos establecimientos",
          r3$ok, r3$detalle)

# ---- R4. Las marcas de ola salen de los datos --------------------------------
# meta$REF$marcas trae, por cada ola con establecimientos del referente, el
# primer año de la serie igual o posterior a ella: vacío con los datos actuales
# y no vacío con la copia de R3 (recuento independiente). En la vista escrita no
# hay ninguna marca ni el aviso de cuántos siguen municipales. Control positivo:
# la misma vista con el DATA de la copia de R3 dibuja una marca por año de
# marca, rotulada con su ola, y, en el último año, dice cuántos de los
# presentes en el directorio (meta$REF$vig) siguen municipales (enmienda D35-4).
# El HTML de ese control se escribe en tempdir(), fuera del árbol, y se borra al
# terminar.

marcas_df <- function(m) {
  if (is.null(m)) return(NULL)
  data.frame(anio = vapply(m, function(x) as.integer(x$anio), integer(1)),
             ola  = vapply(m, function(x) as.integer(x$ola), integer(1)))
}
marcas_esperadas <- function(anios, olas) {
  olas <- as.integer(names(olas)[olas > 0])
  olas <- olas[vapply(olas, function(o) any(anios >= o), logical(1))]
  data.frame(anio = vapply(olas, function(o) as.integer(min(anios[anios >= o])), integer(1)),
             ola  = olas)
}
r4 <- evaluar({
  D   <- exigir(DATA_T)
  cr3 <- exigir(copia_r3)
  m_actual <- marcas_df(D$meta[[ID_REFERENTE]]$marcas)
  m_copia  <- marcas_df(cr3$DATA$meta[[ID_REFERENTE]]$marcas)
  datos_ok <- !is.null(m_actual) && nrow(m_actual) == 0L &&
    identical(m_actual, marcas_esperadas(D$anios, ESPERADO_REF_OLAS)) &&
    !is.null(m_copia) && nrow(m_copia) > 0L &&
    identical(m_copia, marcas_esperadas(cr3$DATA$anios, ESPERADO_REF_OLAS))

  vista <- leer_vista(RUTA_HTML, JS_ESTADO)
  vista_ok <- length(vista$marcas) == 0L && !grepl(TEXTO_AUN_MUNICIPALES, vista$lg, fixed = TRUE)

  # Control positivo: la vista escrita con el DATA de la copia de R3, en su
  # último año (el sintético).
  ctrl <- leer_vista_con_data(cr3$DATA, JS_ESTADO, antes = JS_ULTIMO_ANIO)
  vig_ref <- cr3$DATA$meta[[ID_REFERENTE]]$vig
  olas_c  <- olas_de(cr3$DATA$meta[[ID_REFERENTE]])
  siguen  <- vig_ref - sum(olas_c[as.integer(names(olas_c)) <= as.integer(ctrl$yr)])
  aviso   <- sprintf("%s de %s %s", fmt_entero(siguen), fmt_entero(vig_ref), TEXTO_AUN_MUNICIPALES)
  control_ok <- !is.null(m_copia) && length(ctrl$marcas) == nrow(m_copia) &&
    all(grepl(paste0("^sale la ola (", paste(m_copia$ola, collapse = "|"), ")$"), ctrl$marcas)) &&
    grepl(aviso, ctrl$lg, fixed = TRUE)

  list(ok = datos_ok && vista_ok && control_ok,
       detalle = sprintf(paste0("marcas en DATA %d (esperado 0); con la copia de R3 %s; marcas en la vista %d; ",
                                "control con el DATA de la copia en %s: %d marcas «%s» y aviso «%s»: %s"),
                         if (is.null(m_actual)) NA_integer_ else nrow(m_actual),
                         if (is.null(m_copia)) "(sin campo)" else paste(m_copia$anio, m_copia$ola, sep = "/", collapse = ", "),
                         length(vista$marcas), ctrl$yr, length(ctrl$marcas),
                         paste(ctrl$marcas, collapse = " | "), aviso, control_ok))
})
comprobar("R4", "Las marcas de ola salen de los datos: ninguna con los datos actuales, una por ola alcanzada en la copia de R3",
          r4$ok, r4$detalle)

# ---- Referente por ola con el directorio (D35-4) -----------------------------
# La enmienda D35-4 (misma decisión) reemplaza la regla de las olas del
# referente: meta$REF$olas cuenta, por ola, los establecimientos del referente
# presentes en el directorio oficial (con cualquier dependencia), según la
# comuna que el directorio les registra, y meta$REF$vig es cuántos están
# presentes. Los que cerraron antes de su traspaso no están en el directorio y
# no cuentan en ninguna ola; «aún municipales» los descuenta desde el inicio. R5
# y R6 se escribieron antes del código (encargo pendientes s35b, tarea A1). Los
# valores esperados (ESPERADO_REF_VIG y ESPERADO_REF_OLAS) y el recuento
# independiente por el directorio (presentes_ind y ola_ref_ind) se declaran con
# los del referente, antes de R1: R3 y R4 usan la misma regla.

# ---- R5. El referente se cuenta por ola con el directorio: 475, 406 y 401 ------
# meta$REF$olas vale lo esperado por ola, suma 1.282 y coincide con meta$REF$vig;
# el recuento independiente da lo mismo. Control positivo: un reparto con un
# establecimiento de más en la primera ola se detecta.

r5_ok <- function(olas, vig) {
  identical(olas, ESPERADO_REF_OLAS) && sum(olas) == ESPERADO_REF_VIG &&
    identical(as.integer(vig), ESPERADO_REF_VIG)
}
r5 <- evaluar({
  ref        <- exigir(DATA_T)$meta[[ID_REFERENTE]]
  olas_datos <- olas_de(ref)
  olas_dir   <- por_ola(exigir(ola_ref_ind)$ola)
  vig_ind    <- nrow(exigir(presentes_ind))
  plantado   <- olas_dir
  plantado[1] <- plantado[1] + 1L
  control    <- !r5_ok(plantado, vig_ind)
  list(ok = r5_ok(olas_datos, ref$vig) && r5_ok(olas_dir, vig_ind) && control,
       detalle = sprintf(paste0("olas en DATA %s, vig en DATA %s; recuento independiente por el directorio %s, ",
                                "presentes %s y fuera del directorio %s; esperado %s y %s; control plantado detectado: %s"),
                         if (length(olas_datos)) a_texto(olas_datos) else "(sin olas)",
                         if (is.null(ref$vig)) "(sin campo)" else fmt_entero(ref$vig),
                         a_texto(olas_dir), fmt_entero(vig_ind),
                         fmt_entero(length(ref_ind) - vig_ind),
                         a_texto(ESPERADO_REF_OLAS), fmt_entero(ESPERADO_REF_VIG), control))
})
comprobar("R5", "El referente se cuenta por ola con el directorio: 475, 406 y 401, que suman 1.282",
          r5$ok, r5$detalle)

# ---- R6. Con la copia de R3, la leyenda dice «807 de 1.282 aún municipales» ---
# La vista escrita con el DATA de la copia de R3, en su último año (el
# sintético, que ya pasó la ola OLA_SINTETICA), trae el rótulo de D35-4 completo:
# «Referente: 1.299 municipales en 2014 · 1.282 se traspasan entre 2027 y 2029 ·
# con resultado en 2027: <e> · 807 de 1.282 aún municipales». Las cifras
# esperadas salen de las constantes de D35-4 (807 = 1.282 - 475), no del DATA de
# la copia; el año ancla es el primero de la serie y `e` se lee de la copia.
# Control positivo: la misma leyenda no pasa con un establecimiento más de los
# que siguen municipales.

rotulo_d354 <- function(anio_ancla, anio, e, siguen) {
  olas <- as.integer(names(ESPERADO_REF_OLAS)[ESPERADO_REF_OLAS > 0])
  sprintf("Referente: %s municipales en %s · %s se traspasan entre %s y %s · con resultado en %s: %s · %s de %s %s",
          fmt_entero(ESPERADO_REF_CAT), anio_ancla, fmt_entero(ESPERADO_REF_VIG), min(olas), max(olas),
          anio, fmt_entero(e), fmt_entero(siguen), fmt_entero(ESPERADO_REF_VIG), TEXTO_AUN_MUNICIPALES)
}
r6 <- evaluar({
  cr3  <- exigir(copia_r3)
  ctrl <- leer_vista_con_data(cr3$DATA, JS_ESTADO, antes = JS_ULTIMO_ANIO)
  e_esp <- cr3$DATA$datos |>
    filter(id == ID_REFERENTE, anio == as.integer(ctrl$yr), np == ctrl$np, g == ctrl$gse,
           panel == as.integer(ctrl$panel)) |>
    pull(e)
  if (length(e_esp) != 1L) stop("el referente no tiene una fila para el año sintético")
  siguen <- ESPERADO_REF_VIG - ESPERADO_REF_OLAS[[as.character(OLA_SINTETICA)]]
  esperado <- rotulo_d354(min(cr3$DATA$anios), ctrl$yr, e_esp, siguen)
  control  <- !grepl(rotulo_d354(min(cr3$DATA$anios), ctrl$yr, e_esp, siguen + 1L), ctrl$lg, fixed = TRUE)
  list(ok = as.integer(ctrl$yr) == ANIO_SINTETICO && grepl(esperado, ctrl$lg, fixed = TRUE) && control,
       detalle = sprintf("año en pantalla %s; esperado «%s»; leyenda «%s»; control plantado detectado: %s",
                         ctrl$yr, esperado, ctrl$lg, control))
})
comprobar("R6", "Con la copia de R3, la leyenda trae el rótulo de D35-4 y «807 de 1.282 aún municipales»",
          r6$ok, r6$detalle)

# ---- R7. El tooltip del referente dice sus cifras desde DATA (Q-26) ----------
# La vista escrita, en su estado inicial, con el cursor sobre la marca visible
# del referente (un mousemove sobre el elemento que el navegador encuentra en el
# centro de la marca, como el paso del cursor): el tooltip se titula «Referente
# municipal» y su descripción trae el año ancla (el primero de la serie), el
# tamaño del grupo (meta$REF$cat), cuántos están en el directorio y se traspasan
# (meta$REF$vig), con el rango de las olas que traspasan alguno (el mismo del
# rótulo), y cuántos cerraron antes de su traspaso (cat - vig, enmienda D35-4);
# conserva «Conjunto fijo; la marca no usa la escala de tamaño». Todas las
# cifras de la descripción salen de DATA: no hay otras. Hasta el encargo
# pendientes s35c decía «Municipales en 2014 que no están en los 36 Servicios
# Locales del catálogo: los traspasan las olas siguientes», con el año escrito
# en la plantilla y sin los cerrados (Q-26). R7 se escribió antes del código.
# Control positivo: la misma descripción no pasa con un cerrado de más.

TEXTO_CONJUNTO_FIJO <- "Conjunto fijo; la marca no usa la escala de tamaño"
# Marca el tooltip del referente: centra en pantalla su marca visible y mueve el
# cursor sobre el elemento que el navegador encuentra en su centro.
JS_HOVER_REF <- paste0(
  "(function(){window.__hoverRef=false;",
  "var p=[].filter.call(document.querySelectorAll('#g [data-ref]'),function(c){",
  "return +c.getAttribute('opacity')>.3;})[0];if(!p)return false;",
  "p.scrollIntoView({block:'center',inline:'center'});",
  "var b=p.getBoundingClientRect(),x=b.left+b.width/2,y=b.top+b.height/2,t=document.elementFromPoint(x,y);",
  "if(!t||t.closest('svg')!==document.getElementById('g'))return false;",
  "t.dispatchEvent(new MouseEvent('mousemove',{bubbles:true,clientX:x,clientY:y}));",
  "window.__hoverRef=true;return true;})()"
)
JS_TOOLTIP <- paste0(
  "{hover: window.__hoverRef === true, on: document.getElementById('tip').classList.contains('on'), ",
  "titulo: (document.querySelector('#tip b') || {textContent: ''}).textContent, ",
  "kv: Array.from(document.querySelectorAll('#tip .kv')).map(k => k.textContent)}"
)
# Cifras de un texto con el formato de la vista (miles con punto), en orden.
cifras_texto <- function(x) {
  m <- regmatches(x, gregexpr("[0-9]+(\\.[0-9]{3})*", x))[[1]]
  sort(as.integer(gsub(".", "", m, fixed = TRUE)))
}
# La descripción del referente trae cada cifra de DATA en su frase y ninguna otra.
tooltip_ref_ok <- function(texto, ref, anio_ancla, cerrados) {
  olas <- olas_de(ref)
  olas <- sort(as.integer(names(olas)[olas > 0]))
  rango <- if (length(olas) > 1) sprintf("se traspasan entre %d y %d", min(olas), max(olas)) else
    if (length(olas) == 1) sprintf("se traspasan en %d", olas) else "por traspasar"
  partes <- c(sprintf("%s municipales en %s", fmt_entero(ref$cat), anio_ancla),
              sprintf("%s %s", fmt_entero(ref$vig), rango),
              if (cerrados > 0) sprintf("%s %s antes de su traspaso", fmt_entero(cerrados),
                                        if (cerrados == 1) "cerró" else "cerraron"),
              TEXTO_CONJUNTO_FIJO)
  cifras_esp <- sort(as.integer(c(ref$cat, anio_ancla, ref$vig,
                                  if (length(olas) > 1) range(olas) else olas,
                                  if (cerrados > 0) cerrados)))
  all(vapply(partes, grepl, logical(1), x = texto, fixed = TRUE)) &&
    identical(cifras_texto(texto), cifras_esp)
}
r7 <- evaluar({
  ref  <- exigir(DATA_T)$meta[[ID_REFERENTE]]
  if (is.null(ref$vig)) stop("meta$REF no trae vig")
  anio_ancla <- min(exigir(DATA_T)$anios)
  cerrados   <- as.integer(ref$cat) - as.integer(ref$vig)
  tt <- leer_vista(RUTA_HTML, JS_TOOLTIP, antes = JS_HOVER_REF)
  descripcion <- if (length(tt$kv)) tt$kv[length(tt$kv)] else ""
  control <- !tooltip_ref_ok(descripcion, ref, anio_ancla, cerrados + 1L)
  list(ok = isTRUE(tt$hover) && isTRUE(tt$on) && identical(tt$titulo, NOM_REFERENTE) &&
         tooltip_ref_ok(descripcion, ref, anio_ancla, cerrados) && control,
       detalle = sprintf(paste0("cursor sobre la marca: %s; tooltip visible: %s; título «%s»; ",
                                "esperado de DATA: ancla %s, cat %s, vig %s, cerrados %s, olas %s; ",
                                "cifras del texto %s; descripción «%s»; control plantado detectado: %s"),
                         isTRUE(tt$hover), isTRUE(tt$on), tt$titulo, anio_ancla,
                         fmt_entero(ref$cat), fmt_entero(ref$vig), fmt_entero(cerrados),
                         a_texto(olas_de(ref)),
                         paste(cifras_texto(descripcion), collapse = "/"), descripcion, control))
})
comprobar("R7", "El tooltip del referente dice el año ancla, el tamaño, los que se traspasan y los cerrados desde DATA",
          r7$ok, r7$detalle)

# Cierra el navegador que abrió chromote para R2, R4, R6 y R7.
if (requireNamespace("chromote", quietly = TRUE) && chromote::has_default_chromote_object()) {
  try(chromote::default_chromote_object()$close(), silent = TRUE)
}

# ---- Salida ----------------------------------------------------------------

tabla <- do.call(rbind, resultados$filas)
fallan <- sum(tabla$estado == "FALLA")

cat("\n")
cat(sprintf("Resultado: %d pruebas, %d pasan, %d fallan\n",
            nrow(tabla), sum(tabla$estado == "PASA"), fallan))

if (fallan > 0) quit(status = 1)
