% State the fact: name(cellular_stratum) — the pack for the cellular stratum (ordinal 6).
name(cellular_stratum).
% State the fact: version('0.1.0') — a granularity-experiment prototype.
version('0.1.0').
% State the fact: title naming the cellular stratum, which the slice names but does not populate.
title('Connectome strata — cellular_stratum (ordinal 6): the cellular level (named, unpopulated by this slice)').
% State the fact: author is the PrologAI Community.
author('PrologAI Community', 'ai.university.aiu@gmail.com').
% State the fact: home points at the connectome-strata repository.
home('https://github.com/ai-university-aiu/connectome-strata').
% State the fact: download points at the repository releases page.
download('https://github.com/ai-university-aiu/connectome-strata/releases').
% State the fact: requires([]) — dependencies are declared as library imports in the module.
requires([]).
% State the fact: layer(3) — ordinal 6 ranks second among the strata, so it takes the next stratum layer.
layer(3).
