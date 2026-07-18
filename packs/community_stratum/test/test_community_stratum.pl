% Test suite for the community_stratum pack (ordinal 14, the cortisol skip's high end).
% Load the community_stratum module under test.
:- use_module(library(community_stratum)).
% Load PrologAI's schema validator for the structure records.
:- use_module(library(schema_check)).
% Load the PLUnit testing framework.
:- use_module(library(plunit)).
% Load list utilities.
:- use_module(library(lists)).

% Open the test block for the community_stratum pack.
:- begin_tests(community_stratum).

% This stratum's four records are all schema-valid, one being the skip CRO.
test(records_valid) :-
    % Fetch the labelled records.
    community_stratum_records(Records),
    % There are exactly four of them.
    length(Records, 4),
    % Each validates against its kind's schema.
    forall(member(record(_, Kind, Dict), Records),
           co_validate_schema(Dict, Kind, true, [])),
    % One of them is the skipping cortisol CRO.
    memberchk(record(cro_cortisol_skip, causal_relation_object, _), Records).

% The cortisol CRO, spanning two stratum packs, still classifies as a clean skip.
test(clean_skip_across_two_packs) :-
    % Classify the CRO (its effect occurrent is imported down from the macromolecular pack).
    community_stratum_skip_check(Class, Gaps),
    % It skips ten strata with no gap — the absence of a mechanism is a positive finding.
    Class == skipping, Gaps == [].

% The signed provenance assertion over the skip CRO carries a signature.
test(assertion_signed) :-
    % A signed assertion exists and has a signature field.
    community_stratum_signed_assertion(Signed),
    get_dict(signature, Signed, _).

% Close the test block.
:- end_tests(community_stratum).
