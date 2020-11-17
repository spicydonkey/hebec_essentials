function r = laprnd(mu,b,varargin)
%LAPRND Random arrays from Laplace (double-exponential) distribution.
%   R = EXPRND(MU,B,M,N,...) or R = EXPRND(MU,B,[M,N,...]) returns an array
%   of random numbers chosen from the Laplace distribution with mean 
%   parameter MU, and variance 2B^2.  
%   R is an array of size M-by-N-by-...
%

%   See also 

%   LAPRND uses the inversion method.

%   References:
%      [1]  https://en.wikipedia.org/wiki/Laplace_distribution

% DKS (dk.shin1992@gmail.com), 2020

if nargin < 2
    error(message('stats:laprnd:TooFewInputs'));
end

sizeOut = varargin;
if iscell(sizeOut)
    sizeOut = [sizeOut{:}];
end

% Generate Laplacian noise
u = rand(sizeOut)-0.5;
r = mu - b.*sign(u).*log(1- 2*abs(u));
