---
slug: slep_simce_adecuado
nombre_real: Motor de comparación interactivo de los resultados Simce por estándares de aprendizaje (Adecuado/Elemental/Insuficiente)
categoria: activo
semaforo: activo
sesion_actual: v31
ultima_actividad: 2026-09-23
maneja_sensibles: false
tipo_pendiente: deuda_tecnica
sesion_abierta: false
maquina: MacBook-Pro-de-Tomas.local
commit_cierre: d6ea287
traspaso_vigente: traspaso_cierre_v31.md
cierre_incompleto: no
insumos_verificados: 2026-09-23
ventana_insumos: ./20_insumos
---
## En que vamos
Sesión 31: se cerró en emergencia el cierre v30 pendiente, se retiró la dependencia de `unpkg.com` (el JSX se transpila en el build con V8), 2025 pasó a la base final de la Agencia sin cambios de datos, y las barras de la vista de comparación dejaron de encimar cifras con la regla de rotulado de `slep_idps`. Tres despliegues verificados por md5; el motor publicado abre sin red.

## Proximo paso
Decidir el destino de la rama local `feat/contrato-contexto`, que reclama el paso 35, y trasladar la vista de trayectorias a `30_procesamiento/` corrigiendo la exclusión del grupo 5.

## Bloqueantes
`suitedoc` sin publicar (externo a este repositorio): bloquea `renv.lock` con `V8` y `openssl`, `documentar.R`, `34_historico_pct_adecuado_costa_central.R` y la suite standalone.
