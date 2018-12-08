clear; clc; close all; tic;
%%
%citeste imaginea
srcTextura = 'Van_Gogh.jpg';
imgTextura = imread(['../data/' srcTextura]);
imgReferinta = imread('../data/golden-gate-bridge.jpg');
%seteaza parametri
parametri.texturaInitiala = imgTextura;
parametri.imgReferinta = imgReferinta;
parametri.dimensiuneTexturaSintetizata = [2*size(imgTextura,1) 2*size(imgTextura,2)];
parametri.dimensiuneBloc = 60; % pentru transferul de textura este dimensiunea primului bloc
parametri.nrBlocuri = 2000;
parametri.eroareTolerata = 0.1;
parametri.portiuneSuprapunere = 1/6;
parametri.N = 3; % doar pentru transferTextura
% optiuni: blocuriAleatoare, eroareSuprapunere, frontieraCostMinim, transferTextura
parametri.metodaSinteza = 'transferTextura';
imgSintetizata = realizeazaSintezaTexturii(parametri);

% parametri.metodaSinteza = 'transferTextura';
% imgSintetizata = realizeazaSintezaTexturii(parametri);
% imwrite(imgSintetizata,['../' parametri.metodaSinteza '_' srcTextura]);
% 
% parametri.metodaSinteza = 'eroareSuprapunere';
% imgSintetizata = realizeazaSintezaTexturii(parametri);
% imwrite(imgSintetizata,['../' parametri.metodaSinteza '_' srcTextura]);
% 
% parametri.metodaSinteza = 'frontieraCostMinim';
% imgSintetizata = realizeazaSintezaTexturii(parametri);
% imwrite(imgSintetizata,['../' parametri.metodaSinteza '_' srcTextura]);
toc;