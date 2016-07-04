%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YPEA121
% Project Title: Multi-Objective Particle Swarm Optimization (MOPSO)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function z=ZDTF(x)

%     persistent smp;
%     if isempty(smp)
%         smp = [1 0 1];
%         disp(['smp=',num2str(smp)])   
%     end
%     global cnt pf Snew
persistent cnt pf
if isempty(cnt)
   cnt = 1;
   addpath('.\GridData');
   % global pf Snew
   data33 = busdata33;
   pf = PowerFlowRadia(data33);   
   % initialize
   pf.makeYbus();
   pf.makeSbus();
   pf.initPowerflow();

   disp(['cnt=',num2str(cnt)])  
end
x = round(x);
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
z(1,1) = sum((spVm-1).^2);
z(2,1) = spLoss;
z(3,1) = sum(round(x))*0.05;

end