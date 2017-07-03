% list all raw TDC (d#.txt) and TXY imported (d_txy_forc#.txt) files in
% directory

function ddata = listdata(path_dir)
% DEFINE TOKENS
tok_raw='d';
tok_txy='d_txy_forc';

% load info about files matching exp data format
dlist=dir([path_dir,'/d*.txt']);    

nfiles=size(dlist,1);

initval=cell(nfiles,1);
ddata=struct('id',initval,'type',initval,'bytes',initval);     % initialise struct array
% sort data into "raw" and "txy"
count_id=1;
for ii=1:nfiles
    fname=dlist(ii).name;
    % get type of data file
    if ~isempty(sscanf(fname,[tok_txy,'%d.txt']))
        dtype=tok_txy;      % txy file token
        did=sscanf(fname,[tok_txy,'%d.txt']);
    elseif ~isempty(sscanf(fname,[tok_raw,'%d.txt']))
        dtype=tok_raw;      % raw file token
        did=sscanf(fname,[tok_raw,'%d.txt']);
    else
        % file doensn't seem to be a data file - skip this
        continue
    end
    
    % store info into output
    ddata(count_id).type=dtype;
    ddata(count_id).id=did;
    ddata(count_id).bytes=dlist(ii).bytes;
    
    count_id=count_id+1;
end

% clean data for any false files
ddata(count_id:end)=[];

end