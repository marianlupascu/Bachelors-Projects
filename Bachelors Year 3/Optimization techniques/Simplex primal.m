A = [1 2 1 1; ...
     0 1 1 2];
b = [5; 2];
c = [1; 2; 3; 0];

[x] = SimplexPrimal(A, b, c);
 
% Se ruleaza de doua ori, Initial obtin o baza primal admisibila apoi cu ea
% continui algoritmul
% A doua oara folosim baza pentru probleme initiala si rulam iar algoritmul
function [x] = SimplexPrimal(A, b, c)
    [m, n] = size(A);
    
    % Initial cautam baza
    
    B = eye(m); %baza din variabilele artificiale 
    A_artif = [A B]; %adaugam indicii la ecuatiile noastre
    B_ind = (n+1) : (n+m); %B rond, indicii bazei
    R_ind = 1:n; %R rond, indicii non bazici
    % Rezolvam problema inf(suma 1*variabila artificiala)
    c_artif = [zeros(n, 1); ones(m, 1)];
    x = [zeros(n, 1); b];
    
    while 1
        B = A_artif(:, B_ind);
        B_inv = inv(B);
        % Test de optim
        rjs = zeros(size(x));
        rjs(B_ind) = 0; % rj, j din B_ind = 0, stim asta
        for index = 1:length(R_ind)
            j = R_ind(index);
            rj = c_artif(j) - c_artif(B_ind)' * B_inv * A_artif(:, j);
            rjs(j) = rj;
        end
        
        js = find(rjs < 0);
        if isempty(js) == 1
            % solutie optima
            disp('Solutie optima - P1');
            break;
        end
        
        % Test de optim infinit
        djs = zeros(n+m, n+m);
        optimInfinit = 0;
        for index = 1:length(js)
            j = js(index);
            dj = zeros(size(x));
            dj(B_ind) = -B_inv * A_artif(:, j);
            dj(j) = 1;
            djs(:, j) = dj;
            
            if sum(dj >= 0) == (n+m)
                optimInfinit = 1;
            end
        end
        
        if optimInfinit == 1
            disp('Optim infinit - P1');
            break; % TODO: what to do here
        end
        
        % Schimbam baza
        [rk, k] = min(rjs); % daca exista 2 minime il ia pe primul
        dk = djs(:, k);
        rs = find(dk < 0);
        vals = ones(size(dk)) * Inf;
        vals(rs) = -x(rs) ./ dk(rs);
        [alfa, i] = min(vals);
        
        B_ind = sort([B_ind(B_ind ~= i) k]);
        R_ind = sort([R_ind(R_ind ~= k) i]);
        disp(B_ind);
        disp(R_ind);
    end
    
   
    % Pas 2
    % Presupunem ca B_ind contine indici initiali, doar din 1:n
    R_ind = R_ind(R_ind <= n);
    
    while 1
        x = zeros(n, 1);
        B = A(:, B_ind);
        B_inv = inv(B);
        x(B_ind) = B_inv * b;
        
        % Test de optim
        rjs = zeros(size(x));
        rjs(B_ind) = 0; % rj, j din B_ind = 0, stim asta
        for index = 1:length(R_ind)
            j = R_ind(index);
            rj = c(j) - c(B_ind)' * B_inv * A(:, j);
            rjs(j) = rj;
        end
        
        js = find(rjs < 0);
        if isempty(js) == 1
            % solutie optima
            disp('Solutie optima');
            return;
        end
        
        % Test de optim infinit
        djs = zeros(n, n);
        optimInfinit = 0;
        for index = 1:length(js)
            j = js(index);
            dj = zeros(size(x));
            dj(B_ind) = -B_inv * A(:, j);
            dj(j) = 1;
            djs(:, j) = dj;
            
            if sum(dj >= 0) == n
                optimInfinit = 1;
            end
        end
        
        if optimInfinit == 1
            disp('Optim infinit');
            return;
        end
        
        % Schimbam baza
        [rk, k] = min(rjs); % daca exista 2 minime il ia pe primul
        dk = djs(:, k);
        rs = find(dk < 0);
        vals = ones(size(dk)) * Inf;
        vals(rs) = -x(rs) ./ dk(rs);
        [alfa, i] = min(vals);
        
        B_ind = sort([B_ind(B_ind ~= i) k]);
        R_ind = sort([R_ind(R_ind ~= k) i]);
    end
end