function V = boost_zxy(U,du)
%Apply uniform offset to all shots.
%   - Useful for re-centering experimental data.
%
% V = BOOST_ZXY(U,du)
%
%   U: shots of vectors
%   du: offset vector
%

V=cellfun(@(x) x+du,U,'UniformOutput',false);

end