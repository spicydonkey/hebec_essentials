function [n_v,v_ed] = histVectors(V,ndiv_ed)
% Creates N-dim histogram from a list of N-dim vectors.
%   useful for visualising density/number images from set of discrete points
%   
% INPUT
%   * V: n-by-N array of vectors
%   * ndiv_ed: N-vector of number of equal-sized bins (spans range)
%
% OUTPUT
%   * n_v: N-dim #counts array (histogram output)
%   * v_ed: 1xN cell array of bin edges (eq-spaced) in each dime for histogram
%
% DKS
% 2018-06-15
%

n=size(V,2);


% when all dims should be divided by equal number of bins
if length(ndiv_ed)==1
    ndiv_ed=ones(1,n)*ndiv_ed;
end


% range each compoent of vecs
vi_min=min(V,[],1);
vi_max=max(V,[],1);
vi_range=vi_max-vi_min;


% create histogram bin edges (n-dim box) in each dim
v_ed=cell(1,n);
for ii=1:n
    v_ed{ii}=linspace(vi_min(ii),vi_max(ii),ndiv_ed(ii)+1);
end


% do the histogram
n_v=nhist(V,v_ed);


end