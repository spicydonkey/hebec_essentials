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
s.a0=5.29e-11;                  % Bohr radius [m]
s.Na=6.022140857e23;            % Avogadro constant [mol^-1]
s.kB=1.38064852e-23;          	% Boltzmann constant [J.K^-1]
s.c=299792458;                  % speed of light [m.s^-1]
s.e0 = 8.854e-12;               % vacuum permitivity [F.m^-1]
s.e = 1.602e-19;                % elementary charge [C]


% Helium
s.m_He=6.646476e-27;            % mass of helium-4 [kg]
s.lambda_He=1083.33e-9;
s.life_He=97.87e-9;             % lifetime  [s]     (DOI: 10.1103/RevModPhys.84.175)
s.gamma_He=1/s.life_He;         % linewidth (halfwidth of spectral line) [Hz]
s.Is_He=0.17;
s.mu_He=2.8e6;
s.k_He=(2*pi)/s.lambda_He;      % wavenumber of cooling photon
s.a_11=7.512e-9;                % s-wave scat length spin-polarised He* [Moal, et. al., PRL (96) 2006]
s.He_gLande=2;                  % He* Lande g factor
s.He_gymag=1e-4*s.He_gLande*s.mu_B/s.h;     % He* gyromagnetic ratio (gamma) [Hz/G]

% Lab
s.g=9.81;       % gravitational acceleration [m.s^-2]

end