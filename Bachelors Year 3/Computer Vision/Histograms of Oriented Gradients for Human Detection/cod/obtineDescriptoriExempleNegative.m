function descriptoriExempleNegative = obtineDescriptoriExempleNegative(parametri)
% descriptoriExempleNegative = matrice MxD, unde:
%   M = numarul de exemple negative de antrenare (NU sunt fete de oameni),
%   M = parametri.numarExempleNegative
%   D = numarul de dimensiuni al descriptorului
%   in mod implicit D = (parametri.dimensiuneFereastra/parametri.dimensiuneCelula)^2*parametri.dimensiuneDescriptorCelula

imgFiles = dir( fullfile( parametri.numeDirectorExempleNegative , '*.jpg' ));
numarImagini = length(imgFiles);

numarExempleNegative_pe_imagine = round(parametri.numarExempleNegative/numarImagini);
descriptoriExempleNegative = zeros(parametri.numarExempleNegative,(parametri.dimensiuneFereastra/parametri.dimensiuneCelulaHOG)^2*parametri.dimensiuneDescriptorCelula);
disp(['Exista un numar de imagini = ' num2str(numarImagini) ' ce contine numai exemple negative']);
contor = 0;
for idx = 1:numarImagini
    disp(['Procesam imaginea numarul ' num2str(idx) ' din ' ...
        num2str(numarImagini) ' (' ...
        num2str((contor * 100) / (parametri.numarExempleNegative)) '%)']);
    img = imread([parametri.numeDirectorExempleNegative '/' imgFiles(idx).name]);
    if size(img,3) == 3
        img = rgb2gray(img);
    end 
    %completati codul functiei in continuare
   for i = 1 : numarExempleNegative_pe_imagine
       contor = contor + 1;
       x = randi(size(img, 2) - parametri.dimensiuneFereastra + 1);
       y = randi(size(img, 1) - parametri.dimensiuneFereastra + 1);
       f = img(y : y + parametri.dimensiuneFereastra - 1, x : x + parametri.dimensiuneFereastra - 1);
       hog_f = vl_hog(single(f), parametri.dimensiuneCelulaHOG);
       hog_f = reshape(hog_f, [1 numel(hog_f)]);
       descriptoriExempleNegative(contor, :) = hog_f;
   end
end