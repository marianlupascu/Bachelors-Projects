function [esteMaxim] = eliminaNonMaximele(detectii, scoruriDetectii, dimensiuneImg)
% Detectiile cu scor mare suprima detectiile ce se suprapun cu acestea dar au scor mai mic.
% Detectiile se pot suprapune partial, dar centrul unei detectii nu poate
% fi in interiorul celeilalte detectii.
%
% 'detectii' = matrice Nx4, unde 
%           N este numarul de detectii  
%           detectii(i,:) = [x_min, y_min, x_max, y_max]
% 'scoruriDetectii' = matrice Nx1. scoruriDetectii(i) este scorul detectiei i
% 'dimensiuneImg' este =  dimensiunile [y,x] ale imaginii
%
% esteMaxim = matrice Nx1 (1 daca detectia este maxim, 0 altfel)
%

%trunchiaza detectiile la dimensiunile imaginii
x_out_of_bounds = detectii(:,3) > dimensiuneImg(2); %xmax > dimensiunea x 
y_out_of_bounds = detectii(:,4) > dimensiuneImg(1); %ymax > dimensiunea y

detectii(x_out_of_bounds,3) = dimensiuneImg(2);
detectii(y_out_of_bounds,4) = dimensiuneImg(1);

numarDetectii = size(scoruriDetectii,2);

%ordonam detectiile in functie de scorul lor
[scoruriDetectii, ind] = sort(scoruriDetectii, 'descend');
detectii = detectii(ind,:);

% indicator for whether each bbox will be accepted or suppressed
esteMaxim = logical(zeros(1,numarDetectii)); 

for i = 1:numarDetectii
    detectiaCurenta = detectii(i,:);
    detectiaCurenta_esteMaxim = true;
    
    for j = find(esteMaxim)
        %calculeaza suprapunerea(overlap) cu fiecare detectia confirmata ca fiind maxim        
        detectieAnterioara=detectii(j,:);
        bi=[max(detectiaCurenta(1),detectieAnterioara(1)) ; ... 
            max(detectiaCurenta(2),detectieAnterioara(2)) ; ...
            min(detectiaCurenta(3),detectieAnterioara(3)) ; ...
            min(detectiaCurenta(4),detectieAnterioara(4))];
        iw=bi(3)-bi(1)+1;
        ih=bi(4)-bi(2)+1;
        if iw>0 && ih>0                
            % calculam suprapunere ca fiind intersectie/reuniune
            ua=(detectiaCurenta(3)-detectiaCurenta(1)+1)*(detectiaCurenta(4)-detectiaCurenta(2)+1)+...
               (detectieAnterioara(3)-detectieAnterioara(1)+1)*(detectieAnterioara(4)-detectieAnterioara(2)+1)-...
               iw*ih;
            ov=iw*ih/ua;
            if ov > 0.3 %daca detectia cu scor mai mic se suprapune prea mult (>0.3) cu detectia anterioara
                detectiaCurenta_esteMaxim = false;
            end
            
            %caz special -- centrul detectiei curente este in interiorul detectiei anterioare            
            center_coord = [(detectiaCurenta(1) + detectiaCurenta(3))/2, (detectiaCurenta(2) + detectiaCurenta(4))/2];
            if( center_coord(1) > detectieAnterioara(1) && center_coord(1) < detectieAnterioara(3) && ...
                center_coord(2) > detectieAnterioara(2) && center_coord(2) < detectieAnterioara(4))               
                detectiaCurenta_esteMaxim = false;
            end                        
        end
    end
    
    esteMaxim(i) = detectiaCurenta_esteMaxim;

end

%intoarce-te la ordinea initiala a detectiilor
reverse_map(ind) = 1:numarDetectii;
esteMaxim = esteMaxim(reverse_map);

fprintf(' Elimina non-maxime: %d detectii -> %d detectii finale\n', numarDetectii, sum(esteMaxim));


