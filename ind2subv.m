function S = ind2subv(siz,I)
%IND2SUBV vector of subscripts from linear index.
%
%   S = IND2SUBV(SIZ,IND) returns a vector S containing the
%   equivalent N-dimensional subscripts corresponding to the index
%   matrix IND for a matrix of size SIZ.  
%
%   See also IND2SUB, SUB2IND, FIND.%
%   DKS 2020
S = cell(1,length(siz));
[S{:}] = ind2sub(siz,I);
S = [S{:}];
end