function [ TT, LL ] = genereazaExemplePerturbate( dataTrain, labelTrain, sigma )

T = dataTrain;
L = labelTrain;

index = size(dataTrain, 2) + 1;
for i = 0 : 8
    indici = find(labelTrain == i);
    for j = 1 : size(indici, 2)
        for k = 1 : 3
            T(:, index) = dataTrain(:, indici(1, j)) + sigma * randn(size(dataTrain, 1), 1);
            L(1, index) = i;
            index = index +1;
        end
    end
end

p = randperm(size(T, 2));
TT = T(:, p);
LL = L(:, p);

end

