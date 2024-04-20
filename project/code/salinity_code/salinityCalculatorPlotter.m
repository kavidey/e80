% takes in voltages and temperature, pus out salinity
clc
clf
clear

load('salinityfits.mat')
% put data here
gains = [1.1 1.2 1.3 1.2 1.3 1.5 1.23 1.42 1.31 1.4];
temps = [18 17.99 18.02 18 18.5 17.86 18.01 18.23 18 19];
salinity = Zpoly23(gains, temps)
xcoords = [43 43 43 44 45 44 45 44.5 45 47];
ycoords = [43 44 45 43 43 44 44 45.5 45 32];

[X, Y] = meshgrid(linspace(min(xcoords), max(xcoords), 100), linspace(min(ycoords), max(ycoords), 100));
Z = griddata(xcoords, ycoords, salinity, X, Y, "linear");
figure(1)
clf
hold on
surf(X, Y, Z);
view(2)
shading interp
scatter(xcoords, ycoords, max(salinity), "filled", MarkerFaceColor='black');
hold off
xlabel('x coordinate')
ylabel('y coordinate')

% try poly34

% salinities = Zpoly23(gains, temps);
% data = [xcoords' ycoords' salinities'];
% % data = [43 43 9; 43 44 10; 43 45 9.5; 44 43 8; 45 43 10; 44 44 9; 45 44 8; 44 45 9; 45 45 8;];
% % agregate data into 2d matrix
% % idk if this will format correctly
% Data = array2table(data, 'VariableNames', {'x coordinate', 'y coordinate', 'salinity'});
% 
% map = heatmap(Data, 'x coordinate', 'y coordinate', 'ColorVariable', 'salinity', ...
%     'ColorMethod', 'mean'); %plots heat map of temperature
% title = 'Salinity Accross Sampling Area';
% output = 'hewwo'