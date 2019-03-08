function H = vis_ellipsoid_fit(xyz_data,center,radii,vaxis,v)
%vis_ellipsoid_fit - diagnostic for ellipsoid fit to data
%
% Syntax:  H = vis_ellipsoid_fit(xyz_data,center,radii,vaxis,v)
%
% Inputs:
%   * xyz_data  -  Nx3 array of XYZ vectors
%   * center    -  ellispoid or other conic center coordinates [xc; yc; zc]
%   * radii     -  ellipsoid or other conic radii [a; b; c]
%   * evecs     -  the radii directions as columns of the 3x3 matrix
%   * v         -  the 10 parameters describing the ellipsoid / conic algebraically: 
%                Ax^2 + By^2 + Cz^2 + 2Dxy + 2Exz + 2Fyz + 2Gx + 2Hy + 2Iz + J = 0
%
% Outputs:
%   H           -  figure handle
%
% Example:
%
%
% Other m-files required: ellipsoidEqn
% Subfunctions: none
% MAT-files required: none
%
% See also: ellipsoid_fit
% Author: David Shin
% Work address
% email: david.shin@anu.edu.au
% Website: https://github.com/spicydonkey
% March 2019; Last revision:
%------------- BEGIN CODE --------------

H=figure('Name','vis_ellipsoid_fit','Units','centimeters','Position',[0 0 18 8.6],'Renderer','painters');

% 3D: data and fitted ellipsoid =========================
ax=subplot(2,4,[1,2,5,6]);
hold on;

% raw data ---------------------------------------------
nmax_data_plot = 3e3;       % produces visually good well-filled halo
n_data = size(xyz_data,1);
if n_data > nmax_data_plot
    % rng subset for scatter plot
    i_data_plot = randperm(size(xyz_data,1),nmax_data_plot);
    xyz_data_plot=xyz_data(i_data_plot,:);
else
    xyz_data_plot=xyz_data;
end
s_data = vis_zxy_3d(xyz2zxy(xyz_data_plot));

% ellipsoid ----------------------------------------------
vis_ellipsoid(center,radii,vaxis,v);

axis tight;
axis equal;
xlabel('$x$ (m)');
ylabel('$y$ (m)');
zlabel('$z$ (m)');

axis vis3d;
camlight;
lighting phong;


% asphericity ===============================================
%   radii & center
% center
ax=subplot(2,4,3);
c=categorical({'x','y','z'});
bb_cent = bar(c,1e3*center);
set(bb_cent,'FaceColor','k');
title('O (mm)');

% semi-axes lengths
ax=subplot(2,4,4);
bb_rad = bar(1:3,diag(1e3*radii),'stacked');
set(bb_rad(1),'FaceColor','r');
set(bb_rad(2),'FaceColor','g');
set(bb_rad(3),'FaceColor','b');
title('semi-axes (mm)');


% residual ==================================================
ax=subplot(2,4,[7,8]);

res = ellipsoidEqn(v,xyz_data(:,1),xyz_data(:,2),xyz_data(:,3));

% histogram
hres = histogram(res,'Normalization','pdf','DisplayStyle','stairs','EdgeColor','k');
xlabel('residual (arb. unit)');
ylabel('pdf');
xlim([-0.5,0.5]);

H.Renderer='opengl';        % gives better image even when rasterised

% NOTE =================================================
% print this via HR PNG printer
%   print(gcf,'foo.png','-dpng','-r600');
% or
%   print_pnghr(gcf);

%------------- END OF CODE --------------
end