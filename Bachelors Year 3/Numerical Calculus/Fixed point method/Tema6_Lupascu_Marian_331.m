% LUPASCU MARIAN 331 - TEMA 6
clear; clc; close all;
%%
%{
% Jacobi Relaxat
A = [4 2 2;...
     2 10 4;...
     2 4 6];
a = [1 2 3]';
eps = 10^(-5);
[xAprox, N] = JacobiRelaxat(A, a, eps)
%}

%%
% 1 
% Sa se adapteze teorema III.2. pentru cazul unidimensional, i.e. n = 1.

% Rezolvat la laborator

%%
% 2
% Rescrieti demonstratia teoremei III.2. adaptate la cazul unidimensional.

% Rezolvat la laborator

%%
% 3
% Fie ecuatia f(x) = 0; unde f(x) = x^4 + 2*x^2 - x - 3. Se considera functi
% g(x) = (3 + x - 2*x^2)^(1/4).

% a) Aratati ca daca x* este punct fix pentru g, atunci x* este radacina 
% functiei f.
% Rezolvare:
% x* punct fix pentru g => g(x*) = x* => (3 + x* - 2*x*^2)^(1/4) = x* |^4 => 
% 3 + x* - 2*x*^2 = x*^4 => x*^4 + 2*x*^2 - x* - 3 = 0 => x* radacina pt. f

% b) Aflati domeniul de definitie D = [a; b] al functiei g.
% Rezolvare:
% g(x) = (3 + x - 2*x^2)^(1/4) <=>  g(x) = sqrt4(3 + x - 2*x^2), cum
% radicalul are ordinul par => 3 + x - 2*x^2 >= 0 => x partine [-1, 1.5] =>
% D = [-1, 1.5].

% c) Construiti in Matlab graficul functiei g pe intervalul [a; b] si un 
% patrat cu varfurile de coordonate (a; a); (a; b); (b; a); (b; b).
% Verificati conform graficului daca g(x) apartine [a; b], oricare x din
% [a; b]; i.e. graficul functiei g ramane in interiorul patratului.
% Rezolvare:

%{
a = -1;
b = 1.5;
x = linspace(a, b, 100);
g = @(x)((3+x-2*x.^2).^(1/4));
figure(1);
plot(x, g(x), '-r'); % graficul functiei g ramane in interiorul patratului.
hold on;
x1 = [a, b, b, a, a];
y1 = [a, a, b, b, a];
plot (x1, y1, 'Linewidth', 3)
plot(x, x, '-g');


% d) Construiti graficul functiei g' pe intervalul [a; b] si doua segmente de
% dreapta situate pe dreptele y = 1 si y = -1. Alegeti conform graficului un 
% interval [a'; b'] inclus in [a; b] astfel incat -1 < g'(x) < 1.
% Verificati daca g(x) apartine [a'; b'], pentru orice x din [a'; b']. 
% Daca nu, alegeti un alt interval [a''; b''] inclus in [a'; b'] astfel incat 
% g(x) apartine [a''; b''] pentru orice x din [a''; b'']. Obs.: Alegerea unui 
% alt interval [a''; b''] propune construirea unui patrat cu diagonala pe 
% bisectoarea y = x care contine punctul fix (punctul fix fiind punctul de 
% intersectie al functiei g cu bisectoarea y = x), iar graficul functiei g 
% restrictionata la intervalul [a''; b''] nu depaseste cadrul patratului.
% Rezolvare:
a = -1;
b = 1.5;
x = linspace(a, b, 100);
g = @(x)((3+x-2*x.^2).^(1/4));
syms arg;
dg = matlabFunction(diff(g(arg)));
figure(2);
hold on;
plot(x, dg(x));
plot([a, b],[1, 1]);
plot([a, b],[-1, -1]);

aPrim = -0.77;
bPrim = 1.27;
x = linspace(aPrim, bPrim, 100);
g = @(x)((3+x-2*x.^2).^(1/4));
syms arg;
dg = matlabFunction(diff(g(arg)));
figure(3);
hold on;
plot(x, dg(x), '-c');
plot([aPrim, bPrim],[1, 1], '-r');
plot([aPrim, bPrim],[-1, -1], '-r');

figure(4);
hold on;
plot(x, g(x), '-b');
plot([aPrim, bPrim],[aPrim, aPrim], '-g');
plot([aPrim, bPrim],[bPrim, bPrim], '-g');

aSecund = 0.766;
bSecund = 1.27;
x = linspace(aSecund, bSecund, 100);
g = @(x)((3+x-2*x.^2).^(1/4));
syms arg;
dg = matlabFunction(diff(g(arg)));
figure(5);
hold on;
plot(x, dg(x), '-c');
plot([aSecund, bSecund],[1, 1], '-r');
plot([aSecund, bSecund],[-1, -1], '-r');

figure(6);
hold on;
plot(x, g(x), '-b');
plot([aSecund, bSecund],[aSecund, aSecund], '-g');
plot([aSecund, bSecund],[bSecund, bSecund], '-g');

% e) Aflati solutia aproximativa conform metodei de punct fix cu eroarea
% eps = 10^-5 folosind criteriul de oprire |xk - xk-1| < eps si un x din 
% [a'; b'] oarecare.

eps = 10^(-5);
xaprox = punctFix(g, 1, eps);

% f) Construiti intr-o alta figura functia f pe intervalul [a; b] si solutia 
% aproximativa.

figure(7);
hold on;
f = @(x)(x.^4 + 2*x.^2 - x - 3);
plot(x, f(x), '-c');
line(xlim, [0 0]);
plot(xaprox, f(xaprox), 'om', 'MarkerSize', 10);
%}

%%
% 4
% a) Fie g1(x) = ((x + 3) / (x^2 + 2))^(1/2); cerintele sunt similare cu cele 
% de la Ex. 3.
% Rezolvare:
%   a) % x* punct fix pentru g1 => g1(x*) = x* => 
%   ((x* + 3) / (x*^2 + 2))^(1/2) = x* |^2 => 
%   (x* + 3) / (x*^2 + 2) = x*^2 => x* + 3 = x*^4 + 2*x*^2 =>
%   x*^4 + 2*x*^2 - x* - 3 = 0 => x* radacina pt. f

%   b) g1(x) = ((x + 3) / (x^2 + 2))^(1/2), cum x^2 + 2 > 0 pentru orice x 
%   => nu avem restrictii din cauza fractiei <=>  
%   g1(x) = sqrt2((x + 3) / (x^2 + 2)), cum
%   radicalul are ordinul par => (x + 3) / (x^2 + 2) >= 0, x^2 + 2 > 0 
%   pentru orice x  => x >= -3 => x partine [-3, +Inf] =>
%   D = [-3, +Inf].

%   c)
%{
a = -3;
b = 7;
x = linspace(a, b, 1000);
g1 = @(x)(((x + 3) ./ (x.^2 + 2)).^(1/2));
figure(1);
plot(x, g1(x), '-r'); % graficul functiei g1 ramane in interiorul patratului.
hold on;
x1 = [a, b, b, a, a];
y1 = [a, a, b, b, a];
plot (x1, y1, 'Linewidth', 3)
plot(x, x, '-g');

%   d)
a = -3;
b = 7;
x = linspace(a, b, 100);
g1 = @(x)(((x + 3) ./ (x.^2 + 2)).^(1/2));
syms arg;
dg1 = matlabFunction(diff(g1(arg)));
figure(2);
hold on;
plot(x, dg1(x));
plot([a, b],[1, 1]);
plot([a, b],[-1, -1]);

aPrim = a;
bPrim = b;
figure(3);
hold on;
plot(x, g1(x), '-b');
plot([aPrim, bPrim],[aPrim, aPrim], '-g');
plot([aPrim, bPrim],[bPrim, bPrim], '-g');

%	 e)
eps = 10^(-5);
xaprox = punctFix(g1, 1, eps);
% sirul construit in baza functiei g2 converge la solutia ecuatiei f(x) = 0.

%    f)

figure(4);
hold on;
f = @(x)(x.^4 + 2*x.^2 - x - 3);
plot(x, f(x), '-c');
line(xlim, [0 0]);
plot(xaprox, f(xaprox), 'om', 'MarkerSize', 10);
%}

% b) Fie g2(x) = ((x + 3 - x^4) / 2)^(1/2); cerintele sunt similare cu cele 
% de la Ex. 3. Testati daca sirul construit in baza functiei g converge la 
% solutia ecuatiei f(x) = 0.
% Rezolvare:
%   a) % x* punct fix pentru g1 => g2(x*) = x* => 
%   ((x + 3 - x^4) / 2)^(1/2) = x* |^2 => 
%   (x + 3 - x^4) / 2 = x*^2 => (x + 3 - x^4) = 2*x*^2 =>
%   x*^4 + 2*x*^2 - x* - 3 = 0 => x* radacina pt. f

%   b) g2(x) = ((x + 3 - x^4) / 2)^(1/2) <=>  
%   g1(x) = sqrt2((x + 3 - x^4) / 2), cum
%   radicalul are ordinul par => (x + 3 - x^4) / 2 >= 0 =>
%   x + 3 - x^4 >= 0 => x partine [-1.1640, 1.4526] =>
%   D = [-1.1640, 1.4526]. -- www.wolframalpha.com :)

%   c)
%{
a = -1.1640;
b = 1.4526;
x = linspace(a, b, 1000);
g2 = @(x)(((x + 3 - x.^4) / 2).^(1/2));
figure(1);
plot(x, g2(x), '-r'); % graficul functiei g2 ramane in interiorul patratului.
hold on;
x1 = [a, b, b, a, a];
y1 = [a, a, b, b, a];
plot (x1, y1, 'Linewidth', 3)
plot(x, x, '-g');

%   d)
a = -1.1640;
b = 1.4526;
x = linspace(a, b, 100);
g2 = @(x)(((x + 3 - x.^4) / 2).^(1/2));
syms arg;
dg2 = matlabFunction(diff(g2(arg)));
figure(2);
hold on;
plot(x, dg2(x));
plot([a, b],[1, 1]);
plot([a, b],[-1, -1]);

aPrim = -0.85;
bPrim = 1.05;
x = linspace(aPrim, bPrim, 100);
g2 = @(x)(((x + 3 - x.^4) / 2).^(1/2));
figure(3);
hold on;
plot(x, dg2(x), '-b');
plot([aPrim, bPrim],[aPrim, aPrim], '-g');
plot([aPrim, bPrim],[bPrim, bPrim], '-g');

figure(4);
hold on;
plot(x, g2(x), '-b');
plot([aPrim, bPrim],[aPrim, aPrim], '-g');
plot([aPrim, bPrim],[bPrim, bPrim], '-g');

aSecund = aPrim;
bSecund = -0.65;
x = linspace(aSecund, bSecund, 100);
g2 = @(x)(((x + 3 - x.^4) / 2).^(1/2));
syms arg;
dg2 = matlabFunction(diff(g2(arg)));
figure(5);
hold on;
plot(x, dg2(x), '-c');
plot([aSecund, bSecund],[1, 1], '-r');
plot([aSecund, bSecund],[-1, -1], '-r');

figure(6);
hold on;
plot(x, g2(x), '-b');
plot([aSecund, bSecund],[aSecund, aSecund], '-g');
plot([aSecund, bSecund],[bSecund, bSecund], '-g');
% OBS: -- IMPORTANT --
% A se vedea pe figurile 6 si 4 ca NU putem construi un patrat cu diagonala
% pe bisectoarea y = x care contine punctul fix (punctul fix fiind punctul 
% de intersectie al functiei g cu bisectoarea y = x). De fapt putem dar nu
% contine absolut nici un punct din graficul functiei, deoarece restrictia
% [a'', b''] pentru f nu lasa graficul sa se intersecteze cu dreapta y = x.

%	 e)
eps = 10^(-5);
xaprox = punctFix(g2, 1, eps);
% sirul construit in baza functiei g2 NU converge la solutia ecuatiei f(x) = 0.
%	 f)

figure(7);
hold on;
f = @(x)(x.^4 + 2*x.^2 - x - 3);
plot(x, f(x), '-c');
line(xlim, [0 0]);
plot(xaprox, f(xaprox), 'om', 'MarkerSize', 10);
%}

%%
% 6
% Fie sistemul neliniar
% x1^2 - 10*x1 + x2^2 + 8 = 0
% x1*x2^2 +x1 - 10*x2 + 8 = 0
% a) Sa se demonstreze ca x* este solutie a sistemului neliniar daca si 
% numai daca x* este punct fix pentru functia 
% G(x1; x2) = ((x1^2 + x2^2 + 8) / 10, (x1*x2^2 + x1 + 8) / 10)

% Rezolvare - pe hartie

% b) Sa se demonstreze conform teoremei III.2. ca functia G admite un 
% unic punct fix pe domeniul D = {(x1; x2)| 0 <= x1; x2 <= 1:5}
% 
% Rezolvare - pe hartie

% c) Sa se afle solutia aproximativa conform metodei de punct fix cu eroarea 
% eps = 10^-5.

%{
eps = 10^(-5);
g1 = @(x1, x2)((x1.^2 + x2.^2 + 8) ./ 10);
g2 = @(x1, x2)((x1.*x2.^2 + x1 + 8) ./ 10);
x0 = [1; 1.25];
xsol = punctFix2D(g1, g2, x0, eps);
    
% d) Sa se construiasca grafic curbele descrise implicit de ecuatiile 
% F1(x1; x2) = 0; F2(x1; x2) = 0 unde F1(x;x2) = x1^2 - 10*x1 + x2^2 + 8
% si F2(x1; x2) = x1*x2^2 +x1 - 10*x2 + 8. Alegetti intervale potrivite 
% pentru a vizualiza cat mai bine curbele. Vezi fisierul CalculSimbolic.pdf
% la sectiunea grafice de curbe descrise implicit de ecuatia F(x; y) = 0.

syms x1 x2
F1 = x1^2 - 10*x1 + x2^2 + 8;
F2 = x1*x2^2 +x1 - 10*x2 + 8;
hold on;
ezplot(F1, [0, 1.5, 0, 1.5]);
ezplot(F2, [0, 1.5, 0, 1.5]);
grid on
axis equal

% e) Construiti in acelasi grafic solutia aproximativa care va reprezenta 
% punctul de intersectie a graficelor celor doua curbe.

plot(xsol(1,1), xsol(2, 1), 'or');
%}


%%
% -----------------------------------------
% --------------- FUNCTII -----------------
% -----------------------------------------

function [xAprox, Iter] = JacobiRelaxat(A, a, eps)

if ~(isempty(find((A ~= A') ~= 0, 1)) && ... % A simetrica
        isempty(find(diag(A) <= 0, 1))) % aii>0 pentru 1<=i<=n
%     am verificat ca A sa fie simetrica, 
%     si aii>0 pentru 1<=i<=n, adica pozitiv definita.
%     O conditie suficienta pentru ca o matrice A sa fie pozitiv definita
%     Puteam face si cu regula lui Sylvester, dar computational e mai ok
%     asa
    disp('Jacobi Relaxat nu e fezabil');
    return ;
end

n = size(A, 1);
[~,D] = eig(A);
D = diag(D);
D = sort(D);
D = D';
sigma = 2 / (D(n) + D(1));
q = (D(n) - D(1)) / (D(n) + D(1));
B = eye(n) - sigma * A;
b = sigma * a;
x0 = zeros(n, 1);
Iter = 1;
x1 = B * x0 + b;
xPrev = x1;
while (q^Iter / (1 - q)) * norm((x1 - x0), Inf) >= eps
    
    Iter = Iter + 1;
    x = B * xPrev + b;
    xPrev = x;
end

xAprox = x;

end

% 1 e)
function xsol = punctFix(g, x0, eps)
 
x = g(x0);
sir = [x0, x];
IterMax = 10^4;
iter = 1;
while(abs(x - x0) >= eps)
   
   x0 = x;
   x = g(x0);
   sir = [sir, x];
   iter = iter + 1;
   if iter == IterMax
       disp("Algoritmul nu converge");
       plotSir(sir);
       return
   end
end
 
xsol = x;
 
 end

 % acesta functie este aplelata cand algoritmlul nu converge, pentru a
 % evidentia divergenta sirului data ca parametru.
 function [] = plotSir(sir) 

f = @(x)(x.^4 + 2*x.^2 - x - 3);
figure(100);
hold on;
plot(sir, f(sir), 'or'); 
 
 end

% 6 c)
function xsol = punctFix2D(g1, g2, x0, eps)
 
x11 = g1(x0(1, 1), x0(2, 1));
x12 = g2(x0(1, 1), x0(2, 1));
while(norm(x0 - [x11; x12], Inf) >= eps)
   
   x0 = [x11; x12];
   x11 = g1(x0(1, 1), x0(2, 1));
   x12 = g2(x0(1, 1), x0(2, 1));

end
 
xsol = [x11; x12];
 
end