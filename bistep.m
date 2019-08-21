function v = bistep(cent,dx,vlim)
% BISTEP: bi-directional creation of linearly-spaced vector
%
%   v = bistep(cent,dx,vlim)
%
% DKS 2019

% included integer range
nn = ceil((vlim(1)-cent)/dx):floor((vlim(2)-cent)/dx);	

v = cent + nn*dx;       % the vector

end
