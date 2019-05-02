function imgMozaic = adaugaPieseMozaicPeCaroiajVeciniDiferitiHexagon(params)
%
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)

[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);

[masca, bazaHexagon, defazaj, Hm, Wm] = mascaHexagon(H, W);
imgMozaic = uint8(zeros([h + 2 * size(masca, 1), w +  2 * size(masca, 2), c]));
acoperire = 0;

isGray = 0;
if c == 1
    isGray = 1;
end

matrixIndicii = 0;

 fprintf('Construim mozaic ... \n');
switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        
        i = 1;
        indexi = 1;
        indexj = 1;
            for j=1:Wm + bazaHexagon:w+Wm
                %alege un indice aleator din cele N
                indice = randi(N);
                matrixIndicii(indexi, indexj) = indice;
                indexj = indexj + 2;
                if isGray
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        rgb2gray( ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:));
                else
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:);
                end
            end
            
        indexi = 3;
        indexj = 1;
        for i=1 + Hm:Hm:h + Hm
            indexj = 1;
            for j=1:Wm + bazaHexagon:w+Wm
                %alege un indice aleator din cele N
                indice = randi(N);
                while indice == matrixIndicii(indexi-2, indexj)
                        indice = randi(N);
                end
                matrixIndicii(indexi, indexj) = indice;
                indexj = indexj + 2;
                if isGray
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        rgb2gray( ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:));
                else
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:);
                end
            end
            indexi = indexi + 2;
        end
        
        indexi = 2;
        indexj = 2;
        i=floor(Hm/2) + 1;
            for j=bazaHexagon + defazaj + 1:Wm + bazaHexagon:w+Wm
                %alege un indice aleator din cele N
                indice = randi(N);
                while indice == matrixIndicii(indexi-1, indexj-1) && ...
                        indice == matrixIndicii(indexi-1, indexj+1)
                        indice = randi(N);
                end
                matrixIndicii(indexi, indexj) = indice;
                indexj = indexj + 2;
                if isGray
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        rgb2gray( ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:));
                else
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:);
                end
            end
            
        indexi = 4;
        for i=floor(Hm/2) + 1 + Hm:Hm:h+ Hm
            indexj = 2;
            for j=bazaHexagon + defazaj + 1:Wm + bazaHexagon:w+Wm
                %alege un indice aleator din cele N
                indice = randi(N);
                while indice == matrixIndicii(indexi-1, indexj-1) && ...
                        indice == matrixIndicii(indexi-1, indexj+1) && ...
                        indice == matrixIndicii(indexi-1, indexj)
                        indice = randi(N);
                end
                matrixIndicii(indexi, indexj) = indice;
                indexj = indexj + 2;
                if isGray
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        rgb2gray( ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:));
                else
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:);
                end
            end
            indexi = indexi + 2;
        end
        
        imgMozaic = ...
            imgMozaic(Hm+1:h+Hm, defazaj + bazaHexagon + 1:w+defazaj + bazaHexagon, :);
        fprintf('Construim mozaic ... %2.2f%% \n',100);
        
    case 'distantaCuloareMedie'
        %pune o piese pe baza distantei euclidiene dintre culorile medii
        params.medieCuloarePieseMozaic = mean(mean(params.pieseMozaic(:, :, :, :).*masca));
        
        i = 1;
        indexi = 1;
        indexj = 1;
            for j=1:Wm + bazaHexagon:w-Wm+1
                %alege un indice aleator din cele N
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca.*params.imgReferintaRedimensionata(i:i+Hm-1,j:j+Wm-1,:)))).^2, 3);
                distEuclid = distEuclid(:);
                n = size(distEuclid, 1);
                [minim, indice] = min(distEuclid);
                matrixIndicii(indexi, indexj) = indice;
                indexj = indexj + 2;
                if isGray
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        rgb2gray( ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:));
                else
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:);
                end
            end
            
        indexi = 3;
        indexj = 1;
        for i=1 + Hm:Hm:h - Hm + 1
            indexj = 1;
            for j=1:Wm + bazaHexagon:w-Wm+1
                %alege un indice aleator din cele N
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca.*params.imgReferintaRedimensionata(i:i+Hm-1,j:j+Wm-1,:)))).^2, 3);
                distEuclid = distEuclid(:);
                n = size(distEuclid, 1);
                [minim, indice] = min(distEuclid);
                
                    if indice == matrixIndicii(indexi - 2, indexj)
                        if indice == 1
                            distEuclid = [Inf, distEuclid(2:end)'];
                        end
                        if indice == n
                            distEuclid = [distEuclid(1:end-1)', Inf];
                        end
                        if indice ~= 1 && indice ~= n
                            distEuclid = [distEuclid(1:indice -1)', Inf, distEuclid(indice+1:end)'];
                        end
                        distEuclid = distEuclid';
                        [minim, indice] = min(distEuclid);
                    end
                    matrixIndicii(i, j) = indice;
                
                matrixIndicii(indexi, indexj) = indice;
                indexj = indexj + 2;
                if isGray
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        rgb2gray( ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:));
                else
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:);
                end
            end
            indexi = indexi + 2;
        end
        
        indexi = 2;
        indexj = 2;
        i=floor(Hm/2) + 1;
            for j=bazaHexagon + defazaj + 1:Wm + bazaHexagon:w-Wm
                %alege un indice pe baza distantei
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca.*params.imgReferintaRedimensionata(i:i+Hm-1,j:j+Wm-1,:)))).^2, 3);
                distEuclid = distEuclid(:);
                n = size(distEuclid, 1);
                [minim, indice] = min(distEuclid);
                
                    for k = 1 : 2
                    if indice == matrixIndicii(indexi - 1, indexj-1) || ...
                            indice == matrixIndicii(indexi + 1, indexj-1)
                        if indice == 1
                            distEuclid = [Inf, distEuclid(2:end)'];
                        end
                        if indice == n
                            distEuclid = [distEuclid(1:end-1)', Inf];
                        end
                        if indice ~= 1 && indice ~= n
                            distEuclid = [distEuclid(1:indice -1)', Inf, distEuclid(indice+1:end)'];
                        end
                        distEuclid = distEuclid';
                        [minim, indice] = min(distEuclid);
                    else
                        break;
                    end
                end
                
                matrixIndicii(indexi, indexj) = indice;
                indexj = indexj + 2;
                if isGray
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        rgb2gray( ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:));
                else
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:);
                end
            end

        indexi = 4;
        for i=floor(Hm/2) + 1+Hm:Hm:h- Hm
            indexj = 2;
            for j=bazaHexagon + defazaj + 1:Wm + bazaHexagon:w-Wm
                %alege un indice pe baza distantei
                
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca.*params.imgReferintaRedimensionata(i:i+Hm-1,j:j+Wm-1,:)))).^2, 3);
                distEuclid = distEuclid(:);
                n = size(distEuclid, 1);
                [minim, indice] = min(distEuclid);
                
                for k = 1 : 5
                    if indice == matrixIndicii(indexi - 2, indexj) || ...
                            indice == matrixIndicii(indexi - 1, indexj-1) || ...
                            indice == matrixIndicii(indexi + 1, indexj-1) || ...
                            indice == matrixIndicii(indexi - 1, indexj+1) || ...
                            indice == matrixIndicii(indexi + 1, indexj+1)
                        if indice == 1
                            distEuclid = [Inf, distEuclid(2:end)'];
                        end
                        if indice == n
                            distEuclid = [distEuclid(1:end-1)', Inf];
                        end
                        if indice ~= 1 && indice ~= n
                            distEuclid = [distEuclid(1:indice -1)', Inf, distEuclid(indice+1:end)'];
                        end
                        distEuclid = distEuclid';
                        [minim, indice] = min(distEuclid);
                    else
                        break;
                    end
                end
                
                matrixIndicii(indexi, indexj) = indice;
                indexj = indexj + 2;
                if isGray
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        rgb2gray( ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:));
                else
                    imgMozaic(i:i+Hm-1,j:j+Wm-1,:) = ...
                        params.pieseMozaic(:,:,:,indice) .* masca + ...
                        (1 - masca) .* imgMozaic(i:i+Hm-1,j:j+Wm-1,:);
                end
            end
            indexi = indexi +2;
        end
        
        imgMozaic = ...
            imgMozaic(floor(Hm/2)+1:h-floor(Hm/2)-1, defazaj + bazaHexagon + 1:w-Wm-1, :);
        imgMozaic = imresize(imgMozaic ,[h, w]);
        fprintf('Construim mozaic ... %2.2f%% \n',100);
        
    otherwise
        printf('EROARE, optiune necunoscuta \n');
end
    
    
    
    
    
