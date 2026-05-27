# POLITICA_PROYECTO.md — slep_simce_adecuado

> **Nota:** Este archivo es la copia local de la `POLITICA_PROYECTO.md` canónica
> que el titular mantiene en su knowledge base. La versión a continuación
> recoge las reglas operativas conocidas para este proyecto. Si la canónica
> tiene cláusulas adicionales o más específicas, esta versión debe
> sustituirse por la canónica.

## 1. Estructura canónica de directorios

Directorios numerados, snake_case, descriptivos:

```
00_*.R                # Orquestación, escaneo de proyecto
10_utils/             # Funciones reutilizables
20_insumos/           # Datos crudos y auxiliares
30_procesamiento/     # Scripts de pipeline
40_salidas/           # Outputs intermedios y productos finales
50_documentacion/     # activa/, traspasos/, estructura/
```

Cada subdirectorio dentro de `30_procesamiento/` también va numerado
secuencialmente (`31_*`, `32_*`, `33_*`, ...).

## 2. Naming

- snake_case para archivos, variables, funciones, columnas.
- Identificadores numéricos (rbd, cod_com_rbd, cod_grupo) como `character`,
  nunca como integer ni double.
- Sufijos de columna que indican unidad: `_rbd` (establecimiento), `_com`
  (comuna), `_slep` (servicio local), `_pais`.

## 3. Rutas

- Toda ruta se construye con `here::here()`.
- Cero rutas absolutas.
- Cero `setwd()`.

## 4. Datos

- Todos los datos son públicos (Agencia de Calidad de la Educación). No
  aplica separación publico/privado.
- xlsx crudos en `20_insumos/simce/{nivel}/`.
- Tablas auxiliares en `20_insumos/auxiliares/`.
- Parquet intermedios en `40_salidas/intermedios/`.
- Producto final en `40_salidas/motor_comparacion.html`.

## 5. Reglas SIMCE (umbrales MINEDUC)

- Excluir establecimientos con menos de 10 estudiantes evaluados (`nalu < 10`)
  en la prueba relevante.
- Excluir establecimientos con `marca_<prueba><nivel>_rbd` distinto de NA/vacío.
- Estos filtros se aplican antes de cualquier agregación.

## 6. Fórmula de agregación

Única, válida para comuna y SLEP por igual:

```
% adecuado agregado = sum(nalu * palu_eda_ade / 100) / sum(nalu) * 100
```

Los SLEPs son grupos de comunas; no requieren lógica especial — solo una
tabla de mapeo `cod_com → slep_nombre`.

## 7. Segmentación

- **GSE siempre presente** en toda vista de resultados (Bajo, Medio bajo,
  Medio, Medio alto, Alto). Inviolable.
- Pruebas (Lectura, Matemática) y niveles (4B, 2M) nunca se mezclan.

## 8. UI (HTML final)

- Convenciones numéricas chilenas: coma decimal, punto de miles.
- Formato del indicador: `XX,X% (N)`.
- Standalone: JSON embebido en el HTML, sin dependencias de servidor.

## 9. Versionado

- Repositorio Git con remoto en GitHub.
- Mensajes de commit en español.
- Datos crudos xlsx no se versionan (gitignore).
- Parquet intermedios no se versionan (regenerables).
- HTML final no se versiona (regenerable; se publica por separado).

## 10. Documentación

- `CLAUDE.md` mantenido al día con los últimos 5 cambios relevantes.
- `50_documentacion/estructura/estructura_proyecto.md` con el mapa
  detallado del árbol de archivos y su propósito.
- `50_documentacion/activa/` para documentación de la sesión vigente.
- `50_documentacion/traspasos/` para handoffs entre sesiones.
