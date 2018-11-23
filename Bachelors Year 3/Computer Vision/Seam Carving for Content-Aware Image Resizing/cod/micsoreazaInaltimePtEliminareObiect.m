function img = micsoreazaInaltimePtEliminareObiect(img,numarPixeliInaltime,metodaSelectareDrum,ploteazaDrum,culoareDrum, poz)

img = permute(img,[2 1 3]);

for i = 1:numarPixeliInaltime
    
    disp(['Eliminam drumul orizintal numarul ' num2str(i) ...
        ' dintr-un total de ' num2str(numarPixeliInaltime)]);
    
    %calculeaza energia dupa ecuatia (1) din articol
    E = calculeazaEnergie(img);
    
    E = E';
    constanta = -1 * 10^10; % pun un numar foarte mic in dreptunghiul 
    % selectat astfel incat dinamica sa treaca neaparat pe acolo astfel
    % incat sa sterga acel drum
    E(poz(1, 2):(poz(1, 2) + poz(1, 4)), poz(1, 1):(poz(1, 1) + poz(1, 3))) = constanta;
    poz(1, 4) = poz(1, 4) - 1;
    E = E';
    
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

img = permute(img,[2 1 3]);

end
