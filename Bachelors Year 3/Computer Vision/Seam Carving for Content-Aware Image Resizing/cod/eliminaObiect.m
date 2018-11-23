function img = eliminaObiect(img, parametri)

figure(1);
imshow(img);
poz = getrect; % i-au ceea ce vreu sa scot din imagine
close(1);

poz = round(poz); % prelucrare date
poz(poz < 1) = 1;
if poz(1, 1) > size(img, 2)
    poz(1, 1) = size(img, 2);
end
if poz(1, 1) + poz(1, 3) > size(img, 2)
    poz(1, 3) = size(img, 2) - poz(1, 1);
end

if poz(1, 2) > size(img, 1)
    poz(1, 2) = size(img, 1);
end
if poz(1, 2) + poz(1, 4) > size(img, 1)
    poz(1, 4) = size(img, 1) - poz(1, 2);
end
poz

if poz(1, 3) > poz(1, 4) %daca am mai multi pixeli pe inaltime din dreptunghiul selectat
    
    disp('Fac eliminare pe orizontala');
    parametri.numarPixeliInaltime = poz(1, 4);

    img = micsoreazaInaltimePtEliminareObiect(img,parametri.numarPixeliInaltime,parametri.metodaSelectareDrum,...
                            parametri.ploteazaDrum,parametri.culoareDrum, poz);
    
else
    
    disp('Fac eliminare pe verticala');
    parametri.numarPixeliLatime = poz(1, 3);

    img = micsoreazaLatimePtEliminareObiect(img,parametri.numarPixeliLatime,parametri.metodaSelectareDrum,...
                            parametri.ploteazaDrum,parametri.culoareDrum, poz);
end

end

