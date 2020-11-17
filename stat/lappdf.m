function y = lappdf(x,mu,b)
%LAPPDF Laplace probability density function (pdf).
%   Y = LAPPDF(X,MU,B) returns the pdf of the Laplace distribution with mean 
%   parameter MU, and variance 2B^2.

%   See also LAPRND

%   References:
%      [1]  https://en.wikipedia.org/wiki/Laplace_distribution

% DKS (dk.shin1992@gmail.com), 2020

if nargin < 3
    error(message('stats:lappdf:TooFewInputs')); 
end

% Return NaN for out of range parameters.
b(b < 0) = NaN;

y = exp(-abs(x-mu)/b)/(2*b);