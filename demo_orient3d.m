%% DEMO of 3D orientations
%%% configs
configs.zone.lim_az=pi*[-1,1];
configs.zone.lim_el=pi/2*[-1,1];

configs.zone.n_az=400;
configs.zone.n_el=200;

configs.zone.az=linspace(configs.zone.lim_az(1),configs.zone.lim_az(2),configs.zone.n_az+1);
configs.zone.az=configs.zone.az(1:end-1);
configs.zone.el=linspace(configs.zone.lim_el(1),configs.zone.lim_el(2),configs.zone.n_el);

azel=configs.zone;

[az_grid,el_grid]=ndgrid(configs.zone.az,configs.zone.el);    % az-el grid
n_zone=numel(az_grid);
azel_dims=size(az_grid);

% proper Euler angle
configs.orient.euler=[pi/2,-pi/4-0.15,0];    


%%% Coord transformation
[x,y,z] = arrayfun(@(th,phi) sph2cart(th,phi,1),az_grid,el_grid);   % Cart grid (ext)

invR = inv(euler2rotm2(configs.orient.euler));  % rotation matrix: xyz --> XYZ

v_XYZ = arrayfun(@(x,y,z) invR*[x;y;z],x,y,z,'UniformOutput',false);    % Cart grid (int)
X=cellfun(@(V) V(1),v_XYZ);
Y=cellfun(@(V) V(2),v_XYZ);
Z=cellfun(@(V) V(3),v_XYZ);

[th_rot,phi_rot,r_rot]=arrayfun(@(x,y,z) cart2sph(x,y,z),X,Y,Z);


%% Application
phi_rot_lim=0.01;        % elev angle limit in rot'd coord
phi_rot0=0*pi/2;

% select ring of const elev angle on rotated frame
b_sel=abs(phi_rot-phi_rot0)<phi_rot_lim;

% vis
tmap=plotFlatMapWrappedRad(az_grid,el_grid,double(b_sel),'rect','texturemap');

ax=gca;
axis tight;
xlim([-180,180]);
xticks(-180:90:180);
yticks(-45:45:45);
xlabel('$\theta$ (deg)');
ylabel('$\phi$ (deg)');
% axis off;
colormap('gray');