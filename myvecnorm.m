function norms=myvecnorm(vecs,dim)
% NORMS = MYVECNORM(VECS,DIM)
% Evaluates Cartesian norm of N-dimensional vectors
%
% NORMS:    vector norms
% VECS:     N-by-M array of M-dimensional vectors
% DIM:      (OPT) array dimension in which the N-dim vector is in (default is 2)
%

if ~exist('dim','var')
    dim=2;  % default is N-dim "row (dim=2)" vectors 
end


norms=sqrt(sum(vecs.^2,dim));
