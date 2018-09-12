
%%
% loading data
[dataTest, dataTrain, labelTrain] = loadData();

%% add new exemples
% % % % % % % % % % [plusDataTrain, plusLabelTrain] = genereazaExemplePerturbate(dataTrain, labelTrain, 0.05);

%%
% inspect data
% % % % % % % inspectData(dataTest, plusDataTrain, plusLabelTrain);

%%
% preprocess data
newLabelTrain = preprocess(labelTrain);

%%
% make statistics
% % % % % % % % % % % makeStatistics(dataTrain, newLabelTrain);

%%
% get best network
% % % % % % % % % % % cellNet = getBest(dataTrain, newLabelTrain);
% % % % % % % % % % % cellNet2layers = getBest2layers(dataTrain, newLabelTrain);

%%
% train
fold_cross_validation(dataTrain, newLabelTrain);
% net = learn(dataTrain, newLabelTrain);

% % % % % % % % % % % % % % % % % % index = 1;
% % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % for i = 1 : 50
% % % % % % % % % % % % % % % % % %     i
% % % % % % % % % % % % % % % % % %     [net, error, performance] = learn(dataTrain, newLabelTrain);
% % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % %     aux(index, 1) = {index};
% % % % % % % % % % % % % % % % % %     aux(index, 2) = {error};
% % % % % % % % % % % % % % % % % %     aux(index, 3) = {performance};
% % % % % % % % % % % % % % % % % %     aux(index, 4) = {net};
% % % % % % % % % % % % % % % % % %     index = index + 1;
% % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % % end
% % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % save(['netTraincgf-180-45' '---' int2str(index) '.mat'],'aux');
% % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % min = 20;
% % % % % % % % % % % % % % % % % % poz = 0;
% % % % % % % % % % % % % % % % % % for i = 1 : 50 
% % % % % % % % % % % % % % % % % %     
% % % % % % % % % % % % % % % % % %     if aux{i, 3} < min
% % % % % % % % % % % % % % % % % %         min = aux{i, 3};
% % % % % % % % % % % % % % % % % %         poz = i;
% % % % % % % % % % % % % % % % % %     end
% % % % % % % % % % % % % % % % % % end

% net = learn(dataTrain(:, 1:24000), newLabelTrain(:, 1:24000));
% prezis = net(dataTrain(:, 24001:end));
% efectiv = newLabelTrain(:, 24001:end);
% b = prezis == max(prezis);
% 
% n = 0;
% for i = 1:size(prezis, 2)
%     if sum(b(:, i) ~= efectiv(:, i)) ~= 0
%         n = n + 1;
%     end
% end
% 
% error = n * 100 / size(prezis, 2);
% error

% get test
%%
labelTest = test(dataTest, net);

%%
% write
makeCSV(labelTest);

%%
%deep network
% % % % % % % % net = deeplearning(dataTrain, labelTrain);
% % % % % % % % newDataTest = {};
% % % % % % % % for i = 1 : size(dataTest, 2) 
% % % % % % % %     newDataTest(i) = {dataTest(:, i)};
% % % % % % % % end
% % % % % % % % newDataTest = newDataTest';
% % % % % % % % YPred = classify(net,newDataTest);
% % % % % % % % YPred = double(YPred);
% % % % % % % % makeCSV(YPred');

% index= 1;
% for i= 10 : 5 : 600
%     for j = 1 : 5
%        load(['net2layers' int2str(60) '-' int2str(i) '-' int2str(index) '.mat']);
%        index = index  + 1;
%     end
% end
% 
% save('CellFor2Layers60-10to300.mat', 'aux')

% % % % % % % % min = 10;
% % % % % % % % poz = -1;
% % % % % % % % for i = 1 : 595
% % % % % % % %     
% % % % % % % %    if aux{i, 4} < min
% % % % % % % %        min = aux{i, 4};
% % % % % % % %        poz = i;
% % % % % % % %    end
% % % % % % % % end