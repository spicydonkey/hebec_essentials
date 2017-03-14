% Script to read a simple experiment measurement log in csv format
% INPUT FILE FORMAT:
%###########################################
% NUM_VARS
% VARNAME_1, VARNAME_2, ..., VARNAME_N
% X1_1, ..., XN_1    (must be numeric)
% ...
% XN_NSAMP, ..., XN_NSAMP
%###########################################
% DK Shin
% 21/07/2016

function [data, var_name] = read_exp1(filename)
% get basic file properties
nLines = numLine(filename);

% open file
fid=fopen(filename);

% first line is number of variables
tmp_cell = regexp(fgetl(fid),',','split');
n_var = str2double(tmp_cell{1});

% line 2 is names of variables
var_name = regexp(fgetl(fid),',','split');

% read data into array
data=zeros(nLines-2,n_var);     % initialise data array
for i=1:nLines-2
    tmp_cell=regexp(fgetl(fid),',','split');
    data(i,:)=str2double(tmp_cell);
end

% close file
fclose(fid);