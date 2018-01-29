function vec_cents=edge2cent(vec_edges)
%Bin-edge vector to centers.
%

vec_cents=vec_edges(1:end-1)+0.5*diff(vec_edges);

end