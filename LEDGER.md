# LEDGER — what one-pack-per-stratum found PrologAI still lacks

**This Ledger is the deliverable.** connectome-strata is the STRATA arm — the
finale — of the Wave 3 granularity experiment (see `WAVE_3_DESIGN_v1.txt`). It
re-decomposes the Wave 2 slice under one rule — **one pack per Causalontology
stratum** — holding the behaviour, the twenty-eight Causalontology 3.0.0 records,
the dynamics, and the closure mechanism constant. This arm is the interesting one
because the stratum is already a first-class kind in the DATA layer, so it tests
a sharp question: **is the data layer's own level boundary also the right CODE
boundary?** The answer is a qualified YES with a clean seam — and the
qualifications are the entries below.

## Identifier scheme

Entries use a fresh **STRATA-series (STRATA-1, STRATA-2, …)**, so a finding here
can never be confused with the spike's **L1–L9**, PrologAI's **L-series and
N1–N5**, the slice's **P1–P10**, the atomic arm's **ATOMIC-1…7**, or the loops
arm's **LOOPS-1…4**. Second sightings cite their parent by its own id. Severity
`S` uses the spike's H/M/L scale.

## The headline result, stated first (because it is positive)

Cutting by stratum aligned the code with the data layer in two concrete,
measurable ways, and this must be stated plainly:

- **The layer order fell out of the stratum ordinals.** The five stratum packs
  take pack layers 2–6 tracking the Causalontology ordinals 4, 6, 7, 9, 14
  (macromolecular < cellular < synaptic < region < community). Every dependency
  edge runs COARSE-imports-FINE (higher ordinal imports lower), which is a
  DOWNWARD layer edge, so the strict layer rule passed with zero violations and
  the ordinal order and the layer order AGREE.
- **The ten-stratum cortisol SKIP is the cleanest edge in the whole arm.** The
  skip runs from community (ordinal 14) to macromolecular (ordinal 4); the
  community_stratum pack owns the skip CRO and imports macromolecular_stratum
  downward for the effect occurrent. High-ordinal → low-ordinal is exactly a
  downward layer edge, so the layer-skipping channel — the construct the slice's
  P1/P2 found hardest — is here the most NATURAL cross-pack reference of all.

That alignment is real, not merely tidy. What it does NOT do is come for free or
cover every construct — which is what the findings record.

---

### STRATA-1 — the loop's three regions are CO-STRATAL, so one-pack-per-stratum does not separate them · S=M

- **Construct that forced it.** The three regions of the reentrant loop.
- **What PrologAI could not express / what the cut revealed.** The design
  expected the regions to sit at DIFFERENT levels, making the closure cross-pack
  as in the atomic arm. The slice's DATA says otherwise: cortex, striatum,
  thalamus (and the substantia nigra) are ALL brain regions at ordinal 9. So
  one-pack-per-stratum places all three region RUNTIMES in ONE region_stratum
  pack, as internal sections — the reentrant loop is INTRA-pack (as in the loops
  arm), not cross-pack. The loop is SINGLE-STRATUM at runtime; only the STRUCTURE
  (the synaptic occurrents, the community→macromolecular skip) crosses strata.
  The stratum boundary aligns with the data's cross-level structure but NOT with
  the runtime loop, which lives entirely at one level.
- **Evidence.** `packs/region_stratum/prolog/region_stratum.pl` holds
  `region_stratum_cortex_tick/1`, `region_stratum_striatum_tick/1`,
  `region_stratum_thalamus_tick/1` as three `INTERNAL REGION MODULE` sections;
  `bin/check_no_coupling.sh` does intra-pack section analysis, as in the loops arm.
- **Proposed remedy (minimum).** Recognise (in the connectome's design) that the
  runtime loop and the structural strata are DIFFERENT decompositions — a loop is
  a single-stratum runtime object even when the structure it manipulates spans
  strata; no one code cut captures both.
- **Parents.** New. Shares the intra-pack section mechanism with LOOPS-1/2/3.

### STRATA-2 — cross-stratal constructs have no single-stratum home · S=H

- **Construct that forced it.** The PORTS, the two CONDUITS, the BRIDGE, and the
  skipping cortisol CRO.
- **What PrologAI could not express.** A stratum pack is a clean home for a
  construct that SITS AT one level — a stratum record, an occurrent with a
  `stratum` field, a same-level CRO. But a large family of Causalontology kinds
  SPAN levels by their very definition: a port bridges a bearer to a signal, a
  conduit joins two regions carrying a lower-level signal, a bridge relates a
  coarse occurrent to finer ones, and a skipping CRO crosses ten strata. These
  have NO single stratum, so one-pack-per-stratum must ASSIGN them arbitrarily.
  The Causalontology kinds therefore split into stratum-LOCAL (stratum,
  occurrent, same-level CRO) and stratum-SPANNING (port, conduit, bridge, skip),
  and the pack-per-stratum rule fits only the former. PrologAI/Causalontology
  offers no notion of a construct that belongs to an EDGE between strata rather
  than to a stratum, so the spanning constructs pile into whichever stratum pack
  the assignment rule picks (here: the COARSER stratum they touch — see STRATA-3).
- **Evidence.** All four ports, both conduits, and the bridge are minted in
  `packs/region_stratum/prolog/region_stratum.pl` (the coarser, region stratum),
  each reaching DOWN to `synaptic_stratum` for the finer occurrent it references;
  the skip CRO is in `community_stratum` reaching down to `macromolecular_stratum`.
- **Proposed remedy (minimum).** A first-class notion of a cross-stratal (edge)
  construct with a HOME rule — e.g. "a spanning construct belongs to the coarsest
  stratum it touches" made explicit and checkable — so the assignment is a
  language rule, not a per-arm convention.
- **Parents.** New. The central finding of the strata arm; it is why grounding
  fit is high for LOCAL constructs and undefined for SPANNING ones.

### STRATA-3 — nothing BINDS a pack's layer to its stratum ordinal (the alignment is by hand) · S=M

- **Construct that forced it.** The pack `layer(N)` declaration versus the
  Causalontology stratum `ordinal`.
- **What PrologAI could not express.** These are two DIFFERENT numbering systems:
  the pack layer (a code-dependency coordinate) and the stratum ordinal (a
  data-layer level coordinate). This arm MADE them agree — layer = rank of
  ordinal — and the agreement is useful (STRATA headline: free layer order,
  natural skip). But the agreement is maintained BY HAND: each `pack.pl` sets
  `layer(N)` to a number I computed from the ordinal, and NOTHING checks that the
  pack's declared layer actually matches the ordinal of the stratum record it
  mints. A pack could mint the ordinal-14 community stratum and declare `layer(2)`
  and no tool would object. The alignment that is this arm's whole point is
  invisible to the language. Note too that the agreement is only PARTLY forced:
  the real edges (region→synaptic, community→macromolecular) confirm the
  coarse-imports-fine direction, but isolated strata (cellular, imported by
  nobody) have a free layer choice — the ordinal supplies a convention, not a
  constraint, for them.
- **Evidence.** `packs/community_stratum/pack.pl` declares `layer(6)` while its
  module mints the ordinal-14 stratum; the two numbers are related only by a
  comment. `packs/cellular_stratum/pack.pl` declares `layer(3)` though no edge
  forces any particular layer.
- **Proposed remedy (minimum).** Let a pack declare `layer(stratum(Ordinal))` (or
  a checked mapping) so the layer construct can DERIVE and VERIFY the pack layer
  from the stratum ordinal, binding the code coordinate to the data coordinate.
- **Parents.** A facet of the layer construct **L4**; the data-layer-alignment
  case L4 was never asked to cover.

### STRATA-4 — one-pack-per-stratum produces wildly uneven packs · S=L

- **Construct that forced it.** The cellular stratum (empty) versus the region
  stratum (heavy).
- **What PrologAI could not express / what the cut revealed.** The anatomy is not
  evenly distributed across the levels, so cutting by stratum makes packs of
  wildly uneven weight: `cellular_stratum` owns ONE record (its own stratum
  definition — the slice names the cellular level but populates it with nothing),
  while `region_stratum` owns FOURTEEN records plus the entire runtime. A stratum
  the data layer NAMES but the slice does not POPULATE still costs a whole pack
  under this rule, and the coarse strata (region) become catch-alls for every
  spanning construct (STRATA-2).
- **Evidence.** `packs/cellular_stratum/` (1 record) beside `packs/region_stratum/`
  (14 records + 3 runtime sections).
- **Proposed remedy (minimum).** None at the language level — this is an inherent
  property of the rule, recorded so the Wave 3 verdict can weigh it: pack EVENNESS
  is not a property one-pack-per-stratum provides.
- **Parents.** New. A COMPARISON-level observation promoted to a finding.

### STRATA-5 — the structure↔dynamics seam persists, because the native dynamics have no stratum (P1, second sighting) · S=M

- **Construct that forced it.** CORTISOL — its structure at the community
  stratum, its dynamics nowhere in the strata.
- **What PrologAI could not express.** The slice's **P1** found PrologAI has no
  construct binding a hormone's structural record to its dynamical law. One might
  hope the stratum cut would heal that seam by co-locating a construct's structure
  and dynamics in its stratum pack. It CANNOT: the native dynamics (dopamine RPE,
  cortisol suppression, three-factor plasticity) are — correctly, per the
  GROUNDING RULE — NOT grounded and so have NO stratum, so they cannot live in a
  stratum pack at all. They sit in the un-stratified `neurochemistry` substrate,
  while cortisol's structural skip CRO sits in `community_stratum`. The seam P1
  named is not only unhealed but STRUCTURALLY unavoidable under one-pack-per-
  stratum: structure is stratified, dynamics are not, so they can never share a
  stratum pack. **Second sighting, sharpened.**
- **Evidence.** Cortisol's structure: `packs/community_stratum/prolog/community_stratum.pl`
  (the skip CRO). Cortisol's dynamics: `packs/neurochemistry/prolog/neurochemistry.pl`
  (`neurochemistry_cortisol_suppression/2`) — a different pack in a different
  band, with nothing binding them.
- **Parents.** Confirms **P1** (Wave 2 slice; also L5 / N4). NOTE: this arm also
  re-touches **P5** (its own `check_layers.sh` wrapper) and **ATOMIC-4** (the
  region_stratum pack co-locates structure with runtime, so the runner must load
  `causal_core` and the validator must load `library(lattice)`), but both are
  known and are noted rather than re-numbered.

---

## What did NOT become a finding (honesty)

- The behaviour held EXACTLY: the narrated trace is byte-identical to the slice's
  and both prior arms', proven by `diff`. The three co-stratal regions coordinated
  only through the Lattice (STRATA-1), and `check_no_coupling.sh` confirms it and
  catches an injected cross-region call, so it is not vacuous.
- The twenty-eight records are byte-identical to the slice's, proven by
  regenerating `structure/` from the five stratum packs and `diff`-ing — every
  content-addressed id matched, so distributing the minting BY STRATUM cost the
  data nothing.
- The layer rule passed with ZERO violations and — the arm's positive result —
  the pack layers TRACK the stratum ordinals, with the ten-stratum skip as the
  cleanest downward edge. The data layer's boundary really can be the code
  boundary for stratum-LOCAL constructs.

This Ledger is neither thin nor padded: five entries that together answer the
arm's question honestly. Cutting by stratum is the BEST of the three arms at
grounding fit — the layer order and the skip come almost for free — but it does
NOT cover the stratum-SPANNING constructs (STRATA-2), does NOT separate the
co-stratal loop (STRATA-1), does NOT bind the two numbering systems in the
language (STRATA-3), produces uneven packs (STRATA-4), and cannot heal the
structure↔dynamics seam because dynamics have no stratum at all (STRATA-5). The
full side-by-side, three-way measurement is in [`COMPARISON.md`](COMPARISON.md).
