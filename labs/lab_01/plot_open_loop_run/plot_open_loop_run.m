[accelX, accelY, accelZ] = read_data('run', 'data');

startSampleNo = 300;
stopSampleNo = 540;
teensyAccelerationUnits = 0.0102;

fh = figure;
set(fh, 'color', [1 1 1]);  

subplot(3, 1, 1);
plot(accelX(startSampleNo:stopSampleNo)*teensyAccelerationUnits);
title('X Acceleration');
xlabel('Time (Sample No.)') 
ylabel('Acceleration (m/s^2)') 

subplot(3, 1, 2);
plot(accelY(startSampleNo:stopSampleNo)*teensyAccelerationUnits);
title('Y Acceleration');
xlabel('Time (Sample No.)') 
ylabel('Acceleration (m/s^2)') 

subplot(3, 1, 3);
plot(accelZ(startSampleNo:stopSampleNo)*teensyAccelerationUnits);
title('Z Acceleration');
xlabel('Time (Sample No.)') 
ylabel('Acceleration (m/s^2)') 

print -dpng -r300 accel.png
