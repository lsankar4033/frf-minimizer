sigma_f = 0.1;
sigma_t = 0.1;

mean_t = 100;

% Load in params from file
[aij, li, Ai, st, T] = params_from_file('params.xls');

% Do grid search with params and frf function
xjt = grid_search(aij, li, Ai, st, T, sigma_f, sigma_t, mean_t, @d_calc, 0.5)