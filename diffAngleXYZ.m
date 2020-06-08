function psi=diffAngleXYZ(vx,vy,vz,ux,uy,uz)
% PSI = DIFFANGLEXYZ(VX,VY,YZ,UX,UY,UZ)
% Evaluates the relative angle between 3D-cartesian vectors.
%
% VX,VY,VZ: cartesian components 3-vectors V. Same for U.
%
% PSI: relative angle between V and U.
%
% See also: diffAngleCart
% DKS 2020

v_dot_u = vx.*ux + vy.*uy + vz.*uz;
v_norm=sqrt(vx.^2 + vy.^2 + vz.^2);
u_norm=sqrt(ux.^2 + uy.^2 + uz.^2);

psi=real(acos(v_dot_u./(v_norm.*u_norm)));
end