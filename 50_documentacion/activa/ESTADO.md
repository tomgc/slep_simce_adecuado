---
slug: slep_simce_adecuado
nombre_real: Motor de comparación interactivo de los resultados Simce por estándares de aprendizaje (Adecuado/Elemental/Insuficiente)
categoria: activo
semaforo: activo
sesion_actual: v28
ultima_actividad: 2026-08-28
maneja_sensibles: false
tipo_pendiente: bloqueado_externo
sesion_abierta: false
maquina: MacBook-Pro-de-Tomas
commit_cierre: 542088c
traspaso_vigente: traspaso_cierre_v28.md
cierre_incompleto: no
insumos_verificados: 2026-08-28
ventana_insumos: ./20_insumos
---
## En que vamos
Sesión 28, larga y de saldo de deuda: 19 entradas de backlog y tres despliegues. Se cerró la migración tipográfica que s27 dejó a medias (bloque `:root` duplicado, `.app-title` restaurado a 30px, 8 literales `fontSize` React omitidos del censo), se elevó el tope de comparación de 4 a 5 territorios, se migró la escala del SVG a constantes JS con los valores preservados, se ordenó el repositorio y se corrigieron dos bugs propios de la sesión. Nacieron tres documentos de gobernanza: `50_diseno_ramas_deteccion.md`, `50_datos_versionados_autorizados.md` y la normalización de `backlog_acumulativo.md` a las cinco secciones de POLITICA §10, que llevaba 28 sesiones fuera de norma. El motor publicado incluye todo lo anterior. La funcionalidad "Panorama territorial" quedó especificada y medida, no construida.

## Proximo paso
Publicar `herramientas_dev` en sesión propia: `suitedoc` no existe en ningún remoto y eso bloquea la reparación de `renv.lock` y la regeneración de la suite standalone. Después, construir el panorama territorial con la especificación del traspaso v28 §10.

## Bloqueantes
`suitedoc` sin publicar (externo a este repositorio): bloquea `documentar.R`, `34_historico_pct_adecuado_costa_central.R` y la regeneración de la suite.
