%%
addpath(genpath("../code"))

teensy_conversion = 3.3/2^10;
lat_origin = 33.462663;
lon_origin = -117.704884;
%% run 1 (contains files 000-014) in general temp and gps are only working sensors
% 000-001 has nothing
% 002 has a long deployment
% 003 super short deployment
% 004 medium deployment
% 005 medium deployment
% 006 super short deployment, data looks kinda weird
% 007 nothing
% 008 nothing
% 009 super short deployment
% 010-013 temp is high, out of water?
% 014 really good long deployment

% overall notes: 014 is best, 002-005 may have additional good data
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_014', 'Dana Point/run 1');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
hold on
plot(time, VtoT(temp_voltage));
plot(time, smoothdata(VtoT(temp_voltage) ,"rloess", 200));
ylim([0 25])
yline(16.1)
ylabel("Temperature [C]")
xlabel("Time [s]")
hold off

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 1/salinity_014", 3, 16);
hold on
plot(salinity_time, salinity)
plot(salinity_time, smoothdata(salinity ,"rloess", 200))
yline(33)
ylim([0, 60])
ylabel("Salinity [ppt]")
xlabel("Time [s]")
hold off

%% run 2 (contains 016) only temp
% still only temp working, but measuring several degrees too high - ignore (seems like robot never went in water?)
% [rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_016', 'Dana Point/run 2');
% time = double(A14) * 1e-3;
% temp_voltage = double(A00) * teensy_conversion;

% tiledlayout("vertical")
% nexttile
% geoplot(lat(lat ~= 0), lon(lat ~= 0));
% geobasemap satellite

% nexttile
% plot(time, VtoT(temp_voltage));
% ylim([0 25])

%% run 3 (contains 018) only temp
% gps got really messed up, but temperature data looks super good, nice long deployment
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_018', 'Dana Point/run 3');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
hold on
plot(time, VtoT(temp_voltage));
plot(time, smoothdata(VtoT(temp_voltage) ,"rloess", 200));
ylim([0 25])
yline(16.1)
ylabel("Temperature [C]")
xlabel("Time [s]")
hold off

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 3/salinity_018", 4, 16);
hold on
plot(salinity_time, salinity)
plot(salinity_time, smoothdata(salinity ,"rloess", 200))
yline(33)
ylim([0, 60])
ylabel("Salinity [ppt]")
xlabel("Time [s]")
hold off
%% run 4 (contains 022) only temp
% temp and gps both look pretty good!!
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_022', 'Dana Point/run 4');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
hold on
plot(time, VtoT(temp_voltage));
plot(time, smoothdata(VtoT(temp_voltage) ,"rloess", 200));
ylim([0 25])
yline(16.1)
ylabel("Temperature [C]")
xlabel("Time [s]")
hold off

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 4/salinity_022", 4, 16);
hold on
plot(salinity_time, salinity)
plot(salinity_time, smoothdata(salinity ,"rloess", 200))
yline(33)
ylim([0, 60])
ylabel("Salinity [ppt]")
xlabel("Time [s]")
hold off
%% run 5 (contains 029) temp and salinity, gps is rlly messed up
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_029', 'Dana Point/run 5');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
hold on
plot(time, VtoT(temp_voltage));
plot(time, smoothdata(VtoT(temp_voltage) ,"rloess", 200));
ylim([0 25])
yline(16.1)
ylabel("Temperature [C]")
xlabel("Time [s]")
hold off

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 5/salinity_029", 4, 16);
hold on
plot(salinity_time, salinity)
plot(salinity_time, smoothdata(salinity ,"rloess", 200))
yline(33)
ylim([0, 60])
ylabel("Salinity [ppt]")
xlabel("Time [s]")
hold off
%% run 6 (contains 030) sonar only, gps is really messed up
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_030', 'Dana Point/run 6');
time = double(A14) * 1e-3;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0), 'LineWidth', 2);
geobasemap satellite

nexttile
[dist, dist_time] = process_sonar("Dana Point/run 6/sonar_030", 90);
scatter(dist_time, -dist);

nexttile
[x, y] = process_gps(lat(lat ~= 0), lon(lat ~= 0), lat_origin, lon_origin);
xsp = spline(time(lat ~= 0), x);
ysp = spline(time(lat ~= 0), y);
zsp = spline(dist_time, dist);
t = linspace(0, max(time), length(time));
plot3(ppval(xsp, t), ppval(ysp, t), -ppval(zsp, t));
xlabel("X Position [m]")
ylabel("Y Position [m]")
zlabel("Depth [m]")
axis tight
zlim([-1.5 0.5])
pbaspect([10 10 6])
%% run 7 (contains 033) sonar only, looks a bit wonky
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_033', 'Dana Point/run 7');
time = double(A14) * 1e-3;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0), 'LineWidth', 2);
geobasemap satellite

nexttile
[dist, dist_time] = process_sonar("Dana Point/run 7/sonar_033", 90);
scatter(dist_time, -dist);

nexttile
[x, y] = process_gps(lat(lat ~= 0), lon(lat ~= 0), lat_origin, lon_origin);
xsp = spline(time(lat ~= 0), x);
ysp = spline(time(lat ~= 0), y);
zsp = spline(dist_time, dist);
t = linspace(0, max(time), length(time));
plot3(ppval(xsp, t), ppval(ysp, t), ppval(zsp, t));
xlabel("X Position [m]")
ylabel("Y Position [m]")
zlabel("Depth [m]")
axis tight
zlim([0,1.5])
pbaspect([10 10 6])
%% runs 8-9 (contains 034-039) sonar only
% 034 nothing
% 035 should have something because file is reasonably large and gps looks good, but sonar doesn't show anything (more investigation needed?)
% 036-038 nothing
% 039 having some trouble with processing sonar but looks like it will be REALLY good
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_039', 'Dana Point/run 8-9');
time = double(A14) * 1e-3;

tiledlayout("vertical")
nexttile
geoplot(lat(lat > 1), lon(lat > 1), 'LineWidth', 2);
geobasemap satellite

nexttile
[dist, dist_time] = process_sonar("Dana Point/run 8-9/sonar_039", 90);
scatter(dist_time, -dist);

nexttile
[x, y] = process_gps(lat(lat ~= 0), lon(lat ~= 0), lat_origin, lon_origin);
xsp = spline(time(lat ~= 0), x);
ysp = spline(time(lat ~= 0), y);
zsp = spline(dist_time, dist);
t = linspace(0, max(time), length(time));
plot3(ppval(xsp, t), ppval(ysp, t), ppval(zsp, t));
xlabel("X Position [m]")
ylabel("Y Position [m]")
zlabel("Depth [m]")
axis tight
zlim([0,1.5])
pbaspect([10 10 6])
%% run 10 (contains 000-010, note that salinity+sonar are one number ahead) temp and salinity
% 009-000 (010-000) nothing
% 010 (011) super long run with kayak, temp railed out, salinity working, gps might be messed up
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_010', 'Dana Point/run 10');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
hold on
plot(time, VtoT(temp_voltage));
plot(time, smoothdata(VtoT(temp_voltage) ,"rloess", 200));
ylim([0 25])
yline(16.1)
ylabel("Temperature [C]")
xlabel("Time [s]")
hold off

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 10/salinity_011", 4, 16);
hold on
plot(salinity_time, salinity)
plot(salinity_time, smoothdata(salinity ,"rloess", 200))
yline(33)
ylim([0, 60])
ylabel("Salinity [ppt]")
xlabel("Time [s]")
hold off
%% run 11 (contains 011, note that salinity+sonar are one number ahead) temp and salinity, tested at dock area
% definitely something weird happening with temperature
% possibly an issue with salinity too
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_011', 'Dana Point/run 11');
time = double(A14) * 1e-3;
temp_voltage = double(A00) * teensy_conversion;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0));
geobasemap satellite

nexttile
plot(time, VtoT(temp_voltage));
ylim([0 25])

nexttile
[salinity, salinity_time] = process_salinity("Dana Point/run 11/salinity_012", 4, 16.4);
hold on
plot(salinity_time, salinity)
% plot(salinity_time, smoothdata(salinity ,"rloess", 200))
yline(33)
ylim([0, 60])
ylabel("Salinity [ppt]")
xlabel("Time [s]")
hold off
%% run 12 (contains 012, note that salinity+sonar are one number ahead) sonar only
% sonar didn't work, as expected because its to deep
% [rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_012', 'Dana Point/run 12');
% time = double(A14) * 1e-3;

% tiledlayout("vertical")
% nexttile
% geoplot(lat(lat ~= 0), lon(lat ~= 0), 'LineWidth', 2);
% geobasemap satellite

% nexttile
% [dist, dist_time] = process_sonar("Dana Point/run 12/sonar_013", 90);
% plot(dist_time, -dist);

%% run 13 (contains 013-017, note that salinity+sonar are one number ahead) sonar only
% 017 is the only valid one
% there should be some sonar results, but will require tuning algorithm, nothing atm
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_017', 'Dana Point/run 13');
time = double(A14) * 1e-3;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0), 'LineWidth', 2);
geobasemap satellite

nexttile
[dist, dist_time] = process_sonar("Dana Point/run 13/sonar_018", 90);
scatter(dist_time, -dist);

nexttile
[x, y] = process_gps(lat(lat ~= 0), lon(lat ~= 0), lat_origin, lon_origin);
xsp = spline(time(lat ~= 0), x);
ysp = spline(time(lat ~= 0), y);
zsp = spline(dist_time, dist);
t = linspace(0, max(time), length(time));
plot3(ppval(xsp, t), ppval(ysp, t), ppval(zsp, t));
xlabel("X Position [m]")
ylabel("Y Position [m]")
zlabel("Depth [m]")
axis tight
zlim([0,1.5])
pbaspect([10 10 6])
%% run 14 (contains 018, note that salinity+sonar are one number ahead) sonar only
% sonar needs more tuning for TOF
% need to figure out how to process doppler velocity
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_018', 'Dana Point/run 14');
time = double(A14) * 1e-3;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0), 'LineWidth', 2);
geobasemap satellite

nexttile
[dist, dist_time] = process_sonar("Dana Point/run 14/sonar_019", 45);
scatter(dist_time, -dist);

nexttile
[x, y] = process_gps(lat(lat ~= 0), lon(lat ~= 0), lat_origin, lon_origin);
xsp = spline(time(lat ~= 0), x);
ysp = spline(time(lat ~= 0), y);
zsp = spline(dist_time, dist);
t = linspace(0, max(time), length(time));
plot3(ppval(xsp, t), ppval(ysp, t), ppval(zsp, t));
xlabel("X Position [m]")
ylabel("Y Position [m]")
zlabel("Depth [m]")
axis tight
zlim([0,1.5])
pbaspect([10 10 6])
%% run 15 (contains 025, note that salinity+sonar are one number ahead) sonar only
% sonar needs more tuning for TOF
% need to figure out how to process doppler velocity
% gps looks semi-reasonable??
[rollIMU,pitchIMU,headingIMU,accelX,accelY,accelZ,magX,magY,magZ,lat,lon,nsats,x,y,u,uL,uR,yaw,yaw_des,motorA,motorB,motorC,Current_Sense,A00,A01,A02,A03,A10,A11,A12,A13,A14,A15,A16,A17,A18,A19,A20,ErrorFlagA,ErrorFlagB,ErrorFlagC] = read_data('run_025', 'Dana Point/run 15');
time = double(A14) * 1e-3;

tiledlayout("vertical")
nexttile
geoplot(lat(lat ~= 0), lon(lat ~= 0), 'LineWidth', 2);
geobasemap satellite

nexttile
[dist, dist_time] = process_sonar("Dana Point/run 15/sonar_026", 45);
scatter(dist_time, -dist);

nexttile
[x, y] = process_gps(lat(lat ~= 0), lon(lat ~= 0), lat_origin, lon_origin);
xsp = spline(time(lat ~= 0), x);
ysp = spline(time(lat ~= 0), y);
zsp = spline(dist_time, dist);
t = linspace(0, max(time), length(time));
plot3(ppval(xsp, t), ppval(ysp, t), ppval(zsp, t));
xlabel("X Position [m]")
ylabel("Y Position [m]")
zlabel("Depth [m]")
axis tight
zlim([0,1.5])
pbaspect([10 10 6])