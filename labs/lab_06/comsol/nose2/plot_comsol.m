data = table2array(readtable("nose2_data.txt"));
% data = renamevars(data, ["Var1", "Var2", "Var3", "Var4"], ["Wind Speed [m/s]", "Reynolds Number", "Drag [N]", "Drag Coefficient"]);

rho = 1.115; % density of air at room temp
nu = 1.46*10^5; % kinematic viscocity of air at room temp
coneArea =  0.00196; % [m] all cones have same frontal area
coneL = 50 * 1e-3; % [m] characteristic length of cone is 50mm diameter

dragForce = data(:, 3);
windSpeed = data(:, 1);
reynoldsNumber = data(:,1) .* robotL ./ nu;
dragCoefficient = dragForce ./ (0.5 .* rho .* windSpeed .^ 2 .* robotArea);

subplot(2,1,1);
plot(reynoldsNumber, dragForce);,
xlabel("Reynolds Number")
ylabel("Drag Force [N]")
title("Nose Cone 2: Reynolds Number vs. Drag Force")

subplot(2,1,2);
plot(reynoldsNumber, dragCoefficient);
xlabel("Reynolds Number")
ylabel("Drag Coefficient")
title("Nose Cone 2: Reynolds Number vs. Drag Coefficient")

set(gcf, "Color", "w")