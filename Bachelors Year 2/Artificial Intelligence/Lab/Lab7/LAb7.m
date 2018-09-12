clear all, close all
%datele: exemplele + etichetele
X = [0 0 0 0.5 0.5 0.5 1 1 -50;0 0.5 1 0 0.5 1 0 0.5 90];
T = [1 1 1 1 -1 -1 -1 -1 1];
%reprezentare grafica a datelor
figure(1), hold on;
eticheta1 = find(T==1);
etichetaMinus1 = find(T==-1);
plot(X(1,eticheta1),X(2,eticheta1),'or');
plot(X(1,etichetaMinus1),X(2,etichetaMinus1),'xg');
axis([-0.5 1.5 -0.5 1.5]);
%pune pauza 2 secunde
pause(1);
%creeaza perceptron
net = perceptron;
%modifica functia de transfer – din hardlim in hardlims
net.layers{1}.transferFcn = 'hardlims';
%configureaza perceptron pe baza datelor de intrare si iesire
net = configure(net,X,T);
%view(net);
%afiseaza proprietatile perceptronului legate de vectorul de ponderi + bias
disp('Proprietati legate de vectorul de ponderi:');
disp(net.inputWeights{1});
disp('Proprietati legate de bias:');
disp(net.biases{1});
%initializeaza parametri retelei
net = init(net);
% implicit ponderile + bias sunt nule (de la initzero)
net.inputWeights{1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';

net.inputWeights{1}.learnFcn = 'learnpn';
net.biases{1}.learnFcn = 'learnpn';

disp('Proprietati legate de vectorul de ponderi:');
disp(net.inputWeights{1});
disp('Proprietati legate de bias:');
disp(net.biases{1});

net.trainFcn = 'trainb';

disp(net.IW{1}), disp(net.b{1})
%seteaza numarul de epoci pentru antrenare
net.trainParam.epochs = 1000;
%antreneaza reteaua

[net,antrenare] = train(net,X,T);
figure(1);
%ploteaza dreapta de separare
plotpc(net.IW{1},net.b{1})
title('Reprezentarea grafica a exemplelor de antrenare si a dreptei de separare');
%simuleaza reteaua pentru datele de intrare
etichetePrezise = sim(net,X);
isequal(etichetePrezise,T)