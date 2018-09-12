P = [-2 -2 -1 -1 0 0 0 0 1 1 2 2 3 3 3 3 4 4 5 5;...
2 3 1 4 0 1 2 3 0 1 1 2 -1 0 1 2 -2 1 -1 0];
T  = [-1 -1 -1 -1 -1 -1 -1 -1 1 -1 1 -1 1 1 1 1 1 1 1 1];
ind1 = find(T == 1);
figure, plot(P(1,ind1),P(2,ind1),'sg');hold on;
ind2 = find(T == -1);
plot(P(1,ind2),P(2,ind2),'or');hold on;
axis([-3 6 -3 5]);


X = [ones(1, size(P, 2)); P];
beta = inv(X*X')*X*T';
betastar = beta(1)
wstar = beta(2:3)

plotpc(wstar', betastar);

net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,P,T);
net.inputWeights{1}.learnFcn = 'learnwh';
net.biases{1}.learnFcn = 'learnwh';
net.trainParam.epochs = 1000;
net.trainParam.lr = 0.005;
net.trainFcn = 'trainb';
net.biasConnect = 0;

net = train(net,P,T);
net.IW{1}
net.b{1}

hPlot = plotpc(net.IW{1, 1}, net.b{1});
set(hPlot, 'Color', 'r');

wstar = inv(P*P')*P*T'


[x, y] = meshgrid(-0.7:0.01:0.7);
J = zeros(size(x));
for i = 1 : size(x, 1)
    for j = 1 : size(x, 2)
        w = [x(i, j) y(i, j)];
        J(i, j) = 0.5*sum((w*P-T).^2);
    end
end
figure;
surf(x,y,J);
