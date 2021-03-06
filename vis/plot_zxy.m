function S = plot_zxy(ZXY,NDISP,SIZE,COLORS)
% PLOT_ZXY(ZXY, NDISP, SIZE, COLORS)
%
% Plots Nshot-by-Mspecies cell of ZXY counts
% DKS 

if ~iscell(ZXY)
    warning('ZXY must be a cell array.');
    return;
end
if ~exist('NDISP','var')
    NDISP=[];
end
if ~exist('COLORS','var')
    COLORS='brgmcyk';  % default COLORS
end
if ~exist('SIZE','var')
    SIZE=1;     % default scatter dot size
end

n_species=size(ZXY,2);
S = gobjects(1,n_species);
for i=1:n_species
    temp_zxy=vertcat(ZXY{:,i});     % whole collated data
    
    if ~isequal(NDISP,[])
        % randomly filter counts to display
        N_TOT=size(temp_zxy,1);
        idx_sel=rand(N_TOT,1);          % RNG array
        idx_sel=idx_sel<(NDISP/N_TOT);  % RNG to binary selection indices
        
        temp_zxy=temp_zxy(idx_sel,:);
    end
    
    S(i) = scatter_zxy(temp_zxy,SIZE,COLORS(i));
    hold on;    % hold current figure - to plot on
end

% hold off;
axis equal;
end