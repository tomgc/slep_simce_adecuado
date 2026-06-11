# Decisión — Visibilidad pública del repositorio (B3)

- **Fecha:** 2026-06-11 (sesión 13, auditoría pre-lanzamiento)
- **Decisión:** el repositorio `tomgc/slep_simce_adecuado` se mantiene
  PUBLIC.

## Contexto

SETTINGS_Y_PROMPTS_OPERACIONALES.md §4.3 establece visibilidad privada como
regla, "no negociable sin justificación". La auditoría B3 detectó que el
repo es público.

## Justificación

GitHub Pages en plan Free exige repositorio público; el motor se publica vía
Pages (`docs/index.html`). La excepción queda así justificada y documentada.

## Estándar derivado

Con repo público, TODO lo trackeado es visible para cualquiera, no solo
`docs/`. Verificaciones realizadas en la auditoría:

- Insumos versionados: bases públicas de la Agencia y directorio MINEDUC;
  `caracterizacion_establecimientos.xlsx` y
  `202602_Listado_SLEP_2026_vf.xlsx` son de creación interna pero SIN datos
  privados (confirmación del titular, 2026-06-11). Si su contenido cambia,
  revisar esta decisión.
- `.claude/settings.local.json`: no trackeado.
- B1 sobre el producto: 0 RUT, 0 correos, 0 campos sospechosos.

## Pendiente derivado

Auditoría conjunta de `50_documentacion/` pública (traspasos, backlog,
encargo) — registrada en el traspaso v13. Regla operativa hasta entonces:
nada se versiona en este repo si no es publicable.
