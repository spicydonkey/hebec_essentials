% TXY --> ZXY: lazyman's function

function zxy=txy2zxy(txy,vz)
if ~exist('vz','var')
    vz=9.81*0.416;
end

% Convert T-->Z
nshot=size(txy,1);
for ii=1:nshot
    txy{ii}(:,1)=txy{ii}(:,1)*vz;    % ToF to Z
end
zxy=txy;
end