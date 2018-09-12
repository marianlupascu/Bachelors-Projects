function [] = generare()

% Genera?i mul?imea de exemple: S={(pi,ti) | pi= (xi,yi) ~
% Unif([-10 10] x [-1 1]), ti = 1 daca pi se aflã deasupra curbei f(x) =
% sin(x), ti = 0 altfel}i=1,100. Salva?i mul?imea S în fi?ierul ’Sgenerat.mat’
% (folosi?i func?ia save).

Sgenerat = zeros(3, 100);
Sgenerat(1, :) = rand(1, 100) * 20 - 10;
Sgenerat(2, :) = rand(1, 100) * 2 - 1;
for i = 1 : 100
    
    if sin(Sgenerat(1, i)) > Sgenerat(2, i)
        Sgenerat(3, i) = 1;
    end
end
save('Sgenerat.m', 'Sgenerat');
end

