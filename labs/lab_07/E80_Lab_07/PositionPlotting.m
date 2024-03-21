% matlablogging
% reads from Teensy data stream
filename= .001;
map = imread("campusmap.png");
imgdim = size(map)
xdim = imgdim(1)
ydim = imgdim(2)
realx = 260 % real map width, in meters, approximated using google maps
realy = 160 % real map height, in meters, approximated using google maps
imgScale = mean([realx/xdim, realy/ydim])
map = imresize(map, imgScale);
positionPlotter(map)

function position=positionPlotter(map)

    % based on plot_open_loop_run.m, by Kavi Dey (kdey@hmc.edu) 1/26/24
    % commented code that theoretically reads inn data
    % [accelX,accelY,accelZ,magX,magY,magZ,headingIMU,pitchIMU,rollIMU,motorA,motorB,motorC] = read_data('run', 'data');
    X = [1 20 30 40 50 60 70 80 90 100];
    Y = [10 20 38 25 20 21 15 23 18 23];
    startSampleNo = 1;
    stopSampleNo = 10;
    xScaleFactor = 1;
    xShift = 75; % origin is ~75m east of plot origin
    yScaleFactor = 1;
    yShift = 140; % origin is ~140m north of plot origin
    
    fh = figure;
    set(fh, 'color', [1 1 1]);  
    
    hold on
    image(map)
    plot(X(startSampleNo:stopSampleNo)*xScaleFactor+xShift, Y(startSampleNo:stopSampleNo)*yScaleFactor+yShift, 'LineWidth', 2.5);
    h = legend('X', 'Y');
    set(h, 'Location', 'best');
    xlabel('X position');
    ylabel('Y positionon');
    title('Path over Harvey Mudd Campus');
    fontsize(16,"points")
    hold off
    
    print -dpng -r300 accel.png
    end
