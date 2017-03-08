% In-plane integrated 1D density profile
% 3D inverted paraboloid integrated in 2-dims
% 02/03/2017
% DK Shin

% params: [N0, W]

function Q_TF = tf_Q(params,r)
       N0=params(1);    % condensate population number
       W=params(2);     % condensate TF-width (perp to integrated dims)
       
       Q0=(15/16)*N0/W;
%        Q0 = 1.5*N0/W;   % countrate must integrate to condensate population
       
       % in-plane integrated profile
       inv_parab=1-(r.^2)/(W^2);
       inv_parab(inv_parab<0)=0;      % zero cut-off
       Q_TF=Q0*(inv_parab.^2);
       
%        % inverted parabola model
%        Q_TF = Q0 - (4*Q0/W^2)*(r.^2);
%        Q_TF(Q_TF<0)=0;      % zero cut-off
end