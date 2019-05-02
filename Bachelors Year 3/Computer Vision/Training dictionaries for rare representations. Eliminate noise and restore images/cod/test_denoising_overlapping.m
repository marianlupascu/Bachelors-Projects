function [Ic, ipsnr, issim] = test_denoising_overlapping(I, Inoisy, parametri)
% Copyright (c) 2018 Paul Irofti <paul@irofti.net>
% 
% Permission to use, copy, modify, and/or distribute this software for any
% purpose with or without fee is hereby granted, provided that the above
% copyright notice and this permission notice appear in all copies.
% 
% THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
% WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
% MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
% ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
% WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
% ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
% OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.

%% DL denoising with training on noisy image
%%-------------------------------------------------------------------------
datadir = parametri.dataDirectory;
img = parametri.originalImage;
p = parametri.patchSize;                   % patch size
s = parametri.sparsity;                    % sparsity
N = parametri.totalNumberOfPatches;        % total number of patches
n = parametri.dictionarySize;              % dictionary size
K = parametri.DL;                          % DL 
sigma = parametri.noiseStandardDeviation;  % noise standard deviation
%%-------------------------------------------------------------------------
dataprefix = 'denoise';

addpath(genpath('DL'));
ts = datestr(now, 'yyyymmddHHMMss');
%% Initial Data
errs = zeros(1,K);
fname = [datadir dataprefix '-' img '-sigma' num2str(sigma) ...
    '-n' num2str(n) '-' ts '.mat'];

% Random dictionary
D0 = normc(randn(p^2,n));

I = double(I);
Inoisy = double(Inoisy);

% % % figure;
% % % subplot(1,2,1), imshow(I,[]);
% % % subplot(1,2,2), imshow(Inoisy,[]);

%extract distinct patches
Ynoisy = im2col(Inoisy, [p p], 'sliding');
Ynmean = mean(Ynoisy);
Ynoisy = Ynoisy - repmat(Ynmean,size(Ynoisy,1),1);

save(fname, 'Inoisy', 'Ynoisy', 'Ynmean');

%% Dictionary Learning
%pick N random patched from all patches
Y = Ynoisy(:,randperm(size(Ynoisy,2), N));
D = D0;
for iter = 1:K
    X = omp(Y, D, s);
    [D, X] = aksvd(Y, D, X, iter);
    errs(iter) = norm(Y - D*X, 'fro') / sqrt(numel(Y));
end
save(fname,'D','X','errs','-append');
%% Denoising via Sparse Representation

% Sparse representation
max_s = size(Ynoisy,1)/2;   % maximum density is half the patch
gain = 1.15;                % default noise gain
params = {'error', sqrt(size(Ynoisy,1))*gain*sigma, 'maxatoms', max_s};
Xc = omp(Ynoisy,D,max_s,[],params{:});

% Completati codul Matlab pentru reconstructia imaginii Ic
Y = D * Xc;
Yc = Y + repmat(Ynmean, size(Ynoisy,1), 1);
Ic = zeros(size(I));
Pond = zeros(size(I));
poz = 1;

for j = 1 : size(I, 2) - p + 1
    for i = 1 : size(I, 1) - p + 1
        Ic(i:i + p - 1, j:j + p - 1) = Ic(i:i + p - 1, j:j + p - 1) + ...
            reshape(Yc(:, poz), p, p);
        Pond(i:i + p - 1, j:j + p - 1) = Pond(i:i + p - 1, j:j + p - 1) + 1;
        poz = poz + 1;
    end
end

Ic = Ic ./ Pond;

% Clean vs. Original
ipsnr = psnr(Ic, I, 255);
issim = ssim(Ic, I, 'DynamicRange', 255);
sprintf('psnr=%f ssim=%f\n', ipsnr, issim);

save(fname,'Ic','Yc','Xc','ipsnr','issim','-append');
end