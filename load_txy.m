function [txy_all,files,hfig]=load_txy(f_path,f_id,window,mincount,maxcount,rot_angle,verbose,visual)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Loads raw-data DLD/TXY and get counts in region of interest (after XY rotation) and 
% save to file
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

% Initialiase variables
% file output flags
files.build_txy=false(length(f_id),1);      % dld files processed to txy
files.missing=false(length(f_id),1);        % missing dld/txy file
files.lowcount=false(length(f_id),1);       % files with too few counts (skipped in analysis)
files.highcount=false(length(f_id),1);      % files with too high counts (skipped in analysis)
files.id_ok=false(length(f_id),1);          % files id's that were successfully processed

% XY rotation
if ~exist('rot_angle','var')
    rot_angle=0.61;     % set param to default value
end

%% Prepare TXY-files and check for low-counts (possibly errorneous shots)
if verbose>0, fprintf('Preparing TXY-files...\n'), end;
for i=1:length(f_id)
    % TXY-file does not exist
    if ~fileExists([f_path,'_txy_forc',num2str(f_id(i)),'.txt'])
        if verbose>1, warning('Could not find TXY-file #%d.',f_id(i)); end;
        
        % rawDLD source file exists
        if fileExists([f_path,num2str(f_id(i)),'.txt'])
            % Create TXY from DLD
            if verbose>0, warning('Creating TXY-file from raw source #%d.',f_id(i)); end;
            dld_raw_to_txy(f_path,f_id(i),f_id(i));
            files.build_txy(i)=1;
            
        % no source exists
        else
            % error - file # is missing
            warning('Could not load data. Source file #%d is missing.',f_id(i));
            files.missing(i)=1;
            continue;
        end
    end  % TXY-file exists
end

%% Extract a region of interest from TXY-files
% f_id=f_id(~files.missing);      % get ids for existing data files
txy_all=cell(length(f_id),1);   % TXY data cell in window
ncounts=zeros(length(f_id),1);  % number of counts in window per shot

if verbose>0, fprintf('Getting counts in window from TXY-files...\n'); end;
counter=1;
for i=1:length(f_id)
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
end

%% Shot-to-shot atom number fluctuation
ncounts_avg=mean(ncounts,'omitnan');
ncounts_std=std(ncounts,'omitnan');

if visual
    hfig_ncounts_hist=figure();
    hist_ncounts=histogram(ncounts);
    titlestr=sprintf('Atom number fluctuation (window): %0.2g ± %0.2g\n',ncounts_avg,ncounts_std);
    title(titlestr);
    xlabel('no. counts');
    ylabel('no. shots');
    ylim_temp=get(gca,'YLim');
    ylim([0,ylim_temp(2)]);   % set ylim minimum to 0
    box on;
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