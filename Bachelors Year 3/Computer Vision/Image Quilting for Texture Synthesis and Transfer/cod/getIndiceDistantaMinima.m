function [indice] = getIndiceDistantaMinima(blocuri, ...
                        suprapunereImgStanga, suprapunereImgSus, ...
                        dimSuprapunere, err)

if sum(isnan(suprapunereImgStanga(:))) + sum(isnan(suprapunereImgSus(:))) == 0
    
    medieCuloriBlocuri = mean(mean(blocuri(1:end, 1:dimSuprapunere, :, :)));
	distEuclidStanga = sum((medieCuloriBlocuri - ...
                        mean(mean(suprapunereImgStanga(:, :, :)))).^2, 3);
    distEuclidStanga = distEuclidStanga(:);
    
    medieCuloriBlocuri = mean(mean(blocuri(1:dimSuprapunere, ...
        dimSuprapunere + 1:end, :, :)));
	distEuclidSus = sum((medieCuloriBlocuri - ...
                        mean(mean(suprapunereImgSus(:, :, :)))).^2, 3);
    distEuclidSus = distEuclidSus(:);
    % distEuclidSus contine mediile pentru suprapunerea cu partea de
    % sus, dar fara partea comuna cu suprapunerea din partea dreapta
    
    distEuclid = distEuclidStanga + distEuclidSus;
    
    minim = min(distEuclid)
    if minim == 0
        minim = 1;
    end
    indici = find(distEuclid <= (1 + err) * minim);
    pos = randi(size(indici, 1));
    indice = indici(pos);
    
else

    if isnan(suprapunereImgStanga)
        medieCuloriBlocuri = mean(mean(blocuri(1:dimSuprapunere, 1:end, :, :)));
        suprapunereImg = suprapunereImgSus;
    else
        medieCuloriBlocuri = mean(mean(blocuri(1:end, 1:dimSuprapunere, :, :)));
        suprapunereImg = suprapunereImgStanga;
    end

    distEuclid = sum((medieCuloriBlocuri - ...
                        mean(mean(suprapunereImg(:, :, :)))).^2, 3);
    distEuclid = distEuclid(:);
    minim = min(distEuclid)
    if minim == 0
        minim = 1;
    end
    indici = find(distEuclid <= (1 + err) * minim);
    pos = randi(size(indici, 1));
    indice = indici(pos);
        
end

end

