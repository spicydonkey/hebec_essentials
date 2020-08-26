% test rotation matrix
v = [0,0,1]';

u_torque = [1,0,0]';

nn = 100;
theta = linspace(0,pi,nn);

V = NaN(3,nn);
for ii = 1:nn
    tR = rot3m(u_torque,theta(ii));
    tV = tR*v;
    V(:,ii) = tV;
end

%%% rot3theta
Vth = rot3theta(u_torque,v,theta);

% plot
figure;
l = line(V(1,:),V(2,:),V(3,:));
l.Color = 'b';

hold on;
l2 = line(Vth(1,:),Vth(2,:),Vth(3,:));
l2.Color = 'r';
l2.LineStyle = '--';

xlabel('x');
ylabel('y');
zlabel('z');
view(3);
axis equal;