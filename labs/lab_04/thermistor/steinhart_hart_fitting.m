%% Steinhart-Hart Temperatue Fitting

% The resistances
R = [473200, 441800, 412600, 385600, 360500, 337200, 315500, 295400, ...
    276700, 259300, 243100, 228000, 213900, 200800, 188600, 177200, ...
    166500, 156600, 147300, 138600, 130500, 122900, 115800, 109200, ...
    103000, 97130, 91660, 86540, 81730, 77220, 72980, 69000, 65260, ...
    61750, 58450, 55340, 52420, 49670, 47080, 44640, 42340, 40170, ...
    38120, 36200, 34380, 32660, 31040, 29510, 28060, 26690, 25400, ...
    24180, 23020, 21920, 20890, 19900, 18970, 18090, 17260, 16470, ...
    15710, 15000, 14320, 13680, 13070, 12490, 11940, 11420, 10920, ...
    10450, 10000, 9572, 9165, 8777, 8408, 8056, 7721, 7402, 7098, ...
    6808, 6531, 6267, 6015, 5774, 5545, 5326, 5116, 4916, 4725, 4543, ...
    4368, 4201, 4041, 3888, 3742, 3602];

% The temperatures
T = [237.89, 222.29, 220.44, 229.68, 223.80, 240.13, 224.09, 236.63, ...
    239.87, 236.67, 241.33, 230.53, 244.87, 243.76, 253.48, 248.04, ...
    245.11, 241.58, 250.99, 251.27, 254.79, 247.07, 244.51, 240.73, ...
    259.03, 247.82, 253.96, 246.75, 249.61, 260.59, 245.99, 270.61, ...
    262.16, 251.45, 256.72, 250.46, 259.38, 277.45, 267.59, 270.90, ...
    258.47, 257.87, 268.08, 267.12, 266.16, 283.41, 268.84, 273.66, ...
    263.59, 274.50, 291.04, 281.83, 267.99, 277.94, 278.47, 275.93, ...
    297.04, 273.29, 296.58, 283.65, 275.19, 284.87, 290.91, 302.05, ...
    283.67, 290.39, 299.32, 308.30, 300.72, 295.69, 298.54, 289.95, ...
    289.15, 313.87, 307.66, 316.51, 304.86, 308.64, 292.66, 293.79, ...
    312.59, 299.79, 322.10, 298.11, 317.17, 306.48, 326.64, 303.52, ...
    320.89, 308.95, 325.71, 315.08, 317.71, 317.80, 333.34, 337.38];

confLev = 0.95; % We set the confidence level for the data fits here.

% Constants from Datasheet (calculated using datasheet_constants.m)
A = 9.1478e-04;
B = 2.1481e-04;
C = 1.0345e-07;
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
plot(exp(xplot), 1 ./ (A + log(exp(xplot)) * B + (log(exp(xplot)).^3) * C))
plot(exp(xplot), 1./yplot)
plot(exp(xplot), 1./p21, '-.b') % Upper and lower functional confidence limits
plot(exp(xplot), 1./p11, '--m') % Upper and lower observational confidence limits
legend('Data Points','Pred. from datasheet','Best Fit Line','Upper Func. Bound',...
    'Lower Func. Bound', 'Upper Obs. Bound', 'Lower Obs. Bound',...
    'Location', 'northeast')
xlabel('Resistance (\Omega)')
ylabel('Temperature (K)')
title('Retransformed 3rd-Order with Fit Lines')
hold off
