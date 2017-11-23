function psi=diffAngleCart(vs,u)
% PSI = DIFFANGLECART(VS,U)
% Evaluates the relative angle between cartesian vectors
%
% VS: NxM array of vectors
% U: 1xM reference vector
%

nvecs=size(vs,1);
u=repmat(u,[nvecs,1]);

vs_dot_u=sum(vs.*u,2);
vs_norm=myvecnorm(vs);
u_norm=myvecnorm(u);

psi=real(acos(vs_dot_u./(vs_norm.*u_norm)));
