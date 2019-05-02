function img = micsoreazaLatimePtEliminareObiect(img,numarPixeliLatime,metodaSelectareDrum,ploteazaDrum,culoareDrum, poz)

for i = 1:numarPixeliLatime
    
    disp(['Eliminam drumul vertical numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliLatime)]);
    
    %calculeaza energia dupa ecuatia (1) din articol
    E = calculeazaEnergie(img);
    
    constanta = -1 * 10^10;
    E(poz(1, 2):(poz(1, 2) + poz(1, 4)), poz(1, 1):(poz(1, 1) + poz(1, 3))) = constanta;
    poz(1, 3) = poz(1, 3) - 1;
    
    %alege drumul vertical care conecteaza sus de jos
    drum = selecteazaDrumVertical(E,metodaSelectareDrum);
    
    %afiseaza drum
    if ploteazaDrum
        ploteazaDrumVertical(img,E,drum,culoareDrum);
        pause(1);
        title(["Figura #" int2str(i)]);
        close(gcf);
    end
    
    %elimina drumul din imagine
    img = eliminaDrumVertical(img,drum);

end
