function X = linspace_nd(win,n)
% N-dimensional linearly spaced grid
% 
%   X = LINSPACE_ND(WIN,N)
%
%   win:    window limits in each dimension (n-dims x 2 array).
%   n:      number of points in each dimension to form a grid. (default =
%   100)
%
%   X:      n-dim x 1 cell array of grid points in each dimension (n x n x ... x array).

% DKS (dk.shin1992@gmail.com), 2020

if nargin < 2
    n = 100;
end

dim = size(win,1);
x_d = cell(dim,1);
for ii = 1:dim
    x_d{ii} = linspace(win(ii,1),win(ii,2),n);
end
X = cell(dim,1);
[X{:}] = ndgrid(x_d{:});

end