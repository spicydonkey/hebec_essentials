% Convert 3D rotation matrix to Euler angles
%   source: http://nghiaho.com/?page_id=846

function eul_angle=rotm2euler(R)
    % eul_angle: 1x3 array
    %   alpha in    (-pi,pi)
    %   beta in     (-pi/2,pi/2)
    %   gamma in    (-pi,pi)

    % Decompose rotation matrix 
    alpha=atan2(R(3,2),R(3,3));
    beta=atan2(-R(3,1),sqrt(R(3,2)^2+R(3,3)^2));
    gamma=atan2(R(2,1),R(1,1));
    
    eul_angle=[alpha,beta,gamma];
end