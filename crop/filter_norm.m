function [xf,b_filt] = filter_norm(x,rmin,rmax)
%[xf,b_filt] = filter_norm(x,rmin,rmax)
%
%   Filters vectors outside norm-range
%
%   x: array of row vectors
%   rmin: min of range
%   rmax: max of range
%
%   xf: filtered array of row vectors
%   b_filt: boolean array of vectors in range

r = sqrt(sum((x.^2),2));        % get norm - row-vectors

b_filt = (r>rmin & r<rmax);
xf = x(b_filt,:);

end