% testing norm + diff angle codes

% reference cart vectors
vs_cart=rand(1000,3);
u_cart=rand(1,3);

[vs_th,vs_phi,vs_r]=cart2sph(vs_cart(:,1),vs_cart(:,2),vs_cart(:,3));
[u_th,u_phi]=cart2sph(u_cart(1),u_cart(2),u_cart(3));

% get norms
vs_cart_norm=vecnorm(vs_cart);
n_norm_oor=sum(~(abs(vs_cart_norm-vs_r)<2*eps));
warning('Number of wrong norms: %d\nMax error: %0.2g',n_norm_oor,max(abs(vs_cart_norm-vs_r)));

% get rel angles
psi_cart=diffAngleCart(vs_cart,u_cart);
psi_sph=diffAngleSph(vs_th,vs_phi,u_th,u_phi);

n_diffAngle_oor=sum(~(abs(psi_cart-psi_sph)<20*eps));
warning('Number of wrong rel angle: %d\nMax error: %0.2g',n_diffAngle_oor,max(abs(psi_cart-psi_sph)));
