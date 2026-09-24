# Errores del asistente, sesión 32 (2026-09-23)

Registro en el momento en que ocurren (POLITICA 0.5; SETTINGS §2.2.15, diez campos en layout de bloque).

**ERR-32-01**
- `momento`: Fase C, recomendación sobre el destino de la rama local `feat/contrato-contexto` (opción B, publicarla sin integrar).
- `disparador`: el ejecutor lo detectó (hook pre-push, R1: `40_salidas/publico/contexto_simce.parquet` sin autorizar; push rechazado).
- `que_paso`: recomendé B como «un solo push» sin medir que la rama versiona un parquet no declarado en `50_datos_versionados_autorizados.md`, aunque en el mismo análisis había medido ese parquet y había atado la autorización I8 solo a la opción A.
- `regla_violada`: SETTINGS §2.1, compuerta de repositorio I8 (ningún archivo de datos versionado sin autorizar), y aviso 8 de la apertura («ningún comando va a un encargo sin haberlo corrido antes»).
- `causa_raiz`: asocié la autorización de datos a la integración en `main` y no a cualquier publicación de la rama; la restricción que yo mismo escribí para A no se propagó a B.
- `salvaguarda_presente`: SETTINGS y POLITICA §6; mensaje de apertura del titular.
- `patron`: PAT-07, restricción leída no propagada a otra opción del mismo análisis.
- `gatillo_observable`: restriccion-no-propagada: la opción recomendada publica un árbol que contiene un `.parquet` que `git diff --stat main...feat/contrato-contexto` ya mostraba.
- `intentos_previos`: 0.
- `costo`: un push rechazado y una vuelta de decisión con el titular; ningún cambio en el repositorio.

**ERR-32-02**
- `momento`: instrucción a Claude Code para autorizar el parquet y publicar la rama, paso 4 de verificación.
- `disparador`: el ejecutor lo detectó (`fatal: Needed a single revision`; lo midió por separado).
- `que_paso`: escribí `git rev-parse --short HEAD origin/main`, que no corre porque `--short` admite una sola revisión; es el mismo comando de ERR-31-04.
- `regla_violada`: aviso 8 del mensaje de apertura y ⚠️ del traspaso v31 («NO escribir en un encargo un comando que no se corrió antes»); SETTINGS §1.2.6, «ningún comando asume el entorno».
- `causa_raiz`: traté el bloque como instrucción corta y no como encargo, y no probé el comando en mi entorno pese a tener git disponible; la regla la leí como propia de encargos formales.
- `salvaguarda_presente`: traspaso v31 (§12 y ERR-31-04), mensaje de apertura, SETTINGS.
- `patron`: PAT-03, sintaxis de una herramienta no probada; reincidencia literal de ERR-31-04.
- `gatillo_observable`: comando-entorno: un comando de verificación entregado a Claude Code sin haberse ejecutado antes en ningún entorno.
- `intentos_previos`: 0.
- `costo`: una verificación rehecha por el ejecutor en dos comandos; ninguno hacia fuera.

**ERR-32-03**
- `momento`: redacción de `encargo_traslado_trayectorias.md`, paso 3 de FASE 1 (esperado de D10).
- `disparador`: el ejecutor lo detectó (D10 dio 13 cifras distintas contra 3 esperadas; T1 congelada por la cláusula residual, R-14 BLOQUEA).
- `que_paso`: fijé como esperado el número exacto de cifras distintas del mockup («3») medido en mi entorno x86_64, cuando ese número depende de cómo la coma flotante resuelve empates en cada plataforma y orden de suma; lo que la meta afirma es «ninguna diferencia fuera de empates».
- `regla_violada`: ⚠️ del traspaso v31 («NO expresar criterios como cantidad de líneas...»: un conteo como criterio) y encargo v1.6 §2.6 (criterio calibrado sobre la afirmación, no sobre un proxy).
- `causa_raiz`: vi que las 3 diferencias eran empates y no pregunté por qué había empates que la aritmética resolvía distinto; traté un síntoma del entorno como constante del dato.
- `salvaguarda_presente`: traspaso v31 §12, encargo v1.6 §2.6, regla 12 de `50_diseno_ramas_deteccion.md`.
- `patron`: PAT-13, criterio que mide un proxy (conteo de diferencias) y no el riesgo (diferencias fuera de empate).
- `gatillo_observable`: encargos-premisas: un esperado numérico derivado de una sola corrida en otra plataforma para una magnitud sensible al redondeo.
- `intentos_previos`: 0.
- `costo`: T1 congelada sin commit, una corrida completa del encargo y una decisión devuelta al titular.

**ERR-32-04**
- `momento`: entrega de los dos scripts con redondeo entero, después de depositar la adenda del traslado.
- `disparador`: el ejecutor lo detectó (`?? "Claude outputs/"` en FASE 0 de la adenda; regla 2, sesión detenida).
- `que_paso`: entregué en el chat dos archivos que ya estaban en la carpeta conectada, y la app de escritorio dejó sus copias en `Claude outputs/` dentro de la raíz del repositorio, 12 segundos después de fijar el estado de partida de la adenda.
- `regla_violada`: SETTINGS §1.2.6, «ningún comando asume el entorno»: el estado de partida de un encargo lo cambió una acción mía posterior a su medición; encargo v1.6 §2.2 regla 3 por analogía (sobrescribir es hipótesis).
- `causa_raiz`: no medí el efecto de la entrega en el chat sobre la carpeta conectada; la traté como una acción sin efecto en el árbol y la hice después de medir el `git status` que la adenda declara.
- `salvaguarda_presente`: SETTINGS; ERR-31-07 (artefactos no versionados que cambian el estado supuesto).
- `patron`: PAT-03, efecto de una herramienta propia sobre el entorno del ejecutor no medido.
- `gatillo_observable`: comando-entorno: una entrega de archivos al chat con carpeta conectada, hecha después de medir el `git status` que un encargo declara como premisa.
- `intentos_previos`: 0.
- `costo`: una corrida de la adenda detenida en FASE 0 y un commit de log sin la meta cumplida.
