/* ============================================================
   Motor SIMCE — gráficos D3
   1 entidad × 1 GSE por panel.
   Cada panel tiene DOS subgráficos verticales:
   - Sparkline arriba: trayectoria histórica completa, minimalista
   - Barras abajo: 100% apiladas de las últimas 3 aplicaciones SIMCE
   ============================================================ */

const { useEffect, useRef, useMemo } = React;

// Formato chileno
function fmtPct(v) {
  if (v == null) return "—";
  return v.toFixed(1).replace(".", ",") + "%";
}
function fmtPctShort(v) {
  if (v == null) return "—";
  return Math.round(v) + "%";
}
function fmtInt(v) {
  if (v == null) return "—";
  return v.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".");
}

// gris para borde / segmento Elemental+Insuficiente
const REST_BORDER = "#C8BDA0";
const REST_FILL   = "#FFFFFF";

// tooltip compartido
function makeTooltip(entity, gse) {
  function show(e, s, yr) {
    const tip = document.getElementById("global-tooltip");
    tip.style.display = "block";
    tip.innerHTML = `
      <div class="tt-row tt-head">
        <span class="tt-swatch" style="background:${entity.color}"></span>
        <span class="tt-ent">${entity.name}</span>
      </div>
      <div class="tt-gse">GSE ${gse} · ${yr}${s.preliminar ? " *" : ""}</div>
      <div class="tt-segments">
        <div class="tt-seg">
          <span class="tt-seg-sw" style="background:${entity.color}"></span>
          <span class="tt-seg-lbl">Adecuado</span>
          <span class="tt-seg-val">${fmtPct(s.pct)}</span>
        </div>
        <div class="tt-seg">
          <span class="tt-seg-sw tt-seg-sw-empty"></span>
          <span class="tt-seg-lbl">Elemental + Insuficiente</span>
          <span class="tt-seg-val">${fmtPct(100 - s.pct)}</span>
        </div>
      </div>
      <div class="tt-meta">
        <span>N evaluados: <b>${fmtInt(s.n_eval)}</b></span>
        <span>N establecimientos: <b>${fmtInt(s.n_estab)}</b></span>
      </div>
      ${s.n_estab === 1 ? '<div class="tt-warn">Baja representatividad — un solo establecimiento</div>' : ""}
      ${s.preliminar ? '<div class="tt-warn">* Dato preliminar 2025</div>' : ""}
    `;
    tip.style.left = (e.clientX + window.scrollX + 12) + "px";
    tip.style.top  = (e.clientY + window.scrollY - 12) + "px";
  }
  function hide() {
    document.getElementById("global-tooltip").style.display = "none";
  }
  return { show, hide };
}

// ============================================================
// Sparkline — trayectoria histórica minimalista
// ============================================================
function SparklineSubchart({ entity, gse, nivel, prueba }) {
  const ref = useRef(null);

  useEffect(() => {
    const svg = d3.select(ref.current);
    svg.selectAll("*").remove();

    const W = 320, H = 90;
    const M = { top: 16, right: 12, bottom: 22, left: 12 };
    const iw = W - M.left - M.right;
    const ih = H - M.top - M.bottom;

    const g = svg
      .attr("viewBox", `0 0 ${W} ${H}`)
      .attr("preserveAspectRatio", "xMidYMid meet")
      .append("g")
      .attr("transform", `translate(${M.left},${M.top})`);

    const series = SimceData.generateSeries({
      entityName: entity.name, gse, nivel, prueba,
    });
    const valid = series.filter(s => s.pct != null);

    // X y Y
    const x = d3.scaleLinear().domain([2014, 2025]).range([0, iw]);
    const y = d3.scaleLinear().domain([0, 100]).range([ih, 0]);

    // banda suave 2019-2021 (sólo se intuye, sin label)
    g.append("rect")
      .attr("x", x(2019)).attr("y", 0)
      .attr("width", x(2021) - x(2019)).attr("height", ih)
      .attr("fill", "#0A3A5C").attr("opacity", 0.03);

    // Línea histórica — dividida en pre/post gap
    const lineGen = d3.line()
      .defined(d => d.pct != null)
      .x(d => x(d.year)).y(d => y(d.pct))
      .curve(d3.curveMonotoneX);

    const pre = series.filter(s => s.year <= 2018);
    const post = series.filter(s => s.year >= 2022);

    [pre, post].forEach(seg => {
      const v = seg.filter(s => s.pct != null);
      if (v.length < 2) {
        // dibujamos un solo punto, o nada
        return;
      }
      g.append("path")
        .attr("d", lineGen(seg))
        .attr("fill", "none")
        .attr("stroke", entity.color)
        .attr("stroke-width", 1.5)
        .attr("stroke-linejoin", "round")
        .attr("stroke-linecap", "round");
    });

    const tt = makeTooltip(entity, gse);

    // Dots + value labels arriba / abajo (alternante para evitar choques)
    valid.forEach((s, i) => {
      const cx = x(s.year);
      const cy = y(s.pct);
      const isLowN = s.n_estab === 1;
      const opacity = isLowN ? 0.45 : 1;

      g.append("circle")
        .attr("cx", cx).attr("cy", cy)
        .attr("r", 2.2)
        .attr("fill", entity.color)
        .attr("opacity", opacity)
        .style("cursor", "pointer")
        .on("mouseenter", e => tt.show(e, s, s.year))
        .on("mouseleave", tt.hide);

      // valor sobre el punto (clamp para no salir del frame)
      const labelY = Math.max(8, cy - 6);
      g.append("text")
        .attr("x", cx).attr("y", labelY)
        .attr("text-anchor", "middle")
        .attr("font-family", "Museo Sans, sans-serif")
        .attr("font-size", 8.5)
        .attr("font-weight", 600)
        .attr("fill", entity.color)
        .attr("opacity", opacity * 0.9)
        .style("pointer-events", "none")
        .text(Math.round(s.pct) + "%");

      // año abajo
      g.append("text")
        .attr("x", cx).attr("y", ih + 13)
        .attr("text-anchor", "middle")
        .attr("font-family", "Museo Sans, sans-serif")
        .attr("font-size", 8)
        .attr("fill", "#747474")
        .text(s.year);

      // asterisco preliminar
      if (s.preliminar) {
        g.append("text")
          .attr("x", cx + 7).attr("y", labelY - 1)
          .attr("font-family", "Museo Sans, sans-serif")
          .attr("font-size", 9)
          .attr("font-weight", 900)
          .attr("fill", "var(--ocean)")
          .text("*");
      }
    });
  }, [entity.id, entity.color, entity.name, gse, nivel, prueba]);

  return <svg ref={ref} className="sparkline-svg" />;
}

// ============================================================
// Bar chart — últimas 3 aplicaciones, 100% apiladas
// ============================================================
function RecentBarsSubchart({ entity, gse, nivel, prueba, showElemInsuf, yScale, recentN = 3 }) {
  const ref = useRef(null);

  useEffect(() => {
    const svg = d3.select(ref.current);
    svg.selectAll("*").remove();

    const W = 320, H = 165;
    const M = { top: 14, right: 10, bottom: 24, left: 28 };
    const iw = W - M.left - M.right;
    const ih = H - M.top - M.bottom;

    const g = svg
      .attr("viewBox", `0 0 ${W} ${H}`)
      .attr("preserveAspectRatio", "xMidYMid meet")
      .append("g")
      .attr("transform", `translate(${M.left},${M.top})`);

    const series = SimceData.generateSeries({
      entityName: entity.name, gse, nivel, prueba,
    });
    // últimas N aplicaciones con datos
    const recent = series.filter(s => s.pct != null).slice(-recentN);

    // Y
    let yMax = 100;
    if (yScale === "auto" && !showElemInsuf) {
      const peak = d3.max(recent, d => d.pct) || 0;
      yMax = Math.min(100, Math.max(20, Math.ceil((peak + 8) / 10) * 10));
    }
    const y = d3.scaleLinear().domain([0, yMax]).range([ih, 0]);

    // gridlines
    const yTicks = [0, 25, 50, 75, 100].filter(v => v <= yMax);
    if (yMax !== 100 && !yTicks.includes(yMax)) yTicks.push(yMax);
    g.append("g")
      .selectAll("line")
      .data(yTicks)
      .join("line")
      .attr("x1", 0).attr("x2", iw)
      .attr("y1", d => y(d)).attr("y2", d => y(d))
      .attr("stroke", "#E7DFC9")
      .attr("stroke-dasharray", d => d === 0 ? "0" : "2,3")
      .attr("stroke-width", 1);

    // eje Y
    g.append("g")
      .call(
        d3.axisLeft(y)
          .tickValues(yTicks)
          .tickFormat(d => d + "%")
          .tickSize(0)
          .tickPadding(6)
      )
      .call(s => s.select(".domain").remove())
      .call(s => s.selectAll("text")
        .attr("font-family", "Museo Sans, sans-serif")
        .attr("font-size", 9.5)
        .attr("fill", "#747474"));

    // X
    const x = d3.scaleBand()
      .domain(recent.map(s => s.year))
      .range([0, iw])
      .padding(0.18);

    const tt = makeTooltip(entity, gse);

    // bars
    recent.forEach(s => {
      const xPos = x(s.year);
      if (xPos == null) return;
      const bw = x.bandwidth();
      const isLowN = s.n_estab === 1;
      const opacity = isLowN ? 0.45 : 1;

      // Elemental+Insuficiente: caja vacía con borde gris
      if (showElemInsuf && s.pct < 100) {
        const restTopY = y(Math.min(yMax, 100));
        const restBottomY = y(s.pct);
        const h = restBottomY - restTopY;
        if (h > 0) {
          g.append("rect")
            .attr("x", xPos + 0.5).attr("y", restTopY + 0.5)
            .attr("width", bw - 1).attr("height", h - 1)
            .attr("fill", REST_FILL)
            .attr("stroke", REST_BORDER)
            .attr("stroke-width", 1)
            .attr("opacity", opacity)
            .style("cursor", "pointer")
            .on("mouseenter", e => tt.show(e, s, s.year))
            .on("mouseleave", tt.hide);
        }
      }

      // Adecuado
      const yAdec = y(s.pct);
      const hAdec = ih - yAdec;
      g.append("rect")
        .attr("x", xPos).attr("y", yAdec)
        .attr("width", bw).attr("height", hAdec)
        .attr("fill", entity.color)
        .attr("opacity", opacity)
        .style("cursor", "pointer")
        .on("mouseenter", e => tt.show(e, s, s.year))
        .on("mouseleave", tt.hide);

      // etiqueta % dentro/sobre la barra entidad
      const insideMin = 22;
      let labelY, fill;
      if (hAdec > insideMin) {
        labelY = yAdec + 14;
        fill = "#FFFFFF";
      } else {
        labelY = yAdec - 4;
        fill = entity.color;
      }
      g.append("text")
        .attr("x", xPos + bw / 2)
        .attr("y", labelY)
        .attr("text-anchor", "middle")
        .attr("font-family", "Museo Sans, sans-serif")
        .attr("font-size", 12)
        .attr("font-weight", 700)
        .attr("fill", fill)
        .attr("opacity", isLowN ? 0.7 : 1)
        .style("pointer-events", "none")
        .text(fmtPctShort(s.pct));

      // año bajo eje X
      g.append("text")
        .attr("x", xPos + bw / 2)
        .attr("y", ih + 14)
        .attr("text-anchor", "middle")
        .attr("font-family", "Museo Sans, sans-serif")
        .attr("font-size", 10.5)
        .attr("font-weight", 500)
        .attr("fill", "#2E2230")
        .text(s.year);

      // asterisco preliminar 2025
      if (s.preliminar) {
        g.append("text")
          .attr("x", xPos + bw / 2).attr("y", -3)
          .attr("text-anchor", "middle")
          .attr("font-family", "Museo Sans, sans-serif")
          .attr("font-size", 13)
          .attr("font-weight", 900)
          .attr("fill", "var(--ocean)")
          .text("*");
      }
    });
  }, [entity.id, entity.color, entity.name, gse, nivel, prueba, showElemInsuf, yScale, recentN]);

  return <svg ref={ref} className="bars-svg" />;
}

// ============================================================
// ChartCell — compone los dos subgráficos
// ============================================================
function ChartCell(props) {
  const { gse } = props;
  return (
    <div className="chart-cell">
      <div className="chart-cell-head">
        <span className="chart-cell-eyebrow">GSE</span>
        <span className="chart-cell-title">{gse}</span>
      </div>

      <div className="sub-section">
        <span className="sub-eyebrow">Trayectoria histórica</span>
        <SparklineSubchart {...props} />
      </div>

      <div className="sub-section sub-section-bars">
        <span className="sub-eyebrow">Últimas 3 aplicaciones</span>
        <RecentBarsSubchart {...props} />
      </div>
    </div>
  );
}

Object.assign(window, { ChartCell, fmtPct, fmtPctShort, fmtInt });
