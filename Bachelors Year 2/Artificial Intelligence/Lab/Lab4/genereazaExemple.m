function S = genereazaExemple(n, f, sigma, a, b)

S = zeros(2, n);
S(1, :) = sort(rand(1, n))
eps = randn(1, n) * sigma;

S(2, :) = f(S(1, :)) + eps;

end

