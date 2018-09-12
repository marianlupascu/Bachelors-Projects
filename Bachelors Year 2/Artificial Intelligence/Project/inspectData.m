function [] = inspectData(dataTest, dataTrain, labelTrain)
%%
% inspect data
n = 0:9;
for i = 0:9
    indexs = find(labelTrain == i);
    cardinal(i+1) = size(indexs, 2);
    disp([int2str(cardinal(i+1)) ' de ' int2str(i)]);
end
figure(1);
bar(n, cardinal), xlabel('class'), ylabel('number of exemples');

%%
%inspect null values for dataTrain
n = 0:max(sum(isnan(dataTrain)));
for i = 0:max(sum(isnan(dataTrain)))
    numberOfNan(i+1) = size(find(sum(isnan(dataTrain)) == i), 2);
end
figure(2);
bar(n, numberOfNan), ylabel('dimesions'), xlabel('number of Nan');

disp(['numarul maxim de Nan per caracteristica din dataTrain este ' int2str(max(sum(isnan(dataTrain')))) ...
    ' dintr-un total de ' int2str(size(dataTrain, 2)) ' (' ...
    num2str(max(sum(isnan(dataTrain'))) * 100 / size(dataTrain, 2)) ' %)']);

for i = 0:9
    index = find(labelTrain == i);
    for j = 0:max(sum(isnan(dataTrain(:, index))))
        nans(i+1, j+1) = size(find(sum(isnan(dataTrain(:, index))) == j), 2);
    end
end
nans
figure(3);
bar(nans), ylabel('dimesions'), xlabel('number of Nan per class');
ylim([0 100]);

%%
%inspect null values for dataTest
n = 0:max(sum(isnan(dataTest)));
for i = 0:max(sum(isnan(dataTest)))
    numberOfNan(i+1) = size(find(sum(isnan(dataTest)) == i), 2);
end
figure(4);
bar(n, numberOfNan), ylabel('dimesions'), xlabel('number of Nan');

disp(['numarul maxim de Nan per caracteristica din dataTest este ' int2str(max(sum(isnan(dataTest')))) ...
    ' dintr-un total de ' int2str(size(dataTest, 2)) ' (' ...
    num2str(max(sum(isnan(dataTest'))) * 100 / size(dataTest, 2)) ' %)']);

end

