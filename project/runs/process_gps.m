function [x, y] = process_gps(lat, lon, lat_origin, lon_origin)
    EARTH_RADIUS = 6378100; % [m]

    x = EARTH_RADIUS * ((lon - lon_origin) * pi / 180) * cos(lat_origin * pi / 180);
    y = EARTH_RADIUS * ((lat - lat_origin) * pi / 180);
end