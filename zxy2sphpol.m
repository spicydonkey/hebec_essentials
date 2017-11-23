function sphpol = zxy2sphpol(zxy)
% SPHPOL = ZXY2SPHPOL(ZXY)
%
% Converts counts in Cartesian coordinate to Spherical coord
%
% I/O
% ZXY: should be a Nx3 array
%
% SPHPOL: Nx3 array of sph polar coord [AZIM,ELEV,NORM] (Matlab convention)

rad=sqrt(sum(zxy.^2,2));    % radius
azim=atan2(zxy(:,3),zxy(:,2));  % azimuthal ang=atan2(Y/X) - 4-quadrant inverse tangent
elev=asin(zxy(:,1)./rad);       % elevation ang=asin(Z/NORM)

sphpol=[azim, elev, rad];   % SPHPOL=(azim,elev,R)

end