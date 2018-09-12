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

%%
%punctul 2 solutia ecuatiei generale
M = [ones(1,size(S.',2)); S.'];
beta = (M*M')\M *F1;
bstar = beta(1);
wstar = beta(2:end);


%%
%punctul 3
%creare perceptron cu functia de transfer purelin
et = newp([0 1; 0 1; 0 1], 1);
net.trainParam.epochs = 200;
net.iw{1, 1} = [3 3 3];
net = train(net, S', F2');

figure(2);
plotpv(S', F2')
plotpc(net.IW{1}, net.b{1})
