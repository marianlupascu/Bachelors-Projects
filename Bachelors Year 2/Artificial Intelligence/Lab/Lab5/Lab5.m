
%nnd3pc();

Nor = ex3(1000)
net = perceptron;%creeaza o retea de perceptroni
net = configure(net,[0;0],0);%configureaza reteaua - are ca input vectori 1×2 si un output
net.layers{1}.transferFcn  = 'hardlim';
net.IW{1} = [1 -1];%setam ponderile pentru intrari
net.b{1} = 0;%setam bias-ul
view(net);%vizualizeaza reteaua

clasePrezise = sim(net, Nor([1, 2], :))
isequal(clasePrezise, Nor(3, :))

net1 = perceptron;%creeaza o retea de perceptroni
net1 = configure(net1,[0;0],0);%configureaza reteaua - are ca input vectori 1×3 si un output
net1 = train(net1, Nor([1, 2], :), Nor(3, :));
view(net);%vizualizeaza reteaua
net1.IW{1}
net1.b{1}
plotpc(net1.IW{1, 1},net1.b{1})

