function img = updateCfFrontieraCostMinim(blocDinImgSintetizata, ...
                    bloc, dimSuprapunere, caz)
                
img = uint8(zeros(size(blocDinImgSintetizata)));

switch caz
    case 1
        
        suprapunereImgSintetizata = blocDinImgSintetizata(1:end, ...
            1:dimSuprapunere, :);
        suprapunerebloc = bloc(1:end, ...
            1:dimSuprapunere, :);
        suprapunere = (double(suprapunereImgSintetizata) - double(suprapunerebloc)) .^ 2;
        E = 0.2989 * suprapunere(:, :, 1) + ...
            0.5870 * suprapunere(:, :, 2) + ...
            0.1140 * suprapunere(:, :, 3);
        
        drum = selecteazaDrumVerical(E);
        
        for i=1:size(img,1)
            coloana = drum(i,2);
            %copiem partea din stanga
            img(i,1:coloana-1,:) = blocDinImgSintetizata(i,1:coloana-1,:);
            %copiem partea din dreapta
            img(i,coloana:end,:) = bloc(i,coloana:end,:);
        end
        
    case 2
        
        suprapunereImgSintetizata = blocDinImgSintetizata(1:dimSuprapunere, ...
            1:end, :);
        suprapunerebloc = bloc(1:dimSuprapunere, ...
            1:end, :);
        suprapunere = (double(suprapunereImgSintetizata) - double(suprapunerebloc)) .^ 2;
        E = 0.2989 * suprapunere(:, :, 1) + ...
            0.5870 * suprapunere(:, :, 2) + ...
            0.1140 * suprapunere(:, :, 3);
        
        drum = selecteazaDrumVerical(E');
        drum = drum';
        
        for i=1:size(img,2)
            linia = drum(2, i);
            %copiem partea de sus
            img(1:linia - 1,i,:) = blocDinImgSintetizata(1:linia - 1,i,:);
            %copiem partea de jos
            img(linia:end,i,:) = bloc(linia:end,i,:);
        end
        
    case 3
        
        suprapunereImgSintetizata = blocDinImgSintetizata(1:end, ...
            1:dimSuprapunere, :);
        suprapunerebloc = bloc(1:end, ...
            1:dimSuprapunere, :);
        suprapunere = (double(suprapunereImgSintetizata) - double(suprapunerebloc)) .^ 2;
        E = 0.2989 * suprapunere(:, :, 1) + ...
            0.5870 * suprapunere(:, :, 2) + ...
            0.1140 * suprapunere(:, :, 3);
        
        drum = selecteazaDrumVerical(E);
        
        for i=1:size(img,1)
            coloana = drum(i,2);
            %copiem partea din stanga
            img(i,1:coloana-1,:) = blocDinImgSintetizata(i,1:coloana-1,:);
            %copiem partea din dreapta
            img(i,coloana:end,:) = bloc(i,coloana:end,:);
        end
        
        
        
        suprapunereImgSintetizata = blocDinImgSintetizata(1:dimSuprapunere, ...
            1:end, :);
        suprapunerebloc = bloc(1:dimSuprapunere, ...
            1:end, :);
        suprapunere = (double(suprapunereImgSintetizata) - double(suprapunerebloc)) .^ 2;
        E = 0.2989 * suprapunere(:, :, 1) + ...
            0.5870 * suprapunere(:, :, 2) + ...
            0.1140 * suprapunere(:, :, 3);
        
        drum = selecteazaDrumVerical(E');
        drum = drum';
        
        for i=1:size(img,2)
            linia = drum(2, i);
            %incarcam partea de sus, cu ce aveam inainte in img.
            %sintetizata
            img(1:linia - 1,i,:) = blocDinImgSintetizata(1:linia - 1,i,:);
            %partea de jos ramane fix cum era, dupa prima procesare
        end
        
    otherwise
        error('Optiune pentru metodaSelectareDrum invalida');
end

end

