function Y = aplicaClasificatorBayesian(X, c)

Y = X >= c;

end

%Y=1 dacã P(Y=1|X=x) > P(Y=0|X=x)