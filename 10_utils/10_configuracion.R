# =============================================================================
# 10_configuracion.R — Punto de arranque común de slep_simce_adecuado
# -----------------------------------------------------------------------------
# Todo proceso de R del pipeline lo carga antes de su primera lectura o
# escritura: 00_build.R y cada script de 30_procesamiento/ que se corre suelto
# con Rscript. Hoy solo instala la guarda de locale UTF-8 (POLITICA 5.2bis):
# los insumos viven en el propio repositorio (./20_insumos), así que no hay
# raíz de datos externa que resolver.
# =============================================================================

# Guarda de locale UTF-8: va ANTES que todo. Un proceso en locale C (cron, CI,
# shells no interactivos) escribe texto acentuado escapado como <c3><a1> sin
# error visible (medido en este proyecto en la sesión 34: el JSON del motor
# salió con «Educaci<c3><b3>n»). El helper aborta si no puede corregirlo.
source(here::here("10_utils", "10_locale.R"))
asegurar_locale_utf8("10_configuracion")
