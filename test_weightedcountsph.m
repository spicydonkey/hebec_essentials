% Test weigthedCountSph

% configure
sig=[5e-1,Inf];
lim=[3,3];

n_gen_counts=1000;

% generate randomly distributed counts on sphere
usph_cart=get_rand_usph(n_gen_counts);

% get counts in spherical-coord
usph_sph=zeros(size(usph_cart,1),3);
[usph_sph(:,1),usph_sph(:,2),usph_sph(:,3)]=cart2sph(usph_cart(:,1),usph_cart(:,2),usph_cart(:,3));

% define spherical zones
az=linspace(-pi,pi,50);
az=az(1:end-1);     % unique angles only
el=linspace(-pi/2,pi/2,25);

[z_az,z_el]=ndgrid(az,el);      % grid to preserve dimensional ordering in array indexing

% evaluate count density in sphere by the weighted counting algorithm
nCountsTot=size(usph_sph,1);
ww=zeros(size(z_az));
for ii=1:numel(z_az)
    tzone=[z_az(ii),z_el(ii),1];
    tww=weightedCountSph(usph_sph,tzone,sig,lim);
    ww(ii)=tww;
end

% normalise weighted count density
wNormFactor=nCountsTot*normSphCount(ww,z_az,z_el);
ww=ww*wNormFactor;

% plot the distribution of weghted counts in spherical zone
figure(1);
scatter_zxy(usph_cart(:,[3,1,2]),10,'g');
hold on;
plot_sph_surf(z_az,z_el,ww);
hold off;
colorbar();