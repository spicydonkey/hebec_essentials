% ZXY to radial distance

function r = zxy2rdist(zxy,cent)
if ~exist('cent','var')
    cent=zeros(1,3);
end

ncounts=size(zxy,1);

% offset centre
zxy0=zxy-repmat(cent,[ncounts,1]);

% evaluate radial distance (from centre)
r=sqrt(sum((zxy0.^2),2));

end