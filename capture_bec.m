% Locate condensate by cropping a ball around estimated centres and
%   radius and AVERAGE count positions - ITERATED until convergence 

function [bec_cent,bool_bec]=capture_bec(zxy,bec_cent0,r_ball,verbose)
% BEC centre estimate tolerance
tol=1e-5;

% get run stats
nshots=size(zxy,1);
nbec=length(bec_cent0);

% initialise BEC results
bec_cent=cell(nshots,nbec);
bool_bec=cell(nshots,nbec);

for ii=1:nshots
    zxy_this=zxy{ii};   % points in this shot
    ncounts=size(zxy_this,1);   % number of counts in this shot
    
    for jj=1:nbec
        % initialise iterative minimisation algorithm
        cent=bec_cent0{jj};
        cent_new=cent;
        rad=r_ball{jj};
        err_cent=Inf;
        n_bec_max=0;
        n_iter=0;
        fi
        while err_cent>tol
            % update ball centre for BEC capture
            cent=cent_new;
            
            zxy0=zxy_this-repmat(cent,[ncounts,1]);     % centre to ball
            r0=sqrt(sum(zxy0.^2,2));            % evaluate radial distances
            
            is_bec=r0<rad;      % logical index vector for BEC - atoms within r_ball
            zxy_bec=zxy_this(is_bec,:);     % collate captured BEC counts
            
            % Evaluate BEC centre
            cent_new=mean(zxy_bec,1);       % approx of BEC centre by mean position
            err_cent=abs(cent-cent_new);    % error this iteration
            
            % total count in this ball - used to tell if BEC well-captured
            num_in_bec=sum(is_bec);
            if num_in_bec>n_bec_max
                n_bec_max=num_in_bec;
            end
            
            n_iter=n_iter+1;
        end
        % centre has converged! update results
        bec_cent{ii,jj}=cent;
        bool_bec{ii,jj}=is_bec;
        
    end
end