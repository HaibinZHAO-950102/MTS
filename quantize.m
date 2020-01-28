function Bb = quantize(Vn, k, Sensordata)
Vq = 5/2^k*floor(Vn*2^k/5);    
Bb = (Vq-Sensordata(2))/Sensordata(4);