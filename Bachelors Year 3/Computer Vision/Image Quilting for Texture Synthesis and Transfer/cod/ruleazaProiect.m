clear; clc; close all;
%%
%citeste imaginea
img = imread('../data/img5.png');
%seteaza parametri
parametri.texturaInitiala = img;
parametri.dimensiuneTexturaSintetizata = [2*size(img,1) 2*size(img,2)];
parametri.dimensiuneBloc = 36;
parametri.nrBlocuri = 2000;
parametri.eroareTolerata = 0.1;
parametri.portiuneSuprapunere = 1/6;
% optiuni: blocuriAleatoare, eroareSuprapunere, frontieraCostMinim
parametri.metodaSinteza = 'eroareSuprapunere';

imgSintetizata = realizeazaSintezaTexturii(parametri);