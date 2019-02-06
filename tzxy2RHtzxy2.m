function zxy_RH = tzxy2RHtzxy2(zxy_LH)
% Convert from "experiment" T(Z)XY left-handed to right-handed coord system,
% preserving original X and Z direction, by flipping the Y-direction.
%
% Right-handed coord (2)
%   +x = BEC-chamber --> LMOT
%   +y = z x y (right-handed)
%   +z = detector --> BEC_chamber
%
%   Refer to tzxy2RHtzxy.m for similar transform (and R. Khakimov or DKS thesis/logbooks for
%   diagrams)
%
% DKS
% 2019-02-06
%

zxy_RH = zxy_LH;
zxy_RH(:,3) = -zxy_RH(:,3);     % flip sign of Y

end