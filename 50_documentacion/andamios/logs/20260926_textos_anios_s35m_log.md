# Log: los años sin Simce en los textos visibles (s35m) (slep_simce_adecuado)

- Meta: ningún texto visible de las páginas escribe a mano los años sin Simce; el contenido publicado no cambia.
- Fecha: 2026-09-26 · Repositorio: slep_simce_adecuado · Rama: main
- Punto de retorno: `10512e4` (commit de T0, H4; 10512e42827079b6e836ab6bbcc73a3b2de7bf36)
- Encargo: `50_documentacion/activa/encargos/encargo_textos_anios_s35m.md`, md5 `cccdba6dc4ba5e1cb50c91cc81290545` (verificado por el orquestador antes de empezar, igual al del mensaje de entrega; se mide otra vez en H4)
- ENTORNO: Claude Code en la estación macOS, /Users/tomgc/Projects/slep_simce_adecuado
- EJECUCIÓN declarada: esfuerzo xhigh; orquestador Opus; subagentes 0
- Modo real de la sesión: Claude Code CLI, modo de permisos auto; orquestador Opus 5.5 (`claude-opus-5-5[1m]`). El harness tenía activo el modo «ultracode» (Workflow por omisión), pero el encargo fija subagentes 0 y prevalece: sin subagentes ni Workflow, todo en serie.
- Grafo y olas (copiados de §5): orden fijo T0, N1, FASE R, FASE L con el push.
- Topes: 3 intentos por bug; 2 ciclos de reparación; 1 reintento por comando
- Carpetas de trabajo: `$TMPDIR/s35m/` (instantáneas de I-1 e I-5), `$TMPDIR/cal_s35m/` (calibraciones, copias, controles y parches) y `$TMPDIR/base_s35m/` (salidas de H6). `$TMPDIR` = `/var/folders/3g/46nk6_2s5q140g74395q6s880000gn/T/`.

## J. Juicio (lo rellena FASE L)

- Meta y resultado: meta cumplida. Ningún texto visible de las páginas escribe a mano los años sin Simce: el `grep` de §2 sobre las plantillas pasa de 9 líneas (4 visibles) a 5 comentarios, y las cuatro formas salen de `ANIOS_SIN_SIMCE` con cuatro marcadores. El contenido publicado no cambia: el build reproduce `docs/` byte a byte (42ab9300…/883f76bc…), con `Gap 2019\u20132021` de Babel igual.
- Estado por tarea: FASE 0 completa · T0 completa · N1 completa (intento 1) · FASE R: 0 BLOQUEA, 1 REPARA (R-26, reparado en `ed07558`), 7 ADVIERTE (R-27 a R-33) · FASE L en el Cierre.
- Commits: 10512e4 (T0, punto de retorno), 3cbb42c (N1), ed07558 (`fix(auditoria)` R-26) y el `docs(log)` de este archivo (hash en el reporte final).
- Auditoría (FASE R): sin subagentes. 25 de 25 afirmaciones confirmadas con otros instrumentos: git de bajo nivel, `openssl` y `git hash-object`, Python sobre `git show`, otra prueba unitaria (7 de 7) y dos controles nuevos con el build completo (los dos como se predijo). 8 controles positivos disparan. Veredicto: APROBADO CON ADVERTENCIAS.
- Invariantes: I-1 a I-6 en PASA en el estado final (R.3 y tras R.8); I-1 e I-5, otra vez en FASE L contra FASE 0 (`diff`, 0 y 0); las condiciones del push se miden antes de publicar (reporte final).
- Cifras críticas: `grep` de §2, 9 → 5 líneas (visibles 4 → 0); marcadores de años sin Simce 1 → 4; M2 12 → 15; unidad 14 de 14 y 7 de 7; 8 controles con el build completo, todos como se predijo; batería del motor 8 de 8 (70 s) y de la vista 35 de 35, cuatro corridas cada una; validador 0 críticas y 7 advertencias; `docs/` 42ab9300…/883f76bc… (blobs 2554f9a2…/7cbbdb75…); I-6 28.
- Decisiones autónomas de mayor riesgo: D1-c (`sustituir_anios()` exige al menos un marcador de años sin Simce, en vez de `__ANIO_SIN_SIMCE__`); D1-a (el rango con dos marcadores de extremo y el conector en la plantilla); D1-d (el control de rango con un xlsx de 2020 plantado).
- Desviaciones respecto del encargo: ninguna en criterios, tolerancias ni ALCANCE. El control de rango del criterio no usa solo el ejemplo del encargo (2019 y 2021), porque con él el paso 31 se detiene antes; se anotan las dos variantes (R-30). Además de lo pedido: un control por cada marcador de años sin Simce del motor y de la vista, una prueba unitaria de 14 casos y la calibración de M2 con un marcador nuevo sin sustituir.
- Dudas abiertas: Q-83 (formas declaradas por página), Q-84 (2018 y 2022 fijos en el código de la banda y del corte, y en un ejemplo), Q-85 (autorización fija para CLAUDE.md); siguen Q-70, Q-71 y Q-81.
- Errores propios: dos horas escritas sin medir, corregidas en su sección; tres de instrumento (`echo =====`, `sed 1,0d`, el corte de la expresión regular de `rd_b.py`), corregidos antes de registrar; tres líneas de N1 con un formato que el conteo de §9.5 no empareja, sin ajustar; R-26 reparado. Ninguno tocó los datos ni el contenido publicado.
- Qué debe verificar el revisor por sí mismo: la identidad de las salidas con `docs/` (`git hash-object`, un comando); una corrida de las dos baterías en su estación; las respuestas a Q-83 y Q-84, que definen cuánto más se ata a `ANIOS_SIN_SIMCE`; la revisión en Safari y en un teléfono de s35h y s35i.
- No publicado / queda al usuario: el push de `main` va en el reporte final; CLAUDE.md sin s35m (Q-85); el traspaso de cierre, Q-70, Q-71, Q-81 y Q-83 a Q-85.
- Ejecución: esfuerzo xhigh; orquestador Opus 5.5 en serie; 0 subagentes, sin Workflow (el encargo no los admite, aunque el harness tenía «ultracode» activo); git 2.54.0, R 4.5.2 con `renv` 1.1.4, `chromote` 0.5.1, Python 3.14.7; de 19:49:33 a 20:15:01 (`date` al terminar el Cierre; el commit del log y el push, en el reporte final).

### FASE 0: log, punto de retorno y premisas

Inicio de FASE 0: 2026-09-26 19:49:33 (`date`). Antes, lectura de los insumos (este encargo; `CLAUDE.md`; el log de s35l segunda emisión, con L3, L4, R-46 y Q-80; los pasos 31, 33 y 36; `10_utils/10_html.R`; la M2 de `33_verificar_motor.R`; `verificar_contenido_motor.R`; los guiones `copia.sh`, `l4_controles.sh`, `h6_diff.R` e `i4_data_vista.R` de `$TMPDIR/cal_s35l/`), sin ningún comando de escritura en el árbol. D35-21 se lee en el archivo de decisiones modificado que commitea T0.

**Paso 1.** Log creado antes de H1, con el encabezado, el slot J vacío y la plantilla; por eso H1 muestra también la línea del propio log. Cada `esperado:` se escribe en el log antes de correr su comando (regla de pre-registro).

**H1.** `git status --porcelain` (salida en `$TMPDIR/cal_s35m/f0/h1.txt`; código leído sin tubería)
esperado: exactamente ` M …/20260924_decision_referente_traspasos.md`, ` M …/20260924_sesion35_errores_asistente.md` y `?? …/encargo_textos_anios_s35m.md`, más el log
obtenido: status_codigo=0, las tres líneas esperadas más el log:
```text
 M 50_documentacion/activa/decisiones/20260924_decision_referente_traspasos.md
 M 50_documentacion/andamios/logs/20260924_sesion35_errores_asistente.md
?? 50_documentacion/activa/encargos/encargo_textos_anios_s35m.md
?? 50_documentacion/andamios/logs/20260926_textos_anios_s35m_log.md
```
**Cumple.**

**H2.** `git stash list | wc -l` y `git worktree list`
esperado: 0; solo el árbol principal
obtenido: stash_codigo=0, 0 líneas; `/Users/tomgc/Projects/slep_simce_adecuado 0f419b4 [main]` (wt_codigo=0). **Cumple.**

**H3.** `git fetch origin`; después `git rev-parse --short HEAD` y `git rev-parse --short origin/main`, en dos comandos. Instantáneas: I-1 (`git for-each-ref --format='%(refname) %(objectname)'`, `$TMPDIR/s35m/i1_fase0.txt`) e I-5 (`md5 -q renv.lock renv/settings.json`, `$TMPDIR/s35m/i5_fase0.txt`; además, como en s35l, la biblioteca de `renv` con nombre, `Version` y destino del enlace, `$TMPDIR/s35m/i5_lib_fase0.txt`)
esperado: fetch sin error; 0f419b4 y 0f419b4
obtenido: fetch_codigo=0 (sin salida); `0f419b4` (c1=0) y `0f419b4` (c2=0). `git ls-remote --heads origin`: `feat/contrato-contexto` 31befa2c… y `main` 0f419b41…. I-1 de partida (`i1_fase0.txt`):
```text
refs/heads/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/heads/main 0f419b418ba9ae997a789953473343788b31f443
refs/remotes/origin/HEAD 0f419b418ba9ae997a789953473343788b31f443
refs/remotes/origin/feat/contrato-contexto 31befa2c17efdf7d241699364846d69051c2a326
refs/remotes/origin/main 0f419b418ba9ae997a789953473343788b31f443
```
I-5 de partida (`i5_fase0.txt`): `renv.lock` e6323bf2d0fb341589c4ce8a19b74636 y `renv/settings.json` d0bcb98db909870724e9b0fc5eff1700, los mismos de s35l. Biblioteca (`i5_lib_fase0.txt`): 58 paquetes; contra la lista de FASE 0 de s35l, `diff` solo difiere en el rótulo «(directorio)» de `renv` 1.1.4 y `suitedoc` 0.5.1, que esta lista deja vacío (mismos nombres, versiones y destinos). **Cumple.**

**H4.** `md5 -q` del encargo y de `docs/`; después `git add` de las tres rutas de T0 y `git commit -m "docs(sesion 35): encargo de la decimotercera ola y decision D35-21"`
esperado: cccdba6dc4ba5e1cb50c91cc81290545 (mensaje de entrega); 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3; un commit con las tres rutas, padre 0f419b4
obtenido: encargo cccdba6dc4ba5e1cb50c91cc81290545 (m1=0); `docs/index.html` 42ab93003e722f9bb6c725fec2d348bd y `docs/trayectorias.html` 883f76bcefc89d93f2d1e753fc4d75c3 (m2=0). T0: commit_codigo=0, `10512e4 docs(sesion 35): encargo de la decimotercera ola y decision D35-21`, padre `0f419b4`; `git show --name-status` = `M …/20260924_decision_referente_traspasos.md`, `A …/encargo_textos_anios_s35m.md`, `M …/20260924_sesion35_errores_asistente.md`; `git status --porcelain` = solo este log. **Punto de retorno: 10512e4** (10512e42827079b6e836ab6bbcc73a3b2de7bf36).

**H5.** `cd "$RAIZ" && Rscript 30_procesamiento/33_verificar_motor.R` y `cd "$RAIZ" && Rscript 30_procesamiento/36_verificar_trayectorias.R` (salidas en `$TMPDIR/cal_s35m/f0/h5_motor.txt` y `h5_vista.txt`; códigos leídos sin tubería)
esperado: motor código 0 con 8 de 8; vista código 0 con 35 o más en PASA
obtenido: codigo_motor=0, «Resultado: 8 pruebas, 8 pasan, 0 fallan (en 70 segundos)» (19:50:48 a 19:51:58); codigo_vista=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan» (19:51:58 a 19:52:16). **Cumple.**

**H6.** `cd "$RAIZ" && Rscript 00_build.R` (salida en `$TMPDIR/cal_s35m/f0/h6.txt`); I-4 con `md5 -q`, `cmp` contra `docs/` y `h6_diff.R` (copia del de s35l en `cal_s35m/f0/`)
esperado: código 0 con 0 fallas críticas; la vista con el md5 de `docs/trayectorias.html`; el motor igual a `docs/index.html` fuera de `meta$fecha_generacion` (mismo día que lo publicado: byte a byte)
obtenido: codigo_build=0 (19:52:26 a 19:52:34); «Fallas criticas: 0 | Advertencias: 7»; «OK: 18 archivos detectados (9 por nivel), años 2014, …, 2025.»; «00_build.R: OK en 6 segundos». Motor 42ab93003e722f9bb6c725fec2d348bd y vista 883f76bcefc89d93f2d1e753fc4d75c3; `cmp` contra `docs/index.html` y `docs/trayectorias.html`, código 0 y 0: **iguales byte a byte** (mismo día). `h6_diff.R`, codigo_h6diff=0: «fuera del bloque de datos, idéntico: TRUE | largo 837548 837548»; «fecha_generacion hoy: 2026-09-26 | docs: 2026-09-26»; «JSON sin fecha_generacion, identical: TRUE»; «caracteres distintos: 0». `git status --porcelain` = solo este log. **I-4 cumple.**

Las dos salidas se copiaron a `$TMPDIR/base_s35m/` (md5 42ab9300… y 883f76bc…): es la base de H6. `verificar_contenido_motor.R` (raíz, ignorado por `.gitignore:34`; autorización 4) apuntaba a `$TMPDIR/base_s35l/`; se apuntó a `base_s35m` (L24 y comentarios de L3 y L12). Copias en `cal_s35m/f0/`: `alterar_json_motor.R` (sin cambios) e `i4_data_vista.R` (apuntado a `base_s35m`: 4 menciones, 0 de `base_s35l`).

Calibración de `verificar_contenido_motor.R`
esperado: «idéntico» sobre la base; «difiere» con un número alterado
obtenido: `Rscript verificar_contenido_motor.R` → codigo_i3_base=0, «JSON idéntico a la línea base». `alterar_json_motor.R` sobre la base: «fragmento original: 3.5 -> alterado: 3.6»; `Rscript verificar_contenido_motor.R $TMPDIR/cal_s35m/f0/motor_alterado.html` → codigo_i3_alt=1, «JSON difiere: $datos$pct[[1]] (3.6 vs 3.5)». **Dispara.** El comparador del `DATA` de la vista sobre `40_salidas/`: codigo_i4v=0, «DATA de la vista: claves anios,meta,nac,datos,nube,comunas | identical: TRUE».

**Paso 8. Calibración.** `grep -n '2019\|2020\|2021' 30_procesamiento/36_trayectorias_template.html 30_procesamiento/33_motor_template.html 30_procesamiento/33_fragmento_sitio.html` (salida en `$TMPDIR/cal_s35m/f0/grep_s2.txt`)
esperado: las 9 líneas de §2: vista L462 y L1032 (visibles) y L1161 (comentario); motor L5063 y L5064 (visibles) y L2347, L2595, L2612 y L2641 (comentarios); el fragmento sin ninguna
obtenido: grep_codigo=0; **9 líneas, las de §2** (`grep_s2.txt`):
```text
30_procesamiento/36_trayectorias_template.html:462:   <p>No existe Simce 2019, 2020 ni 2021. El tramo se recorre con las burbujas atenuadas y sin valores intermedios: no se interpola.</p>
30_procesamiento/36_trayectorias_template.html:1032:  gl.textContent='2019 a 2021, sin medición';tk.appendChild(gl);
30_procesamiento/36_trayectorias_template.html:1161:  if(sn.options[sn.selectedIndex].disabled){   /* p. ej., cohorte 2021 con serie completa */
30_procesamiento/33_motor_template.html:2347:    //     (consecutivas a través del gap 2019-2021 y del corte de traspaso),
30_procesamiento/33_motor_template.html:2595:        // Banda 2019-2021
30_procesamiento/33_motor_template.html:2612:        // del gap 2019-2021: aquí solo modula opacidad y estilo de trazo.
30_procesamiento/33_motor_template.html:2641:        // Tramos del gap 2019-2021. Cuando hay corte de traspaso, se subdivide
30_procesamiento/33_motor_template.html:5063:                      <h4>Gap 2019–2021</h4>
30_procesamiento/33_motor_template.html:5064:                      <p>La aplicación del Simce en 2019, 2020 y 2021 fue interrumpida por el estallido social y la pandemia. En los gráficos aparece una banda sombreada y las líneas no se conectan a través del gap.</p>
```
El fragmento, ninguna. **Coincide con §2.** Búsquedas adicionales, para no dejar fuera un texto visible que el `grep` no ve:
- El mismo patrón sobre los generadores y las utilidades (`33_generar_html.R`, `36_generar_trayectorias.R`, `10_html.R`, `10_configuracion.R`): solo comentarios (`36_generar_trayectorias.R:64`, `10_html.R:28` y `:84`, `10_configuracion.R:27` y `:28`) y la definición (`10_configuracion.R:33`). Ningún texto visible sale de R con esos años.
- Los años vecinos del tramo (`grep -n '2018\|2022'` sobre las tres plantillas): vista L1028 y L1030 (geometría de la banda de la pista, `tx(2018)` y `tx(2022)`; código) y L1170 (comentario); motor L2644 y L2645 (`s.year <= 2018` y `s.year >= 2022`, el corte de las líneas en el tramo; código) y L5060 (texto visible de la nota «Regla GSE dinámico»: «si un establecimiento cambia de GSE entre 2018 y 2022», un ejemplo). No son «esos años» ni textos de años sin Simce: no entran a N1 y se registran para FASE R.
- El motor ya arma otro texto del tramo desde los datos (L4123 a L4127: «El eje salta de … a …: el Simce no se aplicó entre … y …», con `SimceData.GAP_YEARS`, que es `meta.anios_sin_simce`).

**Estado:** completa (19:49:33 a 19:53:54, `date` al cerrar). **Commits:** `10512e4` (T0). **Cambios sustantivos:** ninguno en el producto. **Alcance:** las tres rutas de T0 (commit); `verificar_contenido_motor.R` (ignorado, autorización 4). **Regresión:** H5 y H6. **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D0-a (riesgo bajo): además del `grep` de §2, el paso 8 busca los mismos años en los generadores y las utilidades, y los años vecinos (2018 y 2022) en las plantillas. Lo que hallan fuera de N1 se registra y no se toca.

**Errores propios:** la hora de cierre de esta fase se escribió primero sin medir (19:55); el `date` del mismo comando dio 19:53:54 y se corrigió antes de seguir. Desde aquí, cada hora sale de un `date` ya impreso. Antes de crear el log, un `echo =====` de una lectura falló en zsh («===== not found», la expansión `=comando`); era solo de lectura y no escribió nada. **Dudas:** ninguna.

### FASE N1: los textos visibles de años sin Simce salen de `ANIOS_SIN_SIMCE` (Q-80)

Inicio: 19:55:29 (`date` del comando que abrió esta sección; la hora se escribió primero sin medir, 19:57, y se corrigió enseguida: ver errores propios). ALCANCE: `10_utils/10_html.R`, `30_procesamiento/36_trayectorias_template.html`, `30_procesamiento/33_motor_template.html`, `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_verificar_motor.R` (solo si M2 necesita conocer marcadores nuevos).

**Diseño** (antes de escribir el código). Las formas visibles de hoy son cuatro, repartidas así:

| forma | vista | motor |
|---|---|---|
| enumeración con «y» («2019, 2020 y 2021») | L425 (ya es `__ANIO_SIN_SIMCE__`, s35l) | L5064 |
| enumeración con «ni» («2019, 2020 ni 2021») | L462 | — |
| rango con «a» («2019 a 2021») | L1032 | — |
| rango con guion largo («2019–2021») | — | L5063 |

- Enumeración con «ni»: marcador `__ANIO_SIN_SIMCE_NI__`, con `enumerar_anios(anios, conjuncion = "ni")` (la función de s35l recibe la conjunción; por omisión, «y», así que sus llamadas no cambian).
- Rango: dos marcadores para los extremos, `__ANIO_SIN_SIMCE_DESDE__` y `__ANIO_SIN_SIMCE_HASTA__`, con el conector en la plantilla («… a …» en la vista, «…–…» en el motor). Es la convención del proyecto para el rango de los datos (`__ANIO_MIN__–__ANIO_MAX__` en el fragmento y el motor, `__ANIO_MIN__ a __ANIO_MAX__` en la vista), y deja el guion largo en la plantilla: R no escribe ningún carácter fuera de ASCII, y Babel recibe el mismo texto de antes. Función de formato: `tramo_anios(anios, nombre)`, que devuelve el primer y el último año y **se detiene si los años no son un tramo consecutivo**, con un mensaje que nombra la constante y los años.
- `sustituir_anios()`: con `anios_sin_simce`, sustituye cada marcador de años sin Simce que la página trae (la vista trae tres formas y el motor dos). Se detiene si la página no trae ninguno, si trae solo uno de los dos extremos del rango, y, como antes, si queda algo con el prefijo `__ANIO_`. La forma de rango se calcula solo si la página la usa.
- El motor pasa a llamar `sustituir_anios(plantilla, meta$anios, ANIOS_SIN_SIMCE)`, antes de transpilar, como ya hace con el rango de los datos (s35k, D3-d).
- M2 de la batería del motor lee los marcadores de la plantilla con `PATRON_MARCADOR` (`__[A-Z0-9_]+__`) y, además, aplica `PATRON_ANIO_RESTO`: los tres marcadores nuevos del motor quedan cubiertos sin tocarla (se comprueba en el criterio).

**Criterio pre-registrado** (se mide al final de esta sección)
esperado: I-4: la vista con el md5 de `docs/trayectorias.html` (883f76bc…) y el motor igual a `docs/index.html` (mismo día: byte a byte, 42ab9300…; en particular, «Gap 2019–2021» de Babel igual); el `grep` de §2 sobre las tres plantillas con solo las 5 líneas de comentario (vista L1161; motor L2347, L2595, L2612 y L2641); cada marcador nuevo mal escrito en una copia de la plantilla detiene `00_build.R` (código 1, con el marcador en el mensaje); con `ANIOS_SIN_SIMCE` en 2019 y 2021 en una copia, la forma de rango detiene el build con su mensaje; las dos baterías en PASA (motor 8 de 8, M2 con 15 marcadores de las fuentes en vez de 12; vista 35 o más); I-3 «JSON idéntico a la línea base»
Predicción para el control de rango: con solo `ANIOS_SIN_SIMCE <- c(2019L, 2021L)`, el paso 31 se detiene antes que la forma de rango («Nivel 2m: faltan años 2020», su regla del hueco). Para que el build llegue al generador, el control plantará además un xlsx de 2020 en cada nivel de la copia (copia del de 2018, como el 2026 de s35k). Las dos variantes se corren y se anotan.

**Controles con el build completo** (copias del árbol con `$TMPDIR/cal_s35m/copia.sh`, copia del de s35l limitada a `cal_s35m`; un cambio con `perl` en la copia; `Rscript 00_build.R` completo en la copia; guion `$TMPDIR/cal_s35m/n1_controles.sh`, salidas en `$TMPDIR/cal_s35m/n1ctl/`)
esperado (por caso, código y mensaje):
- `vista_ni_malescrito` (`__ANIO_SIN_SIMCE_NI__` → `__ANIO_SIN_SIMCE_NI_` en la plantilla de la vista): 1, «Quedaron marcadores de años sin sustituir: __ANIO_SIN_SIMCE_NI_»;
- `vista_hasta_malescrito` (`__ANIO_SIN_SIMCE_HASTA__` → `__ANIO_SIN_SIMCE_HASTA_` en la vista): 1, «La página trae un solo extremo del tramo de años sin Simce: __ANIO_SIN_SIMCE_DESDE__ sin __ANIO_SIN_SIMCE_HASTA__»;
- `motor_desde_malescrito` (`__ANIO_SIN_SIMCE_DESDE__` → `__ANIO_SIN_SIMCE_DESD__` en el motor): 1, «… un solo extremo …: __ANIO_SIN_SIMCE_HASTA__ sin __ANIO_SIN_SIMCE_DESDE__»;
- `motor_y_malescrito` (`en __ANIO_SIN_SIMCE__ fue` → `en __ANIO_SIN_SIMCE_ fue` en el motor): 1, «Quedaron marcadores de años sin sustituir: __ANIO_SIN_SIMCE_»;
- `tramo_2019_2021` (`ANIOS_SIN_SIMCE <- c(2019L, 2021L)` en `10_configuracion.R` de la copia, el ejemplo del encargo): 1, pero en el paso 31, «Nivel 2m: faltan años 2020» (predicción de arriba), sin llegar a la forma de rango;
- `tramo_2019_2021_con2020` (lo mismo, más `simce2m2020_rbd_final.xlsx` y `simce4b2020_rbd_final.xlsx`, copias de los de 2018): el paso 31 pasa, con el aviso del año interno, y el paso 33 se detiene: 1, «ANIOS_SIN_SIMCE no es un tramo consecutivo (2019, 2021): no puede escribirse como rango».
En todos, las salidas del árbol no cambian.
obtenido (controles; `n1_controles.sh`, 19:58:36 a 19:59:12; en cada copia, `diff` de una línea contra el árbol): **los seis, como se predijo**:

| caso | código | mensaje (literal de la salida de la copia) | salidas de la copia |
|---|---|---|---|
| `vista_ni_malescrito` | 1 | «Error en sustituir_anios(html_tray, DATA_TRAY$anios, ANIOS_SIN_SIMCE): Quedaron marcadores de años sin sustituir: __ANIO_SIN_SIMCE_NI_» | motor reescrito (el paso 33 pasa); vista sin reescribir |
| `vista_hasta_malescrito` | 1 | «Error en sustituir_anios(html_tray, …): La página trae un solo extremo del tramo de años sin Simce: __ANIO_SIN_SIMCE_DESDE__ sin __ANIO_SIN_SIMCE_HASTA__» | motor reescrito; vista sin reescribir |
| `motor_desde_malescrito` | 1 | «Error en sustituir_anios(plantilla, meta$anios, ANIOS_SIN_SIMCE): La página trae un solo extremo del tramo de años sin Simce: __ANIO_SIN_SIMCE_HASTA__ sin __ANIO_SIN_SIMCE_DESDE__» | ninguna reescrita |
| `motor_y_malescrito` | 1 | «Error en sustituir_anios(plantilla, meta$anios, ANIOS_SIN_SIMCE): Quedaron marcadores de años sin sustituir: __ANIO_SIN_SIMCE_» | ninguna reescrita |
| `tramo_2019_2021` | 1 | «Error en eval(ei, envir): Nivel 2m: faltan años 2020» (paso 31; «Ejecución interrumpida») | ninguna reescrita |
| `tramo_2019_2021_con2020` | 1 | «Error en tramo_anios(anios_sin_simce, "ANIOS_SIN_SIMCE"): ANIOS_SIN_SIMCE no es un tramo consecutivo (2019, 2021): no puede escribirse como rango» (paso 33); antes, «OK: 20 archivos detectados (10 por nivel), años 2014, …, 2018, 2020, 2022, …, 2025.» y los dos avisos «simce{2m,4b}2020_rbd_final.xlsx: año interno (2018) difiere del nombre (2020).» | ninguna reescrita |

Las salidas del árbol siguen en 42ab9300… y 883f76bc…; `git status --porcelain` = los cuatro archivos de N1 y este log.

obtenido (criterio):
- **I-4.** Build con el código de N1 (`cal_s35m/n1/build.txt`, 19:57:08 a 19:57:16): codigo_build=0, «Fallas criticas: 0 | Advertencias: 7», «OK en 7 segundos». Motor **42ab93003e722f9bb6c725fec2d348bd** y vista **883f76bcefc89d93f2d1e753fc4d75c3**; `cmp` contra `docs/index.html` y `docs/trayectorias.html`, código 0 y 0: **iguales byte a byte**. `h6_diff.R`, codigo_h6diff=0: «fuera del bloque de datos, idéntico: TRUE | largo 837548 837548»; «JSON sin fecha_generacion, identical: TRUE»; «caracteres distintos: 0». En `docs/index.html` el título de la nota es `Gap 2019–2021` (`od -c`: el escape de Babel, seis caracteres ASCII); la salida nueva es byte a byte igual, así que el escape también. `grep -c '__ANIO_'` = 0 en las dos salidas. Las 7 advertencias del validador son las de H6; la de `10_utils/10_html.R` pasa de la L130 a la L175 por las líneas agregadas encima, y es la misma línea de código (`fin <- paste0("\n<!-- SITIO_", bloque, "_FIN -->")`, `sed -n` en las dos versiones).
- **`grep` de §2 sobre las plantillas** (`grep -n '2019\|2020\|2021' 30_procesamiento/36_trayectorias_template.html 30_procesamiento/33_motor_template.html 30_procesamiento/33_fragmento_sitio.html`, `cal_s35m/n1/grep_s2_despues.txt`): grep_codigo=0, **5 líneas, todas comentarios**:
```text
30_procesamiento/33_motor_template.html:2347:    //     (consecutivas a través del gap 2019-2021 y del corte de traspaso),
30_procesamiento/33_motor_template.html:2595:        // Banda 2019-2021
30_procesamiento/33_motor_template.html:2612:        // del gap 2019-2021: aquí solo modula opacidad y estilo de trazo.
30_procesamiento/33_motor_template.html:2641:        // Tramos del gap 2019-2021. Cuando hay corte de traspaso, se subdivide
30_procesamiento/36_trayectorias_template.html:1161:  if(sn.options[sn.selectedIndex].disabled){   /* p. ej., cohorte 2021 con serie completa */
```
  Los marcadores de años sin Simce en las plantillas: vista L425 `__ANIO_SIN_SIMCE__` (s35l), L462 `__ANIO_SIN_SIMCE_NI__` y L1032 `__ANIO_SIN_SIMCE_DESDE__ a __ANIO_SIN_SIMCE_HASTA__`; motor L5063 `__ANIO_SIN_SIMCE_DESDE__–__ANIO_SIN_SIMCE_HASTA__` y L5064 `__ANIO_SIN_SIMCE__`.
- **Prueba unitaria** (`cal_s35m/n1/unidad.R`, codigo_unidad=0): **14 de 14**. `enumerar_anios()` con «y» y con «ni» (1, 2 y 3 años, desordenados); `tramo_anios()` (extremos de un tramo; un año da «2019» y «2019»; 2019 y 2021 → «ANIOS_SIN_SIMCE no es un tramo consecutivo (2019, 2021): no puede escribirse como rango»); las dos plantillas reales con el sitio insertado (vista: «No existe Simce 2019, 2020 ni 2021. El tramo», `'2019 a 2021, sin medición'` y «2019, 2020 y 2021 no tienen medición Simce»; motor: «<h4>Gap 2019–2021</h4>» y «en 2019, 2020 y 2021 fue interrumpida»; 0 `__ANIO_`); el motor con la llamada de antes, sin el argumento → «Quedaron marcadores de años sin sustituir: __ANIO_SIN_SIMCE_DESDE__, __ANIO_SIN_SIMCE_HASTA__, __ANIO_SIN_SIMCE__»; la vista con 2019 y 2021 → el mensaje del tramo; el motor con 2019 a 2021 y 2027 → «… (2019, 2020, 2021, 2027) …»; una página sin forma de rango con 2019 y 2021 → sin error (la forma de rango solo se calcula si la página la usa); un solo extremo; ningún marcador de años sin Simce; «ni» mal escrito; un NA.
- **M2 de la batería del motor** lee de las fuentes **15 marcadores** (12 en H5): los 12 de antes más `__ANIO_SIN_SIMCE__`, `__ANIO_SIN_SIMCE_DESDE__` y `__ANIO_SIN_SIMCE_HASTA__` (lista impresa con el mismo patrón, `__[A-Z0-9_]+__`, sobre la plantilla y el fragmento). Calibración: la batería completa contra una copia de la salida con `Gap 2019–2021` → `Gap __ANIO_SIN_SIMCE_DESDE__–2021` (`cal_s35m/n1/sabotaje/`, `diff` de una línea; 20:01:05 a 20:02:15): codigo_sabotaje=1, «Resultado: 8 pruebas, 7 pasan, 1 fallan», FALLA solo en M2, «en el motor: __ANIO_SIN_SIMCE_DESDE__, PATRON_ANIO_RESTO». **Los nuevos quedan cubiertos: `33_verificar_motor.R` no se toca.**
- **I-3:** codigo_i3=0, «JSON idéntico a la línea base» (19:59:21). **Baterías** (19:59:21 a 20:00:51): motor codigo_motor=0, «Resultado: 8 pruebas, 8 pasan, 0 fallan (en 70 segundos)», con M2 «15 marcadores de las fuentes y 2 patrones de resto; en el motor: ninguno»; vista codigo_vista=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan».
**Cumple.**

md5 de los archivos de N1: `10_html.R` be92384a5228f9ae07c02075f808d4d3 (238 líneas), `33_generar_html.R` 4a19626671f2e895d8a7cbb24b5e020c, `33_motor_template.html` 708ee0ac24e50ed6d5259b3041782e1b, `36_trayectorias_template.html` 87cceae022197e785afd222394f844d1. `git diff --numstat`: 60/15, 6/4, 2/2 y 2/2. `# REVISAR` en el diff: 0.

**Commit** `refactor(sitio): los años sin Simce de los textos visibles salen de ANIOS_SIN_SIMCE (Q-80)`: `3cbb42c`, padre `10512e4`; `--numstat`: `10_html.R` 60 15, `33_generar_html.R` 6 4, `33_motor_template.html` 2 2, `36_trayectorias_template.html` 2 2; `git status --porcelain` = solo este log (20:02:51).

**Estado:** completa, en el primer intento (19:55:29 a 20:02:51). **Alcance:** 4 de los 5 archivos del ALCANCE; `33_verificar_motor.R` no se toca, porque M2 ya cubre los marcadores nuevos (medido arriba). **Regresión:** build, I-3, I-4 y las dos baterías (arriba). **Subagentes:** 0. **Bugs:** ninguno.

**Decisiones autónomas:**
- D1-a (riesgo bajo): la forma de rango son dos marcadores, uno por extremo (`_DESDE` y `_HASTA`), con el conector en la plantilla, en vez de un marcador por cada rango. Es la convención del rango de los datos (`__ANIO_MIN__`/`__ANIO_MAX__`), sirve para «a» y para el guion largo, y R no escribe caracteres fuera de ASCII (el guion queda en la plantilla, y Babel recibe el mismo texto). Para que el par funcione como una sola forma, `sustituir_anios()` se detiene si la página trae un solo extremo.
- D1-b (riesgo bajo): la enumeración con «ni» es `enumerar_anios(anios, "ni")`: la función de s35l recibe la conjunción, «y» por omisión, y sus llamadas no cambian. La función nueva de formato es `tramo_anios(anios, nombre)`.
- D1-c (riesgo medio): con `anios_sin_simce`, `sustituir_anios()` sustituye los marcadores de años sin Simce que la página trae, y exige al menos uno. En s35l exigía `__ANIO_SIN_SIMCE__`, la única forma que había. El cambio era necesario, porque la vista trae tres formas y el motor dos. Consecuencias: (1) el control `sinsimce_malescrito` de L4 de s35l (`__ANIO_SIN_SIMCE_` en la vista) ya no sale por «La página no trae el marcador __ANIO_SIN_SIMCE__», sino por «Quedaron marcadores de años sin sustituir: __ANIO_SIN_SIMCE_». El build se sigue deteniendo; es el mismo camino de `vista_ni_malescrito` y `motor_y_malescrito` de esta sección. (2) Si una plantilla vuelve a escribir una forma a mano, sin su marcador, la función no lo detecta: eso lo mide el `grep` de §2. (3) La forma de rango solo se calcula si la página la usa (U10), así que un `ANIOS_SIN_SIMCE` no consecutivo detiene solo las páginas que lo escriben como rango.
- D1-d (riesgo bajo): el control de rango del criterio agrega a la copia dos xlsx de 2020, copias de los de 2018. Con solo 2019 y 2021, el ejemplo del encargo, el paso 31 se detiene antes («Nivel 2m: faltan años 2020»), y la forma de rango no llega a correr. Las dos variantes quedan anotadas: con los datos de hoy, un `ANIOS_SIN_SIMCE` con un hueco lo detiene primero el paso 31.
- D1-e (riesgo bajo): `36_generar_trayectorias.R` está fuera del ALCANCE de N1 y no se toca. Su llamada ya pasa `ANIOS_SIN_SIMCE`, pero el comentario de sus L122 a L124 nombra solo «años sin Simce del aviso del plano», y hoy también cubre las notas y la pista. Va como ADVIERTE en FASE R.

**Errores propios:** la hora de inicio de esta sección se escribió sin medir (19:57) en el mismo comando que corría `date` (19:55:29), y se corrigió enseguida. Es la segunda vez en la sesión (ver FASE 0). **Dudas:** ninguna.

### FASE R: auditoría y reparación

Inicio: 20:03:45 (`date` del comando que cerró N1).

**R.1 Inventario de afirmaciones auditables** (armado desde las secciones anteriores de este log, antes de auditar; cada una se re-deriva en R.2 con un comando distinto del que la produjo; scripts y salidas en `$TMPDIR/cal_s35m/fase_r/`)

| id | afirmación (fase) |
|---|---|
| R-01 | H1: el árbol con las tres rutas de T0 más el log (FASE 0) |
| R-02 | H2: stash 0; un solo worktree (FASE 0) |
| R-03 | H3: `HEAD` y `origin/main` en 0f419b4; I-1 de partida; I-5 de partida (lock e6323bf2…, settings d0bcb98d…, 58 paquetes iguales a s35l) (FASE 0) |
| R-04 | H4: md5 del encargo cccdba6d…; `docs/` 42ab9300… y 883f76bc…; T0 = 10512e4, padre 0f419b4, con las tres rutas (FASE 0) |
| R-05 | H5: batería del motor 8 de 8; de la vista, 35 de 35 (FASE 0) |
| R-06 | H6: build con 0 críticas y 7 advertencias; salidas iguales byte a byte a `docs/`; JSON sin la fecha idéntico (FASE 0) |
| R-07 | Calibración de `verificar_contenido_motor.R` sobre `base_s35m`: «idéntico» y, con 3.5 → 3.6, «difiere» (FASE 0) |
| R-08 | Paso 8: el `grep` de §2 da las 9 líneas de §2; en los generadores y utilidades, solo comentarios y la definición; los años vecinos (2018 y 2022) en vista L1028, L1030 y L1170 y motor L2644, L2645 y L5060; el motor arma otro texto del tramo desde `GAP_YEARS` (L4123 a L4127) (FASE 0) |
| R-09 | Diseño: las cuatro formas publicadas son «2019, 2020 y 2021» (vista L425 y motor L5064), «2019, 2020 ni 2021» (vista L462), «2019 a 2021» (vista L1032) y «2019–2021» (motor L5063, escrito `2019–2021` por Babel) (N1) |
| R-10 | I-4 con el código de N1: salidas iguales byte a byte a `docs/`; 0 `__ANIO_` en las salidas; validador con 7 advertencias, la de `10_html.R` de L130 a L175 con la misma línea de código (N1) |
| R-11 | `grep` de §2 después de N1: 5 líneas, todas comentarios (N1) |
| R-12 | Prueba unitaria 14 de 14 (N1) |
| R-13 | Los seis controles con el build completo: código 1 y el mensaje predicho en cada uno; las salidas del árbol sin cambio (N1) |
| R-14 | M2 lee 15 marcadores de las fuentes, los 3 nuevos incluidos; con `__ANIO_SIN_SIMCE_DESDE__` sin sustituir en una salida, FALLA solo M2 (N1) |
| R-15 | I-3 y baterías después de N1: idéntico, 8 de 8 y 35 de 35 (N1) |
| R-16 | Commit 3cbb42c, padre 10512e4, 4 archivos (60/15, 6/4, 2/2, 2/2), con los md5 anotados; 0 `# REVISAR` (N1) |
| R-17 | `33_verificar_motor.R` y `36_generar_trayectorias.R` no cambian (N1, D1-e) |
| R-18 a R-23 | I-1 a I-6 (§4) |
| R-24 | Alcance global: `git diff --name-only 10512e4..HEAD` dentro de la unión de los ALCANCE más el log; `git status` |
| R-25 | Identidad de lo publicado (`git hash-object` sobre `docs/` y `40_salidas/`) y ausencia de red (`grep -c 'http'`, revisado a mano) |

**R.2 Re-derivación independiente** (sin subagentes; el orquestador, con otros comandos; scripts y salidas en `$TMPDIR/cal_s35m/fase_r/`: `rd_a.txt`, `rd_b.py`, `rd_c_unidad.R`, `rd_d_controles.sh` con `rd_d_prediccion.txt`, `rd_red.py`, `alcance.py`)
esperado: cada afirmación del inventario se confirma o se refuta con un instrumento distinto del original
obtenido: **25 de 25 confirmadas**, 0 refutadas:
- R-01 (`rd_a.txt`): `git diff-tree --name-status -r 10512e4` = las tres rutas de H1 (M, A, M); el encargo no existía en 0f419b4 (`cat-file -e`, código 128); el log no está en ningún commit (0).
- R-02: `git rev-parse -q --verify refs/stash`, código 1; `.git/worktrees` no existe (código 1).
- R-03: `git cat-file -p 10512e4` → `parent 0f419b41…`; el reflog de `origin/main` la pone en 0f419b4 desde las 19:33:53 (el push de s35l) y sin movimiento después, así que el `fetch` de H3 no la cambió. I-5 de partida: R.3.
- R-04: `openssl dgst -md5`: encargo cccdba6d… en el árbol y en `git show 10512e4:` (el commit guarda el encargo verificado); `docs/` 42ab9300… y 883f76bc….
- R-05, R-15: regresión de R.5.
- R-06, R-10, R-25 (identidad): `git hash-object`: `docs/index.html` = `40_salidas/motor_comparacion.html` = `base_s35m` = `HEAD:docs/index.html` = `origin/main:docs/index.html` = `0f419b4:docs/index.html` = **2554f9a2…**; la vista, en los seis lugares, **7cbbdb75…**. `git diff --quiet 10512e4 HEAD -- docs/`, código 0.
- R-07: R.6 (otra cifra alterada).
- R-08, R-11 (`rd_b.py`, Python sobre `git show` de cada versión, sin `grep`; cada coincidencia se clasifica como comentario si cae después de `//` o dentro de `/* … */` de su línea): en 0f419b4, vista visibles [462, 1032] y comentarios [1161]; motor visibles [5063, 5064] y comentarios [2347, 2595, 2612, 2641]; fragmento ninguna. **En HEAD, visibles 0 en las tres plantillas; comentarios, los mismos 5.** Años vecinos en HEAD: vista [1028, 1030, 1170], motor [2644, 2645, 5060]. Generadores y utilidades de HEAD: solo líneas de comentario más la definición (`10_configuracion.R:33`); los comentarios de `10_html.R` son ahora L29-31, L91-92 y L101 (N1 los reescribió). `GAP_YEARS` en el motor: L1350, L1799, L2596, L4123 a L4127.
- R-09 (`rd_b.py`): las cinco cadenas publicadas, cada una **1 vez en `docs/` y 1 vez en `40_salidas/`**: «No existe Simce 2019, 2020 ni 2021.», `gl.textContent='2019 a 2021, sin medición'`, «>2019, 2020 y 2021 no tienen medición Simce<», `Gap 2019–2021` y `La aplicaci\xF3n del Simce en 2019, 2020 y 2021 fue interrumpida` (el motor, con los escapes de Babel). `__ANIO_` 0 en las cuatro salidas.
- R-10 (`rd_b.py`): hallazgos del validador de H6 y de N1, 7 y 7, con archivo e id iguales; la única fila distinta, `10_html.R` 130 → 175; la L130 de 0f419b4 y la L175 de HEAD son la misma línea (`fin <- paste0("\n<!-- SITIO_", bloque, "_FIN -->")`).
- R-12 (`rd_c_unidad.R`, entradas distintas de las de N1): **7 de 7**: cuatro años en lista («2019, 2020, 2021 y 2022» y «… ni 2022»); el motor real con 2019 a 2022 («Gap 2019–2022»); cada marcador dos veces y pegados entre sí (todas las apariciones, sin pisarse: `__ANIO_SIN_SIMCE__` no toca `__ANIO_SIN_SIMCE_NI__`); el extremo que falta es el primero; vector vacío; un hueco al comienzo («(2017, 2019, 2020, 2021)»); sin el argumento, una página con solo el rango de datos, igual que en s35k. Observación, fuera del criterio: con años repetidos, `enumerar_anios(c(2019, 2019, 2020))` da «2019, 2019 y 2020» y `tramo_anios()`, «2019/2020» (R-31).
- R-13: `rd_b.py` lee los `.cod` y `.txt` de los seis controles: códigos 1 y los mensajes de la tabla de N1. (Para `tramo_2019_2021`, la expresión regular del instrumento cortó en el último «:» y mostró «faltan años 2020»; la línea completa, «Nivel 2m: faltan años 2020», es la anotada.) Además, **dos controles nuevos con el build completo, con sabotajes distintos** (`rd_d_controles.sh`; predicción escrita antes en `rd_d_prediccion.txt`; 20:05:49 a 20:06:03), **los dos como se predijo**: `tramo_con2027` (`ANIOS_SIN_SIMCE <- c(2019L, 2020L, 2021L, 2027L)`, sin plantar datos): código 1; el paso 31 pasa («OK: 18 archivos detectados…») y el 33 se detiene con «ANIOS_SIN_SIMCE no es un tramo consecutivo (2019, 2020, 2021, 2027): no puede escribirse como rango». `vista_desde_literal` (en la vista, `__ANIO_SIN_SIMCE_DESDE__ a` → `2019 a`, un año escrito a mano de vuelta): código 1; el motor pasa y el paso 36 se detiene con «La página trae un solo extremo del tramo de años sin Simce: __ANIO_SIN_SIMCE_HASTA__ sin __ANIO_SIN_SIMCE_DESDE__». Salidas del árbol sin cambio (42ab9300…, 883f76bc…).
- R-14 (`rd_b.py`, Python sobre `git show`): marcadores `__X__` de la plantilla del motor y del fragmento: **12 en 0f419b4 y 15 en HEAD**; los de años, `__ANIO_MAX__` y `__ANIO_MIN__` antes, más `__ANIO_SIN_SIMCE__`, `__ANIO_SIN_SIMCE_DESDE__` y `__ANIO_SIN_SIMCE_HASTA__` después.
- R-16 (`rd_a.txt`): `git cat-file -p 3cbb42c` → `parent 10512e42…`; `git diff-tree --numstat` = 60/15, 6/4, 2/2 y 2/2; `openssl dgst -md5` de `git show 3cbb42c:` de cada archivo = los cuatro md5 anotados; `REVISAR` en `git diff 10512e4 HEAD`: 0.
- R-17: `git diff --quiet 10512e4 HEAD -- 30_procesamiento/33_verificar_motor.R 30_procesamiento/36_generar_trayectorias.R`, código 0.
- R-18 a R-23: R.3. R-24: R.4.
- R-25 (red): `grep -c 'http'` = 17 líneas en el motor y 2 en la vista. `rd_red.py` (copia del de s35l) lista cada URL con su contexto; se revisaron a mano. En el motor, 26 apariciones de 9 URL: espacios de nombres XML de `www.w3.org` (svg, xhtml, xlink, XML, MathML, xmlns), la cadena de error de ReactDOM (`reactjs.org/docs/error-decoder.html`) y los comentarios de licencia de D3 (`d3js.org`) y pako (`github.com/nodeca/pako`). En la vista, 2 del espacio de nombres SVG. `src=`/`href=` con http, 0; `url(http`, 0; `@import`, 0; `fetch`/`XMLHttpRequest` a http, 0; enlaces `<a href="http…">`, 0 y 0. La salida del script es idéntica a la de s35l (`diff`, código 0): las salidas son las mismas. **0 cargas por red.**

**R.3 Invariantes 🔒** (comandos de §4; salida literal en `$TMPDIR/cal_s35m/fase_r/invariantes.txt`)

I-1 `git for-each-ref --format='%(refname) %(objectname)'` contra `i1_fase0.txt`, fuera de `refs/heads/main` y `refs/remotes/origin/main`
esperado: iguales
obtenido: `diff`, código 0. `refs/heads/main` 3cbb42c6…; `refs/remotes/origin/main` y `origin/HEAD` 0f419b41… (sin cambio); `feat/contrato-contexto`, local y remota, 31befa2c… → **PASA**

I-2 `md5 -q docs/index.html docs/trayectorias.html`
esperado: 42ab9300… y 883f76bc…
obtenido: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 → **PASA**

I-3 `Rscript verificar_contenido_motor.R`
esperado: «JSON idéntico a la línea base»
obtenido: codigo_i3=0, «JSON idéntico a la línea base» → **PASA**

I-4 md5 de la vista contra `docs/`; motor fuera de `meta$fecha_generacion` (`h6_diff.R`) y, por ser el mismo día, `cmp`
esperado: iguales
obtenido: vista 883f76bcefc89d93f2d1e753fc4d75c3; motor «fuera del bloque de datos, idéntico: TRUE», «JSON sin fecha_generacion, identical: TRUE», «caracteres distintos: 0»; `cmp` contra `docs/index.html`, código 0 → **PASA**

I-5 `md5 -q renv.lock renv/settings.json` contra `i5_fase0.txt`
esperado: idénticos
obtenido: `diff`, código 0; e6323bf2d0fb341589c4ce8a19b74636 y d0bcb98db909870724e9b0fc5eff1700 → **PASA**

I-6 `git ls-files | grep -cE '\.(csv|xlsx|parquet|rds)$'`
esperado: 28
obtenido: 28 → **PASA**

**R.4 Alcance global** (`fase_r/alcance.py`, con los ALCANCE de §5, sobre `git diff --name-only`; y `git status --porcelain`)
esperado: dentro de la unión de los ALCANCE más el log; `status` solo con el log
obtenido: `10512e4..HEAD`: «rutas: 4 | por tarea: N1 4 | fuera: (ninguna)», código 0; con T0 (`10512e4^..HEAD`): 7 rutas, T0 3 y N1 4, fuera ninguna, código 0. `git status --porcelain` = `?? …/20260926_textos_anios_s35m_log.md` → **PASA**

**R.5 Regresión completa** (estado final, códigos leídos sin tubería; 20:06:40 a 20:08:18)
esperado: build código 0 con 0 críticas; batería del motor código 0 (8 pruebas); batería de la vista código 0 con 35 o más; «JSON idéntico a la línea base»
obtenido: codigo_build=0, «Fallas criticas: 0 | Advertencias: 7», «OK en 6 segundos»; codigo_motor=0, «Resultado: 8 pruebas, 8 pasan, 0 fallan (en 70 segundos)»; codigo_vista=0, «Resultado: 35 pruebas, 35 pasan, 0 fallan»; codigo_i3=0, «JSON idéntico a la línea base»; salidas con los blobs de `docs/` (2554f9a2…, 7cbbdb75…) → **PASA**

**R.6 Control positivo de la propia auditoría** (`control_positivo.txt`, copias en `fase_r/ctl_audit/`)
esperado: cada instrumento dispara con una cifra alterada y con una ruta fuera de alcance
obtenido: **disparan todos:**
- identidad de lo publicado, con «2019, 2020 ni 2021» → «2019, 2020 ni 2022» en una copia de la vista: la cadena de R-09, 0 veces en la copia; `git hash-object` c9e44430… ≠ blob de `docs/` 7cbbdb75…;
- I-3 con otra cifra (el **tercer** número decimal del JSON, 29.7 → 29.8, recomprimido en Python con `zlib`): codigo_i3_alt3=1, «JSON difiere: $datos$pct[[3]] (29.8 vs 29.7)»;
- alcance con un diff simulado que agrega `30_procesamiento/36_generar_trayectorias.R` y `docs/index.html`: «fuera: ['30_procesamiento/36_generar_trayectorias.R', 'docs/index.html']», código 1;
- el `grep` de §2 y el clasificador de `rd_b.py`, con «No existe Simce 2019, 2020 ni 2021.» escrito a mano de vuelta en una copia de la plantilla de la vista: `grep` 2 líneas (L462 y L1161) y `rd_b.py` «visibles [462] | comentarios [1161]»;
- red, con un `<img src="https://example.invalid/x.png">` plantado en una copia del motor: `grep -c 'http'` 18 (17 en la salida) y `src=`/`href=` con http 1;
- I-6 con un `.csv` simulado en la lista: 29;
- I-5 con el md5 del lock alterado en una copia: `diff`, código 1;
- I-1 con el hash de `feat/contrato-contexto` alterado en una copia: `diff`, código 1.

**R.7 Veredicto por hallazgo**
- BLOQUEA: ninguno.
- REPARA: **R-26**. El encabezado de `33_generar_html.R` (paso 4 del flujo, L19 a L21) dice que antes de transpilar solo `__ANIO_MIN__` y `__ANIO_MAX__` pasan a los años de `meta$anios`. Desde N1 también se sustituyen los marcadores de años sin Simce, desde `ANIOS_SIN_SIMCE`. N1 actualizó el comentario de la llamada (L431 a L434), pero no el encabezado. Es un defecto del propio trabajo, dentro del ALCANCE de N1, sin efecto sobre un 🔒. Se corrige en R.8.
- ADVIERTE: R-27 a R-33 (tabla R.10).

**R.8 Ciclo de reparación** (un ciclo; R-26)
- (a) Causa raíz: N1 cambió la llamada de `33_generar_html.R` y su comentario (L431 a L434), pero no revisó el encabezado del archivo. Ese encabezado describe el flujo por pasos, y su paso 4 nombra los marcadores que se sustituyen antes de transpilar.
- (b) Arreglo quirúrgico, dentro del ALCANCE de N1: la L21 del encabezado pasa a dos líneas: «año de meta$anios (D35-19), y los marcadores de años sin Simce, a / ANIOS_SIN_SIMCE de 10_configuracion.R (encargo s35m, Q-80).» Es solo un comentario; `git diff` = 2 líneas agregadas y 1 quitada.
- (c) Re-verificación con el mismo chequeo (la lectura del encabezado, `sed -n 1,29p | grep -c ANIOS_SIN_SIMCE`): antes 0, después 1. Con otro chequeo (Python sobre las primeras 29 líneas, `r8_antes.txt` y `r8_despues.txt`): antes «MIN True | MAX True | años sin Simce False», después «… años sin Simce True». `parse()` del archivo, sin error.
- (d) Regresión (20:11:01 a 20:12:45): build codigo_build=0, «Fallas criticas: 0 | Advertencias: 7», salidas con los blobs de `docs/` (2554f9a2…, 7cbbdb75…) y `cmp` 0 y 0; batería del motor codigo=0, «8 pruebas, 8 pasan, 0 fallan (en 70 segundos)»; batería de la vista codigo=0, «35 pruebas, 35 pasan, 0 fallan»; I-3 codigo=0, «JSON idéntico a la línea base».
- (e) Commit `fix(auditoria): R-26 el encabezado del paso 33 nombra los años sin Simce`: `ed07558`, padre `3cbb42c`; `33_generar_html.R` 2/1; md5 1fe3e1b7d589bdb29ef1f79b6983ece7.
- (f) Fila R-26 de R.10.
- Pasos 2 a 5 sobre lo tocado (20:12:51): R.2, la identidad de las salidas con `git hash-object` (arriba) y `parse()`; R.3, I-1 (`diff`, 0), I-2 (42ab9300…, 883f76bc…), I-3 e I-4 (en la regresión), I-5 (`diff`, 0) e I-6 (28); R.4, alcance con `10512e4^..HEAD`, 7 rutas (T0 3, N1 4), ninguna fuera, código 0; `git status --porcelain` = solo este log; R.5, la regresión de (d). El hallazgo no sobrevive y no destapó otro.

**R.9 Prohibiciones.** No se ajustó ningún criterio, tolerancia, valor esperado, meta ni ALCANCE, y no se tocó ningún 🔒. La reparación cambió el trabajo (un comentario del ALCANCE de N1). La evidencia ya escrita no se editó. Las dos horas corregidas (cierre de FASE 0 e inicio de N1) se corrigieron en su propia sección antes de seguir, y están declaradas en sus errores propios. No hubo subagentes.

**R.10 Tabla de auditoría**

| id | afirmación | comando de re-derivación | esperado | obtenido | severidad | acción | commit | re-verificación |
|---|---|---|---|---|---|---|---|---|
| R-01 | H1 | `diff-tree 10512e4`; `cat-file -e 0f419b4:` | 3 rutas; encargo nuevo | así | — | ninguna | — | — |
| R-02 | H2 | `rev-parse -q --verify refs/stash`; `test -d .git/worktrees` | sin stash; sin worktrees | así | — | ninguna | — | — |
| R-03 | H3 e instantáneas | `cat-file -p 10512e4`; reflog de `origin/main`; R.3 | 0f419b4; sin movimiento | así | — | ninguna | — | — |
| R-04 | H4 y T0 | `openssl dgst -md5`, `git show 10512e4:` | cccdba6d…; 42ab…/883f… | así | — | ninguna | — | — |
| R-05 | H5 | R.5 | 8/8; 35/35 | 8/8; 35/35 | — | ninguna | — | — |
| R-06 | H6 | `git hash-object` | = `docs/` | = `docs/` | — | ninguna | — | — |
| R-07 | calibración de I-3 | R.6, el tercer número | difiere | difiere | — | ninguna | — | — |
| R-08 | paso 8 | `rd_b.py` (Python sobre `git show 0f419b4:`) | 9 líneas; 4 visibles | así | ADVIERTE (R-29) | registrar | — | — |
| R-09 | formas publicadas | `rd_b.py` sobre `docs/` y `40_salidas/` | 5 cadenas, 1 y 1 | así | — | ninguna | — | — |
| R-10 | I-4 y validador en N1 | `hash-object`; `rd_b.py` | = `docs/`; 7 = 7 | así; L130 = L175 | — | ninguna | — | — |
| R-11 | `grep` después de N1 | `rd_b.py` (Python sobre `git show HEAD:`) | 0 visibles; 5 comentarios | así | — | ninguna | — | — |
| R-12 | unidad 14/14 | `rd_c_unidad.R` (otras entradas) | 7 de 7 | 7 de 7 | ADVIERTE (R-31) | registrar | — | — |
| R-13 | seis controles | `rd_b.py` sobre `.cod`/`.txt`; dos controles nuevos | como se predijo | así | ADVIERTE (R-30) | registrar | — | — |
| R-14 | M2 con 15 marcadores | Python sobre `git show` | 12 → 15 | 12 → 15 | — | ninguna | — | — |
| R-15 | I-3 y baterías en N1 | R.5 | PASA | PASA | — | ninguna | — | — |
| R-16 | commit N1 | `cat-file -p`, `diff-tree --numstat`, `openssl` | padre 10512e4; 4 archivos | así | — | ninguna | — | — |
| R-17 | fuera de N1 sin cambio | `git diff --quiet` | 0 | 0 | ADVIERTE (R-28) | registrar | — | — |
| R-18 a R-23 | I-1 a I-6 | R.3 | PASA | PASA | — | ninguna | — | — |
| R-24 | alcance | `alcance.py` | 0 fuera | 0 fuera | — | ninguna | — | — |
| R-25 | identidad y red | `hash-object`; `grep -c http` y `rd_red.py`, revisado a mano | iguales; 0 cargas | iguales; 0 cargas | — | ninguna | — | — |
| R-26 | el encabezado de `33_generar_html.R` (paso 4, L19 a L21) no nombra los marcadores de años sin Simce que el paso sustituye antes de transpilar desde N1 | lectura del encabezado; Python | nombrados | no nombrados | REPARA | una línea del encabezado | `ed07558` | `grep -c` 0 → 1; Python False → True; build = `docs/`; baterías 8/8 y 35/35; I-3 |
| R-27 | D1-c: con `anios_sin_simce`, `sustituir_anios()` exige al menos un marcador de años sin Simce. En s35l exigía `__ANIO_SIN_SIMCE__`. Si una plantilla vuelve a escribir una forma a mano, sin su marcador, el build no se detiene: lo detecta el `grep` de §2, que es manual | `rd_c_unidad.R`; `vista_desde_literal` (un extremo a mano sí se detiene) | — | una forma entera a mano no se detiene | ADVIERTE | registrar (Q-83) | — | — |
| R-28 | el comentario de `36_generar_trayectorias.R` L122 a L124 nombra solo los «años sin Simce del aviso del plano»; la misma llamada cubre hoy las notas y la pista. Está fuera del ALCANCE de N1 | lectura | — | incompleto | ADVIERTE | registrar (D1-e) | — | — |
| R-29 | quedan fijos el código que depende del tramo y un ejemplo con los años vecinos: vista L1028 y L1030 (`tx(2018)` y `tx(2022)`, la banda de la pista), motor L2644 y L2645 (`s.year <= 2018` y `>= 2022`, el corte de las líneas) y motor L5060 (texto visible de «Regla GSE dinámico»: «entre 2018 y 2022»). Un cambio de `ANIOS_SIN_SIMCE` no los movería. Fuera del `grep` de §2 y de N1 | `rd_b.py` (años vecinos) | — | 5 líneas | ADVIERTE | registrar (Q-84) | — | — |
| R-30 | el ejemplo del encargo (2019 y 2021), solo, lo detiene antes el paso 31 («Nivel 2m: faltan años 2020»); para llegar a la forma de rango, el control plantó un xlsx de 2020 (D1-d). `tramo_con2027` llega sin plantar datos. El criterio se cumple | controles de N1 y R-13 | — | 2 variantes | ADVIERTE | registrar | — | — |
| R-31 | casos límite latentes: con años repetidos, la enumeración los repite (`enumerar_anios()`, de s35l, no quita duplicados; `tramo_anios()` sí); un tramo de un año se escribiría «2019 a 2019» y «Gap 2019–2019»; `tramo_anios()` llamada sola con un vector vacío da un error genérico de índice (`sustituir_anios()` revisa el vacío antes). Ninguno ocurre con la constante de hoy | `rd_c_unidad.R` (observación); U3 | — | latentes | ADVIERTE | registrar | — | — |
| R-32 | CLAUDE.md, local e ignorado, no registra s35m en «Últimos cambios». La lista cerrada de autorizaciones de este encargo no incluye editarlo (la 5 está sin uso) | lectura del encargo | — | sin s35m | ADVIERTE | registrar; queda al titular | — | — |
| R-33 | errores propios de redacción y de instrumento, corregidos antes de registrar: dos horas escritas sin medir (cierre de FASE 0 e inicio de N1); un `echo =====` que zsh rechazó (lectura previa); una comparación con `sed 1,0d` mal formada en R-25, repetida con `diff` directo; la expresión regular de `rd_b.py`, que corta en el último «:» al mostrar un mensaje en R-13 | — | — | corregidos | ADVIERTE | registrar | — | — |

**Veredicto global de FASE R: APROBADO CON ADVERTENCIAS.** Ningún BLOQUEA. Un REPARA (R-26, el encabezado de `33_generar_html.R`), corregido en el primer ciclo (`ed07558`) y re-verificado con el mismo chequeo, con otro instrumento y con la regresión. Las 25 afirmaciones del inventario quedaron confirmadas con otros instrumentos: git de bajo nivel en vez de `status`, `openssl` y `git hash-object` en vez de `md5`, Python sobre `git show` en vez de `grep`, otra prueba unitaria (7 de 7) y dos controles nuevos con el build completo y sabotajes distintos, los dos como se predijo. Los ocho controles positivos de la auditoría dispararon. Los seis 🔒 están en PASA. Hay 7 ADVIERTE (R-27 a R-33), ninguno sobre datos, invariantes ni alcance. Los que más pesan son R-27 (una forma entera escrita a mano de vuelta no detiene el build) y R-29 (el código de la banda y el corte de las líneas siguen con 2018 y 2022 fijos).

## Cierre

**Paso 1. Estado del árbol** (`git status --porcelain`, 20:13:52, antes del commit de este log)
esperado: vacío o solo el log
obtenido: `?? 50_documentacion/andamios/logs/20260926_textos_anios_s35m_log.md`, status_codigo=0. Nada que limpiar.

### 1. Resumen

La única tarea, N1, se ejecutó sin tareas congeladas, y el contenido publicado no cambió: `docs/` no se tocó, y el build de hoy lo reproduce byte a byte.
- **N1 (Q-80, D35-21).** Los cuatro textos visibles que escribían a mano los años sin Simce salen ahora de `ANIOS_SIN_SIMCE`: vista L462 («No existe Simce … ni …») y L1032 (pista, «… a …, sin medición»), y motor L5063 («Gap …–…») y L5064 («en … fue interrumpida»). Hay tres marcadores nuevos, `__ANIO_SIN_SIMCE_NI__`, `__ANIO_SIN_SIMCE_DESDE__` y `__ANIO_SIN_SIMCE_HASTA__`, además del `__ANIO_SIN_SIMCE__` de s35l. Los forman `enumerar_anios(anios, conjuncion)` y la función nueva `tramo_anios(anios, nombre)`, que se detiene si los años no son un tramo consecutivo. El motor llama `sustituir_anios()` con `ANIOS_SIN_SIMCE`, antes de transpilar, así que Babel recibe el mismo texto de antes. El `grep` de §2 sobre las plantillas da solo los 5 comentarios. Un marcador de años sin Simce mal escrito detiene el build (4 casos con el build completo en N1), y también un extremo del rango escrito a mano (1 caso en FASE R). Un `ANIOS_SIN_SIMCE` no consecutivo detiene el build con el mensaje de la forma de rango, cuando el build llega al generador (2 casos). La batería del motor cubre los marcadores nuevos sin cambios.

FASE R: 25 de 25 afirmaciones confirmadas con otros instrumentos; 8 controles positivos de la auditoría disparan; los 6 🔒 en PASA; 0 BLOQUEA, 1 REPARA (R-26, el encabezado del paso 33, corregido en `ed07558`) y 7 ADVIERTE. Veredicto: **APROBADO CON ADVERTENCIAS**.

### 2. Inventario de commits (`git log 10512e4..HEAD --oneline`, antes del commit de este log)

```text
ed07558 fix(auditoria): R-26 el encabezado del paso 33 nombra los años sin Simce
3cbb42c refactor(sitio): los años sin Simce de los textos visibles salen de ANIOS_SIN_SIMCE (Q-80)
```

Más el punto de retorno, `10512e4 docs(sesion 35): encargo de la decimotercera ola y decision D35-21` (T0), y el commit de este log, `docs(log): textos de anos sin Simce desde la configuracion (s35m)`, cuyo hash va en el reporte final (un archivo no puede llevar el hash de su propio commit).

### 3. Tabla de auditoría

Ver FASE R, R.10 (R-01 a R-33).

### 4. Invariantes

I-1 a I-6 en PASA en el estado final (FASE R, R.3, y otra vez tras R.8), con re-derivación por otra vía (R.2) y controles positivos que disparan (R.6). En FASE L se midieron otra vez I-1 e I-5 contra las instantáneas de FASE 0 (20:13:52):
- I-1: `diff` fuera de `refs/heads/main` y `refs/remotes/origin/main`, código 0; `main` ed075588…, `origin/main` 0f419b41…, `feat/contrato-contexto` 31befa2c… local y remota (`$TMPDIR/s35m/i1_fase_l.txt`);
- I-5: `diff i5_fase0.txt i5_fase_l.txt`, código 0 (lock e6323bf2…, settings d0bcb98d…).
En ninguna tarea un 🔒 dio FALLA. Antes del push se miden las condiciones de la autorización 6 (reporte final).

### 5. Decisiones del usuario

- En el mensaje de entrega: ejecutar el encargo completo en este turno, previa verificación del md5 (cccdba6dc4ba5e1cb50c91cc81290545, verificado, igual).
- En el encargo: D35-21 (commiteada en T0) y las autorizaciones. Se usaron la 1 (commits de T0, N1 y R-26), la 4 (`verificar_contenido_motor.R`, apuntado a `base_s35m`, y archivos y copias en `$TMPDIR`) y la 6 (va en el reporte final). La 3 no se usó: ningún intento se descartó. La 2 y la 5 están sin uso en el encargo.
- Ninguna otra decisión del titular durante la sesión (modo autónomo).

### 6. Estado de cifras (medidas en esta sesión; git 2.54.0, R 4.5.2, `renv` 1.1.4, `jsonlite` 2.0.0, Chrome sin interfaz vía `chromote` 0.5.1, Python 3.14.7)

- `grep` de §2 sobre las plantillas: 9 líneas (4 visibles, 5 comentarios) → 5 (0 visibles, 5 comentarios).
- Marcadores de años sin Simce: 1 → 4 (en la vista, 1 → 4 apariciones; en el motor, 0 → 3). M2 de la batería del motor: 12 → 15 marcadores leídos de las fuentes.
- Prueba unitaria: 14 de 14 (N1) y 7 de 7 (FASE R, otras entradas).
- Controles con el build completo en copias: 6 (N1) + 2 (FASE R), los 8 como se predijo; uno necesitó plantar un xlsx de 2020 (D1-d).
- Batería del motor: 8 de 8 en 70 s en cuatro corridas (H5, N1, R.5 y R.8), y 7 de 8 contra la salida con un marcador nuevo sin sustituir (FALLA solo M2). Batería de la vista: 35 de 35 en cuatro corridas.
- Validador del build: 0 críticas y 7 advertencias en todas las corridas del árbol (la de `10_html.R`, de L130 a L175).
- `docs/` y `40_salidas/`: 42ab93003e722f9bb6c725fec2d348bd y 883f76bcefc89d93f2d1e753fc4d75c3 (blobs 2554f9a2… y 7cbbdb75…), sin cambio; 0 cargas por red; I-6: 28.
- `10_html.R`: 238 líneas (be92384a…); `33_generar_html.R` final 1fe3e1b7….

### 7. Dudas y pendientes consolidados

Tareas congeladas: ninguna. Hallazgos congelados: ninguno. Este encargo cierra Q-80 (D35-21).

Dudas nuevas (se responden con una palabra):
- Q-83 (R-27). Con `ANIOS_SIN_SIMCE`, `sustituir_anios()` exige hoy al menos un marcador de años sin Simce por página. Si una plantilla vuelve a escribir una forma entera a mano, el build no se detiene; solo lo ve el `grep` de §2. ¿Se hace que cada generador declare las formas que usa su página, para que el build se detenga? (declarar / dejar)
- Q-84 (R-29). Quedan fijos 2018 y 2022 en la banda de la pista de la vista (L1028 y L1030), en el corte de las líneas del motor (L2644 y L2645) y en el ejemplo «entre 2018 y 2022» de la nota «Regla GSE dinámico» del motor (L5060). ¿Se pasan también a `ANIOS_SIN_SIMCE` en un encargo corto? (sí / no)
- Q-85 (R-32). La regla global del titular pide mantener CLAUDE.md al día, pero la lista cerrada de este encargo no autoriza editarlo, y no registra s35m. ¿Se agrega a los encargos una autorización fija para actualizar sus «Últimos cambios» al cerrar? (sí / no)

Pendientes que quedan al titular: la revisión en Safari y en un teléfono de s35h y s35i; el traspaso de cierre; Q-70 y Q-71; Q-81 (con la próxima regeneración de la suite). Excluidos por §11 y sin tocar: `docs/` y Pages, los comentarios de código con esos años, `documentar.R` y la suite, `feat/contrato-contexto` y Museo Sans (D35-7).

`# REVISAR` nuevos: ninguno (`git diff 10512e4 HEAD | grep -c REVISAR` = 0).

### 8. Errores propios consolidados

- De redacción, corregidos en su sección antes de seguir: dos horas escritas sin medir (cierre de FASE 0: 19:55 por 19:53:54; inicio de N1: 19:57 por 19:55:29). Es el mismo patrón de s35l (tres veces allí). Después, cada hora del log sale de un `date` ya impreso.
- De instrumento, corregidos antes de registrar resultados: un `echo =====` que zsh rechazó («===== not found», expansión `=comando`; lectura previa al log, no escribió nada); una comparación con `sed 1,0d` mal formada en R-25, repetida con `diff` directo (código 0); la expresión regular de `rd_b.py`, que al mostrar el mensaje de `tramo_2019_2021` cortó en el último «:».
- De formato, sin ajustar: en N1, tres líneas llevan el rótulo seguido de un paréntesis y no de los dos puntos: «esperado (por caso…)», «obtenido (controles; …)» y «obtenido (criterio):». Por eso el conteo del paso 5 de FASE L no empareja (ver §9). Es el mismo caso de s35l.
- Del trabajo, reparado en FASE R: R-26 (el encabezado del paso 33).
- Ninguno tocó los datos ni el contenido publicado.

### 9. Notas para el revisor

- Diseño (D1-a a D1-c): la forma de rango son dos marcadores de extremo, con el conector («a» o el guion largo) en la plantilla, como el rango de los datos. Una página que trae un solo extremo detiene el build. La forma de rango solo se calcula si la página la usa.
- `sustituir_anios()` exige hoy al menos un marcador de años sin Simce (en s35l exigía `__ANIO_SIN_SIMCE__`). Un marcador mal escrito o un extremo escrito a mano detienen el build; una forma entera escrita a mano, no (R-27, Q-83).
- La parada de la forma de rango se probó con el build completo, pero con los datos de hoy un `ANIOS_SIN_SIMCE` con un hueco lo detiene antes el paso 31 (R-30). La prueba necesitó un año de datos dentro del hueco (un xlsx de 2020 plantado) o un año sin Simce fuera de la serie (2027).
- M2 de la batería del motor pasa de 12 a 15 marcadores leídos de las fuentes, sin cambios en el archivo. La calibración con un marcador nuevo sin sustituir hace fallar solo M2.
- Verificación del archivo (FASE L, paso 5): `^esperado:` y `^obtenido:` no emparejan, por las tres líneas de formato de §8. Se deja el conteo como está (§9.5: no se ajusta), y el resultado va en el paso 5.
- CLAUDE.md, local, no registra s35m (R-32, Q-85).

### 10. Estado de cierre

- **Commiteado:** T0 (`10512e4`), N1 (`3cbb42c`), R-26 (`ed07558`) y, al cerrar esta sección, este log (`docs(log)`), en `main`.
- **Local, sin versionar:** `verificar_contenido_motor.R`, apuntado a `$TMPDIR/base_s35m/`; CLAUDE.md, sin cambios en esta sesión.
- **Condiciones de publicación** (autorización 6), medidas después del commit del log, en el mismo turno: veredicto de FASE R `APROBADO CON ADVERTENCIAS`; `git status --porcelain` vacío (CLAUDE.md, ignorado, no cuenta); `git fetch origin` y `git merge-base --is-ancestor origin/main HEAD` con código 0; md5 de `docs/` sin cambio (I-2). Si se cumplen, `git push origin main` una sola vez; si no, se declara en el reporte final. El resultado y el hash de este commit van en el reporte final.
- **Queda al titular:** la revisión en Safari y en un teléfono de s35h y s35i, el traspaso de cierre, Q-70, Q-71, Q-81 y las dudas Q-83 a Q-85.

**Paso 4. Privacidad** (20:15:41). `grep -nE '[0-9]{1,2}\.?[0-9]{3}\.?[0-9]{3}-[0-9kK]'` sobre este log: vacío, código 1. Un `grep -niE` de nombres de establecimientos y comunas (`liceo`, `escuela`, `colegio`, `rbd <número>` y las comunas del territorio) no halla nada. La lectura lo confirma: no hay filas de datos ni nombres de personas o de establecimientos; las cifras son conteos, md5 y hashes.

**Paso 5. Verificación del archivo** (20:15:41, antes de este párrafo): `ls -l` = `-rw-r--r--  1 tomgc  staff  63177 26 Sep 20:15 50_documentacion/andamios/logs/20260926_textos_anios_s35m_log.md`; `wc -l` = 415. `grep -c '^### FASE'` = **3**, igual a las fases con sección propia (FASE 0, FASE N1 y FASE R; FASE L es este Cierre). `grep -c '^## J'` = **1**, con el bloque relleno (13 campos). `grep -c '^esperado:'` = **20** y `grep -c '^obtenido:'` = **19**: no son iguales. La diferencia está en las tres líneas de formato de N1 (§8): el `esperado:` del criterio de N1 tiene su resultado en «obtenido (criterio):», y el par de los controles, «esperado (por caso…)» y «obtenido (controles; …)», no cuenta en ninguno de los dos lados. Cada `esperado` tiene su `obtenido`. Se deja el conteo como está (§9.5).
