c = 10;
volum = 50;

plotFunction(1, 2.5, 5, 10);

[AntrenareX, AntrenareY] = genereazaMultimeAntrenare(volum, c);
AntrenareX
AntrenareY
Clasificare = aplicaClasificatorBayesian(AntrenareX, c);
Clasificare

calculeazaEroareMisclasare(AntrenareX, c)

subplot(2, 2, 1);
ploteazaEroareMisclasare(10);
subplot(2, 2, 2);
ploteazaEroareMisclasare(20);
subplot(2, 2, 3);
ploteazaEroareMisclasare(5);
subplot(2, 2, 4);
ploteazaEroareMisclasare(1);