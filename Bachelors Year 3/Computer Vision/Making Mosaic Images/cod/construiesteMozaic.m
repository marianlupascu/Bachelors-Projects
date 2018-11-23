function [imgMozaic, params] = construiesteMozaic(params)
%functia principala a proiectului
%primeste toate datele necesare in structura params

%incarca toate imaginile mici = piese folosite pentru mozaic
params = incarcaPieseMozaic(params);

%calculeaza noile dimensiuni ale mozaicului
params = calculeazaDimensiuniMozaic(params);

%adauga piese mozaic
switch params.forma
    case 'dreptunghi'
        switch params.modAranjare
            case 'caroiaj'
                switch params.vecini
                    case 'nuconteaza'
                        imgMozaic = adaugaPieseMozaicPeCaroiaj(params);
                    case 'diferiti'
                        imgMozaic = adaugaPieseMozaicPeCaroiajVeciniDiferiti(params);
                end
            case 'aleator'
                imgMozaic = adaugaPieseMozaicModAleator(params);
        end
        
    case 'hexagon'
        switch params.vecini
            case 'nuconteaza'
                imgMozaic = adaugaPieseMozaicPeCaroiajHexagon(params);
            case 'diferiti'
                imgMozaic = adaugaPieseMozaicPeCaroiajVeciniDiferitiHexagon(params);
        end
end
end