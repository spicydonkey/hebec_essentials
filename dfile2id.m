function id = dfile2id(dfilename,verbose)
% ID = DFILE2ID(DFILENAME,TOK)
%
% Extracts shot ID from DLD data
%
% ID is file id (positive integer). NaN if file not a DLD file.
% DFILENAME is the name of raw TDC or processed (txy) file
%
% TODO
% (an optional d-filename TOKEN for non-standard format: TOKID)
%

%%% handle optional args
if ~exist('verbose','var')
    verbose=0;
end


%%% main
id=NaN;     % initialise ID to default err val
[~,name,ext]=fileparts(dfilename);


len=length(name);
if ~isempty(ext)&&~isequal(ext,'.txt')
    if verbose>0
        warning('dfilename should be a .txt file.');
    end
    return
end
if len<2
    if verbose>0
        warning('dfilename should be in a valid d-file format.');
    end
    return
end

tok_raw='d';
tok_proc='d_txy_forc';

if contains(name,tok_proc)
    id=str2double(name(length(tok_proc)+1:end));
elseif contains(name,tok_raw)
    id=str2double(name(length(tok_raw)+1:end));
else
    if verbose>0
        warning('input file name format is invalid.');
    end
    return
end

if isempty(id)
    id=NaN;
    if verbose>0
        warning('input file name format is invalid.');
    end
    return
end

end