temps = [273.15 293.15]; % temp in  kelvin
R =[163000 59000]; % predicted resistances

R0 = 47000; % from datasheet
T0 = 293.15; % reference temp is 25C, negligible uncertainty
B = 4050; % in Kelvin, from 25 to 50 C
dR0 = 470; % uncertainty is 1% of R0
dB = 40.5; % uncertainty is 1% of B
dR = 0.01*R; % uncertainty is ~1% of R

syms r r0 b;
T = @(r, r0, b) ((log(r./r0)/b)+1/T0).^(-1);
% find partial derivatives
diffR = diff(T, r);
diffR0 = diff(T, r0);
diffb = diff(T, b);
% sub in variables
r = R;
r0 = R0;
b = B;
diffR = subs(diffR);
diffR0 = abs(subs(diffR0));
diffb = abs(subs(diffb));
uncertainty = sqrt((diffR.*dR).^2 + (diffR0*R0).^2 + (diffb*B).^2);
uncertainty = double(uncertainty);
output = T(R, R0, B)

