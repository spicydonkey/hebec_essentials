function ax_Ellipsoid = vis_ellipsoid(center,radii,evecs,v)
%vis_ellipsoid - plots ellipsoid
%
% Syntax:  vis_ellipsoid(center,radii,evecs)
%
% Inputs:
%   * center    -  ellispoid or other conic center coordinates [xc; yc; zc]
%   * radii     -  ellipsoid or other conic radii [a; b; c]
%   * evecs     -  the radii directions as columns of the 3x3 matrix
%   * v         -  the 10 parameters describing the ellipsoid / conic algebraically: 
%                Ax^2 + By^2 + Cz^2 + 2Dxy + 2Exz + 2Fyz + 2Gx + 2Hy + 2Iz + J = 0

% Outputs:
%   ax_Ellipsoid - struct of ellipsoid graphics object
%
% Example:
%
% Other m-files required: arrow3
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

% configs
col_cent='k';
col_semiax={'r','g','b'};
col_surf='b';

% center ---------------------------------------------
ax_Ellipsoid.center = scatter3(center(1),center(2),center(3),30,'o','filled','MarkerFaceColor',col_cent,'MarkerEdgeColor','none');

% principal semi-axes ---------------------------------------------
for ii=1:3
    p1 = center';
    p2 = center' + radii(ii)*evecs(:,ii)';
    ax_Ellipsoid.arrow3{ii} = arrow3(p1,p2,col_semiax{ii});
    ax_Ellipsoid.arrow3{ii}(1).LineWidth=1.25;
end

% surface ---------------------------------------------
ax_lim=2*max(radii)*[-1,1];      % axis lims
ax_ngrid=100;       % grid # per dim

[x,y,z] = meshgrid(linspace(ax_lim(1),ax_lim(2),ax_ngrid));
f_ellipsoid = ellipsoidEqn(v,x,y,z);      

ax_Ellipsoid.surf = patch( isosurface( x, y, z, f_ellipsoid, 0 ) );
set(ax_Ellipsoid.surf,'FaceColor',col_surf,'FaceAlpha',0.2,'EdgeColor','none');

%------------- END OF CODE --------------
end