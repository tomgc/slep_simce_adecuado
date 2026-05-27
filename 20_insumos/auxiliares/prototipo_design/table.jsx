/* ============================================================
   Motor SIMCE — tabla de resultados con heat map por GSE
   Escala: diverging por columna GSE — alertas (bajo) en coral,
   neutro en cream, sobre-rendimiento en ocean. Independiente
   del nivel absoluto del GSE.
   ============================================================ */

function ResultsTable({ entities, nivel, prueba }) {
  const YEARS = SimceData.YEARS;
  const GSE_LEVELS = SimceData.GSE_LEVELS;

  // 1) Generar todos los datos
  const rowsRaw = [];
  entities.forEach(ent => {
    GSE_LEVELS.forEach((gse, gi) => {
      const series = SimceData.generateSeries({
        entityName: ent.name,
        gse,
        nivel,
        prueba,
      });
      rowsRaw.push({ ent, gse, gseFirst: gi === 0, series });
    });
  });

  // 2) Para cada GSE, computamos el rango de valores (todas entidades, todos años).
  //    Usamos eso para escala diverging centrada en la mediana del GSE.
  //    Idea: una entidad muy por debajo del rango típico de SU GSE = alerta roja.
  const scaleByGse = {};
  GSE_LEVELS.forEach(gse => {
    const vals = [];
    rowsRaw.forEach(r => {
      if (r.gse !== gse) return;
      r.series.forEach(s => { if (s.pct != null) vals.push(s.pct); });
    });
    if (vals.length === 0) {
      scaleByGse[gse] = { lo: 0, mid: 50, hi: 100 };
      return;
    }
    vals.sort((a, b) => a - b);
    const q = p => vals[Math.min(vals.length - 1, Math.max(0, Math.floor(p * (vals.length - 1))))];
    // amplificamos un poco el rango con un mínimo para que aún con poca variabilidad se vea contraste
    let lo = q(0.10);
    let hi = q(0.90);
    const mid = q(0.50);
    const span = Math.max(8, hi - lo);
    lo = mid - span / 2;
    hi = mid + span / 2;
    scaleByGse[gse] = { lo, mid, hi };
  });

  // Color builder — escala diverging coral → cream → ocean apagado
  // Usamos colores muy desaturados para que el texto siga legible.
  function cellBg(pct, gse) {
    if (pct == null) return null;
    const { lo, mid, hi } = scaleByGse[gse];
    // t en [-1, +1]: -1 = alerta, 0 = neutro, +1 = sobre-rendimiento
    let t;
    if (pct <= mid) {
      t = -1 + (pct - lo) / (mid - lo || 1);
    } else {
      t = (pct - mid) / (hi - mid || 1);
    }
    t = Math.max(-1, Math.min(1, t));

    // Interpola entre 3 paradas:
    //   t=-1 → coral suave  (#F0C2A8 sobre cream)
    //   t= 0 → cream-50     (#FFFBEF)
    //   t=+1 → ocean suave  (#BFD8E7)
    const stops = [
      { t: -1, c: [232, 134, 99] },   // coral pleno (#E88663)
      { t:  0, c: [255, 251, 239] },  // cream-50
      { t:  1, c: [10,  58,  92] },   // ocean institucional (#0A3A5C)
    ];
    // intensidad máxima ~ alpha 0.55 para preservar legibilidad
    const alphaMax = 0.55;
    const alpha = Math.abs(t) * alphaMax;
    const c = t < 0 ? stops[0].c : stops[2].c;
    return `rgba(${c[0]},${c[1]},${c[2]},${alpha.toFixed(3)})`;
  }

  // Indicador de alerta: t <= -0.55 (cerca del extremo inferior del rango GSE)
  function isAlert(pct, gse) {
    if (pct == null) return false;
    const { lo, mid } = scaleByGse[gse];
    const span = mid - lo;
    if (span <= 0) return false;
    return pct < (lo + span * 0.3);
  }

  return (
    <div className="table-wrap">
      <table className="data-table data-table-heat">
        <thead>
          <tr>
            <th className="th-ent">Entidad</th>
            <th className="th-gse">GSE</th>
            {YEARS.map(y => (
              <th key={y} className={y === 2025 ? "th-year th-prelim" : "th-year"}>
                {y}{y === 2025 && <span className="prelim-mark"> *</span>}
              </th>
            ))}
          </tr>
        </thead>
        <tbody>
          {rowsRaw.map((r, i) => {
            const prevEnt = i > 0 ? rowsRaw[i - 1].ent : null;
            const startsEnt = !prevEnt || prevEnt.name !== r.ent.name;
            return (
              <tr key={i} className={startsEnt ? "row-ent-start" : ""}>
                <td className="td-ent">
                  {startsEnt && (
                    <span className="ent-cell">
                      <span className="ent-swatch" style={{ background: r.ent.color }} />
                      <span className="ent-name">{r.ent.name}</span>
                    </span>
                  )}
                </td>
                <td className="td-gse">{r.gse}</td>
                {r.series.map(s => {
                  const bg = cellBg(s.pct, r.gse);
                  const alert = isAlert(s.pct, r.gse);
                  let cls = "td-cell";
                  if (s.preliminar) cls += " td-prelim";
                  if (alert) cls += " td-alert";
                  return (
                    <td
                      key={s.year}
                      className={cls}
                      style={bg ? { background: bg } : null}
                      title={s.pct == null
                        ? "Sin datos"
                        : `${s.pct.toFixed(1)}% Adecuado · N=${s.n_eval} · ${s.n_estab} establecimiento${s.n_estab===1?"":"s"}${s.preliminar ? " · preliminar" : ""}`
                      }
                    >
                      {s.pct == null ? (
                        <span className="td-empty">—</span>
                      ) : (
                        <>
                          <span className="td-pct">
                            {s.pct.toFixed(1).replace(".", ",")}%
                          </span>
                          <span className="td-n">
                            ({fmtInt(s.n_eval)})
                          </span>
                          {alert && <span className="td-alert-dot" title="Bajo el rango típico de este GSE">▼</span>}
                        </>
                      )}
                    </td>
                  );
                })}
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}

// Leyenda del heat map — explica los colores debajo del título
function HeatLegend() {
  return (
    <div className="heat-legend">
      <div className="heat-legend-text">
        <span className="heat-legend-title">Cómo leer los colores</span>
        <p>
          Cada columna GSE tiene su propia escala: el color compara cada celda
          contra el rango típico de ese GSE, no contra valores absolutos. Una
          entidad puede estar en alerta dentro de su GSE aunque su % parezca
          alto en otra columna.
        </p>
      </div>
      <div className="heat-legend-scale">
        <div className="heat-scale-bar">
          <span className="heat-tick heat-tick-left">
            <b>▼ Alerta</b>
            <small>Bajo el rango típico del GSE</small>
          </span>
          <span className="heat-tick heat-tick-mid">
            <b>En rango</b>
            <small>Cercano a la mediana del GSE</small>
          </span>
          <span className="heat-tick heat-tick-right">
            <b>Sobre rango ▲</b>
            <small>Por encima del rango típico</small>
          </span>
        </div>
        <div className="heat-ramp">
          <span className="heat-ramp-bar heat-ramp-coral" />
          <span className="heat-ramp-bar heat-ramp-mid" />
          <span className="heat-ramp-bar heat-ramp-ocean" />
        </div>
      </div>
    </div>
  );
}

Object.assign(window, { ResultsTable, HeatLegend });
