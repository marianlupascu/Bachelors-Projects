% A = [-3 -1; ...
%      -4 -3; ...
%      -1 -2];
% b = [-3; -6; -3];
% c = [-2; -1];

A = [-3 -5;
    -5 -2];
b = [-5; -3];
c = [-15; -10];

[x] = SimplexDual(A, b, c);

function [x] = SimplexDual(A, b, c)
    [m, ~] = size(A);
    
    A = [A eye(m)];
    c = [c; zeros(m, 1)];
    
    B_rond = (size(A, 2) - m + 1) : size(A, 2); %B rond, indicii bazei
    R_rond = 1 : (size(A, 2) - m); %R rond, indicii restului
    
    [~, n] = size(A);
      
    while true
        
        %pasul 1
        x = zeros(n, 1);
        B = A(:, B_rond);
        B_inv = inv(B);
        x(B_rond) = B_inv * b;        
        
        rjs = zeros(size(x));
        rjs(B_rond) = 0; % rj, j din B_rond = 0, stim asta
        for index = 1:length(R_rond)
            j = R_rond(index);
            rj = c(j) - c(B_rond)' * B_inv * A(:, j);
            rjs(j) = rj;
        end
        
        %pasul 2
        js = find(rjs < 0);
        if isempty(js) == 1
            % solutie optima
            disp('Baza dual admisibila');
        end
                
        %pasul 3: Test de optim
        xs = find(x < 0);
        if isempty(xs) == 1
           disp('Solutie optima')
           return;
        end
        
        [ri, i] = min(x); % daca exista 2 minime il ia pe primul
        
        %pasul 4: Verificare solutie
        y = B_inv * A;
        
        cols = y(:, R_rond);
        mins = min(cols);
        if max(mins') >= 0
          disp('Nu avem solutie') 
          return;
        end
        
        %pasul 5: Schimbam baza
        [xk, k] = min(x);
        k = find(B_rond == k);
        values = rjs(R_rond) ./ (y(k, R_rond)');
        [eps, l] = min(values);
        
        B_rond = sort([B_rond(B_rond ~= i) l]);
        R_rond = sort([R_rond(R_rond ~= l) i]);
    end
end