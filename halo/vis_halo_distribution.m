function [H,hdist,ax] = vis_halo_distribution(zxy)
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
ax(1)=subplot(4,1,1);
r=vnorm(zxy,2);     % norms
r_ed=linspace(min(r),max(r),nbins_r+1);
[n_r,r_cent,hdist.r]=radialprofile(r,r_ed,1);
hdist.r.Color='k';

% 2D lat-lon distribution ---------------------------------
ax(2)=subplot(4,1,2);
[az,el]=sphgrid(nbins_azel(1),nbins_azel(2));
n_azel=arrayfun(@(th,ph) size(inCone(zxy,th,ph,bin_alpha),1),...
    az,el)/cone_solang(bin_alpha);
n_azel=n_azel./max(n_azel(:));
hdist.azel=plotFlatMapWrappedRad(az,el,n_azel,'rect');
axis tight;
axis equal;
box on;

set(ax(2),'Position',ax(2).OuterPosition);

set(ax(2),'XAxisLocation','origin');
xlabel('$\theta$');
ylabel('$\phi$');

cbar=colorbar('EastOutside');
cbar.Position(3)=0.025;
cbar.Label.String='P';
% change colorbar position
ax_pos = plotboxpos(ax(2));
% pos_ax=get(gca,'Position');
pos_cbar=get(cbar,'Position');
pos_cbar(3)=0.025;
pos_cbar(1)=ax_pos(1)+ax_pos(3)+1*pos_cbar(3);
set(cbar,'Position',pos_cbar);
% set(gca,'Position',pos_ax);     % return axis to original


% Th/Phi dependency =============================
vspol=zxy2sphpol(zxy);

% azim dependency ----------------------------
ax(3)=subplot(4,1,3);
[n_az,az_ed]=histcounts(rad2deg(vspol(:,1)),nbins_az);
n_az=n_az/max(n_az);    % norm to max
hdist.az=stairs(edge2cent(az_ed),n_az);
hdist.az.Color='k';
xlabel('$\theta (^\circ)$');
ylabel('P');
xlim(180*[-1,1]);


% elev dependency ----------------------------
ax(4)=subplot(4,1,4);
[n_el,el_ed]=histcounts(rad2deg(vspol(:,2)),nbins_el,'Normalization','pdf');
elev_bin_vol=abs(diff(cone_solang(elev2polar(deg2rad(el_ed)))));
n_el=n_el./elev_bin_vol;     % normalise by bin vol
n_el=n_el/max(n_el);        % normalise by max
hdist.el=stairs(edge2cent(el_ed),n_el);
hdist.el.Color='k';

xlabel('$\phi (^\circ)$');
ylabel('P');
xlim(90*[-1,1]);


% tidy
set(ax,'Layer','top');

%------------- END OF CODE --------------
end