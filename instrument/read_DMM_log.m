% Read measurement log from Tektronic DMM
% DK Shin
% 2016-06-16: first implementation
% 2018-05-24: bug fix: smarter way of looking for processing datetime and cell
%   formatting
% 2018-05-27: bug fix: DMM logged in USB writes a ragged csv file.
%   linecount is more robust than numLine.


function DATAOUT = read_DMM_log(filename)

nlines=linecount(filename);
nSamp=nlines-2;

% convert csv to cell
DATA_CELL = cell(nlines,1);
fid = fopen(filename);
for iLine = 1:nlines
    DATA_CELL{iLine}=regexp(fgetl(fid), ',', 'split');
end
fclose(fid);


% collate all data into single cell
nelems=max(cellfun(@(c) length(c),DATA_CELL));     % max length of line
data_collated=cell(nlines,nelems);
for ii=1:nlines
    data_collated(ii,1:length(DATA_CELL{ii}))=DATA_CELL{ii};
end

b_nonempty_cell=cellfun(@(c) ~isempty(c),data_collated);

idx_col_datetime=find(b_nonempty_cell(1,:),1);      % index which datetime info starts
idx_col_data=find(b_nonempty_cell(2,:),1);      % index which data is


% calculate time-stamp for measurement data
dd=data_collated{1,idx_col_datetime};
tt=data_collated{1,idx_col_datetime+1};
t_start_datetime=datetime([dd,'T',tt],...
    'InputFormat','dd-MM-yy''T''HH:mm:ss');

dd=data_collated{end,idx_col_datetime};
tt=data_collated{end,idx_col_datetime+1};
t_end_datetime=datetime([dd,'T',tt],...
    'InputFormat','dd-MM-yy''T''HH:mm:ss');

t_dur=t_end_datetime-t_start_datetime;      % duration of experiment
t_exp=linspace(0,seconds(t_dur),nSamp);     % time points for exp data in seconds


% get measurement data
DATAOUT=NaN(nSamp,2);    % initialise data array
DATAOUT(:,1)=t_exp;
DATAOUT(:,2)=cellfun(@(c) str2double(c),data_collated(2:end-1,idx_col_data));


end