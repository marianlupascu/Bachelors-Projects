function [net] = deeplearning(dataTrain, labelTrain)
%%
% test deep network
% deeplearning(dataTrain, newLabelTrain);

for i = 0 : 9 
    
    index = find(labelTrain == i);
    for j = 1 : 30 
        TF = isnan(dataTrain(j, index));
        index2 = find(TF == 1);
        media = nanmean(dataTrain(j, index));
        dataTrain(j, index(index2)) = media;
    end
end

inputSize = 30;
outputSize = 100;
outputMode = 'last';
numClasses = 10;
layers = [ ...
    sequenceInputLayer(inputSize)
    lstmLayer(150,'OutputMode',outputMode)
    fullyConnectedLayer(numClasses)
    softmaxLayer
    classificationLayer];

maxEpochs = 50;
miniBatchSize = 200;

options = trainingOptions('sgdm', ...
    'ExecutionEnvironment','cpu', ...
    'MaxEpochs',maxEpochs, ...
    'MiniBatchSize',miniBatchSize, ...
    'InitialLearnRate',0.001, ...
    'Verbose',0, ...
    'Plots','training-progress');

newDataTrain = {};
for i = 1 : size(dataTrain, 2) 
    newDataTrain(i) = {dataTrain(:, i)};
end

newDataTrain = newDataTrain';

label = categorical(labelTrain);
label = label';

net = trainNetwork(newDataTrain(1:end),label(1:end) ,layers,options);

YPred = classify(net,newDataTrain(20001:end));
YTest = label(20001:end);

accuracy = sum(YPred == YTest)/numel(YTest)

end

