% Load in params from file
[aij, li, Ai, st] = params_from_file('params.xls');

% Do grid search with params and frf function
xjt = grid_search(aij, li, Ai, st, T, f)