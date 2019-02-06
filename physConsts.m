function s = physConsts()
%s = physConsts()
%
%   Physical constants relevant to metastable helium experiments
%
% All values are in SI units
%
% DKS
%

s.Na=6e23;
% s.m_He=4/s.Na/1000;
s.m_He=6.646476e-27;        % mass of helium (kg)
s.gamma_He=1.62e6*2*pi;
s.lambda_He=1083.33e-9;
s.life_He=1/(s.gamma_He*2*pi);
s.Is_He=0.17;
s.mu_He=2.8e6;
s.hbar=1.05457e-34;
s.kB=1.38066e-23;
s.k_He=(2*pi)/s.lambda_He;
s.g=9.81;                   
s.a_11=7.512e-9;            % s-wave scat length spin-polarised He* [Moal, et. al., PRL (96) 2006]

end