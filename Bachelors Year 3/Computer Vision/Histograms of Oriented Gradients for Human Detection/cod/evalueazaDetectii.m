function [gt_ids, gt_detectii, gt_existaDetectie, tp, fp, detectii_duplicat] = ...
    evalueazaDetectii(detectii, scoruriDetectii, imageIdx, numeDirectorAdnotariTest)
% 'detectii' = matrice Nx4, unde 
%           N este numarul de detectii  
%           detectii(i,:) = [x_min, y_min, x_max, y_max]
% 'scoruriDetectii' = matrice Nx1. scoruriDetectii(i) este scorul detectiei i
% 'imageIdx' = tablou de celule Nx1. imageIdx{i} este imaginea in care apare detectia i

if(~exist('draw', 'var'))
    draw = 1;
end

fid = fopen(numeDirectorAdnotariTest);
gt_info = textscan(fid, '%s %d %d %d %d');
fclose(fid);
gt_ids = gt_info{1,1};
gt_detectii = [gt_info{1,2}, gt_info{1,3}, gt_info{1,4}, gt_info{1,5}];
gt_detectii = double(gt_detectii);

gt_existaDetectie = zeros(length(gt_ids),1);
npos = size(gt_ids,1); %numar total de adevarat pozitive

% sorteaza detectiile dupa scorul lor
[sc,si]=sort(-scoruriDetectii);
imageIdx=imageIdx(si);
detectii=detectii(si,:);

% asigneaza detectii obiectelor ground-truth adnotate
nd=length(scoruriDetectii);
tp=zeros(nd,1);
fp=zeros(nd,1);
detectii_duplicat = zeros(nd,1);
tic;
for d=1:nd      
    cur_gt_ids = strcmp(imageIdx{d}, gt_ids);
    bb = detectii(d,:);
    ovmax=-inf;

    for j = find(cur_gt_ids')
        bbgt=gt_detectii(j,:);
        bi=[max(bb(1),bbgt(1)) ; max(bb(2),bbgt(2)) ; min(bb(3),bbgt(3)) ; min(bb(4),bbgt(4))];
        iw=bi(3)-bi(1)+1;
        ih=bi(4)-bi(2)+1;
        if iw>0 && ih>0       
            % calculeaza overlap ca intersectie / reuniune
            ua=(bb(3)-bb(1)+1)*(bb(4)-bb(2)+1)+...
               (bbgt(3)-bbgt(1)+1)*(bbgt(4)-bbgt(2)+1)-...
               iw*ih;
            ov=iw*ih/ua;
            if ov>ovmax 
                ovmax=ov;
                jmax=j;
            end
        end
    end
    
    % clasifica o detectie ca fiind adevarat pozitiva /fals pozitiva
    if ovmax >= 0.3
        if ~gt_existaDetectie(jmax)
            tp(d)=1;            % detectie adevarat pozitiva
            gt_existaDetectie(jmax)=true;
        else
            fp(d)=1;            % detectie fals pozitiva (detectie multipla)
            detectii_duplicat(d) = 1;
        end
    else
        fp(d)=1;                    % detectie fals pozitiva
    end
end

% calculeaza graficul precizie/recall
cum_fp=cumsum(fp);
cum_tp=cumsum(tp);
rec=cum_tp/npos;
prec=cum_tp./(cum_fp+cum_tp);

ap=calculeazaPrecizieClasificator(rec,prec);

if draw
    % ploteaza graficul precizie/recall
    figure(3)
    plot(rec,prec,'-');
    axis([0 1 0 1])
    grid;
    xlabel 'recall'
    ylabel 'precizie'
    title(sprintf('Precizie medie = %.3f',ap));
    set(3, 'Color', [.988, .988, .988])
    
    pause(0.1) 
    average_precision_image = frame2im(getframe(3));
    imwrite(average_precision_image, '../data/salveazaFisiere/vizualizari/precizie_medie.png')
    
    %figure(4)
    %plot(cum_fp,rec,'-')
    %axis([0 300 0 1])
    %grid;
    %xlabel 'Exemple fals pozitive'
    %ylabel 'Numar detectii corecte (recall)'    
end

%% 
reverse_map(si) = 1:nd;
tp = tp(reverse_map);
fp = fp(reverse_map);
detectii_duplicat = detectii_duplicat(reverse_map);



