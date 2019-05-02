% LUPASCU MARIAN 331 - TEMA 8
clear; clc; close all;
%%
% 1
% Sa se afle polinomul de interpolare Lagrange P2(x) a functiei f(x) = sin(x) 
% relativ la diviziunea(?pi/2, 0, pi/2), utilizand metodele Neville si Newton
% cu diferente divizate. Sa se evalueze eroarea |P2(pi/6) ? f(p1/6)|.

% Rezolvare - pe hartie

%%
% 2
% Fiind date functia f(x) = 3^x si diviziunea (-2, -1, 0, 1, 2), sa se 
% aproximeze sqrt(3) folosind metoda Neville.

% Rezolvare - pe hartie

%%
% 3
% Fiind date xj = j, j = 1...4, P1,2(x) = x + 1, P2,3(x) = 3x - 1, 
% P2,3,4(3/2)= 4, sa se calculeze P1,2,3,4(3/2).

% Rezolvare - pe hartie

%%
% 4
% Fie polinomul P2(x) = f[x1] + f[x1, x2](x - x1) + a3(x - x1)(x - x2). 
% Folosind P2(x3) aratati ca a3 = f[x1, x2, x3].

% Rezolvare - pe hartie

%%
% 5
% 1) Sa se construiasca in Matlab urmatoarele proceduri conform sintaxelor:
% a) y = MetNeville(X, Y, x) (y = Pn(x));
% b) y = MetNDD(X, Y, x), (y = Pn(x));
% c) [y, z] = MetHermite(X, Y, Z, x), (y = H2n+1(x), z = H'2n+1(x)),
% folosind metodele Neville, Newton cu diferente divizate si Hermite. 
% Vectorii X, Y, Z reprezinta nodurile de interpolare, respectiv valorile 
% functiilor f, f' in nodurile de interpolare.
% 2) Sa se construiasca in Matlab in aceea si figura, graficele functiei f 
% pe intervalul [a, b], punctele (Xi, Yi), i = 1, n + 1  si polinomul Pn 
% obtinut alternativ prin una din cele trei metode. Datel problemei sunt: 
% f(x) = sin(x), n = 3, a = -pi/2, b = pi/2. Se va considera diviziunea 
% (Xi)i=1,n+1 echidistanta. Pentru constructia graficelor functiei f si Pn, 
% folositi o discretizare cu 100 noduri. Intr-o alta figura sa se 
% construiasca derivata f' si derivata polinomului Hermite calculat numeric
% conform procedurii MetHermite.
% 3) Reprezentati grafic intr-o alta figura eroarea E = |f - Pn|.

% 1) Rezolvat: - vezi sectiunea de functii de la finalul scriptului

% 2)
%{
f = @(x)(sin(x));
n = 3;
a = -pi/2;
b = pi/2;
X = linspace(a, b, n+1);
xGrafic = linspace(a, b, 100);
figure(1);
hold on;
plot(xGrafic, f(xGrafic), '-c');
yGraficMetNeville = MetNeville(X, f(X), xGrafic);
plot(xGrafic, yGraficMetNeville, '-m');

figure(2);
hold on;
plot(xGrafic, f(xGrafic), '-c');
yGraficMetNDD = MetNDD(X, f(X), xGrafic);
plot(xGrafic, yGraficMetNDD, '-y');

syms x0;
df = matlabFunction(diff(f(x0)));
[H, dH] = MetHermite(X, f(X), df(X), x0);

figure(3);
hold on;
plot(xGrafic, f(xGrafic), '-c');
plot(xGrafic, subs(H, x0, xGrafic), '-m');

figure(4);
hold on;
plot(xGrafic, df(xGrafic), '-c');
plot(xGrafic, subs(dH, x0, xGrafic), '-m');

% 3)
figure(5);
subplot(1, 3, 1);
errMetNeville = @(x)(abs(f(x) - yGraficMetNeville));
plot(xGrafic, errMetNeville(xGrafic));

subplot(1, 3, 2);
errMetNDD = @(x)(abs(f(x) - yGraficMetNDD));
plot(xGrafic, errMetNDD(xGrafic));

subplot(1, 3, 3);
errMetHermite = @(x)(abs(f(x) - subs(H, x0, xGrafic)));
plot(xGrafic, errMetHermite(xGrafic));
%}

%%
% 6
% Fiind data functia f(x) = 3*x*e^x - e^(2*x), sa se aproximeze f(1.03) 
% folosind polinomul Hermite de gradul cel mult 3 si nodurile x1 = 1,
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
[H, dH] = MetHermite(X, f(X), df(X), x0);

figure;
hold on;
plot(xGrafic, f(xGrafic), '-c');
plot(xGrafic, subs(H, x0, xGrafic), '-m');

err = @(x)(abs(f(x) - subs(H, x0, x)));
err(1.03) % err(1.03) = 1.2373e-06
%}

%%
% -----------------------------------------
% --------------- FUNCTII -----------------
% -----------------------------------------

% 5.1
% a)
function y = MetNeville(X, Y, x)

    n = length(X) - 1;
    N = length(x);
    Q = zeros(n + 1, n + 1, N);
    for i = 1 : N
        Q(:, 1, i) = Y';
    end
    
    for i = 2 : n + 1
        
        for j = 2 : i
            
            Q(i, j, :) = (((x - X(i-j+1)) .* squeeze(Q(i, j-1, :))' - ...
                (x - X(i)) .* squeeze(Q(i-1, j-1, :))') / ...
                (X(i) - X(i-j+1)))'; % am expandat formula astfel incat sa 
                                     % nu calculez de fiecare data valoarea
                                     % polinomului in un punct ci intr-un
                                     % interval, e o dinamica pe un cub din
                                     % R^3
        end
    end
    
    y = squeeze(Q(n+1, n+1, :))';
end

% b) 
function y = MetNDD(X, Y, x)

    n = length(X) - 1;
    Q = zeros(n + 1);
    Q(:, 1) = Y';
    
    for i = 2 : n + 1
        
        for j = 2 : i
            
            Q(i, j) = (Q(i, j - 1) - Q(i - 1, j - 1)) / (X(i) - X(i - j + 1));
        end
    end
    
    y = ones(size(x)) * Q(1, 1);
    for k = 2 : n + 1
        
        P = ones(size(x));
        for p = 1 : k - 1
            
            P = P .* (x - X(p));
        end
        y = y + Q(k, k) * P;
    end
    
end

% c) 
function [y, z] = MetHermite(X, Y, Z, x)

    n = length(X) - 1;
    y = sym(0);
    for k = 1 : n + 1
        L = sym(1);
        for p = 1 : n + 1
            if k ~= p
                L = L * (x - X(p)) / (X(k) - X(p));
            end
        end
        dL = diff(L);
        dLk = subs(dL, x, X(k));
        H = (1 - 2 * dLk * (x - X(k))) * (L ^ 2);
        K = (x - X(k)) * (L ^ 2);
        y = y + H * Y(k) + K*Z(k);
    end
    z = diff(y);

end



