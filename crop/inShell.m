function [v_in,b_in,n]=inShell(zxy,r0,dr)
%inShell: Get counts in a spherical shell
%
%   zxy: array of Cart row vectors
%   r0: centre radius of shell
%   dr: shell half-thickness
%
%   v_in: C-vecs in shell
%   b_in: boolean array for vecs in shell
%   n:  num vecs in shell


% vector norms
r = vnorm(zxy,2);

% filter vecs in cone
b_in=abs(r - r0)<dr;
v_in=zxy(b_in,:);
n=sum(b_in);

end