function E = calculeazaEnergie(img)
%calculeaza energia la fiecare pixel pe baza gradientului
%input: img - imaginea initiala
%output: E - energia

%urmati urmatorii pasi:
%transformati imaginea in grayscale
%folositi un filtru sobel pentru a calcula gradientul in directia x si y
%calculati magnitudinea gradientului
%E - energia = gradientul imaginii

%completati aici codul vostru
img = rgb2gray(img);
My = fspecial('sobel');
Mx = My';
Mx(:, [1 3]) = Mx(:, [3 1]);

derivataPartialaX = imfilter(double(img), Mx);
derivataPartialaY = imfilter(double(img), My);

E = abs(derivataPartialaX) + abs(derivataPartialaY);
end