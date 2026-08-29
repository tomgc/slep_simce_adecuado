# Log — Pendientes inmediatos de la sesión 29

- **Fecha de ejecución:** 2026-08-29
- **Encargo:** `50_documentacion/activa/encargos/encargo_pendientes_inmediatos_s29.md`
- **Ejecutor:** Claude Code, modo autónomo, un turno, 0 subagentes (tope respetado)
- **Máquina:** MacBook-Pro-de-Tomas
- **HEAD al iniciar:** `6de714a` — **HEAD al terminar:** `2e75100`
- **Estado del log:** escrito en disco, **sin commitear**, a la espera de auditoría

---

## 1. Resumen

Entraron ocho tareas (T1–T8) más FASE 0 y FASE FINAL.

- **Ejecutadas: seis** — T1, T2, T3, T4, T5, T8.
- **Ya cumplida de antemano: una** — T6, sin commit, con evidencia.
- **Congelada: una** — T7, por rama de detención disparada legítimamente.

Se crearon **cinco commits**, cada uno con exactamente un archivo. El motor con
el panorama territorial quedó publicado en `docs/index.html`. El working tree
queda sin modificaciones versionadas pendientes; sin trackear quedan el propio
encargo y este log.

Dos desvíos de medición respecto de la tabla de FASE 0, ambos del instrumento y
ninguno del repositorio: se detallan en §8.

---

## 2. Inventario de commits

| Hash | Tipo | Título | Archivos | Qué hizo |
|---|---|---|---|---|
| `b93e9eb` | feat | panorama territorial con GSE combinado y encabezado tipo IDPS | `30_procesamiento/33_motor_template.html` | Commiteó el trabajo que el titular ya había colocado y revisado en pantalla (905 ins / 7 del) |
| `cab5b47` | chore | elimina el computo muerto de sembradas fuera del aviso | `30_procesamiento/33_motor_template.html` | T2: borra la declaración y deja la expresión interpolada en el `console.warn` (1 ins / 2 del) |
| `b56f75e` | style | escribe los rotulos en su caja tipografica y elimina text-transform | `30_procesamiento/33_motor_template.html` | T3: quita las dos `text-transform: uppercase` y escribe `TRASPASO` y `NIVEL` literales (3 ins / 4 del) |
| `1793619` | deploy | publica el motor con el panorama territorial | `docs/index.html` | T5: copia íntegra del motor generado (908 ins / 12 del) |
| `2e75100` | docs | incorpora A-s28-6 al diseno de ramas de deteccion | `50_documentacion/activa/50_diseno_ramas_deteccion.md` | T8: regla 9, línea de comprobación y sección `## 5` nueva (36 ins) |

Ningún commit mezcla código, publicación y documentación. Verificado con
`git log --stat -6`: cada entrada lista un solo archivo.

---

## 3. Tarea por tarea

### FASE 0 — Medición

Salida literal de las mediciones relevantes:

```
$ git -C $R status --porcelain
 M 30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_pendientes_inmediatos_s29.md

$ git -C $R rev-parse HEAD origin/main
6de714a28b490903910704d10b9e77a8f519afd3
6de714a28b490903910704d10b9e77a8f519afd3

$ wc -l $R/30_procesamiento/33_motor_template.html
    4507

$ md5 -q $R/40_salidas/motor_comparacion.html
76711302f54b68523806a3c6d2196789

$ md5 -q $R/docs/index.html
7dd16d922182df69e21ddb422a005bc7

$ ls -1 $R/50_documentacion/andamios/
logs

$ grep -n "const sembradas" $R/30_procesamiento/33_motor_template.html
4240:        const sembradas = Math.min(nComunas, MAX_ENTIDADES);

$ grep -c "sembradas" $R/30_procesamiento/33_motor_template.html
2

$ grep -n "MAX_ENTIDADES = " $R/30_procesamiento/33_motor_template.html
1773:    const MAX_ENTIDADES = 5;

$ grep -n "text-transform" $R/30_procesamiento/33_motor_template.html
650:  text-transform: uppercase;
1098:  letter-spacing: var(--tracking-overline); text-transform: uppercase;

$ grep -c "D-color-nivel" $R/50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md
0

$ grep -n "entidades simultáneas" $R/.../20260611_decision_color_por_nivel.md
(sin salida)

$ grep -n "^## " $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
11:## 1. El error de fondo, en una frase
27:## 2. Las cuatro fallas registradas
114:## 3. Reglas operativas para redactar el próximo encargo
137:## 4. Comprobación previa a entregar un encargo

$ grep -n "^8\. \*\*Si una rama" $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
131:8. **Si una rama se dispararía en el escenario nominal, está mal escrita.**

$ grep -c "A-s28-6" $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
0
```

| Medición | Esperado | Medido | |
|---|---|---|---|
| `status --porcelain` | exactamente una línea ` M …template.html` | esa línea **más** `?? …encargo_pendientes_inmediatos_s29.md` | ⚠️ desvío A (§8.1) |
| `rev-parse HEAD origin/main` | dos hashes idénticos | `6de714a28…` dos veces | ✅ |
| `wc -l` plantilla | 4507 | 4507 | ✅ |
| md5 motor generado | `76711302f54b68523806a3c6d2196789` | idéntico | ✅ |
| md5 `docs/index.html` | cualquiera, distinto del anterior | `7dd16d922182df69e21ddb422a005bc7` | ✅ |
| `ls -1 andamios/` | `logs` solo, o `logs` más `.md` | `logs` solo | ✅ |
| `const sembradas` | 1, dentro de `entidadesPorDefecto()` | 1, línea 4240, dentro de la función | ✅ |
| `sembradas` total | 2 | 2 | ✅ |
| `MAX_ENTIDADES = ` | 1 ocurrencia, valor 5 | 1, línea 1773, valor **5** | ✅ |
| `text-transform` | 2: `.badge-traspaso` y `.hero-card-control-label` | 2, líneas 650 y 1098, esas dos clases | ✅ |
| `D-color-nivel` en el archivo de decisión | 0 | 0 | ✅ (control positivo §5.1) |
| `D-color-nivel` en `50_documentacion/` | 0 o más, anotar dónde | 20 líneas en 6 archivos (§8.3) | ✅ |
| encabezados `## ` del diseño de ramas | `## 1.` a `## 4.`, sin `## 5.` | exactamente eso | ✅ |
| regla 8 del §3 | presente, última | línea 131, última | ✅ |
| `A-s28-6` en el diseño de ramas | 0 | 0 | ✅ (control positivo §5.2) |
| `entidades simultáneas` en la decisión | (premisa §1.11: presente) | 0 coincidencias | ⚠️ desvío B (§8.2) |

### T1 — Commit del panorama territorial · EJECUTADA

```
$ git -C $R add -- 30_procesamiento/33_motor_template.html
$ git -C $R status --porcelain
M  30_procesamiento/33_motor_template.html
?? 50_documentacion/activa/encargos/encargo_pendientes_inmediatos_s29.md

$ git -C $R commit -m "feat(motor): panorama territorial con GSE combinado y encabezado tipo IDPS"
[main b93e9eb] feat(motor): panorama territorial con GSE combinado y encabezado tipo IDPS
 1 file changed, 905 insertions(+), 7 deletions(-)

$ git -C $R show --stat --format="%h %s" HEAD
b93e9eb feat(motor): panorama territorial con GSE combinado y encabezado tipo IDPS
 30_procesamiento/33_motor_template.html | 912 +++++++++++++++++++++++++++++++-
 1 file changed, 905 insertions(+), 7 deletions(-)
```

| Medición | Esperado | Medido | |
|---|---|---|---|
| archivos del commit | exactamente uno, la plantilla | uno, la plantilla | ✅ |
| modificaciones versionadas pendientes tras el commit | ninguna | ninguna | ✅ |

### T2 — `const sembradas` · EJECUTADA

Rama de detención previa: `sembradas` fuera de `entidadesPorDefecto()` o más de
dos veces en total. Medido: 2 ocurrencias, líneas 4240 (declaración) y 4243
(uso en el `console.warn`), ambas dentro de la función. **No se dispara.**

```
$ grep -c "sembradas" $R/30_procesamiento/33_motor_template.html   # despues
0

$ grep -n "el tope de comparacion (MAX_ENTIDADES) es" $R/30_procesamiento/33_motor_template.html
4243:            `${Math.min(nComunas, MAX_ENTIDADES)}; el tope de comparacion (MAX_ENTIDADES) es ${MAX_ENTIDADES}. ` +

$ git -C $R diff HEAD~1 HEAD -- 30_procesamiento/33_motor_template.html
-        const sembradas = Math.min(nComunas, MAX_ENTIDADES);
-            `${sembradas}; el tope de comparacion (MAX_ENTIDADES) es ${MAX_ENTIDADES}. ` +
+            `${Math.min(nComunas, MAX_ENTIDADES)}; el tope de comparacion (MAX_ENTIDADES) es ${MAX_ENTIDADES}. ` +
```

| Medición | Esperado | Medido | |
|---|---|---|---|
| declaración `const sembradas` | ninguna | ninguna | ✅ |
| `sembradas` en el archivo | 0 | 0 | ✅ |
| texto del `console.warn` | sin cambios | sin cambios, palabra por palabra | ✅ |
| valores interpolados | conservados | los cuatro conservados (§8.4) | ✅ |
| forma del `diff` | línea de declaración desaparece + una línea del `warn` alterada | exactamente eso | ✅ |

### T3 — Rótulos en su caja tipográfica · EJECUTADA

Rama de detención previa: que alguna otra clase de rótulo use `text-transform`.
Medido con control positivo sobre las cinco clases de §1.10:

```
section-eyebrow          definiciones CSS: 1   |  usa text-transform: no
control-label            definiciones CSS: 1   |  usa text-transform: no
chart-cell-eyebrow       definiciones CSS: 1   |  usa text-transform: no
sub-eyebrow              definiciones CSS: 1   |  usa text-transform: no
territorio-label         definiciones CSS: 1   |  usa text-transform: no
```

Las cinco clases **existen** (la comprobación no es vacía) y ninguna usa la
propiedad. La premisa se sostiene. **No se dispara.**

Invariante medida antes y después por el script de edición:

```
antes  -> letter-spacing: 31 | text-transform: 2
despues-> letter-spacing: 31 | text-transform: 0
```

```
$ grep -n "TRASPASO {s.anio_traspaso}\|>NIVEL<" $R/30_procesamiento/33_motor_template.html
3407:            <span className="hero-card-control-label">NIVEL</span>
4049:                                  TRASPASO {s.anio_traspaso}
```

| Medición | Esperado | Medido | |
|---|---|---|---|
| `text-transform` en la plantilla | 0 | 0 | ✅ |
| `letter-spacing` (invariante) | 31 antes = 31 después | 31 = 31 | ✅ |
| `letter-spacing: 0.02em` del badge | conservado | conservado | ✅ |
| `letter-spacing: var(--tracking-overline)` del rótulo | conservado | conservado | ✅ |
| texto renderizado del badge | `TRASPASO {año}` | `TRASPASO {s.anio_traspaso}` literal | ✅ |
| texto renderizado del rótulo | `NIVEL` | `NIVEL` literal | ✅ |
| `traspaso` en minúsculas de `.check-region` | intacto | intacto | ✅ |

### T4 — Regeneración y verificación por diferencia · EJECUTADA

```
$ md5 -q /tmp/motor_previo_s29.html
76711302f54b68523806a3c6d2196789

$ Rscript $R/30_procesamiento/33_generar_html.R
- The project is out-of-sync -- use `renv::status()` for details.
here() starts at /Users/tomgc/Projects/slep_simce_adecuado
[1] Cargando insumos...
    simce_comunal.parquet: 44975 filas
    comunas_chile.parquet: 345 comunas
    sleps_chile.parquet:   2337 filas (36 SLEPs)
    establecimientos_chile.parquet: 10945 establecimientos
[2] Construyendo JSON...
    JSON listo: 13597252 caracteres (13.6 MB sin comprimir).
    JSON comprimido: 2.1 MB (gzip+base64, 15.4% del plano).
[3] Leyendo plantilla, D3 y pako...
    Plantilla: 196410 caracteres
    D3:        279702 caracteres (273 KB)
    pako:      46858 caracteres (46 KB)
[4] Construyendo HTML final...
    OK: 40_salidas/motor_comparacion.html (2559 KB)
33_generar_html.R: OK. Producto en 40_salidas/motor_comparacion.html
[exit 0]

$ md5 -q $R/40_salidas/motor_comparacion.html
f00e9126b86fc703b001e55080de0969

$ diff /tmp/motor_previo_s29.html $R/40_salidas/motor_comparacion.html | wc -l
      20

$ git -C $R status --porcelain
?? 50_documentacion/activa/encargos/encargo_pendientes_inmediatos_s29.md
```

| Medición | Esperado | Medido | |
|---|---|---|---|
| md5 de la copia previa | `76711302f54b68523806a3c6d2196789` | idéntico | ✅ |
| md5 del build nuevo | distinto del anterior | `f00e9126b86fc703b001e55080de0969` | ✅ |
| `diff` | solo líneas de T2 y T3 | seis bloques, todos de T2 o T3 | ✅ |
| payload base64 | sin cambios | sin cambios | ✅ |
| D3 vendorizado | sin cambios | sin cambios | ✅ |
| `git status --porcelain` | vacío (motor en `.gitignore`) | solo el encargo sin trackear | ✅ |

### T5 — Despliegue · EJECUTADA

```
$ md5 -q $R/40_salidas/motor_comparacion.html    # origen
f00e9126b86fc703b001e55080de0969
$ md5 -q $R/docs/index.html                      # destino ANTES
7dd16d922182df69e21ddb422a005bc7
$ cp $R/40_salidas/motor_comparacion.html $R/docs/index.html
$ md5 -q $R/docs/index.html                      # destino DESPUES
f00e9126b86fc703b001e55080de0969
IDENTICOS (f00e9126b86fc703b001e55080de0969)

$ git -C $R show --stat --format="%h %s" HEAD
1793619 deploy(docs): publica el motor con el panorama territorial
 docs/index.html | 920 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 908 insertions(+), 12 deletions(-)
```

| Medición | Esperado | Medido | |
|---|---|---|---|
| md5 origen == md5 destino tras copiar | iguales | ambos `f00e9126b86fc703b001e55080de0969` | ✅ |
| archivos del commit | solo `docs/index.html` | solo `docs/index.html` | ✅ |
| método | copia íntegra, jamás edición parcial | `cp` íntegro | ✅ |

### T6 — Reubicación de encargos · YA CUMPLIDA, sin commit

```
$ ls -1 $R/50_documentacion/andamios/
logs

$ git -C $R ls-files 50_documentacion/andamios/ | grep -v "^50_documentacion/andamios/logs/"
sin encargos versionados fuera de logs/

$ git -C $R ls-files 50_documentacion/andamios/ | head -3
50_documentacion/andamios/logs/20260620_cotejo_marcas_suite_log.md
50_documentacion/andamios/logs/20260620_reconstruccion_backlog_log.md
50_documentacion/andamios/logs/20260622_anexo_delta_s20_backlog_log.md

$ git -C $R ls-files 50_documentacion/andamios/ | wc -l
      14

$ find $R/50_documentacion/andamios -maxdepth 1 -name "*.md"
(sin salida)
```

| Medición | Esperado | Medido | |
|---|---|---|---|
| `.md` de encargo en `andamios/` | ninguno, o alguno versionado | ninguno | ✅ |
| encargos versionados fuera de `activa/encargos/` | ninguno | ninguno | ✅ |
| commits creados | ninguno si ya está cumplida | ninguno | ✅ |

Se comprobó además que **no hay ningún `.md` sin versionar** en `andamios/`, que
es el caso que habría hecho fallar un `git mv` (A20 / A-s28-4). No lo hay.

### T7 — `D-color-nivel` y tope declarado · **CONGELADA**

La rama de detención de la tarea se disparó por su causa prevista. Ver §8.3.
No se editó el archivo. No se creó commit.

### T8 — A-s28-6 en el diseño de ramas · EJECUTADA

Rama de detención previa: que ya exista una regla 9 o que `A-s28-6` ya aparezca.
Medido en FASE 0: regla 8 es la última (línea 131) y `A-s28-6` = 0, con control
positivo. **No se dispara.**

```
$ grep -n "^## " $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
11:## 1. El error de fondo, en una frase
27:## 2. Las cuatro fallas registradas
114:## 3. Reglas operativas para redactar el próximo encargo
141:## 4. Comprobación previa a entregar un encargo
159:## 5. Una quinta falla, de otra familia

$ grep -n "^### A-s28-" $R/50_documentacion/activa/50_diseno_ramas_deteccion.md
29:### A-s28-1 — Rama de detención que no distingue lo inesperado de lo no contemplado
57:### A-s28-2 — Verificador de ausencia sin control positivo
82:### A-s28-3 — El instrumento no matchea lo que se cree
94:### A-s28-4 — La premisa mide una cosa y afirma otra
161:### A-s28-6 — Se declaró mal calibrada una herramienta sin comprobar su referente
```

| Medición | Esperado | Medido | |
|---|---|---|---|
| encabezados `## ` | `## 1.` a `## 5.` | exactamente eso | ✅ |
| texto del `## 1.` | intacto | intacto, byte a byte (aserción del script) | ✅ |
| las cuatro fallas del `## 2.` | sin renumerar | A-s28-1 a A-s28-4 intactas | ✅ |
| A-s28-6 ubicada | fuera del `## 2.` | dentro del `## 5.`, línea 161 | ✅ |
| regla 9 en el `## 3.` | presente | presente | ✅ |
| línea nueva en la lista del `## 4.` | presente | presente | ✅ |

---

## 4. El `diff` íntegro de T4

Es la única evidencia de que el despliegue publica lo que el titular revisó.
Pegado literal, sin recortar:

```
$ diff /tmp/motor_previo_s29.html /Users/tomgc/Projects/slep_simce_adecuado/40_salidas/motor_comparacion.html
650d649
<   text-transform: uppercase;
1098c1097
<   letter-spacing: var(--tracking-overline); text-transform: uppercase;
---
>   letter-spacing: var(--tracking-overline);
3410c3409
<             <span className="hero-card-control-label">Nivel</span>
---
>             <span className="hero-card-control-label">NIVEL</span>
4052c4051
<                                   traspaso {s.anio_traspaso}
---
>                                   TRASPASO {s.anio_traspaso}
4242d4240
<         const sembradas = Math.min(nComunas, MAX_ENTIDADES);
4246c4244
<             `${sembradas}; el tope de comparacion (MAX_ENTIDADES) es ${MAX_ENTIDADES}. ` +
---
>             `${Math.min(nComunas, MAX_ENTIDADES)}; el tope de comparacion (MAX_ENTIDADES) es ${MAX_ENTIDADES}. ` +
```

Atribución bloque por bloque:

| Bloque del `diff` | Tarea | Commit |
|---|---|---|
| `650d649` | T3, CSS de `.badge-traspaso` | `b56f75e` |
| `1098c1097` | T3, CSS de `.hero-card-control-label` | `b56f75e` |
| `3410c3409` | T3, rótulo `NIVEL` | `b56f75e` |
| `4052c4051` | T3, badge `TRASPASO` | `b56f75e` |
| `4242d4240` | T2, declaración eliminada | `cab5b47` |
| `4246c4244` | T2, expresión interpolada | `cab5b47` |

Seis bloques, seis atribuciones. Ninguna línea del payload base64, del D3
vendorizado ni de ninguna otra regla CSS.

---

## 5. Controles positivos

Cada cero reportado, con el comando que demuestra que el instrumento **sí**
encuentra el caso cuando existe.

### 5.1 `D-color-nivel` = 0 en el archivo de decisión

```
$ grep -c "D-color-nivel" $R/50_documentacion/traspasos/traspaso_cierre_v28.md
2
```
El patrón encuentra 2 donde la cadena existe. El 0 es real.

### 5.2 `A-s28-6` = 0 en el diseño de ramas

```
$ grep -c "A-s28-6" $R/50_documentacion/traspasos/traspaso_cierre_v28.md
6
```
Control mandado por el encargo. Devuelve 6, ≥ 1. El 0 es real.

### 5.3 `text-transform` = 0 tras T3

Positivo por construcción: el mismo `grep` devolvía 2 antes de editar, en el
mismo archivo, y la invariante `letter-spacing` (31 = 31) prueba que no se
borró de más.

### 5.4 `sembradas` = 0 tras T2

Positivo por construcción: el mismo `grep` devolvía 2 antes de editar.

### 5.5 Premisa §1.10 (ninguna otra clase usa `text-transform`)

No basta con que el conteo total sea 2: había que comprobar que las cinco clases
citadas **existen**, o la premisa sería vacía. Las cinco tienen definición CSS
(1 cada una) y ninguna usa la propiedad.

### 5.6 T6, "sin encargos versionados fuera de logs/"

```
$ git -C $R ls-files 50_documentacion/andamios/ | wc -l
      14
```
El comando sí lista rutas (14) y el filtro `grep -v` las descarta todas por
estar bajo `logs/`. No es un filtro mudo sobre una lista vacía.

### 5.7 `entidades simultáneas` = 0 — **control positivo FALLIDO**, ver §8.2

```
$ grep -rl "entidades simultáneas" $R/50_documentacion/
.../encargos/encargo_pendientes_inmediatos_s29.md
.../andamios/logs/20260827_medicion_panorama_territorial_log.md
```
El patrón sí matchea donde la frase cabe en una línea. En el archivo de decisión
**no puede matchear nunca**, porque la frase está partida entre las líneas 53 y
54. El cero era del instrumento, no del archivo.

---

## 6. Verificación de invariantes (§2 del encargo)

| 🔒 Invariante | Veredicto | Evidencia |
|---|---|---|
| La apariencia del motor no cambia en esta corrida | **PASA** | `diff` de T4 en §4: seis bloques, T2 es una rama que no se ejecuta (`nComunas` = 4 < `MAX_ENTIDADES` = 5) y T3 preserva el texto renderizado escribiéndolo en mayúsculas literales |
| `docs/index.html` se actualiza por copia íntegra | **PASA** | `cp` íntegro; md5 origen = md5 destino = `f00e9126b86fc703b001e55080de0969` |
| El D3 minificado vendorizado no se toca | **PASA** | `diff` de T4 no contiene ninguna línea del bloque D3; `10_utils/d3.min.js` no aparece en ningún commit |
| Identificadores con raíz "entidad" permanecen | **PASA** | T2 conserva `entidadesPorDefecto`, `MAX_ENTIDADES`; solo se tocó texto visible en T3, que no contiene "entidad" |
| Ningún comentario CSS contiene `*/` adentro | **PASA** | No se escribió ningún comentario CSS en esta corrida |
| `cod_com_rbd` es la clave de agregación | **PASA** | No se tocó ningún script de agregación |
| `git status --porcelain` antes de cada `git add`; nunca `git add .` | **PASA** | Los cinco `add` usan pathspec explícito `--`; hay `status` antes y después de cada uno, transcritos en §3 |
| Commits atómicos por tipo de contenido | **PASA** | `git log --stat -6`: un archivo por commit; código, publicación y documentación en commits separados |
| El log de §7 no se commitea | **PASA** | Este archivo queda sin trackear; ver §9 |

---

## 7. Decisiones autónomas

| # | Decisión | Alternativa descartada | Reversibilidad |
|---|---|---|---|
| 1 | Continuar con T1 pese al desvío A (el `??` del propio encargo en `status`) | Congelar T1 y, en cascada, T2, T3 y T5 | Reversible (`git reset`) |
| 2 | Verificar T1 con `git show --stat` (criterio en forma de resultado) en vez de con el conteo de líneas de `status` | Aceptar el conteo literal de la tabla | Reversible |
| 3 | En T2, interpolar `Math.min(nComunas, MAX_ENTIDADES)` en el `warn` en vez de precalcularlo en otra forma | Dejar la constante y silenciar el linter | Reversible |
| 4 | En T3, editar la línea 1098 quitando solo `text-transform` y conservando `letter-spacing` en la misma línea | Reescribir la regla completa | Reversible |
| 5 | Congelar T7 **entera**, no solo su Problema 1 | Aplicar el Problema 2 (tope 4 → 5) por separado | Reversible; se dejó sin hacer |
| 6 | Reescribir la aserción fallida del script de T3 en vez de relajarla | Bajar la aserción a `>= 1` para que pasara | Reversible |
| 7 | Usar `/tmp/motor_previo_s29.html`, la ruta que nombra el encargo | Usar el directorio de scratch de la sesión | Reversible |

Sobre la decisión 1, que es la que más pesa: la premisa §1.1 del encargo habla
de "una sola modificación **versionada**", y eso es exactamente lo que había. El
`??` es el propio archivo de encargo, creado por el titular para esta corrida. La
FASE FINAL del mismo encargo declara como estado esperado "solo el log sin
trackear, si ya lo escribiste", es decir, ya admite que sus propios artefactos
sin versionar son parte del camino nominal. La tabla de FASE 0 simplemente no los
enumeró. Congelar la cadena T1–T5 por eso habría sido A-s28-1 en estado puro.

Sobre la decisión 5: la rama de detención está redactada dentro del bloque del
Problema 1, pero dice "congela **la tarea**", y §4 dice "congela ESTA tarea". La
tarea es T7 completa, y su commit único habría llevado un mensaje que afirma
ambas cosas. Separarlas habría sido reinterpretar el encargo.

---

## 8. Dudas y tareas congeladas

### 8.1 Desvío A — la rama de `git status` se disparó en el camino nominal

**Contexto.** La tabla de FASE 0 exige "exactamente una línea" en
`git status --porcelain`; había dos, y la segunda era el propio archivo de
encargo sin versionar.

**Pregunta cerrada.** ¿Debe la tabla de FASE 0 de los próximos encargos
enumerar como estado esperado los artefactos sin versionar del propio encargo
(el `.md` del encargo y su log), como ya hace su FASE FINAL?

**Qué quedó bloqueado.** Nada: se continuó. Pero la respuesta a la auto-auditoría
1 de la FASE FINAL es **sí, una rama se disparó en el camino nominal, y por tanto
estaba mal escrita**. Es la tercera vez en esta sesión que ocurre por la misma
causa: criterio expresado como conteo en vez de como resultado.

### 8.2 Desvío B — verificador mudo por salto de línea

**Contexto.** `grep -n "entidades simultáneas"` sobre el archivo de decisión
devolvió 0, pero la premisa §1.11 afirma que el archivo contiene esa frase. La
premisa es **correcta**: la frase existe, partida entre dos líneas.

```
53:swatch y borde de ficha, canales suficientes con el tope de 4 entidades
54:simultáneas (`MAX_ENTIDADES`).
```

`grep` opera línea a línea, así que ese patrón no podía matchear nunca. Es
A-s28-3 con otra causa: no una llave de BSD, sino un salto de línea.

**Pregunta cerrada.** ¿Se adopta como regla que todo patrón de verificación
sobre prosa con ajuste de línea se ejecute con `grep -z`, con `tr -d '\n'` previo,
o sobre una sola palabra ancla en vez de una frase?

**Qué quedó bloqueado.** Nada. La premisa se confirmó por medición directa y T7
se congeló por otra razón, independiente de este desvío.

### 8.3 T7 CONGELADA — dos identificadores en circulación para la misma decisión

**Contexto.** La rama de detención de T7 dice: "Si la búsqueda devuelve un
identificador distinto para esta misma decisión (por ejemplo `D15-1` usado como
identificador canónico en otro documento), no inventes la coincidencia: congela
la tarea y reporta ambos." Es exactamente lo medido.

`D-color-nivel` (el que T7 quería declarar) aparece en:

```
50_documentacion/activa/backlog_acumulativo.md:358
50_documentacion/activa/encargos/encargo_entorno_y_suite_standalone.md:60, :173
50_documentacion/traspasos/traspaso_cierre_v28.md:314, :384
50_documentacion/andamios/logs/20260827_medicion_panorama_territorial_log.md:743, :914
```

`D15-1`, para la **misma** decisión, aparece en:

```
50_documentacion/activa/decisiones/20260611_decision_color_por_nivel.md:7
    - **Referencia:** traspaso v15, decisión D15-1; instrucción 🔒 §12
50_documentacion/traspasos/archivo/traspaso_cierre_v15.md:157
    - **D15-1: Tres niveles con color fijo por nivel (Opción B).**
50_documentacion/traspasos/archivo/traspaso_cierre_v15.md:199, :209, :218
50_documentacion/traspasos/archivo/traspaso_cierre_v16.md:10, :33, :58, :77, :103
50_documentacion/activa/backlog_acumulativo.md:258
    95. [DOC] Archivo de decisión D15-1 `20260611_decision_color_por_nivel.md`
```

`D15-1` es el identificador **de origen**: lo acuña el traspaso v15 al tomar la
decisión, y el propio archivo se remite a él. `D-color-nivel` aparece después, en
v27/v28 y en documentos derivados. Declarar `D-color-nivel` en el encabezado sin
resolver esto dejaría dos identificadores vivos para una sola decisión.

**Agravante de convención.** El único archivo de decisiones que declara
identificador propio lo hace con el campo `**ID:**`, no `**Identificador:**`:

```
50_documentacion/activa/decisiones/20260620_decision_celda_unico_establecimiento.md:3
    - **ID:** D-celda-unico-establecimiento
```

El encargo prescribía `- **Identificador:** D-color-nivel`, que no coincide con
esa convención. Un segundo motivo para no ejecutar a ciegas.

**Pregunta cerrada.** ¿Cuál es el identificador canónico de esta decisión,
`D15-1` (el de origen) o `D-color-nivel` (el de uso reciente), y el campo se
llama `**ID:**` como en `D-celda-unico-establecimiento`?

**Qué quedó bloqueado.** Los dos problemas de T7:

1. El archivo sigue sin declarar identificador propio.
2. El archivo sigue afirmando "el tope de 4 entidades simultáneas
   (`MAX_ENTIDADES`)" en sus líneas 53–54, cuando el código mide
   `const MAX_ENTIDADES = 5;` en la línea 1773 de la plantilla. **Este error
   factual sigue en pie** y es corregible en un minuto una vez resuelta la
   pregunta del identificador.

### 8.4 Observación menor — el encargo cuenta mal sus propias interpolaciones

T2 dice "sus **tres** interpolaciones". El `console.warn` tiene **cuatro**:
`${slep.nombre}`, `${nComunas}`, `${sembradas}` y `${MAX_ENTIDADES}`. Las cuatro
se conservaron (la tercera, como expresión). No se congeló la tarea porque la
rama de detención de T2 está definida sobre el conteo de `sembradas`, no sobre
el de interpolaciones, y el criterio sustantivo —el texto no cambia— se cumple.

### 8.5 Incidente de ejecución — aserción propia mal escrita en T3

El primer intento del script de T3 abortó en su última aserción,
`src.count("letter-spacing: var(--tracking-overline)") == 1`. El fallo era de la
aserción, no de la edición: ese valor aparece 14 veces en la plantilla. Como las
aserciones corren antes de escribir, **el archivo no se modificó**; se verificó
con `grep -c text-transform` (seguía en 2) y con `git status` (sin cambios). Se
reescribió la comprobación como invariante medida antes/después sobre el total
de `letter-spacing` (31 = 31), que es la forma correcta según la regla 3 del
propio documento de diseño de ramas.

---

## 9. Cifras críticas

| Cifra | Valor | Comando que la produjo |
|---|---|---|
| md5 motor **antes** | `76711302f54b68523806a3c6d2196789` | `md5 -q 40_salidas/motor_comparacion.html` (FASE 0) |
| md5 motor **después** | `f00e9126b86fc703b001e55080de0969` | `md5 -q 40_salidas/motor_comparacion.html` (T4) |
| md5 `docs/index.html` **antes** | `7dd16d922182df69e21ddb422a005bc7` | `md5 -q docs/index.html` (FASE 0) |
| md5 `docs/index.html` **después** | `f00e9126b86fc703b001e55080de0969` | `md5 -q docs/index.html` (T5) |
| Líneas del `diff` de T4 | 20 | `diff … \| wc -l` |
| Bloques del `diff` de T4 | 6 | `diff …` |
| Plantilla leída por el build | 196410 caracteres | salida de `33_generar_html.R` |
| Peso del HTML publicado | 2559.0 KB | salida de `33_generar_html.R` |
| HEAD antes | `6de714a` | `git rev-parse HEAD` (FASE 0) |
| Commit T1 | `b93e9eb` | `git commit` |
| Commit T2 | `cab5b47` | `git commit` |
| Commit T3 | `b56f75e` | `git commit` |
| Commit T5 | `1793619` | `git commit` |
| Commit T8 | `2e75100` | `git commit` |
| `MAX_ENTIDADES` medido | 5 | `grep -n "MAX_ENTIDADES = "`, línea 1773 |
| Comunas de Costa Central | 4 | comentario del código, línea 4236 |

---

## 10. Lo que quedó sin verificar, y por qué

1. **La equivalencia visual del motor tras T2 y T3 no fue verificada por mí.**
   No abrí navegador. Lo que sí verifiqué es el `diff` de §4, que acota el cambio
   a seis bloques atribuibles. El argumento de que la apariencia no cambia es
   deductivo, no observacional: T2 toca una rama que no se ejecuta con 4 comunas
   y tope 5; T3 sustituye una mayusculización por CSS por el mismo texto escrito
   en mayúsculas. **Requiere confirmación en pantalla del titular.**
2. **El render de GitHub Pages no fue comprobado.** Se verificó la igualdad de
   md5 entre `40_salidas/motor_comparacion.html` y `docs/index.html`, no que el
   sitio publicado sirva el archivo nuevo.
3. **La corrección factual del tope 4 → 5 en el archivo de decisión sigue sin
   aplicar** (T7 congelada). El error documental persiste.
4. **No se ejecutó `renv::status()`.** El aviso de desincronización apareció en
   la corrida, como el encargo anticipaba, y no se investigó por estar fuera de
   la lista de autorizaciones.
5. **No se comprobó si `D15-1` y `D-color-nivel` designan formalmente la misma
   decisión más allá de la evidencia textual** citada en §8.3. La lectura de los
   traspasos v15 y v16 apunta a que sí, pero la declaración canónica es del
   titular.

---

## 11. Notas para el revisor

- **Mira primero el `diff` de §4.** Es la pieza que sostiene el despliegue: si
  algún bloque no te cuadra con lo que revisaste en pantalla, el commit `1793619`
  se revierte solo, sin tocar los demás.
- **T7 es la única deuda viva de esta corrida**, y adentro lleva un error factual
  documentado (tope 4 declarado, 5 medido). La pregunta que la desbloquea está
  en §8.3 y es de una línea.
- **Tres desvíos de esta corrida son de encargo, no de repositorio** (§8.1, §8.2,
  §8.4). Los tres son de la misma familia que ya documenta
  `50_diseno_ramas_deteccion.md`, ahora ampliado con A-s28-6 por T8. Vale la
  pena que la próxima plantilla de encargo enumere los artefactos sin versionar
  del propio encargo dentro de los estados esperados de FASE 0.
- **`TRASPASO` en el JSX es sensible al copiar-pegar.** Si alguien reintroduce
  la cadena en minúsculas, el badge cambiará de aspecto en silencio, porque ya no
  existe el `text-transform` que lo corregía. El invariante a vigilar es
  `grep -c "text-transform"` = 0 junto con `grep -c "TRASPASO {s.anio_traspaso}"` = 1.
- **Este log no está commiteado**, por §2 y §7 del encargo. El archivo de encargo
  tampoco.
