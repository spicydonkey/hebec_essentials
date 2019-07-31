function [I,vals] = idxNearest(V,x)
% [I, vals] = idxNearest(V, x)
% finds the indices of the values in V closest to x
%
% DKS
% 2019-07-31

[~,I] = min(abs(V(:) - x(:)'),[],1);
vals = V(I);

end