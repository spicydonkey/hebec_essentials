function v = gridToVecs(x)
% N-dimensional grid to array of vectors.
% 
%   v = gridToVecs(x)
%
%   x:	n-dim x 1 cell array of grid points (n-dim array) in each dimension).
%
%   v:  N x n-dim array. (each row is a vector of grid location)

% DKS (dk.shin1992@gmail.com), 2020

v = cellfun(@(X) X(:),x,'uni',0);       % reshape each grid as 1D vector
v = cat(2,v{:});
