% Thermal de Broglie wavelength of a massive particle
% DKS
% 2020.05.02

function lambda_th = debroglie_th(m,T)
s = physConsts();
hbar = s.hbar;
kB = s.kB;

lambda_th = sqrt( 2*pi*hbar^2 / (m*kB*T) );

end