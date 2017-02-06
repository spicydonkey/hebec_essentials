% He* BEC experiment TXY to K-space converter
%
% Summary:
% Raw data point [TOF;X;Y] --> k-space [Kz,Kx,Ky]
% Conversion relying on ballistic expansion of free-falling atoms released
% at time t_start (mean(t)-0.430 sec if unspecified)
%
% Author: DKS 07/02/2017
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

function k_zxy=txy2kvect(txy,t_start)
% define constants
g=9.81;             % gravitational acceleration [m/s^2]
m=6.6465e-27;       % mass of helium [kg]
hbar=1.0546e-34;    % Plank constant [m^2kg/s]

t_cent=mean(txy(:,1));      % centre of condensate in T-dim

% get time when condensate was released from trap
if ~exist('t_start','var')
    t_start=t_cent-0.430;   % assume condensate released with negligible vert velocity
end

txy(:,1)=txy(:,1)-t_start;  % shift to TOF from release from trap
txy_cent=mean(txy,1);       % evaluate cond centre (reference)
tof=txy_cent(1);     % mean time of flight

ZXY=zeros(size(txy));   % ballistically expanded ZXY in COM frame

% Z
ZXY(:,1)=(g*tof/2)*(tof^2-txy_cent(:,1).^2)./txy_cent(:,1);

% simple shifts in X,Y coords
ZXY(:,2)=txy(:,2)-txy_cent(2);
ZXY(:,3)=txy(:,3)-txy_cent(3);

%% K-space conversion
k_zxy=(m/(hbar*tof))*ZXY;   % k-space centred around condensate (units [m-^1]3)