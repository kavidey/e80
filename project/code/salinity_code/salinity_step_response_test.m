% Trial 1: 5% salinity - hmc run 8-27
%starting at like 20 sec after entering water, increments of 10
temp1 = [21.2, 21.2, 21.2, 21.3, 21.3, 21.3, 21.3, 21.3, 21.3, 21.3, 21.3];
sec1 = (0:length(temp)-1) * 10 + 20;
[salinity, time] = process_salinity("HMC/run8/salinity_027", 4, 21.3);

% Trial 2: 3.7% salinity (100k thermistor)- hmc run 8-29
temp2 = [111.1, 110.4, 109.8, 109.8, 110, 110.2, 110.4, 110.6, 110.7, 110.7, 110.7, 110.7, 110.7, 110.8, 110.9, 110.9, 110.9, 110.9, 110.9, 110.8, 110.8, 110.8, 110.8, 110.8, 110.9, 110.9];
sec2 = (0:length(temp2)-1) * 10;
[salinity, time] = process_salinity("HMC/run8/salinity_029", 4, 21.3);

% Trial 3: same salinity percentage as trial 2, just measuring temp vs time without salinity to compare
temp3 = [111.1, 110.8, 110.9, 110.8, 110.8, 110.8, 110.8, 110.8, 110.9, 110.9, 110.8, 110.8, 110.8, 110.8];
sec3 = (0:length(temp3)-1) * 10 - 10;


B = 4250;
T0 = 298.15;
R0 = 100e3;
calc_T = @(r) (B * T0) ./ (B + T0.*(log(r/R0)));

clf
set(0,'DefaultLineLineWidth',1.5)
tiledlayout("vertical")
nexttile
hold on
plot(sec3, calc_T(temp3)-273.15-273.15, "DisplayName", "Without Salinity Sensor")
plot(sec2, calc_T(temp2)-273.15-273.15, "DisplayName", "With Salinity Sensor")
hold off
legend()
title("Temperature Step Response")
xlabel("Time [s]")
ylabel("Temperature [C]")
max_t = 250;
xlim([0 max_t])

nexttile
start_t = 92;
% end_t = 350;
end_t = start_t + max_t;
time_f = time(start_t < time & time < end_t);
salinity_f = salinity(start_t < time & time < end_t);
plot(time_f-start_t, salinity_f)
xlim([0 max_t])
xlabel("Time [s]")
ylabel("Salinity [ppt]")
title("Salinity Over Time")

set(gcf, "Color", 'w')
fontsize(gcf, 15, "points")

exportgraphics(gca,'salinity_step_response.eps','BackgroundColor','none', 'Resolution', 300)
