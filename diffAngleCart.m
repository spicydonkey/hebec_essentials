function psi=diffAngleCart(v,u)
% PSI = DIFFANGLECART(V,U)
% Evaluates the relative angle between 3D-cartesian vectors.
%
% V, U: arrays of 3-vectors
%
% PSI: relative angle between V and U.
%
% DKS 2020

v_dot_u=sum(v.*u,2);
v_norm=vnorm(v,2);
u_norm=vnorm(u,2);
psi=real(acos(v_dot_u./(v_norm.*u_norm)));

end