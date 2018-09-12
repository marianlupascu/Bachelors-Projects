function E = calculeazaEroareMisclasare(X, c)

mare = X > c;
mic  = X <= c;

E = sum(1-(X(mare)./ (X(mare) + c)));
E = E + sum(X(mic)./ (X(mic) + c));

E = E / size(X, 2);

end

