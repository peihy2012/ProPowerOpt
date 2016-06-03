function [ o ] = RPOF1( X, pf, Snew )
%RPOF1 Summary of this function goes here
%   Detailed explanation goes here

nodeloc = [5 13 20 23 31];
Qc = zeros(pf.nb,1);
Qc(nodeloc) = round(X)*0.05*1j;
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
o(3) = sum(round(X))*0.05;
o(4) = 0;
o(5) = 0;
end

