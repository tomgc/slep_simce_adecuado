# 36_funciones_trayectorias.R
# Copyright 2026 Tomás Ignacio González Cifuentes — SLEP Costa Central
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#     http://www.apache.org/licenses/LICENSE-2.0
#
# ----------------------------------------------------------------------------
# Funciones y constantes de la vista de trayectorias de los Servicios Locales.
#
# Auxiliar no ejecutable del paso 36 (POLITICA §1.2.4): lo cargan
# 36_generar_trayectorias.R y 36_verificar_trayectorias.R. Reconstruye en R
# la capa de datos del mockup auditado en la sesión 30
# (50_documentacion/andamios/mockup_trayectoria_traspasos.html), cuyo script
# de ensamblado no se versionó.
#
# Insumos (40_salidas/intermedios/):
#   - simce_rbd.parquet      resultados por establecimiento, nivel y prueba
#   - sleps_chile.parquet    catálogo de Servicios Locales (SLEP × RBD)
#   - comunas_chile.parquet  nombres de comuna
#   - establecimientos_chile.parquet  directorio (RBD, comuna, dependencia)
# y (20_insumos/auxiliares/):
#   - dim_slep_comunas.csv   catálogo de olas: comuna × Servicio Local × año de
#                            traspaso, copia de slep_central_datos
#                            (manifiesto_insumos.md, sesión 35)
#
# Expone:
#   - leer_insumos_trayectorias(): los cuatro parquet y el catálogo de olas,
#     con la lectura validada.
#   - base_valida(simce): filas con los tres niveles publicados y coherentes.
#   - unidades_futuras(insumos, tras_vigentes): las unidades de las olas
#     OLAS_FUTURAS (D35-2), validadas contra el catálogo de olas.
#   - filas_referente(base, catalogo): las filas del referente municipal.
#   - olas_referente(municipal, olas) y marcas_ola(anios, olas_ref): los
#     establecimientos del referente por ola y los años de marca de ola (D35-1).
#   - construir_datos_trayectorias(insumos): la lista DATA que consume la
#     plantilla (anios, meta, nac, datos, nube, comunas).
#   - datos_a_json(DATA): el JSON compacto que se inserta en la plantilla.
#   - cifras_notas(insumos, DATA): las cifras de las notas metodológicas, ya
#     formateadas, que el generador inserta en los marcadores __NOTA_*__.
#
# Regla de filas (sesión 33, decisión del titular): la misma del motor
# (invariante 5, 33_generar_html.R), es decir, sin marca de la Agencia y con al
# menos UMBRAL_EVALUADOS evaluados. El mockup de la sesión 30 incluía las filas
# marcadas; `excluir_marcadas = FALSE` reproduce su regla y solo lo usa la
# prueba D10, que coteja la maquinaria de agregación contra él.
#
# Universos (reconstruidos del mockup y comprobados celda a celda contra él en
# la sesión 32, prueba D10 de 36_verificar_trayectorias.R: solo difieren
# cifras que son empates de redondeo, que el mockup resolvía en coma flotante):
#   - Servicios Locales: los RBD del catálogo, con cualquier dependencia.
#   - Referente y nube: los RBD con resultado en el primer año de la serie,
#     municipales en cada fila y fuera del catálogo. Es la regla que declaran
#     las notas de la vista («los 1.333 establecimientos que en 2014 eran
#     municipales»). Ningún grupo socioeconómico se excluye: el único
#     establecimiento municipal fuera de los Servicios Locales con grupo alto
#     no tiene resultado en 2014 (sesión 32; corrige el diagnóstico B31-4).
#   - Unidades futuras (sesión 35, D35-2 en
#     decisiones/20260924_decision_referente_traspasos.md): cada par (Servicio
#     Local, año de traspaso) de las olas OLAS_FUTURAS del catálogo de olas, con
#     los establecimientos que el directorio registra como municipales en sus
#     comunas. Sus series siguen las reglas de los Servicios Locales (filas de
#     cualquier dependencia). No cambian las filas de los Servicios Locales ni
#     del referente: `incluir_futuras = FALSE` reproduce el DATA anterior y la
#     prueba C3 lo coteja.
#   - Olas del referente (sesión 35, D35-1, misma decisión): el referente sigue
#     anclado en el primer año de la serie. Su ficha en `meta` agrega cuántos de
#     sus establecimientos traspasa cada ola de OLAS_FUTURAS (por la comuna de su
#     fila más reciente) y los años de marca de ola, que la vista dibuja en la
#     pista. No cambia ninguna fila de `datos`.
# ----------------------------------------------------------------------------


# ---- Constantes ------------------------------------------------------------

# Dependencia municipal en COD_DEPE2 (glosa en referencia_glosas_simce.md).
DEPE_MUNICIPAL <- "1"

# Una fila entra a la base solo si Adecuado + Elemental + Insuficiente cae en
# este rango: fuera de él, la fila es una celda suprimida (los tres en 0) o un
# redondeo anómalo de la Agencia.
SUMA_NIVELES_MIN <- 99
SUMA_NIVELES_MAX <- 101
# Umbral MINEDUC de evaluados por fila: el mismo que aplica el motor
# (33_generar_html.R, invariante 5). En la base de la vista no descarta ninguna
# fila, porque la Agencia no publica porcentajes por nivel bajo ese umbral
# (sesión 33); se declara igual para que la regla sea la del motor y no dependa
# de esa práctica de publicación.
UMBRAL_EVALUADOS <- 10

# Decimales de los porcentajes publicados en la vista. El redondeo ocurre una
# sola vez, al final, sobre numeradores acumulados (A29-5).
DECIMALES_PCT <- 1L

# La Agencia publica los porcentajes por nivel con un decimal y los evaluados
# como enteros: el numerador nalu × porcentaje × 10 es un entero exacto y el
# redondeo se decide en aritmética entera, igual en toda estación y en todo
# orden de suma. Los empates (un valor exactamente a la mitad de un décimo) se
# resuelven hacia arriba, como REDONDEAR de Excel (sesión 32, duda D1 del
# encargo del traslado: en coma flotante, 655 de 68.840 cifras eran empates que
# cada plataforma resolvía distinto).
ESCALA_PCT <- 10L

# Clave de la serie consolidada de niveles y pruebas.
NP_TODO <- "todo"

# Clave del total de grupos socioeconómicos.
GSE_TOTAL <- "T"

# Identificador y nombre del referente municipal en `meta`.
ID_REFERENTE  <- "REF"
NOM_REFERENTE <- "Referente municipal"

# Orden de presentación de los 36 Servicios Locales (norte a sur por región,
# con la Región Metropolitana al final). Heredado tal cual del mockup de la
# sesión 30: fija la numeración de las burbujas que el titular ya revisó.
ORDEN_SLEP <- c(
  "1501", "101", "102", "202", "301", "302", "401", "402",
  "506", "505", "508", "509", "501", "503", "605", "702", "704",
  "1601", "1602", "807", "801", "802", "902", "1401",
  "1002", "1003", "1101", "1201",
  "1301", "1311", "1302", "1309", "1307", "1305", "1303", "1304"
)

# Olas de traspaso que entran a la vista como cohortes por traspasar (D35-2).
# Se declaran aquí para que una ola nueva del catálogo no entre sin decisión:
# si el catálogo trae un año que no es cohorte vigente ni está en esta lista,
# unidades_futuras() se detiene.
OLAS_FUTURAS <- c(2027L, 2028L, 2029L)

# Regiones de norte a sur, con la Metropolitana al final: ordenan las unidades
# futuras dentro de cada ola, con el mismo criterio de ORDEN_SLEP.
ORDEN_REGIONES <- c(15, 1, 2, 3, 4, 5, 6, 7, 16, 8, 9, 14, 10, 11, 12, 13)

# Identificador de una unidad futura: <cod_slep><SEP_ID_FUTURO><año>. Nunca
# coincide con el código de una unidad vigente, aunque el Servicio Local ya
# tenga una cohorte (Petorca y Valle Diguillín reciben comunas en 2027).
SEP_ID_FUTURO <- "_"

# Nombre de una unidad futura cuyo código ya existe en ORDEN_SLEP.
SUFIJO_FUTURA <- " (comunas que se traspasan en %d)"

# Catálogo de olas en 20_insumos/auxiliares/ y columnas que usa el paso.
ARCHIVO_OLAS  <- "dim_slep_comunas.csv"
COLUMNAS_OLAS <- c("cod_comuna", "cod_slep", "slep_formato", "num_region",
                   "anio_traspaso")


# ---- Lectura ---------------------------------------------------------------

# Lee un parquet de 40_salidas/intermedios/ y comprueba que trae las columnas
# que el paso usa. Se detiene con el nombre de la columna faltante.
leer_intermedio <- function(archivo, columnas) {
  ruta <- here::here("40_salidas", "intermedios", archivo)
  if (!file.exists(ruta)) stop("No existe ", ruta, ". Correr 00_build.R antes.")
  df <- arrow::read_parquet(ruta)
  faltan <- setdiff(columnas, names(df))
  if (length(faltan) > 0) {
    stop(archivo, " no trae las columnas: ", paste(faltan, collapse = ", "))
  }
  df
}

# Hermana de leer_intermedio() para un CSV de 20_insumos/auxiliares/ separado
# por `;`: lee todas las columnas como texto (sin convertir vacíos en NA) y
# comprueba que no hubo problemas de lectura, que trae una fila por línea del
# archivo (menos el encabezado) y las columnas que el paso usa.
leer_auxiliar_csv <- function(archivo, columnas) {
  ruta <- here::here("20_insumos", "auxiliares", archivo)
  if (!file.exists(ruta)) stop("No existe ", ruta, ". Ver manifiesto_insumos.md.")
  df <- readr::read_delim(
    ruta, delim = ";",
    col_types = readr::cols(.default = readr::col_character()),
    na = character(), trim_ws = FALSE,
    locale = readr::locale(encoding = "UTF-8"),
    show_col_types = FALSE, progress = FALSE
  )
  if (nrow(readr::problems(df)) > 0) {
    stop(archivo, ": ", nrow(readr::problems(df)), " problemas de lectura")
  }
  lineas <- length(readLines(ruta, encoding = "UTF-8", warn = FALSE))
  if (nrow(df) != lineas - 1L) {
    stop(archivo, ": se leyeron ", nrow(df), " filas para ", lineas - 1L,
         " líneas de datos")
  }
  faltan <- setdiff(columnas, names(df))
  if (length(faltan) > 0) {
    stop(archivo, " no trae las columnas: ", paste(faltan, collapse = ", "))
  }
  df
}

leer_insumos_trayectorias <- function() {
  list(
    simce = leer_intermedio(
      "simce_rbd.parquet",
      c("anio", "nivel", "prueba", "rbd", "cod_com_rbd", "cod_grupo",
        "cod_depe2", "nalu", "palu_eda_ade", "palu_eda_ele", "palu_eda_ins",
        "marca")
    ),
    sleps = leer_intermedio(
      "sleps_chile.parquet",
      c("cod_slep", "nombre_slep", "anio_traspaso", "rbd")
    ),
    comunas = leer_intermedio(
      "comunas_chile.parquet",
      c("cod_com_rbd", "nom_com_rbd")
    ),
    establecimientos = leer_intermedio(
      "establecimientos_chile.parquet",
      c("rbd", "nom_rbd", "cod_com_rbd", "nom_com_rbd", "cod_depe2")
    ),
    olas = leer_auxiliar_csv(ARCHIVO_OLAS, COLUMNAS_OLAS)
  )
}


# ---- Base y agregación -----------------------------------------------------

# Filas con los tres niveles y el número de evaluados publicados, y con una
# suma de niveles coherente; con `excluir_marcadas = TRUE` (la regla vigente),
# además sin marca de la Agencia y con al menos UMBRAL_EVALUADOS evaluados.
# Agrega la clave nivel_prueba y los numeradores crudos de Adecuado e
# Insuficiente.
base_valida <- function(simce, excluir_marcadas = TRUE) {
  base <- simce |>
    dplyr::filter(
      !is.na(palu_eda_ade), !is.na(palu_eda_ele), !is.na(palu_eda_ins),
      !is.na(nalu)
    ) |>
    dplyr::mutate(suma_niveles = palu_eda_ade + palu_eda_ele + palu_eda_ins) |>
    dplyr::filter(suma_niveles >= SUMA_NIVELES_MIN,
                  suma_niveles <= SUMA_NIVELES_MAX)
  if (excluir_marcadas) {
    base <- base |> dplyr::filter(is.na(marca), nalu >= UMBRAL_EVALUADOS)
  }
  base |>
    dplyr::mutate(
      rbd     = as.character(rbd),
      anio    = as.integer(anio),
      np      = paste0(nivel, "_", prueba),
      p_ade   = round(palu_eda_ade * ESCALA_PCT),
      p_ins   = round(palu_eda_ins * ESCALA_PCT)
    )
}

# Porcentaje con DECIMALES_PCT decimales a partir de un numerador y un
# denominador enteros (num / den = porcentaje × ESCALA_PCT), redondeado en
# aritmética entera con los empates hacia arriba. Los enteros caben de sobra
# en la precisión exacta de un double (menos de 2^53).
redondear_exacto <- function(num, den) {
  ((2 * num + den) %/% (2 * den)) / ESCALA_PCT
}

# Agrega por `claves`: porcentajes ponderados por evaluados, evaluados y
# establecimientos distintos. Redondeo único al final.
agregar_trayectorias <- function(df, claves) {
  df |>
    dplyr::summarise(
      .by = dplyr::all_of(claves),
      ade_num = sum(nalu * p_ade),
      ins_num = sum(nalu * p_ins),
      den     = sum(nalu),
      n   = as.integer(round(sum(nalu))),
      e   = dplyr::n_distinct(rbd)
    ) |>
    dplyr::mutate(ade = redondear_exacto(ade_num, den),
                  ins = redondear_exacto(ins_num, den))
}

# Duplica las filas bajo la clave NP_TODO: la serie que combina los dos
# niveles y las dos pruebas.
con_todo <- function(df) {
  dplyr::bind_rows(df, dplyr::mutate(df, np = NP_TODO))
}

# Total (GSE_TOTAL) más un desglose por grupo socioeconómico.
total_y_grupos <- function(df, claves) {
  dplyr::bind_rows(
    agregar_trayectorias(df, claves) |> dplyr::mutate(g = GSE_TOTAL),
    agregar_trayectorias(df, c(claves, "cod_grupo")) |>
      dplyr::rename(g = cod_grupo)
  )
}

# Serie completa: para cada nivel y prueba, los establecimientos con resultado
# en todos los años; para la serie NP_TODO, los que tienen algún resultado en
# todos los años. Devuelve las filas de `df` que pertenecen al panel fijo, con
# la serie NP_TODO ya incluida.
panel_fijo <- function(df, n_anios) {
  completos_np <- df |>
    dplyr::summarise(.by = c(rbd, np), k = dplyr::n_distinct(anio)) |>
    dplyr::filter(k == n_anios) |>
    dplyr::select(rbd, np)
  completos_rbd <- df |>
    dplyr::summarise(.by = rbd, k = dplyr::n_distinct(anio)) |>
    dplyr::filter(k == n_anios) |>
    dplyr::pull(rbd)
  dplyr::bind_rows(
    dplyr::semi_join(df, completos_np, by = c("rbd", "np")),
    df |> dplyr::filter(rbd %in% completos_rbd) |> dplyr::mutate(np = NP_TODO)
  )
}

# Filas de `datos` para un universo con identificador `id`: panel 0 (todos los
# establecimientos con resultado) y panel 1 (serie completa).
filas_datos <- function(df, n_anios) {
  dplyr::bind_rows(
    total_y_grupos(con_todo(df), c("id", "anio", "np")) |>
      dplyr::mutate(panel = 0L),
    total_y_grupos(panel_fijo(df, n_anios), c("id", "anio", "np")) |>
      dplyr::mutate(panel = 1L)
  )
}

# Orden de las claves de grupo: el total primero, después los grupos.
orden_gse <- function(g) ifelse(g == GSE_TOTAL, "0", g)


# ---- Unidades futuras (D35-2) ----------------------------------------------

# Unidades de las olas OLAS_FUTURAS: una por par (Servicio Local, año de
# traspaso) del catálogo de olas, con los establecimientos que el directorio
# registra como municipales (cod_depe2 == DEPE_MUNICIPAL) en sus comunas.
# `tras_vigentes` son los años de traspaso del catálogo de Servicios Locales.
# Devuelve `fichas` (id, nom, tras, cat), en el orden de la vista (ola, región
# de norte a sur y código), y `rbd` (id, rbd). Se detiene si el catálogo de
# olas no cuadra con ORDEN_SLEP, con OLAS_FUTURAS o con el directorio.
unidades_futuras <- function(insumos, tras_vigentes) {
  olas <- insumos$olas |>
    dplyr::mutate(anio = as.integer(anio_traspaso), region = as.integer(num_region))
  if (anyNA(olas$anio) || anyNA(olas$region)) {
    stop(ARCHIVO_OLAS, ": anio_traspaso o num_region no numéricos")
  }
  if (anyDuplicated(olas$cod_comuna) > 0) {
    stop(ARCHIVO_OLAS, ": comunas repetidas: ",
         paste(unique(olas$cod_comuna[duplicated(olas$cod_comuna)]), collapse = ", "))
  }

  # -- El catálogo de olas contra las cohortes vigentes y OLAS_FUTURAS --
  ya_vigentes <- intersect(OLAS_FUTURAS, tras_vigentes)
  if (length(ya_vigentes) > 0) {
    stop("OLAS_FUTURAS incluye años que ya son cohortes vigentes: ",
         paste(ya_vigentes, collapse = ", "))
  }
  sin_decision <- setdiff(olas$anio, c(tras_vigentes, OLAS_FUTURAS))
  if (length(sin_decision) > 0) {
    stop(ARCHIVO_OLAS, " trae años de traspaso que no son cohortes vigentes ni ",
         "OLAS_FUTURAS: ", paste(sort(sin_decision), collapse = ", "))
  }
  sin_olas <- setdiff(OLAS_FUTURAS, olas$anio)
  if (length(sin_olas) > 0) {
    stop(ARCHIVO_OLAS, " no trae comunas para las olas: ", paste(sin_olas, collapse = ", "))
  }
  cod_vigentes <- unique(olas$cod_slep[!olas$anio %in% OLAS_FUTURAS])
  if (!setequal(cod_vigentes, ORDEN_SLEP)) {
    stop(ARCHIVO_OLAS, " no coincide con ORDEN_SLEP en las cohortes vigentes: ",
         paste(sort(setdiff(union(cod_vigentes, ORDEN_SLEP),
                            intersect(cod_vigentes, ORDEN_SLEP))),
               collapse = ", "))
  }

  futuras <- dplyr::filter(olas, anio %in% OLAS_FUTURAS)
  fuera_de_orden <- setdiff(futuras$region, ORDEN_REGIONES)
  if (length(fuera_de_orden) > 0) {
    stop("Regiones de las olas futuras fuera de ORDEN_REGIONES: ",
         paste(fuera_de_orden, collapse = ", "))
  }
  fichas <- futuras |>
    dplyr::summarise(.by = c(cod_slep, anio),
                     nom    = dplyr::first(slep_formato),
                     region = dplyr::first(region),
                     k_nom  = dplyr::n_distinct(slep_formato),
                     k_reg  = dplyr::n_distinct(region))
  ambiguas <- fichas |> dplyr::filter(k_nom != 1L | k_reg != 1L)
  if (nrow(ambiguas) > 0) {
    stop("Unidades futuras con más de un nombre o región: ",
         paste(ambiguas$cod_slep, ambiguas$anio, sep = SEP_ID_FUTURO, collapse = ", "))
  }

  # -- Establecimientos: municipales del directorio en las comunas de cada ola --
  directorio <- insumos$establecimientos |>
    dplyr::mutate(rbd = as.character(rbd), cod_com_rbd = as.character(cod_com_rbd))
  sin_directorio <- setdiff(futuras$cod_comuna, directorio$cod_com_rbd)
  if (length(sin_directorio) > 0) {
    stop("Comunas de las olas futuras sin establecimientos en el directorio: ",
         paste(sin_directorio, collapse = ", "))
  }
  rbd_fut <- directorio |>
    dplyr::filter(cod_depe2 == DEPE_MUNICIPAL) |>
    dplyr::inner_join(dplyr::select(futuras, cod_comuna, cod_slep, anio),
                      by = c(cod_com_rbd = "cod_comuna")) |>
    dplyr::mutate(id = paste0(cod_slep, SEP_ID_FUTURO, anio)) |>
    dplyr::distinct(id, rbd)
  if (anyDuplicated(rbd_fut$rbd) > 0) {
    stop("Establecimientos en más de una unidad futura: ",
         paste(unique(rbd_fut$rbd[duplicated(rbd_fut$rbd)]), collapse = ", "))
  }

  fichas <- fichas |>
    dplyr::mutate(
      id  = paste0(cod_slep, SEP_ID_FUTURO, anio),
      nom = ifelse(cod_slep %in% ORDEN_SLEP, paste0(nom, sprintf(SUFIJO_FUTURA, anio)), nom)
    ) |>
    dplyr::left_join(dplyr::count(rbd_fut, id, name = "cat"), by = "id") |>
    dplyr::arrange(anio, match(region, ORDEN_REGIONES), as.integer(cod_slep))
  if (anyNA(fichas$cat)) {
    stop("Unidades futuras sin establecimientos municipales en el directorio: ",
         paste(fichas$id[is.na(fichas$cat)], collapse = ", "))
  }
  if (any(fichas$id %in% ORDEN_SLEP) || anyDuplicated(fichas$id) > 0) {
    stop("Identificadores de unidades futuras repetidos o iguales a uno vigente")
  }

  list(fichas = dplyr::transmute(fichas, id, nom, tras = anio, cat = as.integer(cat)),
       rbd = rbd_fut)
}


# ---- Referente: filas, olas y marcas de ola (D35-1) ------------------------

# Filas del referente municipal: las de los establecimientos con resultado en el
# primer año de la serie, municipales en cada fila y fuera del catálogo de
# Servicios Locales (`catalogo`, con rbd como texto). Un establecimiento que se
# traspasa deja de ser municipal y sus filas siguientes salen solas: el grupo
# queda anclado y pierde cada ola en el año en que se traspasa.
filas_referente <- function(base, catalogo) {
  rbd_ancla <- unique(base$rbd[base$anio == min(base$anio)])
  dplyr::filter(base,
                cod_depe2 == DEPE_MUNICIPAL,
                !rbd %in% catalogo$rbd,
                rbd %in% rbd_ancla)
}

# Establecimientos del referente que traspasa cada ola de OLAS_FUTURAS: cada uno
# va a la ola que el catálogo de olas (`olas`) da a la comuna de su fila más
# reciente, que es la comuna donde está hoy (uno cambió de comuna entre 2014 y
# 2015). Los que están en comunas ya traspasadas no cuentan en ninguna ola
# (cerraron antes de su traspaso, decisión D35-1). Devuelve un entero por ola,
# con el año como nombre, en el orden de OLAS_FUTURAS.
olas_referente <- function(municipal, olas) {
  comuna <- municipal |>
    dplyr::filter(.by = rbd, anio == max(anio)) |>
    dplyr::distinct(rbd, cod_com_rbd = as.character(cod_com_rbd))
  if (anyDuplicated(comuna$rbd) > 0) {
    stop("Establecimientos del referente con más de una comuna en su último año: ",
         paste(unique(comuna$rbd[duplicated(comuna$rbd)]), collapse = ", "))
  }
  ola <- comuna |>
    dplyr::inner_join(dplyr::transmute(olas, cod_com_rbd = cod_comuna,
                                       ola = as.integer(anio_traspaso)),
                      by = "cod_com_rbd") |>
    dplyr::filter(ola %in% OLAS_FUTURAS)
  stats::setNames(vapply(OLAS_FUTURAS, function(o) sum(ola$ola == o), integer(1)),
                  OLAS_FUTURAS)
}

# Marcas de ola: por cada ola con establecimientos del referente, el primer año
# de la serie igual o posterior a ella, que es donde el grupo pierde esa ola.
# Una lista de pares (anio, ola), vacía mientras la serie no llegue a ninguna
# ola. La vista dibuja cada marca en su año de la pista.
marcas_ola <- function(anios, olas_ref) {
  olas <- as.integer(names(olas_ref)[olas_ref > 0])
  alcanzadas <- olas[vapply(olas, function(o) any(anios >= o), logical(1))]
  lapply(alcanzadas, function(o) list(anio = min(anios[anios >= o]), ola = o))
}


# ---- Construcción de DATA --------------------------------------------------

# `conservar_brutos = TRUE` agrega a `datos` y `nube` los numeradores y el
# denominador enteros (ade_num, ins_num, den); solo lo usa la verificación,
# para distinguir un empate de redondeo de una diferencia real.
# `excluir_marcadas` pasa a base_valida(); FALSE solo para la prueba D10.
# `incluir_futuras = TRUE` agrega las unidades de las olas OLAS_FUTURAS (D35-2)
# después de las vigentes, y a la ficha del referente sus olas y marcas de ola
# (D35-1); FALSE reproduce el DATA anterior a la sesión 35 y solo lo usan las
# pruebas C3 y D10.
construir_datos_trayectorias <- function(insumos, conservar_brutos = FALSE,
                                         excluir_marcadas = TRUE,
                                         incluir_futuras = TRUE) {
  catalogo <- insumos$sleps |>
    dplyr::mutate(rbd = as.character(rbd), cod_slep = as.character(cod_slep))

  base <- base_valida(insumos$simce, excluir_marcadas)

  anios   <- sort(unique(base$anio))
  n_anios <- length(anios)

  # -- Universos --
  # Servicios Locales: los establecimientos del catálogo, con cualquier
  # dependencia (eran municipales antes del traspaso).
  slep <- base |>
    dplyr::inner_join(dplyr::distinct(catalogo, cod_slep, rbd), by = "rbd") |>
    dplyr::rename(id = cod_slep)

  # Referente y nube: establecimientos con resultado en el primer año de la
  # serie, municipales en cada fila y fuera del catálogo de Servicios Locales.
  municipal <- filas_referente(base, catalogo)

  # -- meta --
  fichas <- catalogo |>
    dplyr::summarise(.by = cod_slep,
                     nom  = dplyr::first(nombre_slep),
                     tras = as.integer(dplyr::first(anio_traspaso)),
                     cat  = dplyr::n_distinct(rbd))
  if (!setequal(fichas$cod_slep, ORDEN_SLEP)) {
    stop("ORDEN_SLEP no coincide con el catálogo de Servicios Locales: ",
         paste(sort(setdiff(union(fichas$cod_slep, ORDEN_SLEP),
                            intersect(fichas$cod_slep, ORDEN_SLEP))),
               collapse = ", "))
  }
  meta <- lapply(ORDEN_SLEP, function(cod) {
    f <- fichas[fichas$cod_slep == cod, ]
    list(nom = f$nom, tras = f$tras, post = sum(anios >= f$tras), cat = f$cat)
  })
  names(meta) <- ORDEN_SLEP

  # Unidades futuras: después de las vigentes, en el orden de unidades_futuras().
  # `post` se calcula como en las vigentes (0 mientras no haya datos del año de
  # la ola).
  futuras <- NULL
  if (incluir_futuras) {
    futuras  <- unidades_futuras(insumos, unique(fichas$tras))
    meta_fut <- lapply(seq_len(nrow(futuras$fichas)), function(i) {
      f <- futuras$fichas[i, ]
      list(nom = f$nom, tras = f$tras, post = sum(anios >= f$tras), cat = f$cat)
    })
    names(meta_fut) <- futuras$fichas$id
    meta <- c(meta, meta_fut)
  }
  meta_ref <- list(nom = NOM_REFERENTE, tras = 0L, post = -1L,
                   cat = dplyr::n_distinct(municipal$rbd))
  # Olas y marcas de ola del referente (D35-1): `olas` da el rango de años del
  # rótulo y cuántos siguen municipales después de cada marca; `marcas`, los
  # años de la pista donde el grupo pierde una ola.
  if (incluir_futuras) {
    olas_ref <- olas_referente(municipal, insumos$olas)
    meta_ref$olas   <- as.list(olas_ref)
    meta_ref$marcas <- marcas_ola(anios, olas_ref)
  }
  meta[[ID_REFERENTE]] <- meta_ref

  # -- nac: todos los establecimientos del país --
  nac_df <- total_y_grupos(con_todo(base), c("anio", "np")) |>
    dplyr::mutate(clave = paste0(np, "|", g),
                  bloque = ifelse(g == GSE_TOTAL, 0L, 1L)) |>
    dplyr::arrange(bloque, np, orden_gse(g), anio)
  nac <- lapply(split(nac_df, factor(nac_df$clave, levels = unique(nac_df$clave))),
                function(d) {
                  v <- lapply(seq_len(nrow(d)), function(i) c(d$ade[i], d$ins[i]))
                  names(v) <- as.character(d$anio)
                  v
                })

  # -- datos: Servicios Locales, referente y unidades futuras --
  # Las futuras se agregan aparte, con su propio panel fijo: sus filas no tocan
  # las de los Servicios Locales ni las del referente (prueba C3).
  datos_df <- dplyr::bind_rows(
    filas_datos(slep, n_anios),
    filas_datos(dplyr::mutate(municipal, id = ID_REFERENTE), n_anios),
    if (incluir_futuras) {
      filas_datos(dplyr::inner_join(base, futuras$rbd, by = "rbd"), n_anios)
    }
  ) |>
    dplyr::arrange(panel, orden_gse(g), id, anio, np) |>
    dplyr::select(id, anio, np, g, panel, ade, ins, n, e,
                  dplyr::any_of(if (conservar_brutos) c("ade_num", "ins_num", "den")))

  # -- nube: una fila por comuna con sus establecimientos municipales --
  nube_df <- total_y_grupos(con_todo(dplyr::rename(municipal, com = cod_com_rbd)),
                            c("com", "anio", "np")) |>
    dplyr::arrange(orden_gse(g), com, anio, np) |>
    dplyr::select(com, anio, np, g, ade, ins, n,
                  dplyr::any_of(if (conservar_brutos) c("ade_num", "ins_num", "den")))

  # -- comunas: nombre en tipo título, solo las de la nube --
  comunas_df <- insumos$comunas |>
    dplyr::filter(cod_com_rbd %in% nube_df$com) |>
    dplyr::distinct(cod_com_rbd, nom_com_rbd) |>
    dplyr::arrange(cod_com_rbd)
  comunas <- as.list(stringr::str_to_title(comunas_df$nom_com_rbd))
  names(comunas) <- comunas_df$cod_com_rbd

  list(anios = anios, meta = meta, nac = nac,
       datos = datos_df, nube = nube_df, comunas = comunas)
}

# Serializa DATA como JSON compacto: `datos` y `nube` como arreglos de filas
# ([id, anio, np, g, panel, ade, ins, n, e] y [com, anio, np, g, ade, ins, n]),
# que es la forma que lee la plantilla.
datos_a_json <- function(DATA) {
  enc2utf8(as.character(jsonlite::toJSON(
    DATA, dataframe = "values", auto_unbox = TRUE, digits = NA,
    null = "null", na = "null"
  )))
}


# ---- Cifras de las notas metodológicas -------------------------------------
# Las notas de la vista citan cifras de los datos. Hasta la sesión 32 eran
# literales copiados del mockup y quedaban obsoletas con cualquier cambio de
# regla o de año; desde la sesión 33 las calcula esta función y el generador
# las inserta en los marcadores __NOTA_<NOMBRE>__ de la plantilla.
#
# Definiciones (sesión 33). Movimiento anual: cambio absoluto de % Adecuado
# entre años medidos consecutivos, por Servicio Local y por nivel y prueba, en
# el total de grupos y el panel de todos los establecimientos; la mediana sobre
# los Servicios Locales y el máximo del referente. Correlación: Pearson entre
# ese cambio y el cambio nacional del mismo nivel, prueba y año. Las cifras
# 2,9 y 0,53 que traía el mockup no se reproducen con ninguna definición
# medida sobre su propio DATA; con esta, el mockup da 2,1 y 0,52. El ejemplo
# de la nube (Palena, 2018) es una ilustración elegida a mano: queda literal en
# la plantilla y la prueba D11 comprueba que sigue en los datos.

# Serie en que se mide la variación de la composición: la que la vista abre por
# defecto (4° básico, Lectura).
NP_NOTAS <- "4b_lect"
# Variación de la composición que la nota declara: (máximo - mínimo) / máximo
# de los establecimientos con resultado, por Servicio Local.
UMBRAL_COMPOSICION <- 0.20

# Formato de cifras en español: miles con punto y decimales con coma. Los
# decimales se redondean con los empates hacia arriba, como el resto de la
# vista (el margen absorbe el error de representación binaria).
fmt_entero <- function(x) {
  formatC(as.numeric(x), format = "f", digits = 0, big.mark = ".",
          decimal.mark = ",")
}
fmt_decimal <- function(x, decimales) {
  escala <- 10^decimales
  formatC(floor(x * escala + 0.5 + 1e-9) / escala, format = "f",
          digits = decimales, big.mark = ".", decimal.mark = ",")
}

# Cambio absoluto de % Adecuado entre años medidos consecutivos de una serie
# (2018 a 2022 cuenta como consecutivo: no hay medición entre ellos).
cambios_anuales <- function(df, claves) {
  df |>
    dplyr::arrange(anio) |>
    dplyr::mutate(.by = dplyr::all_of(claves), d_ade = ade - dplyr::lag(ade)) |>
    dplyr::filter(!is.na(d_ade))
}

# Universo de cada cifra (sesión 35, D35-2). Las que hablan de Servicios
# Locales (filas, pares por grupo, movimiento, correlación y composición) se
# calculan sobre los vigentes, los del catálogo sleps_chile, igual que antes de
# las cohortes por traspasar: las notas lo declaran. N_UNIDADES, la del marco
# de los ejes, cuenta todas las unidades de la vista. N_FUTURAS, N_EST_FUTURAS
# y OLA_* describen solo las cohortes por traspasar. N_CERRADOS (D35-1) cuenta
# los establecimientos del referente que no están en el directorio oficial.
#
# Devuelve una lista con nombre: cada elemento es el texto que reemplaza al
# marcador __NOTA_<nombre>__.
cifras_notas <- function(insumos, DATA, excluir_marcadas = TRUE) {
  catalogo <- insumos$sleps |>
    dplyr::mutate(rbd = as.character(rbd), cod_slep = as.character(cod_slep))
  np_pruebas <- setdiff(unique(DATA$datos$np), NP_TODO)

  # -- Unidades: vigentes (catálogo de Servicios Locales) y por traspasar --
  cod_vigentes <- unique(catalogo$cod_slep)
  ids_futuras  <- setdiff(names(DATA$meta), c(cod_vigentes, ID_REFERENTE))
  if (length(ids_futuras) == 0) {
    stop("cifras_notas() espera el DATA con las unidades futuras (incluir_futuras = TRUE)")
  }
  tras_de <- function(ids) vapply(DATA$meta[ids], function(m) as.integer(m$tras), integer(1))
  cat_futuras <- vapply(DATA$meta[ids_futuras], function(m) as.integer(m$cat), integer(1))

  # -- Filas de los Servicios Locales: qué entra y qué se cae --
  filas_slep <- insumos$simce |>
    dplyr::mutate(rbd = as.character(rbd)) |>
    dplyr::semi_join(dplyr::distinct(catalogo, rbd), by = "rbd") |>
    dplyr::mutate(
      con_pct = !is.na(palu_eda_ade) & !is.na(palu_eda_ele) &
        !is.na(palu_eda_ins) & !is.na(nalu),
      suma = palu_eda_ade + palu_eda_ele + palu_eda_ins,
      coherente = con_pct & suma >= SUMA_NIVELES_MIN & suma <= SUMA_NIVELES_MAX,
      marcada = coherente & (!is.na(marca) | nalu < UMBRAL_EVALUADOS)
    )
  n_marcadas <- if (excluir_marcadas) sum(filas_slep$marcada) else 0L
  pct_marcadas <- 100 * sum(filas_slep$nalu[filas_slep$marcada]) /
    sum(filas_slep$nalu[filas_slep$coherente])

  # -- Pares Servicio Local por grupo y grupos que cambian entre niveles --
  base <- base_valida(insumos$simce, excluir_marcadas)
  pares_existen <- base |>
    dplyr::inner_join(dplyr::distinct(catalogo, cod_slep, rbd), by = "rbd") |>
    dplyr::filter(!is.na(cod_grupo)) |>
    dplyr::distinct(cod_slep, cod_grupo) |>
    nrow()
  n_grupos <- dplyr::n_distinct(base$cod_grupo, na.rm = TRUE)
  grupos_escuela <- base |>
    dplyr::filter(!is.na(cod_grupo)) |>
    dplyr::summarise(.by = c(rbd, anio), grupos = dplyr::n_distinct(cod_grupo))

  # -- Referente: los que cerraron antes de su traspaso (D35-1) --
  # Son los establecimientos del referente que ya no están en el directorio
  # oficial, con cualquier dependencia.
  rbd_ref <- unique(filas_referente(base, catalogo)$rbd)
  if (length(rbd_ref) != DATA$meta[[ID_REFERENTE]]$cat) {
    stop("cifras_notas(): el referente de los insumos (", length(rbd_ref),
         ") no coincide con el de DATA (", DATA$meta[[ID_REFERENTE]]$cat, ")")
  }
  n_cerrados <- sum(!rbd_ref %in% as.character(insumos$establecimientos$rbd))

  # -- Movimiento anual: Servicios Locales, referente y país --
  series <- DATA$datos |>
    dplyr::filter(g == GSE_TOTAL, panel == 0L, np %in% np_pruebas)
  mov_slep <- cambios_anuales(dplyr::filter(series, id %in% cod_vigentes), c("id", "np"))
  mov_ref  <- cambios_anuales(dplyr::filter(series, id == ID_REFERENTE), c("id", "np"))
  nac_df <- do.call(rbind, lapply(names(DATA$nac), function(k) {
    partes <- strsplit(k, "|", fixed = TRUE)[[1]]
    data.frame(np = partes[1], g = partes[2],
               anio = as.integer(names(DATA$nac[[k]])),
               ade = vapply(DATA$nac[[k]], `[`, numeric(1), 1))
  }))
  mov_nac <- cambios_anuales(
    dplyr::filter(nac_df, g == GSE_TOTAL, np %in% np_pruebas), "np"
  )
  cotejo_nac <- dplyr::inner_join(mov_slep, mov_nac, by = c("np", "anio"),
                                  suffix = c("", "_nac"))

  # -- Composición: variación de los establecimientos con resultado --
  composicion <- DATA$datos |>
    dplyr::filter(g == GSE_TOTAL, panel == 0L, np == NP_NOTAS, id %in% cod_vigentes) |>
    dplyr::summarise(.by = id, var = (max(e) - min(e)) / max(e))

  list(
    N_REFERENTE      = fmt_entero(DATA$meta[[ID_REFERENTE]]$cat),
    N_CERRADOS       = fmt_entero(n_cerrados),
    N_COMUNAS        = fmt_entero(length(DATA$comunas)),
    MOV_MEDIANA      = fmt_decimal(stats::median(abs(mov_slep$d_ade)), 1),
    MOV_REF_MAX      = fmt_decimal(max(abs(mov_ref$d_ade)), 1),
    CORR_NAC         = fmt_decimal(stats::cor(cotejo_nac$d_ade, cotejo_nac$d_ade_nac), 2),
    N_COMPOSICION    = fmt_entero(sum(composicion$var > UMBRAL_COMPOSICION)),
    FILAS_TOTAL      = fmt_entero(nrow(filas_slep)),
    FILAS_SIN_PCT    = fmt_entero(sum(!filas_slep$con_pct)),
    FILAS_SUPRIMIDAS = fmt_entero(sum(filas_slep$con_pct & !filas_slep$coherente)),
    FILAS_MARCADAS   = fmt_entero(n_marcadas),
    PCT_MARCADAS     = fmt_decimal(pct_marcadas, 1),
    FILAS_VALIDAS    = fmt_entero(sum(filas_slep$coherente) - n_marcadas),
    PARES_EXISTEN    = fmt_entero(pares_existen),
    GSE_MEZCLA       = fmt_entero(sum(grupos_escuela$grupos > 1)),
    GSE_PARES        = fmt_entero(nrow(grupos_escuela)),
    UMBRAL           = fmt_entero(UMBRAL_EVALUADOS),
    UMBRAL_COMPOSICION = fmt_entero(100 * UMBRAL_COMPOSICION),
    N_VIGENTES       = fmt_entero(length(cod_vigentes)),
    PARES_POSIBLES   = fmt_entero(length(cod_vigentes) * n_grupos),
    COH_PRIMERA      = as.character(min(tras_de(intersect(names(DATA$meta), cod_vigentes)))),
    COH_ULTIMA       = as.character(max(tras_de(intersect(names(DATA$meta), cod_vigentes)))),
    N_UNIDADES       = fmt_entero(length(setdiff(names(DATA$meta), ID_REFERENTE))),
    N_FUTURAS        = fmt_entero(length(ids_futuras)),
    N_EST_FUTURAS    = fmt_entero(sum(cat_futuras)),
    OLA_PRIMERA      = as.character(min(tras_de(ids_futuras))),
    OLA_ULTIMA       = as.character(max(tras_de(ids_futuras)))
  )
}
