%proiect REALIZAREA DE MOZAICURI
clear; clc;
tic

%%
%seteaza parametri pentru functie

%citeste imaginea care va fi transformata in mozaic
%puteti inlocui numele imaginii
params.imgReferinta = imread('../data/imaginiTest/liberty.jpg');

%seteaza directorul cu imaginile folosite la realizarea mozaicului
%puteti inlocui numele directorului
params.numeDirector = '../data/colectie/'; 

params.tipImagine = 'png';

%seteaza numarul de piese ale mozaicului pe orizontala
%puteti inlocui aceasta valoare
params.numarPieseMozaicOrizontala = 150;
%numarul de piese ale mozaicului pe verticala va fi dedus automat

%seteaza optiunea de afisare a pieselor mozaicului dupa citirea lor din
%director
params.afiseazaPieseMozaic = 0;

%seteaza modul de aranjare a pieselor mozaicului
%optiuni: 'aleator','caroiaj'
params.modAranjare = 'aleator';

%seteaza criteriul dupa care realizeze mozaicul
%optiuni: 'aleator','distantaCuloareMedie'
params.criteriu = 'distantaCuloareMedie';

%seteaza criteriul de alegere a vecinilor
%optiuni: 'nuconteaza', 'diferiti'
params.vecini = 'diferiti';

%seteaza forma pieselor
%optiuni: 'dreptunghi', 'hexagon'
params.forma = 'dreptunghi';
%%
%apeleaza functia principala
% Pentru cazul gray
% params.imgReferinta = rgb2gray(params.imgReferinta);

[imgMozaic, params] = construiesteMozaic(params);

imwrite(imgMozaic,'../mozaic.jpg');
figure, imshow(imgMozaic)

% pentru cifar-10
% % % % % % % % % folder = '..\cifar-10-matlab';
% % % % % % % % % srcImgRef = '..\data\imaginiTest\Horse1.jpg';
% % % % % % % % % construiesteMozaicTematic(folder, srcImgRef, 'horse');

% mascaHexagon(size(params.pieseMozaic, 1), size(params.pieseMozaic, 2));
toc