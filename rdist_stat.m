function [r_mean,r_std,r] = rdist_stat(x,verbose)
%Simple summary of radial distribution
%
%   x: array of row vectors
%  

if ~exist('verbose','var')
    verbose=0;
end

r = vnorm(x,2);

r_mean=mean(r);
r_std=std(r);

if verbose>0
    histogram(r);
    xlabel('r');
    ylabel('N');
end

end