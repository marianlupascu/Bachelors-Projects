
%% best net = patternnet([200, 50], 'traincgf');
%% less then 9.4494 (error)
%% merge si traincgf si traincgp
%%
function [net] = learn(dataTrain, labelTrain)

net = patternnet([200, 50]);
% net.layers{1}.transferFcn = 'logsig';
% net.layers{2}.transferFcn = 'purelin';
net.inputs{1}.processFcns = {'fixunknowns', 'mapstd', 'processpca', 'removeconstantrows'};
net.performFcn = 'crossentropy';
% net.performParam.regularization = 0.5;
% net.performParam.normalization = 'standard';
net.trainParam.epochs = 500;
% net.trainParam.goal = 0.0001;
net.divideFcn = 'dividerand';
net.trainFcn = 'traincgf';
[net,info] = train(net,dataTrain,labelTrain);
a=sim(net,dataTrain);
crossentropy(a,labelTrain);

b = a == max(a);

a = zeros(10, size(labelTrain, 2));
a(b) = 1;
n = 0;
for i = 1:size(labelTrain, 2)
    if sum(a(:, i) ~= labelTrain(:, i)) ~= 0
        n = n + 1;
    end
end

error = n * 100 / size(labelTrain, 2);
error
performance = info.perf(end)

end

