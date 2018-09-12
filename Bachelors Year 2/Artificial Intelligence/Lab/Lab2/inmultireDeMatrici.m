function [Timplicit, Tdefinit] = inmultireDeMatrici(dim)

A = rand(dim);
B = rand(dim);
tic;
C = A * B;
Timplicit = toc;

C = zeros(dim);
tic;
for i = 1 : dim
    for j = 1 : dim
        for k = 1 : dim
            C(i, j) = C(i, j) + A(i, k) * B(k, j);
        end
    end
end
Tdefinit = toc;
end

