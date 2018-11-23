%Implementarea a proiectului Redimensionare imagini
%dupa articolul "Seam Carving for Content-Aware Image Resizing", autori S.
%Avidan si A. Shamir 

clear;
clc;
tic
%%
%aceasta functie ruleaza intregul proiect 
%setati parametri si imaginile de redimensionat aici

%citeste o imagine
img = imread('../data/delfin.jpeg');
% imgRedimensionata_traditional = imresize(img,[size(img,1) size(img,2) - 50]);
% imwrite(imgRedimensionata_traditional,'../castelImresize-50.jpg');

%reducem imaginea in latime cu 50 de pixeli
%seteaza parametri
%optiuni: micsoreazaLatime
%         micsoreazaInaltime
%         maresteLatime
%         maresteInaltime
%         amplificaContinut
%         eliminaObiect
parametri.optiuneRedimensionare = 'amplificaContinut';
parametri.numarPixeliLatime = 200;
parametri.numarPixeliInaltime = 200;
parametri.ploteazaDrum = 0;
parametri.culoareDrum = [255 0 0]';%culoarea rosie
%optiuni posibile: 'aleator','greedy','programareDinamica'
parametri.metodaSelectareDrum = 'programareDinamica';
parametri.factor = 0.25;

imgRedimensionata_proiect = redimensioneazaImagine(img,parametri);  

% imgRedimensionata_proiect = redimensioneazaImagine(img,parametri); 
imwrite(imgRedimensionata_proiect,'../lacprogramareDinamica.jpg');

%foloseste functia imresize pentru redimensionare traditionala
imgRedimensionata_traditional = imresize(img,[ size(imgRedimensionata_proiect,1) size(imgRedimensionata_proiect,2)]);
imwrite(imgRedimensionata_traditional,'../programareDinamicaImresize.jpg');

%ploteaza imaginile obtinute
figure, hold on;

%1. imaginea initiala
h1 = subplot(1,3,1);imshow(img);
xsize = get(h1,'XLim');ysize = get(h1,'YLim');
xlabel('imaginea initiala');

%2. imaginea redimensionata cu pastrarea continutului
h2 = subplot(1,3,2);imshow(imgRedimensionata_proiect);
set(h2, 'XLim', xsize, 'YLim', ysize);
xlabel('rezultatul nostru');

%3. imaginea obtinuta prin redimensionare traditionala
h3 = subplot(1,3,3);imshow(imgRedimensionata_traditional);
set(h3, 'XLim', xsize, 'YLim', ysize);
xlabel('rezultatul imresize');

toc