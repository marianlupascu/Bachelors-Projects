S = [0 0 0; 
     0 0 1;
     0 1 0;
     0 1 1;
     1 0 0;
     1 0 1;
     1 1 0;
     1 1 1];
F1 = S(:, 2) & (S(:, 1) | (~S(:, 1) & S(:, 3)));
F2 = (S(:, 1) & S(:, 2)) | (S(:, 1) | (~S(:, 1) & S(:, 2)));
F3 = (S(:, 1) & ~S(:, 2)) | (~S(:, 1) & S(:, 2) & S(:, 3));

%%
%cazul F1
ind0 = find(F1 == 0);
ind1 = find(F1 == 1);
hold on;
axis([-0.5 1.5 -0.5 1.5 -0.5 1.5]);
plot3(S(ind0, 1), S(ind0, 2), S(ind0, 3), 'or');
plot3(S(ind1, 1), S(ind1, 2), S(ind1, 3), 'xg');

net = perceptron;
net.layers{1}.transferFcn = 'hardlim';
net = configure(net,S.',F1.');
% view(net);

net = init(net);
net.inputWeights{1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';

net.inputWeights{1}.learnFcn = 'learnpn';
net.biases{1}.learnFcn = 'learnpn';

disp('Proprietati legate de vectorul de ponderi:');
disp(net.inputWeights{1});
disp('Proprietati legate de bias:');
disp(net.biases{1});

net.trainFcn = 'trainr';

%seteaza numarul de epoci pentru antrenare
net.trainParam.epochs = 1000;
%antreneaza reteaua

net = train(net,S.',F1.');
plotpc(net.IW{1},net.b{1});
net.IW{1},net.b{1}
etichetePrezise = sim(net,S.');
isequal(etichetePrezise,F1.')

%%
%cazul F2
ind0 = find(F2 == 0);
ind1 = find(F2 == 1);
figure(2);
hold on;
axis([-0.5 1.5 -0.5 1.5 -0.5 1.5]);
plot3(S(ind0, 1), S(ind0, 2), S(ind0, 3), 'or');
plot3(S(ind1, 1), S(ind1, 2), S(ind1, 3), 'xg');

clear net
net = perceptron;
net.layers{1}.transferFcn = 'hardlim';
net = configure(net,S.',F2.');
% view(net);

net = init(net);
net.inputWeights{1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';

net.inputWeights{1}.learnFcn = 'learnpn';
net.biases{1}.learnFcn = 'learnpn';

disp('Proprietati legate de vectorul de ponderi:');
disp(net.inputWeights{1});
disp('Proprietati legate de bias:');
disp(net.biases{1});

net.trainFcn = 'trainr';

%seteaza numarul de epoci pentru antrenare
net.trainParam.epochs = 1000;
%antreneaza reteaua

net = train(net,S.',F2.');
plotpc(net.IW{1},net.b{1});
net.IW{1},net.b{1}
etichetePrezise = sim(net,S.');
isequal(etichetePrezise,F2.')

%%
%cazul F3
ind0 = find(F3 == 0);
ind1 = find(F3 == 1);
figure(3);
hold on;
axis([-0.5 1.5 -0.5 1.5 -0.5 1.5]);
plot3(S(ind0, 1), S(ind0, 2), S(ind0, 3), 'or');
plot3(S(ind1, 1), S(ind1, 2), S(ind1, 3), 'xg');

clear net
net = perceptron;
net.layers{1}.transferFcn = 'hardlim';
net = configure(net,S.',F3.');
% view(net);

net = init(net);
net.inputWeights{1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';

net.inputWeights{1}.learnFcn = 'learnpn';
net.biases{1}.learnFcn = 'learnpn';

disp('Proprietati legate de vectorul de ponderi:');
disp(net.inputWeights{1});
disp('Proprietati legate de bias:');
disp(net.biases{1});

net.trainFcn = 'trainr';

%seteaza numarul de epoci pentru antrenare
net.trainParam.epochs = 1000;
%antreneaza reteaua

net = train(net,S.',F3.');
plotpc(net.IW{1},net.b{1});
net.IW{1},net.b{1}
etichetePrezise = sim(net,S.');
isequal(etichetePrezise,F3.')
