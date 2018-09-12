function [X, Y] = genereazaMultimeAntrenare(n, c)

X = zeros(1, n);
Y = zeros(1, n);

X = rand(1, n) * 4 * c;
Y = X ./ (X + c)
mare = Y>1/2;
mic = Y <= 1/2;
Y(mare) = 1;
Y(mic) = 0;

end

