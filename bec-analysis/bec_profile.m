% Estimation of condensate parameters
% Summary: condensate peak density (n0) and condensate population (N0) are key estimations from a
% density fit to the Z-column and in-plane integrated TOF profile, respectively
%
% Fitting functions:
% * tf_dist - 1D TF density profile
% * tf_Q    - in-plane integrated count rate/density
%
% DK Shin

function varout = bec_profile(zxy)
%% Fig graphics
cf_paperunits='centimeters';
cf_papersize=[30,21];
cf_paperposition=[0 0 cf_papersize];

%% Main
% Exp constants
QE=0.1;     % quantum efficiency of detector
tof=0.413;
vz=tof*9.81;

r_sat_tol=0.6;          % cut-off scaling to allow for near saturation

Q_T_sat = 1e6;          % 1 MHZ MCP/DLD counting saturation rate
Q_Z_sat = Q_T_sat/vz;
Q_Z_sat=Q_Z_sat/QE;     % scale by QE

%% profiling config
% common
r_edge=2.5;     % half-range of profile to analyse from centre (in SD units)
n_bins=100;      % number of bins in z-profile range

% 1D slice
dxy=0.2e-3;       % in-plane tolerance (bin half-width in perp dims) [weak HW~2mm]

%% fit initial conditions
% in-plane integrated flux
Zfit.param0=[7e4,10e-3];        % [N0, W]

% 1D density profile (TF only)
zfit.param0=[3e11,10e-3];     % [n0, W]

% 1D density profile (TF + thermal)
zfit2.param0=[3e11,10e-3,10000,150e-9];      % [n0,W,Nth,Ta]

%% Parse input
n_shots=1;
% If input is a cell-array (shots) of ZXY then collate
if iscell(zxy)
    n_shots=size(zxy,1);    % Must be a Nx1 cell array
    zxy=vertcat(zxy{:});    % collate all shots to a single Mx3 array
end

%% In-plane integrated count profile
% get integrated density in Z
Z_collate = zxy(:,1);       % all z

Z_sd=std(Z_collate);        % rms width
Z_edge=linspace(-r_edge*Z_sd,r_edge*Z_sd,n_bins);    % TODO: could so many data at tails cause problems in fitting?
Z_cent=0.5*(Z_edge(1:end-1)+Z_edge(2:end));

N_Z = histcounts(Z_collate,Z_edge)/n_shots;     % normalise histogram by the number of shots
Q_Z = N_Z./(diff(Z_edge)*QE);    % count rate in Z

% Q_Z_sm = smooth(Q_Z,10);

fig=figure();
subplot(1,2,1); box on; grid on;
hold on;
plot(Z_cent,Q_Z,'-.','DisplayName','raw data');
% plot(Z_cent,Q_Z_sm,'k-');       % smoothed
axis tight;
h_sat_line=refline(0,Q_Z_sat);     % saturation
h_sat_line.Color='r';
h_sat_line.LineWidth=3;
h_sat_line.DisplayName='MCP sat rate';

title('in-plane integrated count rate');
xlabel('Z [m]'); ylabel('$Q(Z)$ [counts/m]');

% handle saturation effects
idx_QZ_ok=Q_Z<r_sat_tol*Q_Z_sat;
Z_cent_sat=Z_cent(~idx_QZ_ok);
Z_cent_ok=Z_cent(idx_QZ_ok);
Q_Z_ok=Q_Z(idx_QZ_ok);

figure(fig);
plot(Z_cent_ok,Q_Z_ok,'ko','DisplayName','data for fitting');

% fit and evaluate N0, W
Zfit.fun=@tf_Q;
Zfit.coefname={'N0','W_Z'};
Zfit.fitopts=statset('TolFun',1e-50,...
    'TolX',1e-50,...
    'MaxIter',1e4,...
    'UseParallel',1,...
    'FunValCheck','off',...
    'Display','off');

Zfit.fit=fitnlm(Z_cent_ok,Q_Z_ok,...
    Zfit.fun,Zfit.param0,...
    'CoefficientNames',Zfit.coefname,...
    'Options',Zfit.fitopts);

% Zfit.fit=fitnlm(Z_cent_ok,Q_Z_ok,...
%     Zfit.fun,Zfit.param0,...
%     'CoefficientNames',Zfit.coefname);

disp(Zfit.fit);

% get fit profile
Zfit.Z=linspace(min(Z_cent),max(Z_cent),1000);
Zfit.QZ=feval(Zfit.fit,Zfit.Z);

figure(fig);
subplot(1,2,1);
dispname_tmp=sprintf('fit: $N_0=%.2g$\n$W_Z=%.2g$',Zfit.fit.Coefficients.Estimate);
plot(Zfit.Z,Zfit.QZ,'k-','LineWidth',2,'DisplayName',dispname_tmp);

legend('show');     % show legend

%% Plot some user-configured models
% param_user=[5e3,15e-3];
% profile_user=tf_Q(param_user,Zfit.Z);
% figure(fig); subplot(1,2,1);
% plot(Zfit.Z,profile_user,'-');

%% 1D count density through centre (Z)
% get 1D slice in Z
z=zxy(abs(zxy(:,2))<dxy&abs(zxy(:,3))<dxy,1);

z_sd=std(z);
z_edge=linspace(-r_edge*z_sd,r_edge*z_sd,n_bins);
z_cent=0.5*(z_edge(1:end-1)+z_edge(2:end));

N_z = histcounts(z,z_edge)/n_shots;     % normalise histogram by the number of shots
n_z = N_z./(diff(z_edge)*(2*dxy)^2*QE);     % condensate density profile

figure(fig);
subplot(1,2,2); box on; grid on;
hold on;
plot(z_cent,n_z,'-.','DisplayName','raw data');

title('1D condensate density profile');
xlabel('Z [m]'); ylabel('$n(Z)$ [counts/m$^3$]');

% handle saturation effects - local saturation effects from integrated count flux
z_sat_range=[min(Z_cent_sat),max(Z_cent_sat)];
idx_nz_ok=z_cent<z_sat_range(1)|z_cent>z_sat_range(2);
z_cent_ok=z_cent(idx_nz_ok);
n_z_ok=n_z(idx_nz_ok);

figure(fig);
plot(z_cent_ok,n_z_ok,'ko','DisplayName','data for fitting');

% fit and evaluate n0, W
zfit.fun=@tf_dist;
zfit.coefname={'n0','W'};
zfit.fitopts=statset('TolFun',1e-30,...
    'TolX',1e-30,...
    'MaxIter',1e6,...
    'UseParallel',1,...
    'FunValCheck','off',...
    'Display','off');

zfit.fit=fitnlm(z_cent_ok,n_z_ok,...
    zfit.fun,zfit.param0,...
    'CoefficientNames',zfit.coefname,...
    'Options',zfit.fitopts);

% zfit.fit=fitnlm(z_cent_ok,n_z_ok,...
%     zfit.fun,zfit.param0,...
%     'CoefficientNames',zfit.coefname);

disp(zfit.fit);

% get fit profile
zfit.z=linspace(min(z_cent),max(z_cent),1000);
zfit.nz=feval(zfit.fit,zfit.z);

figure(fig);
subplot(1,2,2);
dispname_tmp=sprintf('fit: $n_0=%.2g$\n$W_Z=%.2g$',zfit.fit.Coefficients.Estimate);
plot(zfit.z,zfit.nz,'k-','LineWidth',2,'DisplayName',dispname_tmp);

legend('show');

%% TF + thermal fit
% Use above data for fitting
fig2=figure();
box on; grid on; hold on;
plot(z_cent,n_z,'-.','DisplayName','raw data');

title('1D condensate density profile');
xlabel('Z [m]'); ylabel('$n(Z)$ [counts/m$^3$]');

plot(z_cent_ok,n_z_ok,'ko','DisplayName','data for fitting');

% fit
zfit2.fun=@bec_thermal_dist;
zfit2.coefname={'n0','W','Nth','Ta'};
zfit2.fitopts=statset('TolFun',1e-50,...
    'TolX',1e-50,...
    'MaxIter',1e2,...
    'UseParallel',1,...
    'FunValCheck','off',...
    'Display','iter');

zfit2.fit=fitnlm(z_cent_ok,n_z_ok,...
    zfit2.fun,zfit2.param0,...
    'CoefficientNames',zfit2.coefname,...
    'Options',zfit2.fitopts);

disp(zfit2.fit);

% get fit profile
zfit2.z=linspace(min(z_cent),max(z_cent),1000);
zfit2.nz=feval(zfit2.fit,zfit2.z);

figure(fig2);
dispname_tmp=sprintf('fit: $n_0=%.2g$\n$W_Z=%.2g$\n$Nth=%.2g$\n$T_a=%.2g$',zfit2.fit.Coefficients.Estimate);
plot(zfit2.z,zfit2.nz,'k-','LineWidth',2,'DisplayName',dispname_tmp);

legend('show');


%% Fit with nlinfit
beta0=[3e11,10e-3];

options_tmp=statset('TolFun',1e-50,...
    'TolX',1e-50,...
    'MaxIter',1e3,...
    'UseParallel',1,...
    'FunValCheck','off',...
    'Display','iter');

[beta,R,J,CovB,MSE,ErrorModelInfo]=nlinfit(z_cent_ok,n_z_ok,@tf_dist,beta0,options_tmp)

ci1=nlparci(beta,R,'covar',CovB)
ci2=nlparci(beta,R,'jacobian',J)


%% Plot some user-configured models
% param_user=[8e10,18e-3];
% profile_user=tf_dist(param_user,zfit.z);
% figure(fig); subplot(1,2,2);
% plot(zfit.z,profile_user,'-');

%% Set figure dimensions
fig.Units=cf_paperunits;
fig.Position=cf_paperposition;
fig.PaperUnits=cf_paperunits;
fig.PaperSize=cf_papersize;
fig.PaperPosition=cf_paperposition;

%% Prepare output
varout=false;        % Dummy return value

end