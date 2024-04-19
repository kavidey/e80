% 2d array; 3 columns with x coords, y coords, and temperature vals

data = [43 43 9; 43 44 10; 43 45 9.5; 44 43 8; 45 43 10; 44 44 9; 45 44 8; 44 45 9; 45 45 8;];
% agregate data into 2d matrix
% idk if this will format correctly
Data = array2table(data, 'VariableNames', {'x coordinate', 'y coordinate', 'temperature'});

map = heatmap(Data, 'x coordinate', 'y coordinate', 'ColorVariable', 'temperature', ...
    'ColorMethod', 'mean'); %plots heat map of temperature
title = 'Salinity Temperature Accross Sampling Area';
output = 'hewwo'