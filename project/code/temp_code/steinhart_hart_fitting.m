%% Steinhart-Hart Temperatue Fitting

% The resistances
R = [102.84 102.15 96.89 92.42 86.82 81.73 78.74 75.47 70.53 68.12 65.11 61.32 60.26 58.22 57.33 55.24 53.96] * 1e3; % kOhm
% R = [323.1500  353.1500  373.1500  358.1500]; % from datasheet

% The temperatures
T = [7.8 8.0 8.8 9.8 11.1 12.2 13.1 14.1 15.4 16.2 17.1 18.4 18.9 19.4 20.0 20.6 21.1] + 273.15; % K
% T = [1.6432 0.5518 0.2902 0.4673] * 1e4; % from datasheet

confLev = 0.95; % We set the confidence level for the data fits here.

% Constants from Datasheet (calculated using datasheet_constants.m)
A = -7.982;
B = 4.151;
C = -0.7198;
D = 0.04161;
%% Plot Original Data
% Plot the original temperature and noisy temperature data.
figure(1)
plot(R,T,'x')
xlabel('Resistance (\Omega)')
ylabel('Temperature (K)')
title('Temperature vs Resistance')
legend('Temperature')
hold off

% Since a plot of 1/T vs ln(R) should be close to linear, we will convert
% the data to the correct forms and do linear and polynomial fits with
% them.
ooT = 1./T;
lnR = log(R);

%% Plot Transformed Data
% Plot the transformed original temperature and noisy temperature data.
figure(2)
plot (lnR,ooT,'x')
xlabel('ln[Resistance (\Omega)]')
ylabel('Reciprocal Temperature (1/K)')
title('Original and Noisy Data Transformed')
legend('Original Temperatures','Noisy Temperatures')
hold off

% Start by working with the original transformed data. We will fit a 1st,
% 2nd, and 3rd order polynomial to the data and look at the fit and the
% residuals.
range = max(lnR) - min(lnR); % Get range for our xplot data
xplot = min(lnR):range/30:max(lnR); % Generate x data for some of our plots.
% The fitting routine 'fit' is particular about the form of the data.
% Use the line below to get your data into the correct format for 'fit'.
[Xout,Yout] = prepareCurveData(lnR, ooT);
[f1,stat1] = fit(Xout,Yout,'poly1') % 1st-order fit with statistics.
[f2,stat2] = fit(Xout,Yout,'poly2') % 2nd-order fit with statistics.
[f3,stat3] = fit(Xout,Yout,'poly3') % 3rd-order fit with statistics.
%% Plot Residuals
% Since the fit is so close, we need a better way to distinguish how well
% 1st-, 2nd-, and 3rd-order fit. We'll plot the residuals to compare.
figure(3)
subplot(3,1,1)
plot(f1,Xout,Yout,'residuals')
% xlabel('Ln[Resistance (\Omega)]')
ylabel('Residuals (1/K)')
title('1st Order Polynomial Fit')
% The linear residuals look parabolic, so we need at least 2nd order.
subplot(3,1,2)
plot(f2,Xout,Yout,'residuals')
% xlabel('Ln[Resistance (\Omega)]')
ylabel('Residuals (1/K)')
title('2nd Order Polynomial Fit')
% The 2nd-order residuals look cubic so we need at least 3rd order.
subplot(3,1,3)
plot(f3,Xout,Yout,'residuals')
xlabel('Ln[Resistance (\Omega)]')
ylabel('Residuals (1/K)')
title('3rd Order Polynomial Fit')
% The 3rd-order residuals look pretty random, so we're done.

%% Plot 3rd-order Fit and Bounds
% Let's plot the 3rd order fit with the data and the functional and
% observational bounds. Note, since there is so little noise in the data,
% we won't be able to distinguish which is which.
p11 = predint(f3,xplot,confLev,'observation','off'); % Gen conf bounds
p21 = predint(f3,xplot,confLev,'functional','off'); % Gen conf bounds
figure(4)
plot(f3,Xout,Yout) % Notice that the fit doesn't need both x and y.
hold on
plot(xplot, p21, '-.b') % Upper and lower functional confidence limits
plot(xplot, p11, '--m') % Upper and lower observational confidence limits
xlabel('Ln[Resistance (\Omega)]')
ylabel('Reciprocal Temperature (1/K)')
title('3rd Order Polynomial Fit')
legend('Data Points','Best Fit Line','Upper Func. Bound',...
    'Lower Func. Bound', 'Upper Obs. Bound', 'Lower Obs. Bound',...
    'Location', 'northwest')
hold off
%% Transform Fit Back
% Let's untransform the best fit and confidence bounds back into the
% original space with T vs R and see how good we feel about things.
yplot = f3(xplot);
figure(5)
plot(R,T,'x')
hold on
% plot(exp(xplot), 1 ./ (A + log(exp(xplot)) * B + (log(exp(xplot)).^2) * C + (log(exp(xplot)).^3) * D))
R0 = 47000; % from datasheet
T0 = 293.15; % reference temp is 25C, negligible uncertainty
B = 4050; % in Kelvin, from 25 to 50 C
calc_T = @(r) (B * T0) ./ (B + T0.*(log(r/R0)));
%plot(R, calc_T(R));
plot(exp(xplot), 1./yplot)
plot(exp(xplot), 1./p21, '-.b') % Upper and lower functional confidence limits
plot(exp(xplot), 1./p11, '--m') % Upper and lower observational confidence limits
legend('Data Points','Best Fit Line','Upper Func. Bound',...
    'Lower Func. Bound', 'Upper Obs. Bound', 'Lower Obs. Bound',...
    'Location', 'northeast')
xlabel('Resistance (\Omega)')
ylabel('Temperature (K)')
title('Retransformed 3rd-Order with Fit Lines')
hold off
