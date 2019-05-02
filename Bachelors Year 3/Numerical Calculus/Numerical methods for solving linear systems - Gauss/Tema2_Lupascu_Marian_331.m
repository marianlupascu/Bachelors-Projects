%%
% 1
% Sa se rezolve manual conform algoritmilor: metoda Gauss fara pivotare, metoda Gauss cu
% pivotare partiala si metoda Gauss cu pivotare totala urmatoarele sisteme:
% S1 : 
% x2 + x3 = 3
% 2*x1 + x2 + 5*x3 = 5
% 4*x1 + 2*x2 + x3 = 1
% 
% S2 :
% x2 - 2x3 = 4
% x1 - x2 + x3 = 6
% x1 - x3 = 2
% Rezolvare: pe hartie

%%
% 2
% Sa se construiasca in Matlab procedura SubsDesc conform sintaxei x=SubsDesc(A; b) care re-
% zolva numeric sisteme liniare superior triunghiulare conform Algoritmului (metoda substitutiei
% descendente).
% Rezolvare: vezi sectiunea de functii de la finalul script-ului

%%
% 3
% a. 
% Sa se construiasca in Matlab trei proceduri GaussFaraPiv, GaussPivPart si GaussPiv-
% Tot conform sintaxelor:
% [x] = GaussFaraPiv(A; b)
% [x] = GaussPivPart(A; b)
% [x] = GaussPivTot(A; b)
% care returneaza solutia sistemului Ax = b conform metodelor de eliminare Gauss fara
% pivotare, Gauss cu pivotare partiala si respectiv, Gauss cu pivotare totala;
% Rezolvare: vezi sectiunea de functii de la finalul script-ului

%%
% b. 
% Sa se apeleze procedurile pentru sistemele de la Ex. 1, apeland cele trei fisiere create la
% subpunctul a:

S1 = [0 1 1; 2 1 5; 4 2 1];
s1 = [3 5 1];

S2 = [0 1 -2; 1 -1 1; 1 0 -1];
s2 = [4 6 2];

disp("GaussFaraPiv Sist1");
x11 = GaussFaraPiv(S1, s1)
disp("GaussFaraPiv Sist2");
x21 = GaussFaraPiv(S2, s2)

disp("GaussPivPart Sist1");
x12 = GaussPivPart(S1, s1)
disp("GaussPivPart Sist2");
x22 = GaussPivPart(S2, s2)

disp("GaussPivTot Sist1");
x13 = GaussPivTot(S1, s1)
disp("GaussPivTot Sist2");
x23 = GaussPivTot(S2, s2)

%%
% c.
% Sa se aplice:
% - Metodele Gauss fara pivotare si cu pivotare partiala pentru sistemul
% S3 : 
% eps*x1 + x2 = 1
% x1 + x2 = 2
% unde eps = O(10^-20) << 1.
% 
% - Metodele Gauss cu pivotare partiala si cu pivotare totala pentru sistemul
% S4 :
% x1 + C*x2 = C
% x1 + x2 = 2
% unde C = O(10^20) >> 1.
% 
% - Verificati in Matlab solutiile si comparati metodele.

eps = 10^(-20);
S3 = [eps 1; 1 1];
s3 = [1 2];
disp("GaussFaraPiv Sist3");
x31 = GaussFaraPiv(S3, s3)
disp("GaussPivPart Sist3");
x32 = GaussPivPart(S3, s3)
% Se observa ca GaussPivPart e mai general ca GaussPivPart

C = 10^20;
S4 = [1 C; 1 1];
s4 = [C 2];
disp("GaussPivPart Sist4");
x41 = GaussPivPart(S4, s4)
disp("GaussPivTot Sist4");
x42 = GaussPivTot(S4, s4)
% Se observa ca GaussPivTot e mai general ca GaussPivPart
% Deci cel mai bun algoritm este GaussPivTot.

%% -----------------------------------------
%  -----------   FUNCTII   -----------------
%  -----------------------------------------

% 2)
function x=SubsDesc(A, b)

n = size(A, 1);
x = zeros(1, n);
for i = n:-1:1
    
    a = b(i) - x(i+1:n)*A(i,i+1:n)';
    x(i) = a/A(i, i);
end

end

% 3) a)
function x = GaussFaraPiv( A, b )

n = size(A, 1);
A = [A, b'];
x = zeros(1, n);
for k = 1:n-1
    
	ind = find(A(k:n, k)~=0);
    if isempty(ind)
        
        disp("Compatibil nedeterminat");
        return ;
    end
    ind(1) = ind(1) + k -1;
    p = ind(1);
    if p ~= k
        
        c = A(k, :);
        A(k, :) = A(p, :);
        A(p, :) = c';
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

x = SubsDesc(A(:, 1:n), A(:, n+1));

end

function x = GaussPivPart( A, b )

n = size(A, 1);
A = [A, b'];
x = zeros(1, n);
for k = 1:n-1
    
	ind = find(A(k:n, k)==max(abs(A(k:n, k))));
    if isempty(ind)
        
        disp("Compatibil nedeterminat");
        return ;
    end
    ind(1) = ind(1) + k -1;
    p = ind(1);
    if p ~= k
        
        c = A(k, :);
        A(k, :) = A(p, :);
        A(p, :) = c';
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

x = SubsDesc(A(:, 1:n), A(:, n+1));

end

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
