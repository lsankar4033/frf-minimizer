
% Calculate the probability that FRF - TRF >= 0
function d = d_calc(xjt, aij, li, Ai, st, sigma_f, mean_t, sigma_t)
    mean_f = frf_calc(xjt, aij, li, Ai, st);
    mean_d = mean_f - mean_t;

    sigma_d = sqrt(sigma_f ^ 2 + sigma_t ^ 2);
    
    d = 1 - normcdf(0, mean_d, sigma_d);
end


% Calculate the FRF for a given set of parameters
% Doesn't take into account uncertainty
function frf = frf_calc(xjt, aij, li, Ai, st)
    T = size(xjt, 2);

    gas_portions = aij * xjt;
    for i = 1:size(gas_portions, 1)
        for t = 1:size(gas_portions, 2)
            decay_coeff = exp( -(T - t) / li(i) );
            gas_portions(i, t) = gas_portions(i, t) * decay_coeff;
        end
    end

    emission_portions = Ai * gas_portions;
    
    if size(st, 1) == 1
        st = ones(T, 1) * st(1);
    end
    frf = emission_portions * st;
end
