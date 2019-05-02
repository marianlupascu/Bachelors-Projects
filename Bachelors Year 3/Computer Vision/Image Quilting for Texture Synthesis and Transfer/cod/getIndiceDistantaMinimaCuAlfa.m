function [indice] = getIndiceDistantaMinimaCuAlfa(blocuri, ...
                        suprapunereImgStanga, suprapunereImgSus, ...
                        dimSuprapunere, err, alfa, ...
                        patchImgReferinta, ...
                        patchSintezaAnterior)

if sum(isnan(suprapunereImgStanga(:))) + sum(isnan(suprapunereImgSus(:))) == 0
    
    distanteStanga = zeros(1, size(blocuri, 4));
    for i = 1:size(blocuri, 4)
        bloc = blocuri(1:end, 1:dimSuprapunere, :, i);
        %calc distanta euclidiana
        distanteStanga(i) = sum((double(suprapunereImgStanga(:)) - double(bloc(:))) .^ 2);
    end
    
    distanteSus = zeros(1, size(blocuri, 4));
    for i = 1:size(blocuri, 4)
        bloc = blocuri(1:dimSuprapunere, dimSuprapunere + 1:end, :, i);
        %calc distanta euclidiana
        distanteSus(i) = sum((double(suprapunereImgSus(:)) - double(bloc(:))) .^ 2);
    end
    % distanteSus contine distantele euclidiene pentru suprapunerea cu partea de
    % sus, dar fara partea comuna cu suprapunerea din partea dreapta
    
    [n, m, ~] = size(patchImgReferinta);
    
    distanteRelativeLaPoazaDeReferinta = zeros([1, size(blocuri, 4)]);
    distanteRelativeLaTexturaAnterioara = zeros([1, size(blocuri, 4)]);
    for i = 1:size(blocuri, 4)
        
        bloc = blocuri(1:n, 1:m, :, i);

        %calc distanta euclidiana
        distanteRelativeLaPoazaDeReferinta(i) = ...
            sum((double(patchImgReferinta(:)) - double(bloc(:))) .^ 2);
        if isequal(0, patchSintezaAnterior) == 0
            distanteRelativeLaTexturaAnterioara(i) = ...
            sum((double(patchSintezaAnterior(:)) - double(bloc(:))) .^ 2);
        else
            distanteRelativeLaTexturaAnterioara(i) = 0;
        end
    end
    
    distEuclid = alfa * (distanteStanga + distanteSus + distanteRelativeLaTexturaAnterioara) + ...
        (1 - alfa) * distanteRelativeLaPoazaDeReferinta;
    
    minim = min(distEuclid);
    if minim == 0
        minim = 1;
    end

    indici = find(distEuclid <= (1 + err) * minim);
    pos = randi(size(indici, 1));
    indice = indici(pos);
    
else

    if isnan(suprapunereImgStanga) == 0
        distante = zeros(1, size(blocuri, 4));
        for i = 1:size(blocuri, 4)
            bloc = blocuri(1:dimSuprapunere, 1:end, :, i);
            %calc distanta euclidiana
            distante(i) = sum((double(suprapunereImgStanga(:)) - double(bloc(:))) .^ 2);
        end
    end
    if isnan(suprapunereImgSus) == 0      
        distante = zeros(1, size(blocuri, 4));
        for i = 1:size(blocuri, 4)
            bloc = blocuri(1:end, 1:dimSuprapunere, :, i);
            %calc distanta euclidiana
            distante(i) = sum((double(suprapunereImgSus(:)) - double(bloc(:))) .^ 2);
        end
    end
    
    if sum(isnan(suprapunereImgStanga(:))) + sum(isnan(suprapunereImgSus(:))) == 2
        distante = 0;
    end
    
    [n, m, ~] = size(patchImgReferinta);
    
    distanteRelativeLaPoazaDeReferinta = zeros([1, size(blocuri, 4)]);
    distanteRelativeLaTexturaAnterioara = zeros([1, size(blocuri, 4)]);
    
    for i = 1:size(blocuri, 4)
        
        bloc = blocuri(1:n, 1:m, :, i);

        %calc distanta euclidiana
        distanteRelativeLaPoazaDeReferinta(i) = ...
            sum((double(patchImgReferinta(:)) - double(bloc(:))) .^ 2);
        if isequal(0, patchSintezaAnterior) == 0
            distanteRelativeLaTexturaAnterioara(i) = ...
            sum((double(patchSintezaAnterior(:)) - double(bloc(:))) .^ 2);
        else
            distanteRelativeLaTexturaAnterioara(i) = 0;
        end
    end
    
    distEuclid = alfa * (distante + distanteRelativeLaTexturaAnterioara) +  ...
        (1 - alfa) * distanteRelativeLaPoazaDeReferinta;
    
    minim = min(distEuclid);
    if minim == 0
        minim = 1;
    end
    indici = find(distEuclid <= (1 + err) * minim);
    pos = randi(size(indici, 1));
    indice = indici(pos);
        
end

end

