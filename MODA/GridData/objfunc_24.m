function [ o ] = objfunc( x )
%OBJFUNC define the optimal objective functions
%   use 'persistent' to define variables to avoid repeated calculation

persistent cnt pf Sn DG % Snew
if isempty(cnt)
   cnt = 1;
   data33 = busdata33;
   pf = PowerFlowRadia(data33);
   % initialize
   pf.makeYbus();
   pf.makeSbus();
   pf.initPowerflow();
   Rdg = typDG();
   Rload = typload();
   locload = typloc();
   dgstd = [0.27+i*0.12; 0.25];
   Sn = [];
   DG = [];  
   Std = pf.busdata(:,5) + i*pf.busdata(:,6);
   for h = 1:24
       RL = Rload(h,locload);
       Sn = [Sn, RL'.*Std]; 
       DG = [DG, dgstd.*Rdg(h,:)'];
   end
   disp(['initialization power flow times : cnt = ',num2str(cnt)])  
end
x1 = round(x);
xMat = reshape(x1, 5, 24);
nodeloc = [5 13 23 29 31];
dgloc = [21 32];

%% power flow
spVm = [];
spVa = [];
spLoss = [];
pf1 = pf;
for h = 1:24
    Qc = zeros(pf.nb,1);
    DGh = Qc;
    Qc(nodeloc) = round(xMat(:,h))*0.15*1j;
    DGh(dgloc) = DG(:,h);
    pf1.Sbus = Sn(:,h) - Qc - DGh;
    pf1.powerflow();
    pf1.powerloss();
    spVm = [spVm, pf1.Vm]; 
    spVa = [spVa, pf1.Va]; 
    spLoss = [spLoss, pf1.loss];
end
spVm = spVm/pf.baseKV;
o(1,1) = sum( sum((spVm-1).^2) );
o(2,1) = sum( sum(spLoss) );
dm = abs( xMat(:,[1:23]) - xMat(:,[2:24]) );
o(3,1) = sum( sum(dm) );
% o(4) = 0;
% o(5) = 0;
% o(6) = 0;
% o(7) = 0;

end

