# Encargo — Normalizar `backlog_acumulativo.md` a POLITICA §10

> **Destino:** `50_documentacion/activa/encargos/encargo_normalizar_backlog_politica10.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.

---

## 0. Contrato

**Por qué existe.** `POLITICA_PROYECTO.md` §10 fija la estructura interna del
backlog en cinco secciones y en este orden: Objetivo del proyecto, Nota
metodológica, Clasificación temática, Resumen estadístico por sesión, Detalle
cronológico. El archivo de este proyecto lleva 28 sesiones sin tres de ellas, con
la Clasificación temática bajo otro nombre y reducida a leyenda, y con el Detalle
cronológico existiendo como contenido sin sección contenedora. Por eso el
instrumento `/cierre` se detuvo en su fase F2: buscaba encabezados que la norma
exige y el archivo no tiene.

**El instrumento estaba bien. El archivo está fuera de norma.** Este encargo lo
normaliza para que el cierre de la sesión 28 pueda ejecutarse por protocolo.

**ENTORNO.** macOS aarch64, `renv` desincronizado (su aviso en cada `Rscript`
**no** es un fallo). Intérprete de los bloques: `bash`. Rutas absolutas. Raíz:

```
/Users/tomgc/Projects/slep_simce_adecuado
```

**Nota de entorno.** `grep` de BSD: patrones con `{` o `}` exigen `-F`.

**Archivo a modificar, único:**

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/activa/backlog_acumulativo.md
```

---

## 1. Invariante mayor

🔒 **Ninguna entrada del detalle cronológico cambia de texto, de número ni de
orden.** Esta normalización agrega secciones y cambia el nivel de tres
encabezados hacia abajo. No reescribe, no resume, no renumera, no reclasifica.

La verificación de ese invariante es programática y está en la FASE 4. No es
opcional.

Además:

- 🔒 La línea 2 del encabezado (`- **Cobertura:** sesiones 1–26 …`) está stale,
  y **no se toca aquí**: es el rótulo R3 del catálogo del instrumento, y lo
  actualiza `/cierre` en su fase F3. Corregirlo a mano lo sacaría del catálogo y
  volvería a fallar en el cierre siguiente.
- 🔒 La taxonomía **no se modifica**: los siete códigos vigentes se conservan tal
  cual. Ver la nota de §5.
- 🔒 `git status --short` antes de cada `git add`. Nunca `git add .`
- 🔒 No se hace `push`: el cierre lo hará.

---

## 2. Autorizaciones

1. Editar `50_documentacion/activa/backlog_acumulativo.md`.
2. Crear un commit.
3. Escribir y commitear el log de la FASE 6.

Nada más. En particular, **no** ejecutes `/cierre` ni toques el paquete de
cierre, el `ESTADO.md` ni los traspasos.

---

## 3. FASE 0 — Medición

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
git status --short --branch
wc -l 50_documentacion/activa/backlog_acumulativo.md
grep -n '^#\{1,3\} ' 50_documentacion/activa/backlog_acumulativo.md
git log --reverse -1 --format='%ad' --date=format:'%B de %Y'
```

**Estados esperados.** 287 líneas; 1 encabezado `#`, 29 encabezados `##` (uno de
taxonomía más 28 bloques cronológicos), cero `###`. Untracked del paquete de
cierre y de este encargo: se reportan y no detienen.

**Cláusula residual.** Cualquier archivo **versionado** modificado: **DETENTE**.
Si ya existen encabezados `###` o alguna de las tres secciones ausentes, el
encargo ya corrió: **DETENTE**.

Guarda dos valores: el conteo de líneas y la fecha del primer commit.

---

## 4. FASE 1 — Huella de las entradas, antes de tocar nada

Esta huella es el control positivo del invariante mayor. Sin ella, la FASE 4 no
prueba nada.

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
grep -E '^[0-9]+\. ' 50_documentacion/activa/backlog_acumulativo.md > /tmp/backlog_entradas_antes.txt
wc -l /tmp/backlog_entradas_antes.txt
md5 -q /tmp/backlog_entradas_antes.txt
grep -E '^\*\*Delta del backlog' 50_documentacion/activa/backlog_acumulativo.md > /tmp/backlog_deltas_antes.txt
wc -l /tmp/backlog_deltas_antes.txt
md5 -q /tmp/backlog_deltas_antes.txt
```

Esperado: 138 entradas y 17 líneas de delta. Si el conteo de entradas no es 138,
**DETENTE**: la magnitud que el paquete de cierre declara como
`backlog_total_previo` no calza con el disco.

---

## 5. FASE 2 — Derivar lo computable

Calcula, y reporta cada cifra con el comando que la produjo:

**a) Reparto por categoría.** Para cada uno de los siete códigos (`P`, `UI`, `D`,
`DOC`, `REPO`, `Infra`, `DT`), el número de entradas y su porcentaje sobre 138,
con un decimal. Cuenta ambas formas de tag (`[X]` inicial y `[X]` final). La
suma de los siete debe dar 138: si no da, **DETENTE** y reporta el desajuste,
porque significa que hay entradas sin tag o con dos.

**b) Filas del resumen estadístico.** Una fila por bloque cronológico, en el
orden del archivo, con estas columnas: `Sesión`, `Traspaso`, `N° de cambios`,
`Modelo`, `Foco`.

- `Sesión` y `Traspaso` salen del encabezado del bloque.
- `N° de cambios` se **cuenta** de las entradas numeradas del bloque, no se copia
  de la línea de delta. Después se contrasta contra ella: los 17 tramos
  declarados deben coincidir con lo contado. Cualquier discrepancia **DETIENE**.
- `Modelo` solo consta para dos bloques (líneas 134 y 158 del archivo actual).
  Para el resto escribe `no registrado`. **No lo infieras.**
- `Foco` se reduce del título del propio encabezado del bloque, en tres a seis
  palabras.
- El bloque `Entre sesiones 26 y 27` es la fila final separada de refinamientos
  no atribuibles que exige SETTINGS §2.2.5: va como última fila antes del total,
  con `Sesión` = `—`.
- Cierra con una fila `Total` cuyo `N° de cambios` sea la suma, que debe dar
  **138**.

La sesión 28 **no** se agrega aquí: esa fila la inserta `/cierre` en su F2.

**Nota que no se ejecuta, se reporta.** SETTINGS §2.2.5 pide entre 8 y 15
categorías y absorber las que queden bajo el 2%. Hay 7, y `D` ronda el 1,4%.
Ajustar la taxonomía es una decisión del titular con implicancias sobre 138
entradas ya tageadas: **queda anotada en el log, no se toca**.

---

## 6. FASE 3 — Reestructurar

Deja el archivo con este orden. Las secciones nuevas van al nivel `##`.

1. **Encabezado del archivo** (título `#` y las tres viñetas actuales:
   Cobertura, Propósito, Regla de mantenimiento). **Sin cambios.**

2. **`## Objetivo del proyecto`**, con este texto literal, sustituyendo
   `<FECHA_PRIMER_COMMIT>` por el valor medido en la FASE 0:

```
Motor de comparación interactivo de los resultados del Simce por estándares de
aprendizaje (Adecuado, Elemental, Insuficiente). Produce un archivo HTML
autocontenido, publicado por GitHub Pages, que permite contrastar hasta cinco
territorios (comuna, SLEP, región, nacional, grupo personalizado o
establecimiento) en series históricas segmentadas por grupo socioeconómico.

Se construye con un pipeline en R (Arrow, dplyr, `here`) que normaliza los
insumos públicos de la Agencia de Calidad de la Educación y del MINEDUC, y con
una interfaz React 18 y D3 v7 embebida en un único HTML, con los datos
comprimidos en línea.

Lo usa el Área de Monitoreo y Seguimiento del SLEP Costa Central (Viña del Mar,
Concón, Quintero y Puchuncaví), y su publicación es abierta. En desarrollo desde
<FECHA_PRIMER_COMMIT>.
```

3. **`## Nota metodológica`**, con este texto literal:

```
**Qué cuenta como cambio.** Una solicitud distinguible del titular, no las
acciones técnicas que la implementan. Un rediseño de la interfaz pedido en una
sesión es una entrada, aunque haya requerido siete commits y tres archivos.

**Qué no cuenta.** Los errores del asistente corregidos de inmediato dentro del
mismo intercambio. Sí cuentan, en cambio, los bugs que el titular reporta: su
detección es una solicitud distinguible.

**Clasificación.** Por intención primaria, no por los archivos tocados. Una
corrección de terminología en el template del motor es documentación si su
propósito era la consistencia del lenguaje, e interfaz si su propósito era lo que
el usuario ve. Cuando una entrada admite dos códigos, se elige el que responde a
por qué se pidió, no a dónde se escribió (D20-3).

**Fuentes del conteo.** El detalle cronológico de este archivo es la fuente
canónica. Las líneas de delta al pie de cada sesión y las filas del resumen
estadístico se derivan de él, nunca al revés: ante una discrepancia, manda el
detalle.
```

4. **`## Clasificación temática`**, reemplazando el encabezado
   `## Taxonomía vigente` y ampliando su tabla a cuatro columnas:
   `Código`, `Categoría`, `N°`, `%`, `Descripción y ejemplos`. Conserva los siete
   códigos y sus nombres de categoría **literales**. `N°` y `%` salen de la FASE
   2a. Las descripciones son estas, literales:

   - **P — Pipeline R:** scripts de lectura, normalización, agregación y salidas
     intermedias. Ej.: entrada 2 (pipeline completo, 185.378 filas brutas a
     32.134 agregaciones comunales) y entrada 131 (histórico ponderado de %
     Adecuado).
   - **UI — Motor HTML / React / D3:** todo lo que el usuario ve o manipula en el
     motor. Ej.: entrada 3 (motor de comparación como HTML autocontenido) y
     entrada 144 (tope de comparación elevado a cinco territorios).
   - **D — Datos / Insumos:** anomalías del insumo y auditorías del universo de
     datos. Ej.: entrada 4 (cuatro anomalías A1-A4 en datos crudos de la Agencia)
     y entrada 94 (auditoría del universo `depe=4`).
   - **DOC — Documentación:** traspasos, decisiones, glosas, suite documental y
     este backlog. Ej.: entrada 21 (nota metodológica sobre Estándares de
     Aprendizaje) y entrada 146 (criterios de diseño de ramas de detención).
   - **REPO — Gobernanza del repo / Despliegue:** estructura del repositorio,
     versionado, gobernanza de datos y publicación. Ej.: entrada 1 (creación del
     repositorio y scaffold) y entrada 152 (despliegues a GitHub Pages).
   - **Infra — Infraestructura (escáner, orquestador, CI):** herramental que
     sostiene el trabajo sin ser el producto. Ej.: entrada 13 (orquestador
     `00_build.R`) y entrada 20 (escáner con cuatro salidas).
   - **DT — Deuda técnica:** limpieza y refactor sin cambio funcional
     observable. Ej.: entrada 19 (estado sin uso en el tab de comunas) y entrada
     147 (escala tipográfica del SVG a constantes JS con valores preservados).

5. **`## Resumen estadístico por sesión`**, con la tabla de la FASE 2b.

6. **`## Detalle cronológico`**, encabezado nuevo, y **todos los bloques
   cronológicos degradados de `##` a `###`**, conservando su texto íntegro. Este
   punto es el que hace posible la inserción estructural de `/cierre`: con los
   bloques en `##`, el primero de ellos cierra la sección y F2 no puede
   posicionar.

El separador `---` que hoy está en la línea 19 se conserva donde tenga sentido
como cierre del preámbulo; si su posición deja de tenerlo, elimínalo y dilo.

---

## 7. FASE 4 — Verificación del invariante mayor

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
grep -E '^[0-9]+\. ' 50_documentacion/activa/backlog_acumulativo.md > /tmp/backlog_entradas_despues.txt
md5 -q /tmp/backlog_entradas_antes.txt
md5 -q /tmp/backlog_entradas_despues.txt
cmp /tmp/backlog_entradas_antes.txt /tmp/backlog_entradas_despues.txt && echo "ENTRADAS INTACTAS" || echo "ENTRADAS ALTERADAS"
grep -E '^\*\*Delta del backlog' 50_documentacion/activa/backlog_acumulativo.md > /tmp/backlog_deltas_despues.txt
cmp /tmp/backlog_deltas_antes.txt /tmp/backlog_deltas_despues.txt && echo "DELTAS INTACTOS" || echo "DELTAS ALTERADOS"
grep -c '^### Sesión\|^### Entre sesiones' 50_documentacion/activa/backlog_acumulativo.md
grep -c '^## ' 50_documentacion/activa/backlog_acumulativo.md
grep -n '^## ' 50_documentacion/activa/backlog_acumulativo.md
git diff --numstat 50_documentacion/activa/backlog_acumulativo.md
```

| Criterio | Esperado | Si difiere |
|---|---|---|
| `cmp` de entradas | `ENTRADAS INTACTAS`, md5 idénticos | **DETENTE** y no commitees |
| `cmp` de deltas | `DELTAS INTACTOS` | **DETENTE** |
| Bloques en `###` | 28 | **DETENTE** |
| Encabezados `##` | 5, en el orden canónico | **DETENTE** |
| `numstat` | las eliminaciones deben corresponder solo a los 29 encabezados degradados o renombrados | Repórtalo con detalle |

---

## 8. FASE 5 — Commit

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
git status --short
git add 50_documentacion/activa/backlog_acumulativo.md
git status --short
git commit -m "docs(backlog): normaliza la estructura a las cinco secciones de POLITICA 10"
```

---

## 9. FASE 6 — Log

Escribe, y commitea, un log en:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/AAAAMMDD_normalizacion_backlog_log.md
```

con la fecha real del día. Debe contener:

- Salida **literal** de cada verificación, no su resumen.
- La tabla de reparto por categoría, con el comando que produjo cada cifra.
- La tabla del resumen estadístico tal como quedó, y la constatación de que los
  17 tramos declarados coinciden con lo contado.
- Los md5 de la huella de entradas antes y después.
- **Por qué esta normalización fue necesaria:** el fallo de F2 de `/cierre`, las
  tres secciones ausentes y la inversión de diagnóstico que la precedió (se
  atribuyó el fallo al instrumento cuando el archivo era el que estaba fuera de
  norma). La sesión de `herramientas_dev` necesita este caso documentado.
- La nota sobre la taxonomía: 7 categorías frente a las 8-15 que pide SETTINGS
  §2.2.5, y `D` bajo el 2%. Decisión del titular, no ejecutada.
- Lo que quedó sin verificar y por qué.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 50_documentacion/andamios/logs/AAAAMMDD_normalizacion_backlog_log.md 50_documentacion/activa/encargos/encargo_normalizar_backlog_politica10.md
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "docs(log): log de la normalizacion del backlog"
```

---

## 10. Reporte final

1. Salidas literales de FASE 0 y FASE 1, con la fecha del primer commit.
2. La tabla de reparto por categoría.
3. La tabla del resumen estadístico completa.
4. Los cinco encabezados `##` con su número de línea, en orden.
5. La tabla de verificación de la FASE 4 con el valor medido.
6. Los dos hashes.
7. Qué falló o sorprendió. **Si nada, dilo explícitamente.**

No hagas `push` y no ejecutes `/cierre`: eso viene después, con el paquete que ya
está en `andamios/`.
