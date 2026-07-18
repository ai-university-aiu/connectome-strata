/*  connectome-strata — cellular_stratum (ordinal 6 → pack layer 3).

    THE STRATA-ARM RULE: one pack per stratum the slice touches. The slice MINTS
    the cellular stratum (Causalontology ordinal 6) as part of the neuroendocrine
    ladder, but places NO construct at it — no occurrent, no continuant, no
    interface stamps against the cellular level in this thin cut. So this pack is
    almost EMPTY: it owns only its own stratum record.

    THAT EMPTINESS IS A FINDING (see LEDGER.md, STRATA on uneven packs). Cutting
    by stratum produces packs of wildly uneven weight — this one holds a single
    record while region_stratum holds fourteen — because the anatomy is not
    evenly distributed across the levels. A stratum the data layer NAMES but the
    slice does not POPULATE still costs a whole pack under one-pack-per-stratum.

    Imports only the shared minting vocabulary (Layer 0); nothing imports it, so
    its layer is free to track the ordinal (3) without any dependency forcing it.
*/

% Declare the module: the cellular stratum's single construct and its record projection.
:- module(cellular_stratum, [
    % cellular_stratum_stratum/1: the cellular stratum record (ordinal 6).
    cellular_stratum_stratum/1,
    % cellular_stratum_records/1: the labelled list of this stratum's one structure record.
    cellular_stratum_records/1
]).

% Import the shared minting vocabulary (Layer 0).
:- use_module(library(causal_grounding)).

% -- cellular_stratum_stratum(-Out): the cellular stratum record (ordinal 6).
cellular_stratum_stratum(Out) :-
    % Mint the cellular stratum with the anatomy's fields.
    cm_stratum("cellular", "neuroendocrine", 6, "cell", ["cell_biology"], Out).

% -- cellular_stratum_records(-Records): this stratum's one structure record.
cellular_stratum_records(Records) :-
    % Mint the stratum record.
    cellular_stratum_stratum(SCell),
    % Assemble the labelled record list (same name the slice used).
    Records = [
        record(stratum_cellular, stratum, SCell)
    ].
