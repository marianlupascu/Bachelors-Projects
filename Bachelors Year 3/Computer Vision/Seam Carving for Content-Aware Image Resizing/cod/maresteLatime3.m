function newImg = maresteLatime3(img,numarPixeliLatime,metodaSelectareDrum)

copieImg = img;
newImg = img;

disp('Incep marirea imaginii pe latime');

drumuri = cell(numarPixeliLatime, 1);

for i = 1:numarPixeliLatime
    
    disp(['Adaug drumul vertical numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliLatime)]);
    
    %calculeaza energia dupa ecuatia (1) din articol
    E = calculeazaEnergie(img);
    
    %alege drumul vertical care conecteaza sus de jos
    drum = selecteazaDrumVertical(E,metodaSelectareDrum);
%     copie = drum;
    %elimina drumul din imagine
    img = eliminaDrumVertical(img,drum);
    for k = 1 : size(drum, 1) 
        
        prev = zeros(1, i-1);
        for j = 1 : i - 1
            
            aux = drumuri{j, 1};
            prev(1, j) = aux(k, 2);
        end
        
        prev = sort(prev);
        
        for j = 1 : i - 1
            if drum(k, 2) >= prev(1, j)
                % daca noul drum este peste drumurile vechi atunci este mai la
                % drepta deoarece inainte am taiat acolo
                drum(k, 2) = drum(k, 2) + 1;
            end
        end 
    end

    drumuri{i, 1} = drum;
    
    
%     drum(:, 2) - copie(:, 2)
%     copieImg = newImg;
%     for j = 1 : i - 1
%         drum = drumuri{j, 1};
%         for o = 1:size(drumuri{j, 1},1)
%             copieImg(drum(o,1),drum(o,2),:) = uint8([255 0 0]');
%         end
%     end
%     drum = drumuri{i, 1};
%         for o = 1:size(drumuri{i, 1},1)
%             if copieImg(drum(o,1),drum(o,2),:) ==  uint8([255 0 0]')
%                 disp('CONF');
%                 copieImg(drum(o,1),drum(o,2),:) = uint8([255 255 0]');
%             else
%                 copieImg(drum(o,1),drum(o,2),:) = uint8([0 0 255]');
%             end
%         end
%         figure(53)
%         imshow(copieImg)
        
end

%     for j = 1 : size(drumuri, 1)
%         r = randi(255);
%         g = randi(255);
%         b = randi(255);
%         drum = drumuri{j, 1};
%         for i = 1:size(drumuri{j, 1},1)
%             copieImg(drum(i,1),drum(i,2),:) = uint8([r b g]');
%         end
%         figure(55)
%         imshow(copieImg)
%     end

drumuriInNewImg = drumuri;

for i = 1:numarPixeliLatime
    
    drum = drumuri{i, 1};
    
    newImg2 = zeros(size(newImg,1),size(newImg,2)+1,size(newImg,3),'uint8');
    for j=1:size(newImg2,1)
    	coloana = drumuriInNewImg{i, 1}(j, 2);
    	%copiem partea din stanga
        newImg2(j,1:coloana,:) = newImg(j,1:coloana,:);
        %copiem partea din dreapta
        newImg2(j,coloana+2:end,:) = newImg(j,coloana+1:end,:);
    end
    
    drumuriInNewImg = actualizeazaDrumuri(drumuriInNewImg, drum, i);
    
    newImg = newImg2;
    for j=1:size(newImg,1)
    	coloana = drum(j,2);
        
        newImg(j,drumuriInNewImg{i, 1}(j, 2),:) = uint8((double(copieImg(j, coloana,:)) + ...
            double(copieImg(j, max([coloana - 1, 1]),:))) / 2);
        newImg(j,drumuriInNewImg{i, 1}(j, 2) + 1,:) = uint8((double(copieImg(j, coloana,:)) + ...
            double(copieImg(j, min([coloana + 1, size(copieImg, 2)]),:))) / 2);
    end

        
end

figure(100)
imshow(newImg);

end

function cellActualizata = actualizeazaDrumuri(cellArray, drumReferinta, poz) 

cellActualizata = cellArray;

for i = poz + 1 : size(cellArray, 1)
    
    drum = cellArray{i, 1};
     
    for j = 1 : size(drum, 1)
        
        if drum(j, 2) >= drumReferinta(j, 2)
            
            cellActualizata{i, 1}(j, 2) = cellActualizata{i, 1}(j, 2) + 1;
        end
    end
end

end

