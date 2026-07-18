# connectome-strata — one pack per stratum (Wave 3c, the finale)

**THE DELIVERABLE IS THE FINDING, NOT THE CODE.**

This repository is the **strata arm** — the third and final arm — of the Wave 3
granularity experiment (see `WAVE_3_DESIGN_v1.txt`). Its one-sentence purpose:
**to measure the decomposition rule "one pack per stratum," where the code
boundary is set by the Causalontology 2.0.0 stratum kind, and to answer whether
the data layer's own level boundary is also the right CODE boundary.** The walls
it hit — and the one place it clearly succeeds — live in [`LEDGER.md`](LEDGER.md);
the three-way side-by-side measurement against the atomic and loops arms lives in
[`COMPARISON.md`](COMPARISON.md). Those two files, not this code, are the product.

## What this is (and why it is the interesting arm)

It is **not a new slice.** It is the SAME Wave 2 vertical slice
(`connectome-proto-agi`), and the SAME anatomy as the atomic and loops arms,
carved by STRATUM. The atomic arm cut by construct and the loops arm cut by
circuit — both code-only ideas. This arm cuts by the stratum, which is ALREADY a
first-class kind in the data layer, so it tests a sharp question: **does the pack
boundary coincide with the Causalontology stratum?** Where it does, the structure
and the code share one seam instead of crossing an unmanaged one.

Everything else is held constant and PROVEN so:

- **The behaviour** — the cortico-basal-ganglia-thalamo-cortical loop closing for
  N laps, same verdict (3N+1 hops, a strictly monotonic token, the region
  sequence cortex then N×[striatum, thalamus, cortex], the cortex re-entering N
  times). The narrated trace is **byte-identical** to the slice and both prior
  arms (verified by `diff`).
- **The data layer** — the SAME twenty-eight Causalontology 2.0.0 records, proven
  **byte-identical** to the slice's `structure/` by regenerating from the five
  stratum packs and `diff`-ing (every content-addressed id matched).
- **The dynamics** — the same dopamine RPE, cortisol suppression, and three-factor
  plasticity math (the slice's `neurochemistry`, reused verbatim).
- **The closure mechanism** — stigmergy for state (zero actor-to-actor
  references) plus notification for reactivity (`lattice_await`/`lattice_notify`,
  no busy-poll), narrated in glass-box style.
- **The platform** — PrologAI reused UNMODIFIED, read-only. Every gap is a Ledger
  entry, never a commit. Mentova and the frozen spike are untouched.

Only the **pack boundaries** move.

## The decomposition — one pack per stratum

Eight packs carve the identical anatomy: three substrate packs plus one pack per
stratum the slice touches. Each stratum pack takes a `layer(N)` that TRACKS the
stratum's Causalontology ordinal:

```
packs/neural_lattice/          layer 0  closure substrate (stigmergy + await/notify)   [reused from the slice]
packs/causal_grounding/        layer 0  the shared Causalontology minting vocabulary    [reused from the atomic arm]
packs/neurochemistry/          layer 1  the native dynamics — which have NO stratum      [reused from the slice]
packs/macromolecular_stratum/  layer 2  ordinal 4  — gene expression + the cortisol episode
packs/cellular_stratum/        layer 3  ordinal 6  — named by the slice, populated by nothing (1 record)
packs/synaptic_stratum/        layer 4  ordinal 7  — the synaptic events + the transform CRO
packs/region_stratum/          layer 5  ordinal 9  — the regions, the interfaces, and the runtime
packs/community_stratum/       layer 6  ordinal 14 — the social cause + the layer-skipping cortisol CRO
```

The stratum-to-pack-layer mapping is `layer = rank of ordinal + 1`, and it passes
the strict layer rule with zero violations because every cross-pack edge runs
coarse-imports-fine (a downward layer edge). Two facts make this the finale's
headline: **the layer order fell out of the stratum ordinals**, and **the
ten-stratum cortisol SKIP (community → macromolecular) is the cleanest downward
edge in the whole arm.** Two facts temper it: the loop's three regions are all
co-stratal (ordinal 9), so they share one pack as internal sections (like the
loops arm); and the stratum-SPANNING constructs (ports, conduits, bridge, skip)
have no single-stratum home and are assigned to the coarser stratum they touch.
See [`LEDGER.md`](LEDGER.md).

## How to run it

Everything reuses a local PrologAI checkout **unmodified** (default
`/home/ccaitwo/PrologAI`; override with `PROLOGAI_HOME`). SWI-Prolog 9.x required.

```bash
# 1. Tick the reentrant loop and print the narrated, glass-box trace (exit 0 on a proven close).
bin/run_slice.sh 8 5 0.4        #  <laps> <cortisol_event_lap> <learning_rate>

# 2. Run PrologAI's UNMODIFIED layer construct against the arm's 8 packs (exit 0 = no upward edge).
#    Watch the report: the stratum packs' layers (2..6) track the Causalontology ordinals (4,6,7,9,14).
bin/check_layers.sh

# 3. Prove the co-stratal regions share only the Lattice — zero actor-to-actor references.
#    (All three regions are at ordinal 9, so they share one pack; the check does intra-pack section analysis.)
bin/check_no_coupling.sh

# 4. Validate every Causalontology 2.0.0 structure record + the skip finding + the signature.
#    (bin/validate_structure.sh is the wrapper; it runs the validator bin/validate_structure.pl.)
bin/validate_structure.sh

# 5. Run every pack's in-pack PLUnit suite.
bin/run_tests.sh
```

## How to read the narration

Each line of the trace is one hop of the beat through the Lattice — identical in
form to the slice and both prior arms:

```
    hop 14  via lattice  striatum  token=14
      striatum: reward=1.00 prediction=0.6400 dopamine(RPE)=0.3600 cortisol=0.000 weight 0.6400 -> 0.7840
    hop 15  via lattice  thalamus  token=15
```

- `via lattice` on **every** hop is the point: the three co-stratal regions share
  one pack, but the beat still always arrives through the shared Lattice, never by
  one section calling another.
- `token=N` increases by exactly 1 every hop; at the end the runner checks the
  token ran 1..3N+1, the region sequence, and the N cortex re-entries.
- At the cortisol event lap a one-line banner marks the ten-stratum skip — the
  very skip whose structural record lives, cleanly, one pack away.

## Status

The loop closes for N laps with a byte-identical trace to the slice; the
co-stratal regions share only the Lattice (zero actor-to-actor references, proven
by intra-pack section analysis) and there is no busy-poll; every pack declares a
layer, the layer checker passes with zero upward edges, and the stratum packs'
layers track the Causalontology ordinals; all 28 records validate and are
byte-identical to the slice's; the mini regression is green (ARC-AGI-1 40/40,
ARC-AGI-2 12/12 — a 10 percent spot-check; full regression deferred); PrologAI,
Mentova, and the frozen spike are unmodified. See [`LEDGER.md`](LEDGER.md) for the
five findings and [`COMPARISON.md`](COMPARISON.md) for the three-way rubric — the
reason this repository exists.

## Boundaries (what this arm must not become)

Not a new slice, not the full 140-construct connectome (it replicates the SLICE
and PROJECTS to 15 packs), not a modification of PrologAI (a gap is a Ledger
entry, not a commit), the frozen spike, or Mentova. It is the slice, carved by
stratum — the third arm of a three-arm comparison whose VERDICT (atomic vs loops
vs strata) is written next, now that all three arms exist.
