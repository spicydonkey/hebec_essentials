function kk=sphpol2zxy(ss)
% Converts spherical-polar vectors to Cart coords (ZXY experiment form)
%
% KK = SPHPOL2ZXY(SS)
%
% SS: Nx3 array of form [az,el,rad]
% KK: Nx3 array of form [Z,X,Y]
%

% use matlab's default function to transform spol --> cart
[kkx,kky,kkz]=sph2cart(ss(:,1),ss(:,2),ss(:,3));   % in XYZ form
% kk=circshift(kk,1,2);       % XYZ --> ZXY
kk=[kkz,kkx,kky];

end