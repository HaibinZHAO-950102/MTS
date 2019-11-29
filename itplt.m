function [HyV,HzV] = itplt(x,y,q2,q3,Hy,Hz,H,B,n)


Vy1 = floor(x/B*n+1);
Vz1 = floor((y+H/2)/H*2*n+1);
Vy2 = Vy1 + 1;
Vz2 = Vz1 + 1;

x1 = q2(Vy1);
x2 = q2(Vy2);
y1 = q3(Vz1);
y2 = q3(Vz2);
f11 = Hy(Vy1,Vz1);
f12 = Hy(Vy1,Vz2);
f21 = Hy(Vy2,Vz1);
f22 = Hy(Vy2,Vz2);
g11 = Hz(Vy1,Vz1);
g12 = Hz(Vy1,Vz2);
g21 = Hz(Vy2,Vz1);
g22 = Hz(Vy2,Vz2);

HyV = 1/(x2-x1)/(y2-y1) * [x2-x,x-x1] * [f11,f12;f21,f22] * [y2-y,y-y1]';
HzV = 1/(x2-x1)/(y2-y1) * [x2-x,x-x1] * [g11,g12;g21,g22] * [y2-y,y-y1]';