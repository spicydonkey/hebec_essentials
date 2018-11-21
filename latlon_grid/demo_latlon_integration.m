%% DEMO: integration on a latlon gridded sphere
% DKS
% 2018-11-20

% CONFIG
[c,cl,cd]=palette(3);

% define lat-lon grid on sphere: non-uniform distribution of points
n_azel=[200,100];
[Az,El] = grid_azel(n_azel(1),n_azel(2));
% density-normalisation weighting
w_azel=cos(El);     % inversely proportional to density: a very simple relation!

% some function defined on a sphere
f_sph = @(th,phi) 1;        % uniform function
% f_sph = @(th,phi) cos(phi+0.1*pi);        % funky function

% function values evaluated at latlon grid
f = arrayfun(@(t,p) f_sph(t,p),Az,El);

% define regions to evaluate integrate function
n_azel_int=[50,25];       % latlon grid to centers of zones
[Az_int,El_int]=grid_azel(n_azel_int(1),n_azel_int(2));
alpha_int=0.1*pi;     % half-cone angle for zone

% get latlon grid masks for membership in integration regions
b_in=arrayfun(@(t,p) inZone(Az,El,t,p,alpha_int),Az_int,El_int,'UniformOutput',false);

%%% statistics
% Normalised mean and variance
fw=f.*w_azel;       % weighted funcion values for density-normalised integration
F_mu = cellfun(@(b) sum(fw(b))/sum(w_azel(b)),b_in);        % weighted mean
F_std = cellfun(@(b) std(f(b),w_azel(b)),b_in);             % weighted standard deviation

% wrong way to integrate!   assumes latlon is uniformly distributed
F_mu_wrong = cellfun(@(b) mean(f(b)),b_in);     
F_std_wrong = cellfun(@(b) std(f(b)),b_in);

%%% sum of function
F_sum_bias = cellfun(@(b) sum(f(b)),b_in);        % weighted sum
F_sum_unif = cellfun(@(b) sum(fw(b)),b_in);        % weighted sum

% normalise
Fn_sum_bias=F_sum_bias/max(F_sum_bias(:));
Fn_sum_unif=F_sum_unif/max(F_sum_unif(:));

%% VIS:
h=figure;

% test function on spher
subplot(3,2,1);
plot_sph_surf(Az,El,f);

cbar=colorbar('eastoutside');
cbar.Label.Interpreter='latex';
cbar.Label.String='function value $f(\theta,\phi)$';

title('test function');

% lat-lon weights
subplot(3,2,2);
plot_sph_surf(Az,El,w_azel);

cbar=colorbar('eastoutside');
cbar.Label.Interpreter='latex';
cbar.Label.String='$w$';

title('latlon weights $w = \cos \phi$');

% spherical plot
subplot(3,2,3);
plot_sph_surf(Az_int,El_int,Fn_sum_bias);
title('biased sum');
cbar=colorbar('eastoutside');
cbar.Label.Interpreter='latex';
cbar.Label.String='$\sum_{S} f$ (normed)';


subplot(3,2,4);
plot_sph_surf(Az_int,El_int,Fn_sum_unif);
title('weighted sum');
cbar=colorbar('eastoutside');
cbar.Label.Interpreter='latex';
cbar.Label.String='$\sum_{S} wf$ (normed)';

% flat image
subplot(3,2,5);
plotFlatMapWrappedRad(Az_int,El_int,Fn_sum_bias,'rect','texturemap');

ax=gca;
box on;
set(ax,'Layer','Top');
set(ax,'YDir','normal');
cbar=colorbar('eastoutside');
cbar.Label.Interpreter='latex';
cbar.Label.String='$\sum_{S} f$ (normed)';
axis tight;
xlabel('$\theta$ (deg)');
ylabel('$\phi$ (deg)');
xticks(-180:90:180);
yticks(-90:45:90);

subplot(3,2,6);
plotFlatMapWrappedRad(Az_int,El_int,Fn_sum_unif,'rect','texturemap');

ax=gca;
box on;
set(ax,'Layer','Top');
set(ax,'YDir','normal');
cbar=colorbar('eastoutside');
cbar.Label.Interpreter='latex';
cbar.Label.String='$\sum_{S} wf$ (normed)';
axis tight;
xlabel('$\theta$ (deg)');
ylabel('$\phi$ (deg)');
xticks(-180:90:180);
yticks(-90:45:90);
