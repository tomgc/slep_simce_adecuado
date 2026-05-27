/* ============================================================
   Motor SIMCE — generador de datos sintéticos (mock)
   Datos plausibles pero aleatorios — solo para prueba visual.
   ============================================================ */

(function () {
  // --- años con brecha 2019-2021 (sin SIMCE) ---
  const YEARS = [2014, 2015, 2016, 2017, 2018, 2022, 2023, 2024, 2025];
  const GAP_YEARS = [2019, 2020, 2021];
  const GSE_LEVELS = ["Bajo", "Medio bajo", "Medio", "Medio alto", "Alto"];

  // GSE -> base pct adecuado (gradiente típico SIMCE)
  const GSE_BASE = {
    "Bajo": 10,
    "Medio bajo": 18,
    "Medio": 32,
    "Medio alto": 52,
    "Alto": 72,
  };

  // Prueba -> ligero offset (Lectura suele ser más alta que Matemática)
  const PRUEBA_OFFSET = { "Lectura": +3, "Matemática": -2 };
  // Nivel -> offset (2° Medio suele ser más bajo que 4° Básico)
  const NIVEL_OFFSET = { "4° Básico": +2, "2° Medio": -3 };

  // hash determinista a partir del nombre de entidad → seed
  function seedFrom(str) {
    let h = 2166136261 >>> 0;
    for (let i = 0; i < str.length; i++) {
      h ^= str.charCodeAt(i);
      h = Math.imul(h, 16777619) >>> 0;
    }
    return h;
  }
  // PRNG mulberry32
  function rng(seed) {
    let t = seed >>> 0;
    return function () {
      t = (t + 0x6D2B79F5) >>> 0;
      let r = Math.imul(t ^ (t >>> 15), 1 | t);
      r = (r + Math.imul(r ^ (r >>> 7), 61 | r)) ^ r;
      return ((r ^ (r >>> 14)) >>> 0) / 4294967296;
    };
  }

  // genera serie histórica para una entidad/GSE/nivel/prueba
  function generateSeries({ entityName, gse, nivel, prueba }) {
    const seed = seedFrom(`${entityName}|${gse}|${nivel}|${prueba}`);
    const r = rng(seed);

    // sesgo propio de la entidad (algunas comunas mejores que otras)
    const entityBias = (r() - 0.5) * 14;
    // tendencia: -3 a +5 puntos en el período
    const trend = -3 + r() * 8;

    // # de establecimientos por GSE para esta entidad
    // entidades con nombre tipo SLEP/Grupo tienden a tener más establecimientos
    const isGroup = /slep|grupo|costa|región/i.test(entityName);
    const estabBase = isGroup
      ? Math.max(2, Math.round(2 + r() * 18))
      : Math.max(1, Math.round(1 + r() * 6));

    const series = YEARS.map((year, i) => {
      const yearProgress = i / (YEARS.length - 1);
      const base = GSE_BASE[gse] + PRUEBA_OFFSET[prueba] + NIVEL_OFFSET[nivel];
      const noise = (r() - 0.5) * 8;
      const yearShock = year === 2022 ? -4 : 0; // shock post-pandemia
      let pct = base + entityBias + trend * yearProgress + noise + yearShock;
      pct = Math.max(0, Math.min(100, pct));

      // baja un poco la representatividad random en años específicos
      const nEstab = Math.max(1, estabBase + Math.round((r() - 0.5) * 4));
      const nEval = Math.round(nEstab * (25 + r() * 80));

      // 2025 = preliminar (lo marcamos en UI con asterisco)
      const preliminar = year === 2025;

      // ocasionalmente sin datos en años intermedios (rare)
      const missing = r() < 0.03 && year !== 2014 && year !== 2025;

      return {
        year,
        pct: missing ? null : Math.round(pct * 10) / 10,
        n_eval: missing ? null : nEval,
        n_estab: missing ? null : nEstab,
        preliminar,
      };
    });

    return series;
  }

  // API pública
  window.SimceData = {
    YEARS,
    GAP_YEARS,
    GSE_LEVELS,
    generateSeries,
    // lista canónica de comunas para el modal
    REGIONES: [
      {
        nombre: "Región de Valparaíso",
        comunas: [
          "Concón", "Puchuncaví", "Quintero", "Viña del Mar",
          "Valparaíso", "Quilpué", "Villa Alemana", "Casablanca",
          "San Antonio", "Cartagena", "El Quisco", "La Ligua",
        ],
      },
      {
        nombre: "Región Metropolitana",
        comunas: [
          "Santiago", "Providencia", "Las Condes", "Ñuñoa",
          "Maipú", "Puente Alto", "La Florida", "Peñalolén",
          "La Pintana", "Recoleta", "Independencia", "Cerrillos",
        ],
      },
      {
        nombre: "Región del Biobío",
        comunas: [
          "Concepción", "Talcahuano", "Chiguayante", "Hualpén",
          "Coronel", "Lota", "San Pedro de la Paz", "Penco",
        ],
      },
      {
        nombre: "Región de La Araucanía",
        comunas: [
          "Temuco", "Padre Las Casas", "Villarrica", "Pucón",
          "Angol", "Victoria", "Lautaro",
        ],
      },
    ],
    PRESETS: {
      "SLEP Costa Central": ["Concón", "Puchuncaví", "Quintero", "Viña del Mar"],
    },
  };
})();
