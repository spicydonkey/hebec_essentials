function nx = equalCount(x,y)
%EQUALCOUNT counts the number of elements in array equal to specified value
% DKS
% 20181120

x=x(:);     % form into a 1D vector
nx = arrayfun(@(Y) sum(x==Y),y);

end