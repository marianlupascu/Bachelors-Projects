function params = incarcaPieseMozaic(params)
    %citeste toate cele N piese folosite la mozaic din directorul corespunzator
    %toate cele N imagini au aceeasi dimensiune H x W x C, unde:
    %H = inaltime, W = latime, C = nr canale (C=1  gri, C=3 color)
    %functia intoarce pieseMozaic = matrice H x W x C x N in params
    %pieseMoziac(:,:,:,i) reprezinta piese numarul i 

    fprintf('Incarcam piesele pentru mozaic din director \n');
    %completati codul Matlab


    filelist = dir([params.numeDirector '/*.' params.tipImagine]);
    params.lenImg = length(filelist);
    for idxImg = 1:params.lenImg
        imgName = [params.numeDirector '/' filelist(idxImg).name];
        img = imread(imgName);
        if idxImg == 1
            pieseMozaic = zeros([size(img) length(filelist)]);
        end
        pieseMozaic(:, :, :, idxImg) = img(:, :, :);
    end

    if params.afiseazaPieseMozaic
        %afiseaza primele 100 de piese ale mozaicului
        figure,
        title('Primele 100 de piese ale mozaicului sunt:');
        idxImg = 0;
        for i = 1:10
            for j = 1:10
                idxImg = idxImg + 1;
                subplot(10,10,idxImg);
                imshow(uint8(pieseMozaic(:,:,:,idxImg)));
            end
        end
        drawnow;
        pause(2);
    end

    params.pieseMozaic = uint8(pieseMozaic);
end