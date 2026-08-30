---
slug: slep_simce_adecuado
nombre_real: Motor de comparación interactivo de los resultados Simce por estándares de aprendizaje (Adecuado/Elemental/Insuficiente)
categoria: activo
semaforo: activo
sesion_actual: v29
ultima_actividad: 2026-08-29
maneja_sensibles: false
tipo_pendiente: deuda_tecnica
sesion_abierta: false
maquina: MacBook-Pro-de-Tomas
commit_cierre: 3b17b9b
traspaso_vigente: traspaso_cierre_v29.md
cierre_incompleto: no
insumos_verificados: 2026-08-28
ventana_insumos: ./20_insumos
---
## En que vamos
Sesión 29, la más larga del proyecto: se construyó y publicó el panorama territorial que v28 había dejado especificado, con los cinco GSE combinados, las dos pruebas del nivel activo lado a lado y estado vacío explícito. Su encabezado se alineó a los valores literales del motor IDPS. Se agotó la deuda trivial heredada de v28, se resolvió `D-color-nivel` y se midieron cuatro dudas abiertas con encargos de solo lectura. Dos mediciones cambiaron el trabajo: el 11,9% de los puntos comunales tenía una franja sin rótulo, casi siempre Adecuado, lo que obligó a rescatar la cifra bajo el eje; y el motor resultó no ser autocontenido. Quince commits, cuatro despliegues, backlog de 157 a 174.

## Proximo paso
Resolver la dependencia de `unpkg.com` en sesión propia: el motor carga React, ReactDOM y Babel por red y no abre sin CDN. El precedente de `slep_categoria_desempeno` ya está auditado con archivo y línea, y su traducción a este proyecto está documentada con riesgo MEDIO en el log `20260829_rescate_rotulos_y_precedente_c3_log.md`.

## Bloqueantes
`suitedoc` sin publicar (externo a este repositorio): bloquea `documentar.R`, `34_historico_pct_adecuado_costa_central.R` y la regeneración de la suite standalone.
