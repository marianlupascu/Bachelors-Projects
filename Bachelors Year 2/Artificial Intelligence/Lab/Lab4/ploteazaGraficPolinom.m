function [] = ploteazaGraficPolinom(P, a, b, culoare)

X = linspace(a, b);
Y = polyval(P, X);
hold on
plot(X, Y, culoare)
axis([0 1 -1.2 1.2])
hold off

end

