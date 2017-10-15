function norms=vecnorm(vecs)
% NORMS = VECNORM(VECS)
% Evaluates Cartesian norm of N-dimensional vectors
%
% NORMS: vector norms
% VECS: N-by-M array of M-dimensional vectors
%

norms=sqrt(sum(vecs.^2,2));