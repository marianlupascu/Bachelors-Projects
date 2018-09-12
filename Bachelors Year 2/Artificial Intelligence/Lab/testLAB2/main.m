%%
%genereaza exemple X2
X2 = zeros(4, 4);
L2 = [0,0,1,1];
index = 1;
for i = 1 : 2
    matrice = zeros(2, 2);
    matrice(:, i) = ones(1, 2);
    X2(:, index) = matrice(:);
    index = index + 1;
end
for i = 1 : 2
    matrice = zeros(2, 2);
    matrice(i, :) = ones(1, 2);
    X2(:, index) = matrice(:);
    index = index + 1;
end

%%
% testare perceptron
net = perceptron;
net.layers{1}.transferFcn = 'hardlim';
net = configure(net,X2,L2);
% view(net);
net = init(net);
net.trainParam.epochs = 1000;
[net,antrenare] = train(net,X2,L2);
etichetePrezise = sim(net,X2);
isequal(etichetePrezise,L2)

%%
% clasificare cu un perceptron
P = X2([1:3], :);
ind0 = find(L2 == 0);
ind1 = find(L2 == 1);
figure;
hold on;
plot3(P(1,ind0),P(2,ind0),P(3,ind0),'or');
plot3(P(1,ind1),P(2,ind1),P(3,ind1),'sg');
% un singur perceptron nu poate clasifica corect cele 4 puncte din R^4
% deoarece punctele nu sunt liliar separabile nici macar in R^3 (am facut o
% proiectie pe primele 3 componente), a se vedea figura facuta mai devreme.
% Iar cum punctele proectate in R^3 nu sunt separabile in R^3 rezulta ca nu
% sunt separabile nici in R^4, deoarece deplasand punctele (cele 2) din
% stanga cu 1 pe directia dimensiunii 4 iar cele din dreapta nemiscandu-se
% deoarece au 0 pe componenta a 4-a, acestea vor pastra configuratia de
% liniarneseparabilitate.

%%
% clasificare cu o retea

net = patternnet(10);
%net.performFcn = 'mse';
net.divideFcn = '';
net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc

[net,tr]=train(net,X2,L2);

t2 = sim(net,X2);
isequal(L2, hardlim(t2 - 0.5))

%%
n = 25;
sigma = 0.1;
nrExemple = 500;
[A, B] = genereazaMultimeAntrenare(n);

Train = zeros(size(A, 1), 500);
Label = zeros(1, 500);
index = 1;

for i = 1 : 25 % prima jumate
    for j = 1 : 13
        Train(:, index) = perturbaExemple(A(:, i), sigma);
        Label(1, index) = B(1, i);
        index = index + 1;
    end
end

for i = 26 : 50 % a 2-a jumate
    for j = 1 : 7
        Train(:, index) = perturbaExemple(A(:, i), sigma);
        Label(1, index) = B(1, i);
        index = index + 1;
    end
end

net = patternnet([100, 35]);
net.trainFcn = 'traingdx';
permutare = randperm(size(Train,2));
exemple = Train(:,permutare);
etichete = Label(:,permutare);

net.divideFcn = 'divideind';
net.divideParam.trainInd = permutare(1:round(0.7*nrExemple));
net.divideParam.valInd = permutare(round(0.7*nrExemple)+1:round(0.85*nrExemple));
net.divideParam.testInd = permutare(round(0.85*nrExemple)+1:end);

[net,tr] = train(net,exemple,etichete);

Prezis = net(A);

Prezis = hardlim(Prezis - 0.5);

isequal(Prezis, B)

["rata de misclasare este de " sum(Prezis ~= B) / size(B, 2)]