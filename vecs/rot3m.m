function R = rot3m(u,theta)
% rotation matrix from an axis and an angle.
% DKS 2020

if ~isequal(size(u),[3,1])
    error('axis vector "u" must be a 3x1 vector.');
end
% normalise axis
u = u/vnorm(u);

% rotation matrix
R = cos(theta)*eye(3) + sin(theta)*cross3m(u) + (1-cos(theta))*(u*u');

end