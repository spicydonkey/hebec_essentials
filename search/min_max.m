function [M,I] = min_max(x)
%MIN_MAX finds the minimum and maximum of a vector and returns as a vector [min,max]
%
%	[M,I] = min_max(x)
%
%   I is index to min and max
%
% DKS 2019

M = [min(x(:)),max(x(:))];

end