f = @(x)(x.^3 - 7*(x.^2) + 14*x - 6);
a = 0;
b = 4;
eps = 10^(-5);
[x, y] = MetBisectie(f, a, b, eps, eps);
[x1, y1] = MetSecantei(f, a, b, eps, eps);
G = linspace(a, b, 100);
figure;
hold on;
plot(G, f(G), '-g');
plot(x, y, '*r');
plot(x1, y1, '*y');

function [xaprox, yaprox, ddfA] = MetSecantei(f,a,b,eps,h)
N = 0;
DFinA = eps;
while abs(DFinA) >= eps
    N = N + 1;
    DFinA = (f(a + h) - f(a)) / h;
    DFinB = (f(b + h) - f(b)) / h;
    alfa = (a * DFinB - b * DFinA) / (DFinB - DFinA);
    DFinAlfa = (f(alfa + h) - f(alfa)) / h;

    if DFinA * DFinAlfa < 0
        a = alfa;
        disp('mutare dreapta');
    else
        b = alfa;
        disp('mutare stanga')
    end
    disp(['a = ' num2str(a) '  b = ' num2str(b)])
end
xaprox = a;
yaprox = f(a);
ddfA = (f(xaprox + h) - 2*f(xaprox) + f(xaprox - h))/(h^2);
if ddfA > 0
    disp('punct de minim');
else
    disp('punct de maxim');
end
disp(['N = ' num2str(N)])
end

function [xaprox, yaprox, ddfA] = MetBisectie(f,a,b,eps,h)
N = 0;
while abs(a - b) >= eps
    N = N + 1;
    alfa = (a+b)/2;
    DFinA = (f(a + h) - f(a)) / h;
    DFinAlfa = (f(alfa + h) - f(alfa)) / h;

    if DFinA * DFinAlfa < 0
        b = alfa;
        disp('mutare stanga');
    else
        a = alfa;
        disp('mutare dreapta')
    end
    disp(['a = ' num2str(a) '  b = ' num2str(b)])
end
xaprox = a;
yaprox = f(a);
ddfA = (f(xaprox + h) - 2*f(xaprox) + f(xaprox - h))/(h^2);
if ddfA > 0
    disp('punct de minim');
else
    disp('punct de maxim');
end
disp(['N = ' num2str(N)])
end