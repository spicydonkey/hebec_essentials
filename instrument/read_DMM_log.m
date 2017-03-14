% Read measurement log from Tektronic DMM
% DK Shin
% 16/06/2016

function DATAOUT = read_DMM_log(filename)

nlines=numLine(filename);
nSamp=nlines-2;

% convert csv to cell
DATA_CELL = cell(nlines,1);
fid = fopen(filename);
for iLine = 1:nlines
    DATA_CELL{iLine}=regexp(fgetl(fid), ',', 'split');
end
fclose(fid);

DATAOUT=zeros(nSamp,2);    % initialise data array

% calculate time-stamp for measurement data
t_start = DATA_CELL{1}{7};
t_start = regexp(t_start, ':', 'split');
t_start = 3600*str2num(t_start{1}) + 60*str2num(t_start{2}) + str2num(t_start{3});

t_end = DATA_CELL{nlines}{7};
t_end = regexp(t_end, ':', 'split');
t_end = 3600*str2num(t_end{1}) + 60*str2num(t_end{2}) + str2num(t_end{3});

% check if on different day (assuming a log must be strictly less than 24 hours)
if t_end < t_start
    t_end = t_end + 3600*24;
end

DATAOUT(:,1)=linspace(0,t_end-t_start,nSamp);

% get measurement data
for iSamp=1:nSamp
    DATAOUT(iSamp,2)=str2double(DATA_CELL{iSamp+1}{2});
end