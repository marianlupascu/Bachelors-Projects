function [Y] = perturbaExemple(X, sigma)

Y = X + max(min(randn(size(X,1), 1)*sigma,1),0);

end

