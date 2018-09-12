function [] = fold_cross_validation(dataTrain, labelTrain)

for i = 1 : 10
    
    newTrain = zeros(size(dataTrain, 1), floor(size(dataTrain, 2) * 0.9));
    newLabel = zeros(size(dataTrain, 1), floor(size(dataTrain, 2) * 0.1));
    
    newDataTest = dataTrain(:, [(i-1)*floor(size(dataTrain, 2) * 0.1) + 1 : i*floor(size(dataTrain, 2) * 0.1)]);
    newLabelTest = labelTrain(:, [(i-1)*floor(size(labelTrain, 2) * 0.1) + 1 : i*floor(size(labelTrain, 2) * 0.1)]);
    
    newTrain = [dataTrain(:, [1:(i-1)*floor(size(dataTrain, 2) * 0.1)]) ...
                dataTrain(:, [i*floor(size(dataTrain, 2) * 0.1) + 1:end])];
    newLabel = [labelTrain(:, [1:(i-1)*floor(size(labelTrain, 2) * 0.1)]) ...
                labelTrain(:, [i*floor(size(labelTrain, 2) * 0.1) + 1:end])];
            
            size(newTrain);
    
    net = learn(newTrain, newLabel);
    figure(i);
    plotconfusion(newLabelTest, net(newDataTest));
end

end

