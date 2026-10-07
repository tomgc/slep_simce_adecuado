# Adenda al encargo de retiro de `unpkg.com`: respuestas a D1-D3 y cierre de T2

Formato: `encargo_autonomo_claude_code_v1.md` v1.6, en modo reducido (tres
pasos). Mismo ENTORNO, POSICIÓN, invariantes 🔒 1, 2, 4 y 5, topes, autorizaciones
y regla de detención que `50_documentacion/activa/encargos/encargo_retiro_cdn_v8.md`;
lo que sigue los reemplaza o los completa. El log de ese encargo está
commiteado y congelado: esta adenda escribe el suyo.

- **EJECUCIÓN:** esfuerzo `xhigh`; subagentes 0.
- **LOG:** `50_documentacion/andamios/logs/20260923_retiro_cdn_v8_adenda_log.md`.
- **ALCANCE:** `30_procesamiento/33_generar_html.R`, `30_procesamiento/33_motor_template.html`,
  la salida ignorada `40_salidas/motor_comparacion.html`, el LOG, esta adenda y
  `50_documentacion/andamios/logs/20260923_sesion31_errores_asistente.md`
  (registro de errores del redactor, ya modificado; solo se commitea).
- **PUNTO DE RETORNO:** `bb53c8c` (fuente: `git log --oneline -4` en la sesión
  del redactor; hipótesis, se mide en FASE 0 con `git rev-parse --short HEAD`).

## Respuestas del redactor

- **D1: sí.** El criterio de marcadores pasa a
  `grep -c -F -e '__REACT_INLINE__' -e '__REACTDOM_INLINE__' 40_salidas/motor_comparacion.html`
  → esperado `0`. Calibración: sobre `30_procesamiento/33_motor_template.html` → esperado `2`.
  El criterio original era defecto del encargo (ERR-31-02), no del build.
- **D2: (a).** El 🔒 3 se reformula así: el JSON descomprimido de la salida,
  sin el campo `meta.fecha_generacion`, es idéntico al JSON descomprimido de
  `docs/index.html` sin ese mismo campo. Medición en R, con el método de
  descompresión que ya registraste en el log del encargo: `identical(j_salida, j_publicado)`
  → esperado `TRUE`. Calibración: la misma comparación con un valor numérico
  alterado en una copia de `j_salida` → esperado `FALSE`. `fecha_generacion`
  cambia por diseño en cada build y no es dato. La opción (b) cambiaría el
  producto para satisfacer un criterio, y queda descartada.
- **D3: no.** La plantilla v1.6 pide `git rev-parse --short HEAD`, una sola
  revisión; el comando defectuoso lo escribí yo en el encargo (ERR-31-04).
- **Línea separadora borrada en el generador:** aceptada. Era un defecto de
  mi edición (ERR-31-05).

## Pasos

1. **FASE 0:** crear LOG con el slot del bloque J; medir PUNTO DE RETORNO,
   `git status --porcelain` (esperado: ` M` en los dos archivos de código del
   ALCANCE y en el registro de errores del redactor, `??` en esta adenda, nada más) y `git merge-base --is-ancestor origin/main HEAD`
   (esperado: código 0).
2. **T2, cierre:** correr de nuevo `Rscript 30_procesamiento/33_generar_html.R`;
   aplicar los criterios de T2 del encargo con D1 y D2 ya reemplazados; los
   cinco 🔒 con su comando; commit
   `feat(motor): retira unpkg.com; React inline y JSX transpilado en el build con V8 (s31)`
   con los dos archivos del ALCANCE.
3. **T3:** tal como está escrita en el encargo (solo si `chromote` está
   disponible; no se instala).
4. **FASE R y FASE L:** los diez y los siete pasos de las secciones homónimas
   del encargo, aplicados sobre lo que hizo esta adenda. En FASE L, `git add`
   del LOG, de esta adenda y del registro de errores del redactor, commit `docs(log): cierre de T2 del retiro de unpkg.com`,
   y push según la autorización 4 del encargo, que ahora cubre también los
   tres commits ya hechos (`2ab9927`, `65e5e4a`, `bb53c8c`).

Reporte final: igual que el §6 del encargo.
