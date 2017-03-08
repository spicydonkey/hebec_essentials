% Script to test function bec_profile
% 08/03/2017
% DK Shin

% Load data with minimal config
cf.files.path='C:\Users\HE BEC\Documents\lab\quantum-depletion\exp7\d';
cf.files.id=1000:1100;
cf.window={[0.55,0.6],[-30e-3,30e-3],[-30e-3,30e-3]};   % capture BEC counts

[txy,fout]=loadExpData(cf,1);

% centre around BEC
[zxy,~,se_cpos,sd_pos]=cellfun(@get_bec_zxy,txy,'UniformOutput',false);

figure(); box on;
plot_zxy(zxy,1e5);
view(3); axis equal;
xlabel('X [m]'); ylabel('Y [m]'); zlabel('Z [m]');

% call bec_profile function
bec_profile(zxy);
