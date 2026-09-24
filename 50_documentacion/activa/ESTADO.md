---
slug: slep_simce_adecuado
nombre_real: Motor de comparación interactivo de los resultados Simce por estándares de aprendizaje (Adecuado/Elemental/Insuficiente)
categoria: activo
semaforo: activo
sesion_actual: v33
ultima_actividad: 2026-09-24
maneja_sensibles: false
tipo_pendiente: nuevo
sesion_abierta: false
maquina: MacBook-Pro-de-Tomas.local
commit_cierre: ce54db8
traspaso_vigente: traspaso_cierre_v33.md
cierre_incompleto: no
insumos_verificados: 2026-09-24
ventana_insumos: ./20_insumos
---
## En que vamos
Sesión 33: la vista de trayectorias usa la regla de filas del motor, tiene su identidad visual con el menú de vistas compartido y no trae los defectos de forma catalogados; batería en 19 de 19 y HTML idéntico en dos plataformas. La publicación está decidida como tercera entrada del menú del motor, pero no ejecutada.

## Proximo paso
Con la revisión en Safari aprobada, enlazar la vista desde el motor y publicarla en `docs/trayectorias.html`.

## Bloqueantes
`suitedoc` sin publicar (externo a este repositorio): bloquea `renv.lock` con `V8` y `openssl`, `documentar.R`, `34_historico_pct_adecuado_costa_central.R` y la suite standalone.
