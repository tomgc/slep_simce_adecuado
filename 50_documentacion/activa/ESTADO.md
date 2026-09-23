---
slug: slep_simce_adecuado
nombre_real: Motor de comparación interactivo de los resultados Simce por estándares de aprendizaje (Adecuado/Elemental/Insuficiente)
categoria: activo
semaforo: activo
sesion_actual: v30
ultima_actividad: 2026-09-23
maneja_sensibles: false
tipo_pendiente: bloqueante
sesion_abierta: true
maquina: MacBook-Pro-de-Tomas.local
commit_cierre: 9c6671c
traspaso_vigente: traspaso_cierre_v30.md
cierre_incompleto: no
insumos_verificados: 2026-08-28
ventana_insumos: ./20_insumos
---
## En que vamos
Sesión 30 dedicada a una tercera vista: un visualizador que anima año a año la trayectoria de los Servicios Locales tras su traspaso, con nube de contexto de 180 sostenedores municipales, referente congelado y panel de serie completa. Quedó autocontenida (sin CDN, fuentes incrustadas) y auditada con 28 pruebas en cuatro familias, más una batería de verificación en R con control positivo. El motor y el pipeline no se tocaron, así que la deuda de v29 sigue entera, y la vista nueva vive todavía en `andamios/`, que la política congela.

## Proximo paso
Resolver la dependencia de `unpkg.com` en sesión propia: el motor carga React, ReactDOM y Babel por red y no abre sin CDN, y el precedente de `slep_categoria_desempeno` ya está auditado con archivo y línea.

## Bloqueantes
`suitedoc` sin publicar (externo a este repositorio): bloquea `documentar.R`, `34_historico_pct_adecuado_costa_central.R` y la regeneración de la suite standalone.
