% Convert Euler angle to rotation matrix
% Axis rotation sequence is in the conventional XYZ order
%   source: http://nghiaho.com/?page_id=846

function R=euler2rotm(euler_angle)
    % euler_angle (TAIT-BRYAN angle): 1x3 array [alpha,beta,gamma]
    %   alpha   (-pi/pi)
    %   beta    (-pi/2,pi/2)
    %   gamma   (-pi,pi)
    
    alpha=euler_angle(1);
    beta=euler_angle(2);
    gamma=euler_angle(3);
    
    % compose the 3D extrinsic rotation matrix
    Rx=[1 0 0; 0 cos(alpha) -sin(alpha); 0 sin(alpha) cos(alpha)];
    Ry=[cos(beta) 0 sin(beta); 0 1 0; -sin(beta) 0 cos(beta)];
    Rz=[cos(gamma) -sin(gamma) 0; sin(gamma) cos(gamma) 0; 0 0 1];
    
    R=Rz*Ry*Rx;         % the total rotation matrix
end