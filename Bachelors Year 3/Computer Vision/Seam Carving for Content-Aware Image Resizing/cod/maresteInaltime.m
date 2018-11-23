function newImg = maresteInaltime(img,numarPixeliInaltime,metodaSelectareDrum)

img = permute(img,[2 1 3]); % transpun imaginea pentru a plica algoritmul de marire pe verticala

newImg = maresteLatime(img,numarPixeliInaltime,metodaSelectareDrum);

newImg = permute(newImg,[2 1 3]);% transpun imaginea la loc

end

