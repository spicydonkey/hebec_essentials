% 3D mapping: affine transformation of an ellipsoid to unit sphere
% (zero-centred)
function xyz_usph=ell2usph(xyz,ellip_param)
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
    
    %% ellipsoid --> unit sphere mapping
    % zero centre
    xyz_usph=xyz-repmat(xyz0,[npoints,1]);     
    
    % rotation matrix to ellipsoid
    Mrot=euler2rotm(eul_angle);     
    
    % rotate ellipsoid to original coord basis
    xyz_usph=(Mrot*xyz_usph')';
    
    % radii scaling
    for ii=1:3
        xyz_usph(:,ii)=xyz_usph(:,ii)/erad(ii);     
    end
    
    % rotate back to original coord system
    xyz_usph=(Mrot'*xyz_usph')';
end