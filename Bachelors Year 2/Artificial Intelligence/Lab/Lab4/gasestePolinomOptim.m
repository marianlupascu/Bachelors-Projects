function P = gasestePolinomOptim(A, deg)

P = polyfit(A(1, :), A(2, :), deg);

end

