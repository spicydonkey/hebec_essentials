% TXY post-processor to clean false counts from multi-pulse/ringing/alias reconstruction
%
% txy : Nx3 array of [T,X,Y] vectors
% dt_alias: aliasing dead-time in seconds (default 100 ns)
%
% bool_alias : Nx1 boolean array to indicate aliased points

function bool_alias = findalias(txy,dt_alias)
% check inputs
if ~exist('dt_alias','var')
    dt_alias=100e-9;        % Default: 100 ns dead-time (Sean's thesis)
end

% check if T is sorted
if ~issorted(txy(:,1))
    % T isn't sorted! might take long
    warning('Points are not ordered in time! this may take a while...');
    
    % TODO - sort txy according to T
end

% diffs in time of arrival
dt=diff(txy(:,1));

% check alias!
% TODO - check dX and dY!
bool_alias=(dt<dt_alias);
bool_alias=[false;bool_alias];      % define "FIRST HIT" as genuine

end