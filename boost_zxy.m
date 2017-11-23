function zxy_f = boost_zxy(zxy_i,dzxy)
% Add a constant offset to all particle distribution (re-centering)
%
% ZXY_F = BOOST_ZXY(ZXY_I,DZXY)
%
%
% ZXY_I:    cell-array of zxy counts
% DZXY:     1x3 zxy vector to shift
%

zxy_f=cell(size(zxy_i));
nshot=size(zxy_i,1);
for ii=1:nshot
    n=size(zxy_i{ii},1);   % num of counts in this shot
    zxy_f{ii}=zxy_i{ii}+repmat(dzxy,n,1);   % boost in cartesian
end
end