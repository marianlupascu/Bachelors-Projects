function [indice] = getIndiceDistantaMinima(blocuri, ...
                        suprapunereImgStanga, suprapunereImgSus, ...
                        dimSuprapunere, err)

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
    
    distEuclid = distanteStanga + distanteSus;
    
    minim = min(distEuclid);
    if minim == 0
        minim = 1;
    end
    indici = find(distEuclid <= (1 + err) * minim);
    pos = randi(size(indici, 1));
    indice = indici(pos);
    
else

    if isnan(suprapunereImgStanga)
        distante = zeros(1, size(blocuri, 4));
        for i = 1:size(blocuri, 4)
            bloc = blocuri(1:dimSuprapunere, 1:end, :, i);
            %calc distanta euclidiana
            distante(i) = sum((double(suprapunereImgSus(:)) - double(bloc(:))) .^ 2);
        end
    else      
        distante = zeros(1, size(blocuri, 4));
        for i = 1:size(blocuri, 4)
            bloc = blocuri(1:end, 1:dimSuprapunere, :, i);
            %calc distanta euclidiana
            distante(i) = sum((double(suprapunereImgStanga(:)) - double(bloc(:))) .^ 2);
        end
    end
    
    minim = min(distante);
    if minim == 0
        minim = 1;
    end
    indici = find(distante <= (1 + err) * minim);
    pos = randi(size(indici, 1));
    indice = indici(pos);
        
end

end

