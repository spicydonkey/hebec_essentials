function weight_g = weight_latlon_grid(el_g)
% Solid-angle proportional weights for linearly spaced latitutde-longitude
% grid
%
%   el_g: #azim x #elev (lat-lon) grid points of elevation angles in radian
%
%   weight_g: lat-lon grid of weights proportional to represented solid-angle
%
% DKS
% 2019-02-28

weight_g = abs(sin(el_g));

end