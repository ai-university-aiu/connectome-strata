% Test suite for the macromolecular_stratum pack (ordinal 4).
% Load the macromolecular_stratum module under test.
:- use_module(library(macromolecular_stratum)).
% Load PrologAI's schema validator for the structure records.
:- use_module(library(schema_check)).
% Load the PLUnit testing framework.
:- use_module(library(plunit)).
% Load list utilities.
:- use_module(library(lists)).

% Open the test block for the macromolecular_stratum pack.
:- begin_tests(macromolecular_stratum).

% This stratum's three records are all schema-valid.
test(records_valid) :-
    % Fetch the labelled records.
    macromolecular_stratum_records(Records),
    % There are exactly three of them.
    length(Records, 3),
    % Each validates against its kind's schema.
    forall(member(record(_, Kind, Dict), Records),
           co_validate_schema(Dict, Kind, true, [])).

% The stratum record carries ordinal 4 (the molecular level).
test(ordinal_is_4) :-
    % Mint the stratum record.
    macromolecular_stratum_stratum(S),
    % Its ordinal is 4.
    get_dict(ordinal, S, 4).

% Close the test block.
:- end_tests(macromolecular_stratum).
