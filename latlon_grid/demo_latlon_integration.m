%% DEMO: integration on a latlon gridded sphere
% DKS
% 2018-11-20

% define lat-lon grid on sphere: non-uniform distribution of points
n_azel=[30,15];
[Az,El] = grid_azel(n_azel(1),n_azel(2));
% density-normalisation weighting
w_azel=cos(El);     % inversely proportional to density: a very simple relation!

% some function defined on a sphere
f_sph = @(th,phi) 1;        % uniform function
% f_sph = @(th,phi) sin(3*th).*cos(5*phi);        % uniform function

% function values evaluated at latlon grid
f = arrayfun(@(t,p) f_sph(t,p),Az,El);


figure;
subplot(2,2,[1,2]);
plot_sph_surf(Az,El,f);
colorbar;

% define regions to evaluate integrate function
n_azel_0=[71,17];       % latlon grid to centers of zones
[Az_0,El_0]=grid_azel(n_azel_0(1),n_azel_0(2));
alpha=0.1*pi;     % half-cone angle for zone

% get latlon grid masks for membership in integration regions
b_in=arrayfun(@(t,p) inZone(Az,El,t,p,alpha),Az_0,El_0,'UniformOutput',false);

% Normalised mean and variance
fw=f.*w_azel;       % weighted funcion values for density-normalised integration
F_mu = cellfun(@(b) sum(fw(b))/sum(w_azel(b)),b_in);        % weighted mean
F_std = cellfun(@(b) std(f(b),w_azel(b)),b_in);             % weighted standard deviation

subplot(2,2,3);
plot_sph_surf(Az_0,El_0,F_mu);
colorbar;

% wrong way to integrate!   assumes latlon is uniformly distributed
F_mu_wrong = cellfun(@(b) mean(f(b)),b_in);     
F_std_wrong = cellfun(@(b) std(f(b)),b_in);

subplot(2,2,4);
plot_sph_surf(Az_0,El_0,F_mu_wrong);
colorbar;