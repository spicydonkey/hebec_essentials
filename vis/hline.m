function pl = hline(y,ax)
% plots horizontal lines on axis
% DKS 2019
%
% See also: vline

if nargin == 1
    ax = gca;
end
hold(ax,'on');

pl = NaN(size(y));
n = numel(y);

ax_xlim = get(ax,'XLim');

% plot horizontal lines
for ii = 1:n
    pl(ii) = line(ax_xlim,y(ii)*[1,1]);
end

end