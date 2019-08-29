function [x_pos,y_pos] = lim2rectpos(x_lim,y_lim)
%LIM2RECTPOS constructs vertices of the rectangle defined by its X and Y
%limits.
%
%	[x_pos,y_pos] = lim2rectpos(x_lim,y_lim)
% 
%   x_lim and y_lim are min-max limit array of x and y-axes
%   x_pos and y_pos are x and y coords of corresponding rectangle vertices
%
%   NOTE: rect-vertices begin at bottom-left corner and counter-clockwise
%
% EXAMPLE:
%   xl = get(gca,'XLim');
%   yl = get(gca,'YLim');
%   [v_x,v_y] = lim2rectpos(xl,yl);
%   patch(v_x,v_y,'k');
%
%
% DKS 2019

x_pos = x_lim([1 2 2 1]);
y_pos = y_lim([1,1,2,2]);

end