function [X,B] = in_range(x,Xlim)
%IN_RANGE filters elements of real-valued array if in/out-side a min-max limit
%       [X,B] = in_range(x,Xlim)
%
%   X is filtered elements (1D array)
%   B is boolean array indicating whether elem is in/out (1 if IN)
%   
%   x is the input array
%   Xlim is the [min, max] limit (inclusive)
%
% DKS 2019

B = abs(x - mean(Xlim)) <= range(Xlim)/2;
X = x(B);

end