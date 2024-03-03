%%
speed_of_sound = 1500; % [m/s]

%%
spkr1_freq = 13e3; % [Hz]
spkr1_dist = [1 3 5 7 9 11 15 20 25] * 10^-2; % [m]
spkr1_VdbV = [8.6 3.77 -5.8 -15.3 -19.8 -18.4 -16.3 -21.04 -19.2]; % [VdbV]
% spkr1_dist = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]; % [cm]
% spkr1_VdbV = [-21.553 -21.905 -21.044 -21.143 -20.762 -20.805 -20.692 -21.310 -20.820 -21.320 -21.678 -21.633 -20.881 -20.903 -21.128 -21.768 -21.522 -21.826 -21.745 -21.998]; % [VdbV]

% Fake Data
% spkr1_dist = awgn(1:0.1:10, 20);
% spkr1_VdbV = awgn(20 .* log(5./spkr1_dist), 0.5);

spkr2_freq = 9e3; % [Hz]
spkr2_dist = [1 2 3 4 5 6] * 10^-2; % [m]
spkr2_VdbV = [-20.157 -20.439 -20.595 -20.689 -20.815 -20.908]; % [VdbV]

spkr3_freq = 11e3; % [Hz]
spkr3_dist = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20] * 10^-2; % [m]
spkr3_VdbV = [-1.159 -0.18 -0.28 -1.55 -2.61 -5.252 -11.293 -12.46 -9.14 -4.9 -4.25 -4.46 -5.84 -7.2 -7.039 -6.95 -5.845 -4.3 -4.58 -4.71]; % [VdbV]

%%
clf
figure(1)
subplot(2, 1, 1)
[beta0, lambdaBeta0, beta1, lambdaBeta1, xplot, yplot, lambday, lambdayhat] = linear_regression(log(spkr1_dist), spkr1_VdbV);
xlabel("log(Distance from speaker) [log(m)]")
ylabel("Voltage Magnitude [VdbV]")
title("Speaker 1: log(Distance) vs Voltage Magnitude")
set(gcf, "Color", "w")

subplot(2,1,2)
hold on
plot(spkr1_dist, spkr1_VdbV, 'x');
plot(exp(xplot), yplot);
plot(exp(xplot),yplot+lambdayhat,'-.b',exp(xplot),yplot-lambdayhat,'-.b')
plot(exp(xplot),yplot+lambday,'--m',exp(xplot),yplot-lambday,'--m')
legend('Data Points','Best Fit Line','Upper Func. Bound',...
    'Lower Func. Bound', 'Upper Obs. Bound', 'Lower Obs. Bound', ...
    'Location', 'best')
xlabel("Distance from Speaker [m]")
ylabel("Voltage Magnitude [VdbV]")
title("Speaker 1: Distance vs Voltage Magnitude")
hold off
%%
% figure(2)
clf
subplot(2, 1, 1)
[beta0, lambdaBeta0, beta1, lambdaBeta1, xplot, yplot, lambday, lambdayhat] = linear_regression(log(spkr2_dist), spkr2_VdbV);
xlabel("log(Distance from speaker) [log(m)]")
ylabel("Voltage Magnitude [VdbV]")
title("Speaker 2: log(Distance) vs Voltage Magnitude")
set(gcf, "Color", "w")

subplot(2,1,2)
hold on
plot(spkr2_dist, spkr2_VdbV, 'x');
plot(exp(xplot), yplot);
plot(exp(xplot),yplot+lambdayhat,'-.b',exp(xplot),yplot-lambdayhat,'-.b')
plot(exp(xplot),yplot+lambday,'--m',exp(xplot),yplot-lambday,'--m')
legend('Data Points','Best Fit Line','Upper Func. Bound',...
    'Lower Func. Bound', 'Upper Obs. Bound', 'Lower Obs. Bound', ...
    'Location', 'best')
xlabel("Distance from Speaker [m]")
ylabel("Voltage Magnitude [VdbV]")
title("Speaker 2: Distance vs Voltage Magnitude")
hold off
%%
% figure(3)
clf
subplot(2, 1, 1)
[beta0, lambdaBeta0, beta1, lambdaBeta1, xplot, yplot, lambday, lambdayhat] = linear_regression(log(spkr3_dist), spkr3_VdbV);
xlabel("log(Distance from speaker) [log(m)]")
ylabel("Voltage Magnitude [VdbV]")
title("Speaker 3: log(Distance) vs Voltage Magnitude")
set(gcf, "Color", "w")

subplot(2,1,2)
hold on
plot(spkr3_dist, spkr3_VdbV, 'x');
plot(exp(xplot), yplot);
plot(exp(xplot),yplot+lambdayhat,'-.b',exp(xplot),yplot-lambdayhat,'-.b')
plot(exp(xplot),yplot+lambday,'--m',exp(xplot),yplot-lambday,'--m')
legend('Data Points','Best Fit Line','Upper Func. Bound',...
    'Lower Func. Bound', 'Upper Obs. Bound', 'Lower Obs. Bound', ...
    'Location', 'best')
xlabel("Distance from Speaker [m]")
ylabel("Voltage Magnitude [VdbV]")
title("Speaker 3: Distance vs Voltage Magnitude")
hold off