function [] = ex1()

%hardlim
n = -5:0.1:5;
a = hardlim(n);
subplot(3, 3, 1);
plot(n,a);
axis([-5 5 -1 2]);
title('hardlim');

%hardlims
n = -5:0.1:5;
a = hardlims(n);
subplot(3, 3, 2);
plot(n,a);
axis([-5 5 -2 2]);
title('hardlims');

%purelin
n = -5:0.1:5;
a = purelin(n);
subplot(3, 3, 3);
plot(n,a);
title('purelin');

%satlin
n = -5:0.1:5;
a = satlin(n);
subplot(3, 3, 4);
plot(n,a);
axis([-5 5 -1 2]);
title('satlin');

%satlins
n = -5:0.1:5;
a = satlins(n);
subplot(3, 3, 5);
plot(n,a);
axis([-5 5 -2 2]);
title('satlins');

%logsig
n = -5:0.1:5;
a = logsig(n);
subplot(3, 3, 6);
plot(n,a);
axis([-5 5 -1 2]);
title('logsig');

%tansig
n = -5:0.1:5;
a = tansig(n);
subplot(3, 3, 7);
plot(n,a);
axis([-5 5 -2 2]);
title('tansig');

%poslin
n = -5:0.1:5;
a = poslin(n);
subplot(3, 3, 8);
plot(n,a);
axis([-5 5 -1 3]);
title('poslin');

%tribas
n = -5:0.1:5;
a = tribas(n);
subplot(3, 3, 9);
plot(n,a);
axis([-5 5 -1 2]);
title('tribas');

%radbas
n = -5:0.1:5;
a = radbas(n);
subplot(3, 3, 10);
plot(n,a);
axis([-5 5 -1 2]);
title('radbas');

%softmax
n = [0; 1; -0.5; 0.5];
a = softmax(n);
figure;
title('poslin');
subplot(2,1,1), bar(n), ylabel('n')
subplot(2,1,2), bar(a), ylabel('a')

end

