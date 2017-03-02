% Thomas-Fermi distribution of BEC in 1D (TOF)- 1D inverted parabola
% 02/03/2017
% DK Shin

% params: [n0, W]

function n_TF = tf_dist(r, params)
    n0=params(1);   % condensate peak density
    W=params(2);    % condensate TF-width (full)
    
    % inverted parabola
    n_TF = n0 - (4*n0/W^2)*(r.^2);
    n_TF(n_TF<0)=0;     % zero-cutoff
end