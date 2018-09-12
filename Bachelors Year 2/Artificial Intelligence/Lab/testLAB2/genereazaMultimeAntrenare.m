function [X, L] = genereazaMultimeAntrenare(n)

X = zeros(n*n, 2*n);
L = zeros(1, 2*n);
index = 1;
for i = 1 : n
    matrice = zeros(n, n);
    matrice(:, i) = ones(1, n);
    X(:, index) = matrice(:);
    index = index + 1;
end
for i = 1 : n
    matrice = zeros(n, n);
    matrice(i, :) = ones(1, n);
    X(:, index) = matrice(:);
    index = index + 1;
    L(1, n+i) = 1;
end

end

