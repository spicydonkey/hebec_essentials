function [N,edges]=counts_2d(data,bin_edges)
% TODO - double check if there is error in orientation
% data should be n x 3 array of ZXY/TXY
% bin_edges is a 3x1 cell of 1D vector of bin edges in corresponding dims

% input check
if nargin<2     % default
    % auto binning - 100 bin edges from min to max
    bin_edges=cell(3,1);
    nbins=100;      % default number of auto binning
    for ii=1:3
        % boundaries as extrema of data in corresponding dim
        edge_i=min(data(:,ii));
        edge_f=max(data(:,ii));
        
        % create linearly spaced edges (default)
        bin_edges{ii}=linspace(edge_i,edge_f,nbins);
    end
end

N=cell(3,1);    % for XY, YZ, ZX projections
% cyclically iterate projection axis
dim_vect=[1,2,3];
for ii=1:3
    % get transverse dims to do 1d-column counting
    dim1=dim_vect(2);
    dim2=dim_vect(3);
    
    % get edges
    dim1_edges=bin_edges{dim1};
    dim2_edges=bin_edges{dim2};
    
    % do the histogram
    N{ii}=histcounts2(data(:,dim1),data(:,dim2),dim1_edges,dim2_edges);
    
    dim_vect=circshift(dim_vect,1,2);   % cyclic shift of dims
end

edges=bin_edges;    % return bin_edges

%% Summary: Surf plot
bin_cents=cellfun(@(ed) ed(1:end-1)+0.5*diff(ed),edges,'UniformOutput',false);

dim_label={'Z','X','Y'};
dim_vect=[1,2,3];
hfig_counts2d=figure();
for ii=1:3
    % get transverse dims to do 1d-column counting
    dim1=dim_vect(2);
    dim2=dim_vect(3);
    
    subplot(1,3,ii);
    [X,Y]=meshgrid(bin_cents{dim1},bin_cents{dim2});
    surf(X',Y',N{ii});
    
    shading interp;
    axis tight;
    view(2);
    cbar=colorbar;
    cbar.Label.String='Detected counts';
    
    titlestr=sprintf('%s-%s',dim_label{dim1},dim_label{dim2});
    title(titlestr);
    xlabel(dim_label{dim1});
    ylabel(dim_label{dim2});
    
    dim_vect=circshift(dim_vect,1,2);   % cyclic shift of dims
end

end