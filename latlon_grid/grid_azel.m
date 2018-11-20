function [azs,els] = grid_azel(n_az,n_el)
% GRID_LATLON creates lat-lon grid spanning the sphere
% DKS
% 2018-11-20

az=linspace(-pi,pi,n_az+1);
az=az(1:end-1);

el=linspace(-pi/2,pi/2,n_el);

[azs,els]=ndgrid(az,el);

end