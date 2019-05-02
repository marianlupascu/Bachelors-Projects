%desc:  a*x1 + b*x2 + c <= 0
%{
HalfPlanes = [1, 1, -3;
              1, -1, -1;
              0, 1, -2;
              -2, 1, -1];
HalfPlanes = [-1, 1, 0;
              1, -2, 0];
HalfPlanes = [1, 1, -3;
              -1, 1, -1;
              1, -1, 4];
HalfPlanes = [-1, -1, 1;
              0, 1, -4;
              1, 2, -10];
%}
HalfPlanes = [-1, 1, 0;
              1, -2, 0];
Line = [1, 2];
P = DrawHalfPlane(HalfPlanes);
if size(P) ~= 0
    xMax = min([max(P(:, 1)) + 1, 15]);
    yMax = min([max(P(:, 2)) + 1, 15]);
    pgon = polyshape(P);
    plot(pgon);
    AnalyzesTheSolution(P, Line);
else
    xMax = 15;
    yMax= 15;
    disp('Nu exista solutie');
end
hold on;
xlabel('x-axis');
ylabel('y-axis');
xlim([-1 xMax]);
ylim([-1 yMax]);
xL = xlim;
yL = ylim;
line([0 0], yL);  %x-axis
line(xL, [0 0]);  %y-axis


DrawParalelsLines(Line(1), Line(2), xMax, yMax);
DrawLines(HalfPlanes, xMax, yMax);

function [] = AnalyzesTheSolution(P, Line)
    if sum(P == [1000 1000]) ~= 0
        disp('Solutie de maxim infinit');
    else
        B = unique(P,'rows');
        M = Line(1) * B(:, 1) + Line(2) * B(:,2);
        m = max(M);
        disp(['Maximul este ' num2str(m)]);
        if sum(M == m) == 1
            disp('Solutie unica');
        else
            disp('Solutie multipla');
        end
    end
end

function R = DrawHalfPlane(v)

[p1, p2, p3, p4, vAux] = DrawHalfPlaneAux(v);
p = [p1; p2; p3; p4];
for i = 1 : size(vAux, 1)
    a1 = vAux(i, 1); b1 = vAux(i, 2); c1 = vAux(i, 3);
    x0 = -c1/a1;
    y0 = -c1/b1;
    m = -a1/b1;
    pNou = [];
    q = [p; p(1, :)];
    for j = 1 : size(q, 1) - 1
        A = q(j, :);
        B = q(j + 1, :);
        A(A == Inf) = 1000;
        B(B == Inf) = 1000;
        a2=B(2) - A(2);
        b2=-(B(1)-A(1));
        c2=- A(1)*B(2) + A(2)*B(1);
        if a1 == 0
            ysol = -c1 / b1;
            xsol = - (b2*ysol + c2) / a2;
        else
            ysol = (c1*a2 - a1*c2) / (b2*a1 - b1*a2);
            xsol = - (b1*ysol + c1) / a1;
        end
        pNou = [pNou; A; [xsol, ysol]];
    end
    p = [];
    for j = 1 : size(pNou, 1)
        if a1 * pNou(j, 1) + b1 * pNou(j, 2) + c1 <= 0 && pNou(j, 1) >= 0 && pNou(j, 2) >= 0
            p = [p; pNou(j, :)];
        end
    end
end

R = [];
for j = 1 : size(p, 1)
    ok = 1;
    for i = 1 : size(v, 1)
        a1 = v(i, 1); b1 = v(i, 2); c1 = v(i, 3);
        if a1 * p(j, 1) + b1 * p(j, 2) + c1 > 0
            ok = 0;
        end
    end
    if ok == 1
        R = [R; p(j, :)];
    end
end
end

function [p1, p2, p3, p4, vAux] = DrawHalfPlaneAux(v) % pentru cazurile trivale
% paralelele la Ox si Oy
vAux = [];
p1 = [0 0]; p2 = [Inf 0]; p3 = [Inf Inf]; p4 = [0 Inf];
    for i = 1 : size(v, 1)
        a = v(i, 1); b = v(i, 2); c = v(i, 3);
        if a == 0 && b == 0
            continue;
        elseif a == 0 && b ~= 0
            if b > 0 %hiperplan orientat in jos
                if c == 0 % semidreapta Ox
                    p3 = p2;
                    p4 = p1;
                elseif c > 0 % hiperplan sub Ox
                    p1 = -1; p2 = -1; p3 = -1; p4 = -1;
                    return;
                else % hiperplan peste Ox
                    p3 = [p3(1) min([-c p3(2)])];
                    p4 = [p4(1) min([-c p4(2)])];
                end
            else %hiperplan orientat in sus
                if c == 0 % semidreapta Ox
                    p3 = p2;
                    p4 = p1;
                elseif c > 0 % hiperplan sub Ox
                    continue;
                else % hiperplan peste Ox
                    p1 = [p1(1) min([-c p1(2)])];
                    p2 = [p2(1) min([-c p2(2)])];
                end
            end
        elseif a ~= 0 && b == 0
            if a > 0 %hiperplan orientat la dreapta
                if c == 0 % semidreapta Oy
                    p2 = p1;
                    p3 = p4;
                elseif c > 0 % hiperplan la stanga de Oy
                    p1 = -1; p2 = -1; p3 = -1; p4 = -1;
                    return;
                else % hiperplan la dreapta de Oy
                    p2 = [min([-c p2(1)]), p2(2)];
                    p3 = [min([-c p2(1)]), p3(2)];
                end
            else %hiperplan orientat la stanga
                if c == 0 % semidreapta Ox
                    p2 = p1;
                    p3 = p4;
                elseif c > 0 % hiperplan la dreapta de Oy
                    p1 = [min([-c p1(1)]) p1(2)];
                    p4 = [min([-c p4(1)]) p4(2)];
                else % hiperplan la stanga de Oy
                    continue;
                end
            end
        else
            vAux = [vAux; v(i, :)];
        end
    end
end

function [] = DrawParalelsLines(c1, c2, xMax, yMax) %desc:  c1*x1 + c2*x2 = 0

xGrafic = -1:0.01:xMax;

plot(xGrafic, (- c1 * xGrafic) / c2, 'g');

for i = -1 : -1: -20
    plot(xGrafic, (- c1 * xGrafic) / c2 + i, 'g');
end

for i = 1 : 50
    plot(xGrafic, (- c1 * xGrafic) / c2 + i, 'g');
end

end

function [] = DrawLines(HalfPlanes, xMax, yMax)

xGrafic = -1:0.01:xMax;

for i = 1 : size(HalfPlanes, 1)
    a = HalfPlanes(i, 1); b = HalfPlanes(i, 2); c = HalfPlanes(i, 3);
    plot(xGrafic, (- c - a * xGrafic) / b, 'm');
end

end