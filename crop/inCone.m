function [v_in,b_in,n]=inCone(zxy,az,el,theta)
%Get counts in an extended cone region.
%
%   zxy: array of Cart row vectors
%   az: cone-axis azim angle [rad]
%   el: cone-axis elev angle [rad]
%   theta: cone half-angle
%
%   v_in: C-vecs in cone
%   b_in: boolean array for vecs in cone
%   n:  num vecs in cone


% transform Caresian --> spherical
vsph=zxy2sphpol(zxy);

% get rel angles of vecs to cone
dtheta=diffAngleSph(vsph(:,1),vsph(:,2),az,el);

% filter vecs in cone
b_in=dtheta<theta;
v_in=zxy(b_in,:);
n=sum(b_in);

end