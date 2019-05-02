% LUPASCU MARIAN 331 - TEMA 10
clear; clc; close all;

%%
% 1
% Sa se afle functia de interpolare spline patratica S asociata functiei 
% f(x) = sin(x) relativ la diviziunea (-pi/2, pi/2).

% Rezolvare: - pe hartie

%% 
% 2
% Fie f : [a, b] ? R o functie continua.
% a) Sa se construiasca ?n Matlab procedura SplineP avand sintaxa 
% [y, z] = SplineP(X, Y, fpa, x), conform metodei de interpolare spline 
% patratica. Datele de intrare: vectorul X, componentele caruia sunt 
% nodurile de interpolare, i.e. a = X1 < X2 < ... < Xn+1 = b; vectorul
% Y definit prin Yi = f(Xi), i = 1, n + 1; derivata functiei f in 
% capatul din stanga a intervalului, fpa = f'(a); variabila scalara 
% x ? [a, b]. Datele de iesire: Valoarile numerice y, z reprezentand 
% valoarile functiei spline patratica S(x) si derivatei S'(x) calculate 
% conform metodei spline patratice. Indicatie: z = bj + 2*cj (x ? xj).
% b) Fie datele: f(x) = sin(x), x ? [-pi/2, pi/2]; n = 2, 4, 10; 
% X - o diviziune echidistanta a intervalului [-pi/2, pi/2] cu n + 1 
% noduri; Y = f(X). Sa se construiasca grafic functia f, punctele de 
% interpolare (X, Y) si functia spline S(x) calculata conform 
% procedurii SplineP, corespunzator unei discretizari x a intervalului 
% [-pi/2, pi/2] cu 100 de noduri.
% c) Intr-o alta figura sa se construiasca grafic derivata functiei spline
% si derivata functiei f.
% d) Sa se modifice procedura [y, z] = SplineP(X, Y, fpa, x), astfel ?ncat
% parametrii de intrare/iesire x si respectiv y, z sa poata fi vectori.

%{
% a). + d). - vezi sectiunea de functii

% b). + c).
a = -pi/2;
b = pi/2;

n = [2 4 10];
for i = 1 : length(n)
    X = linspace(a, b, n(i) + 1);
    f = @(x)(sin(x));
    syms x;
    df = matlabFunction(diff(f(x)));
    fpa = df(X(1));
    interv = linspace(a, b, 100);

    [y, z] = SplineP(X, f(X), fpa, interv);

    figure;
    hold on;
    plot(interv, f(interv), '-m');
    plot(interv, y, '-g');
    title(['functia n = ' num2str(n(i))]);

    figure;
    hold on;
    plot(interv, df(interv), '-m');
    plot(interv, z, '-g');
    title(['derivata n = ' num2str(n(i))]);
end
%}

%%
% 3
% Fie f : [a, b] ? R o functie continua.
% a) Sa se construiasca ?n Matlab procedura SplineC avand sintaxa 
% [y, z, t] = SplineC (X, Y, fpa, fpb, x), conform metodei de interpolare 
% spline cubice. Datele de intrare: vectorul X, componentele caruia sunt 
% nodurile de interpolare, i.e. a = X1 < X2 < ... < Xn+1 = b;
% vectorul Y definit prin Yi = f(Xi), i = 1, n + 1; derivata functiei f ?n 
% capetele intervalului, fpa = f'(a) ?si fpb = f'(b); variabila scalara 
% x ? [a, b]. Obs.: Pentru rezolvarea sistemului din care determina 
% coeficientii bi , i = 1, n + 1 se va apela metoda Jacobi pentru matrice
% diagonal dominante. Se va considera ? = 10^-8. Datele de iesire: 
% Valoarile numerice y, z, t reprezentand valorile functiei spline cubice 
% S(x), primei derivate S'(x) si derivatei a doua S''(x) determinate 
% numeric. Indicatie: z = bj + 2cj (x - Xj ) + 3dj (x - Xj )^2;
% t = 2cj + 6dj (x - Xj ).
% b) Fie datele: f(x) = sin(x), x ? [-pi/2, pi/2]; n = 2, 4, 10; 
% X - o diviziune echidistanta a intervalului [-pi/2, pi/2] cu n + 1 
% noduri; Y = f(X). Sa se construiasca grafic functia f, punctele de 
% interpolare (X, Y) si functia S calculat conform procedurilor SplineC,
% corespunzator unei discretizari x a intervalului [-pi/2, pi/2] cu 100 
% de noduri.
% c) Intr-o alta figura sa se construiasca grafic derivata functiei spline 
% si derivata functiei f.
% d) Intr-o alta figura sa se construiasca grafic derivata a doua a 
% functiei spline si a functiei f.
% e) Sa se modifice procedura y = SplineC(X, Y, fpa, fpb, x), astfel 
% ?ncat parametrii de intrare/iesire x si respectiv y sa poata fi vectori.

%{
% a). + e). - vezi sectiunea de functii

% b). + c). + d).
a = -pi/2;
b = pi/2;

n = [2 4 10];
for i = 1 : length(n)
    X = linspace(a, b, n(i) + 1);
    f = @(x)(sin(x));
    syms x;
    df = matlabFunction(diff(f(x)));
    ddf = matlabFunction(diff(df(x)));
    fpa = df(X(1));
    fpb = df(X(end));
    interv = linspace(a, b, 100);
 
    [y, z, t] = SplineC(X, f(X), fpa, fpb, interv);
    
    figure;
    hold on;
    plot(interv, f(interv), '-m');
    plot(interv, y, '-g');
    title(['functia n = ' num2str(n(i))]);

    figure;
    hold on;
    plot(interv, df(interv), '-m');
    plot(interv, z, '-g');
    title(['derivata n = ' num2str(n(i))]);
    
    figure;
    hold on;
    plot(interv, ddf(interv), '-m');
    plot(interv, t, '-g');
    title(['derivata a doua n = ' num2str(n(i))]);
end
%}

%%
% -----------------------------------------
% --------------- FUNCTII -----------------
% -----------------------------------------

% 2 a). + d). - este deja vectorizata
function [y, z] = SplineP(X, Y, fpa, x)
 
h = X(2) - X(1);
n = length(X) - 1;
a = Y;
defazaj = 1;
len = length(x) / n;
x = [x, x(end)];
b(1) = fpa;
 
for j = 1 : n - 1
   
    b(j + 1) = (2/h)*(Y(j+1) - Y(j)) - b(j);
end
 
c(1 : n) = (1/h^2)*(Y(2:n + 1) - Y(1:n) - b(1:n) * h);
   
for j = 1 : n
    inter = x(defazaj : defazaj + len);
    y(defazaj : defazaj + len) = ...
        a(j) + b(j) * (inter - X(j)) + c(j) * ((inter - X(j)).^2);
   
    z(defazaj : defazaj + len) = ...
        b(j) + 2 * c(j) * (inter - X(j));
    defazaj = defazaj + len;
end
 
y = y(1:length(x) - 1);
z = z(1:length(x) - 1);
 
end


% 3 a). + e). - este deja vectorizata
function [y, z, t] = SplineC(X, Y, fpa, fpb, x)
 
h = X(2) - X(1);
n = length(X) - 1;
a = Y;
defazaj = 1;
len = length(x) / n;
x = [x, x(end)];
M = 4 * diag(ones(1, n + 1)) + diag(ones(1, n), 1) + diag(ones(1, n), -1);
M(1, 1) = 1;
M(1, 2) = 0;
M(n + 1, n) = 0;
M(n+1, n+1) = 1;
g = zeros(1, n + 1);
 
for j = 2 : n
    g(j) = (3/h) * (Y(j+1) - Y(j-1));
end
g(1) = fpa;
g(n+1) = fpb;

eps = 10^(-8);
b = MetJacobiDDL(M, g', eps)';
 
c(1 : n) = (3/h^2)*(Y(2:n + 1) - Y(1:n)) - (1/h)*(b(2:n + 1) + 2*b(1:n));
 
d(1 : n) = -(2/h^3)*(Y(2:n + 1) - Y(1:n)) + (1/h^2)*(b(2:n + 1) + b(1:n));
   
for j = 1 : n
    inter = x(defazaj : defazaj + len);
    y(defazaj : defazaj + len) = a(j) + b(j) * (inter - X(j)) + ...
        c(j) * ((inter - X(j)).^2) + d(j) * ((inter - X(j)).^3);
   
    z(defazaj : defazaj + len) =  b(j) + 2 * c(j) * (inter - X(j)) +  ...
       3 * d(j) * ((inter - X(j)).^2);
    
    t(defazaj : defazaj + len) = 2 * c(j) + 6 * d(j) * (inter - X(j));
          
    defazaj = defazaj + len;
end
 
y = y(1:length(x) - 1);
z = z(1:length(x) - 1);
t = t(1:length(x) - 1);
 
end

function [x, iter] = MetJacobiDDL(A, b, eps)

    n = size(A, 1);
    iter = 1;
    N = diag(diag(A));
    x = zeros(n, 1);
    if find((2 * diag(A)' - sum(A')) <= 0)
        disp('Matricea nu este dominanta pe linii');
        return;
    end
    
    xnou = (eye(n) - N^(-1)*A) * x + N*(-1) * b;
    while norm(N * (xnou - x), Inf) >= eps
        x = xnou;
        xnou = (eye(n) - N^(-1)*A) * x + N^(-1) * b;
        iter = iter + 1;
    end
    x = xnou;

end
