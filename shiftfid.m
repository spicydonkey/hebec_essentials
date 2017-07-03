% Shift raw and txy file ID and save into newly created directory

function shiftfid(path_dir,nshift)
cd(path_dir);   % cd into dir

ddata_orig=listdata('.');   % get all data in this directory

dir_save=['shifted_',datestr(datetime,'yyyymmdd_HHMMSS')];  % dir to save shifted data into
mkdir(dir_save);

% copy shifted data into dir
nfiles=size(ddata_orig,1);
for ii=1:nfiles
    fthis=ddata_orig(ii);
    forig=[fthis.type,int2str(fthis.id),'.txt'];    % orignal file path (rel pwd)
    fnew=[dir_save,'/',fthis.type,int2str(fthis.id+nshift),'.txt'];    % shifted file path (rel pwd)
    
    copyfile(forig,fnew);
end

end