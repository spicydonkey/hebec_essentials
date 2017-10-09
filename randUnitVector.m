% generate a random unit vector in cartesian coordinate system
function uvec_rand = randUnitVector(dimVect)
uvec_rand = rand(dimVect,1);
uvec_norm = sqrt(sumsqr(uvec_rand));
uvec_rand = uvec_rand/uvec_norm;
end