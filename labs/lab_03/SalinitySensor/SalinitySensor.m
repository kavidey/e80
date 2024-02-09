vppin = [0.57 0.56 0.48 0.56 0.54 0.48 0.56 0.56 0.46];
vppout = [7.8 8.3 9.2 7.8 8.3 9.4 7.9 8.4 9.4];
salinity = [1 3 5 1 3 5 1 3 5];

ratio = vppin./vppout

scatter(salinity, ratio)
set(gca,'xscale','log')
set(gca,'yscale','log')
xlabel('Salinity [% Salt by Weight]')
ylabel('Gain')
title('Salinity vs. Gain')