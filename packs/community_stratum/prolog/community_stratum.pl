/*  connectome-strata — community_stratum (ordinal 14 → pack layer 6).

    THE STRATA-ARM RULE: one pack per stratum. This pack IS the community-and-
    society stratum (Causalontology ordinal 14, the coarsest the slice touches).
    It owns the chronic-social-subordination process at this level, AND the
    layer-skipping cortisol causal_relation_object, AND the Ed25519-signed
    provenance assertion over that skip.

    THE SKIP'S HIGH END LIVES HERE, AND THE SKIP IS NATURAL. The cortisol channel
    skips FROM this stratum (ordinal 14) TO the macromolecular stratum (ordinal
    4) — ten strata in one physical step, no intervening mechanism (skips:true).
    Under one-pack-per-stratum the two ends live in two packs: this pack owns the
    skip CRO and the community cause; it imports macromolecular_stratum (down the
    ordinal ladder) for the gene-expression effect's id. Because the skip runs
    from HIGH ordinal to LOW, that cross-pack reference is a DOWNWARD layer edge —
    so the layer-skipping channel is expressed WITHOUT fighting the layer rule.
    That the extreme cross-stratal construct falls out as the cleanest downward
    edge is the strata arm's headline positive result (see LEDGER.md).

    Imports the minting vocabulary (0), the macromolecular stratum (2, for the
    gene occurrent and the macromolecular stratum record the skip classification
    needs), and PrologAI's causal_core (external) for the skip classifier — all
    downward, so its layer(6) is clean.
*/

% Declare the module: the community stratum's constructs plus the skip and signature checks.
:- module(community_stratum, [
    % community_stratum_stratum/1: the community-and-society stratum record (ordinal 14).
    community_stratum_stratum/1,
    % community_stratum_social_occurrent/1: the chronic-social-subordination process (the skip's high end).
    community_stratum_social_occurrent/1,
    % community_stratum_skip_cro/1: the skipping causal_relation_object (community -> macromolecular).
    community_stratum_skip_cro/1,
    % community_stratum_skip_check/2: the semantic classification and skip-gaps of the cortisol CRO.
    community_stratum_skip_check/2,
    % community_stratum_signed_assertion/1: the Ed25519-signed provenance over the skip CRO.
    community_stratum_signed_assertion/1,
    % community_stratum_records/1: the labelled list of this stratum's four structure records.
    community_stratum_records/1
]).

% Import the shared minting vocabulary (Layer 0).
:- use_module(library(causal_grounding)).
% Import the macromolecular stratum (Layer 2) — the skip reaches DOWN to it for the gene occurrent.
:- use_module(library(macromolecular_stratum)).
% Import PrologAI's Causalontology engine (external) for the skip classification and gaps.
:- use_module(library(causal_core)).

% -- community_stratum_stratum(-Out): the community-and-society stratum record (ordinal 14).
community_stratum_stratum(Out) :-
    % Mint the community-and-society stratum with the anatomy's fields.
    cm_stratum("community_and_society", "neuroendocrine", 14, "community", ["sociology"], Out).

% -- community_stratum_social_occurrent(-Out): the chronic-social-subordination process at this stratum.
community_stratum_social_occurrent(Out) :-
    % Read this pack's own stratum id.
    community_stratum_stratum(SCommunity),
    % Mint the chronic-social-subordination occurrent.
    cm_occ("chronic_social_subordination", "process", SCommunity.id, Out).

% -- community_stratum_skip_cro(-Out): the SKIPPING CRO — community (14) -> macromolecular (4), skips:true.
community_stratum_skip_cro(Out) :-
    % The cause is this pack's own social-subordination occurrent.
    community_stratum_social_occurrent(OSocial),
    % The effect is the macromolecular gene-expression occurrent, reached DOWN the ladder.
    macromolecular_stratum_gene_occurrent(OGene),
    % Mint the causal_relation_object flagged skips:true (the absence of a mechanism is a positive finding).
    cm_cro([OSocial.id], [OGene.id], [skips-true], Out).

% -- community_stratum_signed_assertion(-Signed): an Ed25519-signed provenance assertion over the skip CRO.
community_stratum_signed_assertion(Signed) :-
    % Read the skip CRO's content-addressed id.
    community_stratum_skip_cro(SkipCro),
    % Mint and sign the provenance assertion over that id.
    cm_signed_assertion_over(SkipCro.id, Signed).

% -- community_stratum_skip_check(-Class, -Gaps): classify the cortisol CRO and read its skip-gaps.
community_stratum_skip_check(Class, Gaps) :-
    % Mint the skip CRO and the two occurrents it relates (one here, one imported from macromolecular).
    community_stratum_skip_cro(SkipCro),
    community_stratum_social_occurrent(OSocial),
    macromolecular_stratum_gene_occurrent(OGene),
    % Mint the two strata the CRO spans (this pack's community, and the imported macromolecular).
    community_stratum_stratum(SCommunity),
    macromolecular_stratum_stratum(SMacro),
    % Build the occurrent and stratum maps the classifier needs.
    cm_map_of([OSocial, OGene], OccMap),
    cm_map_of([SCommunity, SMacro], StratumMap),
    % Classify the cross-stratal relation (expected: skipping).
    causal_core_classify(SkipCro, OccMap, StratumMap, Class),
    % Read the skip-gaps (expected: none — the absence of a mechanism is a positive finding).
    causal_core_skip_gaps(SkipCro, Class, Gaps).

% -- community_stratum_records(-Records): this stratum's four structure records.
community_stratum_records(Records) :-
    % Mint the stratum, the social occurrent, the skip CRO, and the signed assertion.
    community_stratum_stratum(SCommunity),
    community_stratum_social_occurrent(OSocial),
    community_stratum_skip_cro(SkipCro),
    community_stratum_signed_assertion(Signed),
    % Assemble the labelled record list (same names the slice used).
    Records = [
        record(stratum_community,          stratum,                SCommunity),
        record(occurrent_social_subordination, occurrent,          OSocial),
        record(cro_cortisol_skip,          causal_relation_object, SkipCro),
        record(assertion_skip_provenance,  assertion,              Signed)
    ].
