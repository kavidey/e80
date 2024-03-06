data = table2array(readtable("data.txt"));
% data = renamevars(data, ["Var1", "Var2", "Var3", "Var4"], ["Wind Speed [m/s]", "Reynolds Number", "Drag [N]", "Drag Coefficient"]);

rho = 998.2; % [kg/m^3] density of air at room temp
nu = 1.0023e-6; % [m^2/s] kinematic viscocity of air at 20 C
robotArea = 0.01476; % [m^2] all cones have same frontal area
robotL = 0.0931*3; % [m] characteristic length of cone is 50mm diameter

dragForce = data(:, 3);
windSpeed = data(:, 1);
reynoldsNumber = data(:,1) .* robotL ./ nu;
dragCoefficient = dragForce ./ (0.5 .* rho .* windSpeed .^ 2 .* robotArea);

subplot(2,1,1);
plot(reynoldsNumber, dragForce);
xlabel("Reynolds Number")
ylabel("Drag Force [N]")
title("Full Scale Robot: Reynolds Number vs. Drag Force")

subplot(2,1,2);
plot(reynoldsNumber, dragCoefficient);
xlabel("Reynolds Number")
ylabel("Drag Coefficient")
title("Full Scale Robot: Reynolds Number vs. Drag Coefficient")

set(gcf, "Color", "w")