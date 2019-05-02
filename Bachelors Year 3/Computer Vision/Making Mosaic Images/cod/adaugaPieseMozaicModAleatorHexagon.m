function imgMozaic = adaugaPieseMozaicModAleatorHexagon(params)

pragEuristicaDeTrecere = 95;

[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);
imgMozaic = zeros([h + H - 1, w + W - 1, c]) - 1;

isGray = 0;
if c == 1
    isGray = 1;
end

switch(params.criteriu)
    case 'aleator'
        nrTotalPixeli = h * w;
        acoperire = 0;
        ok = 1;
        iteratie = 0;
        while ok == 1
            iteratie = iteratie + 1;
            indice = randi(N);
            i = max([randi(h) - H, 1]);
            j = max([randi(w) - W, 1]);
            while imgMozaic(i, j, 1) ~= -1
                i = max([randi(h) - H + 1, 1]);
                j = max([randi(w) - W + 1, 1]);
            end
            if isGray
                imgMozaic(i:i+H-1, j:j+W-1, :) = ...
                    rgb2gray(params.pieseMozaic(:,:,:,indice));
            else
                imgMozaic(i:i+H-1, j:j+W-1, :) = ...
                    params.pieseMozaic(:,:,:,indice);
            end
            
            if iteratie > 500
                % fac calculul de umplere si sfisarile din 500 in 500 de
                % iteratii pentru a scoate un timp mai bun
                iteratie = 1;
                acoperire = size(find(imgMozaic(:, :, 1)~=-1), 1);
                if 100*acoperire/nrTotalPixeli >= pragEuristicaDeTrecere
                    ok = 0;
                end
                fprintf('Construim mozaic ... %2.2f%% \n', ...
                    100*acoperire/nrTotalPixeli);
            end
        end
        
        for i = 1:params.numarPieseMozaicVerticala
            for j = 1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);
                [l, c] = find(imgMozaic((i-1)*H+1:i*H, ...
                    (j-1)*W+1:j*W,1) == -1);
                if isempty(l)
                    continue;
                end
                l = min(l) + (i-1)*H;
                c = min(c) + (j-1)*W;
                plusAcoperire = size(find(imgMozaic(l:min([l+H-1, h]), ...
                    c:min([c+W-1, w]),1) == -1), 1);
                if isGray
                    imgMozaic(l:l+H-1,c:c+W-1,:) = ...
                        rgb2gray(params.pieseMozaic(:,:,:,indice));
                else
                    imgMozaic(l:l+H-1,c:c+W-1,:) = ...
                        params.pieseMozaic(:,:,:,indice);
                end
                acoperire = acoperire + plusAcoperire;
                fprintf('Construim mozaic ... %2.2f%% \n', ...
                    100*acoperire/nrTotalPixeli);
            end
        end
        
        
    case 'distantaCuloareMedie'
        params.medieCuloarePieseMozaic = mean(mean(params.pieseMozaic(:, :, :, :)));
        
        nrTotalPixeli = h * w;
        acoperire = 0;
        ok = 1;
        iteratie = 0;
        while ok == 1
            iteratie = iteratie + 1;
            i = max([randi(h) - H, 1]);
            j = max([randi(w) - W, 1]);
            while imgMozaic(i, j, 1) ~= -1
                i = max([randi(h) - H + 1, 1]);
                j = max([randi(w) - W + 1, 1]);
            end
            distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(params.imgReferintaRedimensionata(i:i+H-1, j:j+W-1, :)))).^2, 3);
                [minim, indice] = min(distEuclid);
            if isGray
                imgMozaic(i:i+H-1, j:j+W-1, :) = ...
                    rgb2gray(params.pieseMozaic(:,:,:,indice));
            else
                imgMozaic(i:i+H-1, j:j+W-1, :) = ...
                    params.pieseMozaic(:,:,:,indice);
            end
            
            if iteratie > 500
                % fac calculul de umplere si sfisarile din 500 in 500 de
                % iteratii pentru a scoate un timp mai bun
                iteratie = 1;
                acoperire = size(find(imgMozaic(:, :, 1)~=-1), 1);
                if 100*acoperire/nrTotalPixeli >= pragEuristicaDeTrecere
                    ok = 0;
                end
                fprintf('Construim mozaic ... %2.2f%% \n', ...
                    100*acoperire/nrTotalPixeli);
            end
        end
        
        for i = 1:params.numarPieseMozaicVerticala
            for j = 1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                [l, c] = find(imgMozaic((i-1)*H+1:i*H, ...
                    (j-1)*W+1:j*W,1) == -1);
                if isempty(l)
                    continue;
                end
                l = min(l) + (i-1)*H;
                c = min(c) + (j-1)*W;
                plusAcoperire = size(find(imgMozaic(l:min([l+H-1, h]), ...
                    c:min([c+W-1, w]),1) == -1), 1);
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(params.imgReferintaRedimensionata(l:min([l+H-1, h]), c:min([c+W-1, w]), :)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
                if isGray
                    imgMozaic(l:l+H-1,c:c+W-1,:) = ...
                        rgb2gray(params.pieseMozaic(:,:,:,indice));
                else
                    imgMozaic(l:l+H-1,c:c+W-1,:) = ...
                        params.pieseMozaic(:,:,:,indice);
                end
                acoperire = acoperire + plusAcoperire;
                fprintf('Construim mozaic ... %2.2f%% \n', ...
                    100*acoperire/nrTotalPixeli);
            end
        end
        
    otherwise
        printf('EROARE, optiune necunoscuta \n');
    
end

imgMozaic = imgMozaic(1:size(params.imgReferintaRedimensionata, 1), ...
    1:size(params.imgReferintaRedimensionata, 2), :);
[l, c] = find(imgMozaic(:, :, 1) == -1);
c
imgMozaic = uint8(imgMozaic);
end
