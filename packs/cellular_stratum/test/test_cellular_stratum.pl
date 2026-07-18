% Test suite for the cellular_stratum pack (ordinal 6, the near-empty stratum).
% Load the cellular_stratum module under test.
:- use_module(library(cellular_stratum)).
% Load PrologAI's schema validator for the structure record.
:- use_module(library(schema_check)).
% Load the PLUnit testing framework.
:- use_module(library(plunit)).
% Load list utilities.
:- use_module(library(lists)).

% Open the test block for the cellular_stratum pack.
:- begin_tests(cellular_stratum).

% This stratum owns exactly one record — its own stratum definition — and it validates.
test(single_record_valid) :-
    % Fetch the labelled records.
    cellular_stratum_records(Records),
    % There is exactly one of them (the near-empty stratum).
    length(Records, 1),
    % It validates against the stratum schema.
    forall(member(record(_, Kind, Dict), Records),
           co_validate_schema(Dict, Kind, true, [])).

% The stratum record carries ordinal 6 (the cellular level).
test(ordinal_is_6) :-
    % Mint the stratum record.
    cellular_stratum_stratum(S),
    % Its ordinal is 6.
    get_dict(ordinal, S, 6).

% Close the test block.
:- end_tests(cellular_stratum).
