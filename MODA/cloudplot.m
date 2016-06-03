function [ o ] = cloudplot( X,pf,Snew )
%cloudplot Summary of this function goes here
%   Detailed explanation goes here

simpleNum = 10000;
nodeloc = [6 13 17 23 31];
Qc = zeros(pf.nb,1);
Qc(nodeloc) = round(X)*0.06*1j;
%% power flow
% % Simpling Voltage 
spVm = [];
spVa = [];
spLoss = [];
for spNum = 1:simpleNum
    pf1 = pf;
    pf1.Sbus = Snew(:,spNum)-Qc;
    pf1.powerflow();
    pf1.powerloss();
    spVm(:,spNum) = pf1.Vm; 
    spVa(:,spNum) = pf1.Va; 
    spLoss(1,spNum) = sum(pf1.loss);
end
spVm = spVm/pf.baseKV;
fden = [];
xden = [];
for nbr = 1:pf.nb
    % [y,x] = ksdensity( spVm(nbr,:), [lb(nbr):xbw:ub(nbr)],'function','pdf' );
    [y,x] = ksdensity( spVm(nbr,:),'npoints',100,'function','pdf' );
    fden(nbr,:) = y;
    xden(nbr,:) = x;
end
%%
stressMatrix = fden';
stress = [];
yMatrix = xden';
dy = yMatrix(2,:)-yMatrix(1,:);
for n = 1:32
    % stressMatrix(:,n) = stressMatrix(:,n);%*dy(n);
    xMatrix(:,n) = ones(100,1)*n;
end
%% IEEE-33 nodes
rReduce = 1:32;
rReduce = (rReduce*8-1)/255;
RGBmap = [ones(1,32),ones(1,32);...
    rReduce,ones(1,32);...
    zeros(1,32),rReduce]';
RGBmap = flipud(RGBmap);

figure(1)
subplot(2,2,1)
index = [2:17];
pcolor(xMatrix(:,index),yMatrix(:,index),stressMatrix(:,index));
shading interp
colorbar
colormap(RGBmap)

subplot(2,2,2)
index = [18:21];
pcolor(xMatrix(:,index),yMatrix(:,index),stressMatrix(:,index));
shading interp
colorbar
colormap(RGBmap)

subplot(2,2,3)
index = [5, 25:32];
pcolor(xMatrix(:,index),yMatrix(:,index),stressMatrix(:,index));
shading interp
colorbar
colormap(RGBmap)

subplot(2,2,4)
index = [22:24];
pcolor(xMatrix(:,index),yMatrix(:,index),stressMatrix(:,index));
shading interp
colorbar
colormap(RGBmap)


% surf(xMatrix(:,1:17),yMatrix(:,1:17),stressMatrix(1:17,:)');
% surf(xMatrix(:,18:21),yMatrix(:,18:21),stressMatrix(18:21,:)')

o=1;


end

