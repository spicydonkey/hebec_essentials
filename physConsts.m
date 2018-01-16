function s = physConsts()
%s = physConsts()
%
%   Physical constants relevant to metastable helium experiments
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

end