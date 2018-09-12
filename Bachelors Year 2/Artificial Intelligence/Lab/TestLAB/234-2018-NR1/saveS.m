function [] = saveS()

n = 10;
S = (rand(2, n) * 6) - 3;
T = (-S(1, :)) < S(2, :);
S(3, :) = T;
indPar = 2:2:n;
indImpar = 1:2:n;
S1 = S(:, indImpar);
S2 = S(:, indPar);
save('Sgenerat.mat', 'S');
save('S1generat.mat', 'S1');
save('S2generat.mat', 'S2');

end

