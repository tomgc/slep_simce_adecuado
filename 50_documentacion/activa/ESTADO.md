---
slug: slep_simce_adecuado
nombre_real: Motor de comparación interactivo de los resultados Simce por estándares de aprendizaje (Adecuado/Elemental/Insuficiente)
categoria: activo
semaforo: activo
sesion_actual: v34
ultima_actividad: 2026-09-24
maneja_sensibles: false
tipo_pendiente: nuevo
sesion_abierta: false
maquina: MacBook-Pro-de-Tomas.local
commit_cierre: 880669f
traspaso_vigente: traspaso_cierre_v34.md
cierre_incompleto: no
insumos_verificados: 2026-09-24
ventana_insumos: ./20_insumos
---
## En que vamos
Sesión 34: la vista de trayectorias está publicada en `docs/trayectorias.html` y enlazada desde el motor, que abre el panorama con `#panorama`; encabezado y menú salen de un fragmento común, el proyecto tiene guarda de locale UTF-8 y las cifras de Elemental rescatadas cumplen contraste. `00_build.R` reproduce lo publicado byte a byte.

## Proximo paso
Decidir el referente de la vista y los futuros traspasos (cohortes 2027 a 2029), incluido el rótulo de su conteo, con página de contexto y maquetas.

## Bloqueantes
`suitedoc` sin publicar (externo a este repositorio): bloquea `renv.lock` con `V8` y `openssl`, `documentar.R`, `34_historico_pct_adecuado_costa_central.R` y la suite standalone.
