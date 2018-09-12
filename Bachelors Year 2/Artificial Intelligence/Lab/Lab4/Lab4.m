%genera?i o mul?ime de antrenare S = {(xi,ui)}i=1,n con?inând n = 10
%exemple cu ui = sin(2?xi) + ?i.
a = 0;
b = 1;
sigma = 0.01;
n = 10;
f = inline('sin(2*pi*x)', 'x');
S = genereazaExemple(n, f, sigma, a, b)
T = genereazaExemple(n, f, sigma, a, b)
figure;
hold on;
ploteazaExemple(S);
culori = {'r', 'g', 'b', 'm', 'c', 'k', 'y', 'g', 'm', 'c'};

for i = 0 : 9
    
    subplot(3, 4, i+1);
    ploteazaExemple(S);
    title(i);
    P = gasestePolinomOptim(S, i);
    ploteazaGraficPolinom(P, a, b, culori{i+1});
    ES(i+1) = calculeazaEroare(S, P);
    ET(i+1) = calculeazaEroare(T, P);
    
end

figure;
plot(0:9, ES, 'b');
hold on;
plot(0:9, ET, 'r');
legend('eroare antrenare, eroare testare');
axis([0 9 0 10])

