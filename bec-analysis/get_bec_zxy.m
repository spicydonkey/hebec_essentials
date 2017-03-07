% Get BEC centered ZXY from TXY
%
% DKS 07/03/2017
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INPUT
%   txy
%   capture_lims    - cropping limits as specified by the appropriate
%       cropping function
%   capture_method  - box/cylinder/ellipsoid
%
% OUTPUT
%   zxy_out
%   n_out
%   se_cpos
%   sd_pos
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [zxy0,n_out,se_cpos,sd_pos]=get_bec_zxy(txy,varargin)
nVarargs=length(varargin);     % number of optional arguments

if nVarargs==0
    capture_method='box';
    capture_lims={[],[],[]};
elseif nVarargs==1
    capture_method='box';
    capture_lims=varargin{1};
elseif nVargargs==2
    % TODO - make all other cull functions (i.e. cylindercull and
    % ellipsoid) so that they accept lims (struct?) and cartesian array
    % only (2 params!)
    capture_method=varargin{2};
    capture_lims=varargin{1};
else
    error('Incorrect usage.');
end

% first order approximation for T-Z conversion
tof=0.413;
vz=9.81*tof;
zxy=txy;
zxy(:,1)=zxy(:,1)*vz;   % T-Z

% scale capture lims to Z
capture_lims{1}=capture_lims{1}*vz;     % TODO - won't work in cylinder/ellipsoid yet

% call capturing functions
switch capture_method
    case 'box'
        [zxy_win,~,n_out,cpos,se_cpos,sd_pos]=boxcull(zxy,capture_lims);
        
    case 'cylinder'
        error('Code must be improved');
        
    case 'ellipsoid'
        error('Code must be improved');
        
    otherwise
        error('capture_method must be either "box", "cylinder", or "ellipsoid"');
end

% TODO - improve for heavily saturated shots
% centre ZXY to mean position
zxy0=zxy_win-repmat(cpos,[size(zxy_win,1),1]);