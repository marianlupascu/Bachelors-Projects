function imgMozaic = adaugaPieseMozaicPeCaroiajVeciniDiferiti(params)
%
%tratati si cazul in care imaginea de referinta este gri (are numai un canal)

imgMozaic = uint8(zeros(size(params.imgReferintaRedimensionata)));
[H,W,C,N] = size(params.pieseMozaic);
[h,w,c] = size(params.imgReferintaRedimensionata);

isGray = 0;
if c == 1
    isGray = 1;
end

switch(params.criteriu)
    case 'aleator'
        %pune o piese aleatoare in mozaic, nu tine cont de nimic
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        matrixIndicii = zeros(params.numarPieseMozaicOrizontala, params.numarPieseMozaicVerticala);
        nrPieseAdaugate = 0;
        for i = 1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                if i == 1 && j == 1
                    indice = randi(N);
                    matrixIndicii(i, j) = indice;
                end
                if i == 1 && j ~= 1
                    indice = randi(N);
                    while indice == matrixIndicii(i, j-1)
                        indice = randi(N);
                    end
                    matrixIndicii(i, j) = indice;
                end
                if i ~= 1 && j == 1
                    indice = randi(N);
                    while indice == matrixIndicii(i-1, j)
                        indice = randi(N);
                    end
                    matrixIndicii(i, j) = indice;
                end
                if i ~= 1 && j ~= 1
                    indice = randi(N);
                    while indice == matrixIndicii(i-1, j) && ...
                            indice == matrixIndicii(i, j-1)
                        indice = randi(N);
                    end
                    matrixIndicii(i, j) = indice;
                end
                
                if isGray
                    imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = rgb2gray(params.pieseMozaic(:,:,:,indice));
                else
                    imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
                end
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
    case 'distantaCuloareMedie'
        %pune o piese pe baza distantei euclidiene dintre culorile medii
        params.medieCuloarePieseMozaic = mean(mean(params.pieseMozaic(:, :, :, :)));
        
        nrTotalPiese = params.numarPieseMozaicOrizontala * params.numarPieseMozaicVerticala;
        matrixIndicii = zeros(params.numarPieseMozaicOrizontala, params.numarPieseMozaicVerticala);
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice pe baza distantei
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                        mean(mean(params.imgReferintaRedimensionata(...
                        (i-1)*H+1:i*H,(j-1)*W+1:j*W,:)))).^2, 3);
                distEuclid = distEuclid(:);
           
                if i == 1 && j == 1    
                    [minim, indice] = min(distEuclid);
                    matrixIndicii(i, j) = indice;
                end
                if i == 1 && j ~= 1
                    ind = matrixIndicii(i, j-1);
                    if ind == 1
                        A = [];
                    else
                        A = distEuclid(1: ind - 1);
                    end
                    if ind == size(distEuclid)
                        B = [];
                    else
                        B = distEuclid(ind + 1: end);
                    end
                    [minim, indice] = min([A' Inf B']);
                    matrixIndicii(i, j) = indice;
                end
                if i ~= 1 && j == 1
                    ind = matrixIndicii(i-1, j);
                    if ind == 1
                        A = [];
                    else
                        A = distEuclid(1: ind - 1);
                    end
                    if ind == size(distEuclid)
                        B = [];
                    else
                        B = distEuclid(ind + 1: end);
                    end
                    [minim, indice] = min([A' Inf B']);
                    matrixIndicii(i, j) = indice;
                end
                if i ~= 1 && j ~= 1
                    ind1 = min([matrixIndicii(i-1, j) matrixIndicii(i, j-1)]);
                    ind2 = max([matrixIndicii(i-1, j) matrixIndicii(i, j-1)]);
                    if ind1 ~= ind2
                        if ind1 == 1
                            A = [];
                        else
                            A = distEuclid(1: ind1 - 1);
                        end
                        if ind2 == size(distEuclid)
                            B = [];
                        else
                            B = distEuclid(ind2 + 1: end);
                        end
                        [minim, indice] = min([A' Inf distEuclid(ind1 + 1:ind2 - 1)' Inf B']);
                    else
                        ind = ind1;
                        if ind == 1
                            A = [];
                        else
                            A = distEuclid(1: ind - 1);
                        end
                        if ind == size(distEuclid)
                            B = [];
                        else
                            B = distEuclid(ind + 1: end);
                        end
                        [minim, indice] = min([A' Inf B']);
                    end
                    matrixIndicii(i, j) = indice;
                end
                   
                indice = matrixIndicii(i, j);
                if isGray
                    imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = rgb2gray(params.pieseMozaic(:,:,:,indice));
                else
                    imgMozaic((i-1)*H+1:i*H,(j-1)*W+1:j*W,:) = params.pieseMozaic(:,:,:,indice);
                end
                nrPieseAdaugate = nrPieseAdaugate+1;
                fprintf('Construim mozaic ... %2.2f%% \n',100*nrPieseAdaugate/nrTotalPiese);
            end
        end
        
            
    otherwise
        printf('EROARE, optiune necunoscuta \n');
end
    
    
    
    
    
