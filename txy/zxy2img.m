function [I,x,y] = zxy2img(zxy,img_axes,img_lim,img_pitch)
%zxy2img - ZXY data to 2D density image converter
%
% Syntax:  [I,x,y] = zxy2img(zxy,img_axes,img_lim,img_pitch)
%
% Inputs:
%   zxy - Nx3 array of ZXY-vectors
%   img_axes - image plane by 2 axes 'xy','yz','zx',etc.
%   img_lim - 1x2 cell array of 1x2 vector of image limits in each axes
%   img_pitch - 1x2 cell array of image pixel pitch
%
% Outputs:
%   I - 2D density image
%   x - horz-values
%   y - vert-values
%   
% Example:
%   [I,x,y] = zxy2img(zxy,'xz',{[-30,30],[-30,30]},{1,1})
%   figure;
%   imagesc('XData',x,'YData',y,'CData',I);
%
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: 
% Author: David Shin
% Work address
% email: david.shin@anu.edu.au
% Website: https://github.com/spicydonkey
% March 2019; Last revision:
%------------- BEGIN CODE --------------

% check axes
if ~ischar(img_axes) || length(img_axes)~=2 || ~all(ismember(img_axes,'xyz'))
    error('check usage of var: img_axes.');
end
ax2index=@(c) mod(c-'x'+1,3)+1;

% parse image axes as indices to ZXY array
idx_img_ax = arrayfun(@(c) ax2index(c),img_axes);

% histogram ----------------------------
ed = cellfun(@(x,dx) x(1):dx:x(2),img_lim,img_pitch,'uni',0);
x = edge2cent(ed{1});
y = edge2cent(ed{2});

I = nhist(zxy(:,idx_img_ax),ed);
I = I';     % reshape image to be compatible with imagesc

%------------- END OF CODE --------------
end