function [HxS HyS HzS] = inversetransform(theta1,theta2,thetak,HyV,HzV)
HxS = -HyV*sin(thetak)*cos(theta2) + HzV*sin(theta2);
HyS = -HyV*sin(thetak)*sin(theta1)*sin(theta2)+HyV*cos(thetak)*cos(theta1) - HzV*sin(theta1)*cos(theta2);
HzS = HyV*sin(thetak)*cos(theta1)*sin(theta2)+HyV*cos(thetak)*sin(theta1) + HzV*cos(theta1)*cos(theta2);