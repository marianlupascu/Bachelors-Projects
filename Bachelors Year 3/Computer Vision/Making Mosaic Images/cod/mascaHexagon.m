function [masca, bazaHexagon, defazaj, Hm, Wm] = mascaHexagon(H, W)

bazaHexagon = W - floor((2/3)*W);
defazaj = floor((1/3)*W);
jumatate = ceil(H/2);
Hm = H;
if defazaj + 1 < jumatate
    fprintf('Nu putem construi hexaginul, dimensiuni incomparibile\n');
    return;
end
masca = zeros(H, W);

init = defazaj + 1;
fin = defazaj + bazaHexagon;
for i = 1:jumatate
    for j = init:fin
        masca(i, j) = 1;
    end
    init = init - 1;
    fin = fin + 1;
end

init = init + 1;
fin = fin - 1;
Wm = 2*(1 - init) + 2 * defazaj + bazaHexagon;

for i = jumatate+1:H
    for j = init:fin
        masca(i, j) = 1;
    end
    init = init + 1;
    fin = fin - 1;
end

masca = uint8(masca);

end

