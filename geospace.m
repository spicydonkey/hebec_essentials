function y = geospace(a,b,n)
% y = geospace(a,b,n)
% generates a geometrically spaced sequence between a and b
% DKS 2020

if nargin < 3
    n = 50;                 % default n
end

% a and b should be positive.
if ~( a > 0 && b > 0)
    error('a and b needs to be positive.');
end
    

r = (b/a)^(1/(n-1));        % single geometric step
y = a*(r.^(0:(n-1)));

y(end) = b;                 % fix possible error at end