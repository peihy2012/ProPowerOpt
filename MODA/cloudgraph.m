clc;
clear;
close all;
%% power flow initialize
addpath('.\GridData');
% global pf Snew
% data33 = busdata33;
% pf = PowerFlowRadia(data33);
% sampleNum = 100000;
% pwrSmp = powersample(sampleNum,data33.busdata);
% Swind = windsample(sampleNum,1);
% Ssolar = solarsample(sampleNum,1);
% windLoc = [24];
% solarLoc = [17];
% pwrSmp(windLoc,:) = pwrSmp(windLoc,:) - Swind;
% pwrSmp(solarLoc,:) = pwrSmp(solarLoc,:) - Ssolar/4;
% Snew = pwrSmp;
% %% initialize
% pf.makeYbus();
% pf.makeSbus();
% pf.initPowerflow();
% 
% % cloudplot( zeros(1,5),pf,Snew )
% X = zeros(1,5);
% simpleNum = 10000;
% nodeloc = [6 13 17 23 31];
% Qc = zeros(pf.nb,1);
% Qc(nodeloc) = round(X)*0.06*1j;
% %% power flow
% % % Simpling Voltage 
% spVm = [];
% spVa = [];
% spLoss = [];
% for spNum = 1:simpleNum
%     pf1 = pf;
%     pf1.Sbus = Snew(:,spNum)-Qc;
%     pf1.powerflow();
%     pf1.powerloss();
%     spVm(:,spNum) = pf1.Vm; 
%     spVa(:,spNum) = pf1.Va; 
%     spLoss(1,spNum) = sum(pf1.loss);
% end
% spVm = spVm/pf.baseKV;
% fden = [];
% xden = [];
% for nbr = 1:pf.nb
%     % [y,x] = ksdensity( spVm(nbr,:), [lb(nbr):xbw:ub(nbr)],'function','pdf' );
%     [y,x] = ksdensity( spVm(nbr,:),'npoints',100,'function','pdf' );
%     fden(nbr,:) = y;
%     xden(nbr,:) = x;
% end



load temp.mat
%%
stressMatrix = fden';
ymean = mean(spVm,2)';
stress = [];
yMatrix = xden';
for n = 1:32
    temp = yMatrix(:,n);
    positiveIndex = find(stressMatrix(:,n)>1);
    yup(1,n) = temp(positiveIndex(1));
    ylow(1,n) = temp(positiveIndex(end));
end
% dy = yMatrix(2,:)-yMatrix(1,:);
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
hold on;
plot(xMatrix(1,index)',ylow(index)',':b')
plot(xMatrix(end,index)',ymean(index)','b')
plot(xMatrix(end,index)',yup(index)',':b')

subplot(2,2,2)
index = [18:21];
pcolor(xMatrix(:,index),yMatrix(:,index),stressMatrix(:,index));
shading interp
colorbar
colormap(RGBmap)
hold on;
plot(xMatrix(1,index)',ylow(index)',':b')
plot(xMatrix(end,index)',ymean(index)','b')
plot(xMatrix(end,index)',yup(index)',':b')


subplot(2,2,3)
index = [25:32];
pcolor(xMatrix(:,index),yMatrix(:,index),stressMatrix(:,index));
shading interp
colorbar
colormap(RGBmap)
hold on;
plot(xMatrix(1,index)',ylow(index)',':b')
plot(xMatrix(end,index)',ymean(index)','b')
plot(xMatrix(end,index)',yup(index)',':b')


subplot(2,2,4)
index = [22:24];
pcolor(xMatrix(:,index),yMatrix(:,index),stressMatrix(:,index));
shading interp
colorbar
colormap(RGBmap)
hold on;
plot(xMatrix(1,index)',ylow(index)',':b')
plot(xMatrix(end,index)',ymean(index)','b')
plot(xMatrix(end,index)',yup(index)',':b')





