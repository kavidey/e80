[accelX,accelY,accelZ,magX,magY,magZ] = read_data('uncalibrated', 'data');
[accelX,accelY,accelZ,cmagX,cmagY,cmagZ] = read_data('calibrated', 'data');

dt = 0.1; %[s]; % The sampling rate
t1 = (0:length(magX)-1)*dt; % The time array
t2 = (0:length(cmagX)-1)*dt; % The time array

clf
subplot(2, 1, 1)
hold on
scatter(magX, magY, 'red','filled', "DisplayName", "Uncalibrated");
scatter(cmagX, cmagY, 'k','filled', "DisplayName", "Calibrated");
xlabel("X Magnetic Flux [mGauss]")
ylabel("Y Magnetic Flux [mGauss]")
title("X vs Y Magnetometer Readings")
legend()
hold off

subplot(2, 1, 2)
hold on
plot(t2, atan2(cmagY, cmagX), "DisplayName", "Calibrated")
plot(t1, atan2(magY, magX), "DisplayName", "Uncalibrated")
title("Heading vs. Time")
xlabel("Time [s]")
ylabel("Heading [rad]")
legend()
hold off