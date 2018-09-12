function [A] = genereazaMatrice(n)

A = zeros(n, n+1);
for i = 1 : n
    A(i, i) = 2;
end
for i = 1 : n
    A(i, i + 1) = -1;
end
for i = 2 : n
    A(i, i - 1) = -1;
end

end

