saveS();

load('S', 'S')
load('S1', 'S1')
load('S2', 'S2')
S, S1, S2
ind1 = find(S1(3, :) == 1);
ind0 = find(S1(3, :) == 0);
hold on;
axis([-3 3 -3 3]);
plot(S1(1, ind1), S1(2, ind1), '+g');
plot(S1(1, ind0), S1(2, ind0), 'or');

% net = perceptron;
% net.layers{1}.transferFcn = 'hardlim';
% net = configure(net,S1([1, 2], :), S1(3, :));
% %view(net);
% 
% net = init(net);
% net.trainParam.epochs = 100;
% 
% [net, antrenare] = train(net,S1([1, 2], :),S1(3, :));
% plotpc(net.IW{1},net.b{1});
% title('Reprezentarea grafica a exemplelor de antrenare si a dreptei de separare');
% etichetePrezise = sim(net,S1([1, 2], :));
% isequal(etichetePrezise,S1(3, :))
% net.IW{1},net.b{1}
% 
% %%
% %punct f
% clear net;
% net = perceptron;
% net.layers{1}.transferFcn = 'hardlim';
% net = configure(net,S1([1, 2], :), S1(3, :));
% %view(net);
% net.inputWeights{1}.initFcn = 'rands';
%    net.inputWeights{1}.learnFcn = 'learnp';
%    net.biases{1}.initFcn = 'rands';
%     net.biases{1}.learnFcn = 'learnp';
% 
% net = init(net);
% net.trainParam.epochs = 1;
% 
% epocaCurenta = 1;
% err = [];
%     while epocaCurenta <= 100
%         wold = net.IW{1};
%         bold = net.b{1};
%         
%         [net,antrenare] = train(net,S1([1, 2], :), S1(3, :));
%         
%         w = net.IW{1};
%         b = net.b{1};
%         
%         if isequal(wold, w) && isequal(bold, b)
%             break;
%         end
%         
%         aux = sim(net,S1([1, 2], :)) ~= S1(3, :);
%         greseste = sum(aux)
%         
%         err(epocaCurenta) = greseste / size(S1, 2);
%         epocaCurenta = epocaCurenta + 1;
%     end
% figure();
% plot(err);
% axis([1 epocaCurenta 0 1])
% 
% sim(net,[-1; 1])
% 
% %%
% %punct h
% 
% 
% aux = sim(net,S2([1, 2], :)) ~= S2(3, :);
% greseste = sum(aux) / size(S2, 2)
% 
% figure();
% plotpv(S2([1, 2], :), S2(3, :));
% plotpc(net.IW{1}, net.b{1});

%%
%i

eticheta =  S1(1, :) + S1(2, :)

net = perceptron;
net.layers{1}.transferFcn = 'purelin';
net = configure(net,S1([1, 2], :),eticheta);
%antrenare batch pentru cazul general
net.trainFcn = 'trainb';
net.inputWeights{1}.initFcn = 'rands';
net.inputWeights{1}.learnFcn = 'learnwh';
net.inputWeights{1}.learnParam.lr = 0.005;
net.biases{1}.initFcn = 'rands';
net.biases{1}.learnFcn = 'learnwh';
net.biases{1}.learnParam.lr = 0.001;
net.trainParam.epochs = 1000;

net = train(net,S1([1, 2], :),eticheta);
plotpc(net.IW{1},net.b{1});
net.IW{1},net.b{1}

etichetePrezise = sim(net,S2([1, 2], :)) > 0
isequal(etichetePrezise,S2(3, :))
