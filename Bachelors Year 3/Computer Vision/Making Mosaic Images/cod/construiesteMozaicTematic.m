function imgMozaic = construiesteMozaicTematic(folder, srcImgDeReferinta, clasa)

%seteaza parametri pentru functie

%citeste imaginea care va fi transformata in mozaic
%puteti inlocui numele imaginii
params.imgReferinta = imread(srcImgDeReferinta);

%seteaza numarul de piese ale mozaicului pe orizontala
%puteti inlocui aceasta valoare
params.numarPieseMozaicOrizontala = 500;
%numarul de piese ale mozaicului pe verticala va fi dedus automat

%seteaza modul de aranjare a pieselor mozaicului
%optiuni: 'aleator','caroiaj'
params.modAranjare = 'caroiaj';

%seteaza criteriul dupa care realizeze mozaicul
%optiuni: 'aleator','distantaCuloareMedie'
params.criteriu = 'distantaCuloareMedie';

%seteaza criteriul de alegere a vecinilor
%optiuni: 'nuconteaza', 'diferiti'
params.vecini = 'nuconteaza';

%%
% incarca imaginile din colectie
[trainingImages, trainingLabels, testImages, testLabels] = helperCIFAR10Data.load(folder);
idxImg = 1;
for i = 1 : size(trainingImages, 4)
    
    if trainingLabels(i) == clasa
        pieseMozaic(:, :, :, idxImg) = trainingImages(:, :, :, i);
        idxImg = idxImg + 1;
    end
end
params.pieseMozaic = uint8(pieseMozaic);

%%
% apeleaza functia principala
% params.imgReferinta = rgb2gray(params.imgReferinta);

params = calculeazaDimensiuniMozaic(params);

imgMozaic = adaugaPieseMozaicPeCaroiaj(params);

imwrite(imgMozaic,'../mozaic.jpg');
figure, imshow(imgMozaic)

end

