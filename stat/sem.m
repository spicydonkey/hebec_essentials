function y = sem(x)
% Standard error of the mean
%   
%   x: 1D vector of samples
%   y: standard error of the mean (SEM)
%
% DKS 2020

y = std(x(:))/sqrt(numel(x));

end