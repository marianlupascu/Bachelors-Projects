function [timp] = adunaElementePentruTestOptimizat(n)

A = rand(n);
tic;
A
[minim, indice] = min(A(:));
[l, c] = ind2sub(size(A),indice);
l
c
suma = 0;
for i = 1 : l-1
    suma = suma + sum(A(i, :));
end
for i = 1 : c-1
    suma = suma + A(l, i);
end
timp = toc;

end

