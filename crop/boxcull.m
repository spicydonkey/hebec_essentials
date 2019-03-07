function [v_out,I_out,n_out,cpos,se_cpos,sd_pos] = boxcull(v_in,box_lim)
% [v_out,I_out,n_out,cpos,se_cpos,sd_pos] = boxcull(v_in,box_lim)
%Extract vectors lying inside a box.
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
%   * v_in      - N by M array (usage: N x data vectors of dim M)
%   * box_lim       - 1xM cell array of box limits for each dim
% OUTPUT
%   * v_out     - array of vectors within box
%   * I_out       - indices of vectors (rows) in box
%   * n_out         - number of points captured
%   * cpos          - centre position (mean): [xc,yc,zc,...]
%   * se_cpos       - standard error of mean position
%   * sd_pos        - rms width of captured counts
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DKS 31/01/17

nvects=size(v_in,1);
I_out=1:nvects;

v_out=v_in;         % initialise output

ndim=size(v_in,2);
for i=1:ndim
    if isempty(box_lim{i})  % pass crop if empty
        continue;
    end
    in_window=((v_out(:,i)>box_lim{i}(1))&(v_out(:,i)<box_lim{i}(2)));
    v_out=v_out(in_window,:);       % crop all remaining to this component
    I_out=I_out(in_window);             % update remaining data's parent indices
end

% evaluate number of captured counts
n_out=size(v_out,1);

% evaluate mean position of captured counts
cpos=mean(v_out,1);

% spread/width
sd_pos=std(v_out,1);        % rms width in each dim
se_cpos=sd_pos/sqrt(n_out);     % se

end