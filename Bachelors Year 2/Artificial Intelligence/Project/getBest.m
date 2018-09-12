function [cellNet] = getBest(dataTrain, labelTrain)

for j = 1 : 50
    net = patternnet([600, 150, 35]);
    % net.layers{1}.transferFcn = 'logsig';
    % net.layers{2}.transferFcn = 'purelin';
    net.inputs{1}.processFcns = {'fixunknowns', 'mapstd'};
    net.performFcn = 'crossentropy';
    net.trainParam.epochs = 5000;
    % net.trainParam.goal = 0.0001;
    net.divideFcn = 'dividerand';
    % net.trainFcn = 'trainscg';
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
    cellNet(j, 1) = {j};
    cellNet(j, 2) = {[600, 150, 35]};
    cellNet(j, 3) = {error};
    cellNet(j, 4) = {info.perf(end)};
    cellNet(j, 5) = {net};
    save(['net600-150-35-de-' int2str(j) '.mat'],'net');
end

for j = 51 : 100
    net = patternnet([600, 150, 50]);
    % net.layers{1}.transferFcn = 'logsig';
    % net.layers{2}.transferFcn = 'purelin';
    net.inputs{1}.processFcns = {'fixunknowns'};
    net.performFcn = 'crossentropy';
    net.trainParam.epochs = 5000;
    % net.trainParam.goal = 0.0001;
    net.divideFcn = 'dividerand';
    % net.trainFcn = 'trainscg';
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
    cellNet(j, 1) = {j};
    cellNet(j, 2) = {[600, 150, 50]};
    cellNet(j, 3) = {error};
    cellNet(j, 4) = {info.perf(end)};
    cellNet(j, 5) = {net};
    save(['net600-150-50-de-' int2str(j) '.mat'],'net');
end

for j = 101 : 150
    net = patternnet([600, 250, 35]);
    % net.layers{1}.transferFcn = 'logsig';
    % net.layers{2}.transferFcn = 'purelin';
    net.inputs{1}.processFcns = {'fixunknowns'};
    net.performFcn = 'crossentropy';
    net.trainParam.epochs = 5000;
    % net.trainParam.goal = 0.0001;
    net.divideFcn = 'dividerand';
    % net.trainFcn = 'trainscg';
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
    cellNet(j, 1) = {j};
    cellNet(j, 2) = {[600, 250, 35]};
    cellNet(j, 3) = {error};
    cellNet(j, 4) = {info.perf(end)};
    cellNet(j, 5) = {net};
    save(['net600-250-35-de-' int2str(j) '.mat'],'net');
end

for j = 151 : 200
    net = patternnet([400, 150, 35]);
    % net.layers{1}.transferFcn = 'logsig';
    % net.layers{2}.transferFcn = 'purelin';
    net.inputs{1}.processFcns = {'fixunknowns'};
    net.performFcn = 'crossentropy';
    net.trainParam.epochs = 5000;
    % net.trainParam.goal = 0.0001;
    net.divideFcn = 'dividerand';
    % net.trainFcn = 'trainscg';
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
    cellNet(j, 1) = {j};
    cellNet(j, 2) = {[400, 150, 35]};
    cellNet(j, 3) = {error};
    cellNet(j, 4) = {info.perf(end)};
    cellNet(j, 5) = {net};
    save(['net400-150-35-de-' int2str(j) '.mat'],'net');
end

for j = 201 : 225
    net = patternnet([700, 200, 40]);
    % net.layers{1}.transferFcn = 'logsig';
    % net.layers{2}.transferFcn = 'purelin';
    net.inputs{1}.processFcns = {'fixunknowns'};
    net.performFcn = 'crossentropy';
    net.trainParam.epochs = 5000;
    % net.trainParam.goal = 0.0001;
    net.divideFcn = 'dividerand';
    % net.trainFcn = 'trainscg';
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
    cellNet(j, 1) = {j};
    cellNet(j, 2) = {[700, 200, 40]};
    cellNet(j, 3) = {error};
    cellNet(j, 4) = {info.perf(end)};
    cellNet(j, 5) = {net};
    save(['net700-200-40-de-' int2str(j) '.mat'],'net');
end

for j = 226 : 250
    net = patternnet([700, 350, 45]);
    % net.layers{1}.transferFcn = 'logsig';
    % net.layers{2}.transferFcn = 'purelin';
    net.inputs{1}.processFcns = {'fixunknowns'};
    net.performFcn = 'crossentropy';
    net.trainParam.epochs = 5000;
    % net.trainParam.goal = 0.0001;
    net.divideFcn = 'dividerand';
    % net.trainFcn = 'trainscg';
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
    cellNet(j, 1) = {j};
    cellNet(j, 2) = {[700, 350, 45]};
    cellNet(j, 3) = {error};
    cellNet(j, 4) = {info.perf(end)};
    cellNet(j, 5) = {net};
    save(['net700-350-45-de-' int2str(j) '.mat'],'net');
end

end

