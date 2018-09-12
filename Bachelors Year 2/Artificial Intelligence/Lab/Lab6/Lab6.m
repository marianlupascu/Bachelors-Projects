% S = [0 0 0 0.5 0.5 0.5 1 1; 0 0.5 1 0 0.5 1 0 0.5; 1 1 1 1 -1 -1 -1 -1];
% 
% ind1 = find(S(3, :) == 1);
% figure;
% hold on;
% plot(S(1, ind1), S(2, ind1), 'xg');
% 
% ind2 = find(S(3, :) == -1);
% plot(S(1, ind2), S(2, ind2), 'or');
% 
% [w, b, err] = algoritmRosenblattOnline(S, 100);
% 
% plotpc(w', b);
% axis([-0.5 1.5 -0.5 1.5]);

m = [10, 50, 100, 250, 500];
deplasare = [0.5, 0.3, 0.1, 0.01, -0.1, -0.3];
for i = 1 : size(m, 2)
    
    for j = 1 : size(deplasare, 2)
    
        M = genereazaPuncteDeplasateFataDePrimaBisectoare(m(i), deplasare(j))

        ind1 = find(M(3, :) == 1);
        figure;
        hold on;
        plot(M(1, ind1), M(2, ind1), 'xg');
        
        ind2 = find(M(3, :) == -1);
        plot(M(1, ind2), M(2, ind2), 'or');
        
        [w, b, err] = algoritmRosenblattOnline(M, 100);
        axis([-1.5 1.5 -1.5 1.5]);
        plotpc(w', b);
        title(strcat('m = ', int2str(m(i)), ', deplasare = ', num2str(deplasare(j))))
        
    end
end 


