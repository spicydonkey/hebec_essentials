function cents=edge2cent(edges)
%edge2cent: convert bin-edge vector to centers.
%
%   cents = edge2cent(edges)
%
% INPUTS:
%   edges: 1D vector
%
% OUTPUTS:
%   cents: 1D vector
%
% DKS

cents=edges(1:end-1)+0.5*diff(edges);

end