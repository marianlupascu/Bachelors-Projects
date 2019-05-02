function [detectii, scoruriDetectii, imageIdx] = ruleazaDetectorFacial(parametri)
% 'detectii' = matrice Nx4, unde 
%           N este numarul de detectii  
%           detectii(i,:) = [x_min, y_min, x_max, y_max]
% 'scoruriDetectii' = matrice Nx1. scoruriDetectii(i) este scorul detectiei i
% 'imageIdx' = tablou de celule Nx1. imageIdx{i} este imaginea in care apare detectia i
%               (nu punem intregul path, ci doar numele imaginii: 'albert.jpg')

% Aceasta functie returneaza toate detectiile ( = ferestre) pentru toate imaginile din parametri.numeDirectorExempleTest
% Directorul cu numele parametri.numeDirectorExempleTest contine imagini ce
% pot sau nu contine fete. Aceasta functie ar trebui sa detecteze fete atat pe setul de
% date MIT+CMU dar si pentru alte imagini (imaginile realizate cu voi la curs+laborator).
% Functia 'suprimeazaNonMaximele' suprimeaza detectii care se suprapun (protocolul de evaluare considera o detectie duplicata ca fiind falsa)
% Suprimarea non-maximelor se realizeaza pe pentru fiecare imagine.

% Functia voastra ar trebui sa calculeze pentru fiecare imagine
% descriptorul HOG asociat. Apoi glisati o fereastra de dimeniune paremtri.dimensiuneFereastra x  paremtri.dimensiuneFereastra (implicit 36x36)
% si folositi clasificatorul liniar (w,b) invatat poentru a obtine un scor. Daca acest scor este deasupra unui prag (threshold) pastrati detectia
% iar apoi procesati toate detectiile prin suprimarea non maximelor.
% pentru detectarea fetelor de diverse marimi folosit un detector multiscale

imgFiles = dir(fullfile( parametri.numeDirectorExempleTest, '*.jpg' ));
%initializare variabile de returnat
detectii = zeros(0,4);
scoruriDetectii = zeros(0,1);
imageIdx = cell(0,1);

for i = 1:length(imgFiles)
    fprintf('Rulam detectorul facial pe imaginea %s\n', imgFiles(i).name)
    img = imread(fullfile( parametri.numeDirectorExempleTest, imgFiles(i).name ));    
    if(size(img,3) > 1)
        img = rgb2gray(img);
    end
    origImg = img;    
    %completati codul functiei in continuare astfel incat sa asignati un scor ferestrelor in imagine la diferite scale
    %puneti toate ferestrele in matricea currentImg_detectii (de dimensiune nrFerestre x 4 coloane - pentru cele 4 coordonate)
    %puneti scorurile fiecarei ferestre in vectorul currentImg_scoruriDetectii (vector coloana)

    k = round(parametri.dimensiuneFereastra/parametri.dimensiuneCelulaHOG);
    
    currentImg_detectii = zeros(0,4);
    currentImg_scoruriDetectii = zeros(0,1);
    currentImg_imageIdx = cell(0,1);
    
    %imaginea initiala
    desc_hog = vl_hog(single(img), parametri.dimensiuneCelulaHOG);
    
    for l = 1 : parametri.strideFereastra : size(desc_hog, 1) - k + 1
        for c = 1 : parametri.strideFereastra : size(desc_hog, 2) - k + 1
            
            
            descriptorHOGFereastra = desc_hog(l:l+k-1,c:c+k-1,:);
            scor = descriptorHOGFereastra(:)'*parametri.w+parametri.b;
            if scor > parametri.threshold
                    
                currentImg_detectii = [currentImg_detectii; ...
                    ((c-1)*parametri.dimensiuneCelulaHOG+1) ...
                    ((l-1)*parametri.dimensiuneCelulaHOG+1) ...
                    ((c-1)*parametri.dimensiuneCelulaHOG+parametri.dimensiuneFereastra) ...
                    ceil((l-1)*parametri.dimensiuneCelulaHOG+parametri.dimensiuneFereastra)];
                currentImg_scoruriDetectii = [currentImg_scoruriDetectii scor];
                currentImg_imageIdx = [currentImg_imageIdx {imgFiles(i).name}];
            end
        end
    end
    
    %imaginea marita
    for factorDeMarire = 10 : 10 : 50
        img = imresize(origImg, 1 + factorDeMarire/100);
        desc_hog = vl_hog(single(img), parametri.dimensiuneCelulaHOG);
    
        for l = 1 : parametri.strideFereastra : size(desc_hog, 1) - k + 1
            for c = 1 : parametri.strideFereastra : size(desc_hog, 2) - k + 1

                descriptorHOGFereastra = desc_hog(l:l+k-1,c:c+k-1,:);
                scor = descriptorHOGFereastra(:)'*parametri.w+parametri.b;
                alfa_x = size(origImg,2)/size(img,2);
                alfa_y = size(origImg,1)/size(img,1);
                if scor > parametri.threshold

                    currentImg_detectii = [currentImg_detectii; ...
                        ceil(((c-1)*parametri.dimensiuneCelulaHOG+1)*alfa_x) ...
                        ceil(((l-1)*parametri.dimensiuneCelulaHOG+1)*alfa_y) ...
                        ceil(((c-1)*parametri.dimensiuneCelulaHOG+parametri.dimensiuneFereastra)*alfa_x) ...
                        ceil(((l-1)*parametri.dimensiuneCelulaHOG+parametri.dimensiuneFereastra)*alfa_y)];
                    currentImg_scoruriDetectii = [currentImg_scoruriDetectii scor];
                    currentImg_imageIdx = [currentImg_imageIdx {imgFiles(i).name}];
                end
            end
        end
    end
    
    %imaginea micsorata
    for factorDeMicsorare = 10 : 10 : 80
        img = imresize(origImg, 1 - factorDeMicsorare/100);
        desc_hog = vl_hog(single(img), parametri.dimensiuneCelulaHOG);
    
        for l = 1 : parametri.strideFereastra : size(desc_hog, 1) - k + 1
            for c = 1 : parametri.strideFereastra : size(desc_hog, 2) - k + 1

                descriptorHOGFereastra = desc_hog(l:l+k-1,c:c+k-1,:);
                scor = descriptorHOGFereastra(:)'*parametri.w+parametri.b;
                alfa_x = size(origImg,2)/size(img,2);
                alfa_y = size(origImg,1)/size(img,1);
                if scor > parametri.threshold

                    currentImg_detectii = [currentImg_detectii; ...
                        ceil(((c-1)*parametri.dimensiuneCelulaHOG+1)*alfa_x) ...
                        ceil(((l-1)*parametri.dimensiuneCelulaHOG+1)*alfa_y) ...
                        ceil(((c-1)*parametri.dimensiuneCelulaHOG+parametri.dimensiuneFereastra)*alfa_x) ...
                        ceil(((l-1)*parametri.dimensiuneCelulaHOG+parametri.dimensiuneFereastra)*alfa_y)];
                    currentImg_scoruriDetectii = [currentImg_scoruriDetectii scor];
                    currentImg_imageIdx = [currentImg_imageIdx {imgFiles(i).name}];
                end
            end
        end
    end

    %aplica nms
    ndx = find(currentImg_scoruriDetectii>parametri.threshold);
    currentImg_detectii = currentImg_detectii(ndx,:);
    currentImg_scoruriDetectii = currentImg_scoruriDetectii(ndx);
    currentImg_imageIdx = currentImg_imageIdx(ndx);
    %suprimeaza non-maximele  
    if size(currentImg_detectii,1)>0
       [is_maximum] = eliminaNonMaximele(currentImg_detectii, currentImg_scoruriDetectii, size(origImg));
        currentImg_scoruriDetectii = currentImg_scoruriDetectii(is_maximum);
        currentImg_detectii = currentImg_detectii(is_maximum,:);
        currentImg_imageIdx = currentImg_imageIdx(is_maximum);
    end    
    detectii = [detectii; currentImg_detectii];
    scoruriDetectii = [scoruriDetectii currentImg_scoruriDetectii];
    imageIdx = vertcat(imageIdx, currentImg_imageIdx'); 
end




