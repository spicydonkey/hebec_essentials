function S = ind2subv(siz,I)
%IND2SUBV vector-subscript from linear index.
%   IND2SUBV is used to determine the equivalent subscript values
%   corresponding to a given single index into an array.
%
%   S = IND2SUBV(SIZ,IND) returns the arrays S containing the
%   equivalent N-dimensional subscripts corresponding to the index
%   matrix IND for a matrix of size SIZ.  
%
%   Class support for input IND:
%      float: double, single
%      integer: uint8, int8, uint16, int16, uint32, int32, uint64, int64
%
%   See also IND2SUB, SUB2IND, FIND.
 

%   Modified by DKS 2020
%   Original IND2SUB Copyright 1984-2015 The MathWorks, Inc. 

% siz = double(siz);
% N = length(siz);

D = length(siz);        % dimension
k = cumprod(siz);
if D > 2
    for ii = D:-1:3
        vi = rem(I-1, k(ii-1)) + 1;
        vj = (I - vi)/k(ii-1) + 1;
        S(:,ii) = double(vj);
        I = vi;
    end
end
if D >= 2
    vi = rem(I-1, siz(1)) + 1;
    S(:,2) = double((I - vi)/siz(1) + 1);
    S(:,1) = double(vi);
else 
    S(:,1) = double(I);
end