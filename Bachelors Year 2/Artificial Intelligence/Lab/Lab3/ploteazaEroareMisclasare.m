function ploteazaEroareMisclasare( c )

n = [10, 50, 100, 500, 1000, 2000, 3000, 4000, 5000, 6000, 7000, 10000, 100000, 1000000];
for i = 1 : length(n)
    [x, y] = genereazaMultimeAntrenare(n(i), c);
    E(i) = calculeazaEroareMisclasare(x, c);
end
semilogx(n, E, 'r');
end

