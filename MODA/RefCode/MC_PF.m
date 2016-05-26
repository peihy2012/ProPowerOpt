%%Monte Carlo Power Fkow
%   Use Monte Carlo simulaton to calculate power flow
%   version: v1.0
clear;clc;
% CREATEDATA 
% addpath(genpath(pwd));   % add path of functions and datas
pf = PowerFlowRadia(busdata33);
% % Mathematical Expectation of Active and Reactive Power 
% activePower = busData(:,5);
% reactivePower = busData(:,6);
% % Simpling Number
% % 1000000 = 151 seconds
% % 100000 = 5 seconds
simpleNum = 100000;
% % Deviation of Mathematical Expectation 
% % Standard Normal Distribution P[ -3<x<3 ] = 94.5%
% normalDev = norminv(rand(Nb,simpleNum));
% % activePowerDev = norminv(rand(Nb,simpleNum))/3+1;
% % reactivePowerDev = norminv(rand(Nb,simpleNum))/3+1;
% % Set the Deviation at (-15%,15%)~(-40%,40%)
% devRange = randi([15,40],Nb,1)/100;
% powerDev = diag(devRange) * normalDev / 3 + 1;
% % Simpling with Deviation
% % Active and Reactive Power Simpling
% % actPwrSmp = diag(activePower) * activePowerDev;
% % reactPwrSmp = diag(reactivePower) * reactivePowerDev;
% pwr = activePower + i*reactivePower;
% pwrSmp = diag(pwr) * powerDev;
% % powerFlowPar = parpool;
% % delete(powerFlowPar);
%% include Pwind and pwrSmp
load('Pwind_0512.mat');
load('pwrSmp_0512.mat');
windRate = 0.9;
windLoc = 24;
phi = acos(windRate);
Swind = Pwind.*(1+i*tan(phi));
pwrSmp(windLoc,:) = pwrSmp(windLoc,:) - Swind/4;
Snew = pwrSmp;
%% initialize
pf.makeYbus();
pf.makeSbus();
pf.initPowerflow();
%% power flow
tic
% % Simpling Voltage 
spVm = [];
spVa = [];
parfor spNum = 1:simpleNum
    pf1 = pf;
    pf1.Sbus = Snew(:,spNum);
    pf1.powerflow();
    spVm(:,spNum) = pf1.Vm; 
    spVa(:,spNum) = pf1.Va; 
end
toc

tic
spVm = spVm/pf.baseKV;
ub = max(spVm,[],2);
lb = min(spVm,[],2);
ub = ceil(ub*100+0.5)/100;
lb = floor(lb*100-0.5)/100;
xbw = 0.00001;
ubmax = max(ub);
lbmin = min(lb);
xden = [lbmin:xbw:ubmax];
fden = [];
subfden = zeros(1,size(xden,2));
% fden = zeros(pf.nb,size(xden,2));
% rangewidth = ubmax - lbmin;
% npoint
% parfor
parfor nbr = 1:pf.nb
    % [y,x] = ksdensity( spVm(nbr,:), 'npoints',100,'function','pdf' );
    [y,x] = ksdensity( spVm(nbr,:), [lb(nbr):xbw:ub(nbr)],'function','pdf' );
    lbnum = round((lb(nbr)-lbmin)/xbw)+1;
    ubnum = round((ub(nbr)-lbmin)/xbw)+1;
    rangenum = [lbnum:1:ubnum];
    f = subfden;
    f(1,rangenum) = y;
    fden(nbr,:) = f;
    % fden(:,nbr) = y';
    % xden(:,nbr) = x';
    % bandwidth(nbr) = bw;
end
toc
% plot(xden,fden)
% delete(powerFlowPar);
%% plot 
figure(1)
node = 25;
% Vrange = max(spVm(node,:))-min(spVm(node,:));
% Vrange = max(xden(:,node))-min(xden(:,node));
% [nelements,centers] = hist(spVm(node,:),100);
% bar(centers,nelements/1000/Vrange,'g');
% hold on;
plot(xden,fden(node,:),'r','LineWidth',2)
%% Entropy
% weight of entropy
w = repmat(abs(xden-1),[pf.nb,1])';  
p = fden' * xbw;
% H = entropy(p);
% remove p==0 (avoid 'log2(0) = NaN ' error)
p(find(p<1e-12)) = 1;
plogp = -p .* log2(p);
% entropy
% Hmax = 13.4253
H = sum(plogp,1); 
% entropy with deviation weight
% wHmax = ? 
wH = sum( plogp.*w, 1);   
















