%% Solve for the actual resistances using datasheet provided values
T0 = 25 + 273.15; % K
R0 = 47 * 10^3; % ohms

temps = [50 80 100 85] + 273.15; % K
B = [4050 4101 4131 4108]; % K

R = R0 * exp(B .* (1./temps - 1/T0));

%% Use known resistances & temperatures to find A, B, C'
% https://en.wikipedia.org/wiki/Steinhart%E2%80%93Hart_equation
L = log(R);
Y = 1 ./ temps;
gamma2 = (Y(2) - Y(1)) / (L(2) - L(1));
gamma3 = (Y(3) - Y(1)) / (L(3) - L(1));

C = ((gamma3-gamma2)/(L(3)-L(2))) * 1/sum(L);
B = gamma2 - C * (L(1)^2 + L(1)*L(2) + L(2)^2);
A = Y(1) - (B+L(1)^2*C) * L(1);

A
B
C

% A = 0.9150335910e-03;
% B = 2.147547850e-04;
% C = 1.037372246e-07;