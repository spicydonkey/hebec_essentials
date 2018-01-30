function xf = cfilter_norm(x,rmin,rmax)
%xf = cfilter_norm(x,rmin,rmax)
%
%   filter_norm wrapper for cell-array dataset
%

xf=cellfun(@(C) filter_norm(C,rmin,rmax),x,'UniformOutput',false);

end