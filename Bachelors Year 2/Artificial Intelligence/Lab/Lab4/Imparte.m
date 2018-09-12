a = 0;
b = 1;
sigma = 0.1;
n = 10;
f = inline('sin(2*pi*x)', 'x');
S = genereazaExemple(n, f, sigma, a, b)
IndTestare = sort(randperm(10, 7))
IndValidare = find((~ismember(1:10, IndTestare)) .* (1:10))
Testare(1, :) = S(1, IndTestare);
Testare(2, :) = S(2, IndTestare);
Testare
Validare(1, :) = S(1, IndValidare);
Validare(2, :) = S(2, IndValidare);
Validare

figure;
hold on;
ploteazaExemple(Testare);
culori = {'r', 'g', 'b', 'm', 'c', 'k', 'y', 'g', 'm', 'c'};

for i = 0 : 7
    
    subplot(3, 3, i+1);
    ploteazaExemple(Testare);
    title(i);
    P = gasestePolinomOptim(Testare, i);
    ploteazaGraficPolinom(P, a, b, culori{i+1});
    
    ES(i+1) = calculeazaEroare(Testare, P);
    ET(i+1) = calculeazaEroare(Validare, P);
    
end

figure;
plot(0:7, ES, 'b');
hold on;
plot(0:7, ET, 'r');
legend('eroare antrenare, eroare testare');
axis([0 7 0 10])

