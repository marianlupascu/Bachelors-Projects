function img = micsoreazaInaltime(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum)

img = permute(img,[2 1 3]);% transpun imaginea, pentru a aplica selecteazaDrumVertical

for i = 1:numarPixeliInaltime
    
    disp(['Eliminam drumul orizintal numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliInaltime)]);
    
    %calculeaza energia dupa ecuatia (1) din articol
    E = calculeazaEnergie(img);
    
    %alege drumul vertical care conecteaza sus de jos
    drum = selecteazaDrumVertical(E,metodaSelectareDrum);
    
    %afiseaza drum
    if ploteazaDrum
        ploteazaDrumOrizontal(img,E,drum,culoareDrum);
        pause(1);
        title(["Figura #" int2str(i)]);
        close(gcf);
    end
    
    %elimina drumul din imagine
    img = eliminaDrumVertical(img,drum);

end

img = permute(img,[2 1 3]); % transpun imaginea, pentru a o aduce la forma initiala

end

