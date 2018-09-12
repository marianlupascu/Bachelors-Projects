function lab7
    clear all, close all
    % for i = 1:4 - pt a vedea ca datorita initializarii random, difera
    %datele: exemplele + etichetele
    X = [0 0 0 0.5 0.5 0.5 1 1;0 0.5 1 0 0.5 1 0 0.5];
    % T = [1 1 1 1 -1 -1 -1 -1];
    T = [1 1 1 1 0 0 0 0]; %pct 8
    % X(:, 9) = [-50 90]';
    % T(9) = 1;
    %reprezentare grafica a datelor
    % subplot(2,2,i);
    figure(1), hold on;
    eticheta1 = find(T==1);
    etichetaMinus1 = find(T==-1);
    plot(X(1,eticheta1),X(2,eticheta1),'or');
    plot(X(1,etichetaMinus1),X(2,etichetaMinus1),'xg');
    % axis([-52 2 -2 92]);
    axis([-2 2 -2 2]);
    %pune pauza 2 secunde
    pause(2);
    %creeaza perceptron
    net = perceptron;
    % pt punctul 8, net.trainFcn = 'trainb'; % in loc de trainc
    %modifica functia de transfer – din hardlim in hardlims
    %net.layers{1}.transferFcn = 'hardlims'; % comentam, pt punctul 8
    %punctul b
    net.inputWeights{1}.initFcn = 'rands';
    net.inputWeights{1}.learnFcn = 'learnpn'; % learn normalize, pt punctul 5  
    net.biases{1}.initFcn = 'rands';
    net.biases{1}.learnFcn = 'learnpn'; % learn normalize, pt punctul 5    
    %configureaza perceptron pe baza datelor de intrare si iesire
    net = configure(net,X,T);
    % view(net);
    %afiseaza proprietatile perceptronului legate de vectorul de ponderi + bias
    disp('Proprietati legate de vectorul de ponderi:');
    disp(net.inputWeights{1});
    disp('Proprietati legate de bias:');
    disp(net.biases{1});
    %initializeaza parametri retelei
    net = init(net);
    % implicit ponderile + bias sunt nule (de la initzero)
    disp(net.IW{1}), disp(net.b{1})
    %seteaza numarul de epoci pentru antrenare
    net.trainParam.epochs = 1000;
    %net.trainParam.epochs = 1;
    %epocaCurenta = 1;
    %while epocaCurenta <= 100
        %antreneaza reteaua
        %wold = net.IW{1};
        %bold = net.b{1};
        
        [net,antrenare] = train(net,X,T);
        
        %w = net.IW{1};
        %b = net.b{1};
        
        %figure(1);
        %ploteaza dreapta de separare
        %h = plotpc(net.IW{1},net.b{1});
        %drawnow;
        %pause(0.01);
        
        %if isequal(wold, w) && isequal(bold, b)
            %set(h, 'color', [1 1 0]);
            %break;
        %end
        
        %epocaCurenta = epocaCurenta + 1;
    %end
    figure(1);
        %ploteaza dreapta de separare
        h = plotpc(net.IW{1},net.b{1});
    title('Reprezentarea grafica a exemplelor de antrenare si a dreptei de separare');
    %simuleaza reteaua pentru datele de intrare
    etichetePrezise = sim(net,X);
    isequal(etichetePrezise,T)
    % end
    %[wstar, bstar, Err] = algoritmRosenblattOnline(X, T, 100);
    
    %wstar
    %bstar
end