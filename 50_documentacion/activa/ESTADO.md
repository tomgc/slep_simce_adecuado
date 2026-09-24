---
slug: slep_simce_adecuado
nombre_real: Motor de comparación interactivo de los resultados Simce por estándares de aprendizaje (Adecuado/Elemental/Insuficiente)
categoria: activo
semaforo: activo
sesion_actual: v32
ultima_actividad: 2026-09-24
maneja_sensibles: false
tipo_pendiente: deuda_heredada
sesion_abierta: false
maquina: MacBook-Pro-de-Tomas.local
commit_cierre: 8fe8453
traspaso_vigente: traspaso_cierre_v32.md
cierre_incompleto: no
insumos_verificados: 2026-09-24
ventana_insumos: ./20_insumos
---
## En que vamos
Sesión 32: la rama local `feat/contrato-contexto` quedó publicada sin integrar y la vista de trayectorias salió de `andamios/`: la regenera el paso 36 en R, sin red, con redondeo en aritmética entera que da el mismo HTML en toda estación. B31-4 se cerró como diagnóstico errado: el referente y la nube se anclan a 2014 por decisión del titular.

## Proximo paso
Corregir los nueve defectos de forma de la vista de trayectorias heredados del mockup, con lista de forma y capturas antes y después.

## Bloqueantes
`suitedoc` sin publicar (externo a este repositorio): bloquea `renv.lock` con `V8` y `openssl`, `documentar.R`, `34_historico_pct_adecuado_costa_central.R` y la suite standalone.
