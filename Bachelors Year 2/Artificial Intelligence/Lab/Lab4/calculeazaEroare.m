function e = calculeazaEroare(S, P)

prezis = polyval(P, S(1, :));
u = S(2, :);
e = sum((prezis - u).^2);

end

