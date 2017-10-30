function n = linecount(fname)
% N = LINECOUNT(FNAME)
%
% Counts number of lines in a file
%
% original source: https://au.mathworks.com/matlabcentral/answers/81137-pre-determining-the-number-of-lines-in-a-text-file
%

fid=fopen(fname,'r');
if fid==-1
    error('Could not open file.');
end

n = 0;
tline = fgetl(fid);
while ischar(tline)
    tline = fgetl(fid);
    n = n+1;
end
fclose(fid);

end