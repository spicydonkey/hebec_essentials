function [v,b]=cropBall(V,r,v0,isin)
%Get vectors lying in/out-side a ball.
%
%   v: array of row-vectors (cartesian)
%   r: ball radius
%   v0: ball center (cart). Default is at origin.
%   isin: boolean flag to select in/out
%

ndim=size(V,2);     % dimension of vector space

if ~exist('v0','var')
    v0=zeros(1,ndim);
end
if ~exist ('isin','var')
    isin=true;
end

u=V-v0;     % recentered coord sys
ur=vnorm(u,2);      % norms

b=ur<r;
if ~isin
    b=~b;
end

v=V(b,:);

end