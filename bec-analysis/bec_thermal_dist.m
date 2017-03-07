% BEC in thermal background distribution in 1D
% Sum of BEC (Thomas-Fermi approximation) and Bose-Einstein distribution as
% thermal background
%
% 07/03/2017
% DK Shin

% params: [n0,W, Nth,Ta]

function n_dist = bec_thermal_dist(params,r)
    % constants
    hbar=1.0546e-34;
    tof=0.413;          % freefall TOF
    m=6.6465e-27;       % mass of helium [kg]
    
    % parse inputs
    n0=params(1);
    W=params(2);
    Nth=params(3);
    Ta=params(4);
    
    % r-k conversion
    k=r2k(r);   % TODO - thermal distribution is currently in k-space
    
    n_BEC = tf_dist([n0,W],r);
    n_thermal=((m/(hbar*tof))^3)*bose_dist([Nth,Ta],k);    % TODO - reqs scaling since the function is defined in k-space
    
    n_dist = n_BEC + n_thermal;
    
%     % DEBUG
%     figure();
%     hold on;
%     plot(r,n_BEC,'--','DisplayName','BEC','LineWidth',1.5);
%     plot(r,n_thermal,':','DisplayName','Thermal','LineWidth',1.5);
%     plot(r,n_dist,'-','DisplayName','BEC + Thermal','LineWidth',2);
%     legend('show');
%     xlabel('r [m]');
%     ylabel('n(r) [counts/m$^3$]');
end