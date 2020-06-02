function [n_r_arb,r_cent,b,n_r]=radialprofile(r_data,r_ed,verbose)
%Get radial distribution normalised by r-dependent bin volume
%
%   r_data: array of vector norms
%
%   n_r: radial density profile [arb. u.]
%   r_cent: bin centers
%   b: handle to bar/stairs plot
%

% input check
if ~exist('verbose','var')
    verbose=1;      % default is verbose
end
if ~exist('r_ed','var')
    r_ed=linspace(min(r_data),max(r_data),20);
end

% histogram counts
N_r=histcounts(r_data,r_ed);

% get bin centers
r_cent=r_ed(1:end-1)+0.5*diff(r_ed);

% normalise radially dependent bin volume = 4/3*pi*(r2^3 -r1^3)
vol_sph = @(r) 4/3*pi*r.^3;
vol_r_bin=diff(vol_sph(r_ed));      % exact bin volume

n_r=N_r./vol_r_bin;                 % normalise by bin vol

n_r_arb=n_r/maxall(n_r);       % normalies by max


% histogram plot
b=[];
if verbose>0
    b=stairs(r_cent,n_r);
    
    box on;
    xlabel('r');
    ylabel('P');
end
end