function Vth = rot3theta(urot,v,theta)
% rotate a vector around an axis.
% DKS 2020

Vth = urot*(dot(urot,v)) + cross(cross(urot,v),urot).*cos(theta) + cross(urot,v).*sin(theta);

end