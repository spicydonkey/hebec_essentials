function zxy = xyz2zxy(xyz)
% XYZ vectors to ZXY
%   NOTE: XYZ must be N x 3 array (like txy)
% DKS

zxy = circshift(xyz,1,2);

end