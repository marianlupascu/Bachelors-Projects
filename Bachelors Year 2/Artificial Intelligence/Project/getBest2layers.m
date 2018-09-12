function [cellNet] = getBest2layers(dataTrain, labelTrain)

maxLayer1 = 800;
maxLayer2 = 300;
maxIteration = 5;
stepLayer1 = 10;
stepLayer2 = 5;
index = 1;

for indexLayer1 = 60 : stepLayer1 : maxLayer1
    for indexLayer2 = 10 : stepLayer2 : maxLayer2
        for indexNumarRepetari = 1 : maxIteration
            
            net = patternnet([indexLayer1, indexLayer2]);
            % net.layers{1}.transferFcn = 'logsig';
            % net.layers{2}.transferFcn = 'purelin';
            net.inputs{1}.processFcns = {'fixunknowns', 'mapstd'};
            net.performFcn = 'crossentropy';
            net.performParam.regularization = 0.1;
            net.performParam.normalization = 'standard';
            net.trainParam.epochs = 500;
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
            cellNet(index, 1) = {index};
            cellNet(index, 2) = {[indexLayer1, indexLayer2]};
            cellNet(index, 3) = {error};
            cellNet(index, 4) = {info.perf(end)};
            cellNet(index, 5) = {net};
            aux(index, 1) = {index};
            aux(index, 2) = {[indexLayer1, indexLayer2]};
            aux(index, 3) = {error};
            aux(index, 4) = {info.perf(end)};
            aux(index, 5) = {net};
            save(['net2layers' int2str(indexLayer1) '-' int2str(indexLayer2) '-' int2str(index) '.mat'],'aux');
            index = index + 1;
        end
    end
end
end
    
