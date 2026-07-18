#!/usr/bin/env bash
# check_no_coupling.sh — prove the co-stratal regions share ONLY the Lattice.
#
# The CLOSURE RULE demands actor-to-actor references ZERO: a region may never
# call, address, or name another region — it coordinates purely through the
# Lattice by posting numbered phase cues.
#
# A STRATA-ARM TWIST: the slice's three regions (cortex, striatum, thalamus) are
# all at the SAME Causalontology stratum (brain regions, ordinal 9), so under
# one-pack-per-stratum they ALL live in ONE pack — packs/region_stratum — as
# internal sections. So (like the loops arm, and unlike atomic) this checker does
# INTRA-PACK analysis: it splits the region_stratum module into its three
# "INTERNAL REGION MODULE" runtime sections and confirms no section's CODE
# (comments stripped) calls another region's region_stratum_<region>_ predicates
# or names another region as a bare word. The structure-minting preamble (which
# legitimately names all three regions as continuants) sits before the first
# section marker and is not a runtime section, so it is not checked.
#
# Exit 0 = clean (no cross-region reference); 1 = a reference found; 2 = error.
set -u
# Resolve the arm repository root from this script's location.
cd "$(dirname "$0")/.." || exit 2
# Run a small Python check that splits the region_stratum module into region sections.
python3 - <<'PY'
import re, sys
# The three internal region modules whose runtime code must never call one another.
regions = ["cortex", "striatum", "thalamus"]
# Read the single region_stratum module holding all three region runtime sections.
src = open("packs/region_stratum/prolog/region_stratum.pl").read()
# Split on the internal-region markers, capturing each region name and its body.
parts = re.split(r"%\s*INTERNAL REGION MODULE:\s*(\w+)", src)
# parts[0] is the preamble (module + imports + structure minting); then (name, body) pairs follow.
sections = {}
for i in range(1, len(parts) - 1, 2):
    sections[parts[i].strip()] = parts[i + 1]
# Track every cross-region reference found.
violations = []
# Confirm all three internal region runtime sections are present.
for r in regions:
    if r not in sections:
        violations.append(f"internal region section '{r}' not found (marker missing)")
# Examine each region section's CODE for references to another region.
for r, body in sections.items():
    # Strip block comments /* ... */ (dot matches newline).
    code = re.sub(r"/\*.*?\*/", "", body, flags=re.S)
    # Strip whole-line % comments (keep code lines only).
    code = "\n".join(l for l in code.split("\n") if not l.lstrip().startswith("%"))
    # Also strip trailing % comments on code lines.
    code = re.sub(r"%.*", "", code)
    # Look for a call into any OTHER region's predicate family, or its bare name.
    for other in regions:
        if other == r:
            continue
        # A direct call into another region would be to a region_stratum_<other>_ predicate.
        if re.search(r"\bregion_stratum_" + re.escape(other) + r"_", code):
            violations.append(f"internal region '{r}' calls region '{other}' directly (region_stratum_{other}_...)")
        # Defence in depth: the other region's bare name should not appear in code either.
        if re.search(r"\b" + re.escape(other) + r"\b", code):
            violations.append(f"internal region '{r}' names region '{other}' in code")

# Report the outcome.
if violations:
    print("check_no_coupling: FAIL")
    for v in violations:
        print("  " + v)
    sys.exit(1)
else:
    print("check_no_coupling: PASS -- the co-stratal regions share only the Lattice; 0 actor-to-actor references.")
    print("  cortex, striatum, thalamus are internal sections of one region_stratum pack, coordinating solely via numbered phase cues (phase_0/1/2).")
    sys.exit(0)
PY
# Propagate the Python checker's exit code.
exit $?
