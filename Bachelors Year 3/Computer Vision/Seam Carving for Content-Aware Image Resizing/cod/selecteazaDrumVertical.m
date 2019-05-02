function d = selecteazaDrumVertical(E,metodaSelectareDrum)
%selecteaza drumul vertical ce minimizeaza functia cost calculate pe baza lui E
%
%input: E - energia la fiecare pixel calculata pe baza gradientului
%       metodaSelectareDrum - specifica metoda aleasa pentru selectarea drumului. Valori posibile:
%                           'aleator' - alege un drum aleator
%                           'greedy' - alege un drum utilizand metoda Greedy
%                           'programareDinamica' - alege un drum folosind metoda Programarii Dinamice
%
%output: d - drumul vertical ales

d = zeros(size(E,1),2);

switch metodaSelectareDrum
    case 'aleator'
        %pentru linia 1 alegem primul pixel in mod aleator
        linia = 1;
        %coloana o alegem intre 1 si size(E,2)
        coloana = randi(size(E,2));
        %punem in d linia si coloana coresponzatoare pixelului
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            %alege urmatorul pixel pe baza vecinilor
            %linia este i
            linia = i;
            %coloana depinde de coloana pixelului anterior
            if d(i-1,2) == 1%pixelul este localizat la marginea din stanga
                %doua optiuni
                optiune = randi(2)-1;%genereaza 0 sau 1 cu probabilitati egale 
            elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                %doua optiuni
                optiune = randi(2) - 2; %genereaza -1 sau 0
            else
                optiune = randi(3)-2; % genereaza -1, 0 sau 1
            end
            coloana = d(i-1,2) + optiune;%adun -1 sau 0 sau 1: 
                                         % merg la stanga, dreapta sau stau pe loc
            d(i,:) = [linia coloana];
        end
        
        
    case 'greedy'
        linia = 1;
        [~, coloana] = min(E(linia, :));
        d(1,:) = [linia coloana];
        for i = 2:size(d,1)
            
            linia = i;
            if d(i-1,2) == 1%pixelul este localizat la marginea din stanga
                %doua optiuni
                if E(i, 1) < E(i, 2)
                    coloana = 1;
                else
                    coloana = 2;
                end
            elseif d(i-1,2) == size(E,2)%pixelul este la marginea din dreapta
                %doua optiuni
                if E(i, end) < E(i, end-1)
                    coloana = size(E,2);
                else
                    coloana = size(E,2) - 1;
                end
            else
                [~, coloana] = min(E(i, d(i-1,2)-1:d(i-1,2)+1));
                coloana = coloana + d(i-1,2) -1 - 1;
            end
            
            d(i,:) = [linia coloana];
        end
         
        
    case 'programareDinamica'
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
        
    otherwise
        error('Optiune pentru metodaSelectareDrum invalida');
end

end