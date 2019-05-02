% LUPASCU MARIAN 331 - TEMA 3
clear; clc;
%%
% 1 
% Sa se propuna un Algoritm in baza metodei Gauss-Jordan, care are ca date de intrare matricea
% A si ca date de iesire inversa A^1 si det(A).
% Optiune: Se poate aplica Gauss cu pivotare partiala atunci cand se elimina elementele sub
% diagonala principala, iar pentru eliminarea elementelor deasupra diagonalei principale se vor
% aplica strict transformari elementare (fara interschimbare de linii).

% Rezolvare pe hartie.

%%
% 2
% Sa se construiasca in Matlab procedura GaussJordan conform sintaxei
% [invA, detA] = GaussJordan(A), unde invA reprezint a inversa matricei A, iar detA semnifica
% det(A). Sa se apeleze procedura GaussJordan pentru datele de intrare: A = [4 2 2; 2 10 4; 2 4 6]
% Sa se rezolve ?n Matlab, apeland procedura GaussJordan, sistemul Ax = b,
% b = (12 30 10)'

% Rezolvare: - vezi sectiunea de functii de la final.
%{
A = [4 2 2; 2 10 4; 2 4 6];
[Inv, Det] = GaussJordan(A);
Inv, Det
%}

%%
% 3
% Fie sistemul:
%     x2 + x3 = 3
%     2*x1 + x2 + 5*x3 = 5
%     4*x1 + 2*x2 + x3 = 1
% a) Sa se afle manual descompunerea LU utilizand metodele Gauss fara pivotare si cu pivotare
% partiala. Obs.: Se va tine cont de indicatia de la Ex. 4.
% b) Sa se afle solutia sistemului conform metodei de factorizare LU:

% Rezolvare pe hartie.

%%
% 4
% Sa se propuna un Algoritm de factorizare LU care foloseste metodele Gauss fara pivotare si
% cu pivotare partiala. Algoritmul va avea ca date de intrare matricea A din Mn(R); respectiv
% vectorul b din R^n; iar ca date de iesire matricele L; U si x din R^n - solutia sistemului Ax = b:

% Rezolvare pe hartie.

%%
% 5
% Sa construiasca in Matlab procedurile:
% a) [x] = SubsAsc(A; b)
% b) [L; U; x] = FactLU(A)
% conform metodelor substitutiei ascendente si factorizarii LU si sa se apeleze procedura FactLU
% pentru exemplul de la Ex. 3.

% a) - Vezi sectiunea de functii de la final
% b) - Vezi sectiunea de functii de la final
%{
A = [0 1 1; 2 1 5; 4 2 1];
b = [3 5 1];
[L, U, x] = factorizareLU(A, b');
L, U, x
%}

%%
% 6
% Fie Fie A =[1 2 3; 2 5 8; 3 8 14]
% a) Verificati daca A este simetrica si pozitiv definita;
% b) In caz afirmativ, determinati factorizarea Cholesky;
% c) Sa se rezolve sistemul Ax = b; b = (-5 -14 -25)'; folosind factorizarea Cholesky.

% Rezolvare pe hartie.

%%
% 7
% Sa se construiasca in Matlab procedura FactCholesky conform sintaxei
% [x; L] = FactCholesky(A; b) si se aplice aceasta procedura pentru datele de la Ex.6.

% Vezi sectiunea de functii de la final

%{
A =[1 2 3; 2 5 8; 3 8 14];
b = [-5 -14 -25];
[x, L] = FactCholesky(A, b');
x, L
%}


%%
% -----------------------------------------
% --------------- FUNCTII -----------------
% -----------------------------------------

% 2

function [Inv, Det] = GaussJordan( A )

n = size(A, 1);
A = [A, eye(n)];
Det = 1;
for k = 1:n
    
	ind = find(A(k:n, k)~= 0);
    if isempty(ind)
        
        disp("Avem coloana nula, deci det = 0");
        Det = 0;
        return ;
    end
    ind(1) = ind(1) + k -1;
    p = ind(1);
    if p ~= k
        
        c = A(k, :);
        A(k, :) = A(p, :);
        A(p, :) = c';
        Det = Det * (-1);
    end
    for l = 1:n
       
       if l ~= k
           m = A(l, k)/A(k, k);
           A(l, :) = A(l, :) - m*A(k, :);
       end 
    end
    c = 1 / A(k, k);
    A(k, :) = A(k, :) * c;
    Det = Det / c;
end

if A(n, n) == 0
    disp("Avem coloana nula, deci det = 0");
    Det = 0;
    return ;
end

Inv = A(:, n+1 :end);

end

% 5

function [L, U, x] = factorizareLU( A, b )

U = A;
n = size(A, 1);
L = eye(n);

x = zeros(1, n);
for k = 1:n
    
	ind = find(U(k:n, k)==max(abs(U(k:n, k))));
    ind(1) = ind(1) + k - 1;
    if isempty(ind) || U(ind(1), k) == 0
        
        disp("Compatibil nedeterminat");
        return ;
    end
    p = ind(1);
    if p ~= k
        
        U([p, k], :) = U([k, p], :);
        b([p, k]) = b([k, p]);
        if k >= 2
            L([p, k], 1:k - 1) = L([k, p], 1:k-1);
        end
    end
    for l = k+1:n
        
       m = U(l, k)/U(k, k);
       U(l, :) = U(l, :) - m*U(k, :);
       L(l , k) = m;
    end
end

y = substAsc(L, b);
x = substDesc(U, y);
% substAsc si substDesc sunt la finalul script-ului

end

% 7

function [x, L] = FactCholesky(A, b)

n = size(A, 1);
L = zeros(n);
alfa = A(1, 1);
if alfa <= 0
    disp("A nu este pozitiv definita\n");
    return;
end

L(1, 1) = sqrt(alfa);
for i = 2:n
    
    L(i, 1) = A(i, 1) / L(1, 1);
end

for k = 2:n
    
    alfa = A(k, k) - sum(L(k, 1:k-1).^2);

    if alfa <= 0
        disp("A nu este pozitiv definita\n");
        return;
    end
    L(k, k) = sqrt(alfa);
    
    for i = k + 1:n
    
        L(i, k) = (A(i, k) - sum(L(i, 1:k-1).*L(k, 1:k-1))) / L(k, k);
    end
end

y = substAsc(L, b);
x = substDesc(L', y);
end

% 5

function x=substAsc(A, b)

n = size(A, 1);
x = zeros(1, n);
x(1) = b(1) / A(1, 1);
for i = 2:n
    
    a = b(i) - x(1:i-1)*A(i,1:i-1)';
    x(i) = a/A(i, i);
end

end

function x=substDesc(A, b)

n = size(A, 1);
x = zeros(1, n);
x(n) = b(n) / A(n, n);
for i = n-1:-1:1
    
    a = b(i) - x(i+1:n)*A(i,i+1:n)';
    x(i) = a/A(i, i);
end

end