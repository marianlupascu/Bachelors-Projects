function [I, Ic, Iperturb, ipsnr, issim] = realizeaza_task(parametri)

imdir = parametri.imageDirectory;
imgsrc = parametri.originalImage;

% Add noise to original image and vectorize
I = double(imread([imdir,imgsrc]));
Inoisy = [];
Imiss = [];
IcR = [];
IcG = [];
IcB = [];
ipsnr = 0; 
issim = 0;

switch parametri.tipTest

    case 'test_denoising_distinct'
        sigma = parametri.noiseStandardDeviation;
        Inoisy = I + sigma*randn(size(I));
        
        if size(I, 3) == 1
            [Ic, ipsnr, issim] = test_denoising_distinct(I(:, :, 1), Inoisy(:, :, 1), parametri);
        else
            InoisyR = Inoisy(:, :, 1);
            InoisyG = Inoisy(:, :, 2);
            InoisyB = Inoisy(:, :, 3);

            [IcR, ipsnr1, issim1] = test_denoising_distinct(I(:, :, 1), InoisyR, parametri);
            [IcG, ipsnr2, issim2] = test_denoising_distinct(I(:, :, 2), InoisyG, parametri);
            [IcB, ipsnr3, issim3] = test_denoising_distinct(I(:, :, 3), InoisyB, parametri);

            Ic = cat(3, IcR, IcG, IcB);

            ipsnr = (ipsnr1 + ipsnr2 + ipsnr3) / 3;
            issim = (issim1 + issim2 + issim3) / 3;
        end
        I = uint8(I);
        Inoisy = uint8(Inoisy);
        Ic = uint8(Ic);
        Iperturb = Inoisy;
        
        figure, imshow(I);
        figure, imshow(Inoisy);
        figure, imshow(Ic);
        
    case 'test_denoising_overlapping'
        sigma = parametri.noiseStandardDeviation;
        Inoisy = I + sigma*randn(size(I));
        
        if size(I, 3) == 1
            [Ic, ipsnr, issim] = test_denoising_overlapping(I(:, :, 1), Inoisy(:, :, 1), parametri);
        else
            InoisyR = Inoisy(:, :, 1);
            InoisyG = Inoisy(:, :, 2);
            InoisyB = Inoisy(:, :, 3);

            [IcR, ipsnr1, issim1] = test_denoising_overlapping(I(:, :, 1), InoisyR, parametri);
            [IcG, ipsnr2, issim2] = test_denoising_overlapping(I(:, :, 2), InoisyG, parametri);
            [IcB, ipsnr3, issim3] = test_denoising_overlapping(I(:, :, 3), InoisyB, parametri);

            Ic = cat(3, IcR, IcG, IcB);

            ipsnr = (ipsnr1 + ipsnr2 + ipsnr3) / 3;
            issim = (issim1 + issim2 + issim3) / 3;
        end
        I = uint8(I);
        Inoisy = uint8(Inoisy);
        Ic = uint8(Ic);
        Iperturb = Inoisy;
        
        figure, imshow(I);
        figure, imshow(Inoisy);
        figure, imshow(Ic);
        
        
    case 'test_inpainting'
        if size(I, 3) == 1
            [Ic, ipsnr, issim, Imiss] = test_inpainting(I(:, :, 1), parametri);
        else
            [IcR, ipsnr1, issim1, Imiss1] = test_inpainting(I(:, :, 1), parametri);
            [IcG, ipsnr2, issim2, Imiss2] = test_inpainting(I(:, :, 2), parametri);
            [IcB, ipsnr3, issim3, Imiss3] = test_inpainting(I(:, :, 3), parametri);

            Ic = cat(3, IcR, IcG, IcB);
            Imiss = cat(3, Imiss1, Imiss2, Imiss3);

            ipsnr = (ipsnr1 + ipsnr2 + ipsnr3) / 3;
            issim = (issim1 + issim2 + issim3) / 3;
        end
        
        I = uint8(I);
        Imiss = uint8(Imiss);
        Ic = uint8(Ic);
        Iperturb = Imiss;
        
        figure, imshow(I);
        figure, imshow(Imiss);
        figure, imshow(Ic);
        
    otherwise
        disp("Optiune Invalida");
        return;
end

end