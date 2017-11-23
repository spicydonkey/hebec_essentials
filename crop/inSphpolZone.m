function [v_in,bool_in]=inSphpolZone(v_spol,az_lim,el_lim,r_lim)
% Get counts in spherical-polar region defined by simple limits
%
% [V_IN,BOOL_IN]=INSPHPOLZONE(V_SPOL,AZ_LIM,EL_LIM,R_LIM)
%
%
% v_sphpol:     nCounts x 3 array (az,el,rad)
% az_lim:       1x2 limits of azim angles
% el_lim:       1x2 limits of elev angles
% r_lim:        1x2 limits of norm
%
% NOTE
%   * assume no argument error checking is done

az=v_spol(:,1);
el=v_spol(:,2);
r=v_spol(:,3);

% get boolean of vectors in zone - dims independently
b_az=(az>az_lim(1))&(az<az_lim(2));
b_el=(el>el_lim(1))&(el<el_lim(2));
b_r=(r>r_lim(1))&(r<r_lim(2));

% evaluate atoms in the zone
bool_in=b_az&b_el&b_r;
v_in=v_spol(bool_in,:);

end