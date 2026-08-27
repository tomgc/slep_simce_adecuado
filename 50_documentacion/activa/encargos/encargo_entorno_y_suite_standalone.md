# Encargo — Entorno `renv` y regeneración de la suite standalone

> **Destino:** `50_documentacion/activa/encargos/encargo_entorno_y_suite_standalone.md`
> **Ejecuta:** Claude Code, sesión limpia. No requiere contexto previo de chat.

---

## 0. Contrato

**ENTORNO.** macOS aarch64. Proyecto R con `renv`. Intérprete de los bloques de
comando: `bash`. R se invoca con `Rscript` **desde la raíz del proyecto**: el
`.Rprofile` activa `renv`, así que un `Rscript` lanzado desde otro directorio
apunta a la librería equivocada.

**POSICIÓN.** Ruta absoluta en todos los comandos. No asumas directorio de
trabajo heredado. Raíz:

```
/Users/tomgc/Projects/slep_simce_adecuado
```

**Contexto en una frase.** El proyecto genera un motor interactivo de
comparación de resultados Simce y una suite de documentación en cuatro HTML
autocontenidos. La suite se genera con `50_documentacion/suite/documentar.R`, que
depende del paquete `suitedoc`; hoy `renv` está desincronizado y ese script no
corre. Este encargo repara el entorno y regenera la suite con una corrección de
terminología que ya está commiteada pero nunca se aplicó a los HTML publicados.

**Por qué importa.** Los cuatro HTML de la suite siguen diciendo "entidad" donde
el generador ya dice "territorio" desde el commit `6a1c8b6`. La corrección está
en el código y no en el producto.

---

## 1. Estado de partida (premisas marcadas)

1. `git status` limpio, `main` sincronizada con `origin/main` *(hipótesis, se
   mide en FASE 0)*.
2. `renv` reporta el proyecto out-of-sync: `openxlsx` aparece usado pero no
   instalado ni registrado, y `suitedoc` instalado pero no registrado *(fuente:
   `renv::status()` ejecutado el 2026-08-26, registrado en
   `50_documentacion/andamios/logs/20260826_homogeneidad_y_quinto_territorio_log.md`
   §4b)*.
3. `documentar.R` tiene `standalone = TRUE` y `verificar = FALSE` como valores
   permanentes *(hipótesis, se mide en FASE 0)*.
4. La corrección de terminología "entidad" → "territorio" en el texto UI de
   `documentar.R` está commiteada en `6a1c8b6` *(fuente: `git log`, sesión
   2026-08-26)*.
5. Los cuatro HTML de la suite vigentes se generaron **antes** de esa corrección
   *(hipótesis, se mide en FASE 2)*.

---

## 2. Invariantes (🔒 intocables)

- 🔒 `standalone = TRUE` y `verificar = FALSE` en `documentar.R`: permanentes, no
  se cambian ni temporalmente.
- 🔒 Los identificadores de código con raíz "entidad" (`entidades_tec`,
  `entidades_gen`) permanecen así. Solo el texto visible dice "territorio".
- 🔒 La prosa de la decisión `D-color-nivel` usa "entidad" en sentido analítico
  neutro, no como texto UI: **no se toca**.
- 🔒 `renv::restore()` y `renv::snapshot()` nunca se corren con argumentos que
  fuercen actualizaciones de versión más allá de lo que exige la reparación.
- 🔒 La suite debe quedar **offline**: cero referencias de red en los cuatro
  HTML.
- 🔒 `docs/index.html` no se toca: no forma parte de la suite.
- 🔒 `git status --short` antes de cada `git add`. Nunca `git add .`
- 🔒 No se hace `push`.

---

## 3. Autorizaciones

Estás autorizado a:

1. Modificar `renv.lock` mediante `renv::snapshot()`.
2. Instalar los paquetes que falten en la librería del proyecto.
3. Ejecutar `50_documentacion/suite/documentar.R`.
4. Commitear los archivos que produzcan los pasos anteriores.
5. Escribir y commitear el log de §6.

Nada más. En particular, **no** edites `documentar.R` ni ningún `.R` del
pipeline.

---

## 4. Fases

### FASE 0 — Medición

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
git status --short --branch
git log --oneline -3
Rscript -e 'renv::status()'
Rscript -e 'cat(nrow(renv::lockfile_read()$Packages %||% list()), "\n")' 2>/dev/null || Rscript -e 'cat(length(renv::lockfile_read()$Packages), "\n")'
grep -n "standalone" /Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite/documentar.R | head -5
grep -n "verificar" /Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite/documentar.R | head -5
ls -la /Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite/
```

| Medición | Esperado | Si difiere |
|---|---|---|
| `git status` | limpio | **DETENTE** y reporta lo que hay sin commitear |
| `renv::status()` | menciona `openxlsx` y `suitedoc` | Repórtalo y sigue: repara lo que realmente falte, no lo que este encargo predice |
| `standalone` | `TRUE` | **DETENTE** |
| `verificar` | `FALSE` | **DETENTE** |

Registra el número de paquetes del lockfile: es el baseline del delta de FASE 1.

### FASE 1 — Reparar el entorno

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
Rscript -e 'renv::status()'
```

Instala lo que falte y registra en el lockfile lo que esté instalado y sin
registrar, hasta que `renv::status()` declare el proyecto sincronizado.
`suitedoc` no está en CRAN: si no se puede resolver su origen automáticamente,
**detente y reporta** en vez de improvisar una instalación.

Verificación con rama de detención:

```bash
Rscript -e 'renv::status()'
Rscript -e 'for (p in c("here","arrow","dplyr","jsonlite","openxlsx","suitedoc")) cat(p, as.character(packageVersion(p)), "\n")'
git -C /Users/tomgc/Projects/slep_simce_adecuado diff --stat
```

Las seis dependencias deben imprimir versión y `renv::status()` debe declarar
sincronía. El `diff` debe mostrar **solo** `renv.lock`; si toca cualquier otro
archivo, **detente**.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add renv.lock
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "chore(renv): registra openxlsx y suitedoc en el lockfile"
```

### FASE 2 — Medir el desfase de la suite antes de regenerar

Antes de sobrescribir nada, deja constancia de qué dicen los HTML vigentes:

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite
for f in *_standalone.html; do echo "== $f"; md5 -q "$f"; grep -c "entidad" "$f"; grep -c -E "https?://" "$f"; done
```

Registra los cuatro md5, el conteo de "entidad" y el de referencias de red.
Este es el baseline contra el cual se juzga la regeneración.

### FASE 3 — Regenerar

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado
Rscript -e 'source(here::here("50_documentacion","suite","documentar.R"))'
```

Si falla, error literal completo y **DETENTE** sin borrar nada.

Verificación con ramas de detención:

```bash
cd /Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/suite
for f in *_standalone.html; do echo "== $f"; md5 -q "$f"; grep -c "entidad" "$f"; grep -c -E "https?://" "$f"; done
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
```

| Criterio | Esperado | Si difiere |
|---|---|---|
| Referencias de red | **0** en los cuatro | **DETENTE**: la suite dejó de ser offline |
| "entidad" | Solo el residuo de la decisión `D-color-nivel`, en un único archivo | Reporta archivo y conteo, y **detente** si aparece en otros |
| Archivos modificados | los cuatro `*_standalone.html` | Si aparece alguno más, repórtalo |

Si algún md5 resulta **idéntico** al de FASE 2, la generación fue determinista y
no-op para ese archivo: dilo explícitamente, no lo trates como error.

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 50_documentacion/suite
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "docs(suite): regenera los cuatro HTML standalone con la terminologia corregida"
```

---

## 5. Reporte final al chat

1. Salidas literales de FASE 0.
2. Qué faltaba en el lockfile y cómo se resolvió.
3. Tabla de los cuatro HTML: md5 antes, md5 después, "entidad" antes y después,
   referencias de red después.
4. Los dos hashes.
5. Qué falló o sorprendió. **Si nada, dilo explícitamente.**

No hagas `push`.

---

## 6. Log

Escribe, y **commitea**, un log en:

```
/Users/tomgc/Projects/slep_simce_adecuado/50_documentacion/andamios/logs/AAAAMMDD_entorno_y_suite_standalone_log.md
```

con la fecha real del día. Es el documento que se audita después, así que debe
permitir reconstruir la ejecución sin tenerte delante:

- Salida **literal** de cada comando de verificación, no su resumen.
- Una tabla por fase con tres columnas: medición, valor esperado, valor medido.
- Toda cifra que afirmes debe venir del comando que la produjo, citado en la
  misma línea. Una cifra sin comando al lado es un defecto del log.
- Cada decisión tomada ante una ambigüedad, con la alternativa que descartaste y
  por qué.
- Todo lo que quedó **sin verificar** y por qué.
- Si algo salió distinto de lo esperado, queda escrito aunque después se haya
  arreglado. Un log que solo registra el camino limpio no sirve para auditar.

Último commit del encargo, junto con este archivo de encargo si aún no está
versionado:

```bash
git -C /Users/tomgc/Projects/slep_simce_adecuado add 50_documentacion/andamios/logs/AAAAMMDD_entorno_y_suite_standalone_log.md 50_documentacion/activa/encargos/encargo_entorno_y_suite_standalone.md
git -C /Users/tomgc/Projects/slep_simce_adecuado status --short
git -C /Users/tomgc/Projects/slep_simce_adecuado commit -m "docs(encargos): versiona encargo de entorno y suite con su log"
```
