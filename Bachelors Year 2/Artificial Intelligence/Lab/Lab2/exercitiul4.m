v = [1 10 50 100 250 500 750 1000];
Timplicit = zeros(1, length(v));
Tdefinit = zeros(1, length(v));

for i = 1 : length(v)
    [a, b] = inmultireDeMatrici(v(i));
    Timplicit(i) = a;
    Tdefinit(i) = b;
end

subplot(2,2,1);
title('Graficul timpului de inmultira predefinita');
semilogx(v, Tdefinit);
xlabel('dimensiunea matricei');
ylabel('secunde');
subplot(2,2,2);
title('Graficul timpului de inmultira definita');
semilogx(v, Timplicit, '-r');
xlabel('dimensiunea matricei');
ylabel('secunde');
subplot(2,2,[3 4]);
hold on;
title('Graficul timpului de inmultire predefinita (cu rosu) si definita de mine (cu albastru)')
plot(v,Tdefinit);
plot(v,Timplicit, '-r');
xlabel('dimensiunea matricei');
ylabel('secunde');
hold off;
