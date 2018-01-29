function r = vnorm(v,dim)
%Evaluates norms of vectors
%
%   v: vector array
%   dim: vector dimension (default: 2 - row vecs)
%

if ~exist('dim','var')
    % row-vector as default
    dim=2;
end

r=sqrt(sum(v.^2,dim));

end