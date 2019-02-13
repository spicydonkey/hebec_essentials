function S=scatter_zxy(ZXY_ARRAY,SIZE,COLOR)
% Scatter plot ZXY array
%
% SCATTER_ZXY(ZXY_ARRAY, SIZE, COLOR)
%
% DKS 31/10/2016

if isempty(ZXY_ARRAY)
    warning('Empty array passed as data.');
    return;
end
if ~exist('COLOR','var')
    COLOR='k';  % default COLOR is black
end
if ~exist('SIZE','var')
    SIZE=1;     % default scatter dot size
end

S=scatter3(ZXY_ARRAY(:,2),ZXY_ARRAY(:,3),ZXY_ARRAY(:,1),SIZE,COLOR,'.');
end