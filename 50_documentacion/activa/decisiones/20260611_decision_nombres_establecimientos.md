# Decisión — Nombres de establecimiento en el motor público (B2)

- **Fecha:** 2026-06-11 (sesión 13, auditoría pre-lanzamiento)
- **Decisión:** los popups del motor MANTIENEN `nom_rbd` (nombre del
  establecimiento). No se anonimiza ni se elimina el listado.

## Contexto

El traspaso v12 elevó como bloqueante de lanzamiento que el motor muestra
nombres de establecimiento, citando POLITICA_PROYECTO.md §6.4: "Condiciones
de Uso de Bases de Datos (SIMCE, IDPS): no identificar establecimientos por
nombre en ningún output".

## Verificación de la premisa

La verificación realizada en la sesión 13 indica que esa cláusula
corresponde a las Condiciones de Uso de las bases POR ESTUDIANTE (datos
enmascarados, acceso vía formulario de solicitud con aceptación expresa de
condiciones), que este proyecto NO utiliza. Las bases por establecimiento,
comuna y región son de libre descarga pública
(informacionestadistica.agenciaeducacion.cl) y la propia Agencia identifica
establecimientos por nombre junto a sus resultados en su buscador público
(agenciaeducacion.cl, también enlazado desde ChileAtiende).

## Alternativas consideradas

1. Anonimizar a RBD: descartada — el RBD identifica igual al establecimiento
   (cosmético) y degrada la utilidad diagnóstica.
2. Eliminar el listado de establecimientos: descartada — costo alto en
   utilidad, sin fundamento normativo verificado.
3. Mantener nombres: ELEGIDA. `nom_rbd` proviene además del directorio
   oficial MINEDUC, de fuente pública.

## Implicancias y acciones derivadas

- POLITICA_PROYECTO.md §6.4 generaliza en exceso la restricción; corregirla
  es tarea BIBLIOTECA (documento canónico multi-proyecto). Pendiente
  registrado en el traspaso v13.
- Si el proyecto incorpora en el futuro bases por estudiante, las
  Condiciones de Uso correspondientes aplican en plenitud y esta decisión
  debe revisarse.
