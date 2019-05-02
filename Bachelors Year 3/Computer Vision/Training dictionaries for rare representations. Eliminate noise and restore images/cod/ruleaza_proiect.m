clear; clc; close all; fclose all; format compact; tic;
%%
%referinte
datadir = '../data/savedData/';   % data directory
imdir = '../data/';               % image directory
imgsrc = 'RE26uH2_1920x1080.jpg'; % original image

%seteaza parametri
parametri.dataDirectory = datadir;
parametri.imageDirectory = imdir;
parametri.originalImage = imgsrc;
parametri.patchSize = 8;
parametri.sparsity = 6;
parametri.totalNumberOfPatches = 1000;
parametri.dictionarySize = 256;
parametri.DL = 50;
parametri.noiseStandardDeviation = 20;
parametri.missingDataRatio = 0.7;
% tipurite de test sunt: test_denoising_distinct
%                        test_denoising_overlapping
%                        test_inpainting

parametri.tipTest = 'test_denoising_distinct';
[I, Ic, Iperturb, ipsnr, issim] = realizeaza_task(parametri);
imwrite(Ic,['../rezultate/' parametri.originalImage(1:end - 5) '_' parametri.tipTest '_result' parametri.originalImage(end - 4:end)]);
imwrite(Iperturb,['../rezultate/' parametri.originalImage(1:end - 5) '_' parametri.tipTest '_input' parametri.originalImage(end - 4:end)]);
parametri.tipTest
ipsnr, issim
% 
% parametri.tipTest = 'test_denoising_overlapping';
% [I, Ic, Iperturb, ipsnr, issim] = realizeaza_task(parametri);
% imwrite(Ic,['../rezultate/' parametri.originalImage(1:end - 5) '_' parametri.tipTest '_result' parametri.originalImage(end - 4:end)]);
% imwrite(Iperturb,['../rezultate/' parametri.originalImage(1:end - 5) '_' parametri.tipTest '_input' parametri.originalImage(end - 4:end)]);
% parametri.tipTest
% ipsnr, issim
% 
% parametri.tipTest = 'test_inpainting';
% [I, Ic, Iperturb, ipsnr, issim] = realizeaza_task(parametri);
% imwrite(Ic,['../rezultate/' parametri.originalImage(1:end - 5) '_' parametri.tipTest '_result' parametri.originalImage(end - 4:end)]);
% imwrite(Iperturb,['../rezultate/' parametri.originalImage(1:end - 5) '_' parametri.tipTest '_input' parametri.originalImage(end - 4:end)]);
% parametri.tipTest
% ipsnr, issim

toc