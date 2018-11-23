function imgMozaic = adaugaPieseMozaicPeCaroiajHexagon(params)
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

switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        for i=1:Hm:h + Hm
            for j=1:Wm + bazaHexagon:w+Wm
                %alege un indice aleator din cele N
                indice = randi(N);
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
                fprintf('Construim mozaic ... %2.2f%% \n',50*((i-1)*(h+ Hm)+j)/((h*w)));
            end
        end
        
        for i=floor(Hm/2) + 1:Hm:h+ Hm
            for j=bazaHexagon + defazaj + 1:Wm + bazaHexagon:w+Wm
                %alege un indice aleator din cele N
                indice = randi(N);
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
                fprintf('Construim mozaic ... %2.2f%% \n',50 + 50*((i-1)*(h+ Hm)+j)/(h*w));
            end
        end
        
        imgMozaic = ...
            imgMozaic(Hm+1:h+Hm, defazaj + bazaHexagon + 1:w+defazaj + bazaHexagon, :);
        fprintf('Construim mozaic ... %2.2f%% \n',100);
        
    case 'distantaCuloareMedie'
        %pune o piese pe baza distantei euclidiene dintre culorile medii
        params.medieCuloarePieseMozaic = mean(mean(params.pieseMozaic(:, :, :, :).*masca));
        
        aux = params.imgReferintaRedimensionata;
        params.imgReferintaRedimensionata = uint8(zeros([h + 2 * size(masca, 1), w +  2 * size(masca, 2), c]));
        params.imgReferintaRedimensionata(floor(Hm/2) + 1:h+floor(Hm/2), defazaj + bazaHexagon + 1:w+defazaj + bazaHexagon, :) = ...
            aux;
        
        for i=Hm+1:Hm:h + Hm
            for j=Wm + bazaHexagon+1:Wm + bazaHexagon:w + Wm
                %alege un indice pe baza distantei
                
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca.*params.imgReferintaRedimensionata(i:i+Hm-1,j:j+Wm-1,:)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
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
                 fprintf('Construim mozaic ... %2.2f%% \n',50*((i-1)*(h+ Hm)+j)/((h*w)));
            end
        end
        
        for i=floor(Hm/2) + 1:Hm:h+ Hm
            for j=bazaHexagon + defazaj + 1:Wm + bazaHexagon:w+Wm
                %alege un indice pe baza distantei
                
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca.*params.imgReferintaRedimensionata(i:i+Hm-1,j:j+Wm-1,:)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
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
                fprintf('Construim mozaic ... %2.2f%% \n',50+50*((i-1)*(h+ Hm)+j)/((h*w)));
                acoperire = 50+50*((i-1)*(h+ Hm)+j)/((h*w));
            end
        end
        
            
        %prima linie
            i = 1;
            for j=Wm + bazaHexagon + 1:Wm + bazaHexagon:w + Wm
                %alege un indice pe baza distantei
                
                l = floor(Hm/2)+1;
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca(l:end, :).*params.imgReferintaRedimensionata(l:Hm,j:j+Wm-1,:)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
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
            fprintf('Construim mozaic ... %2.2f%% \n',acoperire + 4);
            
            %ultima linie
            i = h - floor(Hm/2) + 1;
            for j=bazaHexagon + defazaj + 1:Wm + bazaHexagon:w + Wm
                %alege un indice pe baza distantei
                
                l = floor(Hm/2);
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca(1:l, :).*params.imgReferintaRedimensionata(i:i+l-1,j:j+Wm-1,:)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
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
            fprintf('Construim mozaic ... %2.2f%% \n',acoperire + 8);
            
            %prima coloana
            j = 1;
            for i=Hm+1:Hm:h+Hm
                %alege un indice pe baza distantei
                
                c = 1 + defazaj + bazaHexagon;
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca(:, c:end).*params.imgReferintaRedimensionata(i:i+Hm-1,c:Wm,:)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
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
            fprintf('Construim mozaic ... %2.2f%% \n',acoperire + 12);
            
            %ultima coloana
            j = w+bazaHexagon + defazaj;
            for i=Hm+1:Hm:h
                %alege un indice pe baza distantei
                
                c = defazaj + 1;
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca(:, 1:c).*params.imgReferintaRedimensionata(i:i+Hm-1,j:j+c-1,:)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
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
            fprintf('Construim mozaic ... %2.2f%% \n',acoperire + 16);
            
            % dreapta sus
            i = 1;
            j = w+ defazaj + bazaHexagon - 1;
            distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca(floor(Hm/2)+1: end, 1: defazaj) ...
                    .*params.imgReferintaRedimensionata(floor(Hm/2)+1:Hm, j:j+defazaj-1, :)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
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
                
            % stanga sus
            i = 1;
            j = 1;
            distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(masca(floor(Hm/2)+1: end, bazaHexagon + defazaj + 1:end) ...
                    .*params.imgReferintaRedimensionata(floor(Hm/2)+1:Hm, bazaHexagon + defazaj + 1:Wm, :)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
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
        
        fprintf('Construim mozaic ... %2.2f%% \n',100);
        imgMozaic = ...
            imgMozaic(floor(Hm/2) + 1:h+floor(Hm/2), defazaj + bazaHexagon + 1:w+defazaj + bazaHexagon, :);
            
    otherwise
        printf('EROARE, optiune necunoscuta \n');
end
    
    
    
    
    
