% Lerch vs g_bose (polylog)

z=linspace(0,1,10);

gLerch=[];
for i=1:length(z)
    gLerch(i)=z(i)*lerch(z(i),3/2,1);   % lerch transcedental identity to polylog order 3/2
end

gbose=g_bose(z);

disp(gLerch);
disp(gbose);

ERR=abs((gLerch-gbose)./gbose);
disp(ERR);