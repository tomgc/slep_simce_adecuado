# Constancia — Guarda de locale UTF-8

**Fecha:** 2026-08-27
**Encargo que la origina:** `50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md`
**Log de la ejecución:** `50_documentacion/andamios/logs/20260827_ordenacion_repositorio_log.md`

Constancia de qué existe hoy en este repositorio respecto de la guarda
`asegurar_locale_utf8`. Registra lo medido, no lo supuesto. Las secciones 1 a 4
son el estado del 2026-08-27, sin guarda; la sección 5 registra su instalación
en la sesión 34 (2026-09-24).

---

## 1. Qué se verificó, cuándo y con qué comando

Verificación del 2026-08-27, sobre el árbol de trabajo en `main`.

### La comprobación de locale UTF-8 **sí existe**

**Archivo:** `10_utils/10_validar_portabilidad.R`
**Función contenedora:** `.vp_validar_entorno(raiz)`
**Identificador del check:** `locale_utf8`

Comando:

```
grep -rln "asegurar_locale_utf8" /Users/tomgc/Projects/slep_simce_adecuado/10_utils
```

Resultado: `10_utils/10_validar_portabilidad.R` (1 archivo).

Código que implementa la comprobación, línea 227 y siguientes:

```r
  utf8 <- isTRUE(l10n_info()[["UTF-8"]])
  checks[[length(checks) + 1L]] <- .vp_check(
    "locale_utf8", utf8,
    "Locale sin UTF-8; ejecutar la guarda asegurar_locale_utf8() (POLITICA 5.2bis)")
```

O sea: el proyecto **detecta** un locale no-UTF-8 y falla la validación de
portabilidad con un mensaje que indica el remedio.

### La función `asegurar_locale_utf8()` **no está definida en este repositorio**

Comando:

```
git grep -n "asegurar_locale_utf8 *<- *function"
```

Resultado: sin coincidencias.

Inventario completo del identificador en el repositorio versionado
(`git grep -n "asegurar_locale_utf8"`):

```
.Renviron.example:29:# Locale UTF-8 obligatoria (guarda asegurar_locale_utf8, POLITICA 5.2bis)
10_utils/10_validar_portabilidad.R:230:    "Locale sin UTF-8; ejecutar la guarda asegurar_locale_utf8() (POLITICA 5.2bis)")
```

Dos apariciones, ninguna es una definición: una es una glosa en
`.Renviron.example` y la otra es el mensaje de remediación del validador.

---

## 2. Lectura de lo anterior

| Pieza | ¿Existe en este repositorio? | Evidencia |
|---|---|---|
| Comprobación de que el locale es UTF-8 | **Sí** | `10_utils/10_validar_portabilidad.R:227`, check `locale_utf8` |
| Mensaje que indica el remedio y su norma | **Sí** | mismo archivo, línea 230; atribuido a POLITICA 5.2bis |
| Glosa en la plantilla de entorno | **Sí** | `.Renviron.example:29` |
| Definición de `asegurar_locale_utf8()` | **No** | `git grep "asegurar_locale_utf8 *<- *function"` sin coincidencias |

Las tres referencias apuntan a **POLITICA 5.2bis**. `POLITICA_PROYECTO.md` está
en `.gitignore` (líneas 41 y 44): vive en la knowledge base del Project, no en
este repositorio. Lo más probable es que la guarda esté definida a nivel de
cartera y no por proyecto, pero **eso no se verificó**: queda fuera del alcance
de esta constancia, que solo mide este repositorio.

---

## 3. Discrepancia con la premisa del encargo

El encargo que origina esta constancia afirma, en su premisa 5:

> La guarda `asegurar_locale_utf8` ya existe en un archivo de `10_utils`
> *(fuente: `grep -rl asegurar_locale_utf8 10_utils | wc -l` = 1, 2026-08-26)*.
> Falta la **constancia**, no la guarda.

El comando citado se reprodujo y da exactamente 1, igual que el 2026-08-26. Pero
ese comando prueba que **la cadena aparece** en un archivo, no que **la función
esté definida** ahí. Al medirlo con `git grep "asegurar_locale_utf8 *<- *function"`
resulta que no lo está.

Lo que falta, entonces, no es solo la constancia. Esta constancia se emite igual,
porque su cometido es registrar el estado verificado, y ese estado es el de
arriba. Que la guarda esté o no en la cartera, y si conviene traerla a
`10_utils/`, es **decisión del titular**: el encargo autorizaba crear este
documento, no instalar la guarda.

---

## 4. Cómo reproducir esta verificación

```bash
grep -rln "asegurar_locale_utf8" 10_utils
git grep -n "asegurar_locale_utf8"
git grep -n "asegurar_locale_utf8 *<- *function"
sed -n '226,231p' 10_utils/10_validar_portabilidad.R
Rscript -e 'cat(isTRUE(l10n_info()[["UTF-8"]]), "\n")'
```

El último comando informa si el locale de la sesión actual es UTF-8, que es
exactamente lo que evalúa el check `locale_utf8`.

---

## 5. Instalación (sesión 34, 2026-09-24)

**Decisión del titular:** opción A, `10_utils/10_configuracion.R` canónico como
punto de arranque común (POLITICA 5.2bis; SETTINGS §1.2.2 punto 4ter).

**Motivo medido:** una regeneración del motor con R en locale C escribió en el
JSON embebido «Servicio Local de Educaci<c3><b3>n P<c3><ba>blica» en vez del
texto con tildes, sin error ni prueba que fallara.

| Pieza | Estado |
|---|---|
| `10_utils/10_locale.R` | Copia idéntica de `herramientas_dev/plantillas/10_locale.R` (md5 `dc900c1b0d2d252c9e5730875be5d632`) |
| `10_utils/10_configuracion.R` | Nuevo; su primera línea ejecutable, tras el `source()` de la guarda, es `asegurar_locale_utf8("10_configuracion")` |
| Invocadores | `00_build.R` y los ocho scripts ejecutables de `30_procesamiento/` que se corren sueltos (30, 31, 32, 33, 34, 36 generar, 36 verificar), en la línea siguiente a `library(here)` |

**Verificación (en la réplica del asistente, R 4.3.3):**

- `90_verificar_locale.R` del kit: V1 a V4 en OK («GUARDA INSTALADA»).
- Se la vio fallar: con la invocación comentada, V2, V3 y V4 fallan; restaurado
  el archivo, es idéntico al instalado.
- `33_generar_html.R` bajo `LANG=C`: la guarda avisa la corrección a C.UTF-8 y el
  JSON queda igual al publicado (salvo la fecha de generación).
- `36_generar_trayectorias.R` bajo `LANG=C`: md5 `ebee5acf417f9aebaa46366c167588d7`,
  el mismo de la versión publicada; batería 19 de 19.

**Fuera de alcance:** `10_utils/10_validar_portabilidad.R` sigue sin invocador
(pendiente heredado).
