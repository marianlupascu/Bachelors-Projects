function ploteazaDrumOrizontal(img,E,drum,culoareDrum)    

img = permute(img,[2 1 3]);
imgDrum = img;
for i = 1:size(drum,1)
    imgDrum(drum(i, 2),drum(i, 1),:) = uint8(culoareDrum);
end
% figure,
full screen
figure('units','normalized','outerposition',[0 0 1 1]);
subplot(1,2,1); imshow(imgDrum);
E = permute(E,[2 1 3]);
subplot(1,2,2); imshow(E,[]);