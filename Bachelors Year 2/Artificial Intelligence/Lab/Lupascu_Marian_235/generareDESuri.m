function [] = generareDESuri()

n = 40;
S = ((rand(2, n)) * 6) - 3;
T = (-S(1, :)) < S(2, :);
S(3, :) = T;
save('Sgenerat.m', 'S');

indPoz = find(S(2, :) > 0);
indNeg = find(S(2, :) <= 0);

S1 = S(:, indPoz);
S2 = S(:, indNeg);

save('S1generat.m', 'S1');
save('S2generat.m', 'S2');

% ind1 = find(S1(3, :) == 1);
% ind0 = find(S1(3, :) == 0);
% figure(1);
% hold on;
% axis([-3 3 -3 3]);
% plot(S1(1, ind1), S1(2, ind1), '+g');
% plot(S1(1, ind0), S1(2, ind0), 'or');

end

