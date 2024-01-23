[accelX_zero, accelY_zero, accelZ] = read_data('sample_data', 'data');
[accelX, accelY, accelZ_zero] = read_data('sample_data', 'data');

zero_acceleration_matrix = horzcat(accelX_zero, accelY_zero, accelZ_zero);

[p,tbl,stats] = anova1(zero_acceleration_matrix)
set(gcf, 'color', [1 1 1]);

title('Zero Acceleration on All Axes');
xticks([1 2 3])
xticklabels({'X','Y','Z'})
xlabel('Axis');
ylabel('Acceleration (m/s^2)');

print -dpng -r300 anova_boxplot.png
% exportapp(gcf, 'anova_boxplot.png')