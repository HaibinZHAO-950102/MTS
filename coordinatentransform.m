function [rcs thetak] = coordinatentransform(Orientation,Sensor)
% rcs[1,:] is the Coordinates of the Sensors in Magentcoordinaten
% Orientation is the position and rotation of the magnet, c1,c2,c3,theta1,theta2
% Sensor is the Position of Sensors 
% rcs[2,:] is the Coordinaten of Vergleichspunkt

c1 = Orientation(1);
c2 = Orientation(2);
c3 = Orientation(3);
theta1 = Orientation(4);
theta2 = Orientation(5);

s1 = Sensor(1);
s2 = Sensor(2);

rcs(1,1) = (-c1+s1)*cos(theta2) + (-c2+s2)*sin(theta1)*sin(theta2) + c3*cos(theta1)*sin(theta2);
rcs(1,2) = (-c2+s2)*cos(theta1) - c3*sin(theta1);
rcs(1,3) = (-c1+s1)*sin(theta2) - (-c2+s2)*sin(theta1)*cos(theta2) - c3*cos(theta1)*cos(theta2);

   
if rcs(1,2) < 0
    if rcs(1,1) < 0
        thetak = - atan(rcs(1,1)/rcs(1,2)) + pi;
    else
        thetak = - atan(rcs(1,1)/rcs(1,2)) - pi;
    end
else
    thetak = - atan(rcs(1,1)/rcs(1,2));
end


rcs(2,1) = 0;
rcs(2,2) = -rcs(1,1)*sin(thetak) + rcs(1,2)*cos(thetak);
rcs(2,3) = rcs(1,3);

if rcs(1,1) == 0 & rcs(1,2) == 0
    thetak = 0;
    rcs(2,2) = 0;
end
