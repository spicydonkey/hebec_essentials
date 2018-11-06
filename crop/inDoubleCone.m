function [v_in,b_in] = inDoubleCone(zxy,az,el,alpha)
%Get vectors in an infinite double cone.
%
%   zxy: array of Cart row vectors
%   az: cone-axis azim angle [rad]
%   el: cone-axis elev angle [rad]
%   alpha: cone half-angle
%
%   v_in: Cart-vecs (zxy) in D-cone
%   b_in: boolean array for vecs in D-cone
%
% DKS
% 2018-11-05

% get vecs in each cones separately
[~,b_A]=inCone(zxy,az,el,alpha);
[~,b_B]=inCone(zxy,az+pi,-el,alpha);
b_in=b_A|b_B;   % in D-cone

v_in=zxy(b_in,:);

end