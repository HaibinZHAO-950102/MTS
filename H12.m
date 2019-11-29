function S = H12(varargin)
if length(varargin) == 5
    n = 100;
else
    n = varargin{6};
end
y = varargin{1};
z = varargin{2};
m = varargin{3};
Ra = varargin{4};
L = varargin{5};

dr = Ra/n;
dt = 2*pi/100;

sum = 0;
for r = 0 : dr : Ra
    for theta = 0 : dt :2*pi
        sum = sum + (y-r*sin(theta))/((r*cos(theta))^2+(y-r*sin(theta))^2+(z-L/2)^2)^(3/2)*r*dr*dt;
    end
end
S = sum*m/4/pi;