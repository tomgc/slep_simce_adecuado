# Decisión: el JSX del motor se transpila en el build con V8

**ID:** D31-1
**Fecha:** 2026-09-23 (sesión 31)
**Estado:** vigente, publicada en `232960c`.

## Contexto

El motor publicado cargaba React 18.3.1, ReactDOM 18.3.1 y Babel standalone 7.29.0
desde `unpkg.com`, y Babel transpilaba el JSX en el navegador: sin red, pantalla en
blanco. El precedente C3 de `slep_categoria_desempeno` resolvió lo mismo
transpilando una vez a mano con `npx` y versionando el resultado.

## Alternativas

- **A. Precedente C3.** React inline y JSX transpilado a mano con `npx`, con un
  archivo JSX hermano. Descartada: agrega un paso manual con Node que puede fallar en
  silencio sin `runtime: "classic"` (A34 del precedente) y cambia el flujo de edición.
- **B. Incrustar también Babel.** Descartada: el HTML crece unos 3 MB y el navegador
  sigue transpilando en cada apertura.
- **C. Transpilar en el build (elegida).** `33_generar_html.R` toma el bloque
  `<script type="text/babel" data-presets="env,react">` de la plantilla, lo transpila
  con Babel standalone dentro del paquete R `V8` (presets `env` y `react`, runtime
  `classic`) y lo publica como `<script>` normal. React, ReactDOM y Babel viven en
  `10_utils/` y se verifican por su sha384, el mismo SRI que se usaba con unpkg.

## Consecuencias

- El titular sigue editando JSX dentro de la plantilla; no hay paso manual ni Node.
- El HTML publicado no carga nada por red y abre como archivo local.
- El build exige los paquetes R `V8` y `openssl`, que aún no están en `renv.lock`
  (bloqueado por `suitedoc`).
- El transpilado del build es idéntico, carácter a carácter, al que producía el
  navegador (175.217 caracteres; log `20260923_retiro_cdn_v8_log.md`).
