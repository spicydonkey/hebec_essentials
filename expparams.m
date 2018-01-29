function s = expparams()
%Experimental parameters relevant to ANU He* BEC lab
%
%

g=9.81;     % acceleration due to gravity (m/s^2)

s.d_dld=0.8488;             % distance between DLD and trap (m)
s.tof=sqrt(2*s.d_dld/g);	% 0.416: free-fall tof from trap to DLD (s)
s.vz=s.tof*g;               % 4.08: vertical velocity at DLD (m/s)

s.th_dld=0.61;              % detector-trap misalignment (rad)

end