function psi=diffAngleSph(th1,phi1,th2,phi2)
% PSI = DIFFANGLESPH(TH1,PHI1,TH2,PHI2)
% Evaluates the relative angle between two vectors defined in spherical
% coordinates
% 
% TH: azimuthal angles (std Matlab convention)
% PHI: elev angles ([-pi/2,pi/2])
% 
% DKS

psi=real(acos(sin(phi1).*sin(phi2)+cos(phi1).*cos(phi2).*cos(th1-th2)));
end