function S = genereazaPuncteDeplasateFataDePrimaBisectoare(m, deplasare)

S = rand(2, m)*2 - 1;
for i = 1 : m
    if(S(1, i) - S(2, i) < 0)
         S(3, i) = 1;
         S(2, i) = S(2, i) + deplasare;
    else
         S(3, i) = -1;
         S(2, i) = S(2, i) - deplasare;
    end
end
end

