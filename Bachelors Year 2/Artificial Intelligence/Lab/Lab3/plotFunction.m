function plotFunction(a, b, c, d)

x1 = linspace(0, 4*a, 100);
y1 = x1 ./ (x1 + a);
subplot(2, 2, 1);
plot(x1, y1);
title(num2str(a));
 
x2 = linspace(0, 4*b, 100);
y2 = x2 ./ (x2 + b);
subplot(2, 2, 2);
plot(x2, y2);
title(b);

x3 = linspace(0, 4*c, 100);
y3 = x3 ./ (x3 + c);
subplot(2, 2, 3);
plot(x3, y3);
title(c);

x4 = linspace(0, 4*d, 100);
y4 = x4 ./ (x4 + d);
subplot(2, 2, 4);
plot(x4, y4);
title(d);

end

