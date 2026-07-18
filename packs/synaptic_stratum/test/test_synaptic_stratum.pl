% Test suite for the synaptic_stratum pack (ordinal 7).
% Load the synaptic_stratum module under test.
:- use_module(library(synaptic_stratum)).
% Load PrologAI's schema validator for the structure records.
:- use_module(library(schema_check)).
% Load the PLUnit testing framework.
:- use_module(library(plunit)).
% Load list utilities.
:- use_module(library(lists)).

% Open the test block for the synaptic_stratum pack.
:- begin_tests(synaptic_stratum).

% This stratum's six records are all schema-valid, one being the transform CRO.
test(records_valid) :-
    % Fetch the labelled records.
    synaptic_stratum_records(Records),
    % There are exactly six of them.
    length(Records, 6),
    % Each validates against its kind's schema.
    forall(member(record(_, Kind, Dict), Records),
           co_validate_schema(Dict, Kind, true, [])),
    % One of them is the corticostriatal transform causal_relation_object.
    memberchk(record(cro_corticostriatal_transform, causal_relation_object, _), Records).

% The stratum record carries ordinal 7 (the synaptic level).
test(ordinal_is_7) :-
    % Mint the stratum record.
    synaptic_stratum_stratum(S),
    % Its ordinal is 7.
    get_dict(ordinal, S, 7).

% Close the test block.
:- end_tests(synaptic_stratum).
