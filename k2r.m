% k-space to real-space converter
% Simple k-vector dist (at COM after TOF from trap release) to radial dist
% transform
% DKS 08/02/2017
%
% INPUT:    k [m^-1]
% OUTPUT:   r [m]
%

function r=k2r(k)
m=6.6465e-27;       % mass of helium [kg]
hbar=1.0546e-34;    % Plank constant [m^2kg/s]
tof=0.43;           % default free-fall tof for He* BEC experiment

r=k/(m/(hbar*tof));