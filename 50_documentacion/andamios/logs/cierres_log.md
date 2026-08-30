# Log de cierres — slep_simce_adecuado

Registro acumulativo de los cierres ejecutados con el instrumento
`cierre_sesion_autonomo_cc_v11.md`. Una sección por cierre, anexada; jamás un
archivo por cierre. La tabla de rótulos de cada sección es el **insumo de la F3
del cierre siguiente** (regla 7.3, v10): no se resume en prosa.

---

## v28 — 2026-08-28

**Instrumento:** `cierre_sesion_autonomo_cc_v11.md`
**Protocolo:** SETTINGS `> **Versión 34.**`, POLITICA v5.8
**Sesión:** 28 · **Traspaso:** v28 · **Tramo:** 139–157 (19 entradas) · **Total:** 157
**Hash de documentación (F7):** `3ac607d`
**Estado del push:** por publicar

### Fases

| Fase | Resultado |
|---|---|
| F0 Precondiciones | pasa íntegra |
| F1 Copia de trabajo | `mktemp -d`, tres destinos |
| F2 Inserciones estructurales | **detención y decisión del titular** (ver abajo) |
| F3 Rótulos derivados | 2 rótulos disparan, 10 fuera de catálogo aplicable |
| F4 Invariantes I1–I7 | siete en verde |
| F5 Compuerta | abre |
| F6 Árbol real | escáner regenerado, 27 traspasos archivados, tres archivos copiados |
| F7 Commit de documentación | `3ac607d`, 34 archivos |
| F8 Distribución | diff vacío en los tres bloques; paquete eliminado |
| F9 Log y commit del log | esta sección |

### F0 — Precondiciones

- Paquete único: `paquete_cierre_v28.md`. Cuatro delimitadores abren y cierran.
  Cero placeholders.
- Guardia de repo: `raiz_proyecto` = `pwd` = `/Users/tomgc/Projects/slep_simce_adecuado`.
- Correlativo triple: `traspaso_nuevo: v28` = nombre del paquete = máx(v27) + 1.
- Magnitudes contra disco: `backlog_total_previo: 138` = último número real del
  Detalle cronológico; tramo `139→157` empieza en previo+1 y termina en
  previo+19; el bloque trae 19 entradas contiguas 139…157.
- `settings_version` transcribe la línea 3 real de SETTINGS.
- `compuerta_dudas: 4 registradas` calza con las 4 filas de tres campos del §10
  del traspaso.
- Árbol limpio en traspasos, backlog y ESTADO.

### F2 — Dos detenciones sobre la misma fase, con diagnósticos opuestos

Este cierre se intentó **tres veces**. La secuencia importa para
`herramientas_dev` y se registra completa.

**Intento 1 — detención correcta, diagnóstico invertido.** F2 no encontró
ninguno de sus tres objetivos. El reporte concluyó que el instrumento modelaba
un backlog ajeno y propuso enmendar el instrumento. Era al revés: `Resumen
estadístico por sesión` y `Detalle cronológico` son dos de las cinco secciones
que **POLITICA §10 fija como obligatorias**, y el archivo llevaba 28 sesiones sin
ellas. El instrumento acertó; el archivo estaba fuera de norma.

**Corrección.** Encargo `encargo_normalizar_backlog_politica10.md`, ejecutado el
mismo día (commits `a441c98` y `542088c`, log
`20260828_normalizacion_backlog_log.md`). El backlog quedó con las cinco
secciones de §10 y sus 28 bloques cronológicos degradados a `###`. Ninguna
entrada cambió: md5 de la huella idéntico antes y después.

**Intento 2 — detención correcta, diagnóstico correcto.** F2 resolvió dos de
tres. El tercero, `Fila del delta → final de la tabla "Delta del backlog"`,
siguió sin objetivo: 0 apariciones como encabezado, 0 como tabla, 17 como línea
en prosa al pie de cada bloque de sesión.

**Decisión del titular, con su fundamento transcrito:**

> SETTINGS §2.2.5 describe el Delta del backlog como contenido, no como tabla.
> Su viñeta enumera qué debe decir (N entradas nuevas, refinamientos de
> taxonomía, reclasificaciones) y no prescribe formato, a diferencia de la
> viñeta del Resumen estadístico, que sí dice "tabla" y enumera sus columnas.
> POLITICA §10 no lo incluye entre las cinco secciones. La exigencia de tabla es
> del instrumento, no de la norma: el archivo cumple.

Instrucción: componer la línea con el formato de las 17 anteriores, con la
lectura larga en la misma línea después de las cifras. Sin reestructurar nada
más y sin tocar las 17 líneas históricas.

### 🔧 Para la sesión de `herramientas_dev` — dos hallazgos que se resuelven al revés

1. **F2 exige una tabla `Delta del backlog` que ninguna norma del proyecto
   pide.** Es la tercera inserción y es la que sobra. POLITICA §10 no la lista
   entre sus cinco secciones y SETTINGS §2.2.5 la describe como contenido sin
   prescribir formato, a diferencia de las viñetas del Resumen estadístico y de
   la Clasificación temática, que sí dicen "tabla" y enumeran columnas. **La
   enmienda va en el instrumento:** F2 debe aceptar la línea al pie del bloque
   de sesión.
2. **La exigencia de tabla del Resumen estadístico sí es normativa**, y el
   archivo la cumplía solo desde la normalización de hoy. **Ahí la enmienda fue
   del archivo.**

Ambos hallazgos nacen de la misma fase y del mismo síntoma —"F2 no encuentra su
objetivo"— y tienen resoluciones opuestas. La regla que los separa, y que este
cierre deja probada en los dos sentidos: **antes de enmendar una rama de
detención por "no aplica a este proyecto", verificar si lo que exige está
escrito en la norma del proyecto. Si lo está, se enmienda el archivo; si no lo
está, se enmienda el instrumento.** El intento 1 falló por no aplicarla.

### F3 — Rótulos

**Catálogo aplicable: sin historia previa.** `cierres_log.md` no existía: este es
el primer cierre del archivo con este instrumento y sus disparos fundan el
catálogo aplicable del cierre siguiente.

| ID | Rótulo | Disparos | Texto resultante |
|---|---|---:|---|
| R3 | Cobertura "sesiones 1 a N" | 1 | `sesiones 1–26 (traspasos v01–v26)` → `sesiones 1–28 (traspasos v01–v28)`; y `deltas s11–s26` → `deltas s11–s28` |
| R12 | Recuento temático: denominador y porcentajes | 2 | tabla de Clasificación temática y fila `Total` del Resumen, recalculadas sobre 157 |

`catalogo no aplicable: R1, R2, R4, R5, R6, R7, R8, R9, R10, R11 (10 de 12)`.

**R12 es un rótulo que dispara por primera vez en este archivo.** No existía
antes de la normalización de hoy: la tabla de Clasificación temática ganó las
columnas `N°` y `%`, y el Resumen estadístico ganó su fila `Total`. Son
afirmaciones nuevas gobernadas por `backlog_total_nuevo`. Pasa a integrar el
catálogo aplicable del cierre v29.

Recuento temático recalculado, con los 19 tags nuevos (UI 7, DOC 5, REPO 3,
DT 3, P 1):

| Código | Antes | Nuevos | Después | % sobre 157 |
|---|---:|---:|---:|---:|
| P | 13 | 1 | 14 | 8,9% |
| UI | 52 | 7 | 59 | 37,6% |
| D | 2 | 0 | 2 | 1,3% |
| DOC | 35 | 5 | 40 | 25,5% |
| REPO | 21 | 3 | 24 | 15,3% |
| Infra | 6 | 0 | 6 | 3,8% |
| DT | 9 | 3 | 12 | 7,6% |
| **Total** | **138** | **19** | **157** | **100,0%** |

**Cifras sin rótulo** en zonas declarativas, para ampliar el catálogo:
`cifra sin rotulo: 2026-06-09 — línea de Cobertura ("Consolidado v01–v10 el
2026-06-09")` → (b) cifra histórica legítima, de un tramo cerrado.
`cifra sin rotulo: sesión 11 — misma línea` → (b) ídem.
`cifra sin rotulo: sesión 20 — misma línea ("s14–s19 reconstruidos")` → (b) ídem.
`cifra sin rotulo: v09 — línea de Propósito` → (b) ídem.
Ninguna reaparece por segunda vez sin resolver.

### F4 — Invariantes

| # | Invariante | Resultado |
|---|---|---|
| I1 | Numeración contigua | verde — 1…157, sin huecos ni duplicados, medida solo sobre el Detalle cronológico |
| I2 | Cuadratura | verde — las 29 filas del resumen suman 157 = `backlog_total_nuevo` |
| I3 | Filas del resumen | verde — 28 + 1 = 29 |
| I4 | Sin magnitudes viejas sobrevivientes | verde — cero apariciones de `138`, `1–26` o `s11–s26` en zonas declarativas tras F3 |
| I5 | Sin autorreferencias | verde — el bloque de autoría no declara cuántas entradas trae; las cifras están solo en la línea de delta, que la escribe el ejecutor |
| I6 | Gobernanza | verde — cero OneDrive, rutas absolutas, credenciales, coautoría de la herramienta o placeholders. Dos `MRUN` en el backlog, ambos en las entradas históricas 111 y 119, que registran el hallazgo de la auditoría Ley 21.719; son texto sobre un hallazgo, no datos |
| I7 | Traspaso vigente | verde — 27 planos archivados con `git mv`, exactamente 1 vigente (`v28`) |

**I2 e I3 eran incomputables en el intento 1** y lo dejaron declarado: sin tabla
de resumen no hay filas que sumar ni que contar. La normalización las volvió
medibles, que era su propósito.

### F6 — Árbol real

```
Escaneo completo: 23 carpetas, 175 archivos.
Snapshot: 50_documentacion/estructura/20260828_142629_estructura.{txt,md}
Aliases : 50_documentacion/estructura/estructura_actual.{txt,md}
Poda    : 2 archivo(s) de snapshots antiguos eliminados (retencion: 2 sellos).
```

El aviso `The project is out-of-sync -- use renv::status()` apareció, como en
toda ejecución de esta sesión. No es un fallo del pipeline: `renv` está
desincronizado por los cuatro paquetes sin registrar, pendiente bloqueado por
causa externa.

27 traspasos planos archivados en `traspasos/archivo/` con `git mv`, nunca
`cp`+`rm`. Es el primer archivado del proyecto: `archivo/` no existía.

### F7 — Commit de documentación

`git add` selectivo de traspasos (nuevo y los 27 archivados), backlog, ESTADO y
salidas del escáner. Sin `git add .` ni `-A`. 34 archivos, +754 −186.

**Sucios preexistentes ajenos al cierre, no commiteados** (y descuento exacto que
F10 aplica a su predicado):

```
 D 50_documentacion/andamios/encargo_normalizar_backlog_politica10.md
?? 50_documentacion/activa/encargos/encargo_normalizar_backlog_politica10.md
```

El encargo de normalización fue movido por el titular de `andamios/` a
`activa/encargos/` con un `mv` plano en vez de `git mv`, entre el turno de la
normalización y este cierre. Eso dejó una eliminación rastreada y un untracked
en la ruta nueva. **No es trabajo del cierre y no se tocó.** Queda pendiente que
el titular resuelva el par con `git add -A` sobre esas dos rutas, o con
`git mv` rehecho.

### F8 — Distribución

Diff de los tres bloques de autoría contra su destino: **idénticos los tres**.

| Bloque | Destino | Resultado |
|---|---|---|
| TRASPASO | `traspasos/traspaso_cierre_v28.md` | idéntico |
| BACKLOG_ENTRADAS | bloque `### Sesión 28` del backlog | idéntico |
| ESTADO | `activa/ESTADO.md` | idéntico |

`rm` del paquete ejecutado: única eliminación sancionada.

### Desviaciones y observaciones

1. **El paquete se emitió tres veces.** El criterio de éxito del instrumento
   —"cero reemisiones del paquete por defectos de forma"— no se cumplió. Las
   tres emisiones no fueron por defectos de forma del paquete, que pasó F0
   íntegra las tres veces, sino por el estado del archivo destino y por la
   ampliación del tramo de 17 a 19 entradas para registrar la propia
   normalización. La segunda causa es legítima y esperable; la primera es la que
   este log documenta para `herramientas_dev`.

2. **Deriva del traspaso respecto del árbol, reportada y no editada.** El
   traspaso declara `main` previo al cierre = `c7fb2ee` y "30 commits" de delta
   respecto a v27. Al momento del cierre, `main` previo era `542088c` y el delta
   son 32 commits. Son contenido de autoría: el instrumento prohíbe editarlos y
   manda reportarlos.

3. **`commit_cierre` de `ESTADO.md` = `542088c`**, no el hash del commit del log,
   como establece la v11. El traspaso §9 declara esta limitación por su cuenta:
   el hash del log no existe cuando se redacta el paquete. La ascendencia se
   cumple —`542088c` es antepasado de los dos commits del cierre— pero el
   candado 0bis pasaría en verde aunque estos no se publicaran. **Contrastar en
   la apertura de s29 contra los dos hashes del eco.**

4. **Columna `Modelo` de la fila 28: `no registrado`.** El paquete no declara
   modelo y BACKLOG_NARRATIVA no tiene ese campo. No se infirió, en línea con las
   otras 26 filas sin dato y con la instrucción del propio encargo de
   normalización.

5. **Las descripciones de la Clasificación temática citaban entradas
   inexistentes.** El encargo de normalización prescribió ejemplos que apuntan a
   las entradas 144, 146, 147 y 152, que solo existen a partir de este cierre.
   Fueron referencias adelantadas durante unas horas; este cierre las resuelve.
   Sin acción pendiente.

6. **Desviación triple de taxonomía, no ajustada.** Registrada como entrada 157 y
   en el log de la normalización: `D` al 1,3% bajo el 2% de absorción; `UI` al
   37,6% y `DOC` al 25,5% sobre el 25% de subdivisión; y 7 categorías frente a
   las 8-15 que pide SETTINGS §2.2.5. Reclasificar 157 entradas ya tageadas es
   decisión del titular.

### Lo que este cierre no verificó

- Que el sitio publicado siga sirviendo el build vigente: el cierre no toca
  `docs/` ni ejecuta el pipeline del motor.
- Las cuatro dudas de la compuerta quedan como las dejó el traspaso: registradas
  con su predicado y su medición, ninguna ejecutada en el cierre.
- El renderizado de las dos tablas nuevas del backlog en GitHub.

---

## v29 — 2026-08-29

**Instrumento:** `cierre_sesion_autonomo_cc_v11.md`
**Protocolo:** SETTINGS `> **Versión 34.**`, POLITICA v5.8
**Sesión:** 29 · **Traspaso:** v29 · **Tramo:** 158–174 (17 entradas) · **Total:** 174
**Hash de documentación (F7):** `f4d7920`
**Estado del push:** por publicar
**Nota horaria:** ejecutado en la madrugada del 2026-08-30; la fecha del cierre
es la del paquete (`fecha_cierre: 2026-08-29`), y el sello del escáner lleva la
fecha real de ejecución.

### Fases

| Fase | Resultado |
|---|---|
| F0 Precondiciones | pasa íntegra en la tercera emisión del paquete (ver Desviaciones) |
| F1 Copia de trabajo | `mktemp -d`, tres destinos |
| F2 Inserciones estructurales | tres resueltas; delta como línea al pie del bloque, según decisión del titular registrada en v28 |
| F3 Rótulos derivados | R3 y R12 disparan (catálogo aplicable completo); 10 fuera de catálogo aplicable |
| F4 Invariantes I1–I7 | siete en verde |
| F5 Compuerta | abre |
| F6 Árbol real | escáner regenerado con poda (2 snapshots), v28 archivado con `git mv`, tres archivos copiados |
| F7 Commit de documentación | `f4d7920`, 8 archivos |
| F8 Distribución | diff vacío en los tres bloques; paquete eliminado |
| F9 Log y commit del log | esta sección |

### F0 — Precondiciones

- Paquete único `paquete_cierre_v29.md`; cuatro delimitadores abren y cierran; cero placeholders.
- Guardia de repo: `raiz_proyecto` = `pwd`.
- Correlativo triple: `v29` = nombre del paquete = máx(v28 vigente; v23–v27 en `archivo/`) + 1.
- Magnitudes contra disco: `backlog_total_previo: 157` = última entrada real del Detalle cronológico; tramo `158→174` = previo+1 → previo+17; bloque con 17 entradas contiguas 158…174, todas con tag de clasificación.
- `settings_version` transcribe la línea 3 real de SETTINGS (`> **Versión 34.**`).
- `compuerta_dudas: 5 registradas` calza con las 5 filas de tres campos (`supuesto`, `predicado`, `medición`) del §11 del traspaso.
- Árbol limpio en traspasos, backlog y ESTADO; tres `??` ajenos al scope (listados en F7).

### F3 — Rótulos

**Catálogo aplicable (de la tabla v28): R3, R12.** Ambos dispararon; sin detención 7.3.

| ID | Rótulo | Disparos | Texto resultante |
|---|---|---:|---|
| R3 | Cobertura "sesiones 1 a N" | 2 | `sesiones 1–28 (traspasos v01–v28)` → `sesiones 1–29 (traspasos v01–v29)`; `deltas s11–s28` → `deltas s11–s29` |
| R12 | Recuento temático: denominador y porcentajes | 2 | tabla de Clasificación temática recalculada sobre 174 (7 filas: UI 59→65, DOC 40→46, REPO 24→27, DT 12→14, P/D/Infra sin cambio de conteo, porcentajes nuevos) y filas Total de Clasificación y Resumen 157→174 |

`catalogo no aplicable: R1, R2, R4, R5, R6, R7, R8, R9, R10, R11 (10 de 12)`.

Tags nuevos contados del propio bloque: DOC 6, UI 6, REPO 3, DT 2 (= 17).
Cuadratura: 157 + 17 = 174 = suma de la tabla temática recalculada.

Recuento temático recalculado:

| Código | Antes | Nuevos | Después | % sobre 174 |
|---|---:|---:|---:|---:|
| P | 14 | 0 | 14 | 8,0% |
| UI | 59 | 6 | 65 | 37,4% |
| D | 2 | 0 | 2 | 1,1% |
| DOC | 40 | 6 | 46 | 26,4% |
| REPO | 24 | 3 | 27 | 15,5% |
| Infra | 6 | 0 | 6 | 3,4% |
| DT | 12 | 2 | 14 | 8,0% |
| **Total** | **157** | **17** | **174** | **100,0%** |

Los porcentajes redondeados a un decimal suman 99,8; la fila Total declara el
porcentaje del total (100,0%), no la suma de redondeos, igual que en v28.

**Cifras sin rótulo** en zonas declarativas: las mismas cuatro de v28
(`2026-06-09`, `sesión 11`, `sesión 20` en la línea de Cobertura; `v09` en la de
Propósito), ya resueltas como (b) cifra histórica legítima de tramo cerrado.
Ninguna nueva; ninguna reaparece sin resolver.

### F4 — Invariantes

| # | Invariante | Resultado |
|---|---|---|
| I1 | Numeración contigua | verde — 1…174 sin huecos ni duplicados, solo sobre el Detalle cronológico |
| I2 | Cuadratura | verde — las 30 filas del resumen suman 174 |
| I3 | Filas del resumen | verde — 29 + 1 = 30 |
| I4 | Sin magnitudes viejas | verde — cero apariciones de `157`, `1–28` o `s11–s28` en zonas declarativas tras F3 |
| I5 | Sin autorreferencias | verde — las entradas no declaran cuántas son; las cifras viven solo en la línea de delta, compuesta por el ejecutor |
| I6 | Gobernanza | verde — cero OneDrive, `Co-Authored-By`, RUT, credenciales y placeholders en los tres archivos; 2 `MRUN` históricos (entradas 111/119), texto sobre un hallazgo, precedente v28 |
| I7 | Traspaso vigente | verde — v28 archivado con `git mv`, exactamente 1 vigente (v29) |

Defecto de instrumento propio, corregido en el mismo turno: la primera medición
de I2/I3 usó un regex que excluía la fila histórica `| — | — | 1 |` del resumen
(dio 173/29); el universo de filas se corrigió y la medición real dio 174/30.
A29-4 aplicado al propio verificador.

### F7 — Commit de documentación

`git add` selectivo de 9 rutas nombradas una a una (traspaso v29, archivado de
v28, backlog, ESTADO y las cuatro salidas del escáner + dos bajas de poda).
Commit `f4d7920`, 8 archivos (+508 −247, cifras informativas del stat).

**Sucios preexistentes ajenos al cierre, no commiteados** (descuento exacto del
predicado de F10):

```
?? 50_documentacion/activa/encargos/encargo_memos_y_rutas_no_ejercidas.md
?? 50_documentacion/andamios/logs/20260829_memos_y_rutas_no_ejercidas_log.md
```

Ambos son artefactos de la propia sesión 29 (su encargo final y su log de
corridas), aún sin versionar: el patrón de la sesión fue versionarlos en el
siguiente commit de despliegue, y el último despliegue ya ocurrió. Decisión de
versionarlos o no: del titular, en la apertura de s30.

### F8 — Distribución

| Bloque | Destino | Resultado |
|---|---|---|
| TRASPASO | `traspasos/traspaso_cierre_v29.md` | idéntico |
| BACKLOG_ENTRADAS | bloque `### Sesión 29` del backlog | idéntico |
| ESTADO | `activa/ESTADO.md` | idéntico |

`rm` del paquete ejecutado: única eliminación sancionada.

### Desviaciones y observaciones

1. **El paquete se emitió tres veces**; el criterio "cero reemisiones por
   defectos de forma" no se cumplió. Las dos detenciones fueron por **autoría
   faltante que la convención vigente del archivo exige**: (1ª) la compuerta de
   dudas venía en prosa sin los campos `supuesto`/`predicado`/`medición` que
   F0.6 verifica y que v28 estableció como tabla; (2ª) las 17 entradas venían
   sin tag `[COD]`, insumo sin el cual R12 (catálogo aplicable) no puede
   recalcular la Clasificación temática — el cierre en seco midió la cascada:
   I4 habría quedado en rojo con dos `157` supervivientes. **Para
   `herramientas_dev`:** ambos son slots que el paquete podría declarar
   obligatorios (la v7→v8 resolvió así la primera omisión de compuerta; los
   tags piden el equivalente en la plantilla del bloque BACKLOG_ENTRADAS).
2. **`commit_cierre` de `ESTADO.md` = `3b17b9b`** (main previo al cierre), no el
   hash del commit del log que la v11 designa como el correspondiente. Misma
   limitación declarada en v28 (desviación 3): el hash del log no existe al
   redactar el paquete. La ascendencia se cumple; contrastar en la apertura de
   s30 contra los dos hashes del eco.
3. **Deriva menor del traspaso respecto del árbol, reportada y no editada:** §1
   declara "Archivos principales modificados" incluyendo `ESTADO.md`, cuyo
   cambio de sesión es obra de este cierre, no de la sesión; y §10 declara
   "Escáner regenerado al cierre", que este cierre materializó con sello del
   2026-08-30. Contenido de autoría; no se tocó.
4. **Columna `Modelo` de la fila 29: `no registrado`** — el paquete no declara
   modelo y BACKLOG_NARRATIVA no tiene ese campo; en línea con v28.
5. **Ejecución en madrugada:** el cierre corrió el 2026-08-30 con
   `fecha_cierre: 2026-08-29`. El bloque de sesión y el delta llevan la fecha
   del paquete; el snapshot del escáner lleva la real. Sin efecto en rótulos
   (R2/R11 no aplican a este archivo).

### Lo que este cierre no verificó

- Que Pages sirva el build vigente (`c9747962…`): el cierre no toca `docs/` ni
  la red; es la duda 1 de la compuerta, con su predicado y su medición.
- Las otras cuatro dudas de la compuerta: registradas, ninguna ejecutada.
- El render de la tabla temática recalculada y del bloque s29 en GitHub.
