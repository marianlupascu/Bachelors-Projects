% v = [ 1 2 3 4 ] ;
% A = [ 1 2 3 4 4; 5 6 7 8 4; 9 10 11 12 4];
% 
% w1=max(v)
% B1=min(A(:))
% w2=mean(v)
% B2=mean(A)
% w3=median(v)
% B3=median(A)
% w4=sum(v)
% w5=cumsum(A)
% w6=prod(v)
% w7=cumprod(A)
% w8=sort(v)
% [w9, w10]=sort(v)
% B4=sort(A)
% size(v)
% length(A)

% A = [ 1 3 2 ];
% B = [ 3 4 6 ];
% p = 3;
% A.'

v=[1 2 3], V=diag(v), W=diag(v,2)
A=[1 2 3;4 5 6;7 8 9], B=diag(diag(A))
C=inv(A), d=det(B), t=trace(B)
D=[1 2 3 4 5 6], E=D(3:5), F=D(2:2:6)
H=[1 2 3 1 5 6;2 3 4 5 6 1;3 4 5 6 1 2;...
4 5 6 1 2 3; 5 6 1 2 3 4; 6 1 2 3 4 5]
I=H(2,:), J=H(:,3), K=H(1:2,4:6), L=H([1,4],[2,4:5]),
m=1:4, n=2:2:6, M=H(m,n)

I = find( H > 3 )
H(I) = 10 * ones(size(I))

x = -2:0.1:2;
y = x;
[X,Y] = meshgrid(x, y);
F = X.*exp(-X.^2-Y.^2);
contour(X,Y,F)
surf(X,Y,F)