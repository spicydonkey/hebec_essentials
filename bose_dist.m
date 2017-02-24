% k-space Bose distribution
% params: [N_THERMAL, T_APPARENT]

function n_bose = bose_dist(params, k)
    Nth=params(1);
    Ta=params(2);
    
    n_bose=Nth*g_bose(exp(-6.0597e-20*(k.^2)/Ta))/(4.4870e29*(Ta^(3/2)));
end