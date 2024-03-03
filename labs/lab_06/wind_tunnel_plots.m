%% Setup
load calibration.mat

rho = 1.195; % [kg/m^3] density of air at room temp
nu = 15.27*10^-6; % kinematic viscocity of air at room temp

reynoldsNumber = @(v, l, nu) v.*l./nu;
dragCoefficient = @(drag, rho, v, frontalArea) drag./(0.5.*rho.*v.^2.*frontalArea);

coneArea =  pi*(25*1e-3)^2; % [m] all cones have same frontal area
coneL = 50 * 1e-3; % [m] characteristic length of cone is 50mm diameter
robotL = 0.0931; % [m] characteristic length of robot
robotArea = 0.00164; % [m^2] characteristic area of robot

nose1_v = rpm2v([0 435 651 840 994 1159 1299 1517 1671 1871]);
nose1_drag = kgf2N([-1.247 -1.252 -1.258 -1.265 -1.273 -1.283 -1.292 -1.310 -1.324 -1.343])*-1;
nose1_lift = kgf2N([0.424 0.412 0.418 0.414 0.398 0.380 0.358 0.370 0.360 0.340]);
fprintf("Zero Lift %g, Zero Drag %g\n", nose1_lift(1), nose1_drag(1))
nose1_drag = nose1_drag - nose1_drag(1);
% nose1_v = nose1_v(2:end);
% nose1_drag = nose1_drag(2:end);
nose1_reynolds = reynoldsNumber(nose1_v, coneL, nu);
nose1_dragC = dragCoefficient(nose1_drag, rho, nose1_v, coneArea);

nose2_v = rpm2v([0 430 701 840 1004 1186 1360 1532 1705 1909]);
nose2_drag = kgf2N([-1.247 -1.250 -1.252 -1.255 -1.258 -1.261 -1.267 -1.271 -1.277 -1.285])*-1;
nose2_lift = kgf2N([0.448 0.444 0.440 0.437 0.422 0.405 0.405 0.390 0.390 0.370]);
fprintf("Zero Lift %g, Zero Drag %g\n", nose2_lift(1), nose2_drag(1))
nose2_drag = nose2_drag - nose2_drag(1);
% nose2_v = nose2_v(2:end);
% nose2_drag = nose2_drag(2:end);
nose2_reynolds = reynoldsNumber(nose2_v, coneL, nu);
nose2_dragC = dragCoefficient(nose2_drag, rho, nose2_v, coneArea);

nose3_v = rpm2v([0 497 666 839 1012 1160 1350 1520 1736 1917]);
nose3_drag = kgf2N([-1.248 -1.250 -1.252 -1.255 -1.259 -1.259 -1.268 -1.272 -1.281 -1.288])*-1;
nose3_lift = kgf2N([0.449 0.445 0.442 0.439 0.421 0.410 0.405 0.395 0.380 0.350]);
fprintf("Zero Lift %g, Zero Drag %g\n", nose3_lift(1), nose3_drag(1))
nose3_drag = nose3_drag - nose3_drag(1);
% nose3_v = nose3_v(2:end);
% nose3_drag = nose3_drag(2:end);
nose3_reynolds = reynoldsNumber(nose3_v, coneL, nu);
nose3_dragC = dragCoefficient(nose3_drag, rho, nose3_v, coneArea);

% robot
robot_v = rpm2v([0 556 710 870 1010 1219 1357 1586 1757 1953]);
robot_drag = kgf2N([-1.245 -1.252 -1.257 -1.263 -1.270 -1.282 -1.291 -1.309 -1.324 -1.340])*-1;
robot_lift = kgf2N([0.765 0.765 0.766 0.767 0.767 0.768 0.770 0.777 0.780 0.790]);
fprintf("Zero Lift %g, Zero Drag %g\n", robot_lift(1), robot_drag(1))
robot_drag = robot_drag - robot_drag(1);
% robot_v = robot_v(2:end);
% robot_drag = robot_drag(2:end);
robot_reynolds = reynoldsNumber(robot_v, robotL, nu);
robot_dragC = dragCoefficient(robot_drag, rho, robot_v, robotArea);

%% Plotting
figure(1)
clf
set(groot,'defaultLineLineWidth',1.5)

% nose 1 plotting
subplot(4, 2, 1)
plot(nose1_reynolds, nose1_drag)
xlabel("Reynold's Number")
ylabel("Drag [N]")
title("Drag vs Reynold's Number for Nose #1")

subplot(4, 2, 2)
plot(nose1_reynolds, nose1_dragC)
xlabel("Reynold's Number")
ylabel("Drag Coefficient")
title("Drag Coefficient vs Reynold's Number for Nose #1")

% nose 2 plotting
subplot(4, 2, 3)
plot(nose2_reynolds, nose2_drag)
xlabel("Reynold's Number")
ylabel("Drag [N]")
title("Drag vs Reynold's Number for Nose #2")

subplot(4, 2, 4)
plot(nose2_reynolds, nose2_dragC)
xlabel("Reynold's Number")
ylabel("Drag Coefficient")
title("Drag Coefficient vs Reynold's Number for Nose #2")

% nose 3 plotting
subplot(4, 2, 5)
plot(nose3_reynolds, nose3_drag)
xlabel("Reynold's Number")
ylabel("Drag [N]")
title("Drag vs Reynold's Number for Nose #3")

subplot(4, 2, 6)
plot(nose3_reynolds, nose3_dragC)
xlabel("Reynold's Number")
ylabel("Drag Coefficient")
title("Drag Coefficient vs Reynold's Number for Nose #3")

% robot plotting
subplot(4, 2, 7)
plot(robot_reynolds, robot_drag)
xlabel("Reynold's Number")
ylabel("Drag [N]")
title("Drag vs Reynold's Number for Robot Scale Model)")

subplot(4, 2, 8)
plot(robot_reynolds, robot_dragC)
xlabel("Reynold's Number")
ylabel("Drag Coefficient")
title("Drag Coefficient vs Reynold's Number for Robot Scale Model")

set(gcf, "Color", "w");