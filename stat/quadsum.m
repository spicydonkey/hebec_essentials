function S = quadsum(varargin)
%QUADSUM sums inputs in quadrature.
%   S = quadsum(varargin)
% DKS 2020
N = nargin;
S = 0;
for ii = 1:N
    S = S + varargin{ii}.^2;
end
S = sqrt(S);
end