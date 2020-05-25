function [v,I,n,cpos,se_cpos,sd_pos,b] = boxcull(v_in,box_lim,b_invert)
% [v,I,n,cpos,se_cpos,sd_pos] = boxcull(v_in,box_lim,b_invert)
% Extract vectors lying inside a box.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
%   * v_in          - N by M array (usage: N x data vectors of dim M)
%   * box_lim       - 1xM cell array of box limits for each dim
%   * b_invert      - boolean to swap crop direction (default false=inside).
% OUTPUT
%   * v             - array of vectors within box
%   * I             - indices of vectors (rows) in box
%   * n             - number of points captured
%   * cpos          - centre position (mean): [xc,yc,zc,...]
%   * se_cpos       - standard error of mean position
%   * sd_pos        - rms width of captured counts
%   * b             - boolean to captured vecs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DKS 31/01/17 -- 2020

if nargin < 3
    b_invert = false;       % default gets points INSIDE box
end

nvects=size(v_in,1);
I=1:nvects;

v=v_in;         % initialise output

ndim=size(v_in,2);
for i=1:ndim
    if isempty(box_lim{i})      % pass crop if empty
        continue;
    end
    in_window=((v(:,i)>box_lim{i}(1))&(v(:,i)<box_lim{i}(2)));
    v=v(in_window,:);           % crop all remaining to this component
    I=I(in_window);             % update remaining data's parent indices
end

b = false(nvects,1);
b(I) = true;
if b_invert
    b = ~b;     % flip captured mask
    
    v=v_in(b,:);
    I=find(b);
end

% evaluate number of captured counts
n=size(v,1);

% evaluate mean position of captured counts
cpos=mean(v,1);

% spread/width
sd_pos=std(v,1);        % rms width in each dim
se_cpos=sd_pos/sqrt(n);     % se

end