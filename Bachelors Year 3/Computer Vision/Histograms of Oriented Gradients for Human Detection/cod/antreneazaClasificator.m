function [w,b] = antreneazaClasificator(exempleAntrenare,eticheteExempleAntrenare)

acurateteClasificator = 0;
lambdaOptim = [];
wOptim = [];
bOptim = [];
 for lambda = 10.^[-5 -4 -3 -2 -1 0]
     [w, b] = vl_svmtrain(exempleAntrenare, eticheteExempleAntrenare, lambda);     
     % examineaza performanta clasificatorului
     % eroarea clasificatorului pe multimea de antrenare ar trebui sa fie foarte mica
     disp(['Performanta clasificatorului pt lambda = ' num2str(lambda) ' pe multimea de antrenare este:']);
     scoruriExemple = exempleAntrenare'*w + b;
     [acuratete, rataExempleAdevaratPozitive, rataExempleFalsPozitive, rataAdevaratNegative, rataFalsNegative] =  calculeazaAcurateteClasificator( scoruriExemple, eticheteExempleAntrenare);
     if acurateteClasificator < acuratete
         acurateteClasificator = acuratete;
         lambdaOptim = lambda;
         wOptim = w;
         bOptim = b;
     end
 end
 w = wOptim;
 b = bOptim;
 disp(['Performanta clasificatorului optim pt lambda = ' num2str(lambdaOptim) ' pe multimea de antrenare este:' num2str(acurateteClasificator)]);
 scoruriExemple = exempleAntrenare'*w + b;
 % vizualizeaza cat de bine sunt separate exemplele pozitive de cele negative dupa antrenare
 % ideal ar fi ca exemplele pozitive sa primeasca scoruri >0, iar exemplele negative sa primeasca scoruri <0
 scoruriExempleNegative = scoruriExemple( eticheteExempleAntrenare < 0);
 scoruriExemplePozitive = scoruriExemple( eticheteExempleAntrenare > 0);
 figure(1);
 plot(sort(scoruriExemplePozitive), 'g'); hold on
 plot(sort(scoruriExempleNegative),'r');
 plot([0 max(size(scoruriExempleNegative,1),size(scoruriExempleNegative,1))], [0 0], 'b');
 legend('Scoruri exemple pozitive','Scoruri exemple negative');
 title('Distributia scorurilor clasificatorului pe exemplele de antrenare');
 pause(2);
 hold off;