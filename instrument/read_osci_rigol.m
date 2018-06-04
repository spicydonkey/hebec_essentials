function DATA = read_osci_rigol(FILENAME)
% Script to read csv data from Rigol Oscilloscipe DS1054Z
%   DATA = read_osci_rigol(FILENAME)
%
%   DATA: [TIME; CH1;...; CH_N]
%
% DK Shin
% 02/08/16


% nlines = numLine(FILENAME);
nlines = linecount(FILENAME);
nSamp = nlines-2;       % l1:header; l2:units+time; l3-end:data
DATA_cell=cell(nlines,1);

fid=fopen(FILENAME);
for iLine = 1:nlines
    DATA_cell{iLine} = regexp(fgetl(fid),',','split');
end
fclose(fid);

nChan = size(DATA_cell{2},2)-2;     % number of channels saved
t_start = str2double(DATA_cell{2}{nChan+1});    % start time
t_incre = str2double(DATA_cell{2}{nChan+2});    % increment time

DATA = zeros(nSamp,size(DATA_cell{3},2));   % initialise data array
for iLine=1:nSamp
    DATA(iLine,:)=str2double(DATA_cell{iLine+2});   % force convert comma-sep'd string to number
end

t = 0:t_incre:t_incre*(nSamp-1);    % create time-stamp
t = t + t_start;

DATA = [t' DATA];   % concantenate time and channel meas

end