function [txy_all,files,hfig]=load_txy(f_path,f_id,window,mincount,maxcount,rot_angle,build_txy,verbose,visual)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loads raw-data DLD/TXY and get counts in region of interest (after XY rotation) and 
% save to file
%
% [TXY_ALL,FILES,HFIG]=LOAD_TXY(F_PATH,F_ID,WINDOW,MINCOUNT,MAXCOUNT,ROT_ANGLE,BUILD_TXY,VERBOSE,VISUAL)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
%   required:   
%       f_path
%       f_id
%       
%   optional:
%       window - 3x1 cell of Z,X,Y window limits (crop)
%       rot_angle
%       mincount
%       maxcount
%       verbose
%       visual
%
% OUTPUT
%   txy_all : Nx1 cell-array of TXY data
%   files   : flags for processed files
%       has fields:     build_txy,missing,lowcount,highcount,id_ok
%   

if ~exist('verbose','var')
    verbose=0;  % default verbose is quiet
end

%% MAIN
t_fun_start=tic;
hfig={};

% default count range
if ~exist('mincount','var')
    mincount=0;     % no min count limit
end
if ~exist('maxcount','var')
    maxcount=Inf;   % no max count limit
end

% default window
if ~exist('window','var')
    window={[],[],[]};
end

% default build_txy
if ~exist('build_txy','var')
    build_txy=1;
end

% check for special conditions
if isempty(f_id)
    % set f_id to all matching files
    dlist=dir([f_path,'*.txt']);
    dlist={dlist(:).name}';
    f_id=sort(unique(cellfun(@(x) dfile2id(x),dlist)));
end

% Initialiase variables
nfiles=length(f_id);
% file output flags
files.build_txy=false(nfiles,1);      % dld files processed to txy
files.missing=false(nfiles,1);        % missing dld/txy file
files.lowcount=false(nfiles,1);       % files with too few counts (skipped in analysis)
files.highcount=false(nfiles,1);      % files with too high counts (skipped in analysis)
files.id_ok=false(nfiles,1);          % files id's that were successfully processed

% XY rotation
if ~exist('rot_angle','var')
    rot_angle=0.61;     % set param to default value
end

%% Prepare TXY-files and check for low-counts (possibly errorneous shots)
if verbose>0, fprintf('Preparing TXY-files...\n'), end;
for i=1:nfiles
    % TXY-file does not exist
    if ~fileExists([f_path,'_txy_forc',num2str(f_id(i)),'.txt'])
        if verbose>1, warning('Could not find TXY-file #%d.',f_id(i)); end;
        
        % rawDLD source file exists
        if fileExists([f_path,num2str(f_id(i)),'.txt'])
            if build_txy
                % Create TXY from DLD
                if verbose>0, warning('Creating TXY-file from raw source #%d.',f_id(i)); end;
                dld_raw_to_txy(f_path,f_id(i),f_id(i));
                files.build_txy(i)=1;
            else
                if verbose>0, warning('Source file #%d exists but skipping TXY generation.',f_id(i)); end;
                files.missing(i)=1;
                continue;
            end
        % no source exists
        else
            % error - file # is missing
            if verbose>0, warning('Could not load data. Source file #%d is missing.',f_id(i)); end;
            files.missing(i)=1;
            continue;
        end
    end  % TXY-file exists
end

%% Extract a region of interest from TXY-files
txy_all=cell(nfiles,1);   % TXY data cell in window
ncounts=zeros(nfiles,1);  % number of counts in window per shot

if verbose>0, fprintf('Getting counts in window from TXY-files...\n'); end;
counter=1;
for i=1:nfiles
    % pass for missing files
    if files.missing(i)
        ncounts(i)=NaN;
        continue;
    end
    
    % load the TXY-file to memory
    txy_temp=txy_importer(f_path,f_id(i));
    
    % Apply rotation in XY plane
    x_temp=txy_temp(:,2);   % temp store x,y vects
    y_temp=txy_temp(:,3);
    txy_temp(:,2)=x_temp*cos(rot_angle)-y_temp*sin(rot_angle);
    txy_temp(:,3)=x_temp*sin(rot_angle)+y_temp*cos(rot_angle);
    
    % Crop counts to window
    for i_dim=1:3
        if isempty(window{i_dim})   % pass crop if empty
            if verbose>0
                warning('window{%d} is empty - no cropping in this dimension.',i_dim);
            end
        else
            in_window=((txy_temp(:,i_dim)>window{i_dim}(1))&...
                (txy_temp(:,i_dim)<window{i_dim}(2)));
            txy_temp=txy_temp(in_window,:);     % crop counts in XY axis
        end
    end
    
    % filter files by the number of counts in window
    num_counts_in_window=size(txy_temp,1);
    ncounts(i)=num_counts_in_window;
    if num_counts_in_window<=mincount
        files.lowcount(i)=1;
        if verbose>0
            warning('ROI counts too LOW in file #%d. Discarding from further processing.',f_id(i));
        end
        continue
    elseif num_counts_in_window>=maxcount
        files.highcount(i)=1;
        if verbose>0
            warning('ROI counts too HIGH in file #%d. Discarding from further processing.',f_id(i));
        end
        continue
    end
    
    txy_all{counter}=txy_temp;    % save captured counts
    counter=counter+1;
end
txy_all(counter:end)=[];    % delete all empty cells

% evaluate files successfully processed: id_ok
files.id_ok=f_id(~(files.missing|files.lowcount|files.highcount));

%% Plot captured counts (TXY)
if verbose>2 && visual
    fprintf('Plotting captured counts...\n');
    
    h_zxy_all=figure();     % create figure
    hfig{length(hfig)+1}=gcf;
    plot_zxy(txy_all,1e6,1,'k');
    title('Raw TXY data');
    xlabel('X [m]'); ylabel('Y [m]'); zlabel('T [s]');
    
    view(3);
    axis vis3d;
    
    drawnow;
end

%% Shot-to-shot atom number fluctuation
ncounts_avg=mean(ncounts,'omitnan');
ncounts_std=std(ncounts,'omitnan');

if verbose>0&&visual
    hfig_ncounts_hist=figure();
    hist_ncounts=histogram(ncounts);
    titlestr=sprintf('Atom number fluctuation (window): $%0.2g\\pm%0.1g$\n',ncounts_avg,ncounts_std);
    title(titlestr);
    xlabel('no. counts');
    ylabel('no. shots');
    ylim_temp=get(gca,'YLim');
    ylim([0,ylim_temp(2)]);   % set ylim minimum to 0
    box on;
    hfig{length(hfig)+1}=gcf;
    
    hfig_ncounts_trend=figure();
    nsmooth=11;     % smoothing number
    plot(smooth(ncounts,nsmooth),'-','LineWidth',1.5);
    titlestr=sprintf('Atom number in window: $%0.2g\\pm%0.1g$\n',ncounts_avg,ncounts_std);
    title(titlestr);
    xlabel('shot number');
    ylabel('number in window');
    box on;
    axis tight;
    hfig{length(hfig)+1}=gcf;
    
    drawnow;
end

%% Summary
if verbose>0
    fprintf('===================IMPORT SUMMARY===================\n');
    fprintf('Number of shots successfully loaded: %d\n',length(files.id_ok));
    fprintf('Number of shots with counts below %d: %d\n',mincount,sum(files.lowcount));
    fprintf('Number of shots with counts over  %d: %d\n',maxcount,sum(files.highcount));
    fprintf('Number fluctuation: %0.3g ± %0.2g\n',ncounts_avg,ncounts_std);
    fprintf('Number of missing files: %d\n',sum(files.missing));
    fprintf('Number of files converted to TXY: %d\n',sum(files.build_txy));
    fprintf('====================================================\n');
end

%% END
t_fun_end=toc(t_fun_start);   % end of code
if verbose>0
    disp('-----------------------------------------------');
    fprintf('Total elapsed time for %s (s): %7.1f\n','loadExpData',t_fun_end);
    disp('-----------------------------------------------');
end