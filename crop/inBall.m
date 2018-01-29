function [v_in,b_in]=inBall(v,r,v0)
%Get vectors lying in a ball.
%
%   v: array of row-vectors (cartesian)
%   r: ball radius
%   v0: ball center (cart). Default is at origin.
%

ndim=size(v,2);     % dimension of vector space

if ~exist('v0','var')
    v0=zeros(1,ndim);
end

u=v-v0;     % recentered coord sys
ur=vnorm(u,2);      % norms

b_in=ur<r;
v_in=v(b_in,:);

end