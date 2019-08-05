function v = linspace_lim(vlim,n)
%LINSPACE_LIM wrapper for linspace.
%   LINSPACE(VLIM,N) 
% DKS 2019

if nargin == 1
    v = linspace(vlim(1),vlim(2));
else
    v = linspace(vlim(1),vlim(2),n);
end

end
