function plotPosition(p, AoA)
p.range_res = p.c/(2*p.bw)*p.range_factor;
range = p.rBin*p.range_res

% Determine coordinates
x = p.range*sind(p.theta)
y = p.range*cosd(p.theta)
xCalc = range*sind(AoA)
yCalc = range*cosd(AoA)

%Determine differences
xDiff = xCalc - x
yDiff = yCalc - y

% Plot on shared axes
figure
hold on;
plot(x, y, 'rx', 'MarkerSize', 10, 'LineWidth', 1.2);
plot(xCalc, yCalc, 'bo', 'MarkerSize', 10, 'LineWidth', 1.2);
xlim([-4,4]);
ylim([0,5]);
grid on;
title("Calculated vs Actual X-Y postion of target");
xlabel('x coordinates [m]');
ylabel('y coordinates [m]');
legend('Actual','Calculated');
end

