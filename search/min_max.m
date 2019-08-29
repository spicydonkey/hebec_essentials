function [M,I] = min_max(x)
%MIN_MAX finds the minimum and maximum of a vector and returns as a vector [min,max]
%
%	[M,I] = min_max(x)
%
%   I is index to min and max
%
% DKS 2019

[x_min,I_min] = minall(x);
[x_max,I_max] = maxall(x);

M = [x_min,x_max];
I = [I_min,I_max];

end