function S = findv(X)
% S = FINDV(X)
% Finds nonzero values in array X and returns location as vector-subscript form.
%
%
%   See also FIND, IND2SUBV
%   DKS 2020

I = find(X);
S = ind2subv(size(X),I);