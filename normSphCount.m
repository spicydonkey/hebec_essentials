function norm=normSphCount(ww,azim,elev)
%
% NORM=NORMSPHCOUNT(WW,AZIM,ELEV)
%
% Evaluates the normalisation factor for weighted count distribution on
% sphere - such that the closed surface integral of the result from
% weightedCountSph equals 1.
% NOTE: spherical zones must be evenly spaced in azimuthal/elevation angles
%
% NORM: the normalisation factor (single count)
% WW: weighted counts in zones
% AZIM: azimuthal angles
% ELEV: elevation angles
%

% get lat-lon spacing
dTh=azim(2,1)-azim(1,1);
dPhi=elev(1,2)-elev(1,1);

norm=1/sum(sum(ww.*cos(elev)*dTh*dPhi));

end