function p_fill = patchfill(ax,patch_col)
%PATCHFILL patches axes provided

if nargin < 2
    patch_col = 0.8*ones(1,3);      % default patch color (gray)
end

ax_xlim = get(ax,'XLim');
ax_ylim = get(ax,'YLim');

p_fill=patch('XData',ax_xlim([1 2 2 1]),...
        'YData',ax_ylim([1 1 2 2]),...
        'FaceColor',patch_col,'EdgeColor','none');
uistack(p_fill,'bottom');
    
end