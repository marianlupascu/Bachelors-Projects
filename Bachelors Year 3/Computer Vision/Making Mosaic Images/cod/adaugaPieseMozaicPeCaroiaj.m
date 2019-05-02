function imgMozaic = adaugaPieseMozaicPeCaroiaj(params)
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
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice aleator din cele N
                indice = randi(N);
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
        nrPieseAdaugate = 0;
        for i =1:params.numarPieseMozaicVerticala
            for j=1:params.numarPieseMozaicOrizontala
                %alege un indice pe baza distantei
                
                distEuclid = sum(( params.medieCuloarePieseMozaic - ...
                    mean(mean(params.imgReferintaRedimensionata((i-1)*H+1:i*H,(j-1)*W+1:j*W,:)))).^2, 3);
                distEuclid = distEuclid(:);
                [minim, indice] = min(distEuclid);
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
    
    
    
    
    
