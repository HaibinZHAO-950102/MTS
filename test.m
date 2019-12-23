clc
clear
% 
% 
% Ra1 = 0.009;     % Radius of the Magnet in Meter m
% L1 = 0.005;      % Altitude of the Magnet in Meter m
% Ra2 = 0.0075/2;     % Radius of the Magnet in Meter m
% L2 = 0.0020;      % Altitude of the Magnet in Meter m
% 
% 
% 
% 
% Br = 1.48;      % Magnetic Remanenz in T
% n = 200;        % Number of the Nodes
% B = 0.15;
% H = 2 * B;      % Width and Length of the calculated area
% mu0 = 4*pi*10^-7;
% 
% [Hy1,Hz1,q2,q3] = Magnetfield(Ra1,L1,Br,B,H,n);
% Hm1 = sqrt(Hy1.^2+Hz1.^2);
% 
% By1 = Hy1 * mu0 * 10000;
% Bz1 = Hz1 * mu0 * 10000;
% Bm1 = Hm1 * mu0 * 10000;
% 
% [Hy2,Hz2,q2,q3] = Magnetfield(Ra2,L2,Br,B,H,n);
% Hm2 = sqrt(Hy2.^2+Hz2.^2);
% 
% By2 = Hy2 * mu0 * 10000;
% Bz2 = Hz2 * mu0 * 10000;
% Bm2 = Hm2 * mu0 * 10000;


