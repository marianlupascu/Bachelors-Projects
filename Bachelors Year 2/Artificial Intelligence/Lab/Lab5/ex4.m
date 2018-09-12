function [] = ex4()

OR = [0 1 0 1; 0 0 1 1; 0 1 1 1];
AND = [0 1 0 1; 0 0 1 1; 0 0 0 1];
XOR = [0 1 0 1; 0 0 1 1; 0 1 1 0];

hold on;
for i = 1 : size(OR, 2)
    if(OR(3, i) == 0)
        plot(OR(1, i), OR(2, i), 'or');
    else
        plot(OR(1, i), OR(2, i), 'og');
    end
end
net1 = perceptron;%creeaza o retea de perceptroni
net1 = configure(net1,[0;0],0);%configureaza reteaua - are ca input vectori 1×3 si un output
net1.trainFcn = 'trainb';
net1 = train(net1, OR([1, 2], :), OR(3, :));
%view(net);%vizualizeaza reteaua
net1.IW{1}
net1.b{1}

axis([-0.5 1.5 -0.5 1.5]);
plotpc(net1.IW{1},net1.b{1});

hold off;

figure;
hold on;
for i = 1 : size(AND, 2)
    if(AND(3, i) == 0)
        plot(AND(1, i), AND(2, i), 'or');
    else
        plot(AND(1, i), AND(2, i), 'og');
    end
end
net2 = perceptron;%creeaza o retea de perceptroni
net2 = configure(net2,[0;0],0);%configureaza reteaua - are ca input vectori 1×3 si un output
net2.trainFcn = 'trainb';
net2 = train(net2, AND([1, 2], :), AND(3, :));
%view(net);%vizualizeaza reteaua
net2.IW{1}
net2.b{1}
axis([-0.5 1.5 -0.5 1.5]);
plotpc(net2.IW{1},net2.b{1});

hold off;

figure;
hold on;
for i = 1 : size(XOR, 2)
    if(XOR(3, i) == 0)
        plot(XOR(1, i), XOR(2, i), 'or');
    else
        plot(XOR(1, i), XOR(2, i), 'og');
    end
end
net3 = perceptron;%creeaza o retea de perceptroni
net3 = configure(net3,[0;0],0);%configureaza reteaua - are ca input vectori 1×3 si un output
net3 = train(net3, XOR([1, 2], :), XOR(3, :));
%view(net);%vizualizeaza reteaua
net3.IW{1}
net3.b{1}
plotpc(net3.IW{1},net3.b{1});
axis([-0.5 1.5 -0.5 1.5]);
hold off;

end

