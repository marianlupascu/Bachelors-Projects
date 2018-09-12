X = (rand(2, 240) * -50) + 20
T(1, :) = (X(1, :) - X(2, :)) < 0;
T(2, :) = ~T(1, :);
T
ind0 = find(T(1, :) == 0);
ind1 = find(T(1, :) == 1);

hold on;
plot(X(1, ind0), X(2, ind0), 'xr');
plot(X(1, ind1), X(2, ind1), 'og');

net = perceptron;
net.layers{1}.transferFcn = 'hardlim';
net = configure(net,X ,T);
% view(net);

net = init(net);
net.inputWeights{1}.initFcn = 'rands';
net.biases{1}.initFcn = 'rands';

net.inputWeights{1}.learnFcn = 'learnwh';
net.biases{1}.learnFcn = 'learnwh';

disp('Proprietati legate de vectorul de ponderi:');
disp(net.inputWeights{1});
disp('Proprietati legate de bias:');
disp(net.biases{1});

net.trainFcn = 'trainr';

%seteaza numarul de epoci pentru antrenare
net.trainParam.epochs = 1000;
%antreneaza reteaua

net = train(net,X,T);
plotpc(net.IW{1},net.b{1});
net.IW{1},net.b{1}
etichetePrezise = sim(net,X);
isequal(etichetePrezise,T)