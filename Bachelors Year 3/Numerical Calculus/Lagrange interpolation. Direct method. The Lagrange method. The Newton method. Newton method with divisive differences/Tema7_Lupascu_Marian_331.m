% LUPASCU MARIAN 331 - TEMA 7
clear; clc; close all; %delete *.png
%%
% 1
% Fie urmatorul sistem de ecuatii neliniare:
%     x^2 + y^2 = 4
%     x^2/8 - y = 0
% (x, y) din [-3, 3] × [-3, 3]. Sa se implementeze in Matlab urmtoarele cerinte:
% - Sa se calculeze simbolic Jacobianul sistemului;
% - Sa se construiasca grafic curbele 
%     C1 : x^2 + y^2 = 4
%     C2: x^2/8 - y = 0
% - Sa se construiasca procedura Newton cu sintaxa [xaprox, N] = Newton(F, J, x0, eps) in
% baza algoritmului metodei Newton;
% - Sa se afle ambele puncte de intersectie apeland procedura Newton pentru datele eps = 10^-6
% si x0 ales in vecinatatea punctelor de intersectie.
% - Sa se construiasca pe graficul curbelor punctele de intersectie.
% - Sa se adapteze programul Newton astfel incat matricea Jacobian va fi calculata aproxi-
% mativ folosind diferente finite. Sa se recalculeze solutia apeland noua procedura.
%{
f1 = @(x, y)(x.^2 + y.^2 - 4);
f2 = @(x, y)((x.^2)./8 - y);

syms x y
A(x, y) = diff(f1(x, y), x);
B(x, y) = diff(f1(x, y), y);
C(x, y) = diff(f2(x, y), x);
D(x, y) = diff(f2(x, y), y);

j11 = matlabFunction(A);
j12 = matlabFunction(B);
j21 = matlabFunction(C);
j22 = matlabFunction(D);

figure; hold on;
fimplicit(f1, [-3 3]);
fimplicit(f2, [-3 3]);

% Newton
F = {f1 f2};
J = {j11, j12; j21 j22};
eps = 10^(-6);
x0 = [-2; 1];
[xAprox1, N1] = Newton(F, J, x0, eps);
x0 = [2; 1];
[xAprox2, N2] = Newton(F, J, x0, eps);
plot(xAprox1(1, 1), xAprox1(2, 1), '*r');
plot(xAprox2(1, 1), xAprox2(2, 1), '*b');

% NewtonCuDiferenteFinite
x0 = [-2; 1];
[xAprox1NewtonCuDiferenteFinite, N1NewtonCuDiferenteFinite] = ...
    z  ,l
.(F, x0, eps);
x0 = [2; 1];
[xAprox2NewtonCuDiferenteFinite, N2NewtonCuDiferenteFinite] = ...
    NewtonCuDiferenteFinite(F, x0, eps);
plot(xAprox1NewtonCuDiferenteFinite(1, 1), xAprox1NewtonCuDiferenteFinite(2, 1), '*y');
plot(xAprox2NewtonCuDiferenteFinite(1, 1), xAprox2NewtonCuDiferenteFinite(2, 1), '*g');
isequal(xAprox1, xAprox1NewtonCuDiferenteFinite)
isequal(xAprox2, xAprox2NewtonCuDiferenteFinite) % sunt foarte apropiate, a se vedea graficul
%}

%%
% 2
% Fie sistemul neliniar
%     x^2 - 10*x + y^2 + 8 = 0
%     x*y^2 + x - 10*y + 8 = 0
% (x1, x2) din [0, 5] x [0, 5] Raman valabile cerintele de la Ex. 1.

%{
f1 = @(x, y)(x.^2 - 10.*x + y.^2 + 8);
f2 = @(x, y)(x.*(y.^2) + x - 10.*y + 8);

syms x y
A(x, y) = diff(f1(x, y), x);
B(x, y) = diff(f1(x, y), y);
C(x, y) = diff(f2(x, y), x);
D(x, y) = diff(f2(x, y), y);

j11 = matlabFunction(A);
j12 = matlabFunction(B);
j21 = matlabFunction(C);
j22 = matlabFunction(D);

figure; hold on;
fimplicit(f1, [0 5]);
fimplicit(f2, [0 5]);

% Newton
F = {f1 f2};
J = {j11, j12; j21 j22};
eps = 10^(-6);
x0 = [1; 1];
[xAprox1, N1] = Newton(F, J, x0, eps);
x0 = [2.5; 2.5];
[xAprox2, N2] = Newton(F, J, x0, eps);
plot(xAprox1(1, 1), xAprox1(2, 1), '*r');
plot(xAprox2(1, 1), xAprox2(2, 1), '*b');

% NewtonCuDiferenteFinite
x0 = [1.1; 1.1];
[xAprox1NewtonCuDiferenteFinite, N1NewtonCuDiferenteFinite] = ...
    NewtonCuDiferenteFinite(F, x0, eps);
x0 = [2.2; 3];
[xAprox2NewtonCuDiferenteFinite, N2NewtonCuDiferenteFinite] = ...
    NewtonCuDiferenteFinite(F, x0, eps);
plot(xAprox1NewtonCuDiferenteFinite(1, 1), xAprox1NewtonCuDiferenteFinite(2, 1), '*y');
plot(xAprox2NewtonCuDiferenteFinite(1, 1), xAprox2NewtonCuDiferenteFinite(2, 1), '*g');
isequal(xAprox1, xAprox1NewtonCuDiferenteFinite)
isequal(xAprox2, xAprox2NewtonCuDiferenteFinite) % sunt foarte apropiate, a se vedea graficul
%}

%%
% 3
% Sa se afle polinomul de interpolare Lagrange P2(x), prin metodele directa, Lagrange, Newton
% ?si Newton cu diferente divizate, a functiei f(x) = sin(x) relativ la diviziunea 
% (-pi/2, 0, pi/2). Sa se evalueze eroarea |P2(pi/6) - f(pi/6)|.

% Rezolvare - pe hartie

%%
%4
% 1) Sa se construiasca ?n Matlab urmatoarele proceduri conform sintaxelor:
% a) y = MetDirecta(X, Y, x)
% b) y = MetLagrange(X, Y, x)
% c) y = MetN(X, Y, x)
% conform metodelor prezentate la curs. Vectorii X, Y reprezinta nodurile de 
% interpolare, respectiv valorile functiei f ?n nodurile de interpolare;
% 
% 2) Sa se construiasca ?n Matlab ?n aceeasi figura, graficele functiei f pe 
% intervalul [a, b], punctele (Xi, Yi), i = 1.. n + 1 si polinomul Pn 
% obtinut alternativ prin una din cele doua metode. Datele problemei sunt: 
% f(x) = sin(x), n = 3, a = ?pi/2, b = pi/2. Se va considera diviziunea 
% (Xi)i=1..n+1 echidistanta. Pentru constructia graficelor functiei f si Pn, 
% folositi o discretizare cu 100 noduri.
% 3) Reprezentati grafic intr-o alta figura eroarea E = |f ? Pn|.
% 4) Cresteti progresiv gradul polinomului Pn si rulati programele. 
% Ce observati in comportamentul polinomului Pn? Deduceti n maxim pentru 
% care polinomu Pn si pierde caracterul.
% 
% Obs.: Polinoamele Lagrange sunt instabile pentru n mare, i.e., la 
% o variatie mica ?n coeficienti apar variatii semnificative ?n 
% valorile polinomului.

%{
% 4.2
f = @(x)(sin(x));
n = 3;
a = -pi/2;
b = pi/2;
X = linspace(a, b, n + 1)';
Y = f(X);
xGrafic = linspace(a, b, 100);

figure; hold on;
plot(xGrafic, f(xGrafic), '-k');

yGraficDirect = MetDirecta(X, Y, xGrafic);
plot(xGrafic, yGraficDirect, '-m');

yGraficLagrange = MetLagrange(X, Y, xGrafic);
plot(xGrafic, yGraficLagrange, '-g');

yGraficNewton = MetNewton(X, Y, xGrafic);
plot(xGrafic, yGraficNewton, '-c');

% 4.3
figure; hold on;

yGraficDirect = MetDirecta(X, Y, xGrafic);
eMetDirecta = abs(f(xGrafic) - yGraficDirect);
plot(xGrafic, eMetDirecta, '-m');

yGraficLagrange = MetLagrange(X, Y, xGrafic);
eMetLagrange = abs(f(xGrafic) - yGraficLagrange);
plot(xGrafic, eMetLagrange, '-g');

yGraficNewton = MetNewton(X, Y, xGrafic);
eMetNewton = abs(f(xGrafic) - yGraficNewton);
plot(xGrafic, eMetNewton, '-c');
%}

%{
% 4.4
step = 5;
err = {};
for n = 5 : step : 100
    f = @(x)(sin(x));
    a = -pi/2;
    b = pi/2;
    X = linspace(a, b, n + 1)';
    Y = f(X);
    xGrafic = linspace(a, b, 1000);

    subplot(2,1,1); hold on;
    plot(xGrafic, f(xGrafic), '-k');

    yGraficDirect = MetDirecta(X, Y, xGrafic);
    plot(xGrafic, yGraficDirect, '-m');

    yGraficLagrange = MetLagrange(X, Y, xGrafic);
    plot(xGrafic, yGraficLagrange, '-g');

    yGraficNewton = MetNewton(X, Y, xGrafic);
    plot(xGrafic, yGraficNewton, '-c');
    title(['Graficele functiilor f si Pn pentru n=' num2str(n)]);
    hold off;
    
    subplot(2,1,2); 
    hold on;

    yGraficDirect = MetDirecta(X, Y, xGrafic);
    eMetDirecta = abs(f(xGrafic) - yGraficDirect);
    plot(xGrafic, eMetDirecta, '-m');

    yGraficLagrange = MetLagrange(X, Y, xGrafic);
    eMetLagrange = abs(f(xGrafic) - yGraficLagrange);
    plot(xGrafic, eMetLagrange, '-g');

    yGraficNewton = MetNewton(X, Y, xGrafic);
    eMetNewton = abs(f(xGrafic) - yGraficNewton);
    plot(xGrafic, eMetNewton, '-c');
    title(['Graficele erorilor pentru n=' num2str(n)]);
    saveas(gcf,['Grafic_n=' num2str(n) '.png']);
    err = [err, {[eMetDirecta; eMetLagrange; eMetNewton]}];
end
% se poate observa pe grafice ca de la n = 53, eroare incepe sa creasca
% destul de mult, acest lucru se poate observa si in matricea de celule
% err.
%}

%%
% -----------------------------------------
% --------------- FUNCTII -----------------
% -----------------------------------------

% 1
function [xAprox, N] = Newton(F, J, x0, eps)

N = 0;
JEval = [J{1, 1}(x0(1, 1), x0(2, 1)), J{1, 2}(x0(1, 1), x0(2, 1)); ...
    J{2, 1}(x0(1, 1), x0(2, 1)), J{2, 2}(x0(1, 1), x0(2, 1))];
FEval = [F{1, 1}(x0(1, 1), x0(2, 1)); F{1, 2}(x0(1, 1), x0(2, 1))];
x1 = x0 + JEval\FEval;

while norm((x1 - x0), Inf) >= eps
    
    N = N + 1;
    x0 = x1;
    JEval = [J{1, 1}(x0(1, 1), x0(2, 1)), J{1, 2}(x0(1, 1), x0(2, 1)); ...
        J{2, 1}(x0(1, 1), x0(2, 1)), J{2, 2}(x0(1, 1), x0(2, 1))];
    FEval = [-F{1, 1}(x0(1, 1), x0(2, 1)); -F{1, 2}(x0(1, 1), x0(2, 1))];
    x1 = x0 + JEval\FEval;
    
end

xAprox = x1;

end

function [xAprox, N] = NewtonCuDiferenteFinite(F, x0, eps)

N = 0;
h = randi(10) / 10^10; % aleg random un numar foarte mic intre 1e-10 si 1e-9
JEval = [(F{1, 1}(x0(1, 1) + h, x0(2, 1)) - F{1, 1}(x0(1, 1), x0(2, 1))) / h, ...
     (F{1, 1}(x0(1, 1), x0(2, 1) + h) - F{1, 1}(x0(1, 1), x0(2, 1))) / h; ...
     (F{1, 2}(x0(1, 1) + h, x0(2, 1)) - F{1, 2}(x0(1, 1), x0(2, 1))) / h, ...
     (F{1, 2}(x0(1, 1), x0(2, 1) + h) - F{1, 2}(x0(1, 1), x0(2, 1))) / h];
FEval = [-F{1, 1}(x0(1, 1), x0(2, 1)); -F{1, 2}(x0(1, 1), x0(2, 1))];
x1 = x0 + JEval\FEval;

while norm((x1 - x0), Inf) >= eps
    
    N = N + 1;
    x0 = x1;
    JEval = [(F{1, 1}(x0(1, 1) + h, x0(2, 1)) - F{1, 1}(x0(1, 1), x0(2, 1))) / h, ...
     (F{1, 1}(x0(1, 1), x0(2, 1) + h) - F{1, 1}(x0(1, 1), x0(2, 1))) / h; ...
     (F{1, 2}(x0(1, 1) + h, x0(2, 1)) - F{1, 2}(x0(1, 1), x0(2, 1))) / h, ...
     (F{1, 2}(x0(1, 1), x0(2, 1) + h) - F{1, 2}(x0(1, 1), x0(2, 1))) / h];
    FEval = [-F{1, 1}(x0(1, 1), x0(2, 1)); -F{1, 2}(x0(1, 1), x0(2, 1))];
    x1 = x0 + JEval\FEval;
    
end

xAprox = x1;

end

% 4.1
function y = MetDirecta(X, Y, x)

n = size(X, 1) - 1;
A = fliplr(vander(X));
a = A \ Y;
y = 0;
for i = 1 : (n + 1)
    y = y + a(i).*x.^(i-1);
end

end

function y = MetLagrange(X, Y, x)

n = size(X, 1) - 1;
y = 0;
for k = 1 : (n + 1)
    L = 1;
    for j = 1 : (n + 1)
        if j ~= k
            L = L .* ((x - X(j)) ./ (X(k) - X(j)));
        end
    end
    y = y + L * Y(k);
end

end

function y = MetNewton(X, Y, x)

n = size(X, 1) - 1;
A = zeros(n + 1);
A(:, 1) = 1;
for i = 2 : n + 1
    for j = 2 : i
        p = 1;
        for k = 1 : j - 1
            p = p * (X(i) - X(k));
        end
        A(i, j) = p;
    end
end

c = substAsc(A, Y);

y = c(1);
for i = 2 : (n + 1)
    p = 1;
    for j = 1 : i - 1
        p = p .* (x - X(j));
    end
    y = y + c(i) .* p;
end

end

function x = substAsc(A, b)

n = size(A, 1);
x = zeros(1, n);
x(1) = b(1) / A(1, 1);
for i = 2:n
    
    a = b(i) - x(1:i-1)*A(i,1:i-1)';
    x(i) = a/A(i, i);
end

end