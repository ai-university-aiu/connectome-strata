% Test suite for the region_stratum pack (ordinal 9, the heaviest stratum pack).
% The three region ticks block on Lattice cues, so their behaviour is proven
% end-to-end by bin/run_slice.sh; this in-pack test confirms the module loads,
% exposes all three region ticks, and mints its fourteen valid structure records.
% Load the region_stratum module under test.
:- use_module(library(region_stratum)).
% Load PrologAI's schema validator for the structure records.
:- use_module(library(schema_check)).
% Load the PLUnit testing framework.
:- use_module(library(plunit)).
% Load list utilities.
:- use_module(library(lists)).

% Open the test block for the region_stratum pack.
:- begin_tests(region_stratum).

% The pack exposes the three co-stratal region ticks as its runtime interface.
test(exports_three_region_ticks) :-
    % All three region ticks are defined and callable (they share this one stratum pack).
    current_predicate(region_stratum_cortex_tick/1),
    current_predicate(region_stratum_striatum_tick/1),
    current_predicate(region_stratum_thalamus_tick/1).

% This stratum's fourteen records are all schema-valid, spanning several kinds.
test(records_valid) :-
    % Fetch the labelled records.
    region_stratum_records(Records),
    % There are exactly fourteen of them (the heaviest pack).
    length(Records, 14),
    % Each validates against its kind's schema.
    forall(member(record(_, Kind, Dict), Records),
           co_validate_schema(Dict, Kind, true, [])),
    % Both conduits and the bridge live here (the cross-stratal constructs).
    memberchk(record(bridge_action_selection, bridge, _), Records),
    memberchk(record(conduit_corticostriatal_computational, conduit, _), Records).

% The stratum record in this pack carries ordinal 9 (the brain-region level).
test(ordinal_is_9) :-
    % Fetch the records and pick out this pack's own stratum record.
    region_stratum_records(Records),
    memberchk(record(stratum_region, stratum, S), Records),
    % Its ordinal is 9.
    get_dict(ordinal, S, 9).

% Close the test block.
:- end_tests(region_stratum).
