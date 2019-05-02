function descriptoriExemplePozitive = obtineDescriptoriExemplePozitive(parametri)
% descriptoriExemplePozitive = matrice NxD, unde:
%   N = numarul de exemple pozitive de antrenare (fete de oameni) 
%   D = numarul de dimensiuni al descriptorului
%   in mod implicit D = (parametri.dimensiuneFereastra/parametri.dimensiuneCelula)^2*parametri.dimensiuneDescriptorCelula

imgFiles = dir( fullfile( parametri.numeDirectorExemplePozitive, '*.jpg') ); %exemplele pozitive sunt stocate ca .jpg
numarImagini = length(imgFiles);

descriptoriExemplePozitive = zeros(numarImagini,(parametri.dimensiuneFereastra/parametri.dimensiuneCelulaHOG)^2*parametri.dimensiuneDescriptorCelula);
disp(['Exista un numar de exemple pozitive = ' num2str(numarImagini)]);pause(2);
contor = 1;
for idx = 1:numarImagini
    disp(['Procesam exemplele pozitive numarul ' num2str(contor) ...
        ' si numarul ' num2str(contor + 1) ' din ' ...
        num2str(numarImagini * 2) ' (' ...
        num2str((contor * 100) / (numarImagini * 2)) '%)']);
    img = imread([parametri.numeDirectorExemplePozitive '/' imgFiles(idx).name]);
    if size(img,3) > 1
        img = rgb2gray(img);
    end   
    %completati codul functiei in continuare
    %addpath(genpath(pwd)) pt vl_hog
    desc_hog = vl_hog(single(img), parametri.dimensiuneCelulaHOG);
    desc_hog = reshape(desc_hog, [1 numel(desc_hog)]);
    descriptoriExemplePozitive(contor, :) = desc_hog;
    contor = contor + 1;
    
    img = fliplr(img);
    desc_hog = vl_hog(single(img), parametri.dimensiuneCelulaHOG);
    desc_hog = reshape(desc_hog, [1 numel(desc_hog)]);
    descriptoriExemplePozitive(contor, :) = desc_hog;
    contor = contor + 1;
end