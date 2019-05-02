% LUPASCU MARIAN 331 - TEMA 5
clear; clc;
%%
% 1 
% Fie matricea A = [3 1 1; 1 3 1; 1 1 3]; sa se calculeze in Matlab, apeland 
% dupa caz procedurile create in temele precedente:
% a) Normele matriciale ||A||p, p = 1; 2; Inf: Se va construi procedura 
% [normap] = normap(A; p) care returneaza norma p a matricei A:
% b) Raza spectrala ro(A): Cum este raza spectrala fata de normele calculate 
% la punctul a)?
% c) Numarul de conditionare Kp(A); p = 1; 2; Inf. Se va defini procedura 
% [condp] = condp(A; p) care returneaza numarul de conditionare in raport
% cu norma p.
% d) Numerele ||A||p si Kp(A) folosind functiile predefinite in Matlab 
% norm(A; p) si cond(A; p); p = 1; 2; Inf.

%{
A = [3 1 1; 1 3 1; 1 1 3];
% a)
norma1 = normap(A, 1)
norma2 = normap(A, 2)
normaInf = normap(A, Inf)

% b)
ro = razaSpectrala(A) % raza spectrala este mai mica decat orice norma

% c)
cond1 = condp(A, 1)
cond2 = condp(A, 2)
condInf = condp(A, Inf)

% d) - Scris mai sus a) si c)
%}

%%
% 2
% Fie sistemul Ax = b unde
% A = [10 7 8 7;
%      7 5 6 5;
%      8 6 10 9;
%      7 5 9 10]
% b = [32 23 33 31]'
% cu solutia x = [1 1 1 1 1]'
% a) Aflati solutia sistemului Ax = b, folosind procedura GaussPivTot.
% b) Fie b + delta*b = (32.1 22.9 33.1 30.9)' vectorul perturbat. Sa se 
% rezolve in sistemul A(x + delta*x) = b + delta*b: Ce observati in solutia obtinuta?
% c) Sa se calculeze in Matlab KInf(A). Sa se calculeze si sa se compare marimile
% ||delta * x||Inf / ||x||Inf si KInf(A) * ||delta * b||Inf / ||b||Inf
% Ce observati?
% d) Consideram sistemul perturbat (A + delta*A)(x + delta*x) = b unde
% A + delta * A = [10 7 8.1 7.2
%                  7.08 5.04 6 5
%                  8 5.98 9.89 9
%                  6.99 4.99 9 9.98]
% Sa se rezolve acest sistem. Ce observati in solutia sistemului perturbat?

%{
% a)
A = [10 7 8 7;...
     7 5 6 5;...
     8 6 10 9;...
     7 5 9 10];
b = [32 23 33 31];
x = GaussPivTot( A, b )

% b)
bPlusDeltaOrib = [32.1 22.9 33.1 30.9];
xPlusDeltaOrix = GaussPivTot( A, bPlusDeltaOrib )
% in solutia x + delta*x a sistemului A(x + delta*x) = b + delta*b se
% observa ca exista diferente destul de considerabile fata de solutia x,
% desi b + delta*b nu are asa multe diferente cu b.

% c)
condInf = condp(A, Inf)
n1 = norm(xPlusDeltaOrix - x, Inf) / norm(x, Inf)
n2 = condInf * norm(bPlusDeltaOrib - b, Inf) / norm(b, Inf)
% se observa ca n1 == n2

% d)
APlusDELTAOriA = [10 7 8.1 7.2;...
                 7.08 5.04 6 5;...
                 8 5.98 9.89 9;...
                 6.99 4.99 9 9.98];
xPlusDELTAOrix = GaussPivTot( APlusDELTAOriA, b )
% Se observa ca solutia x + DELTA*x a sistemului 
% (A + DELTA*A)(x + DELTA*x) = b in care doar matricea A a fost perturbata
% variaza/ este perturbata mult mai mult comparativ cu solutia precedenta
% in care doar vectorul coloana b a fost perturbat.
%}

%%
% 4
% Sa se construiasca in Matlab procedurile
% a) [xaprox;N] = MetJacobi(A; a; eps)
% b) [xaprox;N] = MetJacobiDDL(A; a; eps)
% c) [xaprox;N] = MetGaussSeidel(A; a; eps)
% conform metodelor: a) Metoda Jacobi, 
% b) Metoda Jacobi pentru matrice diagonal dominante pe linii, 
% c) Metoda Gauss - Seidel.

% Vezi sectiunea de functii de mai jos

%%
% 5
% 1) Sa se studieze aplicabilitatea metodelor in cazul urmatoarelor matrice:
% a) A = [0.2 0.01 0;
%         0 1 0.04;
%         0 0.02 1]; - Metoda Jacobi;
% b) A = [4 1 2;
%         0 3 1;
%         2 4 8]; - Metoda Jacobi pentru matrice diagonal dominante;
% c) A = [4 2 2;
%         2 10 4;
%         2 4 6];  - Metodele Jacobi si Gauss - Seidel.
% 2) In caz afirmativ sa se afle solutia aproximativa a sistemului Ax = a pentru matricele
% de la a), b) si c) apeland corespunzator procedurile de la Ex. 4, pentru a = (1 2 3)'
% si eps = 10^-5.

%{
% 1 a)
A =[0.2 0.01 0;...
     0 1 0.04;...
     0 0.02 1];
a = [1 2 3];
eps = 10^(-5);
[x, N] = MetJacobi(A, a', eps)
% metoda Jacobi este aplicabila deoarece norm(eye(size(A)) - A, Inf) = 
% 0.81 < 1 si avem x = (4.9059 1.8815 2.9624)'
%}

%{
%1 b)
A =[4 1 2;...
    0 3 1;...
    2 4 8];
a = [1 2 3];
eps = 10^(-5);
[x, N] = MetJacobiDDL(A, a', eps)
% metoda JacobiDDL este aplicabila deoarece matricea A este dominanta 
% pe linii si avem x = (0.0714 0.6571 0.0286 )'
%}

%{
% 1 c)
A = [4 2 2;
     2 10 4;
     2 4 6];
a = [1 2 3];
eps = 10^(-5);
[x, N] = MetJacobi(A, a', eps)
[x, N] = MetJacobiDDL(A, a', eps)
[x, N] = MetGaussSeidel(A, a', eps)
% metoda Jacobi nu este aplicabila deoarece norm(eye(size(A)) - A, Inf) = 
% 15 >= 1
% metoda JacobiDDL nu este aplicabila deoarece matricea A nu este dominanta 
% pe linii
% metoda Gauss Seidel este fezabila deoarece A este o matrice simetrica si
% pozitiv definita
%}

% 2) - Rezolvat anterior la punctul 1)

%%
% -----------------------------------------
% --------------- FUNCTII -----------------
% -----------------------------------------

% 1 a)
function [norma] = normap(A, p)

switch p
    case 1
        norma = max(sum(abs(A')));
    case 2
        norma = sqrt(max(eig((A') * A))); % puteam folosi si Metoda Jacobi 
                                          % de aproximare a valorilor proprii
                                          % in loc de eig
    case Inf
        norma = max(sum(abs(A)));
    otherwise
        disp('Norma trebuie sa fie 1, 2 sau Inf');
        return ;
end

end

% 1 b)
function [ro] = razaSpectrala(A)

ro = max(abs(eig(A)));

end

%1 c)
function [cond] = condp(A, p)

if det(A) == 0
    disp('A nu este nesingulara');
    return ;
end
cond = normap(A, p) * normap(A ^ (-1), p);

end

% 2 a)
function x = GaussPivTot( A, b )

n = size(A, 1);
A = [A, b'];
x = zeros(1, n);
index = 1:n;

for k = 1:n-1
    
	[l, c] = find(A(k:n, k:n)==max(max(abs(A(k:n, k:n)))));
    if isempty(l)
        
        disp("Compatibil nedeterminat");
        return ;
    end
    l(1) = l(1) + k - 1;
    c(1) = c(1) + k - 1;
    p = l(1);
    m = c(1);
    if p ~= k
        
        s = A(k, :);
        A(k, :) = A(p, :);
        A(p, :) = s';
    end
    
    if m ~= k
        
        s = A(:, k);
        A(:, k) = A(:, m);
        A(:, m) = s;
        aux = index(m);
        index(m) = index(k);
        index(k) = aux;
    end
    
    for l = k+1:n
        
       m = A(l, k)/A(k, k);
       A(l, :) = A(l, :) - m*A(k, :);
    end
end

if A(n, n) == 0
    
    disp("Compatibil nedeterminat");
    return ;
end

p = SubsDesc(A(:, 1:n), A(:, n+1));

x(index) = p;

end

function x=SubsDesc(A, b)

n = size(A, 1);
x = zeros(1, n);
for i = n:-1:1
    
    a = b(i) - x(i+1:n)*A(i,i+1:n)';
    x(i) = a/A(i, i);
end

end

% 4 a)
function [x, iter] = MetJacobi(A, b, eps)

    n = size(A, 1);
    iter = 1;
    N = eye(n);
    x = zeros(n, 1);
    if norm(eye(n) - N^(-1)*A, 1) >= 1
        disp('Algoritmul nu converge');
        return;
    end
    
    xnou = (eye(n) - N^(-1)*A) * x + N*(-1) * b;
    while norm(N * (xnou - x), 1) >= eps
        x = xnou;
        xnou = (eye(n) - N^(-1)*A) * x + N^(-1) * b;
        iter = iter + 1;
    end
    x = xnou;

end

% 4 b)
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

% 4 c)
function [x, iter] = MetGaussSeidel(A, b, eps)

if ~(isempty(find((A ~= A') ~= 0)) && ... % A simetrica
        isempty(find((2 * diag(A)' - sum(A')) < 0)) && ... % diagonala dominanta
        isempty(find(diag(A) <= 0))) % aii>0 pentru 1<=i<=n
%     am verificat ca A sa fie simetrica, 
%     cu diagonala dominanta si aii>0 pentru 1<=i<=n.
%     O conditie suficienta pentru ca o matrice A sa fie pozitiv definita
%     Puteam face si cu regula lui Sylvester, dar computational e mai ok
%     asa
    disp('Gauss-Seidel nu e fezabil');
    return ;
end
n = size(A, 1);
iter = 1;
x = zeros(n, 1);

for i = 1:n
    xnou(i) = (1/A(i, i))*(b(i) - A(i, 1:n)*x + A(i, i)*x(i));
end

while norm(x - xnou, Inf) >= eps
    x = xnou;
    for i = 1:n
        xnou(i) = (1/A(i, i))*(b(i) - A(i, i+1:n)*(x(i+1:n))' - A(i, 1:i-1)*(x(1:i-1))');
    end
    iter = iter + 1;
end
x = xnou;
x = x';

end