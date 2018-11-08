function V = row2set(x)
% ROW2SET forms 2D array into 1D cell array of original rows as elems
%
% DKS
% 2018-11-08

n_vec=size(x,1);
l_vec=size(x,2);

V = mat2cell(x,ones(n_vec,1),l_vec);

end