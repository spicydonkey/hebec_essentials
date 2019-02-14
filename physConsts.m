function s = physConsts()
%s = physConsts()
%
%   Physical constants relevant to metastable helium experiments
%
%   All values are in SI units unless otherwise stated
%
% References:
%   CODATA: The NIST Reference on Constants, Units, and Uncertainty. https://physics.nist.gov/cuu/index.html
%
% DKS
%

% Physical constants
s.h=6.62607015e-34;             % Planck constant [J.s]
s.hbar=1.054571800e-34;         % reduced Planck constant [J.s]
s.mu_B=9.274009994e-24;         % Bohr magneton [J.T^-1] 
s.Na=6.022140857e23;            % Avogadro constant [mol^-1]
s.kB=1.38064852e-23;          	% Boltzmann constant [J.K^-1]

% Helium
s.m_He=6.646476e-27;            % mass of helium-4 [kg]
s.gamma_He=1.62e6*2*pi;         
s.lambda_He=1083.33e-9;
s.life_He=1/(s.gamma_He*2*pi);
s.Is_He=0.17;
s.mu_He=2.8e6;
s.k_He=(2*pi)/s.lambda_He;  
s.a_11=7.512e-9;            % s-wave scat length spin-polarised He* [Moal, et. al., PRL (96) 2006]
s.He_gLande=2;              % He* Lande g factor
s.He_gymag=1e-4*s.He_gLande*s.mu_B/s.h;     % He* gyromagnetic ratio (gamma) [Hz/G]

% Lab
s.g=9.81;       % gravitational acceleration [m.s^-2]

end