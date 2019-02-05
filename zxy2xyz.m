function xyz = zxy2xyz(zxy)
% ZXY vectors to XYZ
%   NOTE: ZXY must be N x 3 array (like txy)
% DKS

xyz = circshift(zxy,-1,2);

end