%% demo predict
% DKS 2019


%% config
% n-sigma confidence interval for prediction
pred_n_sig = 1;     % n-sdev range: mu ± n*sigma


%% generate noisy data
% simple harmonic motion with amplitude and phase noise

n = 1e2;
x = linspace(0,3*pi,n)';

amp_avg = 3;
amp_sig = 1;

phi_avg = 0;
phi_sig = 0.1;

amp = normrnd(amp_avg,amp_sig,size(x));
phi = normrnd(phi_avg,phi_sig,size(x));

y = amp.*sin(x + phi);


%% fit
mdl_fun = @(b,x) b(1).*sin(b(2)*x);
mdl_par0 = [amp_avg,1];

mdl_fit = fitnlm(x,y,mdl_fun,mdl_par0);


%% predict
X = linspace_lim(min_max(x),1e3)';
[Y,Yci] = predict_nsig(mdl_fit,X,pred_n_sig);


%% vis
H = figure('name','demo_predict');
p_raw = plot(x,y,'ok','DisplayName','data');

hold on;
p_fit = plot(X,Y,'-r','DisplayName','fit est.');
p_fit_ci = plot(X,Yci,'--r','DisplayName',sprintf('CI ($\\pm %0.2g \\sigma$)',pred_n_sig));

lgd = legend([p_raw,p_fit,p_fit_ci(1)],'Location','best');
