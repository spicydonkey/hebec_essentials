function R=euler2rotm2(euler_angle)
% David's Euler angles --> rotation matrix
% DKS
% 2019-02-05
%
% DEFINITION:
%
%   v_XYZ = inv(R(alpha,beta,gamma)) * v_xyz
%
%   equivalently,
%
%   v_xyz = R * v_XYZ
%
%
%   Input is "PROPER Euler angles" (see
%   https://en.wikipedia.org/wiki/Euler_angles)
%
%   xyz is extrinsic coord sys
%   XYZ is the rotated coord sys such that the Euler angles describe the
%   orientation of XYZ wrt xyz.
%

alpha=euler_angle(1);
beta=euler_angle(2);
gamma=euler_angle(3);

R = rotz(alpha) * rotx(beta) * rotz(gamma);

end