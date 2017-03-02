% Estimation of condensate parameters
% Summary: condensate peak density (n0) and condensate population (N0) are key estimations from a
% density fit to the Z-column and in-plane integrated TOF profile, respectively
%
% * tf_dist - 1D TF density profile
% * tf_Q - in-plane integrated count rate/density
%
% DK Shin
% 02/03/2017

clear all;
    
% TODO: package as a function

% Exp constants
QE=0.1;     % quantum efficiency of detector
tof=0.413;
vz=tof*9.81;

Q_T_sat = 1e6;  % 1 MHZ MCP/DLD counting saturation rate
Q_Z_sat = Q_T_sat/vz;
% scale by QE
Q_Z_sat=Q_Z_sat/QE;

% Load some experimental data
fpath='Y:\TDC_user\ProgramFiles\my_read_tdc_gui_v1.0.1\dld_output\QuantumDepletion\Run7\d';
fid_str='1000';

txy_raw=txy_importer(fpath,fid_str);        % load txy data

% cull to region of interest
ROI_lims={[0.55,0.59],[-30e-3,20e-3],[-40e-3,10e-3]};       % lims in T,X,Y

txy_culled=txy_raw;     % copy raw data
for i_dim=1:3
    txy_culled=txy_culled(txy_culled(:,i_dim)>ROI_lims{i_dim}(1)&txy_culled(:,i_dim)<ROI_lims{i_dim}(2),:);
end

% centre to BEC
bec_cent=mean(txy_culled,1);
txy0=txy_culled-repmat(bec_cent,[size(txy_culled,1),1]);

% T-Z conversion

zxy=txy0;
zxy(:,1)=zxy(:,1)*vz;

%% In-plane integrated count profile
% get integrated density in Z
Z_collate = zxy(:,1);       % all z

Z_sd=std(Z_collate);        % rms width
Z_edge=linspace(-6*Z_sd,6*Z_sd,100);
Z_cent=0.5*(Z_edge(1:end-1)+Z_edge(2:end));

N_Z = histcounts(Z_collate,Z_edge);
Q_Z = N_Z./(diff(Z_edge)*QE);    % count rate in Z

% Q_Z_sm = smooth(Q_Z,10);

fig=figure();
subplot(1,2,1); box on; grid on;
hold on;
plot(Z_cent,Q_Z,'-.');          
% plot(Z_cent,Q_Z_sm,'k-');       % smoothed
axis tight;
refline(0,Q_Z_sat);     % saturation

title('in-plane integrated count rate');
xlabel('Z [m]'); ylabel('Q(Z) [counts/m]');

% handle saturation effects
idx_QZ_ok=Q_Z<Q_Z_sat;
Z_cent_sat=Z_cent(~idx_QZ_ok);
Z_cent_ok=Z_cent(idx_QZ_ok);
Q_Z_ok=Q_Z(idx_QZ_ok);

figure(fig);
plot(Z_cent_ok,Q_Z_ok,'k*');

% fit and evaluate N0, W
Zfit.fun=@tf_Q;
Zfit.coefname={'N0','W_Z'};
Zfit.param0=[5e4,20e-3];
Zfit.fitopts=statset('TolFun',1e-50,...
    'TolX',1e-50,...
    'MaxIter',1e6,...
    'UseParallel',1,...
    'Display','iter');

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
plot(Zfit.Z,Zfit.QZ,'k--');

%% Plot some user-configured models
% param_user=[5e3,15e-3];
% profile_user=tf_Q(param_user,Zfit.Z);
% figure(fig); subplot(1,2,1);
% plot(Zfit.Z,profile_user,'-');

axis tight;

%% 1D count density through centre (Z)
% get 1D slice in Z
dxy=1e-3;   % in-plane tolerance
z=zxy(abs(zxy(:,2))<dxy&abs(zxy(:,3))<dxy,1);

z_sd=std(z);
z_edge=linspace(-6*z_sd,6*z_sd,100);
z_cent=0.5*(z_edge(1:end-1)+z_edge(2:end));

N_z = histcounts(z,z_edge);
n_z = N_z./(diff(z_edge)*dxy^2*QE);     % condensate density profile

figure(fig);
subplot(1,2,2); box on; grid on;
hold on;
plot(z_cent,n_z,'-.');

title('1D condensate density profile');
xlabel('Z [m]'); ylabel('n(Z) [counts/m^3]');

% handle saturation effects - local saturation effects from integrated count flux
z_sat_range=[min(Z_cent_sat),max(Z_cent_sat)];
idx_nz_ok=z_cent<z_sat_range(1)|z_cent>z_sat_range(2);
z_cent_ok=z_cent(idx_nz_ok);
n_z_ok=n_z(idx_nz_ok);

figure(fig);
plot(z_cent_ok,n_z_ok,'k*');

% fit and evaluate n0, W
zfit.fun=@tf_dist;
zfit.coefname={'n0','W'};
zfit.param0=[10e11,20e-3];
zfit.fitopts=statset('TolFun',1e-50,...
    'TolX',1e-50,...
    'MaxIter',1e6,...
    'UseParallel',1,...
    'Display','iter');

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
plot(zfit.z,zfit.nz,'k--');

%% Plot some user-configured models
% param_user=[8e10,18e-3];
% profile_user=tf_dist(param_user,zfit.z);
% figure(fig); subplot(1,2,2);
% plot(zfit.z,profile_user,'-');

axis tight;
