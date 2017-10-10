% Create a 1D Gaussian convolution profile
%
% hsize : length of gaussFilter vector (nominal: 5)
% sigma : standard deviation (nominal: 0.5)
%
function gProf = gaussFilter(hsize,sigma)
xx = linspace(-hsize/2,hsize/2,hsize);
gProf = exp(-xx.^2 /(2*sigma^2));
gProf = gProf/sum(gProf);               % normalise
end