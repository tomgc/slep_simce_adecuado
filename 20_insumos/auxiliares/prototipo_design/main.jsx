/* ============================================================
   Motor SIMCE — main app + wiring
   ============================================================ */

function App() {
  const [nivel, setNivel] = React.useState("4° Básico");
  const [prueba, setPrueba] = React.useState("Lectura");
  const [entities, setEntities] = React.useState(INITIAL_ENTITIES);
  const [modal, setModal] = React.useState(null);
  const [loading, setLoading] = React.useState(false);
  const [notesOpen, setNotesOpen] = React.useState(false);
  const [t, setTweak] = useTweaks(TWEAK_DEFAULTS);

  // pseudo-loading al cambiar nivel/prueba
  const firstRender = React.useRef(true);
  React.useEffect(() => {
    if (firstRender.current) { firstRender.current = false; return; }
    setLoading(true);
    const id = setTimeout(() => setLoading(false), 420);
    return () => clearTimeout(id);
  }, [nivel, prueba]);

  // anotamos en cada entidad el nivel/prueba actual para que charts puedan generar
  const entitiesAnnotated = entities.map(e => ({
    ...e, _nivel: nivel, _prueba: prueba,
  }));

  function saveEntity(ent) {
    setEntities(prev => {
      const idx = prev.findIndex(p => p.id === ent.id);
      if (idx >= 0) {
        const next = [...prev];
        next[idx] = ent;
        return next;
      }
      if (prev.length >= 4) return prev;
      return [...prev, ent];
    });
    setModal(null);
  }

  function applyPreset() {
    // Preset SLEP Costa Central
    setEntities([
      { id: "slep1", name: "SLEP Costa Central", kind: "group",
        comunas: ["Concón", "Puchuncaví", "Quintero", "Viña del Mar"],
        color: "#0A3A5C" },
      { id: "ref1", name: "Comparable Valparaíso", kind: "comuna",
        comunas: ["Valparaíso"], color: "#C45A3E" },
      { id: "ref2", name: "Promedio región Valparaíso", kind: "group",
        comunas: ["Valparaíso","Quilpué","Villa Alemana","San Antonio","Casablanca"],
        color: "#1F4A1F" },
    ]);
  }

  const containerClass =
    "app " +
    (t.density === "compacta" ? "is-compact " : "is-comfy ");

  return (
    <div className={containerClass}>
      <Header />

      <main className="app-main">
        <ControlsBar
          nivel={nivel} setNivel={setNivel}
          prueba={prueba} setPrueba={setPrueba}
          loading={loading}
        />

        <EntitiesBar
          entities={entities}
          setEntities={setEntities}
          openModal={(ent) => setModal({ editing: ent })}
          openPresetMenu={applyPreset}
        />

        {/* ====== Sección grid entidades × GSE ====== */}
        <section className="results-section">
          <div className="results-head">
            <div>
              <span className="section-eyebrow">Resultados por GSE</span>
              <h2 className="results-title">
                % ponderado en nivel Adecuado — {prueba}, {nivel}
              </h2>
            </div>
            <div className="section-actions">
              <ChartHints showElemInsuf={t.showElemInsuf !== false} />
              <IconExport label="Exportar gráficos" icon="image" />
            </div>
          </div>

          <div
            className="supergrid"
            style={{ gridTemplateColumns: `repeat(${entities.length}, minmax(0, 1fr))` }}
          >
            {/* fila 0: nombres de entidad */}
            {entitiesAnnotated.map(ent => (
              <div key={ent.id} className="supergrid-entity-head">
                <span className="entity-swatch" style={{ background: ent.color }} />
                <span className="sg-ent-name">{ent.name}</span>
                <span className="sg-ent-meta">
                  {ent.kind === "group" ? `Grupo de ${ent.comunas.length} comunas` : "Comuna"}
                </span>
              </div>
            ))}

            {/* filas por GSE */}
            {SimceData.GSE_LEVELS.map(gse => (
              <React.Fragment key={gse}>
                {entitiesAnnotated.map(ent => (
                  <ChartCell
                    key={ent.id + "|" + gse}
                    entity={ent}
                    gse={gse}
                    showElemInsuf={t.showElemInsuf !== false}
                    yScale={t.yScale || "100"}
                    nivel={nivel}
                    prueba={prueba}
                  />
                ))}
              </React.Fragment>
            ))}
          </div>
        </section>

        {/* ====== Tabla ====== */}
        <section className="table-section">
          <div className="table-head">
            <div className="table-head-titles">
              <span className="section-eyebrow">Tabla de resultados</span>
              <h2 className="table-title">Entidad × GSE × Año</h2>
            </div>
            <div className="section-actions">
              <IconExport label="Exportar CSV" icon="download" />
            </div>
          </div>
          <HeatLegend />
          <ResultsTable entities={entities} nivel={nivel} prueba={prueba} />
          <div className="table-legend">
            <span><b className="dot dot-prelim">*</b> Dato preliminar 2025</span>
            <span>Formato: <code>XX,X% (N evaluados)</code> · — sin datos</span>
          </div>
        </section>

        {/* ====== Footer / notas metodológicas ====== */}
        <footer className="app-footer">
          <button
            className={"notes-toggle" + (notesOpen ? " is-open" : "")}
            onClick={() => setNotesOpen(!notesOpen)}
          >
            <Icon name="info" />
            <span>Notas metodológicas</span>
            <span className="chev"><Icon name="chevron" /></span>
          </button>
          {notesOpen && (
            <div className="notes-body">
              <div className="notes-grid">
                <article className="note">
                  <h4>Fórmula de agregación ponderada</h4>
                  <p>
                    Para cada entidad, GSE y año, el % en nivel Adecuado se calcula
                    como el promedio ponderado por número de estudiantes evaluados:
                  </p>
                  <code className="formula">
                    %adec = Σ(pct_estab × n_eval_estab) / Σ(n_eval_estab)
                  </code>
                  <p>
                    Para "grupos custom" (ej. un SLEP), la ponderación se aplica
                    sobre todos los establecimientos de las comunas seleccionadas.
                  </p>
                </article>
                <article className="note">
                  <h4>Regla GSE dinámico</h4>
                  <p>
                    El GSE de cada establecimiento se toma del año correspondiente.
                    <b> No se imputa entre años</b>: si un establecimiento cambia de
                    GSE entre 2018 y 2022, aparece en la categoría vigente cada año.
                  </p>
                </article>
                <article className="note">
                  <h4>Gap 2019–2021</h4>
                  <p>
                    La prueba SIMCE no se aplicó en 2019, 2020 ni 2021 debido al
                    estallido social y la pandemia. En los gráficos aparece una banda
                    sombreada y las líneas no se conectan a través del gap.
                  </p>
                </article>
                <article className="note">
                  <h4>Datos preliminares 2025</h4>
                  <p>
                    Los resultados de 2025 son <b>preliminares</b> y están sujetos a
                    revisión por la Agencia de Calidad de la Educación. Se marcan con
                    asterisco (*) en todos los gráficos y tablas.
                  </p>
                </article>
              </div>
              <div className="notes-sources">
                <span>
                  Fuente: Agencia de Calidad de la Educación · Bases SIMCE 2014–2025.
                  Procesamiento: equipo de análisis Mineduc.
                </span>
              </div>
            </div>
          )}
        </footer>
      </main>

      {modal && (
        <AddEntityModal
          editing={modal.editing}
          takenColors={entities.map(e => e.color)}
          onSave={saveEntity}
          onCancel={() => setModal(null)}
        />
      )}

      <TweaksPanel title="Tweaks">
        <TweakSection label="Visualización" />
        <TweakToggle
          label="Mostrar Elemental + Insuficiente"
          value={t.showElemInsuf !== false}
          onChange={v => setTweak("showElemInsuf", v)}
        />
        <TweakRadio
          label="Escala Y"
          value={t.yScale || "100"}
          options={[
            { value: "100", label: "Fijo 0–100%" },
            { value: "auto", label: "Auto" },
          ]}
          onChange={v => setTweak("yScale", v)}
        />
        <TweakSection label="Apariencia" />
        <TweakRadio
          label="Densidad"
          value={t.density}
          options={[
            { value: "comoda", label: "Cómoda" },
            { value: "compacta", label: "Compacta" },
          ]}
          onChange={v => setTweak("density", v)}
        />
        <TweakSection label="Acciones rápidas" />
        <TweakButton
          label="Preset SLEP Costa Central"
          onClick={applyPreset}
        />
        <TweakButton
          label="Restablecer (4 comunas seed)"
          onClick={() => setEntities(INITIAL_ENTITIES)}
        />
      </TweaksPanel>
    </div>
  );
}

// Hints inline cerca del título de gráficos — reemplaza la antigua leyenda
function ChartHints({ showElemInsuf }) {
  return (
    <div className="chart-hints">
      {showElemInsuf && (
        <span className="hint-item">
          <span className="hint-empty-box" />
          <span>Elemental + Insuficiente</span>
        </span>
      )}
      <span className="hint-item hint-muted">
        <span className="hint-low-n" />
        <span>Baja representatividad (un solo establecimiento)</span>
      </span>
      <span className="hint-item hint-muted">
        <span className="hint-asterisk">*</span>
        <span>2025 preliminar</span>
      </span>
    </div>
  );
}

// botón exportar icon-only con label en hover
function IconExport({ label, icon }) {
  return (
    <button className="icon-export" title={label} aria-label={label}>
      <Icon name={icon} />
      <span className="icon-export-label">{label}</span>
    </button>
  );
}

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<App />);
