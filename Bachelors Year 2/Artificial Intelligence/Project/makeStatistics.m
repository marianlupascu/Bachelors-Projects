function [] = makeStatistics(dataTrain, labelTrain)

maxLayer1 = 1000;
maxLayer2 = 800;
maxLayer3 = 500;
maxIteration = 3;
stepLayer1 = 200; % la 400 - 800 - 250 m-am oprit, mai trebuie 400 - 800 - 250, 300, .., 500
stepLayer2 = 200;
stepLayer3 = 50;

for indexLayer1 = 200 : stepLayer1 : maxLayer1
    Y = zeros(maxLayer2, maxLayer3);
    M = zeros(maxLayer2, maxLayer3);
    for indexLayer2 = 200 : stepLayer2 : maxLayer2
        for indexLayer3 = 50 : stepLayer3 : maxLayer3
            E = 0;
            Min = 100;
            for indexNumarRepetari = 1 : maxIteration
                net = patternnet([indexLayer1, indexLayer2, indexLayer3]);
                % net.layers{1}.transferFcn = 'logsig';
                % net.layers{2}.transferFcn = 'purelin';
                net.inputs{1}.processFcns = {'fixunknowns'};
                net.performFcn = 'crossentropy';%mean squared error
                % net.trainParam.goal = 0.0001;% vreau sa obtin o valoare f mica a functiei de eroare
                net.divideFcn = 'dividerand';
                % net.trainFcn = 'traingdm';
                [net,info] = train(net,dataTrain, labelTrain);
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
                E = E + error;
                Min = min(E, Min);
            end
            Y(indexLayer2, indexLayer3) = E / maxIteration;
            M(indexLayer2, indexLayer3) = Min;
        end
    end
    save(['Statistics' int2str(indexLayer1) '.mat'], 'Y');
    save(['Minimum' int2str(indexLayer1) '.mat'], 'M');
end

end
