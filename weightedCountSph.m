function weighted_counts=weightedCountSph(vs,u_ref,sig,lim)
%
% COUNTS = WEIGHTEDCOUNTSPH(VS,U_REF,SIG)
%
% Evaluates number of vectors at a zone defined by a reference vector by
% assigning vectors with weights corresponding to displacement.
%
% COUNTS: total weighted sum of counts
% VS: N-by-3 array of spherical-coord vectors (TH,PHI,R)
% U_REF: 1x3 sph vector defining zone
% SIG: 1x2 array of sigmas for gaussian weights (angular, norm)
% LIM: 1x2 array to delimit outliers in weighted counting defined in
% standard score (i.e. number of sigmas)
%

% standardised difference score
z_psi=diffAngleSph(vs(:,1),vs(:,2),u_ref(1),u_ref(2))/sig(1);
z_norm=(vs(:,3)-u_ref(3))/sig(2);

% cull outliers
z_psi=z_psi(z_psi>lim(1));
z_norm=z_norm(abs(z_norm)>lim(2));

% evaluate Gaussian weights
w_psi=exp(-0.5*z_psi.^2);
w_norm=exp(-0.5*z_norm.^2);

weighted_counts=w_psi.*w_norm;

end