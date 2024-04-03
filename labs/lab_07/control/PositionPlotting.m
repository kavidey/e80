clf
clc
clear

figure(1)
map = imread("campusmap.png");
map = flip(map);
imgdim = size(map);
xdim = imgdim(1);
ydim = imgdim(2);
realx = 260 % real map width, in meters, approximated using google maps
realy = 160 % real map height, in meters, approximated using google maps
imgScale = mean([realx/xdim, realy/ydim]);
map = imresize(map, imgScale);

% based on plot_open_loop_run.m, by Kavi Dey (kdey@hmc.edu) 1/26/24
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC,Button] = read_data('trial1', 'data');
X = x;
Y = y;
startSampleNo = 1500;
stopSampleNo = length(x);
xScaleFactor = 1;
xShift = 80; % origin is ~60m east of plot origin
yScaleFactor = 1;
yShift = 120; % origin is ~110m north of plot origin

waypointsx = [125 150 125];
waypointsy = [-40 -40 -40];

set(gcf, 'color', [1 1 1]);  

hold on
image(map)
plot(X(startSampleNo:stopSampleNo)*xScaleFactor+xShift, Y(startSampleNo:stopSampleNo)*yScaleFactor+yShift, 'LineWidth', 2.5, 'Color', 'red', 'DisplayName', 'Path');
plot(waypointsx*xScaleFactor+xShift, waypointsy*yScaleFactor+yShift, '-o', 'Color', 'black', 'DisplayName', 'Waypoints');
legend()
% h = legend('X', 'Y');
% set(h, 'Location', 'best');
xlabel('X position (m)');
ylabel('Y positionon (m)');
title('Path traveled over Harvey Mudd Campus');
fontsize(16,"points")
hold off

figure(2)
dt = 0.1; %[s]; % The sampling rate
t = (0:length(magX)-1)*dt; % The time array
set(gcf, 'color', [1 1 1]);
subplot(2, 1, 1);
yaw_err = yaw_des-yaw
plot(t(startSampleNo:stopSampleNo), yaw_err(startSampleNo:stopSampleNo));
xlabel("Time [s]")
ylabel("Angle Error [rad]")
title("Angle Error over time")

subplot(2, 1, 2);
plot(t(startSampleNo:stopSampleNo), u(startSampleNo:stopSampleNo));
xlabel("Time [s]")
ylabel("Control Effort")
title("Control Effort over time")