/* ============================================================
   Motor SIMCE — App principal (controles, entidades, modal)
   ============================================================ */

const { useState, useEffect, useRef, useMemo } = React;

// Paleta de entidades — híbrido Set2 ajustado para armonizar con plum/cream
// Incluye los colores de referencia del usuario.
const ENTITY_PALETTE = [
  "#0A3A5C", // azul oscuro institucional (SLEP Costa Central)
  "#C45A3E", // terracotta (coral oscuro)
  "#1F4A1F", // verde oscuro
  "#8A5A8E", // ciruela media
  "#B89530", // mostaza ámbar
  "#4A6FA5", // azul pizarra
  "#A35A6F", // rosa polvo
  "#5C8A6E", // sage
];

// Estado inicial: las 4 comunas seed (SLEP Costa Central)
const INITIAL_ENTITIES = [
  { id: "e1", name: "Concón", kind: "comuna", comunas: ["Concón"], color: ENTITY_PALETTE[0] },
  { id: "e2", name: "Puchuncaví", kind: "comuna", comunas: ["Puchuncaví"], color: ENTITY_PALETTE[1] },
  { id: "e3", name: "Quintero", kind: "comuna", comunas: ["Quintero"], color: ENTITY_PALETTE[2] },
  { id: "e4", name: "Viña del Mar", kind: "comuna", comunas: ["Viña del Mar"], color: ENTITY_PALETTE[3] },
];

const TWEAK_DEFAULTS = /*EDITMODE-BEGIN*/{
  "density": "comoda",
  "showElemInsuf": true,
  "yScale": "100"
}/*EDITMODE-END*/;

// =================================================================
// Header — banner azul institucional, sin exportar (esos van junto a cada sección)
// =================================================================
function Header() {
  return (
    <header className="app-header">
      <div className="app-header-inner">
        <div className="app-header-left">
          <div className="brand-lockup">
            <span className="brand-eyebrow">Agencia de Calidad de la Educación</span>
            <span className="brand-divider">·</span>
            <span className="brand-eyebrow brand-eyebrow-muted">Mineduc</span>
          </div>
          <h1 className="app-title">
            Motor de comparación SIMCE
            <span className="app-title-sub"> — % ponderado en nivel Adecuado</span>
          </h1>
          <p className="app-subtitle">
            Datos 2014–2025 · Resultados segmentados por grupo socioeconómico (GSE)
          </p>
        </div>
      </div>
    </header>
  );
}

// =================================================================
// Controles (barra)
// =================================================================
function ControlsBar({ nivel, setNivel, prueba, setPrueba, loading }) {
  return (
    <section className="controls-bar">
      <div className="control-group">
        <span className="control-label">Nivel</span>
        <Segmented
          value={nivel}
          options={["4° Básico", "2° Medio"]}
          onChange={setNivel}
        />
      </div>
      <div className="control-group">
        <span className="control-label">Prueba</span>
        <Segmented
          value={prueba}
          options={["Lectura", "Matemática"]}
          onChange={setPrueba}
        />
      </div>
      <div className="controls-spacer" />
      {loading && (
        <div className="loading-pill">
          <span className="loading-dot" />
          <span>Recalculando…</span>
        </div>
      )}
    </section>
  );
}

function Segmented({ value, options, onChange }) {
  const opts = options.map(o =>
    typeof o === "string" ? { value: o, label: o } : o
  );
  return (
    <div className="segmented" role="tablist">
      {opts.map(o => (
        <button
          key={o.value}
          role="tab"
          aria-selected={value === o.value}
          className={"segmented-btn" + (value === o.value ? " is-active" : "")}
          onClick={() => onChange(o.value)}
        >
          {o.label}
        </button>
      ))}
    </div>
  );
}

// =================================================================
// Sección Entidades
// =================================================================
function EntitiesBar({ entities, setEntities, openModal, openPresetMenu }) {
  function removeEntity(id) {
    setEntities(entities.filter(e => e.id !== id));
  }
  return (
    <section className="entities-bar">
      <div className="entities-head">
        <h2 className="section-eyebrow">Entidades a comparar</h2>
        <span className="entities-count">
          {entities.length} de 4 activas
        </span>
      </div>
      <div className="entities-list">
        {entities.map(e => (
          <EntityChip
            key={e.id}
            entity={e}
            onRemove={() => removeEntity(e.id)}
            onEdit={() => openModal(e)}
          />
        ))}
        {entities.length < 4 && (
          <div className="entities-actions">
            <button className="btn btn-primary" onClick={() => openModal(null)}>
              <Icon name="plus" /> Agregar entidad
            </button>
            <button className="btn btn-ghost btn-small" onClick={openPresetMenu}>
              <Icon name="layers" /> Preset SLEP
            </button>
          </div>
        )}
      </div>
    </section>
  );
}

function EntityChip({ entity, onRemove, onEdit }) {
  const isGroup = entity.kind === "group";
  return (
    <div className="entity-chip">
      <span className="entity-swatch" style={{ background: entity.color }} />
      <span className="entity-text">
        <span className="entity-name">{entity.name}</span>
        <span className="entity-meta">
          {isGroup
            ? `Grupo · ${entity.comunas.length} comunas`
            : "Comuna"}
        </span>
      </span>
      <button className="entity-btn" onClick={onEdit} title="Editar">
        <Icon name="edit" />
      </button>
      <button className="entity-btn entity-btn-remove" onClick={onRemove} title="Eliminar">
        <Icon name="x" />
      </button>
    </div>
  );
}

// =================================================================
// Modal — Agregar / editar entidad
// =================================================================
function AddEntityModal({ editing, onSave, onCancel, takenColors }) {
  const [tab, setTab] = useState(editing?.kind === "group" ? "group" : "comuna");
  const [region, setRegion] = useState(SimceData.REGIONES[0].nombre);
  const [comuna, setComuna] = useState(editing?.kind === "comuna" ? editing.name : "");
  const [groupName, setGroupName] = useState(editing?.kind === "group" ? editing.name : "");
  const [groupComunas, setGroupComunas] = useState(
    editing?.kind === "group" ? editing.comunas : []
  );
  const [search, setSearch] = useState("");

  const availableColor = useMemo(() => {
    return ENTITY_PALETTE.find(c => !takenColors.includes(c)) || ENTITY_PALETTE[0];
  }, [takenColors]);

  function handleSave() {
    if (tab === "comuna") {
      if (!comuna) return;
      onSave({
        id: editing?.id || ("e" + Date.now()),
        name: comuna,
        kind: "comuna",
        comunas: [comuna],
        color: editing?.color || availableColor,
      });
    } else {
      if (!groupName || groupComunas.length === 0) return;
      onSave({
        id: editing?.id || ("e" + Date.now()),
        name: groupName,
        kind: "group",
        comunas: groupComunas,
        color: editing?.color || availableColor,
      });
    }
  }

  const currentRegion = SimceData.REGIONES.find(r => r.nombre === region);
  const allComunas = SimceData.REGIONES.flatMap(r =>
    r.comunas.map(c => ({ comuna: c, region: r.nombre }))
  );
  const filtered = allComunas.filter(({ comuna }) =>
    comuna.toLowerCase().includes(search.toLowerCase())
  );

  return (
    <div className="modal-backdrop" onClick={onCancel}>
      <div className="modal" onClick={e => e.stopPropagation()}>
        <div className="modal-header">
          <h3 className="modal-title">
            {editing ? "Editar entidad" : "Agregar entidad"}
          </h3>
          <button className="icon-btn" onClick={onCancel} aria-label="Cerrar">
            <Icon name="x" />
          </button>
        </div>

        <div className="modal-tabs">
          <button
            className={"modal-tab" + (tab === "comuna" ? " is-active" : "")}
            onClick={() => setTab("comuna")}
          >
            Comuna individual
          </button>
          <button
            className={"modal-tab" + (tab === "group" ? " is-active" : "")}
            onClick={() => setTab("group")}
          >
            Grupo custom (ej. SLEP)
          </button>
        </div>

        <div className="modal-body">
          {tab === "comuna" ? (
            <div className="form-grid">
              <label className="field">
                <span className="field-label">Región</span>
                <select className="select" value={region} onChange={e => { setRegion(e.target.value); setComuna(""); }}>
                  {SimceData.REGIONES.map(r => (
                    <option key={r.nombre} value={r.nombre}>{r.nombre}</option>
                  ))}
                </select>
              </label>
              <label className="field">
                <span className="field-label">Comuna</span>
                <select className="select" value={comuna} onChange={e => setComuna(e.target.value)}>
                  <option value="">Selecciona una comuna…</option>
                  {currentRegion.comunas.map(c => (
                    <option key={c} value={c}>{c}</option>
                  ))}
                </select>
              </label>
              <div className="field field-full">
                <span className="field-label">Color asignado</span>
                <div className="color-preview">
                  <span className="entity-swatch" style={{ background: editing?.color || availableColor }} />
                  <span className="color-note">
                    Asignado automáticamente desde la paleta de la herramienta.
                  </span>
                </div>
              </div>
            </div>
          ) : (
            <div className="form-grid">
              <label className="field field-full">
                <span className="field-label">Nombre del grupo</span>
                <input
                  className="input"
                  type="text"
                  placeholder="Ej. SLEP Atacama, Mi grupo de control…"
                  value={groupName}
                  onChange={e => setGroupName(e.target.value)}
                />
              </label>
              <label className="field field-full">
                <span className="field-label">
                  Comunas en el grupo
                  <span className="field-hint">{groupComunas.length} seleccionadas</span>
                </span>
                <input
                  className="input input-search"
                  type="text"
                  placeholder="Buscar comuna…"
                  value={search}
                  onChange={e => setSearch(e.target.value)}
                />
                <div className="comuna-checklist">
                  {filtered.map(({ comuna, region }) => (
                    <label key={comuna} className="check-row">
                      <input
                        type="checkbox"
                        checked={groupComunas.includes(comuna)}
                        onChange={e => {
                          if (e.target.checked) setGroupComunas([...groupComunas, comuna]);
                          else setGroupComunas(groupComunas.filter(c => c !== comuna));
                        }}
                      />
                      <span className="check-name">{comuna}</span>
                      <span className="check-region">{region}</span>
                    </label>
                  ))}
                  {filtered.length === 0 && (
                    <div className="empty-state">Sin resultados para "{search}"</div>
                  )}
                </div>
              </label>
            </div>
          )}
        </div>

        <div className="modal-footer">
          <button className="btn btn-ghost" onClick={onCancel}>Cancelar</button>
          <button className="btn btn-primary" onClick={handleSave}>
            {editing ? "Guardar cambios" : "Agregar al análisis"}
          </button>
        </div>
      </div>
    </div>
  );
}

// =================================================================
// Iconos (Lucide-style inline SVG)
// =================================================================
function Icon({ name }) {
  const paths = {
    plus: <><line x1="12" y1="5" x2="12" y2="19" /><line x1="5" y1="12" x2="19" y2="12" /></>,
    x: <><line x1="18" y1="6" x2="6" y2="18" /><line x1="6" y1="6" x2="18" y2="18" /></>,
    edit: <><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" /><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" /></>,
    download: <><path d="M21 15v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4" /><polyline points="7 10 12 15 17 10" /><line x1="12" y1="15" x2="12" y2="3" /></>,
    image: <><rect x="3" y="3" width="18" height="18" rx="2" ry="2" /><circle cx="8.5" cy="8.5" r="1.5" /><polyline points="21 15 16 10 5 21" /></>,
    layers: <><polygon points="12 2 2 7 12 12 22 7 12 2" /><polyline points="2 17 12 22 22 17" /><polyline points="2 12 12 17 22 12" /></>,
    chevron: <><polyline points="6 9 12 15 18 9" /></>,
    info: <><circle cx="12" cy="12" r="10" /><line x1="12" y1="16" x2="12" y2="12" /><line x1="12" y1="8" x2="12.01" y2="8" /></>,
  };
  return (
    <svg className="icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2" strokeLinecap="round" strokeLinejoin="round">
      {paths[name]}
    </svg>
  );
}

Object.assign(window, {
  Header, ControlsBar, EntitiesBar, AddEntityModal, Icon,
  INITIAL_ENTITIES, ENTITY_PALETTE, TWEAK_DEFAULTS,
});
