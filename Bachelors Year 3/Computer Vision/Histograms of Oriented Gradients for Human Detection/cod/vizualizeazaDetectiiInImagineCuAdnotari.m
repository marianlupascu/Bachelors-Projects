function vizualizeazaDetectiiInImagineCuAdnotari(detectii, scoruriDetectii, imageIdx, tp, fp, numeDirectorExempleTest, numeDirectorAdnotariTest)
% 'detectii' = matrice Nx4, unde 
%           N este numarul de detectii  
%           detectii(i,:) = [x_min, y_min, x_max, y_max]
% 'scoruriDetectii' = matrice Nx1. scoruriDetectii(i) este scorul detectiei i
% 'imageIdx' = tablou de celule Nx1. imageIdx{i} este imaginea in care apare detectia i
% tp - true positives 
% fp - false positives


fid = fopen(numeDirectorAdnotariTest);
gt_info = textscan(fid, '%s %d %d %d %d');
fclose(fid);
gt_ids = gt_info{1,1};
gt_detectii = [gt_info{1,2}, gt_info{1,3}, gt_info{1,4}, gt_info{1,5}];
gt_detectii = double(gt_detectii);

gt_file_list = unique(gt_ids);

num_test_images = length(gt_file_list);

for i=1:num_test_images
   cur_test_image = imread( fullfile( numeDirectorExempleTest, gt_file_list{i}));
   cur_gt_detections = strcmp( gt_file_list{i}, gt_ids);
   cur_gt_detectii = gt_detectii(cur_gt_detections ,:);
   
   cur_detections = strcmp(gt_file_list{i}, imageIdx);
   cur_detectii = detectii(cur_detections,:);
   cur_scoruriDetectii = scoruriDetectii(cur_detections);
   cur_tp = tp(cur_detections);
   cur_fp = fp(cur_detections);
   
   figure(4)
   imshow(cur_test_image);
   hold on;
   
   num_detections = sum(cur_detections);
   
   for j = 1:num_detections
       bb = cur_detectii(j,:);
       if(cur_tp(j)) %detectie corecta
           plot(bb([1 3 3 1 1]),bb([2 2 4 4 2]),'g:','linewidth',2);
       elseif(cur_fp(j))
           plot(bb([1 3 3 1 1]),bb([2 2 4 4 2]),'r-','linewidth',2);
       else
           error('detectia nu e nici adevarat pozitiva nici fals pozitiva')
       end
   end
   
   num_gt_detectii = size(cur_gt_detectii,1);

   for j=1:num_gt_detectii
       bbgt=cur_gt_detectii(j,:);
       plot(bbgt([1 3 3 1 1]),bbgt([2 2 4 4 2]),'y-','linewidth',2);
   end
 
   hold off;
   axis image;
   axis off;
   title(sprintf('Imaginea: "%s" (verde=detectie adevarata, rosu=detectie falsa, galben=ground-truth adnotat), %d/%d gasite',...
                 gt_file_list{i}, sum(cur_tp), size(cur_gt_detectii,1)),'interpreter','none');
             
   set(4, 'Color', [.988, .988, .988])
   pause(0.1) %p
   detection_image = frame2im(getframe(4));
   imwrite(detection_image, sprintf('../data/salveazaFisiere/vizualizari/detectii_%s.png', gt_file_list{i}))
    
   fprintf('Apasati orice tasta pentru a continua cu urmatoarea imagine \n');
   pause;
end

