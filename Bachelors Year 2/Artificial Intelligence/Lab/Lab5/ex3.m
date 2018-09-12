function Y = ex3(n)

Y = rand(2, n) * 2;
Y = Y - 1;
Y(3, :) = Y(1, :) - Y(2, :) >= 0;

poz = find(Y(3, :) > 0);
neg = find(Y(3, :) <= 0);

figure;
hold on;
plot(Y(1, poz), Y(2, poz), 'og');
plot(Y(1, neg), Y(2, neg), 'xb');
hold off;

end

