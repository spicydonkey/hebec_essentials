function zxy_f = boost_zxy(zxy_i,dzxy)
zxy_f=cell(size(zxy_i));
nshot=size(zxy_i,1);
for ii=1:nshot
    n=size(zxy_i{ii},1);   % num of counts in this shot
    zxy_f{ii}=zxy_i{ii}+repmat(dzxy,n,1);   % boost in cartesian
end
end