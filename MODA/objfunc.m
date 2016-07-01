function [ output ] = objfunc( x )
%OBJFUNC define the optimal objective functions
%   use 'persistent' to define variables to avoid repeated calculation

persistent cnt pf Snew
if isempty(cnt)
   cnt = 1;
   addpath('.\GridData');
   data33 = busdata33;
   pf = PowerFlowRadia(data33);
   sampleNum = 100000;
   % include Pwind and pwrSmp
   pwrSmp = powersample(sampleNum,data33.busdata);
   Swind = windsample(sampleNum,1);
   Ssolar = solarsample(sampleNum,1);
   windLoc = [24];
   solarLoc = [17];
   pwrSmp(windLoc,:) = pwrSmp(windLoc,:) - Swind/4;
   pwrSmp(solarLoc,:) = pwrSmp(solarLoc,:) - Ssolar/4;
   Snew = pwrSmp;        
   % initialize
   pf.makeYbus();
   pf.makeSbus();
   pf.initPowerflow();
   disp(['initialization power flow times : cnt = ',num2str(cnt)])  
end

nodeloc = [5 13 20 23 31];
Qc = zeros(pf.nb,1);
Qc(nodeloc) = round(x)*0.05*1j;
%% power flow
spVm = [];
spVa = [];
spLoss = [];

pf1 = pf;
pf1.Sbus = pf1.busdata(:,5) + j*pf1.busdata(:,6) - Qc;
pf1.powerflow();
pf1.powerloss();
spVm = pf1.Vm; 
spVa = pf1.Va; 
spLoss = sum(pf1.loss);

spVm = spVm/pf.baseKV;
o(1) = sum((spVm-1).^2);
o(2) = spLoss;
o(3) = sum(round(x))*0.05;
o(4) = 0;
o(5) = 0;
o(6) = 0;
o(7) = 0;

end

