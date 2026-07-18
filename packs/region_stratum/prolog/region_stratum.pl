/*  connectome-strata — region_stratum (ordinal 9 → pack layer 5).

    THE STRATA-ARM RULE: one pack per stratum. This pack IS the brain-region
    stratum (Causalontology ordinal 9). It is by far the HEAVIEST pack (fourteen
    structure records plus the whole runtime), for two reasons the strata cut
    makes visible:

    (1) THE THREE REGIONS ARE CO-STRATAL. The design expected the loop's regions
    to sit at DIFFERENT levels; the slice's data says otherwise — cortex,
    striatum, and thalamus are ALL brain regions at ordinal 9, and so is the
    substantia nigra. So one-pack-per-stratum does NOT separate them: all three
    region RUNTIMES land in THIS one pack, as internal sections (marked
    "INTERNAL REGION MODULE"), and the reentrant loop's closure is INTRA-pack
    (like the loops arm), not cross-pack (see LEDGER.md, STRATA-1). They still
    coordinate ONLY through the Lattice by numbered phase cues, never calling one
    another — enforced across the section boundary by bin/check_no_coupling.sh.

    (2) THE CROSS-STRATAL CONSTRUCTS HAVE NOWHERE ELSE TO GO. Ports, conduits,
    and the bridge SPAN strata by their very Causalontology kind (a port bridges
    a bearer to a signal; a conduit joins two regions carrying a synaptic signal;
    a bridge relates a coarse occurrent to finer ones). They are assigned HERE —
    to the COARSER (region) stratum of the levels they touch — so their downward
    references (to the synaptic occurrents) are downward layer edges and the
    layer rule holds. Assigning them to the finer synaptic stratum would invert
    those edges into violations (see LEDGER.md, STRATA-2).

    Imports the minting vocabulary (0), the synaptic stratum (4, for the drive/
    release/transform ids its ports/conduits/bridge reference — a downward edge),
    the Lattice (0, runtime), and the neurochemistry (1, runtime dynamics) — all
    downward, so its layer(5) is clean.
*/

% Declare the module: the three region ticks (for the runner) plus the record projection.
:- module(region_stratum, [
    % region_stratum_cortex_tick/1: one cortical step (the origin and re-entry point).
    region_stratum_cortex_tick/1,
    % region_stratum_striatum_tick/1: one striatal step (dopamine-gated plasticity).
    region_stratum_striatum_tick/1,
    % region_stratum_thalamus_tick/1: one thalamic step (the relay that closes the loop).
    region_stratum_thalamus_tick/1,
    % region_stratum_records/1: the labelled list of this stratum's fourteen structure records.
    region_stratum_records/1
]).

% Import the shared minting vocabulary (Layer 0).
:- use_module(library(causal_grounding)).
% Import the synaptic stratum (Layer 4) for the occurrent and transform ids the interfaces reference.
:- use_module(library(synaptic_stratum)).
% Import the Lattice substrate (Layer 0) for the runtime cue await/post and narration.
:- use_module(library(neural_lattice)).
% Import the native dynamics (Layer 1) for the runtime reward/dopamine/plasticity math.
:- use_module(library(neurochemistry)).

% ---------------------------------------------------------------------------
% THE REGION-STRATUM STRUCTURE (all fourteen records at ordinal 9 or spanning down).
% ---------------------------------------------------------------------------

% -- region_stratum_stratum(-Out): the brain-region stratum record (ordinal 9).
region_stratum_stratum(Out) :-
    % Mint the region stratum with the anatomy's fields.
    cm_stratum("region", "neuroendocrine", 9, "brain_region", ["systems_neuroscience"], Out).

% -- region_stratum_cortex_continuant(-Out): the cortex continuant (bearer).
region_stratum_cortex_continuant(Out) :-
    % Mint the cortex bearer.
    cm_cnt("cortex", "object", Out).

% -- region_stratum_striatum_continuant(-Out): the striatum continuant (bearer).
region_stratum_striatum_continuant(Out) :-
    % Mint the striatum bearer.
    cm_cnt("striatum", "object", Out).

% -- region_stratum_thalamus_continuant(-Out): the thalamus continuant (bearer).
region_stratum_thalamus_continuant(Out) :-
    % Mint the thalamus bearer.
    cm_cnt("thalamus", "object", Out).

% -- region_stratum_snc_continuant(-Out): the substantia-nigra-pars-compacta continuant (bearer).
region_stratum_snc_continuant(Out) :-
    % Mint the dopamine-source bearer (a nucleus, also a region-level continuant).
    cm_cnt("substantia_nigra_pars_compacta", "object", Out).

% -- region_stratum_action_selection_occurrent(-Out): the action-selection process, at this stratum.
region_stratum_action_selection_occurrent(Out) :-
    % Read this pack's own stratum id.
    region_stratum_stratum(SRegion),
    % Mint the action-selection occurrent.
    cm_occ("action_selection", "process", SRegion.id, Out).

% -- region_stratum_plasticity_realizable(-Out): the synaptic-plasticity disposition borne by the striatum.
region_stratum_plasticity_realizable(Out) :-
    % The bearer is the striatum continuant (same pack, so no cross-stratum edge — the KEY assignment).
    region_stratum_striatum_continuant(CStriatum),
    % Mint the realizable disposition (assigned to the bearer's region stratum, not the synaptic level).
    cm_rlz(CStriatum.id, "disposition", "synaptic_plasticity", Out).

% -- region_stratum_cortical_output_port(-Out): the cortex output port (carries the synaptic drive).
region_stratum_cortical_output_port(Out) :-
    % The bearer is the cortex continuant.
    region_stratum_cortex_continuant(CCortex),
    % The accepted occurrent is the synaptic drive (imported downward from synaptic_stratum).
    synaptic_stratum_drive_occurrent(ODrive),
    % Mint the output port.
    cm_port(CCortex.id, "cortical_output", "out", [ODrive.id], Out).

% -- region_stratum_corticostriatal_input_port(-Out): the striatal input port (bears plasticity).
region_stratum_corticostriatal_input_port(Out) :-
    % The bearer is the striatum continuant.
    region_stratum_striatum_continuant(CStriatum),
    % The accepted occurrent is the synaptic drive.
    synaptic_stratum_drive_occurrent(ODrive),
    % The port bears the plasticity realizable.
    region_stratum_plasticity_realizable(RPlast),
    % Mint the input port carrying the realizable id.
    cm_port(CStriatum.id, "corticostriatal_input", "in", [ODrive.id], RPlast.id, Out).

% -- region_stratum_dopaminergic_output_port(-Out): the nigral dopaminergic output port.
region_stratum_dopaminergic_output_port(Out) :-
    % The bearer is the substantia-nigra continuant.
    region_stratum_snc_continuant(CSnc),
    % The accepted occurrent is the synaptic dopamine release.
    synaptic_stratum_dopamine_release_occurrent(ODopamine),
    % Mint the output port.
    cm_port(CSnc.id, "dopaminergic_output", "out", [ODopamine.id], Out).

% -- region_stratum_dopaminergic_input_port(-Out): the striatal dopaminergic input port.
region_stratum_dopaminergic_input_port(Out) :-
    % The bearer is the striatum continuant.
    region_stratum_striatum_continuant(CStriatum),
    % The accepted occurrent is the synaptic dopamine release.
    synaptic_stratum_dopamine_release_occurrent(ODopamine),
    % Mint the input port.
    cm_port(CStriatum.id, "dopaminergic_input", "in", [ODopamine.id], Out).

% -- region_stratum_nigrostriatal_conduit(-Out): the TRANSMISSIVE dopamine projection (no transform).
region_stratum_nigrostriatal_conduit(Out) :-
    % The from-port is the nigral dopaminergic output.
    region_stratum_dopaminergic_output_port(PSncOut),
    % The to-port is the striatal dopaminergic input.
    region_stratum_dopaminergic_input_port(PStriatumDop),
    % The carried occurrent is the synaptic dopamine release.
    synaptic_stratum_dopamine_release_occurrent(ODopamine),
    % Mint the transmissive conduit (a perfect wire suffices; no transform).
    cm_conduit(PSncOut.id, PStriatumDop.id, [ODopamine.id], "nigrostriatal_projection", Out).

% -- region_stratum_corticostriatal_conduit(-Out): the COMPUTATIONAL projection (transform = synaptic CRO).
region_stratum_corticostriatal_conduit(Out) :-
    % The from-port is the cortical output.
    region_stratum_cortical_output_port(PCortexOut),
    % The to-port is the striatal input.
    region_stratum_corticostriatal_input_port(PStriatumIn),
    % The carried occurrent is the synaptic drive.
    synaptic_stratum_drive_occurrent(ODrive),
    % The transform is the synaptic transform CRO (imported downward).
    synaptic_stratum_transform_cro(CroPlast),
    % Mint the computational conduit (carries the transform id).
    cm_conduit(PCortexOut.id, PStriatumIn.id, [ODrive.id], "corticostriatal_projection", CroPlast.id, Out).

% -- region_stratum_bridge(-Out): the bridge — action-selection (region) realises the finer synaptic events.
region_stratum_bridge(Out) :-
    % The coarse occurrent is the region-level action selection.
    region_stratum_action_selection_occurrent(OSelect),
    % The finer occurrents are the synaptic neurotransmitter release and dopamine release.
    synaptic_stratum_nt_release_occurrent(ORelease),
    synaptic_stratum_dopamine_release_occurrent(ODopamine),
    % Mint the bridge relating the coarse process to the finer events.
    cm_bridge(OSelect.id, [ORelease.id, ODopamine.id], "realizes", Out).

% -- region_stratum_records(-Records): this stratum's fourteen structure records.
region_stratum_records(Records) :-
    % Mint the stratum, the four continuants, and the region-level occurrent.
    region_stratum_stratum(SRegion),
    region_stratum_cortex_continuant(CCortex),
    region_stratum_striatum_continuant(CStriatum),
    region_stratum_thalamus_continuant(CThalamus),
    region_stratum_snc_continuant(CSnc),
    region_stratum_action_selection_occurrent(OSelect),
    % Mint the realizable, the four ports, the two conduits, and the bridge.
    region_stratum_plasticity_realizable(RPlast),
    region_stratum_cortical_output_port(PCortexOut),
    region_stratum_corticostriatal_input_port(PStriatumIn),
    region_stratum_dopaminergic_output_port(PSncOut),
    region_stratum_dopaminergic_input_port(PStriatumDop),
    region_stratum_nigrostriatal_conduit(KDopamine),
    region_stratum_corticostriatal_conduit(KCortico),
    region_stratum_bridge(BSelect),
    % Assemble the labelled record list (same names the slice used).
    Records = [
        record(stratum_region,             stratum,     SRegion),
        record(continuant_cortex,          continuant,  CCortex),
        record(continuant_striatum,        continuant,  CStriatum),
        record(continuant_thalamus,        continuant,  CThalamus),
        record(continuant_snc,             continuant,  CSnc),
        record(occurrent_action_selection, occurrent,   OSelect),
        record(realizable_plasticity,      realizable,  RPlast),
        record(port_cortical_output,       port,        PCortexOut),
        record(port_corticostriatal_input, port,        PStriatumIn),
        record(port_dopaminergic_output,   port,        PSncOut),
        record(port_dopaminergic_input,    port,        PStriatumDop),
        record(conduit_nigrostriatal_transmissive,   conduit, KDopamine),
        record(conduit_corticostriatal_computational, conduit, KCortico),
        record(bridge_action_selection,    bridge,      BSelect)
    ].

% ============================================================================
% INTERNAL REGION MODULE: cortex — the origin and re-entry point (co-stratal at ordinal 9)
% ============================================================================

% -- region_stratum_cortex_tick(+Nexus): block for the phase-0 cue, predict, hand on or finish.
region_stratum_cortex_tick(Nexus) :-
    % Block with no busy-poll until the beat has returned to phase 0, then take that cue.
    neural_lattice_await_cue(Nexus, 0, State0),
    % Read the current lap number.
    get_dict(lap, State0, Lap),
    % Read the number of laps the loop should run.
    get_dict(n_laps, State0, NLaps),
    % Read the current corticostriatal weight, read as the reward prediction.
    get_dict(weight, State0, Weight),
    % Read the running token counter.
    get_dict(token, State0, Token0),
    % Advance the token by one for the cortical hop.
    Token is Token0 + 1,
    % Record and print the cortical hop; the beat arrived VIA the Lattice, re-entering the loop.
    neural_lattice_hop(lattice, cortex, Token),
    % Decide whether this re-entry is the terminal one or a continuing lap.
    region_stratum_cortex_step(Nexus, Lap, NLaps, Weight, Token, State0).

% -- region_stratum_cortex_step(+Nexus, +Lap, +NLaps, +Weight, +Token, +State0): terminate or continue.
region_stratum_cortex_step(Nexus, Lap, NLaps, _Weight, Token, _State0) :-
    % The loop is at rest once the cortex re-enters beyond the last lap.
    Lap > NLaps,
    !,
    % Narrate that the loop has closed for the full number of laps.
    format(string(Line), "cortex: lap ~w exceeds ~w -- loop at rest; final token=~w", [Lap, NLaps, Token]),
    % Print the closing narration line.
    neural_lattice_narrate('    ', Line),
    % Signal the driver that the loop has come to rest, carrying the final token.
    neural_lattice_signal_done(Nexus, Token).
region_stratum_cortex_step(Nexus, Lap, NLaps, Weight, Token, State0) :-
    % Otherwise this is a continuing lap: predict reward from the learned value.
    Prediction = Weight,
    % Narrate the lap header and the cortical prediction, in glass-box style.
    format(string(Line), "cortex: lap ~w/~w  predict(value)=~4f", [Lap, NLaps, Prediction]),
    % Print the narration line.
    neural_lattice_narrate('    ', Line),
    % Update the state snapshot with the token and the prediction for the next slot.
    State1 = State0.put(_{token: Token, prediction: Prediction}),
    % Post the phase-1 cue: hand the beat to the next slot by NUMBER, naming no region.
    neural_lattice_post_cue(Nexus, 1, State1).

% ============================================================================
% INTERNAL REGION MODULE: striatum — the dopamine-gated plasticity site (co-stratal at ordinal 9)
% ============================================================================

% -- region_stratum_striatum_tick(+Nexus): block for the phase-1 cue, run plasticity, hand on.
region_stratum_striatum_tick(Nexus) :-
    % Block with no busy-poll until phase 1 has been cued, then take that cue.
    neural_lattice_await_cue(Nexus, 1, State0),
    % Read the current lap number (drives the reward schedule).
    get_dict(lap, State0, Lap),
    % Read the prediction of reward (the value estimate = the synaptic weight).
    get_dict(prediction, State0, Prediction),
    % Read the current corticostriatal synaptic weight to be updated.
    get_dict(weight, State0, Weight0),
    % Read the prevailing cortisol tone (suppresses plasticity when elevated).
    get_dict(cortisol, State0, Cortisol),
    % Read the learning rate for the three-factor rule.
    get_dict(rate, State0, Rate),
    % Read the running token counter.
    get_dict(token, State0, Token0),
    % Determine the reward delivered on this lap.
    neurochemistry_reward(Lap, Reward),
    % Form the dopamine reward-prediction-error: reward minus predicted reward.
    neurochemistry_dopamine(Reward, Prediction, Dopamine),
    % Apply the three-factor plasticity rule (pre and post activity are both 1.0 here).
    neurochemistry_plasticity(Weight0, 1.0, 1.0, Dopamine, Cortisol, Rate, Weight),
    % Advance the token by one for the striatal hop.
    Token is Token0 + 1,
    % Record and print the striatal hop; the beat arrived VIA the Lattice.
    neural_lattice_hop(lattice, striatum, Token),
    % Narrate the dopamine computation and the gated weight change, in glass-box style.
    format(string(Line),
        "striatum: reward=~2f prediction=~4f dopamine(RPE)=~4f cortisol=~3f weight ~4f -> ~4f",
        [Reward, Prediction, Dopamine, Cortisol, Weight0, Weight]),
    % Print the narration line at the standard indent.
    neural_lattice_narrate('      ', Line),
    % Update the state snapshot with the new weight, dopamine, reward, and token.
    State1 = State0.put(_{weight: Weight, dopamine: Dopamine, reward: Reward, token: Token}),
    % Post the phase-2 cue: hand the beat to the next slot by NUMBER, naming no region.
    neural_lattice_post_cue(Nexus, 2, State1).

% ============================================================================
% INTERNAL REGION MODULE: thalamus — the relay that closes the loop (co-stratal at ordinal 9)
% ============================================================================

% -- region_stratum_thalamus_tick(+Nexus): block for the phase-2 cue, relay the beat, close the loop.
region_stratum_thalamus_tick(Nexus) :-
    % Block with no busy-poll until phase 2 has been cued, then take that cue.
    neural_lattice_await_cue(Nexus, 2, State0),
    % Read the current lap number from the state snapshot.
    get_dict(lap, State0, Lap),
    % Read the running token counter (the closure proof's monotonic value).
    get_dict(token, State0, Token0),
    % Read the current cortisol tone.
    get_dict(cortisol, State0, Cortisol0),
    % Read the lap on which the social-stress cortisol event fires.
    get_dict(event_lap, State0, EventLap),
    % Advance the token by one for this hop (the relay is a hop like any other).
    Token is Token0 + 1,
    % Record and print the thalamic hop; the beat arrived VIA the Lattice, not from a named sender.
    neural_lattice_hop(lattice, thalamus, Token),
    % Decide the cortisol tone for the next lap: surge on the event lap, else decay.
    region_stratum_thalamus_cortisol(Lap, EventLap, Cortisol0, Cortisol),
    % The loop closes by handing the beat to the next lap: increment the lap number.
    NextLap is Lap + 1,
    % Update the state snapshot with the new token, cortisol tone, and lap.
    State1 = State0.put(_{token: Token, cortisol: Cortisol, lap: NextLap}),
    % Post the phase-0 cue: the beat returns to the origin slot by NUMBER, naming no region.
    neural_lattice_post_cue(Nexus, 0, State1).

% -- region_stratum_thalamus_cortisol(+Lap, +EventLap, +Old, -New): the cortisol tone for the next lap.
region_stratum_thalamus_cortisol(Lap, Lap, _Old, 3.0) :-
    % On the event lap the chronic social subordination drives a cortisol surge to 3.0.
    !,
    % Narrate the layer-skip in glass-box style: one physical step across ten strata, no mechanism.
    neural_lattice_narrate('    ',
        'CORTISOL EVENT: chronic_social_subordination @ community_and_society (ordinal 14) -> gene_expression @ macromolecular (ordinal 4): one physical step, ten strata skipped, no intervening mechanism (skips:true). Glucocorticoid tone now suppresses corticostriatal plasticity.').
region_stratum_thalamus_cortisol(_Lap, _EventLap, Old, New) :-
    % On every other lap the cortisol tone simply decays toward baseline.
    neurochemistry_cortisol_decay(Old, New).
