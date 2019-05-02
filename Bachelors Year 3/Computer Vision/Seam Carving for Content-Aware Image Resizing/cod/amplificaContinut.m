function imgRedimensionata_proiect = amplificaContinut(img, factor, metodaSelectareDrum)

newImg = imresize(img, 1 + factor); %maresc imaginea cu factorul dat
difW = size(newImg, 2) - size(img, 2);
difH = size(newImg, 1) - size(img, 1);

parametri.optiuneRedimensionare = 'micsoreazaLatime'; % setez parametrii
parametri.numarPixeliLatime = difW;
parametri.numarPixeliInaltime = difH;
parametri.ploteazaDrum = 0;
parametri.culoareDrum = [255 0 0]';%culoarea rosie
parametri.metodaSelectareDrum = metodaSelectareDrum;

%fac eliminarile de drumuri, astfel incat in imaginea rezultata sa am numai
%continut interesant
imgRedimensionata_proiect = redimensioneazaImagine(newImg,parametri);
parametri.optiuneRedimensionare = 'micsoreazaInaltime';
imgRedimensionata_proiect = redimensioneazaImagine(imgRedimensionata_proiect,parametri);

end

