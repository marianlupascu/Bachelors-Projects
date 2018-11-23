function imgRedimensionata = redimensioneazaImagine(img,parametri)
%redimensioneaza imaginea
%
%input: img - imaginea initiala
%       parametri - stuctura ce defineste modul in care face redimensionarea 
%
% output: imgRedimensionata - imaginea redimensionata obtinuta


optiuneRedimensionare = parametri.optiuneRedimensionare;
metodaSelectareDrum = parametri.metodaSelectareDrum;
ploteazaDrum = parametri.ploteazaDrum;
culoareDrum = parametri.culoareDrum;

switch optiuneRedimensionare
    
    case 'micsoreazaLatime'
        numarPixeliLatime = parametri.numarPixeliLatime;
        imgRedimensionata = micsoreazaLatime(img,numarPixeliLatime,metodaSelectareDrum,...
                            ploteazaDrum,culoareDrum);
        
    case 'micsoreazaInaltime'
        numarPixeliInaltime = parametri.numarPixeliInaltime;
        imgRedimensionata = micsoreazaInaltime(img,numarPixeliInaltime,metodaSelectareDrum,...
                            ploteazaDrum,culoareDrum);
        
    case 'maresteLatime'
        prag = 0.25; % imi stabilesc un prag de trecere, l-am fixat 25% ce 
                     % reprezinta obariera care nu lasa o latire a imaginii
                     % peste 25% din dimensiunea initiala, daca se doreste
                     % o redimensionare de peste 25% atunci o fac in mai
                     % multe iteratii de 25%, 25%, .... 25% si cat ramane.
                     % Fac acest lucru deoarece vreau sa am un damage cat
                     % mai mic asupra obiectelor imortante din imagine.
                     % Spre exemplu daca fac o redimensionare cu 100% din
                     % din imagine atunci e fix la fel ca si cum as face
                     % imresize. Insa daca fac 4 * 25% atunci voi amplifica
                     % de 4 ori cel mai neimportant 25% continut din
                     % imagine.
        numarPixeliLatime = parametri.numarPixeliLatime;
        imgRedimensionata = img;
        while numarPixeliLatime > 0
            
            numarPixeliInaltimePerIteratie = min([numarPixeliLatime, ...
                floor(size(img, 2) * prag)]);
            numarPixeliLatime = numarPixeliLatime - numarPixeliInaltimePerIteratie;
            imgRedimensionata = maresteLatime(imgRedimensionata, ...
                numarPixeliInaltimePerIteratie, metodaSelectareDrum);
            disp(['Mai raman de adaugat ' num2str(numarPixeliLatime) ' drumuri']);
        end
        
    case 'maresteInaltime'
        prag = 0.1; % analog observatiei de la maresteLatime
        numarPixeliInaltime = parametri.numarPixeliInaltime;
        imgRedimensionata = img;
        while numarPixeliInaltime > 0
            
            numarPixeliInaltimePerIteratie = min([numarPixeliInaltime, ...
                floor(size(img, 2) * prag)]);
            numarPixeliInaltime = numarPixeliInaltime - numarPixeliInaltimePerIteratie;
            imgRedimensionata = maresteInaltime(imgRedimensionata, ...
                numarPixeliInaltimePerIteratie, metodaSelectareDrum);
            disp(['Mai raman de adaugat  ' num2str(numarPixeliInaltime) ' drumuri']);
        end
    
    case 'amplificaContinut'
        imgRedimensionata = amplificaContinut(img, parametri.factor, ...
            parametri.metodaSelectareDrum);
    
    case 'eliminaObiect'
        imgRedimensionata = eliminaObiect(img, parametri);
    
end