function v = max2unit(V)
% MAX2UNIT: normalises a vector by a constant scaling to make max elem = 1
%   
%   v = max2unit(V)
%
% DKS 2019

v = V./max(V);

end