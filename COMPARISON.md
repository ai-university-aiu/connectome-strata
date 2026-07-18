# COMPARISON — connectome-strata (Wave 3c, the strata arm)

The Wave 3 granularity experiment tests ONE variable: **how big should a
code-pack be?** This arm's answer is **one pack per Causalontology stratum** —
the cut that aligns the code boundary with the data layer's own level boundary.
Every number below is argued from the built code and stated against BOTH prior
arms (atomic, the control; loops, the coarse arm), so the three-way Wave 3 table
writes itself. The invariant (behaviour, the twenty-eight records, the dynamics,
the closure mechanism, the platform) was held constant and is proven so: the
narrated trace and all twenty-eight records are byte-identical to the Wave 2 slice.

## Rubric at a glance (three-way)

| # | Rubric question | atomic | loops | **strata (this arm)** |
|---|---|---|---|---|
| 1 | Pack count (slice / projected) | 11 / ~143 | 4 / ~23 | **8 / 15** |
| 2 | Change locality (retune dopamine) | 1, isolated | 1, coarse | **1, coarse (dynamics are un-stratified)** |
| 3 | Coupling (intra-repo edges) | 29/11 (2.6, superlinear) | 2/4 (0.5, linear) | **9/8 (1.1, in between)** |
| 4 | Layer-rule pressure | 6 levels, 0 viol | 3 levels, 0 viol, hides hierarchy | **7 levels, 0 viol, layer = stratum ordinal (free)** |
| 5 | Testability | dynamics isolate | regions not isolable | **leaf strata isolate; the region stratum does not** |
| 6 | Grounding fit | low (cut across kinds) | low (all kinds in one pack) | **HIGHEST — pack = stratum, for the LOCAL constructs** |
| 7 | Ergonomics / new gaps | 4 new + 3 second | 3 new + 1 second | **5 (incl. P1 second sighting)** |
| 8 | Scale verdict | best locality; ceremony + interface coupling | leanest; cost inside the pack | **best grounding fit; spanning constructs + uneven packs hurt** |

## 1. Pack count

**Actual at the slice: 8 packs** — three substrate (`neural_lattice`,
`causal_grounding`, `neurochemistry`) plus five stratum packs, one per stratum the
slice touches: `macromolecular_stratum` (ordinal 4), `cellular_stratum` (6),
`synaptic_stratum` (7), `region_stratum` (9), `community_stratum` (14). That is a
MIDDLE number — more than loops's 4, fewer than atomic's 11 — exactly as the
design predicted for a per-stratum cut.

**Two deliberate substrate decisions** (recorded per the order): the closure
(`neural_lattice`) and the minting vocabulary (`causal_grounding`) are NOT "at a
stratum," so they form a base band beneath the strata; and the native DYNAMICS
(`neurochemistry`) have NO stratum at all (the grounding rule keeps them native
and ungrounded), so they too are substrate, not a stratum pack — a decision with
consequences (STRATA-5).

**Projected to a full connectome: 15 packs** — one per layer of abstraction, plus
the small fixed substrate. The projection is linear in STRATA, and the count is
FIXED by the data layer (the connectome has fifteen strata), which is this arm's
distinctive property: the pack count is not a code choice, it is the number of
levels the anatomy has.

## 2. Change locality — retune dopamine

**One pack (`neurochemistry`), coarse.** Because dopamine is native DYNAMICS and
the dynamics have no stratum, a dopamine retune edits `neurochemistry` — one
pack, but the coarse substrate pack that also holds cortisol and plasticity (the
loops situation, not atomic's isolation). Structure changes DO localise well
(editing the synaptic stratum's records touches only `synaptic_stratum`), but a
region-runtime change edits the heavy `region_stratum` pack (all three regions +
fourteen records). So strata's change locality is SPLIT: excellent for a single
stratum's structure, coarse for dynamics and for the region runtime. It matches
loops on the dopamine question specifically and beats it for stratum-local
structure edits.

## 3. Coupling and how it grows

Measured intra-repo import edges:

```
neural_lattice          0     macromolecular_stratum  1
causal_grounding        0     cellular_stratum        1
neurochemistry          0     synaptic_stratum        1
                              region_stratum          4  (causal_grounding, synaptic_stratum, neural_lattice, neurochemistry)
                              community_stratum        2  (causal_grounding, macromolecular_stratum — the SKIP)
                              TOTAL                    9 edges / 8 packs
```

**Nine edges / eight packs (1.1/pack)** sits squarely between loops (0.5) and
atomic (2.6). The leaf stratum packs each import only the minting vocabulary (1
edge); the coupling concentrates in the two packs that hold spanning constructs —
`region_stratum` (imports the synaptic stratum for the occurrent ids its ports,
conduits and bridge reference) and `community_stratum` (imports the macromolecular
stratum for the SKIP). Growth is roughly linear in strata plus the spanning
references — better than atomic's superlinear interface explosion, and every
cross-pack edge is a DOWNWARD (coarse-imports-fine) edge that the layer rule
blesses.

## 4. Layer-rule pressure — where strata shines

This is the arm's standout result. The strict layer rule passed with ZERO
violations across 7 levels, AND — uniquely — the pack layers TRACK the
Causalontology stratum ordinals:

```
layer 0  neural_lattice, causal_grounding      (substrate)
layer 1  neurochemistry                         (un-stratified dynamics)
layer 2  macromolecular_stratum  (ordinal 4)
layer 3  cellular_stratum        (ordinal 6)
layer 4  synaptic_stratum        (ordinal 7)
layer 5  region_stratum          (ordinal 9)
layer 6  community_stratum        (ordinal 14)
```

Pack layer = rank of stratum ordinal + 1. Every real dependency edge runs
coarse-imports-fine (region→synaptic, community→macromolecular), which is
downward, so the ordinal order and the layer order AGREE and the layer rule falls
out of the data layer's ordinals essentially for free. The atomic arm's 6 layers
and the loops arm's 3 are code-only coordinates that mean nothing in the data
layer; strata's 7 layers ARE the stratum ordinals. The one caveat (STRATA-3):
nothing in PrologAI BINDS the pack layer to the stratum ordinal — the agreement
is maintained by hand and unchecked — and isolated strata (cellular) have a free
layer choice the ordinal only conventionally fixes.

## 5. Testability

Split, and instructively so. The leaf stratum packs (`macromolecular_stratum`,
`cellular_stratum`, `synaptic_stratum`) isolate cleanly — you can mint and
validate the synaptic level's records without loading any region or dynamics.
But the `region_stratum` pack, holding all three co-stratal regions plus fourteen
records, does NOT let you exercise ONE region alone (the loops problem, STRATA-1),
and — because it co-locates structure with runtime — testing its structure drags
in the Lattice (the atomic problem, ATOMIC-4 second sighting). So strata is BETTER
than loops (three of five stratum packs isolate) and WORSE than atomic (its
heaviest pack fuses runtime and structure across three regions).

## 6. Grounding fit — highest by construction; measure what it buys

By design this arm should score highest on grounding fit, and it does: the pack
boundary IS a Causalontology kind (the stratum), so each stratum pack owns exactly
the constructs stamped at its level. **What the alignment BUYS is concrete, not
merely tidy:** the layer order comes free from the ordinals (rubric 4), the
ten-stratum SKIP is the cleanest downward edge in the arm (the construct the
slice's P1/P2 found hardest is here the most natural), and structure minting
localises by level.

**But the alignment is PARTIAL.** It fits the stratum-LOCAL constructs (strata,
occurrents, same-level CROs) perfectly and has NO home for the stratum-SPANNING
constructs (ports, conduits, bridge, skip CRO), which by their Causalontology kind
belong to an EDGE between strata, not a stratum (STRATA-2). Those pile into the
coarser stratum pack by an assignment rule the language does not provide. So the
honest measure: cutting by stratum genuinely reduces seams and buys a free layer
order for the ~two-thirds of constructs that sit at a level, and leaves the
spanning ~third homeless. Neither atomic (cut across kinds) nor loops (all kinds
in one pack) aligns with the kinds at all; strata aligns with the stratum kind and
reveals that the kinds themselves divide into local and spanning families.

## 7. Ergonomics and new gaps

Cutting by stratum surfaced five findings (full detail in [`LEDGER.md`](LEDGER.md)):

- **STRATA-1** — the loop's three regions are co-stratal, so the cut collapses the
  runtime into one region_stratum pack (the loop is single-stratum at runtime).
- **STRATA-2** — cross-stratal constructs (ports, conduits, bridge, skip) have no
  single-stratum home; the Causalontology kinds split into local and spanning.
- **STRATA-3** — nothing binds a pack's layer to its stratum ordinal; the useful
  alignment is maintained by hand and unchecked.
- **STRATA-4** — one-pack-per-stratum produces wildly uneven packs (cellular: 1
  record; region: 14 + runtime); a named-but-unpopulated stratum still costs a pack.
- **STRATA-5 → P1** (second sighting) — the structure↔dynamics seam persists and
  is now structurally unavoidable, because the native dynamics have no stratum and
  so can never share a stratum pack with the structure they animate.

## 8. Scale verdict

At 15 stratum packs, one-pack-per-stratum is the arm whose pack count is FIXED by
the anatomy (fifteen levels), whose layer order comes free from the data layer's
ordinals, and whose coupling stays modest and downward. **What it buys:** the
tightest code-to-data alignment of the three arms — the layer numbers mean
something, the skip is natural, and each level's structure lives in one place.

**What hurts first:** the stratum-SPANNING constructs (STRATA-2). Every port,
conduit, and bridge — and there are ~forty interfaces in the full connectome —
has no stratum of its own and must be assigned to a coarser stratum pack, so the
coarse strata (region, organ, system) become heavy catch-alls while fine strata
stay near-empty (STRATA-4), and the runtime loops (single-stratum) cut ACROSS the
structural strata (STRATA-1). The data layer's boundary is the right code boundary
for the two-thirds of constructs that sit at a level, and the wrong one for the
third that span levels and for the runtime that lives at one.

## The three-way picture (for the Wave 3 verdict)

- **atomic** (fine): best change-locality and per-construct testability; pays in
  superlinear interface coupling and ~143-pack ceremony.
- **loops** (coarse): leanest and least-coupled; pays by pushing all discipline
  INSIDE the pack, where the language cannot see it.
- **strata** (data-aligned): best grounding fit — the layer order and the skip
  come free — for the constructs that sit at a level; pays at the constructs that
  SPAN levels and at the un-stratified dynamics and runtime.

No arm dominates. The honest reading these three COMPARISONs invite is a HYBRID,
as the spike found for closure: cut STRUCTURE by stratum (strata's free layer
order and natural skip), keep the runtime LOOP as its own single-stratum unit
(atomic/loops), and give the stratum-spanning interfaces a first-class edge home
of their own (STRATA-2's remedy) rather than forcing them into a stratum. That
synthesis is for the Wave 3 verdict to weigh — this arm's job was to measure the
stratum cut, and it does: aligned where the data sits at a level, homeless where
it spans them.
