function [newLabelTrain] = preprocess(labelTrain)

newLabelTrain = zeros(10, size(labelTrain, 2));
for i = 1 : size(labelTrain, 2)
    newLabelTrain(labelTrain(i)+1, i) = 1;
end

end

