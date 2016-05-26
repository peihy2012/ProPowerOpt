function MODAopt(  )
%MODAOPT Summary of this function goes here
%   Detailed explanation goes here
clc;
clear;
close all;
%% power flow initialize
addpath('.\GridData');
% global pf Snew
data33 = busdata33;
pf = PowerFlowRadia(data33);
sampleNum = 100000;
%% include Pwind and pwrSmp
% load('Pwind_0512.mat');
% load('pwrSmp_0512.mat');
% windRate = 0.8;
% windLoc = 24;
% phi = acos(windRate);
% Swind = Pwind.*(1+i*tan(phi));
pwrSmp = powersample(sampleNum,data33.busdata);
Swind = windsample(sampleNum,1);
windLoc = 24;
pwrSmp(windLoc,:) = pwrSmp(windLoc,:) - Swind/4;
Snew = pwrSmp;
%% initialize
pf.makeYbus();
pf.makeSbus();
pf.initPowerflow();
%% MODA optimization process
ObjectiveFunction=@RPOF1;
mo = MODA(@RPOF1);
mo.init();
for iter = 1:100
    for it=1:mo.N 
        mo.Particles_F(it,:) = ObjectiveFunction(mo.X(:,it)', pf, Snew);
    end
    mo.getfront();
    mo.operation(iter);
    mo.plot(iter);
    display(['Iteration = ', num2str(iter), ' , ', num2str(mo.ArchiveSize), ' non-dominated solutions']);
    pause(0.05);
end


end

