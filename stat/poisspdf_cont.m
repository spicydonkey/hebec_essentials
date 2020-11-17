function y = poisspdf_cont(x,lambda)
% Poisson probability mass function with continuous interpolation for
% non-integer values
%   NOTE: non-integer values give strictly 0 pmf for Poisson distribution.
% DKS 2020
y = exp(x.*log(lambda) - lambda - gammaln(x+1) );
end