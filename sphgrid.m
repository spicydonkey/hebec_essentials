function [az,el] = sphgrid(naz,nel,az_lim,el_lim,b_wrap)
%SPHGRID construct 2D lat-lon grid on sphere.
%   [AZ,EL] = SPHGRID(NAZ,NEL)
%   [AZ,EL] = SPHGRID(NAZ,NEL,AZ_LIM,EL_LIM)
%
%   Grid are in linearly divisions of lat-lon lines on a sphere in radians.
%
%   NB: NAZ should be even for the constructed grid to be invertible.
%   Parity of NEL has no effect.
%   

% check args
if nargin < 5
    b_wrap = false;     % default don't wrap
    
    if ~exist('az_lim','var')
        az_lim=[-pi,pi];
    end
    if ~exist('el_lim','var')
        el_lim=[-pi/2,pi/2];
    end
end

% 1D linearly spaced lat/lon
az1=linspace(az_lim(1),az_lim(2),naz+1);
az1=az1(1:end-1);       % azimuthal angle will wrap in default usage

el1=linspace(el_lim(1),el_lim(2),nel);

% create 2D grid of lat-lon points
[az,el]=ndgrid(az1,el1);

end