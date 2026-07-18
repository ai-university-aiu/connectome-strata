% State the fact: name(region_stratum) — the pack for the brain-region stratum (ordinal 9).
name(region_stratum).
% State the fact: version('0.1.0') — a granularity-experiment prototype.
version('0.1.0').
% State the fact: title naming the region stratum, which holds all three co-stratal regions and the interfaces.
title('Connectome strata — region_stratum (ordinal 9): the region level, its regions, interfaces and runtime').
% State the fact: author is the PrologAI Community.
author('PrologAI Community', 'ai.university.aiu@gmail.com').
% State the fact: home points at the connectome-strata repository.
home('https://github.com/ai-university-aiu/connectome-strata').
% State the fact: download points at the repository releases page.
download('https://github.com/ai-university-aiu/connectome-strata/releases').
% State the fact: requires([]) — dependencies are declared as library imports in the module.
requires([]).
% State the fact: layer(5) — ordinal 9 ranks fourth among the strata; it imports the synaptic stratum below it.
layer(5).
