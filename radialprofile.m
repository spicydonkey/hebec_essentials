function [nr,rc]=radialprofile(r,red,verbose)
%Get radial distribution normalised by r-dependent bin volume
%
%   r: array of vector norms
%
%   nr: radial density profile [arb. u.]
%   rc: bin centers
%

% input check
if ~exist('verbose','var')
    verbose=1;      % default is verbose
end
if ~exist('red','var')
    red=linspace(min(r),max(r),20);
end

% histogram counts
nr=histcounts(r,red);

% get bin properties
rc=red(1:end-1)+0.5*diff(red);

% get normalised density
Vbin=1./(rc.^2);    % radially dependent bin volume (proportionality can be ignored)
nr=nr./Vbin;
nr=nr/max(nr);      % normalise max to 1

% histogram plot
if verbose>0
    figure;
    b=bar(rc,nr,'histc');
end

end