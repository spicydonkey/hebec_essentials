function zxy_RH = tzxy2RHtzxy(zxy_LH)
% Convert from "experiment" T(Z)XY left-handed to right-handed coord system,
% preserving original X and Y direction, by flipping the Z-direction.
%
% Right-handed coord adopted by RK & DKS
%   +x = BEC-chamber --> LMOT
%   +y = z x y (right-handed)
%   +z = BEC_chamber --> detector
%
%   Refer to R. Khakimov or DKS thesis/logbooks for diagrams
%
% DKS
% 2019-02-06
%

zxy_RH = zxy_LH;
zxy_RH(:,1) = -zxy_RH(:,1);     % flip sign of Z

end