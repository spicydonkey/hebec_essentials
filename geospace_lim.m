function v = geospace_lim(vlim,n)
%GEOSPACE_LIM geometrically spaced sequence between limits.
%   v = geospace_lim(vlim,n)
% DKS 2020

if nargin == 1
    v = geospace(vlim(1),vlim(2));
else
    v = geospace(vlim(1),vlim(2),n);
end

end