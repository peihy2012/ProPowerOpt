function [ o ] = RPOF( X, pf, Snew )
%RPOF Summary of this function goes here
%   Detailed explanation goes here
% pf = PowerFlowRadia(busdata33);
simpleNum = 10000;
% %% include Pwind and pwrSmp
% load('Pwind_0512.mat');
% load('pwrSmp_0512.mat');
% windRate = 0.9;
% windLoc = 24;
% phi = acos(windRate);
% Swind = Pwind.*(1+i*tan(phi));
% pwrSmp(windLoc,:) = pwrSmp(windLoc,:) - Swind/4;
% Snew = pwrSmp;
% %% initialize
% pf.makeYbus();
% pf.makeSbus();
% pf.initPowerflow();
% global pf Snew
nodeloc = [5 13 20 23 31];
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
ub = max(spVm,[],2);
lb = min(spVm,[],2);
ub = ceil(ub*100+0.5)/100;
lb = floor(lb*100-0.5)/100;
xbw = 1/simpleNum;
ubmax = max(ub);
lbmin = min(lb);
xden = [lbmin:xbw:ubmax];
fden = [];
subfden = zeros(1,size(xden,2));
for nbr = 1:pf.nb
    [y,x] = ksdensity( spVm(nbr,:), [lb(nbr):xbw:ub(nbr)],'function','pdf' );
    lbnum = round((lb(nbr)-lbmin)/xbw)+1;
    ubnum = round((ub(nbr)-lbmin)/xbw)+1;
    rangenum = [lbnum:1:ubnum];
    f = subfden;
    f(1,rangenum) = y;
    fden(nbr,:) = f;
end
[floss,xloss] = ksdensity( spLoss, 'npoints',1000,'function','pdf' );
% delete(powerFlowPar);
%% plot 
% figure(1)
% node = 25;
% plot(xden,fden(node,:),'r','LineWidth',2)
%% Entropy
% weight of entropy
w = repmat(abs(xden-1),[pf.nb,1])';  
p = fden' * xbw;
% remove p==0 (avoid 'log2(0) = NaN ' error)
p(find(p<1e-12)) = 1;
plogp = -p .* log2(p);
% entropy
% Hmax = 13.4253
% H = sum(plogp,1); 
% entropy with deviation weight
wH = sum( plogp.*w, 1);   


xbw = (max(spLoss)-min(spLoss))/1000;
p = floss'*xbw;
p(find(p<1e-12)) = 1;
plogp = -p .* log2(p);
% entropy
% Hmax = 
% entropy with deviation weight
wHL = sum( plogp.*xloss', 1);   
o = [sum(wHL), sum(wH)];

end

