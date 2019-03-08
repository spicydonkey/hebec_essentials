function [H,hdist] = vis_halo_distribution(zxy)
%vis_halo_distribution - diagnostic for halo distribution
%
% Syntax:  [H,hdist] = vis_halo_distribution(zxy)
%
% Inputs:
%   zxy     -  Nx3 array of ZXY vectors
%
% Outputs:
%   H       -  figure handle
%   hdist   -  distribution graphics obj struct 
%
% Example:
%
%
% Other m-files required:
% Subfunctions: none
% MAT-files required: none
%
% See also:
% Author: David Shin
% Work address
% email: david.shin@anu.edu.au
% Website: https://github.com/spicydonkey
% March 2019; Last revision:
%------------- BEGIN CODE --------------

% configs
nbins_r=100;
nbins_azel=[60,30];
bin_alpha=0.05*pi;
nbins_az=100;
nbins_el=100;


H=figure('Name','vis_halo_distribution','Units','centimeters','Position',[0 0 8.6 12],'Renderer','painters');

% radial distribution ---------------------------------
ax=subplot(4,1,1);
r=vnorm(zxy,2);     % norms
r_ed=linspace(min(r),max(r),nbins_r+1);
[n_r,r_cent,hdist.r]=radialprofile(r,r_ed,1);
hdist.r.Color='k';
set(ax,'Layer','top');

% 2D lat-lon distribution ---------------------------------
ax=subplot(4,1,2);
[az,el]=sphgrid(nbins_azel(1),nbins_azel(2));
n_azel=arrayfun(@(th,ph) size(inCone(zxy,th,ph,bin_alpha),1),...
    az,el)/cone_solang(bin_alpha);
n_azel=n_azel./max(n_azel(:));
hdist.azel=plotFlatMapWrappedRad(az,el,n_azel,'rect');
axis tight;
axis equal;
cbar=colorbar();
cbar.Label.String='P';
set(ax,'Layer','top');


% Th/Phi dependency =============================
vspol=zxy2sphpol(zxy);

% azim dependency ----------------------------
ax=subplot(4,1,3);
[n_az,az_ed]=histcounts(vspol(:,1)/pi,nbins_az);
n_az=n_az/max(n_az);    % norm to max
hdist.az=stairs(edge2cent(az_ed),n_az);
hdist.az.Color='k';
xlabel('\theta/\pi');
ylabel('P');
xlim([-1,1]);
set(ax,'Layer','top');


% elev dependency ----------------------------
ax=subplot(4,1,4);
[n_el,el_ed]=histcounts(vspol(:,2)/pi,nbins_el,'Normalization','pdf');
elev_bin_vol=abs(diff(cone_solang(elev2polar(pi*el_ed))));
n_el=n_el./elev_bin_vol;     % normalise by bin vol
n_el=n_el/max(n_el);        % normalise by max
hdist.el=stairs(edge2cent(el_ed),n_el);
hdist.el.Color='k';

xlabel('\phi/\pi');
ylabel('P');
xlim([-0.5,0.5]);
set(ax,'Layer','top');

%------------- END OF CODE --------------
end