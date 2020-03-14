function S = H13(varargin)
if length(varargin) == 5
    n = 100;
else
    n = varargin{6};
end
y = varargin{1};
z = varargin{2};
magnetization = varargin{3};
Magnet_radius = varargin{4};
Magnet_altitude = varargin{5};


dr = Magnet_radius/n;
dt = 2*pi/100;

sum = 0;
for r = 0 : dr : Magnet_radius
    for theta = 0 : dt :2*pi
        sum = sum + (z-Magnet_altitude/2)/((r*cos(theta))^2+(y-r*sin(theta))^2+(z-Magnet_altitude/2)^2)^(3/2)*r*dr*dt;
    end
end
S = sum*magnetization/4/pi;