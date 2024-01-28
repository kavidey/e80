% plot_open_loop_run.m
% Kavi Dey (kdey@hmc.edu)
% 1/26/24

[accelX,accelY,accelZ,magX,magY,magZ,headingIMU,pitchIMU,rollIMU,motorA,motorB,motorC] = read_data('run', 'data');

startSampleNo = 335;
stopSampleNo = 475;
teensyAccelerationUnits = 0.0102;

fh = figure;
set(fh, 'color', [1 1 1]);  

hold on
x = (1:length(accelX))'*0.1;
x = x(startSampleNo:stopSampleNo);
plot(x, accelX(startSampleNo:stopSampleNo)*teensyAccelerationUnits, 'LineWidth', 1.5);
plot(x, accelY(startSampleNo:stopSampleNo)*teensyAccelerationUnits, 'LineWidth', 1.5);
plot(x, accelZ(startSampleNo:stopSampleNo)*teensyAccelerationUnits, 'LineWidth', 1.5);

h = legend('X', 'Y', 'Z');
set(h, 'Location', 'best');
xlabel('Time [s]');
ylabel('Acceleration [m/s^2]');
title('Open Loop Obstacle Course Acceleration');
fontsize(16,"points")
hold off

print -dpng -r300 accel.png
