function pl = vline(x,ax)
% plots vertical lines on axis
% DKS 2019

if nargin == 1
    ax = gca;
end
hold(ax,'on');

pl = NaN(size(x));
n = numel(x);

ax_ylim = get(ax,'YLim');

% plot vertical lines
for ii = 1:n
    pl(ii) = line(x(ii)*[1,1],ax_ylim);
end

end