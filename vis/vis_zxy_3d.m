function s = vis_zxy_3d(zxy)
%vis_zxy_3d - plot experimental data (ZXY-vectors) as a 3D scatter
%
% Syntax:  [H] = vis_zxy_3d(zxy,coord_type)
%
% Inputs:
%    zxy - Nx3 array of ZXY-vectors
%
% Outputs:
%    s - handle to Scatter
%
% Other m-files required: none
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

% default config ----------------------------------
mark_size = 5;
mark_col = 'k';
mark_alpha = 0.25;


xyz = zxy2xyz(zxy);
s = scatter3(xyz(:,1),xyz(:,2),xyz(:,3),mark_size,'o');
s.Marker='o';
s.MarkerEdgeColor='none';
s.MarkerFaceColor=mark_col;
s.MarkerFaceAlpha=mark_alpha;


axis equal;
xlabel('$x$');
ylabel('$y$');
zlabel('$z$');
view(3);
box on;

%------------- END OF CODE --------------

end