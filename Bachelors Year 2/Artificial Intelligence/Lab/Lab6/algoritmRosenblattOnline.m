function [w, b, err] = algoritmRosenblattOnline(S, nrMaximEpoci)

d = size(S, 1) - 1;
m = size(S, 2);
X = S(1:d, :);
T = S(d+1, :);

w = rand(d, 1);
b = rand;
epocaCurenta = 1;
err = [];

while epocaCurenta < nrMaximEpoci
    numarExempleGresite = 0;
    for i = 1 : m
        y = hardlims(w'*X(:, i) + b);
        if y ~= T(i)

            w = w + T(i) * X(:, i);
            b = b + T(i);
            numarExempleGresite = numarExempleGresite + 1;
        end
    end
    err(epocaCurenta) = numarExempleGresite/m;
    if numarExempleGresite == 0
        break;
    end
    epocaCurenta = epocaCurenta + 1;
end

% m = size(S, 2);
% for k = 2 : nrMaximEpoci
%     i = mod(k, m) + 1;
%     yi = hardlims((wk)*S{1, i} + bk);
%     if(yi ~= S{2, i})
%         wk = wk + S{2, i} * S{1, i};
%         bk = bk + S{2, i};
%     end
%     if mod(k, m) == 0
%         if isequal(w, wk) && b == bk
%             break;
%         end
%         b = bk;
%         w = wk;
%     end
% end


