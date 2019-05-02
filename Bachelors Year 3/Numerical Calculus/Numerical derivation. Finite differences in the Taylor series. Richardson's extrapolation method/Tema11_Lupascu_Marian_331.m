% LUPASCU MARIAN 331 - TEMA 10
clear; clc; close all;
%%
% 1
% a) Sa se creeze ?n Matlab procedura DerivNum cu sintaxa 
% dy = DerivNum(x, y, metoda). Parametrii de intrare sunt: vectorul x, 
% reprezentand discretizarea x1 < a = x2 < . . . < xm = b < xm+1; 
% vectorul y, reprezentand valoarea functiei f ?n x; metoda din {'diferente
% f inite progresive', 'diferente f inite regresive', 'diferente f inite
% centrale'}. Parametrul de iesire este vectorul dy calculat conform 
% Algoritmului (Derivare numerica). Se va folosi instructiunea de 
% selectie switch.
% b) Fie datele: f(x) = sin(x), a = 0, b = pi; m = 100; y = f(x). Sa 
% se construiasca grafic, derivata functiei f si derivata obtinuta 
% numeric ?n baza procedurii DerivNum, pe intervalul [0, pi].
% c) Intr-un alt grafic construiti eroarea, reprezentand diferenta ?n 
% modul dintre derivata exacta si cea calculata numeric.

%{
f = @(x)(sin(x));
a = 0;
b = pi;
m = 100;
x = linspace(a, b, m - 1);
h = x(2) - x(1);
x = [a - h, x, b + h];
y = f(x);

syms z;
df = matlabFunction(diff(f(z)));
aproxdf = DerivNum(x, y, 'diferente finite centrale');

figure, hold on;
plot(x(2:m), df(x(2:m)));
plot(x(2:m), aproxdf(2:m));

err = abs(df(x(2:m)) - aproxdf(2:m));
figure;
plot(x(2:m), err);
%}

%%
% 2
% a) Sa se construiasca ?n Matlab procedura MetRichardson cu sintaxa
% [df] =MetRichardson(f, x, h, n), conform algoritmului (Formula de
% extrapolare Richardson).
% b) Sa se construiasca grafic functia f'(x) si derivata aproximativa
% determinata ?n baza procedurii MetRichardson pe intervalul [a, b].
% Considerati x o discretizare a intervalului [a, b] cu 100 de noduri
% si construiti vectorul df apeland procedura MetRichardson ?n fiecare
% nod al discretizarii. Se vor considera urmatoarele date:
% - a = 0; b = pi
% - sin(x);
% - n = 4, 6, 8;
% - fi(x, h) = (f(x + h) - f(x)) / h
% c) Sa se construiasca grafic intr-o alta figura eroarea pe intervalul
% [a, b], reprezentand diferenta dintre valoarea exacta a derivatei f'(x)
% si valoarea aproximativa calculata cu ajutorul procedurii MetRichardson.
% d) Sa se calculeze derivata aproximativa f''(x) prin Metoda Richardson
% cu ordinul de aproximare O(h^n) apeland aceasi procedura,
% [d2f] = MetRichardson(f, x, h, n-1) si fi(x, h) =
% (f(x + h) - 2f(x) + f(x - h)) / h^2
% Obs.: Datorita faptului ca formula de aproximare pentru f''(x) este
% de ordinul doi am suprimat o coloana, astfel ca matricea Qij va avea
% n ? 1 linii si n ? 1 coloane.
% e) Sa se reprezinte grafic pe intervalul [a, b] derivata de ordinul
% doi exacta si aproximativa calculata conform procedurii MetRichardson.

%{
n = [4, 6, 8];

for k = 1 : length(n)
    f = @(x)(sin(x));
    a = 0;
    b = pi;
    m = 100;
    x = linspace(a, b, m);
    h = x(2) - x(1);

    syms z;
    df = matlabFunction(diff(f(z)));
    aproxdf = zeros(size(x));
    for i = 1 : m
        aproxdf(i) = MetRichardson(f, x(i), h, n(k));
    end

    figure, hold on;
    plot(x, df(x));
    plot(x, aproxdf);

    err = abs(df(x) - aproxdf);
    figure;
    plot(x, err);


    d2f = matlabFunction(diff(df(z)));
    aproxd2f = zeros(size(x));
    for i = 1 : m
        aproxd2f(i) = MetRichardson2(f, x(i), h, n(k));
    end

    figure, hold on;
    plot(x, d2f(x));
    plot(x, aproxd2f);

    err2 = abs(d2f(x) - aproxd2f);
    figure;
    plot(x, err2);
    
    pause(10);
    close all;
end
%}

%%
% -----------------------------------------
% --------------- FUNCTII -----------------
% -----------------------------------------

% 1 a)
function dy = DerivNum(x, y, metoda) 

m = length(x) - 1;

switch metoda
    
    case 'diferente finite progresive'
        dy(2:m) = (y(3:m+1) - y(2:m)) ./ (x(3:m+1) - x(2:m));
        
    case 'diferente finite regresive'
        dy(2:m) = (y(2:m) - y(1:m-1)) ./ (x(2:m) - x(1:m-1));
        
    case 'diferente finite centrale'
        dy(2:m) = (y(3:m+1) - y(1:m-1)) ./ (x(3:m+1) - x(1:m-1));
end
end

% 2 a)
function df = MetRichardson(f, x, h, n)

fi = @(x, h)((f(x + h) - f(x))./h);
Q = zeros(n);
for i = 1 : n
	Q(i, 1) = fi(x, h/(2^(i-1)));
end

for i = 2 : n
    for j = 2 : i
        Q(i, j) = Q(i, j-1) + 1/(2^(j-1) - 1) * ...
            (Q(i, j-1) - Q(i-1, j-1));
    end
end

df = Q(n, n);

end

% 2 d)
function df = MetRichardson2(f, x, h, n)

fi = @(x, h)((f(x + h) - 2 * f(x) + f(x - h))./(h ^ 2));
Q = zeros(n-1);
for i = 1 : n
	Q(i, 1) = fi(x, h/(2^(i-1)));
end

for i = 2 : n-1
    for j = 2 : i
        Q(i, j) = Q(i, j-1) + 1/(2^(j-1) - 1) * ...
            (Q(i, j-1) - Q(i-1, j-1));
    end
end

df = Q(n-1, n-1);

end
