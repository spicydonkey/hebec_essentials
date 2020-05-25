function [v,b] = bitmap_mask(v_in,b_mask,ed_mask,b_invert)
% [v,b] = bitmap_mask(v_in,b_mask,ed_mask)
% Filter vectors by a bitmap mask.
%
%   v:          vectors inside mask
%   b:          boolean to masked vectors
%
%   v_in:       NxM array of input vectors (length M)
%   b_mask:     M dim boolean mask
%   ed_mask:    bitmap grid limits in each dimension
%   b_invert:   boolean to indicate mask direction (default false = inside)
%
%
% DKS 2020

if nargin < 4
    b_invert = false;
end

n_mask_cell = sumall(b_mask);
S_mask = findv(b_mask);             % vector subscripts
D = ndims(v_in);

n_vec = size(v_in,1);

%%% mask
b = false(n_vec,1);
for ii = 1:n_mask_cell
    
    % define cell box limits
    t_ed_cell = cell(1,D);
    for jj = 1:D
        t_ed_cell{jj} = ed_mask{jj}(S_mask(ii,jj)+[0,1]);
    end
    
    % get vecs inside this mask cell
    [~,~,~,~,~,~,tb] = boxcull(v_in,t_ed_cell);
    b = b|tb;               % update the boolean selection
end

if b_invert
    b = ~b;
end

v = v_in(b,:);      % get all desired vectors