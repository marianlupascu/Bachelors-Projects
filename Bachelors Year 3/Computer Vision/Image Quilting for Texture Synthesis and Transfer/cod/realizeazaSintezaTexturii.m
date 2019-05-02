function imgSintetizata = realizeazaSintezaTexturii(parametri, transferTextura)

if nargin < 2
    transferTextura = 0;
end

dimBloc = parametri.dimensiuneBloc;
nrBlocuri = parametri.nrBlocuri;

[inaltimeTexturaInitiala,latimeTexturaInitiala,nrCanale] = ...
    size(parametri.texturaInitiala);
H = inaltimeTexturaInitiala;
W = latimeTexturaInitiala;
c = nrCanale;

H2 = parametri.dimensiuneTexturaSintetizata(1);
W2 = parametri.dimensiuneTexturaSintetizata(2);
overlap = parametri.portiuneSuprapunere;

err = parametri.eroareTolerata;

% o imagine este o matrice cu 3 dimensiuni: inaltime x latime x nrCanale
% variabila blocuri - matrice cu 4 dimensiuni: punem fiecare bloc 
% (portiune din textura initiala) unul peste altul 
dims = [dimBloc dimBloc c nrBlocuri];
blocuri = uint8(zeros(dims(1), dims(2),dims(3),dims(4)));

%selecteaza blocuri aleatoare din textura initiala
%genereaza (in maniera vectoriala) punctul din stanga sus al blocurilor
y = randi(H-dimBloc+1,nrBlocuri,1);
x = randi(W-dimBloc+1,nrBlocuri,1);
%extrage portiunea din textura initiala continand blocul
for i =1:nrBlocuri
    blocuri(:,:,:,i) = ...
        parametri.texturaInitiala(y(i):y(i)+dimBloc-1,x(i):x(i)+dimBloc-1,:);
end

imgSintetizata = uint8(zeros(H2,W2,c));

switch parametri.metodaSinteza

    case 'blocuriAleatoare'
        %%
        %completeaza imaginea de obtinut cu blocuri aleatoare
        
        nrBlocuriY = ceil(H2/dimBloc);
        nrBlocuriX = ceil(W2/dimBloc);
        imgSintetizataMaiMare = uint8(zeros(nrBlocuriY * ...
        	dimBloc, nrBlocuriX * dimBloc, c));
        
        for y=1:nrBlocuriY
            for x=1:nrBlocuriX
                indice = randi(nrBlocuri);
                imgSintetizataMaiMare((y-1)*dimBloc+1:y*dimBloc,(x-1)*dimBloc+1:x*dimBloc,:)=blocuri(:,:,:,indice);
            end
        end
        
        imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
        
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imgSintetizata);
        title('Rezultat obtinut pentru blocuri selectatate aleator');
        return

    
    case 'eroareSuprapunere'
        %%
        %completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere    
        
        dimSuprapunere = ceil(dimBloc * overlap);
        nrBlocuriY = ceil(H2/(dimBloc-dimSuprapunere)) + 1;
        nrBlocuriX = ceil(W2/(dimBloc-dimSuprapunere)) + 1;
        imgSintetizataMaiMare = uint8(zeros(...
            nrBlocuriY * (dimBloc-dimSuprapunere) + dimSuprapunere, ...
            nrBlocuriX * (dimBloc-dimSuprapunere) + dimSuprapunere, c));
        
        for y=1:nrBlocuriY
            for x=1:nrBlocuriX
                startY = (y - 1) * (dimBloc-dimSuprapunere) + 1;
                startX = (x - 1) * (dimBloc-dimSuprapunere) + 1;
                endY = startY + dimBloc - 1;
                endX = startX + dimBloc - 1;
                
                if x == 1 && y == 1 % stanga sus
                    indice = randi(nrBlocuri);
                end 
                
                if x > 1 && y == 1 % prima linie
                    suprapunereImg = imgSintetizataMaiMare(startY:endY,...
                        startX:startX + dimSuprapunere - 1, :);
                    indice = getIndiceDistantaMinima(blocuri, ...
                        suprapunereImg, NaN, dimSuprapunere, err);
                end 
                
                if x == 1 && y > 1 % prima coloana
                    suprapunereImg = imgSintetizataMaiMare(...
                        startY:startY + dimSuprapunere - 1, startX:endX, :);
                    indice = getIndiceDistantaMinima(blocuri, NaN, ...
                        suprapunereImg, dimSuprapunere, err);
                end 
                
                if x > 1 && y > 1 % restul
                    suprapunereImgStanga = imgSintetizataMaiMare(startY:endY,...
                        startX:startX + dimSuprapunere - 1, :);
                    suprapunereImgSus = imgSintetizataMaiMare(...
                        startY:startY + dimSuprapunere - 1, startX + dimSuprapunere:endX, :);
                    % suprapunereImgSus contine suprapunerea cu partea de
                    % sus, dar fara partea comuna cu suprapunerea din
                    % partea dreapta
                    indice = getIndiceDistantaMinima(blocuri, suprapunereImgStanga, ...
                        suprapunereImgSus, dimSuprapunere, err);
                end 
                
                imgSintetizataMaiMare(startY:endY, startX:endX,:)=blocuri(:,:,:,indice);
            end
        end
        
        imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
        
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imgSintetizata);
        title('Rezultat obtinut pentru cazul eroare de suprapunere minima');
        return
        
        
	case 'frontieraCostMinim'
        %
        %completeaza imaginea de obtinut cu blocuri ales in functie de eroare de suprapunere + forntiera de cost minim
        dimSuprapunere = ceil(dimBloc * overlap);
        nrBlocuriY = ceil(H2/(dimBloc-dimSuprapunere)) + 1;
        nrBlocuriX = ceil(W2/(dimBloc-dimSuprapunere)) + 1;
        imgSintetizataMaiMare = uint8(zeros(...
            nrBlocuriY * (dimBloc-dimSuprapunere) + dimSuprapunere, ...
            nrBlocuriX * (dimBloc-dimSuprapunere) + dimSuprapunere, c));
        
        for y=1:nrBlocuriY
            for x=1:nrBlocuriX
                nrBlocuriY
                y
                nrBlocuriX
                x
                startY = (y - 1) * (dimBloc-dimSuprapunere) + 1;
                startX = (x - 1) * (dimBloc-dimSuprapunere) + 1;
                endY = startY + dimBloc - 1;
                endX = startX + dimBloc - 1;
                
                if transferTextura ~= 0
                    
                    endYNou = endY;
                    endXNou = endX;
                    imgReferinta = parametri.imgReferinta ;
                    
                    if endY > size(imgReferinta, 1)
                        if startY > size(imgReferinta, 1)
                            patchSintezaAnterior = 0;
                            patchImgReferinta = 0;
                            continue;
                        end
                        endYNou = size(imgReferinta, 1);
                    end

                    if endX > size(imgReferinta, 2)
                        if startX > size(imgReferinta, 2)
                            patchSintezaAnterior = 0;
                            patchImgReferinta = 0;
                            continue;
                        end
                        endXNou = size(imgReferinta, 2);
                    end
                    
                    patchImgReferinta = imgReferinta(startY:endYNou, startX:endXNou, :);
                    if transferTextura == 1
                        patchSintezaAnterior = 0;
                    else
                        patchSintezaAnterior = parametri.imgSintetizata(startY:endYNou, startX:endXNou, :);
                    end
                end
                
                if x == 1 && y == 1 % stanga sus
                    if transferTextura == 0 % cazul in care nu
                        %folosesc acesata ramura pentru transferul texturii
                        indice = randi(nrBlocuri);
                    else % aici fac transfer de textura
                        
                        indice = getIndiceDistantaMinimaCuAlfa(blocuri, ...
                            NaN, NaN, dimSuprapunere, err, ...
                            parametri.alfa, ...
                            patchImgReferinta, ...
                            patchSintezaAnterior);
                    end
                    imgSintetizataMaiMare(startY:endY, startX:endX,:)=...
                    	blocuri(:,:,:,indice);
                end 
                
                if x > 1 && y == 1 % prima linie
                    suprapunereImg = imgSintetizataMaiMare(startY:endY,...
                        startX:startX + dimSuprapunere - 1, :);
                    if transferTextura == 0 % cazul in care nu
                        %folosesc acesata ramura pentru transferul texturii
                        indice = getIndiceDistantaMinima(blocuri, ...
                            suprapunereImg, NaN, dimSuprapunere, err);
                    else % aici fac transfer de textura
                        
                        indice = getIndiceDistantaMinimaCuAlfa(blocuri, ...
                            suprapunereImg, NaN, dimSuprapunere, err, ...
                            parametri.alfa, ...
                            patchImgReferinta, ...
                            patchSintezaAnterior);
                    end
                    
                    imgSintetizataMaiMare(startY:endY, startX:endX,:)= ...
                    updateCfFrontieraCostMinim(imgSintetizataMaiMare(startY:endY, startX:endX,:), ...
                    blocuri(:,:,:,indice), dimSuprapunere, 1);
                end 
                
                if x == 1 && y > 1 % prima coloana
                    suprapunereImg = imgSintetizataMaiMare(...
                        startY:startY + dimSuprapunere - 1, startX:endX, :);
                    if transferTextura == 0
                        indice = getIndiceDistantaMinima(blocuri, NaN, ...
                            suprapunereImg, dimSuprapunere, err);
                    else
                        indice = getIndiceDistantaMinimaCuAlfa(blocuri, NaN, ...
                            suprapunereImg, dimSuprapunere, err, ...
                            parametri.alfa, ...
                            patchImgReferinta, ...
                            patchSintezaAnterior);
                    end
                    
                    imgSintetizataMaiMare(startY:endY, startX:endX,:)= ...
                    updateCfFrontieraCostMinim(imgSintetizataMaiMare(startY:endY, startX:endX,:), ...
                    blocuri(:,:,:,indice), dimSuprapunere, 2);
                end 
                
                if x > 1 && y > 1 % restul
                    suprapunereImgStanga = imgSintetizataMaiMare(startY:endY,...
                        startX:startX + dimSuprapunere - 1, :);
                    suprapunereImgSus = imgSintetizataMaiMare(...
                        startY:startY + dimSuprapunere - 1, startX + dimSuprapunere:endX, :);
                    % suprapunereImgSus contine suprapunerea cu partea de
                    % sus, dar fara partea comuna cu suprapunerea din
                    % partea dreapta
                    if transferTextura == 0
                        indice = getIndiceDistantaMinima(blocuri, suprapunereImgStanga, ...
                            suprapunereImgSus, dimSuprapunere, err);
                    else
                        indice = getIndiceDistantaMinimaCuAlfa(blocuri, suprapunereImgStanga, ...
                            suprapunereImgSus, dimSuprapunere, err, ...
                            parametri.alfa, ...
                            patchImgReferinta, ...
                            patchSintezaAnterior);
                    end
                    
                    imgSintetizataMaiMare(startY:endY, startX:endX,:)= ...
                    updateCfFrontieraCostMinim(imgSintetizataMaiMare(startY:endY, startX:endX,:), ...
                    blocuri(:,:,:,indice), dimSuprapunere, 3);
                end 
            end
        end
        
        imgSintetizata = imgSintetizataMaiMare(1:size(imgSintetizata,1),1:size(imgSintetizata,2),:);
        
        figure, imshow(parametri.texturaInitiala)
        figure, imshow(imgSintetizata);
        title('Rezultat obtinut pentru cazul eroare de suprapunere minima');
        return
        
    case 'transferTextura'
        parametri.dimensiuneTexturaSintetizata = ...
            [size(parametri.imgReferinta, 1), size(parametri.imgReferinta, 2)];
        parametri.metodaSinteza = 'frontieraCostMinim';
        N = parametri.N;
        for i = 1 : N
            alfa = 0.8 * ((i-1) / (N - 1)) + 0.1;
            parametri.alfa = alfa;
            imgSintetizata = realizeazaSintezaTexturii(parametri, i);
            imwrite(imgSintetizata,['../transferTextura_' num2str(i) '_rice_eminescu.jpg']);
            parametri.imgSintetizata = imgSintetizata;
            parametri.dimensiuneBloc = floor(parametri.dimensiuneBloc / 3);
            title('Rezultat obtinut pentru cazul eroare de transfer de textura');
            if ceil(parametri.dimensiuneBloc * overlap) == 1
                break;
            end
        end
        
        return
        
    otherwise
        disp("Optiune invalida");
       
end
       
    
