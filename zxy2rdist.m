function r = zxy2rdist(zxy,cent)
% ZXY to radial distance
%
% R = ZXY2RDIST(ZXY)
% R = ZXY2RDIST(ZXY, CENT)
%
% ZXY: Nx3 array of vectors
% CENT: 1x3 array for center
%

if ~exist('cent','var')
    cent=zeros(1,3);
end

ncounts=size(zxy,1);

% offset centre
zxy0=zxy-cent;

% evaluate radial distance (from centre)
r=sqrt(sum((zxy0.^2),2));

end
