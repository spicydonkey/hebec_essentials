function id = dfile2id(dfilename,tok)
% ID = DFILE2ID(DFILENAME,TOK)
%
% Extracts shot ID from DLD data
%
% ID is file id (positive integer)
% DFILENAME is the name of raw TDC or processed (txy) file
%
% TODO
% (TOK is an optional d-filename TOKEN for non-standard format: TOKID)
%

[~,name,ext]=fileparts(dfilename);

len=length(name);
if ~isempty(ext)&&~isequal(ext,'.txt')
    error('dfilename should be a .txt file.');
end
if len<2
    error('dfilename should be in a valid d-file format.');
end

% if exist(tok,'var')
%end

tok_raw='d';
tok_proc='d_txy_forc';

if contains(name,tok_proc)
    id=str2double(name(length(tok_proc)+1:end));
elseif contains(name,tok_raw)
    id=str2double(name(length(tok_raw)+1:end));
else
    error('input file name format is invalid.');
end

if isempty(id)
    error('input file name format is invalid.');
end

end