function y = thermalpdf(x,mu)
%THERMALPDF Single-mode thermal probability density function.
%   Y = THERMALPDF(X,MU) returns the single-mode thermal probability 
%   density function with mean MU at the values in X.
%
%   The size of Y is the common size of X and MU. A scalar input   
%   functions as a constant matrix of the same size as the other input.    
%
%   BEWARE: when inputting errorneous cases for negative MU, fractional X.
%
%   See also POISSPDF.
%   DKS 2020

if sumall(isinteger(x) & ~(x<0))>0
    error('X must be non-negative integer.');
end
if sumall(mu<0)>0
    error('MU must be non-negative.');
end

y = (1./mu).*(1+1./mu).^(-(x+1));

end