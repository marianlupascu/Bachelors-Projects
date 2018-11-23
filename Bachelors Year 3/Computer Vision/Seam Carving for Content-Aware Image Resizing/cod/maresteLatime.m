function newImg = maresteLatime(img,numarPixeliLatime,metodaSelectareDrum)

    drumuri = cell(numarPixeliLatime, 1);
    copieImg = img;
    
    % memorez cele mai nesemnificative numarPixeliLatime drumuri pe care 
    % le elimin din imagine
    for i = 1 : numarPixeliLatime
        
        disp(['Elimin drumul vertical numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliLatime)]);
        disp([num2str(i*100/(numarPixeliLatime*2)) '%']);
    
        E = calculeazaEnergie(img);
        drum = selecteazaDrumVertical(E, metodaSelectareDrum);
        drumuri{i} = drum;
        img = eliminaDrumVertical(img, drum);
%         ploteazaDrumVertical(copieImg,E,drum,[0 0 255]');
    end
    
    % in continuare salvez pentru fiecare rand coloanele pe care l-em
    % modificat mai sus
    coloanePeRanduri = cell(size(drumuri{1}, 1), 1);
    for i = 1 : numarPixeliLatime

        for j = 1 : size(drumuri{i}, 1)
            
            r = drumuri{i}(j, 1);
            c = drumuri{i}(j, 2);
            if isempty(coloanePeRanduri{r})
                coloanePeRanduri{r, 1} = [];
            end
            coloanePeRanduri{r, 1} = [coloanePeRanduri{r} c];
        end
    end

    img = copieImg;
    newImg = zeros(size(img, 1),size(img, 2) + numarPixeliLatime,size(img, 3),'uint8');
    
    % aici updatez imaginea modificata conform articolului si anume pun pe
    % fiecare drum adaugat media drumurilor stanga dreapta, cu
    % constrangerile de rigoare: pentru prima coloana si ultima din drum.
    disp('Incep reconstructia...');    
    for rand = 1 : size(drumuri{1}, 1)
        
        disp([num2str(50+rand*100/(size(img, 1)*2)) '%']);
        coloane = coloanePeRanduri{rand, 1};
        noulRand = squeeze(img(rand, :, :));

        while size(coloane) >= 1
            
            c = coloane(1);
            if size(coloane) == 1
                coloane = [];
            else
                coloane = coloane(2:end);
            end
            
            coloane(coloane >= c) = coloane(coloane >= c) + 1;

            vecini = [];

            if c > 1
                vecini = [vecini noulRand(c - 1, :)];
            else
                vecini = [vecini noulRand(c, :)];
            end

            vecini = [vecini noulRand(c, :)];

            if c < size(noulRand, 1)
                vecini = [vecini noulRand(c + 1, :)];
            else
                vecini = [vecini noulRand(c, :)];
            end
            
            vecini = reshape(vecini, [3 3]);

            col1 = uint8((double(vecini(:,1)) + double(vecini(:,2))) / 2);
            col2 = uint8((double(vecini(:,2)) + double(vecini(:,3))) / 2);
           
            noulRand = [noulRand(1:c-1, :)', col1, col2, noulRand(c + 1:end, :)']';
            
        end
        
        aux(1, :, :) = noulRand;
        newImg(rand, :, :) = aux; % adaug dimensiunea pe care am luat-o cu squeeze
    end

end

