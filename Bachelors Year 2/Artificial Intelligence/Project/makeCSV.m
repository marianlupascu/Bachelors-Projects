function [final] = makeCSV(labelTest)

final = zeros(size(labelTest, 2), 2);

for i = 1:size(labelTest, 2)
    final(i,1) = i;
end
final(:, 2) = labelTest';

cHeader = {'Id' 'Prediction'};
commaHeader = [cHeader;repmat({','},1,numel(cHeader))]; %insert commaas
commaHeader = commaHeader(:)';
textHeader = cell2mat(commaHeader); %cHeader in text with commas
%write header to file
fid = fopen('submission.csv','w');
correctedStr = extractBetween(textHeader, 1, length(textHeader) - 1);
fprintf(fid,'%s\n', correctedStr{1});
fclose(fid);
dlmwrite('submission.csv',final,'-append');

end

