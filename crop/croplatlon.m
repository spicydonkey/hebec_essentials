function [v,b,n] = croplatlon(V,lim_latlon)
% Get ZXY-vectors in lat-lon-norm region defined with min-max
% limits
%
%   v: vecs in region
%   b: boolean flagging vecs in region
%   n: nums of vecs in region
%
%   V: ZXY-vector array
%   lim_latlon: 1x3 cell-array of [min,max] limits in the order: azim,elev,norm
%       leave limit empty (i.e. []) to ignore
%

[b,n] = inlatlon(V,lim_latlon);    % find vecs in region
v = V(b,:);     % select vecs in region

end