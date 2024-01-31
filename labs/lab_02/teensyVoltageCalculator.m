function Vout = teensyVoltageCalculator(Z1, Z2)
w = 100*2*pi; % signal input frequency
Vin = 1;
A = [(Z2*(2e3+1e8/(j*w))+(50+Z1)*(2e3+1e8/(j*w))+(50+Z1)*Z2) 0
    (1-(2e3/(2e3+1e8/(j*w)))) -1 ];
b = [Vin*Z2*(2e3+1e8/(j*w)) 0]';
voltages = A\b;
Voutpp = abs(voltages(2));
Vout = Voutpp /(2*sqrt(2))

%Vout2 = ((1e8/(j*w)/(2e3+(1e8/j*w)))*(Z2*(2e3+1e8)/(j*w))/(Z2*(50+Z1)+(50+Z1)*(2e3+1e8/(j*w))+Z2*(2e3+1e8/(j*w))));
%Vout2 = abs(Vout2)/sqrt(2);
end
