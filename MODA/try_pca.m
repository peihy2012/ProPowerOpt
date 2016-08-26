clear;clc;
MatSize = [32,24];
Am = 100*ones(MatSize) + 20*rand(MatSize);
Am(:,[10:20]) = Am(:,[10:20]) + 50*rand(size(Am(:,[10:20])));
Am(:,[6:22]) = Am(:,[6:22]) + 20*rand(size(Am(:,[6:22])));
A = Am.*(0.9+0.2*rand(MatSize)) + 30*rand(MatSize);
A2 = A.*(0.9+0.2*rand(MatSize));
A1 = Am.*(0.9+0.2*rand(MatSize)) + 30*rand(MatSize);
[U,S,V] = svd(A-100,'econ');

C = U'*(A2-100)*V;
C(find(C<1e-6))=0;
ds = diag(S);
dc = diag(C);
err = sum(abs(ds-dc))/sum(ds);
r = 1/(1+err)

% hmo = HeatMap(A);
%program 1
xv = 1:1:MatSize(2);
yv = 1:1:MatSize(1);
[x,y]=meshgrid(xv,yv);
% z=sin(y).*cos(x);
mesh(x,y,A);
surf(x,y,A);
xlabel('x-axis'),ylabel('y-axis'),zlabel('z-axis');
title('mesh');
% %program 2
% x=0:0.1:2*pi;
% [x,y]=meshgrid(x);
% z=sin(y).*cos(x);
% surf(x,y,z);
% xlabel('x-axis'),ylabel('y-axis'),zlabel('z-axis');
% title('surf'); pause;
% %program 3
% x=0:0.1:2*pi;
% [x,y]=meshgrid(x);
% z=sin(y).*cos(x);
% plot3(x,y,z);
% xlabel('x-axis'),ylabel('y-axis'),zlabel('z-axis');
% title('plot3-1');grid;
