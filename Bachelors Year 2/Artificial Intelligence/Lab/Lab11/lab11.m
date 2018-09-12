netf = feedforwardnet(2);
netf.layers{1:2}.transferFcn = 'logsig';
netf.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
netf.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
netf = configure(netf,0,0);
netf.IW{1,1} = [10 10]';
netf.b{1} = [-5 5]';
netf.LW{2,1} = [1 1];
netf.b{2} = -1;
% view(netf);
%plotam functia implementata de retea
p = -2:0.001:2;
t = sim(netf,p);
figure(1),hold on;
plot(p,t,'b');
%luam numai cateva puncte
p = -2:0.1:2;
t = sim(netf,p);
plot(p,t,'xr');

%%
%definim reteaua pentru a fi antrenata
% % net = feedforwardnet(2);
% % net.layers{1:2}.transferFcn = 'logsig';
% % net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
% % net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
% % net = configure(netf,0,0);
% % %definim parametri de antrenare
% % net.trainFcn = 'traingd'; %antrenare cu batch gradient descend - coborare pe gradient varianta batch
% % net.trainParam.lr = 0.05;%rata de invatare
% % net.trainParam.epochs = 1000; %nr de epoci
% % net.trainParam.goal = 1e-5;%valoarea erorii pe care vrem sa o atingem
% % [net,tr]=train(net,p,t); %antrenarea retelei
% % % plotperform(tr);
% % plot(p,net(p),'g');

%%
%cu moment
% % net = feedforwardnet(2);
% % net.layers{1:2}.transferFcn = 'logsig';
% % net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
% % net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
% % net = configure(netf,0,0);
% % %definim parametri de antrenare
% % %antrenare cu batch gradient descend - coborare pe gradient varianta batch
% % net.trainFcn = 'traingdm';
% % net.trainParam.show = 50;
% % net.trainParam.lr = 0.05;
% % net.trainParam.mc = 0.9;
% % net.trainParam.epochs = 1000;
% % net.trainParam.goal = 1e-5;
% % [net,tr]=train(net,p,t);
% % % plotperform(tr);
% % plot(p,net(p),'g');

%%
%cu rata variabila
net = feedforwardnet(2);
net.layers{1:2}.transferFcn = 'logsig';
net.inputs{1}.processFcns = {};%eliminam faza de preprocesare: scalare, etc.
net.outputs{2}.processFcns = {};%eliminam faza de postprocesare: scalare, etc
net = configure(netf,0,0);
net.trainFcn = 'traingdx';
net.trainParam.show = 50;
net.trainParam.lr = 0.05;
net.trainParam.mc = 0.9;
net.trainParam.lr_inc = 1.05;
net.trainParam.lr_dec = 0.7;
net.trainParam.max_perf_inc = 1.04;
net.trainParam.epochs = 1000;
net.trainParam.goal = 1e-5;
[net,tr]=train(net,p,t);
plot(p,net(p),'g');
% % plotperform(tr);