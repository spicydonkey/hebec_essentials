% 3D mapping - affine transformation of unit sphere (centered) to ellipsoid (inverse
% of ell2usph map)
function xyz_ell=usph2ell(xyz,ellip_param)
    % xyz: nshot x 3 array
    % ellip_param: 1x9 array defining a general ellipsoid
    %   [centx,centy,centz,eulx,euly,eulz,r1,r2,r3]
    %   cent are centres
    %   eul are euler angles for ellipsoid principal axis
    %   r are ellipsoid semiprincipal axes (radii)
    
    npoints=size(xyz,1);

    % get ellipsoid params
    xyz0=ellip_param(1:3);          % centres
    eul_angle=ellip_param(4:6);     % principal axis euler angles
    erad=ellip_param(7:9);          % semiprincipal axes/radii
    
    %% unit sphere --> ellipsoid
    xyz_ell=xyz;
    
    Mrot=euler2rotm(eul_angle);     % rotation matrix to ellipsoid coord system
    
    % rotate unit sphere frame to ellipsoid principal axes
    xyz_ell=(Mrot*xyz_ell')';
    
    % radii scaling
    for ii=1:3
        xyz_ell(:,ii)=xyz_ell(:,ii)*erad(ii);
    end
    
    % rotate back to original coord system
    xyz_ell=(Mrot'*xyz_ell')';
    
    % shift centre
    xyz_ell=xyz_ell+repmat(xyz0,[npoints,1]);
end