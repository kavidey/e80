rho = 1.195; % [kg/m^3] density of air at room temp
nu = 15.27*10^-6; % kinematic viscocity of air at room temp

deltaPwater = [0 0.11 0.2 0.34 0.5 0.68 0.98 1.25 1.53 1.95 0 2.12 1.56 1.3 0.97 0.77 0.55 0.37 0.24 0.13];
deltaP = deltaPwater*249.08;
v=sqrt(2*deltaP./rho);

fanRPM = [0 472 650 820 995 1152 1358 1518 1672 1870 0 1954 1705 1560 1361 1214 1030 868 707 538];

figure(1)
set(groot,'defaultLineLineWidth',1)
[beta0, lambdaBeta0, beta1, lambdaBeta1] = linear_regression(fanRPM, v)
set(gcf, "Color", "w");

drag_kgf = [-1.244 -1.245 -1.245 -1.246 -1.245 -1.247 -1.248 -1.249 -1.250 -1.254 -1.244 -1.253 -1.251 -1.250 -1.248 -1.248 -1.247 -1.246 -1.246 -1.245];
lift_kgf = [0.789 0.790 0.791 0.792 0.793 0.796 0.799 0.805 0.809 0.815 0.796 0.836 0.824 0.821 0.820 0.815 0.812 0.810 0.806 0.802];

drag = drag_kgf * 9.80665;
lift = lift_kgf * 9.80665;
% drag = drag - drag(1);
% lift = lift - lift(1);

figure(2)
subplot(2,1,1)
scatter(v, drag)
title("Drag Offset")
xlabel("Wind Speed [m/s]")
ylabel("Drag Offset [N]")
grid on

subplot(2,1,2)
scatter(v, lift)
title("Lift Offset")
xlabel("Wind Speed [m/s]")
ylabel("Lift Offset [N]")
set(gcf, "Color", "w");
grid on

rpm2v = @(RPM) beta0 + beta1 * RPM;
kgf2N = @(kgf) kgf * 9.80665;

save calibration.mat v beta0 beta1 lambdaBeta0 lambdaBeta1 drag lift rpm2v kgf2N