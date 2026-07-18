#!/usr/bin/env bash
# run_slice.sh — tick the reentrant loop for N laps and print the narrated trace.
#
# The strata arm holds the BEHAVIOUR constant with the Wave 2 slice; only the pack
# boundaries differ (one pack per stratum). This script assembles the SWI-Prolog
# library path over the arm's eight packs plus the PrologAI packs reused
# UNMODIFIED (lattice = the stigmergy + await/notify substrate; actors = the
# cyclic_actor threads), then runs the driver.
#
# NOTE: the region_stratum pack co-locates the region-level STRUCTURE records WITH
# the runtime, so loading it (to run the ticks) pulls in the grounding engine —
# like the atomic arm and UNLIKE the loops arm, this runner needs causal_core and
# the signing harness on its path even though the loop never mints a record
# (see LEDGER.md).
#
# Usage: bin/run_slice.sh [NLaps] [EventLap] [Rate]   (defaults: 8 5 0.4)
set -u
# Resolve the arm repository root from this script's location.
cd "$(dirname "$0")/.." || exit 2
# Resolve the PrologAI checkout (honour PROLOGAI_HOME, else the local default).
PROLOGAI_HOME="${PROLOGAI_HOME:-/home/ccaitwo/PrologAI}"
# Confirm the PrologAI checkout exists before building the library path.
if [ ! -d "$PROLOGAI_HOME/packs/lattice/prolog" ]; then
  # Report the missing dependency and stop.
  echo "run_slice.sh: cannot find PrologAI at $PROLOGAI_HOME (set PROLOGAI_HOME)" >&2
  exit 2
fi
# Start the library path with every arm pack's prolog directory.
LIB=""
for d in packs/*/prolog; do LIB="$LIB -p library=$d"; done
# Add the reused PrologAI packs (read-only, unmodified): the Lattice and the actors.
LIB="$LIB -p library=$PROLOGAI_HOME/packs/lattice/prolog"
LIB="$LIB -p library=$PROLOGAI_HOME/packs/actors/prolog"
# Add the grounding engine and signing harness (region_stratum co-locates structure with runtime).
LIB="$LIB -p library=$PROLOGAI_HOME/packs/causal_core/prolog"
LIB="$LIB -p library=$PROLOGAI_HOME/tests/causalontology_conformance"
# Read the three parameters with defaults.
NLAPS="${1:-8}"
EVENTLAP="${2:-5}"
RATE="${3:-0.4}"
# Run the driver; its initialization goal reads argv after -- and halts with the verdict code.
swipl -q $LIB bin/run_slice.pl -- "$NLAPS" "$EVENTLAP" "$RATE"
# Propagate the driver's exit code (0 = clean, proven closure).
exit $?
