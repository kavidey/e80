%%
speed_of_sound = 1500; % [m/s]

%%
spkr1_freq = 9e3; % [Hz]
% spkr1_dist = []; % [m]
% spkr1_VdbV = []; % [VdbV]

% Fake Data
spkr1_dist = awgn(1:0.1:10, 20);
spkr1_VdbV = awgn(20 .* log(5./spkr1_dist), 0.5);

% spkr2_freq = 11e3; % [Hz]
% spkr2_dist = []; % [m]
% spkr2_VdbV = []; % [VdbV]

% spkr3_freq = 13e3; % [Hz]
% spkr3_dist = []; % [m]
% spkr3_VdbV = []; % [VdbV]

%%
clf
figure(1)
subplot(2, 1, 1)
[beta0, lambdaBeta0, beta1, lambdaBeta1, xplot, yplot] = linear_regression(log(spkr1_dist), spkr1_VdbV);
xlabel("log(Distance from speaker) [log(m)]")
ylabel("Voltage Magnitude [VdbV]")
title("Speaker 1: Distance vs Voltage Magnitude")
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

figure(2)
subplot(2, 1, 1)
[beta0, lambdaBeta0, beta1, lambdaBeta1, xplot, yplot] = linear_regression(log(spkr2_dist), spkr2_VdbV);
xlabel("log(Distance from speaker) [log(m)]")
ylabel("Voltage Magnitude [VdbV]")
title("Speaker 2: Distance vs Voltage Magnitude")
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
title("Speaker 2: Distance vs Voltage Magnitude")
hold off

figure(3)
subplot(2, 1, 1)
[beta0, lambdaBeta0, beta1, lambdaBeta1, xplot, yplot] = linear_regression(log(spkr3_dist), spkr3_VdbV);
xlabel("log(Distance from speaker) [log(m)]")
ylabel("Voltage Magnitude [VdbV]")
title("Speaker 3: Distance vs Voltage Magnitude")
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
title("Speaker 3: Distance vs Voltage Magnitude")
hold off