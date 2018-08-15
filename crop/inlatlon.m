function [b_in,n_in]=inlatlon(V,lim_latlon)
% Get counts in lat-lon-(norm) region defined with min-max limits
%
%   b_in:   boolean flags for vecs in region
%   n_in:   num vecs in region
%
%   V: ZXY-vector array
%   lim_latlon: 1x3 cell-array of [min,max] limits in the order: azim,elev,norm
%       leave limit empty (i.e. []) to ignore
%
%   BUG: azim limits should be limited to and not wrap around [-pi,pi]
%


Vspol=zxy2sphpol(V);        % tranform to spherical coord
n_v=size(Vspol,1);          % num of vecs

b_spol=true(n_v,3);     % initialise boolean flag in each dim
for ii=1:3
    if ~isempty(lim_latlon{ii})
        tlim=lim_latlon{ii};    % this dim limit
        tvs=Vspol(:,ii);         % this component
        
        b_spol(:,ii)=(tlim(1)<tvs)&(tlim(2)>tvs);
    end
end

% find vecs in region
b_in=prod(b_spol,2)==1;
n_in=sum(b_in);

end