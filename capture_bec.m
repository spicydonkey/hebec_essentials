function [bec_cent,bool_bec]=capture_bec(zxy,bec_cent0,r_ball,verbose)
% Locate condensate by cropping a ball around estimated centres and
%   radius and AVERAGE count positions - ITERATED until convergence
%
% [BEC_CENT,BOOL_BEC] = CAPTURE_BEC(ZXY,BEC_CENT0,R_BALL,VERBOSE)
%
%
% TODO
%   [ ] generalise to finding a sharp density region (like BEC)
%

if ~exist('verbose','var')
    verbose=0;
end

% config iterator
tol=1e-5;   % BEC centre estimate tolerance


% initialise iterative minimisation algorithm
cent=bec_cent0;
cent_new=cent;
err_cent=Inf;
n_bec_max=0;
n_iter=0;
while err_cent>tol
    cent=cent_new;      % update ball centre for BEC capture
    
    % Evaluate BEC centre
    [zxy_bec,bool_bec]=cropBall(zxy,r_ball,cent);
    cent_new=mean(zxy_bec,1);       % approx of BEC centre by mean position
    err_cent=vnorm(cent-cent_new);    % error this iteration
    
    % total count in this ball - used to tell if BEC well-captured
    num_in_bec=sum(bool_bec);
    if num_in_bec>n_bec_max
        n_bec_max=num_in_bec;
    end
    
    n_iter=n_iter+1;
end
% centre has converged! update results
bec_cent=double(cent);

% Summary
if verbose>0
    fprintf('-------------------------------------------------\n');
    fprintf('capture_bec:\n');
    fprintf('Iterations: %d\n',n_iter);
    fprintf('Total counts in BEC (max): %d (%d)\n',num_in_bec,n_bec_max);
    % total deviation from initial guess
    dev_tot=vnorm(bec_cent-bec_cent0);
    fprintf('Deviation from initial guess: %0.2g (mm)\n',1e3*dev_tot);
end

end