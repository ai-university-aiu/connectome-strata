/*  connectome-strata — synaptic_stratum (ordinal 7 → pack layer 4).

    THE STRATA-ARM RULE: one pack per stratum. This pack IS the synaptic stratum
    (Causalontology ordinal 7). It owns every construct stamped at the synaptic
    level: the stratum record, the neurotransmitter-release and dopamine-release
    events, the corticostriatal drive process, the synaptic weight-change, and
    the corticostriatal transform causal_relation_object (drive → weight change),
    which is a purely synaptic cause→effect claim and so lives cleanly here.

    A CLEAN ALIGNMENT. Every construct here has an explicit `stratum` field
    pointing at this pack's own stratum, or (the transform CRO) relates two
    occurrents that both do. So this pack is entirely self-contained: it imports
    only the minting vocabulary and stamps everything against its own stratum
    record. This is the within-stratum case the strata cut fits perfectly (the
    cross-stratum cases — ports, conduits, the bridge, the skip — do not; they
    are handled in region_stratum and community_stratum).

    The region_stratum pack (Layer 5, ordinal 9) imports THIS pack for the drive,
    dopamine-release, and neurotransmitter-release occurrent ids its ports,
    conduits, and bridge reference — a DOWNWARD edge (coarse imports fine), so the
    layer rule holds and the pack layer tracks the stratum ordinal.

    Imports only the shared minting vocabulary (Layer 0).
*/

% Declare the module: the synaptic stratum's constructs and the accessors coarser strata reference.
:- module(synaptic_stratum, [
    % synaptic_stratum_stratum/1: the synaptic stratum record (ordinal 7).
    synaptic_stratum_stratum/1,
    % synaptic_stratum_nt_release_occurrent/1: the neurotransmitter-release event.
    synaptic_stratum_nt_release_occurrent/1,
    % synaptic_stratum_dopamine_release_occurrent/1: the dopamine-release event.
    synaptic_stratum_dopamine_release_occurrent/1,
    % synaptic_stratum_drive_occurrent/1: the corticostriatal-drive process.
    synaptic_stratum_drive_occurrent/1,
    % synaptic_stratum_transform_cro/1: the corticostriatal transform causal_relation_object.
    synaptic_stratum_transform_cro/1,
    % synaptic_stratum_records/1: the labelled list of this stratum's six structure records.
    synaptic_stratum_records/1
]).

% Import the shared minting vocabulary (Layer 0).
:- use_module(library(causal_grounding)).

% -- synaptic_stratum_stratum(-Out): the synaptic stratum record (ordinal 7).
synaptic_stratum_stratum(Out) :-
    % Mint the synaptic stratum with the anatomy's fields.
    cm_stratum("synaptic", "neuroendocrine", 7, "synapse", ["synaptic_physiology"], Out).

% -- synaptic_stratum_nt_release_occurrent(-Out): the neurotransmitter-release event.
synaptic_stratum_nt_release_occurrent(Out) :-
    % Read this pack's own stratum id.
    synaptic_stratum_stratum(SSyn),
    % Mint the neurotransmitter-release occurrent.
    cm_occ("neurotransmitter_release", "event", SSyn.id, Out).

% -- synaptic_stratum_dopamine_release_occurrent(-Out): the dopamine-release event.
synaptic_stratum_dopamine_release_occurrent(Out) :-
    % Read this pack's own stratum id.
    synaptic_stratum_stratum(SSyn),
    % Mint the dopamine-release occurrent.
    cm_occ("dopamine_release", "event", SSyn.id, Out).

% -- synaptic_stratum_drive_occurrent(-Out): the corticostriatal-drive process.
synaptic_stratum_drive_occurrent(Out) :-
    % Read this pack's own stratum id.
    synaptic_stratum_stratum(SSyn),
    % Mint the corticostriatal-drive occurrent.
    cm_occ("corticostriatal_drive", "process", SSyn.id, Out).

% -- synaptic_stratum_weight_change_occurrent(-Out): the synaptic weight-change.
synaptic_stratum_weight_change_occurrent(Out) :-
    % Read this pack's own stratum id.
    synaptic_stratum_stratum(SSyn),
    % Mint the synaptic-weight-change occurrent.
    cm_occ("synaptic_weight_change", "state_change", SSyn.id, Out).

% -- synaptic_stratum_transform_cro(-Out): the corticostriatal transform (drive -> weight change).
synaptic_stratum_transform_cro(Out) :-
    % The cause is the corticostriatal-drive occurrent.
    synaptic_stratum_drive_occurrent(ODrive),
    % The effect is the synaptic-weight-change occurrent.
    synaptic_stratum_weight_change_occurrent(OUpdate),
    % Mint the transform CRO with its modality and temporal window (both ends are synaptic).
    cm_cro([ODrive.id], [OUpdate.id],
           [modality-"sufficient", temporal-_{minimum_delay:0, maximum_delay:1, unit:"seconds"}],
           Out).

% -- synaptic_stratum_records(-Records): this stratum's six structure records.
synaptic_stratum_records(Records) :-
    % Mint the stratum, the four occurrents, and the transform CRO.
    synaptic_stratum_stratum(SSyn),
    synaptic_stratum_nt_release_occurrent(ORelease),
    synaptic_stratum_dopamine_release_occurrent(ODopamine),
    synaptic_stratum_drive_occurrent(ODrive),
    synaptic_stratum_weight_change_occurrent(OUpdate),
    synaptic_stratum_transform_cro(CroPlast),
    % Assemble the labelled record list (same names the slice used).
    Records = [
        record(stratum_synaptic,           stratum,                SSyn),
        record(occurrent_nt_release,        occurrent,             ORelease),
        record(occurrent_dopamine_release,  occurrent,             ODopamine),
        record(occurrent_corticostriatal_drive, occurrent,         ODrive),
        record(occurrent_weight_change,     occurrent,             OUpdate),
        record(cro_corticostriatal_transform, causal_relation_object, CroPlast)
    ].
