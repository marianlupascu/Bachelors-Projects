function [labelTest] = test(dataTest, net)

a = sim(net,dataTest);
b = find(a == max(a));

a = zeros(10, size(dataTest, 2));
a(b) = 1;
for i = 1:size(dataTest, 2)
    labelTest(i) = find(a(:, i)==1);
end

labelTest = labelTest - 1;

end

