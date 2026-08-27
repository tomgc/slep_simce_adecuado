# Encargo — Ordenación del repositorio y constancias documentales

> **Destino:** `50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.

---

## 0. Contrato

**ENTORNO.** macOS aarch64. Proyecto R con `renv`. Intérprete de los bloques de
comando: `bash`. Todo `Rscript` se lanza desde la raíz del proyecto.

**Nota de entorno.** `grep` en macOS es BSD: los patrones con `{` o `}` van con
`grep -F`, o el comando devuelve 0 siempre y su rama de detención no protege
nada.

**POSICIÓN.** Ruta absoluta en todos los comandos. Raíz:

```
/Users/tomgc/Projects/slep_simce_adecuado
```

**Contexto en una frase.** El proyecto organiza sus carpetas por decenas
(`10_utils`, `20_insumos`, `30_procesamiento`, `40_salidas`,
`50_documentacion`), y con el tiempo se acumularon tres scripts sueltos en la
raíz, un archivo con espacio en el nombre y dos constancias documentales que la
política exige y no existen.

**Este encargo mueve y renombra archivos versionados.** Todo movimiento se hace
con `git mv`, nunca con `mv`, y toda referencia al archivo movido se actualiza
en el mismo commit.

---

## 1. Estado de partida (premisas marcadas)

1. `git status` limpio, `main` sincronizada con `origin/main` *(hipótesis, se
   mide en FASE 0)*.
2. En la raíz hay tres scripts sueltos: `verificar_depe4.R`,
   `verificar_elem_insuf.R` y `verificar_elem_insuf_2023_2024.R` *(fuente:
   escáner `estructura_actual.md` del 2026-08-26 09:21)*.
3. Existe `20_insumos/auxiliares/prototipo_design/Motor SIMCE.html`, con un
   espacio en el nombre *(misma fuente)*.
4. No existen `50_documentacion/activa/50_ordenacion_repositorio.md` ni
   `50_documentacion/activa/50_locale_utf8.md` *(fuente: `ls` ejecutado el
   2026-08-26, ambos "No such file or directory")*.
5. La guarda `asegurar_locale_utf8` ya existe en un archivo de `10_utils`
   *(fuente: `grep -rl asegurar_locale_utf8 10_utils | wc -l` = 1, 2026-08-26)*.
   Falta la **constancia**, no la guarda.
6. Hay 27 traspasos acumulados en `50_documentacion/traspasos/` *(hipótesis, se
   mide en FASE 0)*.

---

## 2. Invariantes (🔒 intocables)

- 🔒 **DRY_RUN obligatorio**: toda operación de movimiento o renombrado se lista
  primero sin ejecutar, se reporta, y solo entonces se ejecuta.
- 🔒 Todo movimiento con `git mv`. Nunca `mv` a secas: perdería el rastro.
- 🔒 Antes de mover o renombrar un archivo, `grep` de **todas** sus referencias
  literales en el repositorio, incluidos comentarios, cadenas de error y
  documentación. Las referencias se actualizan en el mismo commit que el
  movimiento.
- 🔒 Los traspasos históricos **no se tocan, no se renumeran y no se archivan**
  en este encargo: son el registro canónico del proyecto.
- 🔒 `backlog_acumulativo.md` es append-only. Este encargo no lo edita.
- 🔒 Nada se borra. Si un script parece obsoleto, se mueve y se anota como
  candidato a revisión; la eliminación es decisión del titular.
- 🔒 `docs/index.html`, `20_insumos/` y `40_salidas/` no se reorganizan.
- 🔒 `git status --short` antes de cada `git add`. Nunca `git add .`
- 🔒 No se hace `push`.

---

## 3. Autorizaciones

Estás autorizado a:

1. Mover con `git mv` los tres scripts de verificación de la raíz a
   `10_utils/`.
2. Renombrar con `git mv` el archivo con espacio en el nombre.
3. Actualizar las referencias literales a los archivos movidos.
4. Crear `50_documentacion/activa/50_ordenacion_repositorio.md` y
   `50_documentacion/activa/50_locale_utf8.md`.
5. Crear los commits de §4.
6. Escribir y commitear el log de §6.

Nada más. En particular, **no** edites la lógica de ningún script.

---

## 4. Fases

### FASE 0 — Medición y DRY_RUN

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
git status --short --branch
git log --oneline -3
ls -la /Users/tomgc/Projects/slep_simce_adecuado/*.R
ls -la /Users/tomgc/Projects/slep_simce_adecuado/10_utils/
ls "/Users/tomgc/Projects/slep_simce_adecuado/20_insumos/auxiliares/prototipo_design/"
ls /Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/traspasos/ | wc -l
grep -rn "verificar_depe4\|verificar_elem_insuf" /Users/tomgc/Projects/slep_simce_adecuado --include="*.R" --include="*.md" --include="*.html" --include="*.Rproj" --include=".gitignore"
grep -rn "Motor SIMCE.html" /Users/tomgc/Projects/slep_simce_adecuado --include="*.R" --include="*.md" --include="*.html" --include="*.jsx" --include="*.css"
grep -rln "asegurar_locale_utf8" /Users/tomgc/Projects/slep_simce_adecuado/10_utils
```

Reporta el resultado de los tres `grep` **antes de mover nada**: son el
inventario de referencias que hay que actualizar. Si alguno devuelve
coincidencias en archivos que este encargo no autoriza a editar, **detente y
repórtalo**.

Rama de detención: si `git status` no está limpio, **DETENTE**.

### COMMIT 1 — Scripts de verificación a `10_utils/`

Mueve los tres con `git mv` y actualiza toda referencia hallada en FASE 0.
Estos scripts son verificaciones puntuales, no parte del pipeline: si al leerlos
descubres que alguno **sí** es invocado por `00_build.R` o por un script de
`30_procesamiento/`, no lo muevas y repórtalo.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "chore(estructura): mueve los scripts de verificacion sueltos a 10_utils"
```

Verificación posterior: `ls *.R` en la raíz no debe listar ninguno de los tres, y
`grep -rn` de sus nombres no debe devolver rutas viejas.

### COMMIT 2 — Nombre con espacio

Renombra con `git mv` el archivo `Motor SIMCE.html` a un nombre sin espacios,
tildes ni eñes, coherente con la convención del resto del proyecto (minúsculas y
guion bajo). Actualiza las referencias halladas en FASE 0.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "chore(estructura): renombra el prototipo sin espacios en el nombre"
```

Verificación con rama de detención: un `find` sobre el repositorio no debe
devolver **ningún** archivo versionado con espacio en el nombre. Si aparece
alguno más que no estaba en el inventario, repórtalo y no lo toques.

### COMMIT 3 — Las dos constancias

Crea los dos documentos. Son constancias breves, no tratados: cada uno declara
qué se verificó, cuándo, con qué comando y cuál fue el resultado.

**`50_documentacion/activa/50_ordenacion_repositorio.md`** deja constancia de la
ordenación ejecutada en este encargo: el estado previo medido en FASE 0, qué se
movió y a dónde, qué referencias se actualizaron, y el conteo de traspasos
acumulados como dato de contexto para una futura política de archivado (que este
encargo **no** decide).

**`50_documentacion/activa/50_locale_utf8.md`** deja constancia de que la guarda
`asegurar_locale_utf8` existe y dónde: nombre del archivo, función, y el comando
con el que se verificó. La guarda ya existe, así que este documento **registra**,
no instala nada.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 50_documentacion/activa/50_ordenacion_repositorio.md 50_documentacion/activa/50_locale_utf8.md
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "docs(gobernanza): constancias de ordenacion del repositorio y de locale UTF-8"
```

### FASE FINAL — Verificación

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
ls -la /Users/tomgc/Projects/slep_simce_adecuado/*.R
find /Users/tomgc/Projects/slep_simce_adecuado -name "* *" -not -path "*/.git/*" -not -path "*/renv/*"
Rscript -e 'source(here::here("00_escanear_proyecto.R"))'
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado log --oneline -4
```

El escáner regenera el snapshot de estructura. Si eso deja archivos nuevos en
`50_documentacion/estructura/`, commitéalos aparte:

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 50_documentacion/estructura
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "chore(estructura): rota snapshot del escaner tras la ordenacion"
```

Si el escáner falla, error literal completo y **DETENTE**: el resto ya está
commiteado y no hay que revertirlo.

---

## 5. Reporte final al chat

1. Salidas literales de FASE 0, con el inventario de referencias.
2. Tabla de movimientos: origen, destino, referencias actualizadas.
3. Los hashes.
4. Verificaciones de la FASE FINAL.
5. Qué falló o sorprendió. **Si nada, dilo explícitamente.**

No hagas `push`.

---

## 6. Log

Escribe, y **commitea**, un log en:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/AAAAMMDD_ordenacion_repositorio_log.md
```

con la fecha real del día. Es el documento que se audita después, así que debe
permitir reconstruir la ejecución sin tenerte delante:

- Salida **literal** de cada comando de verificación, no su resumen.
- El **DRY_RUN completo** antes de cada movimiento, y el resultado después.
- Una tabla por fase con tres columnas: medición, valor esperado, valor medido.
- Tabla de referencias: archivo movido, cada referencia encontrada con su ruta y
  número de línea, y si se actualizó o por qué no.
- Toda cifra que afirmes debe venir del comando que la produjo, citado en la
  misma línea. Una cifra sin comando al lado es un defecto del log.
- Cada decisión tomada ante una ambigüedad, con la alternativa descartada y por
  qué. En particular, cualquier script que decidiste **no** mover y el motivo.
- Todo lo que quedó **sin verificar** y por qué.
- Si algo salió distinto de lo esperado, queda escrito aunque después se haya
  arreglado.

Último commit del encargo, junto con este archivo de encargo si aún no está
versionado:

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 50_documentacion/andamios/logs/AAAAMMDD_ordenacion_repositorio_log.md 50_documentacion/activa/encargos/encargo_ordenacion_repositorio.md
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "docs(encargos): versiona encargo de ordenacion con su log"
```
