/*  connectome-strata — macromolecular_stratum (ordinal 4 → pack layer 2).

    THE STRATA-ARM RULE: one pack per stratum. This pack IS the macromolecular
    stratum (Causalontology ordinal 4, the molecular level). It owns every
    construct that sits AT this stratum: the stratum record itself, the
    glucocorticoid gene-expression occurrent stamped against it, and the token
    occurrence of one particular gene-expression episode. Each construct's
    stratum field is the pack it lives in — the data layer's level boundary IS
    the code boundary here, which is exactly the alignment this arm tests.

    THE SKIP'S LOW END LIVES HERE. The cortisol channel skips FROM the community
    stratum (ordinal 14) TO this one (ordinal 4). This pack owns the low end (the
    gene-expression occurrent); the community_stratum pack owns the skip CRO and
    reaches DOWN to import this pack for the gene occurrent's id. Because the skip
    goes from a high ordinal to a low ordinal, that cross-pack reference is a
    DOWNWARD layer edge — the skip is naturally expressible (see LEDGER.md,
    STRATA on the skip).

    Imports only the shared minting vocabulary (Layer 0). Nothing here references
    a higher stratum, so its layer(2) has no upward edge.
*/

% Declare the module: the macromolecular stratum's constructs and accessors.
:- module(macromolecular_stratum, [
    % macromolecular_stratum_stratum/1: the macromolecular stratum record (ordinal 4).
    macromolecular_stratum_stratum/1,
    % macromolecular_stratum_gene_occurrent/1: the glucocorticoid gene-expression occurrent (the skip's low end).
    macromolecular_stratum_gene_occurrent/1,
    % macromolecular_stratum_records/1: the labelled list of this stratum's three structure records.
    macromolecular_stratum_records/1
]).

% Import the shared minting vocabulary (Layer 0).
:- use_module(library(causal_grounding)).

% -- macromolecular_stratum_stratum(-Out): the macromolecular stratum record (ordinal 4).
macromolecular_stratum_stratum(Out) :-
    % Mint the macromolecular stratum with the anatomy's fields.
    cm_stratum("macromolecular", "neuroendocrine", 4, "macromolecule", ["molecular_biology"], Out).

% -- macromolecular_stratum_gene_occurrent(-Out): the gene-expression state-change at this stratum.
macromolecular_stratum_gene_occurrent(Out) :-
    % Read this pack's own stratum id (the occurrent is stamped against it).
    macromolecular_stratum_stratum(SMacro),
    % Mint the glucocorticoid gene-expression occurrent.
    cm_occ("glucocorticoid_gene_expression", "state_change", SMacro.id, Out).

% -- macromolecular_stratum_token(-Out): one particular cortisol/gene-expression episode, signed observer.
macromolecular_stratum_token(Out) :-
    % The episode instantiates the gene-expression occurrent.
    macromolecular_stratum_gene_occurrent(OGene),
    % Derive the arm's deterministic observer key (name held constant: connectome_slice).
    cm_key("connectome_slice", _Sec, Observer),
    % Mint the token occurrence over a one-hour interval.
    cm_token(OGene.id, _{start:"2026-07-17T00:00:00Z", end:"2026-07-17T01:00:00Z"}, Observer, Out).

% -- macromolecular_stratum_records(-Records): this stratum's three structure records.
macromolecular_stratum_records(Records) :-
    % Mint the stratum, the gene occurrent, and the token episode.
    macromolecular_stratum_stratum(SMacro),
    macromolecular_stratum_gene_occurrent(OGene),
    macromolecular_stratum_token(TEpisode),
    % Assemble the labelled record list (same names the slice used).
    Records = [
        record(stratum_macromolecular, stratum,          SMacro),
        record(occurrent_gene_expression, occurrent,     OGene),
        record(token_cortisol_episode,  token_occurrence, TEpisode)
    ].
