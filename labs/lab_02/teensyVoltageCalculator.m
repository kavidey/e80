function [Vout, uncertainty] = teensyVoltageCalculator(z1, z2)
w = 100*2*pi; % signal input frequency
Vin = 1; % peak-to-peak voltage amplitude
ez1 = 0.05*z1; % uncertainty in z1
ez2 = 0.05*z2; % uncertainty in z2
eVout = 3.3/1024;

mat = @(Z1, Z2) [(Z2*(3e3+1e8/(j*w))+(50+Z1)*(3e3+1e8/(j*w))+(50+Z1)*Z2) 0
    (1-(3e3/(3e3+1e8/(j*w)))) -1 ];
B = @(Z2) [Vin*Z2*(3e3+1e8/(j*w)) 0]';


% A = [(Z2*(2e3+1e8/(j*w))+(50+Z1)*(2e3+1e8/(j*w))+(50+Z1)*Z2) 0
    % (1-(2e3/(2e3+1e8/(j*w)))) -1 ];
% b = [Vin*Z2*(2e3+1e8/(j*w)) 0]';
A = mat(z1, z2);
b = B(z2);
voltages = A\b;
Voutpp = abs(voltages(2));
Vout = Voutpp /(2*sqrt(2))
% error calculation .. the miracles of modern technology :)
syms Z1 Z2;
matrix = mat(Z1, Z2);
Areduced = matrix \ b;
eqn = (Areduced(2));
Dz1 = diff(eqn, Z1);
Dz2 = diff(eqn, Z2);
Z1 = z1;
Z2 = z2;
Dz1 = abs(subs(Dz1));
Dz2 = abs(subs(Dz2));
contribution1 = ez1*Dz1;
contribution2 = ez2*Dz2;
uncertainty = sqrt(eVout^2 + contribution1^2 + contribution2^2);
uncertainty = double(uncertainty)
%Vout2 = ((1e8/(j*w)/(2e3+(1e8/j*w)))*(Z2*(2e3+1e8)/(j*w))/(Z2*(50+Z1)+(50+Z1)*(2e3+1e8/(j*w))+Z2*(2e3+1e8/(j*w))));
%Vout2 = abs(Vout2)/sqrt(2);

end


