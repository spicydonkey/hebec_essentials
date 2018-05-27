function b = is_file(filename)
% Determine if input is file
%   is_file is 'isfile' (2017b) for older versions of matlab
%
% 2018-05-27
% DKS

b=  (exist(filename,'file') == 2);

end