%%
%punctele a si b rezolvate in functia generareDESuri()
generareDESuri();

%%
%incarcarea datelor pentru viitoarele puncte
load('S', 'S');
load('S1', 'S1');
load('S2', 'S2');
S, S1, S2

%%
%punctul c
ind1 = find(S1(3, :) == 1);
ind0 = find(S1(3, :) == 0);
figure(1);
hold on;
axis([-3 3 -3 3]);
plot(S1(1, ind1), S1(2, ind1), '+g');
plot(S1(1, ind0), S1(2, ind0), 'or');
xlabel('x');
ylabel('y');

%%
%punctul d
R = perceptron;
R.layers{1}.transferFcn = 'hardlim';
R = configure(R,S1([1, 2], :), S1(3, :));
view(R);

R = init(R);
R.trainParam.epochs = 100;

[R, antrenare] = train(R,S1([1, 2], :),S1(3, :));

%%
%punctul e

plotpc(R.IW{1},R.b{1});
title('Reprezentarea grafica a exemplelor de antrenare si a dreptei de separare');
etichetePrezise = sim(R,S1([1, 2], :));
isequal(etichetePrezise,S1(3, :))
R.IW{1},R.b{1}

%%
% punctul f
%la acest punct puteam include punctele d si e, dar deja le-am scis :)
clear R;

R = perceptron;
R.layers{1}.transferFcn = 'hardlim';
R = configure(R,S1([1, 2], :), S1(3, :));

R = init(R);
R.trainParam.epochs = 1;

%optional pentru a vedea diferit garficul eroarii
R.inputWeights{1}.initFcn = 'rands';
R.biases{1}.initFcn = 'rands';

epocaCurenta = 1;
err = [];
    while epocaCurenta <= 100
        wold = R.IW{1};
        bold = R.b{1};
        
        [R,antrenare] = train(R,S1([1, 2], :), S1(3, :));
        
        w = R.IW{1};
        b = R.b{1};
        
        if isequal(wold, w) && isequal(bold, b)
            break;
        end
        
        aux = sim(R,S1([1, 2], :)) ~= S1(3, :);
        greseste = sum(aux)
        
        err(epocaCurenta) = greseste / size(S1, 2);
        epocaCurenta = epocaCurenta + 1;
    end
figure(2);
plot(err);
axis([1 epocaCurenta 0 max(err) + 0.1])
xlabel('numarul de epoci');
ylabel('eroarea de la epoca curenta'); 
title('Graficul erorii perceptronului R pe S2');
%pe axa Ox avem numarul de epoci
%pe axa Oy avem eroarea de la epoca x

%%
%punctul g
sim(R,[-1; 1])
%il pune in clasa 1

%%
%punct h

aux = sim(R,S2([1, 2], :)) ~= S2(3, :);
eroarePeS2 = sum(aux) / size(S2, 2)

%plotez S2 si dreapta de separare invatata de R pe S1
figure();
plotpv(S2([1, 2], :), S2(3, :));
axis([-3 3 -3 3]);
xlabel('x');
ylabel('y');
title('Punctele din clasa S2');

plotpc(R.IW{1}, R.b{1});
%rata de misclasare este de 0.2143 pentru initFcn = 'rands' pentru
%inputWeights si bias
%rata de miscalasare poate fi si de 50% (0.5) in momentul in care S1 nu este
%reprezentativa pentru S (in particulr pentru S2). Exemplu de caz in care
%avem o misclasare de 50% este atunci cand intr-un grid de (0,4)x(0,4)
%multimea de antrenare S1 se imparte in 2 calse 0 si 1 acestea fiind
%distribuite astfel: toate punctele cu clasa 1 ingramadite intr-un clauster
%in zona (4,4) si toate puntele de clasa 0 in zona (0, 0), in acest caz un 
% perceptron poate invata se le separe cu o dreapta paralela cu Ox ce trece 
% prin 2. Iar multimea S2 sa aibe toate punctele forte aproape de a doua
% bistectoare. In acest caz pentru cardinal de S2 care tinde la infinit
% eroarea de misclasare va fi de 50%. Bine inteles pot exista cazuri si mai
% extreme.


%%
%punctul i

eticheta =  -S1(1, :) - S1(2, :)
%alegerea preprezinta suma x + y luata cu semn schimbat deoarece un punct
%de afla desupra fiagonalei secundare daca x+y > 0 si dedesupt daca
%x+y<0. Iar eticheta reprezinta un vector cu + pentru punctele de dedesupt
%si cu - pentru cele de deasupra.

S3 = S1([1,2], :);
S3(3, :) = eticheta;

net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,S1([1, 2], :),eticheta);
%antrenare batch pentru cazul general
net.trainFcn = 'trainb';
net.inputWeights{1}.initFcn = 'rands';
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biases{1}.initFcn = 'rands';
net.biases{1}.learnFcn = 'learnwh';
net.biases{1}.learnParam.lr = 0.001;
net.trainParam.epochs = 1000;

net = train(net,S1([1, 2], :),eticheta);
dreaptaWH1 = plotpc(net.IW{1},net.b{1});
set(dreaptaWH1,'color','m','linewidth',5);
net.IW{1},net.b{1}
%obtinem IW(1) = -1.0000  si  -0.9995 si
%b = -9.1268e-04 ceea ce inseamna o dreapata de ecuatie -x -0,9995y + b = 0
% cum b este extrem de mic aproape 0 avem dreapta x = -0,9995y ceea ce
% aproximeaza foarte bine a doua bisectoare.

etichetePrezise = sim(net,S2([1, 2], :)) < 0
isequal(etichetePrezise,S2(3, :))

figure(1);
hold on;
dreaptaWH = plotpc(net.IW{1},net.b{1});
set(dreaptaWH,'color','m','linewidth',5);
legend('exemplele din clasa 1','exemplele din clasa 0',...
    'dreapta de separare data de R','dreapta de separare pentru cazul batch data de net pentru algoritmul WH');

