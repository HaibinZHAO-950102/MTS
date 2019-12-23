function Sensor = sensorposition(B,n)
% B is the length of the workspace
% n is the number of sensors on each edge
N = n * n;
Sensor = zeros(3,N);

for i = 0 : N-1
    a = mod(i,n);
    b = (i - a) / n;
    Sensor(2,i+1) = a * B/(n-1) - B/2;
    Sensor(1,i+1) = - b * B/(n-1) + B/2;
end
