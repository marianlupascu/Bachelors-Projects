clear;
clc;
%%
% 1
% Folosind metoda bisectiei pentru k = 2 sa se aproximeze manual solutia ecuatiei 8x^3+4x-1 = 0
% din intervalul [0; 1]: Sa se evalueze eroarea de aproximare.
% Rezolvare: initial k = 1; a0 = 0; b0 = 1; x0 = 0.5
% Cum f(a0)*f(x0) < 0 atunci a1 = 0; b1 = x0 = 0.5; x1 = 0.25.
% Apoi k = 2, unde f(a1)*f(x1) < 0 deci a2 = 0; b2 = x1 = 0.25; x2 = 0.125
% Deci dupa doua iteratii avem ca x2 = 0.25, unde f(x2) = 0.125 iar 
% xStar = 0.2267 pentru care f(xStar) = 0, deci avem o eroare de 
% 0.25 - 0.2267 = 0.0233

%{
syms x;
f = 8*x^3+4*x-1;
ezplot(f, [0, 1]);
hold on;
line(xlim, [0 0]);
line([0 0], ylim);
%}

%%
% 2
% Fie ecuatia x^3 - 7x^2 + 14x - 6 = 0
% a. Sa se construiasca in Matlab o procedura cu sintaxa [xaprox] = MetBisectie(f; a; b; eps).
% b. Intr-un fisier script sa se construiasca in Matlab grafcul functiei f(x) = x^3 - 7x^2 + 14x - 6
% pe intervalul [0; 4]: Sa se calculeze solutia aproximativa xaprox cu eroarea eps = 10^-5; apeland
% procedura MetBisectie pentru fecare interval in parte: 1. [0; 1]; 2. [1; 3.2]; 3. [3.2; 4]:
% c. Sa se construiasca punctele (xaprox; f(xaprox)) calculate la b. In acelasi grafc cu grafcul functiei.

%{
% a - vezi sectiunea de functii, la final
% b
f = @(x)x.^3 -7*x.^2 + 14*x -6;
x = linspace(0,4,100);
plot(x, f(x), 'Linewidth', 3)
hold on;
line(xlim, [0 0])
line([0 0], ylim)
eps = 10^(-5)
xAprox1 = MetBisectie(f, 0.01, 1, eps)
xAprox2 = MetBisectie(f, 1, 3.2, eps)
xAprox3 = MetBisectie(f, 3.2, 4, eps)
% c
plot(xAprox1, f(xAprox1), '*r');
plot(xAprox2, f(xAprox2), '*r');
plot(xAprox3, f(xAprox3), '*r');
%}


%%
% 3
% a. Sa se construiasca in Matlab grafcele functiilor y = e^x - 2 si y = cos(e^x - 2);
% b. Sa se implementeze in Matlab metoda bisectiei pentru a calcula o aproximare a solutiei ecuatiei
% e^x - 2 = cos(e^x - 2) cu eroarea eps = 10^-5 pe intervalul [0.5; 1.5]:

%{
% a
f = @(x)exp(1).^x - 2;
x = -2:0.01:2;
plot(x, f(x), 'Linewidth', 3)
hold on;
line(xlim, [0 0])
line([0 0], ylim)

g = @(x)cos(exp(1).^x - 2);
plot(x, g(x), '-r', 'Linewidth', 3)

% b
h = @(x)exp(1).^x - 2 - cos(exp(1).^x - 2);
eps = 10^(-5);
xAprox = MetBisectie(h, 0.5, 1.5, eps);
plot(xAprox, h(xAprox), '*m');
plot(xAprox, f(xAprox), '*g');
%}

%%
% 4
% Sa se gaseasca o aproximare a valorii sqrt(3) cu eroarea eps = 10^-5:

%{
f = @(x)x.^2 - 3;
x = 0:0.01:3;
eps = 10^(-5);
plot(x, f(x), 'Linewidth', 3)
hold on;
line(xlim, [0 0]);
line([0 0], ylim);
xAprox = MetBisectie(f, 0.5, 3, eps);
plot(xAprox, 0, '*m');
xAprox
%}


%%
% 5
% Fie ecuatia x^3 - 7x^2 + 14x - 6 = 0: Se stie ca ecuatia are solutie unica pe intervalul [0; 2.5]:
% Justifcati de ce sirul generat de metoda Newton - Raphson nu converge catre solutia din
% intervalul dat, daca valoarea de pornire este x0 = 2: Alegeti o valoare pentru x0 din [0; 2.5];
% astfel incat sirul construit de metoda N-R sa convearga la solutia din intervalul dat.

%{
f = @(x)x.^3 - 7*x.^2 + 14*x - 6;
x = 0:0.01:2.5;
plot(x, f(x), 'Linewidth', 3)
hold on;
line(xlim, [0 0]);
line([0 0], ylim);
%}

% Rezolvare: Sirul nu converge deoarece nu sunt respectate conditiile
% ipotezei teoremei, si anume a doua derivata se anuleaza undeva in
% [1, 1.5]. Deci daca se doreste solutia trebuie sectionat intervalul
% [0, 2.5], in doua subintervale si alicata functia de doua ori, pentru
% fiecare subinterval, si anume [0, x'] si [x', 2.5], unde f''(x') = 0, dar
% cum x' apartine intervalului [1, 1.5], avem ca x0 se afla in a doua parte
% adica in [x', 2.5], dar in acest subinterval functia nu se anuleaza, deci
% din nou nu sunt respectate contiitiile ipotezei. Pentru x0 din [0, x'],si
% anume x0 = 0 sau x0 = 0.5, ori ce x0 pentru care f(x0) < 0, deoarece f
% este concava pe [0, x']. 

%%
% 6
% Fie ecuatia x3 - 7x2 + 14x - 6 = 0:
% a. Sa se construiasca in Matlab o procedura cu sintaxa [xaprox] = MetNR(f; df; x0; eps) conform
% algoritmului metodei Newton-Raphson.
% b. Intr-un fisier script sa se construiasca grafcul functiei f(x) = x3 - 7x2 + 14x - 6 pe inter-
% valul [0; 4]: Alegeti din grafc trei subintervale si valorile initiale x0 corespunzatoare fecarui
% subinterval, astfel incat sa fie respectate ipotezele teoremei I.2. Afati cele trei solutii apel^and
% procedura MetNR cu eroarea de aproximare eps = 10^-3:

%{
% a - vezi sectiunea de functii, la final
% b
f = @(x)x.^3 -7*x.^2 + 14*x -6;
x = linspace(0,4,100);
plot(x, f(x), 'Linewidth', 3)
hold on;
line(xlim, [0 0])
line([0 0], ylim)
eps = 10^(-3);
syms x
deriv = diff(f(x));
df = matlabFunction(deriv);
xAprox1 = MetNR(f, df, 1, eps)
xAprox2 = MetNR(f, df, 2, eps)
xAprox3 = MetNR(f, df, 4, eps)
plot(xAprox1, f(xAprox1), '*r');
plot(xAprox2, f(xAprox2), '*r');
plot(xAprox3, f(xAprox3), '*r');
solve(8*x^3+4*x-1)
%}

%%
% 7
% Fie ecuatia 8x^3 + 4x - 1 = 0; x din [0; 1]:
% a. Sa se demonstreze ca ecuatia data admite solutie unica.
% b. Sa se calculeze x2 prin metodele Newton-Raphson, secantei si pozitiei false.

%{
% a
f = @(x)8*x.^3 + 4*x - 1;
x = linspace(0,1,100);
plot(x, f(x), 'Linewidth', 3)
hold on;
line(xlim, [0 0])
line([0 0], ylim)
syms x
deriv = diff(f(x))

%Rezolvare: cum f'(x) = 24x^2 + 4 > 0 pentru orice x din [0, 1], deci f
%este scrict crescatoare, si cum f(0) = -1 < 0, si f(1) = 6 > 0, rezulta ca
%avem o schimbare de semn pe [0, 1], deci avem solutie unica.

% b
% vezi sectiunea de functii, la final
f = @(x)8*x.^3 + 4*x - 1;
syms x
deriv = diff(f(x));
df = matlabFunction(deriv);
xAproxNR = MetNRStep(f, df, 0.7, 2)
xAproxSEC = MetSecStep(f, 0, 1, 0.1, 0.9, 2)
xAproxPozF = MetPozFStep(f, 0, 1, 2)
hold on;
plot(xAproxNR, f(xAproxNR), '+r');
plot(xAproxSEC, f(xAproxSEC), '*y');
plot(xAproxPozF, f(xAproxPozF), 'xg');
%}

%%
% 8
% Fie ecuatia x^3 - 18x - 10 = 0:
% a. Intr-un fisier script sa se construiasca grafcul functiei 
% f(x) = x^3 - 18x - 10 pe intervalul [-5; 5]:
% b. Sa se construiasca in Matlab o procedura cu sintaxa [xaprox] = MetSecantei(f; a; b; x0; x1; eps)
% conform algoritmului metodei secantei.
% c. Sa se construiasca in Matlab o procedura cu sintaxa 
% [xaprox] = MetPozFalse(f; a; b; eps) conform
% algoritmului metodei pozitiei false.
% d. Alegeti din grafc trei subintervale, astfel incat pe fiecare subinterval
% sa fie respectate ipotezele teoremei I.3. Afisati cele trei solutii apeland 
% procedura MetSecantei cu eroarea de aproximare eps = 10^-3: 
% Construiti punctele (xaprox; f(xaprox)) pe graficul functiei.
% e. Alegeti din grafic trei subintervale, astfel incat pe fiecare subinterval
% ecuatia f(x) = 0 admite o solutie unica. Aflati cele trei solutii apeland 
% procedura MetPozFalse cu eroarea de aproximare eps = 10^-3: 
% Construiti punctele (xaprox; f(xaprox)) pe graficul functiei.

%{
% a
f = @(x)x.^3 - 18*x - 10;
x = linspace(-5, 5, 500);
plot(x, f(x), 'Linewidth', 3)
hold on;
line(xlim, [0 0])
line([0 0], ylim)

% b - vezi sectiunea de functii, la final
% c - vezi sectiunea de functii, la final

% d
eps = 10^(-3);
xAprox1 = MetSecantei(f, -5, -3, -4.9, -2.9, eps)
xAprox2 = MetSecantei(f, -2, 2, -1.9, 1.9, eps)
xAprox3 = MetSecantei(f, 3, 5, 3.1, 4.9, eps)
plot(xAprox1, f(xAprox1), '*r');
plot(xAprox2, f(xAprox2), '*r');
plot(xAprox3, f(xAprox3), '*r');

% e
eps = 10^(-3);
xAprox1 = MetPozFalse(f, -5, -3, eps)
xAprox2 = MetPozFalse(f, -2, 2, eps)
xAprox3 = MetPozFalse(f, 3, 5, eps)
plot(xAprox1, f(xAprox1), '*g');
plot(xAprox2, f(xAprox2), '*g');
plot(xAprox3, f(xAprox3), '*g');
%}



%%
% FUNCTII
% 2) a)

function [xaprox] = MetBisectie(f,A,B,eps)
a(1)=A; b(1)=B; x(1)=1/2*(a(1)+b(1));
N=floor(log2((B-A/eps)));
for k=2:N+1
    if f(x(k-1))==0
        x(k)=x(k-1);
        break;
    elseif f(a(k-1))*f(x(k-1))<0
        a(k)=a(k-1);
        b(k)=x(k-1);
        x(k)=1/2*(a(k-1)+b(k-1));
    elseif f(a(k-1))*f(x(k-1))>0
        a(k)=x(k-1);
        b(k)=b(k-1);
        x(k)=1/2*(a(k-1)+b(k-1));
        end
    end
    xaprox = x(k);
end

% 6) a)
function [x] = MetNR(f, df, x0, eps)

    err = Inf;
    while err > eps
       
        x = x0 - f(x0)/df(x0);
        err = abs(x-x0)/x;
        x0 = x;
    end
end

% 7) b)
function [x] = MetNRStep(f, df, x0, stepMax)

    step = 0;
    while step <= stepMax
       
        x = x0 - f(x0)/df(x0);
        x0 = x;
        step = step + 1;
        
    end
end

function [x] = MetSecStep(f, a, b, x0, x1, stepMax)

    step = 0;
    while step <= stepMax
        
        step = step + 1;
        x = (x0*f(x1) - x1*f(x0)) / (f(x1) - f(x0));
        if x < a || x > b
            fprintf('Introduceti alte valori pentru x0 si x1');
            break;
        end
        x0 = x1;
        x1 = x;
    end
end

function [x] = MetPozFStep(f, a, b, stepMax)
    
    step = 0;
    a0 = a;
    b0 = b;
    x0 = (a0*f(b0) - b0*f(a0)) / (f(b0) - f(a0));
        
    cond = 1;
    while(cond == 1)
        
        step = step + 1;
        if f(x0) == 0
            x = x0;
            break;
        end
        if(f(a0) * f(x0) < 0)
            b0 = x0;
            x = (a0*f(b0) - b0*f(a0)) / (f(b0) - f(a0));
        end
        if(f(a0) * f(x0) > 0)
            a0 = x0;
            x = (a0*f(b0) - b0*f(a0)) / (f(b0) - f(a0));
        end
        
        if (step > stepMax)
            cond = 0;
        end
        x = x0;
    end
end

% 8) b)
function [x] = MetSecantei(f, a, b, x0, x1, eps)

    while abs(x1 - x0) / abs(x0) >= eps
        
        x = (x0*f(x1) - x1*f(x0)) / (f(x1) - f(x0));
        if x < a || x > b
            fprintf('Introduceti alte valori pentru x0 si x1');
            break;
        end
        x0 = x1;
        x1 = x;
    end
end

% 8) c)

function [x] = MetPozFalse(f, a, b, eps)
    
    a0 = a;
    b0 = b;
    x0 = (a0*f(b0) - b0*f(a0)) / (f(b0) - f(a0));
    
    cond = 1;
    while(cond == 1)
        
        if f(x0) == 0
            x = x0;
            break;
        end
        if(f(a0) * f(x0) < 0)
            b0 = x0;
            x = (a0*f(b0) - b0*f(a0)) / (f(b0) - f(a0));
        end
        if(f(a0) * f(x0) > 0)
            a0 = x0;
            x = (a0*f(b0) - b0*f(a0)) / (f(b0) - f(a0));
        end
        
        if (abs(x - x0) / abs(x0) < eps)
            cond = 0;
        end
        x0 = x;
    end
end


