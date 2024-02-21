% environmental variables
rho = 1.115; % density of air at room temp
nu = 1.46*10^5 % kinematic viscocity of air at room temp

% experimental data goes here
deltaPwater = [0.01 0.03 0.06 0.07 0.15 0.23 0.34 0.49 0.66];
fanSpeed = 15:5:55; % proportion, I'm assuming fan speeds are the same for all models tested
liftOffset = [0 0 0 0 0 0 0 0 0];
dragOffset = [0 0 0 0 0 0 0 0 0];
cone1DragExp = [22 25 24 27 28 32 35 37 40];
cone2DragExp = [1 1 1 1 1 1 1 1 1];
cone3DragExp = [1 1 1 1 1 1 1 1 1];
robotDragExp = [1 1 1 1 1 1 1 1 1];

% experimental constants
coneArea = 0.001963495408; % all cones have same frontal area
coneL = 50 % characteristic length of cone is 50mm diameter
robotL = 0.0931 % characteristic length of robot is 0.0931 m length ... i guess??
robotArea = 0.00164;
deltaP = deltaPwater*249.08;

% experimental calculations
cone1Drag = cone1DragExp - dragOffset;
cone2Drag = cone2DragExp - dragOffset;
cone3Drag = cone3DragExp - dragOffset;
robotDrag = robotDragExp - dragOffset;
v=sqrt(2*deltaP./rho);
reynoldsNumber = @(v, l, nu) v.*l./nu;
dragCoefficient = @(drag, rho, v, frontalArea) drag./(0.5.*rho.*v.^2.*frontalArea);
coneReynold = reynoldsNumber(v, coneL, nu);
robotReynold = reynoldsNumber(v, robotL, nu);

% nose 1 plotting
cone1Coeff = dragCoefficient(cone1Drag, rho, v, coneArea);
figure(1)
clf
subplot(4, 2, 1)
plot(cone1Drag, coneReynold)
xlabel("Drag (N)")
ylabel("Reynold's Number")
title("Drag vs Reynold's Number for Nose #1)")

subplot(4, 2, 2)
plot(cone1Coeff, coneReynold)
xlabel("Drag (N)")
ylabel("Reynold's Number")
title("Drag vs Reynold's Number for Nose #1)")

% nose 2 plotting
cone2Coeff = dragCoefficient(cone2Drag, rho, v, coneArea);
subplot(4, 2, 3)
plot(cone2Drag, coneReynold)
xlabel("Drag (N)")
ylabel("Reynold's Number")
title("Drag vs Reynold's Number for Nose #2)")

subplot(4, 2, 4)
plot(cone2Coeff, coneReynold)
xlabel("Drag (N)")
ylabel("Reynold's Number")
title("Drag vs Reynold's Number for Nose #2)")

% nose 3 plotting
cone3Coeff = dragCoefficient(cone3Drag, rho, v, coneArea);
subplot(4, 2, 5)
plot(cone2Drag, coneReynold)
xlabel("Drag (N)")
ylabel("Reynold's Number")
title("Drag vs Reynold's Number for Nose #3)")

subplot(4, 2, 6)
plot(cone2Coeff, coneReynold)
xlabel("Drag (N)")
ylabel("Reynold's Number")
title("Drag vs Reynold's Number for Nose #3)")

% robot plotting
robotCoeff = dragCoefficient(robotDrag, rho, v, robotArea);
subplot(4, 2, 7)
plot(robotDrag, robotReynold)
xlabel("Drag (N)")
ylabel("Reynold's Number")
title("Drag vs Reynold's Number for Robot Scale Model)")

subplot(4, 2, 8)
plot(robotCoeff, robotReynold)
xlabel("Drag (N)")
ylabel("Reynold's Number")
title("Drag vs Reynold's Number for Robot Scale Model)")

%% calibration curve for fan speed and wind speed
% uncomment here to plot calibration curve !!

% figure(1)
% clf
% speedplt(fanSpeed, v)

% the code below was originally written by the e80 teaching team
function output = speedplt(RPS, v)
    x = RPS;
    y = v;
    confLev = 0.95; % The confidence level
    N = length(y); % The number of data points
    xbar = mean(x);
    ybar = mean(y);
    Sxx = dot((x-xbar),(x-xbar));
    %Sxx = (x-xbar)*transpose(x-xbar);
    % beta1 is the estimated best slope of the best-fit line
    beta1 = dot((x-xbar),(y-ybar))/Sxx
    % beta1 = ((x-xbar)*transpose(y-ybar))/Sxx
    % beta0 is the estimated best-fit y-intercept of the best fit line
    beta0 = ybar - beta1*xbar
    yfit = beta0 + beta1*x;
    SSE = dot((y - yfit),(y - yfit)) % Sum of the squared residuals
    % SSE = (y - yfit)*transpose(y - yfit) % Sum of the squared residuals
    Se = sqrt(SSE/(N-2)) % The Root Mean Square Residual
    Sbeta0 = Se*sqrt(1/N + xbar^2/Sxx)
    Sbeta1 = Se/sqrt(Sxx)
    % tinv defaults to 1-sided test. We need 2-sises, hence:(1-0.5*(1-confLev))
    StdT = tinv((1-0.5*(1-confLev)),N-2) % The Student's t factor
    lambdaBeta1 = StdT*Sbeta1 % The 1/2 confidence interval on beta1
    lambdaBeta0 = StdT*Sbeta0 % The 1/2 confidence interval on beta0
    range = max(x) - min(x);
    xplot = min(x):range/30:max(x); % Generate array for plotting
    yplot = beta0 + beta1*xplot; % Generate array for plotting
    Syhat = Se*sqrt(1/N + (xplot - xbar).*(xplot - xbar)/Sxx);
    lambdayhat = StdT*Syhat;
    Sy = Se*sqrt(1+1/N + (xplot - xbar).*(xplot - xbar)/Sxx);
    lambday = StdT*Sy;
    figure(1)
    plot(x,y,'x')
    hold on
    plot(xplot,yplot)
    plot(xplot,yplot+lambdayhat,'-.b',xplot,yplot-lambdayhat,'-.b')
    plot(xplot,yplot+lambday,'--m',xplot,yplot-lambday,'--m')
    xlabel('Fan Speed (RPS)')
    ylabel('Wind Speed (m/s)')
    title("Wind Speed vs Fan Speed")
    if beta1 > 0 % Fix this
        location = 'northwest';
    else
        location = 'northeast';
    end
    legend('Data Points','Best Fit Line','Upper Func. Bound',...
        'Lower Func. Bound', 'Upper Obs. Bound', 'Lower Obs. Bound',...
        'Location', location)
    hold off
    output = [beta0, lambdaBeta0, beta1, lambdaBeta1];
end