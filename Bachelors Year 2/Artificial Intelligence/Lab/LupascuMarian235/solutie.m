
%%
% a
generare();

%%
% b
% Plota?i punctele mul?imii S reprezentând cu ‘+’ si culoarea
% rosie punctele cu eticheta 1 ?i cu ‘o‘ si albastru punctele cu eticheta 0.
% Seta?i limitele graficului la [-10 10 -1 1]. Salva?i figura în fi?ierul
% fig1.fig.
load('S.mat');

ind1 = find(t == 1);
ind0 = find(t == 0);
figure(1);
hold on;
axis([-10 10 -1 1]);
plot(P(1, ind1), P(2, ind1), '+r');
plot(P(1, ind0), P(2, ind0), 'ob');
xlabel('x');
ylabel('y');

%%
% c
% Ati putea folosi un perceptron antrenat cu algoritmul lui
% Rosenblatt pentru a învã?a perfect mul?imea S? Justifica?i rãspunsul în
% comentarii.

%din plotul de la punctul b se poate observa cu usurinta ca cele doua clase
%nu sunt liniar separabile deci in consecinta nu se poate antrena un 
%perceptron cu algoritmul lui Rosenblatt pentru a învã?a perfect mul?imea
%S, deoarece casa 1 si clasa 0 nu sunt liniar separabile

%%
% d
% Defini?i re?eaua net1 de perceptroni multistrat de tip
% patternnet. Re?eaua net1 va avea 5 perceptroni cu func?ia de transfer
% logsig pe singurul strat ascuns ?i cu func?ia de antrenare datã de
% algoritmul Levenberg-Marquardt aplicatã pentru func?ia obiectiv suma
% pãtratelor erorilor (‘mse’);
net1 = patternnet(5);
net1.layers{1:2}.transferFcn = 'logsig';
% net1.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
% net1.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
net1.trainFcn = 'trainlm';
net1.performFcn = 'mse';
view(net1);

%%
% e
% Antrenati re?eaua net1 de la d) pe mul?imea S în care folositi
% 80% din datele din S pentru antrenare, 10% pentru validare, 10%
% pentru testare;
nrExemple = size(P,2);
permutare = randperm(nrExemple);
exemple = P(:,permutare);
etichete = t(:,permutare);

net1.divideFcn = 'divideind';
net1.divideParam.trainInd = permutare(1:round(0.8*nrExemple));
net1.divideParam.valInd = permutare(round(0.8*nrExemple)+1:round(0.9*nrExemple));
net1.divideParam.testInd = permutare(round(0.9*nrExemple)+1:end);

[net1,tr1] = train(net1,exemple,etichete);

%%
% f
% Afi?ati performan?a re?elei net1 pe multimile de antrenare,
% validare, testare;
figure(2);
plotperform(tr1);
tr1.perf(end) % antrenare
tr1.vperf(end) % verificate
tr1.tperf(end) % testare

%%
% g
% Reluati punctele d-f pentru reteaua net2 de perceptroni
% multistrat de tip patternnet cu 25 perceptroni cu functia de transfer
% logsig pe singurul strat ascuns si cu functia de antrenare data de
% algoritmul Levenberg-Marquardt aplicatã pentru func?ia obiectiv suma
% pãtratelor erorilor (‘mse’). Antrena?i net2 pe aceea?i partii?e a mul?imii
% S folositã la punctual e);
net2 = patternnet(25);
net2.layers{1:2}.transferFcn = 'logsig';
% net1.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
% net1.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
net2.trainFcn = 'trainlm';
net2.performFcn = 'mse';
view(net2);

% nu modific permutarea, deci am acceiasi partitie
net2.divideFcn = 'divideind';
net2.divideParam.trainInd = permutare(1:round(0.8*nrExemple));
net2.divideParam.valInd = permutare(round(0.8*nrExemple)+1:round(0.9*nrExemple));
net2.divideParam.testInd = permutare(round(0.9*nrExemple)+1:end);

[net2,tr2] = train(net2,exemple,etichete);
figure(3);
plotperform(tr2);
tr2.perf(end) % antrenare
tr2.vperf(end) % verificate
tr2.tperf(end) % testare

%%
% h
% Alege?i dintre net1 ?i net2 re?eaua care are performan?a cea
% mai bunã pe mul?imea de testare (10% din S folositã mai sus). Numi?i
% aceastã re?ea net3.

% Am apes reteaua net2 deoarece dupa aproximativ 10 rulari, aceasta obtine
% o performatnta comparativ mai buna cu reteaua net1
net3 = net2;

% puteam sa fac si 
% % % % % % % % % if tr1.tperf(end) > tr2.tperf(end)
% % % % % % % % %     net3 = net2;
% % % % % % % % % else
% % % % % % % % %     net3 = net1;
% insa e irelevant daca se testeaza o singura data

%%
% i
% Construiti re?eaua net4 echivalentã cu net3 (implementeazã
% aceea?i func?ie) cu arhitectura similara cu net3 însã cu func?ia de
% transfer tansig (în loc de logsig) pentru perceptronii de pe stratul
% ascuns. Seta?i manual ponderile ?i bias-urile corespunzãtoare fiecãrui
% strat din net4 folosind identitatea tansig(x) = 2*logsig(2*x) - 1.

net4 = net3;
net4.layers{1}.transferFcn = 'tansig';
view(net4);
% vreau logsig(x) = y, unde x reprezinta o pondere din reteaua net3, pe
% stratul ascuns
% vreau tansig(z) = y, unde z reprezinta o pondere din reteaua net4, pe
% stratul ascuns
% atunci logsig(x) = tansig(z)
% logsig(x) = 2logsig(2*z) -1
% atunci z = (logsig^-1((logsig(x)+1)/2))/2
% cum logsig(x) = 1 / 1 + exp(-x)
% atunci logsig^-1(x) = -ln(1-x/x)
% atunci obtin:
% z = -ln(1-(alfa))/2*(alfa), unde alfa = (logsig(x)+1)/2
alfa = (logsig(net4.IW{1:1})+1)/2; % in acest moment net4.IW{1:1} este = 
% cu net3.IW{1:1}
net4.IW{1:1} = -log(((1-alfa)./alfa)/2);
% metionez ca la un plot perf dupa un train pe net4, este posibil ca
% performanta sa difere pe net4, comparativ cu net3, datorita
% initializarilor si a preprocesarilor