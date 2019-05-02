% LUPASCU MARIAN 331 - TEMA 9
clear; clc; close all;

%%
% 1
% Fiind data functia f(x) = 3*x*e^x - e^2*x, sa se aproximeze f(1.03) 
% folosind polinomul Hermite cu DD de gradul cel mult 3 si nodurile x1 = 1, 
% x2 = 1.05. Evaluati eroarea |f(1.03) - H3(1.03)|.

%{
f = @(x)(3*x.*exp(1).^x - exp(1).^(2*x));
n = 1;
a = 0;
b = 2;
X = [1, 1.05];
xGrafic = linspace(a, b, 100);

syms x0;
df = matlabFunction(diff(f(x0)));
[H, dH] = MetHermiteDD(X, f(X), df(X), x0);

figure;
hold on;
plot(xGrafic, f(xGrafic), '-c');
plot(xGrafic, subs(H, x0, xGrafic), '-m');

err = @(x)(abs(f(x) - subs(H, x0, x)));
double(err(1.03)) % err(1.03) = 1.2373e-06
%}

%%
% 2
% Se va implementa in Matlab procedura [y, z] = MetHermiteDD(X, Y, Z, x), 
% conform algoritmului (Polinomul Hermite cu diferente divizate), 
% folosind datele si cerintele de la Ex. 5, Tema#8.

% 1) Rezolvat: - vezi sectiunea de functii de la finalul scriptului

% 2)
%{
a = -pi/2;
b = pi/2;
interv = linspace(a, b, 100);
n = 3;
X = linspace(a, b, n + 1);
f = @(x)(sin(x));
syms x0;
df = matlabFunction(diff(f(x0)));

syms x;
[y, z] = MetHermiteDD(X, f(X), df(X), x);
figure, hold on;
plot(interv, f(interv), '-m');
plot(interv, subs(y, x, interv), '-g');

figure, hold on;
plot(interv, df(interv), '-c');
plot(interv, subs(z, x, interv), '-y');

% 3)
figure;
subplot(1, 2, 1);
errHerminte = @(a)(abs(f(a) - subs(y, x, a)));
plot(interv, errHerminte(interv));

subplot(1, 2, 2);
errDerivataHermite = @(a)(abs(df(a) - subs(z, x, a)));
plot(interv, errDerivataHermite(interv));
%}
 
%%
% 3
% Sa se afle functia de interpolare spline liniara S asociata functiei 
% f(x) = sin(x) relativ la diviziunea (-pi/2, pi/2).

% Rezolvare: - pe hartie

%%
% 4
% Fie f : [a, b] din R o functie continua.
% a) Sa se construiasca in Matlab procedura SplineL avand sintaxa 
% y = SplineL(X, Y, x), conform metodei de interpolare spline liniara. 
% Datele de intrare: vectorul X, componentele caruia sunt nodurile de 
% interpolare, i.e. a = X1 < X2 < ... < Xn+1 = b; vectorul Y definit
% prin Yi = f(Xi), i = 1, n + 1; variabila scalara x din [a, b]. Datele de 
% iesire: Valoarea numerica y reprezentand valoarea functiei spline liniara 
% S(x) calculata conform metodei spline liniare.
% b) Fie datele: f(x) = sin(x), x din [-pi/2, pi/2]; n = 2, 4, 10; 
% X - o diviziune echidistanta a intervalului [-pi/2, pi/2] cu n + 1 
% noduri; Y = f(X). Sa se construiasca grafic functia 
% f, punctele de interpolare (X, Y) si un vector S calculat conform 
% procedurii SplineL, corespunzator unei discretizari x a intervalului 
% [-pi/2, pi/2] cu 100 de noduri. Ind.: Si = SplineL(X, Y, xi), i = 1, 100.
% c) Sa se modifice procedura y = SplineL(X, Y, x), astfel incat parametrii 
% de intrare/iesire x si respectiv y sa poata fi vectori.

% a) - vezi sectiunea de functii de la finalul scriptului

% b)
%{
a = -pi/2;
b = pi/2;
interv = linspace(a, b, 100);
n = 10;
X = linspace(a, b, n + 1);
f = @(x)(sin(x));
hold on;
 
y = SplineL(X, f(X), interv);
 
plot(interv, f(interv), '-m');
plot(interv, y, '-g');
%}


%%
% -----------------------------------------
% --------------- FUNCTII -----------------
% -----------------------------------------

% 2.1
function [y, z] = MetHermiteDD(X, Y, Z, x)
 
n = length(X);
n = n * 2;
Q = zeros(n);
Q(1:2:end, 1) = Y';
Q(2:2:end, 1) = Y';
X = sort([X, X]);
 
for i = 2 : n
    for j = 2 : i
        if j == 2 && mod(i, 2) == 0
            Q(i, j) = Z(i/2);
        else
            Q(i, j) = (Q(i, j - 1) - Q(i-1, j-1)) / (X(i) - X(i - j + 1));
        end
    end
end
 
y = sym(Q(1, 1));
for k = 2 : n
    prod = sym(1);
    for p = 1 : k - 1
        prod = prod * (x - X(p));
    end
    y = y + Q(k, k) * prod;
end
z = diff(y);
 
end

% 4.a si c
function y = SplineL(X, Y, x)
 
n = length(X) - 1;
a = Y;
defazaj = 1;
len = length(x) / n;
x = [x, x(end)];
for j = 1 : n
    b(j) = (Y(j+1) - Y(j)) / (X(j+1) - X(j));
    
    inter = x(defazaj : defazaj + len);
    y(defazaj : defazaj + len) = ...
        a(j) + b(j) * (inter - X(j));
    defazaj = defazaj + len;
end

y = y(1:end-1); 
 
end


