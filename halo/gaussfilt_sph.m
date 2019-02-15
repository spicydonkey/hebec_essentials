function F = gaussfilt_sph(f,az0,el0,az_f,el_f,sig_beta)
% Angular Gaussian filter on 2D function defined on sphere
%
%   f: N(azim)xM(elev) array of function value defined at...
%   az0: 2D grid of azimuthal angle (rad)
%   el0: 2D grid of elev angle (rad)
%   az_f: 2D grid of azim to eval convolved function val
%   el_f:   " for elev
%   sig_beta: Gaussian RMS width (rad)
%
%   F: convolved function val defined at "az_f X el_f" grid
%
%
% DKS
% 2019-02-15

% for each grid point to eval F find angular dist to datapoints
beta = arrayfun(@(th,phi) diffAngleSph(th,phi,az0,el0),az_f,el_f,'UniformOutput',false);

%% Gaussian convolution on sphere
% Gaussian convolution factor
c_gauss=cellfun(@(th) normpdf(th,0,sig_beta),beta,'UniformOutput',false);

% convolved sum
F_sum=cellfun(@(c) sumall(c.*f,'omitnan'),c_gauss);

% find undefined (NaN) data
isDefined=~isnan(f);

% normalisation (discard for undefined)
F_norm=cellfun(@(c) sumall(c.*isDefined),c_gauss);

% normalised convolution
F = F_sum./F_norm;

end