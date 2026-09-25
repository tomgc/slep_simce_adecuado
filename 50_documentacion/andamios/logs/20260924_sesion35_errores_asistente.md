# Errores del asistente — sesión 35 (slep_simce_adecuado)

Registro al momento de identificarlos (POLITICA 0.5; SETTINGS §2.2.15, diez campos).

## ERR-35-01
- `momento`: entrega de `activa/decisiones/20260924_decision_referente_traspasos.md` (prioridad 2).
- `disparador`: asistente lo señaló espontáneamente, al medir el archivo en la carpeta (`grep` de la cifra corregida dio 0).
- `que_paso`: lancé la corrección de una cifra (0,9 → 1,1 puntos) y la escritura a la carpeta en el mismo bloque de llamadas paralelas, y a la carpeta llegó la versión sin corregir.
- `regla_violada`: SETTINGS §1.2.6, «Generar, verificar, consumar: en ese orden»; instrucción ✅ de v34 §12 sobre `device_commit_files`.
- `causa_raiz`: traté dos operaciones dependientes (editar y luego copiar el resultado) como independientes para ahorrar un turno.
- `salvaguarda_presente`: SETTINGS, traspaso v34 §12.
- `patron`: PAT-02, consumo lanzado en paralelo con el paso que lo condicionaba.
- `gatillo_observable`: costo-sobre-regla: una llamada de escritura a la carpeta en el mismo bloque que la edición del archivo que escribe.
- `intentos_previos`: 0.
- `costo`: una reescritura del archivo en la carpeta; md5 final igual en ambos lados (`a765ddc6…`); nada commiteado con la versión errada.

## ERR-35-02
- `momento`: la misma verificación de ERR-35-01.
- `disparador`: asistente lo señaló espontáneamente (la cadena se detuvo con «md5: command not found»).
- `que_paso`: usé `md5 -q` sin el respaldo `md5sum` dentro de una cadena con `&&` en el shell del puente, que no trae `md5`, y la cadena se detuvo antes de la edición siguiente.
- `regla_violada`: SETTINGS §1.2.6, «Ningún comando asume el entorno».
- `causa_raiz`: omití el respaldo `|| md5sum` que yo mismo había usado antes en la sesión.
- `salvaguarda_presente`: SETTINGS; A34-3 del traspaso v34 (conteos en líneas propias).
- `patron`: PAT-03, comando del shell del puente sin respaldo.
- `gatillo_observable`: comando-entorno: `md5` sin respaldo dentro de una cadena `&&` en el shell del puente.
- `intentos_previos`: 0.
- `costo`: una llamada repetida.

## ERR-35-03
- `momento`: reporte de la prioridad 2 (decisión D35-1 registrada), cuarto intercambio de la sesión.
- `disparador`: usuario lo corrigió («¿contaste cuántos intercambios tuvimos?»).
- `que_paso`: recomendé cerrar la sesión tras cuatro intercambios, sin síntoma de degradación ni cambio de dominio, porque la ruta aprobada terminaba en la prioridad 2.
- `regla_violada`: userPreferences y SETTINGS §3 (el cierre se recomienda solo ante un síntoma de degradación o un pivote, nombrando el síntoma); preferencia registrada del titular: el cierre lo decide y lo pide él.
- `causa_raiz`: confundí el fin de la ruta propuesta con el fin de la sesión y usé la recomendación de cierre para terminar el turno, en vez de proponer el paso siguiente (implementar D35-1).
- `salvaguarda_presente`: userPreferences, SETTINGS §3 y §1.2.6 («El turno termina proponiendo»).
- `patron`: PAT-04, ceder la iniciativa al cierre en vez de proponer el paso siguiente.
- `gatillo_observable`: otro: recomendación de cierre sin un síntoma de §3 nombrado.
- `intentos_previos`: 0.
- `costo`: un turno del titular.

## ERR-35-04
- `momento`: reescritura de `20260924_decision_referente_traspasos.md` con D35-2.
- `disparador`: asistente lo señaló espontáneamente (el md5 medido en la carpeta seguía siendo el de la versión anterior, `a765ddc6…`, aunque la herramienta informó «written»).
- `que_paso`: reescribí el archivo en `outputs/` con el mismo nombre y lo envié a la carpeta; llegó la versión anterior.
- `regla_violada`: instrucción ✅ del traspaso v34 §12: «ANTES de escribir un archivo a la carpeta con `device_commit_files`, usar un nombre nuevo en `outputs/`».
- `causa_raiz`: la instrucción estaba leída y reproducida en el acuse, pero no la apliqué al reescribir un archivo que ya había enviado una vez en la misma sesión.
- `salvaguarda_presente`: traspaso v34 §12.
- `patron`: PAT-07, restricción leída no propagada a la operación.
- `gatillo_observable`: restriccion-no-propagada: `device_commit_files` con un `stagedPath` ya enviado antes en la sesión.
- `intentos_previos`: 0.
- `costo`: un reenvío con nombre nuevo (`_v2` en `outputs/`); md5 final medido en la carpeta.

## ERR-35-05
- `momento`: redacción de `encargo_pendientes_s35.md`, invariante I-7 (§4).
- `disparador`: asistente lo señaló espontáneamente, al leer el log del encargo (FASE R, R-39).
- `que_paso`: escribí el comando de I-7 con esperado «vacío» sin correrlo antes; en el punto de retorno ya daba un acierto (`32_agregar_comunal.R:206`), y eso dejó FASE R en BLOQUEADO y sin push.
- `regla_violada`: traspaso v34 §12, «⚠️ NO escribir en un encargo un comando que no se corrió antes»; SETTINGS §1.2.6, marcador de fuente tipo 4.
- `causa_raiz`: traté los invariantes 🔒 heredados del traspaso como verdaderos por construcción y redacté su comando sin medir el estado de partida.
- `salvaguarda_presente`: traspaso v34 §12 y SETTINGS.
- `patron`: PAT-01, esperado de un comando del encargo sin medición previa.
- `gatillo_observable`: encargos-premisas: un comando de invariante con `esperado:` escrito y sin salida del redactor en la sesión.
- `intentos_previos`: 0.
- `costo`: push retenido; una auditoría cerrada en BLOQUEADO; una decisión pendiente del titular (Q-06).

## ERR-35-06
- `momento`: redacción del encargo, FASE 0, H3.
- `disparador`: asistente lo señaló espontáneamente, al leer el log (desviación D0-c).
- `que_paso`: el comando `git rev-parse --short HEAD origin/main` falla por sintaxis; el ejecutor tuvo que medir con uno equivalente.
- `regla_violada`: traspaso v34 §12, «⚠️ NO escribir en un encargo un comando que no se corrió antes».
- `causa_raiz`: compuse el comando de memoria sin correrlo en el puente, donde git de lectura estaba disponible.
- `salvaguarda_presente`: traspaso v34 §12.
- `patron`: PAT-01, comando de encargo no ejecutado antes.
- `gatillo_observable`: encargos-premisas: comando de FASE 0 sin salida del redactor en la sesión.
- `intentos_previos`: 0.
- `costo`: una desviación declarada del ejecutor; ninguno sobre el producto.

## ERR-35-07
- `momento`: redacción del encargo, T4 punto 2.
- `disparador`: asistente lo señaló espontáneamente, al leer el log (R-49, Q-24).
- `que_paso`: afirmé que los puntos de las sparklines «no llevan texto»; sí llevan una cifra, que quedó atenuada con 2,14:1.
- `regla_violada`: SETTINGS §1.2.6, «NUNCA modificar código sin haberlo leído» y marcador de fuente tipo 4.
- `causa_raiz`: leí solo el bloque de barras recientes (L2318-2425) y extendí la conclusión a la sparkline (L2205) sin abrirla.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, premisa de encargo sobre código no leído.
- `gatillo_observable`: afirmar-sin-leer: una premisa sobre un bloque de código cuyo rango no aparece en las lecturas de la sesión.
- `intentos_previos`: 0.
- `costo`: una cifra con contraste bajo sin corregir y una duda (Q-24).

## ERR-35-08
- `momento`: redacción de D35-1 en `20260924_decision_referente_traspasos.md`.
- `disparador`: asistente lo señaló espontáneamente, al leer el log (Q-22).
- `que_paso`: atribuí el reparto 479/407/408 (que suma 1.294 y se calculó sobre los 1.299 por comuna de la última fila) a los 1.282 del directorio, cuyo reparto medido es 475/406/401.
- `regla_violada`: SETTINGS §1.2.6, marcador de fuente tipo 3: una cifra solo admite un recuento programático del mismo turno sobre el mismo conjunto.
- `causa_raiz`: combiné en una frase dos recuentos de universos distintos (por comuna de 1.299 y por directorio de 1.282) sin recontar el segundo por ola.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, cifra de un universo aplicada a otro.
- `gatillo_observable`: cifras-datos: una frase que junta un total y un reparto que no suma ese total.
- `intentos_previos`: 0.
- `costo`: una frase falsa en una decisión commiteada (`f4bd59e`), a corregir con una entrada nueva.

## ERR-35-09
- `momento`: redacción del encargo, criterios de T1 y T3.
- `disparador`: asistente lo señaló espontáneamente, al leer el log (T3 congelada, Q-18).
- `que_paso`: pedí en T3 «0 píxeles distintos a 768 px» frente al estado previo, sabiendo que T1 agregaba tres botones de cohorte a `#c-coh`; el cambio de T1 hizo desbordar la vista y su reparación (R-47) volvió incumplible el criterio de T3.
- `regla_violada`: encargo_autonomo v1.6 §2.6 (criterio calibrado antes de confiarse) y §2.5 (dependencias del grafo).
- `causa_raiz`: fijé el criterio de T3 contra el estado de antes de T1 y no contra el estado que T1 dejaría.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-07, efecto de una tarea previa no propagado al criterio de la siguiente.
- `gatillo_observable`: restriccion-no-propagada: criterio de identidad de píxeles sobre una zona que una tarea anterior del mismo grafo modifica.
- `intentos_previos`: 0.
- `costo`: T3 y T8 congeladas; un encargo más.

## ERR-35-10
- `momento`: redacción del encargo, calibración de C5 en T1.
- `disparador`: asistente lo señaló espontáneamente, al leer el log (D1-a).
- `que_paso`: pedí calibrar C5 contando `cod_depe2 %in% c("1","5")` como caso malo, y en esas comunas no hay ningún establecimiento con dependencia 5, así que el caso malo no podía disparar.
- `regla_violada`: encargo_autonomo v1.6 §2.6: la calibración debe demostrar que puede dar el resultado contrario.
- `causa_raiz`: elegí el caso malo por plausibilidad sin medir si existía en los datos.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-13, calibración que no mide el riesgo.
- `gatillo_observable`: iteracion-sin-criterio: un caso de calibración sin recuento previo de que cambia el resultado.
- `intentos_previos`: 0.
- `costo`: una desviación (D1-a) y una duda (Q-03).

## ERR-35-11
- `momento`: opciones de la pregunta sobre la opacidad y redacción de T4 del encargo.
- `disparador`: asistente lo señaló espontáneamente, al verificar Q-08 del log.
- `que_paso`: propuse y especifiqué «*» como marca de un solo establecimiento sin buscar sus usos: el motor ya lo usaba para el dato preliminar en gráficos, tablas y notas, y T4 creó un doble significado.
- `regla_violada`: SETTINGS §1.2.6, «NUNCA modificar código sin haberlo leído primero», y marcador de fuente tipo 4.
- `causa_raiz`: diseñé el signo desde la convención gráfica general y no desde un `grep` del símbolo en la plantilla.
- `salvaguarda_presente`: SETTINGS.
- `patron`: PAT-01, diseño de un signo sin leer sus usos vigentes.
- `gatillo_observable`: afirmar-sin-leer: un símbolo nuevo en la interfaz sin `grep` previo del mismo símbolo.
- `intentos_previos`: 0.
- `costo`: un signo a reemplazar en el encargo siguiente (Q-08).

## ERR-35-12
- `momento`: redacción de `encargo_pendientes_s35b.md`, criterio de G.
- `disparador`: asistente lo señaló espontáneamente, al leer el log de s35b (Q-32).
- `que_paso`: puse como criterio `document.fonts.check('16px gobCL')` sin calibrarlo; da `true` aunque la familia no esté cargada, y en la estación gobCL está instalada, así que el criterio no distingue la incrustación de la fuente local.
- `regla_violada`: encargo_autonomo v1.6 §2.6: todo criterio declara su calibración (caso malo y caso bueno).
- `causa_raiz`: calibré solo el md5 de las fuentes y di por evidente la semántica de una API del navegador.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-13, criterio que mide un proxy (la API responde) y no el riesgo (la cara incrustada se usa).
- `gatillo_observable`: iteracion-sin-criterio: criterio de aceptación sin caso malo declarado junto a él.
- `intentos_previos`: 0.
- `costo`: la incrustación de gobCL queda sin verificación válida; una tarea más en el encargo siguiente.

## ERR-35-13
- `momento`: redacción del encargo s35b, criterio de M2.
- `disparador`: asistente lo señaló espontáneamente, al leer el log de s35b (R-48).
- `que_paso`: pedí «0 textos superpuestos» en la sparkline sin exigir que las cifras conserven el orden vertical de sus valores; la regla de choque cumplió el criterio y dejó 627 pares con el orden invertido.
- `regla_violada`: encargo_autonomo v1.6 §2.6 (el criterio mide el riesgo real) y SETTINGS §1.2.6.
- `causa_raiz`: traduje «legible» a «sin superposición» y no pensé en qué hace cualquier regla que mueve cifras para evitar choques.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-13, criterio que mide un proxy (sin superposición) y no la lectura correcta del dato.
- `gatillo_observable`: iteracion-sin-criterio: un criterio sobre posición de rótulos de datos sin condición de orden.
- `intentos_previos`: 0.
- `costo`: tres intentos de reparación sin éxito, veredicto OBSERVADO y push retenido.

## ERR-35-14
- `momento`: redacción del encargo s35b, lista de autorizaciones.
- `disparador`: asistente lo señaló espontáneamente, al leer el log de s35b (FASE R, R-48).
- `que_paso`: la lista cerrada no daba una vía para descartar un intento de reparación sin commitear; el ejecutor usó `git checkout -- 30_procesamiento/33_motor_template.html`, que no estaba autorizado.
- `regla_violada`: encargo_autonomo v1.6 §2.1: todo comando de reversión figura en la lista atado a su condición.
- `causa_raiz`: copié la regla «toda reversión es `git revert` de un commit propio» sin prever intentos que no llegan a commit.
- `salvaguarda_presente`: encargo_autonomo v1.6.
- `patron`: PAT-07, restricción del instrumento no propagada al diseño del ciclo de reparación.
- `gatillo_observable`: encargos-premisas: un ciclo de hasta tres intentos sin comando autorizado para volver al estado commiteado entre intentos.
- `intentos_previos`: 0.
- `costo`: una operación destructiva fuera de la lista (sin daño medido: el archivo volvió al estado commiteado).

## ERR-35-15
- `momento`: redacción del encargo s35b, tarea G (vendorizar los `.otf` de gobCL en `10_utils/fuentes/`).
- `disparador`: asistente lo señaló espontáneamente, al evaluar Q-35 del log de s35b.
- `que_paso`: ordené versionar tres fuentes de terceros en un repositorio público (Apache 2.0) sin verificar su licencia de redistribución; no hay licencia escrita que lo permita y dos caras declaran fsType=4.
- `regla_violada`: POLITICA §6 (gobernanza prevalece sobre la autonomía) y `20260611_decision_licencia_apache.md` (el código publicado queda bajo Apache 2.0; lo de terceros requiere su propia licencia).
- `causa_raiz`: tomé la decisión D33-4 (migrar a gobCL) como autorización para redistribuir los archivos, y el precedente de la suite (que ya los incrusta) como prueba de que era lícito.
- `salvaguarda_presente`: POLITICA y la decisión de licencia del proyecto.
- `patron`: PAT-01, premisa de gobernanza sin fuente primaria.
- `gatillo_observable`: afirmar-sin-leer: un archivo de terceros agregado al árbol versionado sin una fuente leída sobre su licencia.
- `intentos_previos`: 0.
- `costo`: el commit `271c04f` (sin publicar) redistribuiría las fuentes; una decisión del titular y posiblemente reescribir historia local antes del push.
