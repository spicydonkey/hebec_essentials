function V = cross3m(v)
% cross product matrix of a R3 vector.
% DKS 2020

V = [0, -v(3), v(2);
    v(3), 0, -v(1);
    -v(2), v(1), 0];

end