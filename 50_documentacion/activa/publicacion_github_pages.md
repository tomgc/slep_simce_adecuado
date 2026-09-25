# Publicación en GitHub Pages — slep_simce_adecuado

> Documentación activa. Describe cómo se publican y cómo se actualizan el motor
> de comparación SIMCE y la vista de trayectorias en GitHub Pages.

## Qué se publica

Dos archivos autocontenidos, generados por el pipeline y copiados íntegros a
`docs/`, que GitHub Pages sirve desde la rama `main`, carpeta `/docs`:

| Salida local | Archivo publicado | Paso que la genera |
|---|---|---|
| `40_salidas/motor_comparacion.html` | `docs/index.html` | `33_generar_html.R` |
| `40_salidas/trayectorias_traspasos.html` | `docs/trayectorias.html` | `36_generar_trayectorias.R` |

Las dos páginas comparten el menú de vistas: el motor enlaza a
`trayectorias.html` y la vista vuelve a `index.html` o a `index.html#panorama`,
que abre la pestaña Panorama territorial (D33-2). La vista no se incrusta en el
motor. Ninguna de las dos carga nada por red.

- **URL pública:** https://tomgc.github.io/slep_simce_adecuado/
- **Repo:** público (`tomgc/slep_simce_adecuado`; decisión `decisiones/20260611_decision_repo_publico.md`).
- **Vista de trayectorias:** https://tomgc.github.io/slep_simce_adecuado/trayectorias.html
- **Contenido expuesto:** solo `/docs/index.html` y `/docs/trayectorias.html`.
  El resto del repositorio también es público: código R, insumos públicos de la Agencia y documentación.
  Lo que no se versiona es lo que excluye `.gitignore` (por ejemplo, el directorio oficial crudo).

## Gobernanza

- Los dos HTML contienen **únicamente datos agregados públicos** extraídos de la
  Agencia de Calidad de la Educación (SIMCE a nivel RBD, ponderado por GSE).
- No contiene resultados individuales ni datos personales de menores.
- La segmentación por GSE es inviolable y se mantiene en el output publicado.
- Antes de cada republicación, verificar que el JSON embebido sigue siendo
  solo agregado público (invariante metodológico del pipeline).
- Antes de republicar la vista de trayectorias, la batería del paso 36 debe
  pasar completa (`Rscript 30_procesamiento/36_verificar_trayectorias.R`,
  código 0).

## Configuración inicial (ya realizada — referencia)

Settings → Pages → Source: "Deploy from a branch" → Branch `main` / carpeta
`/docs`. GitHub advierte que el sitio será público; es lo esperado para datos
agregados públicos.

## Procedimiento de republicación

Cada vez que se regenere el HTML con un nuevo build del pipeline:

```bash
cd ~/Projects/slep_simce_adecuado

# 1. Regenerar los dos HTML (corre el pipeline completo, pasos 33 y 36)
Rscript 00_build.R

# 2. Batería de la vista de trayectorias (debe terminar con código 0)
Rscript 30_procesamiento/36_verificar_trayectorias.R

# 3. Copia íntegra de cada salida a la carpeta de publicación
cp 40_salidas/motor_comparacion.html docs/index.html
cp 40_salidas/trayectorias_traspasos.html docs/trayectorias.html

# 4. Verificación: sin cargas por red (ambos deben dar 0)
grep -cE "src=[\"']?(https?:)?//" docs/index.html docs/trayectorias.html
grep -c 'url(http' docs/index.html docs/trayectorias.html

# 5. Verificación de gobernanza: solo deben aparecer los dos archivos de docs/
git add docs/index.html docs/trayectorias.html
git status

# 6. Commit y push (solo tras confirmar el status)
git commit -m "deploy: actualizar motor y vista de trayectorias"
git push origin main
```

GitHub Pages reconstruye el sitio automáticamente en 1–2 minutos tras el push.

## Validación post-publicación

Abrir https://tomgc.github.io/slep_simce_adecuado/ y verificar:

1. El motor carga completo.
2. Buscador con diacríticos: "valparaiso" devuelve VALPARAÍSO primero.
3. Tooltip se voltea hacia adentro en los extremos del viewport.
4. Datos segmentados por GSE.
5. «Trayectorias de los Servicios Locales» abre la vista; desde ella,
   «Panorama territorial» abre el motor en esa pestaña y «Comparación entre
   territorios» en la comparación.
6. Lo que sirve Pages es lo publicado: `curl -s https://tomgc.github.io/slep_simce_adecuado/ | md5` igual a
   `md5 -q docs/index.html`, y lo mismo con `trayectorias.html` (Pages tarda 1 a 2 minutos en reconstruir).

## Optimización pendiente (opcional, no urgente)

El motor pesa 2.921.439 B y la vista 2.206.558 B (sesión 35), casi todo por el JSON embebido. Si la carga inicial molesta en la
práctica, separar el JSON del HTML (fetch externo) reduciría el HTML a ~200 KB
y la segunda visita sería instantánea por caché. Requiere modificar
`33_generar_html.R` para emitir HTML + JSON por separado. Cambio acotado, no
abordado en esta sesión.
