% In-plane integrated 1D density profile - 1D inverted parabola
% 02/03/2017
% DK Shin

% params: [N0, W]

function Q_TF = tf_Q(r, params)
       N0=params(1);    % condensate population number
       W=params(2);     % condensate TF-width (perp to integrated dims)
       
       Q0 = 1.5*N0/W;   % countrate must integrate to condensate population
       
       % inverted parabola model
       Q_TF = Q0 - (4*Q0/W^2)*(r.^2);
       
       Q_TF(Q_TF<0)=0;      % zero cut-off
end