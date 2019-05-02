function d = selecteazaDrumVerical(E)

d = zeros(size(E,1),2); % drumul vertical ales
        
	M = zeros(size(E));
	M(1, :) = E(1, :);
	for i = 2:size(M,1)
        
        for j = 1 : size(M,2)
                
            if j == 1
                M(i, j) = E(i, j) + min(M(i-1, j:j+1));
            elseif j == size(M,2)
            	M(i, j) = E(i, j) + min(M(i-1, j-1:j));
            else
                M(i, j) = E(i, j) + min(M(i-1, j-1:j+1));
            end
        end
    end
        
	[~, coloana] = min(M(end, :));
        
	d(size(d, 1), :) = [size(d, 1), coloana];
        
	for i = size(d, 1)-1:-1:1
            
        vechiaColoana = d(i+1, 2);
        if vechiaColoana == 1
            [~, coloana] = min(M(i+1, 1:2));
        elseif vechiaColoana == size(M, 2)
        	[~, coloana] = min(M(i+1, size(M, 2)-1:size(M, 2)));
        	coloana = coloana + size(M, 2) - 1 - 1;
        else
        	[~, coloana] = min(M(i+1, vechiaColoana-1:vechiaColoana+1));
            coloana = vechiaColoana - 1 - 1 + coloana;
        end
        d(i, :) = [i, coloana];
	end

end

