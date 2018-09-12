function [timp] = adunaElementePentruTest(n)

A = rand(n);
tic;
minx = 1;
miny = 1;
min = A(1, 1);
for i = 1 : n
    for j = 1 : n
        if A(i, j) < min
            minx = i;
            miny = j;
            min = A(i, j);
        end
    end
end

suma = 0;
for i = 1 : n
    for j = 1 : n
        if i == minx && j == miny
            break;
        else
            suma = suma + A(i, j);
        end
    end
end
timp = toc;

end



