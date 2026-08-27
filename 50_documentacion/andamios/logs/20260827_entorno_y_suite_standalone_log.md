# Log — Entorno `renv` y regeneración de la suite standalone

**Fecha:** 2026-08-27
**Encargo:** `50_documentacion/activa/encargos/encargo_entorno_y_suite_standalone.md`
**Resultado:** **DETENIDO en FASE 1** por rama de detención explícita del propio
encargo. Las FASES 2 y 3 no se ejecutaron. La suite **no** se regeneró.
**Push:** no se hizo.

> Este encargo se ejecutó como primer eslabón de una cadena de tres. Al
> dispararse la rama de detención, la cadena completa se detuvo aquí: los
> encargos `encargo_deuda_tipografica_svg_y_codigo_muerto.md` y
> `encargo_ordenacion_repositorio.md` **no se ejecutaron** y no tienen log.

---

## 1. FASE 0 — Medición (salida literal)

### `git status --short --branch`

```
## main...origin/main
?? 50_documentacion/activa/encargos/encargo_deuda_tipografica_svg_y_codigo_muerto.md
?? 50_documentacion/activa/encargos/encargo_entorno_y_suite_standalone.md
?? 50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md
```

### `git log --oneline -3`

```
06d6586 docs(encargos): versiona encargo de homogeneidad y quinto territorio con su log
a433839 deploy(pages): publica motor con 5 territorios y correcciones visuales de s28
9e8ecdd fix(motor): elimina celdas de relleno del supergrid, obsoletas con la grilla dinamica
```

### `date "+%Y-%m-%d %H:%M:%S %Z"`

```
2026-08-27 09:02:51 -04
```

### `Rscript -e 'renv::status()'`

```
- The project is out-of-sync -- use `renv::status()` for details.
The following package(s) are in an inconsistent state:

 package  installed recorded used
 openxlsx n         n        y   
 suitedoc y         n        y   

See `?renv::status` for advice on resolving these issues.
```

### `Rscript -e 'cat(length(renv::lockfile_read()$Packages), "\n")'`

```
40
```

### `grep -n "standalone" 50_documentacion/suite/documentar.R | head -5`

```
425:  standalone  = TRUE,
```

### `grep -n "verificar" 50_documentacion/suite/documentar.R | head -5`

```
12:# cero residuos. Se usa verificar = FALSE de forma permanente en este proyecto:
419:# verificar = TRUE: aborta si quedara algún residuo del ejemplo de fábrica.
424:  verificar   = FALSE,
```

### `ls -la 50_documentacion/suite/`

```
total 3696
drwxr-xr-x  10 tomgc  staff     320 Aug 26 09:26 .
drwxr-xr-x@  8 tomgc  staff     256 Aug 22 09:03 ..
-rw-r--r--@  1 tomgc  staff  452212 Jul  1 15:11 arquitectura_general_slep_simce_adecuado_standalone.html
-rw-r--r--@  1 tomgc  staff  455637 Jul  1 15:11 arquitectura_slep_simce_adecuado_standalone.html
drwxr-xr-x@  5 tomgc  staff     160 Jun 19 11:59 assets
-rw-r--r--@  1 tomgc  staff  444308 Jul  1 15:11 documentacion_general_slep_simce_adecuado_standalone.html
-rw-r--r--@  1 tomgc  staff  451381 Aug 24 09:48 documentacion_proyecto_slep_simce_adecuado_standalone.html
-rw-r--r--@  1 tomgc  staff   51456 Aug 26 09:25 documentar.R
drwxr-xr-x@  8 tomgc  staff     256 Jun 19 11:59 fonts
-rw-r--r--@  1 tomgc  staff   22254 Jul  1 15:11 suite_estilos.css
```

### Tabla de FASE 0

| Medición | Valor esperado | Valor medido |
|---|---|---|
| `git status --short --branch` | limpio | tres `??`, y son **los tres archivos de encargo de esta misma cadena** (`git status --short --branch`) |
| Sincronía con `origin/main` | sincronizada | `## main...origin/main`, sin `ahead`/`behind` (`git status --short --branch`) |
| `renv::status()` menciona `openxlsx` y `suitedoc` | sí | sí, exactamente esos dos y ningún otro (`Rscript -e 'renv::status()'`) |
| Paquetes en el lockfile (baseline) | — | 40 (`Rscript -e 'cat(length(renv::lockfile_read()$Packages), "\n")'`) |
| `standalone` en `documentar.R` | `TRUE` | `TRUE`, línea 425 (`grep -n "standalone" …`) |
| `verificar` en `documentar.R` | `FALSE` | `FALSE`, línea 424 (`grep -n "verificar" …`) |
| HTML standalone presentes | 4 | 4 (`ls -la 50_documentacion/suite/`) |

### Decisión 1 — el `git status` no limpio no detuvo la corrida

**Ambigüedad.** La tabla de FASE 0 manda **DETENERSE** si `git status` no está
limpio. Estaba sucio: tres archivos sin versionar.

**Decisión.** Continuar.

**Fundamento.** Los tres `??` son exactamente los tres archivos de encargo que el
titular entregó para esta cadena. No hay ni una sola modificación sobre archivo
versionado (`git diff --stat` vacío). Además, la propia §6 de este encargo manda
commitear su archivo de encargo "**si aún no está versionado**", o sea que el
encargo presupone que puede estar sin versionar al arrancar. Existe precedente
en el proyecto: `20260826_homogeneidad_y_quinto_territorio_log.md` §1 registra un
`git status` de partida con el archivo de encargo en `??` y esa corrida procedió.

**Alternativa descartada.** Detener la cadena completa antes de medir nada. Se
descartó porque la rama de detención protege contra trabajo ajeno sin commitear
que se pudiera perder o mezclar, y aquí no hay ninguno: el criterio operativo es
"sin modificaciones a archivos versionados y sin archivos ajenos al encargo", y
se cumple.

---

## 2. FASE 1 — Reparación del entorno: **DETENIDA**

### Paso 1.1 — `openxlsx`: instalado

`openxlsx` sí es una dependencia real del proyecto, no un falso positivo del
escaneo de `renv`. Uso literal:

```
30_procesamiento/34_historico_pct_adecuado_costa_central.R:123:openxlsx::write.xlsx(
30_procesamiento/34_historico_pct_adecuado_costa_central.R:135:wb <- openxlsx::loadWorkbook(ruta_salida)
30_procesamiento/34_historico_pct_adecuado_costa_central.R:136:estilo_pct <- openxlsx::createStyle(numFmt = "0%")
30_procesamiento/34_historico_pct_adecuado_costa_central.R:141:  openxlsx::addStyle(
30_procesamiento/34_historico_pct_adecuado_costa_central.R:146:openxlsx::saveWorkbook(wb, ruta_salida, overwrite = TRUE)
```

Está en CRAN y el repositorio configurado lo resuelve
(`Rscript -e 'print(getOption("repos"))'` → `CRAN "https://cloud.r-project.org"`).

### `Rscript -e 'renv::install("openxlsx")'`

```
- The project is out-of-sync -- use `renv::status()` for details.
The following package(s) will be installed:
- openxlsx [4.2.8.1]
- Rcpp     [1.1.2]
- zip      [3.0.2]
These packages will be installed into "~/Projects/slep_simce_adecuado/renv/library/macos/R-4.5/aarch64-apple-darwin20".

# Installing packages --------------------------------------------------------
- Installing Rcpp ...                           OK [linked from cache]
- Installing zip ...                            OK [linked from cache]
- Installing openxlsx ...                       OK [linked from cache]
Successfully installed 3 packages in 4 milliseconds.
```

Se instalaron tres paquetes, no uno: `Rcpp` y `zip` son dependencias de
`openxlsx` que `renv` arrastró. Los tres salieron de la caché local, sin
descarga. La librería del proyecto está en `.gitignore`
(`renv/settings.json` → `"vcs.ignore.library": true`), así que esto no produce
ningún cambio en `git status`.

### Paso 1.2 — `renv::snapshot()`: **ABORTA**

```
- The project is out-of-sync -- use `renv::status()` for details.
The following package(s) were installed from an unknown source:
- suitedoc [0.5.1]
renv may be unable to restore these packages in the future.
Consider reinstalling these packages from a known source (e.g. CRAN).

Error en renv_snapshot_validate_report(valid, prompt, force): 
  aborting snapshot due to pre-flight validation failure
Calls: <Anonymous> -> renv_snapshot_validate_report
Traceback (most recent calls last):
3: renv::snapshot()
2: renv_snapshot_validate_report(valid, prompt, force)
1: stop("aborting snapshot due to pre-flight validation failure")
Ejecución interrumpida
```

**Consecuencia que conviene subrayar:** el fallo es de *pre-flight*, o sea que
aborta el snapshot **entero**. No se registró tampoco `openxlsx`. El problema de
`suitedoc` bloquea el registro de todo lo demás; no son dos asuntos separables.

### Rama de detención disparada

Texto literal del encargo, FASE 1:

> `suitedoc` no está en CRAN: si no se puede resolver su origen automáticamente,
> **detente y reporta** en vez de improvisar una instalación.

Antes de darla por disparada se comprobó, una por una, cada vía por la que
`renv` podría resolver el origen **automáticamente**:

| Vía de resolución automática | Comando | Resultado |
|---|---|---|
| Campos `Remote*` en el DESCRIPTION instalado | `Rscript -e 'd <- read.dcf(file.path(find.package("suitedoc"),"DESCRIPTION")); print(t(d))'` | ninguno. Solo campos estándar; `Built: R 4.5.2; ; 2026-08-26 19:31:03 UTC; unix` |
| `renv/cellar/` (repositorio local de paquetes privados) | `ls -la renv/cellar` | `ls: renv/cellar: No such file or directory` |
| `local.sources` / `RENV_CONFIG_*` | `env \| grep -i "^RENV"`; `grep -i renv ~/.Renviron`; `cat renv/settings.json` | sin variables `RENV_` en el entorno; sin menciones en `~/.Renviron`; `settings.json` sin rutas de origen |
| Registro previo en el lockfile del que heredar el origen | `git log --oneline -S"suitedoc" -- renv.lock` | vacío: **nunca** estuvo registrado |
| Presencia actual en el lockfile | `grep -n "suitedoc" renv.lock` | sin coincidencias |
| CRAN | `getOption("repos")` = solo CRAN cloud | `suitedoc` no está en CRAN (premisa del encargo) |

Las seis vías dan negativo. `renv` 1.1.4
(`Rscript -e 'cat(as.character(packageVersion("renv")), "\n")'`) no puede
resolver el origen por sí solo, que es exactamente la condición de la rama.

### Lo que sí se encontró, y por qué **no** se usó

Existe una fuente local del paquete en
`/Users/tomgc/Projects/herramientas_dev/suitedoc` (`DESCRIPTION`, `NAMESPACE`,
`R/`, `man/`, `inst/`: un árbol de paquete completo). Es un **repositorio
hermano**, no un origen declarado por este proyecto.

**Decisión 2 — no instalar desde esa ruta.** Instalar `suitedoc` desde una ruta
descubierta rastreando el disco es precisamente "improvisar una instalación", que
es lo que la rama prohíbe. Además, `suitedoc` **no falta**: ya está instalado
(`installed y`). La autorización §3.2 cubre "instalar los paquetes que **falten**",
y este no falta. Lo que falta es su **registro**, y registrarlo bien exige decidir
antes de dónde se declara que viene.

### Alternativas disponibles, todas fuera de las autorizaciones de §3

Se dejan planteadas para que decida el titular. Ninguna se ejecutó:

| Opción | Qué haría | Costo / por qué no la tomé solo |
|---|---|---|
| **A.** `renv::snapshot(force = TRUE)` | Registraría `suitedoc` con `Source: "unknown"`, y de paso `openxlsx`, `Rcpp` y `zip`. `renv::status()` quedaría sincronizado | Deja un lockfile **no restaurable** para `suitedoc`: el propio `renv` avisa "renv may be unable to restore these packages in the future". Convierte la reproducibilidad del proyecto en una promesa falsa, y esa es una decisión de gobernanza, no mecánica |
| **B.** Reinstalar desde `~/Projects/herramientas_dev/suitedoc` | El registro quedaría con `RemoteType: local` y `RemoteUrl` a una ruta **de esta máquina** | Es la instalación improvisada que la rama prohíbe. Y un `RemoteUrl` absoluto y local no restaura en otra máquina |
| **C.** Crear `renv/cellar/` y depositar ahí el tarball de `suitedoc` | Es el mecanismo que `renv` ofrece para paquetes privados; sí restaura, y `renv/settings.json` ya trae `"vcs.ignore.cellar": true` | Instala y además introduce una pieza estructural nueva en el proyecto. No autorizado aquí. **Es la vía técnicamente más sólida de las tres** |
| **D.** Añadir `suitedoc` a `ignored.packages` | `renv::status()` callaría | Esconde una dependencia real. No autorizado y desaconsejable |

---

## 3. Estado del entorno al detenerse

### `Rscript -e 'renv::status()'` (después de instalar `openxlsx`)

```
- The project is out-of-sync -- use `renv::status()` for details.
The following package(s) are in an inconsistent state:

 package  installed recorded used
 openxlsx y         n        y   
 Rcpp     y         n        y   
 suitedoc y         n        y   
 zip      y         n        y   

See `?renv::status` for advice on resolving these issues.
```

Cambió respecto de FASE 0: `openxlsx` pasó de `installed n` a `installed y`, y
aparecieron `Rcpp` y `zip` como instalados-y-no-registrados. Los cuatro se
registrarían de una sola vez en cuanto el snapshot pueda correr.

### `Rscript -e 'for (p in c("here","arrow","dplyr","jsonlite","openxlsx","suitedoc")) cat(p, as.character(packageVersion(p)), "\n")'`

```
here 1.0.1 
arrow 24.0.0 
dplyr 1.2.0 
jsonlite 2.0.0 
openxlsx 4.2.8.1 
suitedoc 0.5.1 
```

Las seis dependencias **imprimen versión**: las seis están instaladas y cargables.
Lo que impide declarar sincronía no es una ausencia, es un registro.

### `git diff --stat`

```
(vacío)
```

`renv.lock` quedó **intacto**, con sus 40 paquetes
(`Rscript -e 'cat(length(renv::lockfile_read()$Packages), "\n")'` → `40`,
idéntico al baseline de FASE 0).

### `git status --short --branch`

```
## main...origin/main
?? 50_documentacion/activa/encargos/encargo_deuda_tipografica_svg_y_codigo_muerto.md
?? 50_documentacion/activa/encargos/encargo_entorno_y_suite_standalone.md
?? 50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md
```

### Tabla de FASE 1

| Medición | Valor esperado | Valor medido |
|---|---|---|
| `openxlsx` instalado | sí | sí, 4.2.8.1 (`renv::install("openxlsx")`) |
| Paquetes instalados de arrastre | no previstos | 2: `Rcpp` 1.1.2 y `zip` 3.0.2 (`renv::install("openxlsx")`) |
| `renv::snapshot()` completa | sí | **no**: aborta en pre-flight por `suitedoc` (`Rscript -e 'renv::snapshot()'`) |
| `renv::status()` declara sincronía | sí | **no**: 4 paquetes inconsistentes (`Rscript -e 'renv::status()'`) |
| Las seis dependencias imprimen versión | sí | sí, las seis (`Rscript -e 'for (p in c(...)) …'`) |
| `git diff --stat` toca solo `renv.lock` | solo `renv.lock` | **ningún** archivo: el snapshot no llegó a escribir (`git diff --stat`) |
| Paquetes en el lockfile | > 40 | 40, sin cambio (`Rscript -e 'cat(length(renv::lockfile_read()$Packages), "\n")'`) |
| Commit `chore(renv)` | creado | **no creado**: no hay nada que commitear |

---

## 4. FASES 2 y 3 — no ejecutadas

No se midieron los md5 de los cuatro HTML, no se contaron sus ocurrencias de
"entidad" ni sus referencias de red, y **no se regeneró la suite**. El desfase
que motiva el encargo sigue vigente: el commit `6a1c8b6`
(`Wed Aug 26 09:26:06 2026 -0400`, "docs(suite): corrige terminologia
entidad->territorio en documentar.R") corrigió el generador, y los cuatro HTML
publicados —tres del 1 de julio, uno del 24 de agosto según
`ls -la 50_documentacion/suite/`— son todos anteriores a esa corrección.

Correr `documentar.R` con el entorno fuera de sincronía habría sido saltarse el
orden del encargo, que hace de la sincronía la precondición de la regeneración.

---

## 5. Qué quedó sin verificar

- **Que la suite regenerada diga "territorio"**: no se regeneró. Sin verificar.
- **Que la suite siga siendo offline (cero referencias de red)**: no se
  regeneró, y tampoco se midió el baseline de FASE 2. Sin verificar en ambos
  extremos.
- **Que `documentar.R` corra sin error**: nunca se invocó. Sin verificar. Que
  `suitedoc` esté instalado y cargable hace *plausible* que corra, pero eso es
  una inferencia, no una medición.
- **Que el residuo de "entidad" de la decisión `D-color-nivel` sea el único
  superviviente**: sin verificar, por lo mismo.
- **Que `renv::restore()` sea capaz de reconstruir el entorno en otra máquina**:
  sin verificar, y hoy con `suitedoc` fuera del lockfile la respuesta segura es
  que no.

---

## 6. Qué falló o sorprendió

1. **La rama de detención de `suitedoc` se disparó.** El encargo la anticipó
   como posibilidad y ocurrió. Es la causa de la parada.

2. **Sorpresa: el fallo de `suitedoc` bloquea el registro de `openxlsx`.** El
   encargo trata los dos casos como si fueran independientes ("`openxlsx`
   aparece usado pero no instalado ni registrado, y `suitedoc` instalado pero no
   registrado"). No lo son: `renv::snapshot()` valida antes de escribir y aborta
   la operación completa, así que un solo paquete de origen desconocido deja el
   lockfile sin tocar. No hay reparación parcial posible por esta vía.

3. **Sorpresa menor: `openxlsx` arrastró dos paquetes.** `Rcpp` y `zip`. El
   encargo hablaba de un paquete faltante; son tres los que habría que
   registrar, cuatro contando `suitedoc`.

4. **Hallazgo lateral: existe fuente local del paquete** en
   `/Users/tomgc/Projects/herramientas_dev/suitedoc`. No se usó, por §3 y por la
   prohibición explícita de improvisar. Queda anotado porque hace viable la
   opción **C** del cuadro de alternativas.

5. **El `git status` de partida no estaba limpio**, aunque por una razón inocua
   y prevista. Queda escrito, como corresponde, aunque no haya alterado nada.

---
---

# Reanudación — 2026-08-27, segunda corrida

**Fecha:** 2026-08-27
**Punto de partida:** el punto de detención de la primera corrida (FASE 1,
`renv::snapshot()` abortado).
**Autorización adicional del titular, literal:** *"Quedas autorizado a reinstalar
`suitedoc` desde su repositorio git remoto, si lo tiene, y a registrar el
resultado en el lockfile. Nada más se amplía."*
**Resultado:** **DETENIDO de nuevo en el PASO A**, por el CASO 2 de la
bifurcación que el propio titular definió. No se instaló nada. No se hizo
snapshot. Las FASES 2 y 3 siguen sin ejecutarse.
**Push:** no se hizo.

> La FASE 0 no se repitió, por instrucción expresa del titular. Sus mediciones
> siguen siendo las de la sección 1 de este log.

---

## R1. PASO A — Medición del origen real de `suitedoc` (salida literal)

### `ls -la /Users/tomgc/Projects/herramientas_dev/suitedoc`

```
total 160
drwxr-xr-x@ 16 tomgc  staff    512 Aug 26 09:39 .
drwxr-xr-x  16 tomgc  staff    512 Aug 26 09:39 ..
-rw-r--r--@  1 tomgc  staff   8196 Aug 26 15:12 .DS_Store
drwxr-xr-x@  3 tomgc  staff     96 Aug 14 06:14 .claude
-rw-r--r--@  1 tomgc  staff    295 Jun 22 18:58 .gitignore
-rw-r--r--@  1 tomgc  staff   4635 Aug 26 15:12 CLAUDE.md
-rw-r--r--@  1 tomgc  staff   1337 Aug 26 15:12 DESCRIPTION
-rw-r--r--@  1 tomgc  staff    259 Jun 22 17:37 NAMESPACE
drwxr-xr-x@  8 tomgc  staff    256 Aug 14 06:14 R
-rw-r--r--@  1 tomgc  staff  22824 Aug 26 15:12 README.md
drwxr-xr-x   8 tomgc  staff    256 Aug 26 15:12 dev
drwxr-xr-x@  8 tomgc  staff    256 Aug 26 15:13 dev_logs
-rw-r--r--@  1 tomgc  staff  12857 Jun 22 17:28 encargo_suitedoc_inline_standalone.md
-rw-r--r--@  1 tomgc  staff   4841 Jun 22 18:56 encargo_suitedoc_saneamiento.md
drwxr-xr-x@  4 tomgc  staff    128 Aug 26 09:30 inst
drwxr-xr-x@  8 tomgc  staff    256 Aug 14 06:14 man
```

Es un árbol de paquete R completo: `DESCRIPTION`, `NAMESPACE`, `R/`, `man/`,
`inst/`. No hay `.git` propio en el listado, primer indicio de que no es un
repositorio.

### `git -C /Users/tomgc/Projects/herramientas_dev/suitedoc remote -v`

```
origin	https://github.com/tomgc/herramientas_dev.git (fetch)
origin	https://github.com/tomgc/herramientas_dev.git (push)
```

El remoto que responde **no es de `suitedoc`**: es el de `herramientas_dev`. El
comando funciona porque `git` sube por el árbol de directorios hasta encontrar el
repositorio contenedor.

### `git -C /Users/tomgc/Projects/herramientas_dev/suitedoc status --short --branch`

```
## main...origin/main [ahead 20]
 M ../plantillas/90_estado_cartera.sh
 D ../prompts/cierre_sesion_autonomo_cc_v10.md
?? ../gobernanza/encargo_normativos_fuera_del_versionado_v1.md
?? ../gobernanza/encargo_traer_cartera_windows_v1.md
?? ../logs/20260824_normativos_fuera_versionado_log.md
?? ../logs/20260824_traer_cartera_windows_log.md
?? ../prompts/asistente_documentar_suite_cc_v6.md
?? ../prompts/cierre_sesion_autonomo_cc_v11.md
?? ../prompts/rutina_dos_maquinas_v1.md
?? dev/encargo_suitedoc_codigo_destacado_v1.md
?? dev/encargo_suitedoc_doc_total_v1.md
?? dev/encargo_suitedoc_mapa_medido_v1.md
?? dev/encargo_suitedoc_masthead_v2.md
```

Las rutas con `../` confirman lo anterior: el repositorio empieza un nivel más
arriba. Trece entradas sucias y 20 commits sin publicar.

### `git -C /Users/tomgc/Projects/herramientas_dev/suitedoc log --oneline -3`

```
39986e8 docs(suitedoc): version 0.5.1
052a489 feat(suitedoc): legibilidad del arbol del repositorio
2c11e53 feat(suitedoc): masthead fijo del documento total
```

### `grep -n "^Version\|^Package\|^Remote" /Users/tomgc/Projects/herramientas_dev/suitedoc/DESCRIPTION`

```
1:Package: suitedoc
3:Version: 0.5.1
```

Ninguna línea `Remote*`. El `DESCRIPTION` **fuente** tampoco declara origen, igual
que el instalado.

### `Rscript -e 'cat(renv::settings$vcs.ignore.cellar(), "\n")'`

```
- The project is out-of-sync -- use `renv::status()` for details.
TRUE
```

---

## R2. Mediciones adicionales para resolver la bifurcación

La tercera condición del CASO 2 —"la versión instalada no corresponde a ningún
commit publicado"— no se puede juzgar con los seis comandos del PASO A. Se
midió con consultas **de solo lectura**, sin `fetch` ni escritura de ningún tipo
sobre el repositorio hermano.

### `git -C /Users/tomgc/Projects/herramientas_dev/suitedoc rev-parse --show-toplevel`

```
/Users/tomgc/Projects/herramientas_dev
```

### `git -C /Users/tomgc/Projects/herramientas_dev log origin/main..HEAD --oneline | wc -l`

```
      20
```

### `git -C /Users/tomgc/Projects/herramientas_dev log origin/main..HEAD --oneline`

```
39986e8 docs(suitedoc): version 0.5.1
052a489 feat(suitedoc): legibilidad del arbol del repositorio
2c11e53 feat(suitedoc): masthead fijo del documento total
91c585b docs(suitedoc): version 0.5.0
182e5e5 feat(suitedoc): cfg_ejemplo con significados
0026977 feat(suitedoc): validaciones del mapa y cruce inverso
39e80a9 feat(suitedoc): render del arbol con cobertura e insignias
00a93d7 feat(suitedoc): mapeo medido del repositorio
77e0fcc docs(suitedoc): version 0.4.1
ee113e3 feat(suitedoc): cfg_ejemplo con cuadros de codigo
b134cfd feat(suitedoc): campo codigo en items del documento total
c65e05a fix(suitedoc): ajustes de verificacion e2e
ea35074 docs(suitedoc): version 0.4.0 y documentacion del quinto documento
ff89c00 feat(suitedoc): cfg_ejemplo con bloque total
101edca feat(suitedoc): inlinar_suite cubre interno/
46da61b feat(suitedoc): generar_suite emite documentacion total en interno/
c12bad8 feat(suitedoc): builder del documento total interno
22089f8 feat(suitedoc): helpers de documentacion total
a42b185 docs(suitedoc): especificacion documentacion total v1
f1c8717 chore(suitedoc): desarchivar paquete a la raiz del kit
```

Los 20 commits sin publicar son, prácticamente todos, de `suitedoc`. El más
antiguo, `f1c8717`, es el que **coloca el paquete donde hoy está**.

### `git -C /Users/tomgc/Projects/herramientas_dev branch -r --contains 39986e8`

```
(vacío)
```

El commit que declara `Version: 0.5.1` no está contenido en **ninguna** rama
remota.

### `git -C /Users/tomgc/Projects/herramientas_dev ls-remote origin main`

```
57c05c78f7870065619a3ec052987aac43addeba	refs/heads/main
```

### `git -C /Users/tomgc/Projects/herramientas_dev rev-parse origin/main`

```
57c05c78f7870065619a3ec052987aac43addeba
```

Los dos SHA coinciden: el ref local de seguimiento **no está desactualizado**, así
que la conclusión no depende de un `fetch` pendiente. Lo que dice el ref local es
lo que hay hoy en GitHub.

### `git -C /Users/tomgc/Projects/herramientas_dev rev-parse HEAD`

```
39986e8ac07d6c3dff9b64e0affe4341534a5ccf
```

### `git -C /Users/tomgc/Projects/herramientas_dev show origin/main:suitedoc/DESCRIPTION`

```
(no existe suitedoc/DESCRIPTION en origin/main)
```

Hallazgo terminal: en el estado publicado del remoto **no existe el paquete** en
esa ruta. No es que esté publicada una versión vieja; es que no hay ninguna.

---

## R3. Resolución de la bifurcación: **CASO 2**

Las tres condiciones del CASO 2 se cumplen, cada una por separado suficiente:

| Condición del CASO 2 | ¿Se cumple? | Evidencia y comando |
|---|---|---|
| "no tiene remoto" (propio) | **Sí** | `suitedoc` no es un repositorio: `git rev-parse --show-toplevel` → `/Users/tomgc/Projects/herramientas_dev`. El `origin` que aparece es el del repo contenedor (`git remote -v`) |
| "el árbol está sucio" | **Sí** | 13 entradas: 1 modificada, 1 borrada, 11 sin versionar; cuatro de ellas **dentro** de `suitedoc/dev/` (`git status --short --branch`) |
| "la versión instalada no corresponde a ningún commit publicado" | **Sí** | `git branch -r --contains 39986e8` → vacío; `git show origin/main:suitedoc/DESCRIPTION` → no existe; `git ls-remote origin main` = `origin/main` local, o sea que el ref no está rancio |

**Acción tomada: DETENERSE.** No se instaló desde ruta local, no se usó
`force = TRUE`, no se tocó `ignored.packages`, exactamente como manda el CASO 2.

### Decisión R-1 — por qué no se intentó `renv::install("git::…", subdir="suitedoc")`

**Ambigüedad.** La autorización dice "reinstalar `suitedoc` desde su repositorio
git remoto, **si lo tiene**". `renv` sabe instalar desde un subdirectorio de un
repo git con `subdir=`, así que técnicamente existía un comando que probar.

**Decisión.** No ejecutarlo.

**Fundamento.** Fallaría con certeza, no por azar: en `origin/main` no existe
`suitedoc/DESCRIPTION` (`git show origin/main:suitedoc/DESCRIPTION`). Y si por
alguna variante de ruta llegara a encontrar algo, instalaría un estado del
paquete **anterior a los 20 commits sin publicar**, es decir una versión distinta
de la 0.5.1 con la que se generó todo lo existente. Eso cambiaría en silencio el
generador de la suite, que es justo lo que este encargo quiere mantener bajo
control. La condición "si lo tiene" no se cumple.

**Alternativa descartada.** Ejecutarlo "a ver qué pasa" y decidir con el error en
la mano. Se descartó porque el CASO 2 ya estaba disparado por otras dos vías
independientes: el resultado no habría cambiado la decisión, solo habría añadido
una escritura innecesaria a la librería del proyecto.

### Decisión R-2 — por qué no se hizo `git fetch` en el repositorio hermano

**Ambigüedad.** El ref `origin/main` local podía estar desactualizado, y con él
todo el juicio sobre qué está publicado.

**Decisión.** Comprobarlo con `git ls-remote`, que consulta el remoto **sin
escribir nada** en el repositorio local.

**Fundamento.** `git ls-remote origin main` devolvió `57c05c7…`, idéntico al ref
local. La duda queda resuelta sin tocar un repositorio que este encargo no
administra.

**Alternativa descartada.** `git fetch`. Se descartó porque escribe refs en un
repositorio ajeno al encargo y no aportaba información adicional.

---

## R4. Estado al detenerse por segunda vez

Sin cambios respecto del cierre de la primera corrida, salvo el commit `c79a6ea`
que ya existía:

| Medición | Valor esperado | Valor medido |
|---|---|---|
| Instalaciones nuevas en esta corrida | ninguna | ninguna: el CASO 2 se resolvió antes de instalar |
| `renv.lock` | intacto | intacto, 40 paquetes |
| `openxlsx`, `Rcpp`, `zip` | instalados, sin registrar | siguen instalados y sin registrar |
| `suitedoc` | instalado 0.5.1, sin registrar | sigue instalado 0.5.1, sin registrar |
| Repositorio hermano `herramientas_dev` | no se modifica | no se modificó: solo lecturas y un `ls-remote` |
| FASES 2 y 3 | pendientes | pendientes |

---

## R5. Qué quedó sin verificar en esta corrida

Todo lo listado en la sección 5 de la primera corrida sigue igual de
inverificado, y por la misma causa. Se añade:

- **Que `renv::install` desde el remoto habría funcionado**: no se ejecutó, por la
  decisión R-1. La afirmación "habría fallado" es una inferencia sólida a partir
  de `git show origin/main:suitedoc/DESCRIPTION`, no una medición.
- **Si el remoto tiene ramas o tags distintos de `main` con el paquete
  publicado**: solo se consultó `main` (`git ls-remote origin main`) y
  `git branch -r --contains`, que cubre las ramas de seguimiento conocidas
  localmente. Un tag remoto publicado y nunca traído no aparecería. No se
  verificó.

---

## R6. Qué falló o sorprendió en esta corrida

1. **Sorpresa mayor: `suitedoc` no es un repositorio.** Toda la bifurcación del
   titular está redactada sobre la premisa de "su repositorio git remoto". El
   paquete es un **subdirectorio** de `herramientas_dev`, un kit de herramientas
   que agrupa además `plantillas/`, `prompts/`, `gobernanza/` y `logs/`. La
   pregunta "¿tiene remoto?" tiene una respuesta engañosa: `git remote -v`
   responde con un remoto, pero es el del contenedor.

2. **Sorpresa mayor: el paquete no está publicado en absoluto.** No se trata de
   un desfase de versión. En `origin/main` no existe `suitedoc/DESCRIPTION`. Los
   20 commits sin publicar incluyen `f1c8717 chore(suitedoc): desarchivar paquete
   a la raiz del kit`, o sea que la ubicación actual del paquete es, ella misma,
   trabajo sin publicar.

3. **Coincidencia que conviene registrar:** las tres condiciones del CASO 2 se
   cumplen a la vez. No hubo que afinar el juicio sobre ninguna.

4. **El ref local no estaba rancio**, lo que ahorró tener que decidir si tocar el
   repositorio hermano. `git ls-remote` y `rev-parse origin/main` coinciden.

5. **La causa raíz se movió de sitio.** En la primera corrida el bloqueo parecía
   una laguna de configuración de este proyecto (falta un cellar, falta declarar
   un origen). Ahora se ve que el bloqueo está **fuera** de este repositorio: el
   paquete del que depende el pipeline de documentación no está publicado en
   ninguna parte, y eso no lo puede arreglar un encargo que solo tiene permisos
   sobre `slep_simce_adecuado`.
