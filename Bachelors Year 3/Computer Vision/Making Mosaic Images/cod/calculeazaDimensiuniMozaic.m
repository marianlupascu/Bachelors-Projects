function params = calculeazaDimensiuniMozaic(params)
%calculeaza dimensiunile mozaicului
%obtine si imaginea de referinta redimensionata avand aceleasi dimensiuni
%ca mozaicul

%completati codul Matlab

%calculeaza automat numarul de piese pe verticala
params.numarPieseMozaicVerticala = floor((size(params.imgReferinta, 1) * ...
    size(params.pieseMozaic, 2) * params.numarPieseMozaicOrizontala) / ...
    (size(params.imgReferinta, 2) *  size(params.pieseMozaic, 1)));
    
params.lungimeMozaic = params.numarPieseMozaicOrizontala * ...
    size(params.pieseMozaic(:, :, :, 1), 2);
params.latimeMozaic = params.numarPieseMozaicVerticala * ...
    size(params.pieseMozaic(:, :, :, 1), 1);

%calculeaza si imaginea de referinta redimensionata avand aceleasi dimensiuni ca mozaicul

params.imgReferintaRedimensionata = imresize(params.imgReferinta ,[params.latimeMozaic params.lungimeMozaic]);