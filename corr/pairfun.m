function f = pairfun(fun_pair,x)
% PAIRFUN finds all function values returned from all *pairs* (2-tuple vs
% 2-set)
%
% INPUTS
%   function_pair: function with 2 params
%   x: 1D cell-array objects
%
% OUTPUT
%   f: 2D cell-array of function values: f(i,j) == f(x{i},x{j})
%
%------------------------------------------------------------------
%   TODO
%   PAIRS: ordered? unordered? self-pairing allowed?
%   (u,v) 2-tuple(?) selected u from U, v from V
%   generalisation to N-tuple/N-set ?
%
% DKS
% 2018-11-08

% config
max_length=1e3;      % memory limited

% main
n=length(x);
if n>max_length
    error('maximum size of set has exceeded.');
end

X1=repmat(x,1,n);
X2=X1';

f = cellfun(@(x1,x2) fun_pair(x1,x2),X1,X2,'UniformOutput',false);

end