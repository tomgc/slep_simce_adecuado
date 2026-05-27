# 00_escanear_proyecto.R
# ----------------------------------------------------------------------------
# Escáner canónico de la estructura del proyecto.
#
# Genera un snapshot markdown del árbol de archivos versionados (excluye
# .git, insumos xlsx crudos y binarios pesados) en:
#   50_documentacion/estructura/estructura_actual.md
#
# Uso:
#   source(here::here("00_escanear_proyecto.R"))
# ----------------------------------------------------------------------------

library(here)

raiz   <- here::here()
salida <- here::here("50_documentacion", "estructura", "estructura_actual.md")

# ============================================================================
# Árbol con fs::dir_tree() — excluye carpetas problemáticas
# ============================================================================

# Captura el árbol excluyendo: .git, renv, simce (xlsx crudos pesados).
# Los .parquet y .min.js quedan en la lista pero son binarios; se omiten
# con regexp sobre el nombre de archivo.
arbol_lines <- capture.output(
  fs::dir_tree(
    raiz,
    recurse  = TRUE,
    all      = FALSE,
    regexp   = "(\\.git|/renv|/simce|node_modules)$",
    invert   = TRUE
  )
)

# Eliminar líneas que corresponden a binarios pesados (parquet, min.js)
# para no llenar el árbol de rutas ilegibles.
arbol_lines <- arbol_lines[
  !grepl("\\.parquet$|\\.min\\.js$", arbol_lines)
]

# ============================================================================
# Parquets en disco y salidas HTML
# ============================================================================

dir_inter    <- here::here("40_salidas", "intermedios")
parquets     <- character(0)
if (dir.exists(dir_inter)) {
  parquets <- list.files(dir_inter, pattern = "\\.parquet$", full.names = FALSE)
}

html_salidas <- list.files(here::here("40_salidas"),
                           pattern = "\\.html$", full.names = FALSE)

# ============================================================================
# Git log últimos 5 commits
# ============================================================================

git_log <- tryCatch(
  system2("git", c("-C", raiz, "log", "--oneline", "-5"),
          stdout = TRUE, stderr = FALSE),
  error = function(e) character(0)
)

# ============================================================================
# Construir markdown
# ============================================================================

fecha <- format(Sys.time(), "%Y-%m-%d %H:%M")

md <- c(
  "# Estructura actual — slep_simce_adecuado",
  "",
  sprintf("_Generado por `00_escanear_proyecto.R` el %s._", fecha),
  "_Los `.parquet` y `.min.js` se omiten del árbol (binarios pesados)._",
  "",
  "## Árbol de archivos versionados",
  "",
  "```",
  arbol_lines,
  "```",
  ""
)

# Intermedios en disco.
md <- c(md, "## Intermedios en disco (no versionados)", "")

if (length(parquets) > 0) {
  md <- c(md,
    "_Parquets presentes en `40_salidas/intermedios/`:_",
    "",
    "| Archivo | Tamaño |",
    "|---------|--------|"
  )
  for (p in sort(parquets)) {
    kb <- round(file.info(file.path(dir_inter, p))$size / 1024, 0)
    md <- c(md, sprintf("| `%s` | %d KB |", p, kb))
  }
  md <- c(md, "")
} else {
  md <- c(md,
    "_No se encontraron parquets. Ejecutar el pipeline para generarlos._",
    ""
  )
}

if (length(html_salidas) > 0) {
  md <- c(md,
    "_Salidas HTML en `40_salidas/`:_",
    "",
    paste0("- `", html_salidas, "`"),
    ""
  )
}

# Git log.
if (length(git_log) > 0) {
  md <- c(md,
    "## Últimos 5 commits",
    "",
    "```",
    git_log,
    "```",
    ""
  )
}

writeLines(md, con = salida, useBytes = FALSE)

message(sprintf("00_escanear_proyecto.R: OK -> %s",
                fs::path_rel(salida, raiz)))
message(sprintf("    Parquets en disco: %d", length(parquets)))
