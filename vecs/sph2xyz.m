function v = sph2xyz(th,phi,r)
% wrapper for sph2cart(TH,PHI,R): returns a Nx3 array of cartesian vectors
%   v = sph2xyz(th,phi,r)
%
% DKS 2019

[x,y,z] = sph2cart(th,phi,r);
v = [x,y,z];
end