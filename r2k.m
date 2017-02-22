% Real-space to k-space converter
% Simple radial dist (at COM after TOF from trap release) to k-vector
% transform
% DKS 07/02/2017
%
% INPUT:    r [m]
% OUTPUT:   k [m^-1]
%

function k=r2k(r)
m=6.6465e-27;       % mass of helium [kg]
hbar=1.0546e-34;    % Plank constant [m^2kg/s]
tof=0.416;           % default free-fall tof for He* BEC experiment

k=(m/(hbar*tof))*r;
