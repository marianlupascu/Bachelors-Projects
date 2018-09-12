function [] = nnd3pc()

net = perceptron;%creeaza o retea de perceptroni
net = configure(net,[0;0;0],0);%configureaza reteaua - are ca input vectori 1×3 si un output
net.layers{1}.transferFcn  = 'hardlims';
net.IW{1} = [0 1 0];%setam ponderile pentru intrari
net.b{1} = 0;%setam bias-ul
view(net);%vizualizeaza reteaua

X = ex2(10)
clasePrezise = sim(net, X)
claseAdev = (X(2, :) > 0) * 2 - 1
isequal(clasePrezise, claseAdev)
end

