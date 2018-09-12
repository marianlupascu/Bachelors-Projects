% 
% net1 = feedforwardnet;
% view(net1);
% 
% net2 = patternnet;
% view(net2);
% 
% net1.trainFcn
% net1.performFcn
% 
% net2.trainFcn
% net2.performFcn
% 
% net1.layers{2}.transferFcn
% net2.layers{2}.transferFcn


%%
% X = [0 1 0 1; 0 0 1 1]; %input-urile
% t = [0 1 1 0]; % target-urile
% net = patternnet(2);
% view(net);
% net.layers{1}.transferFcn = 'hardlim';%setam functiile de transfer
% net.layers{2}.transferFcn = 'hardlim';%pentru ambele layere
% view(net);
% net1.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
% net1.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
% net = configure(net,X,t);%configuram reteaua
% view(net);
% net.IW{1,1} = [-1 1; 1 -1]; %matricea de ponderi de pe primul strat
% net.LW{2,1}=[1 1]; % matricea de ponderi de pe al doilea strat
% net.b{1} = [-0.5; -0.5];
% net.b{2} = -0.5; %bias-urile
% a=sim(net,X)
% isequal(a,t)
% a = net(X) %similar cu sim
% isequal(a,t)

%%
%3
X = [0 1 0 1; 0 0 1 1]; %input-urile
t = [0 1 1 0]; % target-urile
net = patternnet(2);
net.layers{1}.transferFcn = 'hardlim';%setam functiile de transfer
net.layers{2}.transferFcn = 'hardlim';%pentru ambele layere
net1.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
net1.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
net = configure(net,X,t);%configuram reteaua
view(net);
net.IW{1,1} = [-1 -1; 1 1]; %matricea de ponderi de pe primul strat
net.LW{2,1}=[-1 -1]; % matricea de ponderi de pe al doilea strat
net.b{1} = [-0.5; -0.5];
net.b{2} = 0.5; %bias-urile
a=sim(net,X)
isequal(a,t)
a = net(X) %similar cu sim
isequal(a,t)

%%
%4
% X = rand(2, 200000) * 4 - 2;
% net = patternnet(3);
% net.layers{1:2}.transferFcn = 'hardlim';
% net.inputs{1}.processFcns = {};
% net.outputs{2}.processFcns = {};
% % view(net);
% net = configure(net, [0 0]', 0);
% % view(net);
% 
% net.IW{1, 1} = [1 -1; -1 -1; 0 1];
% net.b{1} = [1; 1; 0];
% 
% net.LW{2, 1} = [1 1 1];
% net.b{2} = -3;
% 
% net.IW
% net.LW
% 
% t = net(X);
% 
% size(t)
% unique(t)
% 
% ind1 = find(t == 1);
% ind0 = find(t == 0);
% 
% figure, hold on;
% 
% plot(X(1, ind1), X(2, ind1), '.r');
% plot(X(1, ind0), X(2, ind0), '.b');

%%
%antreneaza retea pt XOR
% X = [0 1 0 1; 0 0 1 1]; %input-urile
% t = [0 1 1 0]; % target-urile
% net = patternnet(2);
% net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
% net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
% net.performFcn = 'mse';%mean squared error
% met.trainParam.goal = 0.01;%conditia de oprire
% net.divideFcn = '';%nu imparti multimea de antrenare
% [net,info] = train(net,X,t);
% net.layers{2}.transferFcn = 'hardlim';
% a=sim(net,X)
% isequal(a,t)

%%
%5
X = rand(2, 20000) * 4 - 2;
net = patternnet(3);
net.layers{1:2}.transferFcn = 'hardlim';
net.inputs{1}.processFcns = {};
net.outputs{2}.processFcns = {};
% view(net);
net = configure(net, [0 0]', 0);
% view(net);

net.IW{1, 1} = [1 -1; -1 -1; 0 1];
net.b{1} = [1; 1; 0];

net.LW{2, 1} = [1 1 1];
net.b{2} = -3;

p = randperm(size(X, 2));
T = X(:, p(1:end));
L = net(T);

nett = patternnet(6);
nett.performFcn = 'mse';%mean squared error
nett.trainParam.goal = 0.01;%conditia de oprire
nett = train(nett,T,L);

prezis=sim(nett,X);
prezis = hardlim(prezis - 0.5);
isequal(prezis,L);

ind1 = find(prezis == 1);
ind0 = find(prezis == 0);

figure, hold on;

plot(X(1, ind1), X(2, ind1), '.r');
plot(X(1, ind0), X(2, ind0), '.b');