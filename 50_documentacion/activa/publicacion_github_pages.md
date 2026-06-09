# Publicación en GitHub Pages — slep_simce_adecuado

> Documentación activa. Describe cómo se publica y cómo se actualiza el motor
> de comparación SIMCE en GitHub Pages.

## Qué se publica

El archivo `40_salidas/motor_comparacion.html` (~15 MB, autocontenido, con JSON
agregado público embebido) se copia a `docs/index.html` y se sirve mediante
GitHub Pages desde la rama `main`, carpeta `/docs`.

- **URL pública:** https://tomgc.github.io/slep_simce_adecuado/
- **Repo:** privado (`tomgc/slep_simce_adecuado`).
- **Contenido expuesto:** solo `/docs/index.html`. El código R, los xlsx de
  insumos y los traspasos permanecen privados.

## Gobernanza

- El HTML contiene **únicamente datos agregados públicos** extraídos de la
  Agencia de Calidad de la Educación (SIMCE a nivel RBD, ponderado por GSE).
- No contiene resultados individuales ni datos personales de menores.
- La segmentación por GSE es inviolable y se mantiene en el output publicado.
- Antes de cada republicación, verificar que el JSON embebido sigue siendo
  solo agregado público (invariante metodológico del pipeline).

## Configuración inicial (ya realizada — referencia)

Settings → Pages → Source: "Deploy from a branch" → Branch `main` / carpeta
`/docs`. GitHub advierte que el sitio será público; es lo esperado para datos
agregados públicos.

## Procedimiento de republicación

Cada vez que se regenere el HTML con un nuevo build del pipeline:

```bash
cd ~/Projects/slep_simce_adecuado

# 1. Regenerar el HTML (corre el pipeline completo)
Rscript 00_build.R

# 2. Copiar el output a la carpeta de publicacion
cp 40_salidas/motor_comparacion.html docs/index.html

# 3. Verificacion de gobernanza: solo debe aparecer docs/index.html
git add docs/index.html
git status

# 4. Commit y push (solo tras confirmar el status)
git commit -m "deploy: actualizar motor de comparacion SIMCE"
git push origin main
```

GitHub Pages reconstruye el sitio automáticamente en 1–2 minutos tras el push.

## Validación post-publicación

Abrir https://tomgc.github.io/slep_simce_adecuado/ y verificar:

1. El motor carga completo.
2. Buscador con diacríticos: "valparaiso" devuelve VALPARAÍSO primero.
3. Tooltip se voltea hacia adentro en los extremos del viewport.
4. Datos segmentados por GSE.

## Optimización pendiente (opcional, no urgente)

El HTML pesa ~15 MB por el JSON embebido. Si la carga inicial molesta en la
práctica, separar el JSON del HTML (fetch externo) reduciría el HTML a ~200 KB
y la segunda visita sería instantánea por caché. Requiere modificar
`33_generar_html.R` para emitir HTML + JSON por separado. Cambio acotado, no
abordado en esta sesión.
