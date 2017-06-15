% 3D mapping by scaling an ellipsoid to a unit sphere
function xyz_mapped=ell2usph(xyz,ellip_param)
    % xyz: nshot x 3 array
    % ellip_param: 1x9 array defining a general ellipsoid
    %   [centx,centy,centz,eulx,euly,eulz,r1,r2,r3]
    %   cent are centres
    %   eul are euler angles for ellipsoid principal axis
    %   r are ellipsoid radii along principal axis
    
    nshots=size(xyz,1);
    
    % get ellipsoid params
    xyz0=ellip_param(1:3);          % centres
    eul_angle=ellip_param(4:6);     % principal axis euler angles
    erad=ellip_param(7:9);          % principal radii
    
    % ellipsoid --> unit sphere mapping
    xyz_mapped=xyz-repmat(xyz0,[nshots,1]);     % zero centre
    
    Mrot=euler2rotm(eul_angle);     % rotation matrix to ellipsoid
    
    xyz_mapped=(Mrot'*xyz_mapped')';    % rotate ellipsoid to original coord basis
    
    for ii=1:3
        xyz_mapped(:,ii)=xyz_mapped(:,ii)/erad(ii);     % radii scaling
    end
    
    xyz_mapped=(Mrot*xyz_mapped')';     % rotate back to original coord system
end