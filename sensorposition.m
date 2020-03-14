function Sensor = sensorposition(Workspace_size,Sensor_number)
N = Sensor_number * Sensor_number;
Sensor = zeros(3,N);

for i = 0 : N-1
    a = mod(i,Sensor_number);
    b = (i - a) / Sensor_number;
    Sensor(2,i+1) = a * Workspace_size/(Sensor_number-1) - Workspace_size/2;
    Sensor(1,i+1) = - b * Workspace_size/(Sensor_number-1) + Workspace_size/2;
end
