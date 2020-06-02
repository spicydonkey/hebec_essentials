function n = hist_zxy_azel(zxy,azel_ed)
%   Histogram cartesian vectors in ZXY coord into 2D lat-lon
%   grid.
%
%   latlon_ed: 1x2 cell-array of bin edges in lat/long-itude
%   

% Cart to sph-polar
vs=zxy2sphpol(zxy);

% 2D histogram
n=nhist(vs(:,1:2),azel_ed);

end