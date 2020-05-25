% test IND2SUBV

%% 2D
% generate random boolean matrix
siz = randi(10,[1,2]);

a = rand(siz);              
a = a > 0.9;           

I = find(a);        

S = ind2subv(siz,I);

[I1,I2] = ind2sub(siz,I);
Sref = [I1,I2];

if ~isequal(Sref,S)
    warning('FAIL');
else
    warning('PASS');
end



%% 3D
% generate random boolean matrix
siz = randi(10,[1,3]);

a = rand(siz);              
a = a > 0.9;           

I = find(a);        

S = ind2subv(siz,I);

[I1,I2,I3] = ind2sub(siz,I);
Sref = [I1,I2,I3];

if ~isequal(Sref,S)
    warning('FAIL');
else
    warning('PASS');
end



%% 4D
% generate random boolean matrix
siz = randi(10,[1,4]);

a = rand(siz);              
a = a > 0.9;           

I = find(a);        

S = ind2subv(siz,I);

[I1,I2,I3,I4] = ind2sub(siz,I);
Sref = [I1,I2,I3,I4];

if ~isequal(Sref,S)
    warning('FAIL');
else
    warning('PASS');
end

