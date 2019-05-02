function vizualizeazaDetectiiInImagineFaraAdnotari(detectii, scoruriDetectii, imageIdx, numeDirectorExempleTest)
% 'detectii' = matrice Nx4, unde 
%           N este numarul de detectii  
%           detectii(i,:) = [x_min, y_min, x_max, y_max]
% 'scoruriDetectii' = matrice Nx1. scoruriDetectii(i) este scorul detectiei i
% 'imageIdx' = tablou de celule Nx1. imageIdx{i} este imaginea in care apare detectia i

test_files = dir(fullfile(numeDirectorExempleTest, '*.jpg'));
num_test_images = length(test_files);

for i=1:num_test_images
   cur_test_image = imread( fullfile( numeDirectorExempleTest, test_files(i).name));
      
   cur_detections = strcmp(test_files(i).name, imageIdx);
   cur_detectii = detectii(cur_detections,:);
   cur_scoruriDetectii = scoruriDetectii(cur_detections);
   
   figure(4)
   imshow(cur_test_image);
   hold on;
   
   num_detections = sum(cur_detections);
   
   for j = 1:num_detections
       bb = cur_detectii(j,:);
       plot(bb([1 3 3 1 1]),bb([2 2 4 4 2]),'g:','linewidth',2);
   end
 
   hold off;
   axis image;
   axis off;
   title(sprintf('Imaginea: "%s" verde=detectie', test_files(i).name),'interpreter','none');
    
   set(4, 'Color', [.988, .988, .988])
   pause(0.1) 
   detection_image = frame2im(getframe(4));
   imwrite(detection_image, sprintf('../data/salveazaFisiere/vizualizari/detectii_%s.png', test_files(i).name))  
   fprintf('Apasati orice tasta pentru a continua cu urmatoarea imagine \n');
   pause;
end



