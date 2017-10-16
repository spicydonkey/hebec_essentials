% Test weigthedCountSph

%% configure
% source
n_gen_counts=10000;
r_sigma=0.05;

% mode distribution
nAz=200;
nEl=100;

% norm integrated
sig=[0.1,Inf];
lim=[3,3];

% norm resolved
mode_thphi=[0,0];
sig2=[5e-1,0.01];
lim2=[3,3];
rr=0.8:0.01:1.2;

%% genrate source - halo with finite thickness
% generate randomly distributed counts on sphere
usph_cart=get_rand_usph(n_gen_counts);

% dither vector norms
r_dither=random('Normal',1,r_sigma,[size(usph_cart,1),1]);
vs_cart=usph_cart.*repmat(r_dither,[1,3]);

%% main
% get counts in spherical-coord
% usph_sph=zeros(size(usph_cart,1),3);
vs_sph=zeros(size(vs_cart,1),3);
% [usph_sph(:,1),usph_sph(:,2),usph_sph(:,3)]=cart2sph(usph_cart(:,1),usph_cart(:,2),usph_cart(:,3));
[vs_sph(:,1),vs_sph(:,2),vs_sph(:,3)]=cart2sph(vs_cart(:,1),vs_cart(:,2),vs_cart(:,3));

% define spherical zones
az=linspace(-pi,pi,nAz);
az=az(1:end-1);     % unique angles only
el=linspace(-pi/2,pi/2,nEl);

[z_az,z_el]=ndgrid(az,el);      % grid to preserve dimensional ordering in array indexing

% evaluate count density in sphere by the weighted counting algorithm
% nCountsTot=size(usph_sph,1);
nCountsTot=size(vs_sph,1);
ww=zeros(size(z_az));
for ii=1:numel(z_az)
    tzone=[z_az(ii),z_el(ii),1];
%     tww=weightedCountSph(usph_sph,tzone,sig,lim);
    tww=weightedCountSph(vs_sph,tzone,sig,lim);
    ww(ii)=tww;
end

% normalise weighted count density
wNormFactor=nCountsTot*normSphCount(ww,z_az,z_el);
ww=ww*wNormFactor;


%%% norm-resolved profile
% counts in mode (norm integrated)
ww_mode=weightedCountSph(vs_sph,[mode_thphi,1],[sig2(1),Inf],[lim2(1),Inf]);
% counts in mode-parallel (norm resolved)
ww_mode_rr=countRadMode(vs_sph,rr,mode_thphi,sig2,lim2);
int_ww_mode_rr=sum(ww_mode_rr*(rr(2)-rr(1)));
norm_mode_rr=ww_mode/int_ww_mode_rr;
ww_mode_rr=ww_mode_rr*norm_mode_rr;

%% Plot
%%% plot the distribution of weghted counts in spherical zone
figure(1);
% scatter_zxy(usph_cart(:,[3,1,2]),10,'g');
scatter_zxy(vs_cart(:,[3,1,2]),10,'g');
hold on;
plot_sph_surf(z_az,z_el,ww);
hold off;
colorbar();

%%% radial distribution at selected mode
figure(2);
plot(rr,ww_mode_rr,'o--');

% annotation
titleStr=sprintf('Mode: THETA=%0.2g, PHI=%0.2g',mode_thphi(:));
title(titleStr);
xlabel('Mode norm');
ylabel('Number of counts in mode');