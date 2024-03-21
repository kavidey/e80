[accelX,AccelY] = read_data('run', 'data');

len = length(accelX);

% X vs Y
dt = 0.1; %[s]; % The sampling rate
t = (0:len-1)*dt; % The time array

anx = accelX*0.0102; % Measured acceleration
vnx = cumtrapz(t,anx); % Integrate the measured acceleration to get the velocity
rnx = cumtrapz(t,vnx); % Integrate the velocity to get the position

any = AccelY*0.0102; % Measured acceleration
vny = cumtrapz(t,any); % Integrate the measured acceleration to get the velocity
rny = cumtrapz(t,vny); % Integrate the velocity to get the position

figure(1)
plot(rnx, rny)
xlabel('X (m)')
ylabel('Y (m)')
title('X vs Y')

% Y vs Time
dt = 0.1; %[s]; % The sampling rate
t = (0:len-1)*dt; % The time array
sigma = .2; % The standard deviation of the noise in the accel.
confLev = 0.95; % The confidence level for bounds
preie = sqrt(2)*erfinv(confLev)*sigma*sqrt(dt); % the prefix to the sqrt(t)
preiie = 2/3*preie; % The prefix to t^3/2a = 1 + sin( pi*t - pi/2);
plusie=preie*t.^0.5; % The positive noise bound for one integration
plusiie = preiie*t.^1.5; % The positive noise bound for double integration
an = AccelY*0.0102; % Measured acceleration
vn = cumtrapz(t,an); % Integrate the measured acceleration to get the velocity
rn = cumtrapz(t,vn); % Integrate the velocity to get the position
rnp = rn + plusiie'; % Position plus confidence bound
rnm = rn - plusiie'; % Position minus confidence bound
figure(2)
plot(t, rn, t, rnp,'-.', t, rnm,'-.')
xlabel('Time (s)')
ylabel('Y (m)')
title('Y vs Time')
legend('Y Position','Calculated Position','Upper Confidence Bound',...
    'Lower Confidence Bound','location','southeast')