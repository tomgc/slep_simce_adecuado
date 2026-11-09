# Decisión: cierre de los pendientes de v34 (D35-7 a D35-27)

**Fecha:** 2026-09-25 y 2026-09-26 (sesión 35). **Decide:** el titular, sobre la propuesta del asistente.
**Origen:** separadas el 2026-11-09 (sesión 36) de `20260924_decision_referente_traspasos.md`, que conserva
D35-1 a D35-6 (referente y cohortes futuras de la vista). El texto de cada decisión no cambia.

## Enmiendas tras el encargo `encargo_pendientes_s35b.md` (sesión 35, 2026-09-25)

Decide el titular sobre la propuesta del asistente, con el log
`50_documentacion/andamios/logs/20260925_pendientes_s35b_log.md` (commit `5e65bd3`) y una evaluación
independiente de solo lectura.

### D35-7. gobCL se publica incrustada y versionada, con su declaración en NOTICE

No existe una licencia escrita que permita redistribuir gobCL, y dos de sus caras declaran `fsType=4`. La suite
de documentación ya la incrusta en cuatro HTML públicos desde la sesión 22, junto con Museo Sans. El titular
decide publicarla tal cual: el sitio es de un servicio público del Estado y la tipografía es la institucional
del Gobierno de Chile. NOTICE agrega una sección que declara que las fuentes gobCL no están cubiertas por
Apache 2.0, su origen y el criterio de uso. La alternativa descartada era sacar los `.otf` de la historia antes
del push y pedir autorización escrita a Gobierno Digital. Queda pendiente, para una sesión de cartera, revisar
Museo Sans en la suite.

### D35-8. Las cifras de la sparkline conservan el orden de sus valores (regla C)

Reemplaza la regla de choque de M2 y R-51, que dibujaba 627 pares con el orden vertical invertido (R-48). Cada
cifra parte en `cy - 6`. Ante un choque, solo se mueve en la dirección que conserva el orden por valor: la
mayor sube o la menor baja. La menor baja solo si queda sobre la banda de años. El choque con «traspaso» se
resuelve bajando la cifra, y la marca preliminar «*» cuenta como obstáculo. Una pasada final de validación
oculta, ante cualquier inversión, superposición o salida del SVG, la cifra del año más antiguo del par; su
valor y su «†» siguen en el tooltip. Criterio: 0 inversiones por construcción, 0 superposiciones y 0 cifras
fuera del SVG, con las ocultas contadas y listadas. Alternativas descartadas: la regla vigente (A), el intento
3 (B, con 155 inversiones) y quitar la «†» de la sparkline (reabría D35-6).

### D35-9. Se incrustan dos caras de gobCL: Regular 400 y Bold 700, con una familia de nombre propio

Heavy pesa 900 real y se había declarado 700, y Light no la usa ninguna regla. Se incrustan solo Regular (400)
y la Bold real (700); los pesos 800 y 900 caen en Bold. La familia incrustada pasa a llamarse `gobCL-sitio`,
para que una gobCL instalada en el equipo no pueda sustituirla ni ocultar una falla de la incrustación. El
criterio de carga deja de ser `document.fonts.check()`, que no discrimina (ERR-35-12): pasa a ser la lista de
caras `gobCL-sitio` con estado `loaded` y la diferencia de ancho medida contra el respaldo del sistema.

### D35-10. El criterio de A3 se redefine tras R-50

Tras corregir la carrera de carga de la fuente (R-50), la vista ya no coincide píxel a píxel con las
referencias posteriores a G. El criterio pasa a ser «0 píxeles distintos entre cargas y `scrollWidth` igual al
viewport». Las capturas de referencia a 768, 1024, 1280 y 1920 px se regeneran desde el estado final de cada
encargo.

## Decisiones del titular tras el encargo `encargo_supports_cohortes_s35g.md` (sesión 35, 2026-09-25)

Tomadas en bloque por el titular, con la recomendación del asistente.

### D35-11. Se cierran sin cambios Q-61, Q-62, Q-60 y Q-56

- Q-61: Q-59 queda resuelta con la simulación en Chrome (un navegador sin `text-box` se salta el bloque `@supports` completo); no se mide en un navegador real.
- Q-62: abajo o arriba del punto, el tooltip conserva la posición horizontal acotada a la izquierda; no se centra.
- Q-60: los botones de Nivel y Prueba quedan aprobados en Safari por la revisión del titular.
- Q-56: se acepta el desvío de hasta ±0,5 px CSS del centrado en Chrome como límite.

### D35-12. Se acepta el comportamiento actual en Q-42, Q-29 y Q-21

- Q-42 (A): con la regla C, las rachas monótonas con «†» se apilan en escalera.
- Q-29 (A): la cifra de un solo establecimiento conserva la opacidad 0,9 común de la sparkline.
- Q-21: las unidades con pocos establecimientos (504_2027, 1310_2029) siguen entrando al marco de los ejes.

### D35-13. Se suman a los próximos encargos Q-31, Q-57 y Q-39

- Q-31 (encargo s35h): el PNG exportado incrusta la `@font-face` de `gobCL-sitio` en el SVG que se rasteriza.
- Q-57 (encargo s35h): el centrado óptico se extiende a las pestañas y el campo del modal, los rótulos de exportar y «Ver establecimientos» del tooltip, con la misma guarda `@supports`.
- Q-39 (encargo s35i): el build se detiene ante una falla de portabilidad también con `source()` interactivo (`validar_portabilidad(detener_si_falla = TRUE)`).

## Decisiones del titular tras el encargo `encargo_pantallas_angostas_s35h.md` (sesión 35, 2026-09-26)

### D35-14. Q-63 y Q-64 se cierran sin cambios

- Q-63: el tope de 5 territorios (`MAX_ENTIDADES = 5`) no cambia; los próximos encargos miden con 5 como máximo.
- Q-64: `ANCHO_PLANO_MIN` queda en 384; a 823 px pueden pasar a una columna las cohortes que quedan bajo ese mínimo.

### D35-15. Q-65 y Q-66 se suman al encargo s35i

- Q-65: al cambiar de cohorte, `rebuild()` reinicia `--cardw` antes de `anchoTarjeta()`, como `resize` y `trasFuentes()`, para que la tarjeta mida lo mismo que en una carga nueva.
- Q-66: el corte bajo el cual el supergrid usa `--supergrid-col-min` sube de 640 px al ancho medido en que ningún texto sale de su columna con 5 territorios (del orden de 690 px).

## Decisiones del titular tras el encargo `encargo_bateria_familias_s35i.md` (sesión 35, 2026-09-26)

### D35-16. Q-67, Q-68 y Q-69 se cierran sin cambios

- Q-67: el corte del supergrid queda en 670 px (primer múltiplo de 10 sobre `W_FUERA` = 666, medido con 5 territorios); corrige la estimación «del orden de 690 px» de D35-15.
- Q-68: R2, R6 y R7 quedan en la familia B (invariantes del motor de la vista).
- Q-69: `--supergrid-col-min` queda en 112 px; se acepta que los nombres de 13 comunas y de la Región Metropolitana invadan la columna vecina en pantallas angostas.

## Decisiones del titular tras el encargo `encargo_ramas_bloqueos_s35j.md` (sesión 35, 2026-09-26)

### D35-17. Ramas (pendientes 10 y 12)

- `respaldo_prerebase_20260824` y `respaldo_normativos_20260824` se borran (0 archivos únicos y vigentes, según R1 de s35j).
- `gobernanza/v16` se borra después de rescatar a `main` el log `20260711_contrato_contexto_simce_log.md` (único registro del paso 35) y la suite standalone regenerada.
- `feat/contrato-contexto` se deja publicada, sin integrar; se integrará por cherry-pick cuando el consumidor programe P-CTX-4.

### D35-18. `suitedoc` queda fuera de `renv.lock` (pendiente 8)

Se registran en el lock los paquetes de CRAN que faltan (entre ellos `V8` y `openssl`) y `suitedoc` queda fuera, porque su remoto (`herramientas_dev`) es privado y este repositorio es público. La vía se prueba antes en una copia del lock.

### D35-19. Simce 2026 y correcciones de redacción (pendiente 13, Q-71, Q-72)

- Pendiente 13: queda bloqueado hasta que la Agencia publique la base 2026. Mientras, los años y los 5 literales de rango se derivan de los archivos disponibles.
- Q-71: el próximo traspaso describe `suitedoc` como «en remoto privado», no «sin remoto».
- Q-72: `manifiesto_insumos.md` dirá que los 18 xlsx Simce se versionan (están autorizados).
- Q-70: el proceso R huérfano de `slep-central-datos` lo detiene el titular.

## Decisiones del titular tras el encargo `encargo_ejecucion_decisiones_s35k.md` (sesión 35, 2026-09-26)

### D35-20. CLAUDE.md local y log de s35j sin cambios

- CLAUDE.md se crea en la raíz, local y sin versionar (el `.gitignore` lo excluye). Los logs dejan de registrarlo como pendiente.
- El log de s35j, con referencias generales a dos repositorios privados (sin datos ni claves), se deja como está.
- Q-73, Q-74 y Q-75 y el detalle R-41 se resuelven en el encargo s35l, junto con una batería versionada del motor.

## Decisiones del titular tras el encargo `encargo_verificaciones_s35l.md`, segunda emisión (sesión 35, 2026-09-26)

### D35-21. Lock, textos de años y baterías

- Q-79: se acepta que 22 paquetes del lock se restauren desde instantáneas de Posit Package Manager; el lock no se actualiza.
- Q-80: los textos fijos de años sin Simce de la vista (L462 y L1032) pasan a `ANIOS_SIN_SIMCE` en un encargo corto.
- Q-81: los cuatro textos de `documentar.R` que llaman «preliminar» al 2025 se corrigen con la próxima regeneración de la suite.
- Q-82: las baterías del motor y de la vista siguen manuales; se corren antes de cada copia a `docs/`.

## Decisiones del titular tras el encargo `encargo_textos_anios_s35m.md` (sesión 35, 2026-09-26)

### D35-22. Cierre de la línea de años sin Simce y CLAUDE.md en los encargos

- Q-83: las páginas no declaran sus formas de años sin Simce; una reescritura a mano la detecta el `grep`.
- Q-84: 2018 y 2022 (vecinos del hueco) quedan fijos en la banda de la vista, el corte de líneas del motor y el ejemplo de la nota GSE.
- Q-85: todo encargo trae una autorización fija para agregar su línea a «Últimos cambios» de `CLAUDE.md` al cerrar.

### D35-23. Revisión del titular de s35h y s35i

El titular revisó en Safari y en un teléfono lo publicado por s35h y s35i (modal y supergrid a 375 px, centrado de Q-57 y un PNG exportado con gobCL) y lo aprobó (2026-09-26).

## Decisiones del titular tras el encargo `encargo_suite_s35n.md` (sesión 35, 2026-09-26)

### D35-24. Suite, README y CLAUDE.md

- Q-86: no se guarda copia local de los íconos de `lucide-static`; generar la suite sigue requiriendo `npm` y red.
- Q-87: un encargo corto pone al día `README.md` (L7, L34 y L239) y los comentarios de `32_agregar_comunal.R` L9 y de `31_leer_normalizar.R` L49 y L315.
- Q-88: «Últimos cambios» de `CLAUDE.md` guarda las 5 entradas más recientes; los encargos quedan autorizados a recortar la lista al agregar la suya.
- Q-89: el glosario técnico de la suite pasa a «término: definición», sin guiones largos, en la próxima regeneración.

## Decisiones del titular tras el encargo `encargo_readme_s35o.md` (sesión 35, 2026-09-26)

### D35-25. Últimos textos de documentación

- Q-90: `.Renviron.example` deja de documentar la raíz de datos y `obtener_data_root_proyecto()`.
- Q-91: el bloque de portabilidad del README pierde la marca «bloque generado, no editar a mano».
- Q-92: `publicacion_github_pages.md` usa la regla del GSE como la dice ahora el README y exige las dos baterías antes de publicar.
- Q-93: los comentarios de `10_utils/10_utils.R` y de `30_procesamiento/30_construir_auxiliares.R` se ponen al día.
- Q-94: los tres documentos de junio de `50_documentacion/activa/` que la suite reemplaza pasan a `_archivo/`.

## Decisiones del titular tras el encargo `encargo_documentacion_s35p.md` (sesión 35, 2026-09-26)

### D35-26. Enlaces del README, `.Renviron.example`, `json_motor` y `COD_DEPE`

- **Q-97.** Quitar del README las entradas que enlazan los documentos archivados.
- **Q-95.** Ejecutar P1 de s35p: `.Renviron.example` sin la raíz de datos. Las dos líneas del validador que nombran esas variables solo las revisan como parte de la plantilla de la cartera; no cuentan como uso.
- **Q-96.** El criterio de `json_motor` de s35p se mide como palabra completa (`git grep -nw`): queda cumplido.
- **Q-98.** El paso 30 valida también la columna `COD_DEPE` del directorio, que usa y hoy no revisa.

## Decisiones del titular tras el encargo `encargo_enlaces_renviron_s35q.md` (sesión 35, 2026-09-26)

### D35-27. Q-99, Q-100 y pendientes para el traspaso

- Q-99: se anota en el protocolo de portabilidad de la cartera (`herramientas_dev`) que el `.Renviron.example` con raíz de datos (opciones A y B) aplica solo a proyectos con datos sensibles (Rama B), como ya dice POLITICA §8.2 y §8.3.6. Se hace en una sesión del kit, porque `herramientas_dev` no está conectado a esta.
- Q-100: `50_documentacion/activa/50_locale_utf8.md` queda como registro fechado del 2026-08-27; su cita a `.Renviron.example:29` no se corrige.
- Quedan para la próxima sesión, sin encargo ahora (verificación independiente del log de s35q): la sección «Cómo correr en una máquina nueva» del README no pide copiar `LANG` a `~/.Renviron`; el README remite a un protocolo en el repositorio privado `herramientas_dev`; el mensaje de `10_validar_portabilidad.R` L280 sugiere declarar `DATA_ROOT` (plantilla de la cartera).
