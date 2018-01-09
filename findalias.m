function bool_alias = findalias(txy,dt_alias,dxy_alias,verbose)
% bool_alias = findalias(txy,dt_alias,dxy_alias)
%
% TXY post-processor to clean false counts from multi-pulse/ringing/alias reconstruction
%
% txy : Nx3 array of [T,X,Y] vectors
% dt_alias: aliasing dead-time in seconds (default 100 ns)
% dxy_alias: diff in X,Y to distinguish separate counts (default Inf)
%
% bool_alias : Nx1 boolean array to indicate aliased points

% check inputs
if ~exist('dt_alias','var')
    dt_alias=100e-9;        % Default: 100 ns dead-time (Sean's thesis)
end
if ~exist('dxy_alias','var')
    dxy_alias=Inf;          % Default: reject all counts if dt in deadtime
end
if ~exist('verbose','var')
    verbose=0;
end

% check if T is sorted
Isort=[];
if ~issorted(txy(:,1))
    % T isn't sorted! might take long
    if verbose>0
        warning('Points are not ordered in time! this may take a while...');
    end
    
    % TODO - sort txy according to T
    [txy,Isort]=sortrows(txy,1);    % txy is sorted from here!
    [~,Irev]=sort(Isort);           % reverse sort back to original
end
% T is sorted!

% diffs in time of arrival & spatial
dt=diff(txy(:,1),1,1);          
dxy=diff(txy(:,2:3),1,1);       % diff in xy for "T-neighbouring counts"

% check alias!
bool_alias=(dt<dt_alias);                   % proximity in time
bool_nearxy=(max(dxy,[],2)<dxy_alias);      % proximity in XY

bool_alias=[false;bool_alias];      % define "FIRST HIT" as genuine
bool_nearxy=[false;bool_nearxy];

% discounts only when two hits are BOTH near in TIME and SPACE
bool_alias=bool_alias&bool_nearxy;

% handle index scrambled data from sort
if ~isempty(Isort)
    bool_alias=bool_alias(Irev);    % reverse back to original data indexing
end

end