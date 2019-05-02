% LUPASCU MARIAN 331 - TEMA 3
clear; clc;
%%
% 1 
% Fie matricea A = [1 1 0; 1 0 1; 0 1 1]. Sa se afle manual factorizarea QR 
% prin metoda Givens. Sa se rezolve sistemul Ax = b; unde b = (1; 2; 5)'.

% Rezolvare pe hartie.

%%
% 2 
% Sa se implementeze algoritmul Metoda Givens si sa se apeleze pentru datele de la Ex. 1.

% Rezolvare: - vezi sectiunea de functii de la final.

%{
A = [1 1 0; 1 0 1; 0 1 1];
b = [1 2 5]';
[ Q, R, x ] = metodaGivens( A, b )
%}

%%
% 3
% Fie matricea A = [3 1 1; 1 3 1; 1 1 3]. Sa se calculeze conform definitiei 
% valorile proprii ale matricei A.

% Rezolvare pe hartie.

%%
% 4
% Sa se implementeze in Matlab Metoda Jacobi de aproximare a valorilor 
% proprii si sa se aplice pentru matricea de la Ex.3 si eps = 10^-4.

% Rezolvare: - vezi sectiunea de functii de la final.

%{
A = [3 1 1; 1 3 1; 1 1 3];
eps = 10^(-4);
lambda = Metoda_Jacobi_de_aproximare_a_valorilor_proprii(A, eps);
lambda
%}

%%
% 5
% Sa se demonstreze ca det(A) = lambda1 * ... * lambdan; unde lambdai, 
% i=1...n sunt valorile proprii ale matricei A din Mn(R): Indicatie: 
% Se vor folosi relatiile lui Viete pentru polinomul caracteristic Pn(lambda) =
% det(A - lambda * In) = (-1)^n*lambda^n + cn-1*lambda^n-1 + ... + c0
% si se va tine cont ca Pn(0) = det(A).

% Rezolvare pe hartie.

%%
% 6 
% Sa se demonstreze ca daca A din Mn(R) este nesingulara, atunci matricea A'A 
% este pozitiv definita. Indicatie: Se va folosi definitia unei matrice
% pozitiv definite.

% Rezolvare pe hartie.

%%
% 7
% Fie lambda valoare proprie pentru A din Mn(R) si x diferit de 0 un un 
% vector propriu asocoat valorii proprii lambda:
% Sa se arate ca:
% a) lambda este valoare proprie si pentru A';
% b) lambda^k este valoare proprie a matricei A^k cu vectorul propriu x:
% c) Daca A este nesingulara, atunci 1/lambda este valoare proprie a
% matricei A^-1 cu vectorul propriu x.

% Rezolvare pe hartie.



%%
% -----------------------------------------
% --------------- FUNCTII -----------------
% -----------------------------------------

% 2
function [ Q, R, x ] = metodaGivens( A, b )

n = size(A, 1);
Q = eye(n);
R = A;
x = zeros(n, 1);
for i = 1:n-1
    
    for j = i+1:n
        
        s = R(j, i) / sqrt(R(j, i)^2 + R(i, i)^2);
        c = R(i, i) / sqrt(R(j, i)^2 + R(i, i)^2);
        u = R(i, :);
        R(i, :) = c*u + s*R(j, :);
        R(j, :) = -s*u + c*R(j, :);
        
        u = Q(i, :);
        Q(i, :) = c*u + s*Q(j, :);
        Q(j, :) = -s*u + c*Q(j, :);
        
    end
end

x = SubsDesc(R, Q*b);
Q = Q';

end

function x = SubsDesc(A, b)

n = size(A, 1);
x = zeros(1, n);
x(n) = b(n) / A(n, n);
for i = n-1:-1:1
    
    a = b(i) - x(i+1:n)*A(i,i+1:n)';
    x(i) = a/A(i, i);
end

end

% 4

function n = modulMatrice(M) 

S = (M - (eye(size(M)) .* M)) .^ 2;
n = sum(S(:));
n = sqrt(n);

end

function lambda = Metoda_Jacobi_de_aproximare_a_valorilor_proprii(A, eps)

n = size(A, 1);
lambda = zeros(1, n);

while modulMatrice(A) >= eps
    
    M = abs(A);
    M = M - M .* triu(ones(n)); % acum M este o copie a lui A, cu 
    % elemente pozitive care contine numai elementele e sub diagonala
    % principala
    [p, q] = find(M == max(M(:)));
    p = p(1);
    q = q(1);
    if A(p, p) == A(q, q)
        theta = pi / 4;
    else
        theta = 0.5 * atan(2*A(p, q) / (A(q, q) - A(p, p)));
    end
    c = cos(theta);
    s = sin(theta);
    for j = 1 : n
        if j ~= p && j ~= q
            u = A(p, j) * c - A(q, j) * s;
            v = A(p, j) * s + A(q, j) * c;
            A(p, j) = u;
            A(q, j) = v;
            A(j, p) = u;
            A(j, q) = v;
        end
    end
    u = c*c*A(p, p) - 2*c*s*A(p, q) + s*s*A(q, q);
    v = s*s*A(p, p) + 2*c*s*A(p, q) + c*c*A(q, q);
    A(p, p) = u;
    A(q, q) = v;
    A(p, q) = 0;
    A(q, p) = 0;
end

for i = 1 : n
    lambda(i) = A(i, i);
end

end

