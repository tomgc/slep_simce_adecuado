---
slug: slep_simce_adecuado
nombre_real: Motor de comparación interactivo de los resultados Simce por estándares de aprendizaje (Adecuado/Elemental/Insuficiente)
categoria: activo
semaforo: activo
sesion_actual: v27
ultima_actividad: 2026-08-26
maneja_sensibles: false
tipo_pendiente: deuda_tecnica
sesion_abierta: true
maquina: MacBook-Pro-de-Tomas
commit_cierre: 6a1c8b6
traspaso_vigente: traspaso_cierre_v27.md
cierre_incompleto: no
insumos_verificados: 2026-08-26
ventana_insumos: ./20_insumos
---
## En que vamos
Sesión 27 corrigió la terminología "entidad"→"territorio" en el texto UI de `documentar.R` (commit `6a1c8b6`) y migró la escala tipográfica de `33_motor_template.html` a 7 variables CSS con piso de 12px (commit `d1d04f6`, 77 de 96 declaraciones). Las 19 declaraciones de D3 SVG y objetos JS quedaron fuera por decisión D-s27-1. La migración está commiteada y pusheada pero nunca se abrió en un navegador. Sesión 28 abierta el 2026-08-26.

## Proximo paso
Regenerar el motor con `33_generar_html.R` y verificar visualmente la migración tipográfica, con foco en la tabla comparativa (contenedor `min-width:1000px`) y los popups RBD.

## Bloqueantes
ninguno
