data = table2array(readtable("NACA6412_data.txt"));
% data = renamevars(data, ["Var1", "Var2", "Var3", "Var4"], ["Wind Speed [m/s]", "Reynolds Number", "Drag [N]", "Drag Coefficient"]);

rho = 1.115; % density of air at room temp
nu = 1.46*10^5; % kinematic viscocity of air at room temp
frontal_area = 1.2*10*(1e-2)^2; % [m^2]
planform_area = 30*10*(1e-2)^2; % [m^2]
characteristic_length = 100 * 1e-3; % [m] characteristic length of cone is 50mm diameter

dragForce = data(:, 4);
liftForce = data(:, 3);
windSpeed = data(:, 2);
reynoldsNumber = windSpeed .* characteristic_length ./ nu;
dragCoefficient = dragForce ./ (0.5 .* rho .* windSpeed .^ 2 .* frontal_area);
liftCoefficient = liftForce ./ (0.5 .* rho .* windSpeed .^ 2 .* planform_area);

reynolds5 = reynoldsNumber(1:5);
liftC5 = liftCoefficient(1:5);
lift5 = liftForce(1:5);

reynolds15 = reynoldsNumber(6:10);
liftC15 = liftCoefficient(6:10);
lift15 = liftForce(6:10);

reynolds45 = reynoldsNumber(11:15);
liftC45 = liftCoefficient(11:15);
lift45 = liftForce(11:15);

subplot(2,1,1);
hold on
plot(reynolds5, lift5);
plot(reynolds15, lift15);
plot(reynolds45, lift45);
hold off
legend("5 [deg]", "15 [deg]", "45 [deg]")
xlabel("Reynolds Number")
ylabel("lift Force [N]")
title("Full Scale Robot: Reynolds Number vs. Lift Force")

subplot(2,1,2);
hold on
plot(reynolds5, liftC5);
plot(reynolds15, liftC15);
plot(reynolds45, liftC45);
hold off
legend("5 [deg]", "15 [deg]", "45 [deg]")
xlabel("Reynolds Number")
ylabel("Lift Coefficient")
title("Full Scale Robot: Reynolds Number vs. Lift Coefficient")

set(gcf, "Color", "w")