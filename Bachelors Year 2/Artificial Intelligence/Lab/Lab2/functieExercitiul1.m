function [] = functieExercitiul1(min, max)

x1 = min : 0.1 : 2;
x2 = 2 : 0.1 : max;
y1 = 2 * x1 + 8;
y2 = 3 * (x2 .^ 2);

hold on;

p1 = plot(x1, y1, '-r');
p1(1).LineWidth = 2;
p2 = plot(x2, y2, '--b');
p2(1).LineWidth = 1;

hold off;

end

