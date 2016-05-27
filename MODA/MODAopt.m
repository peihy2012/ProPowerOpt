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
Ssolar = solarsample(sampleNum,1);
windLoc = [24];
solarLoc = [17];
pwrSmp(windLoc,:) = pwrSmp(windLoc,:) - Swind/4;
pwrSmp(solarLoc,:) = pwrSmp(solarLoc,:) - Ssolar/4;
Snew = pwrSmp;
%% initialize
pf.makeYbus();
pf.makeSbus();
pf.initPowerflow();
%% MODA optimization process
ObjectiveFunction=@RPOF;
mo = MODA();
mo.init();
t0 = clock;
for iter = 1:100
    t1 = clock;
    parfor it=1:mo.N 
        % mo.Particles_F(it,:) = ObjectiveFunction(mo.X(:,it)', pf, Snew);
        P_F(it,:) = ObjectiveFunction(mo.X(:,it)', pf, Snew);
    end
    mo.Particles_F = P_F;
    mo.getfront();
    mo.operation(iter);
    mo.plot(iter);
    t2 = etime(clock, t1);
    display(['Iteration = ', num2str(iter), ' , ', num2str(mo.ArchiveSize), ' non-dominated solutions , time = ', num2str(t2) , ' .']);
    pause(0.05);
end
t2 = etime(clock,t0);
display([ 'time = ', num2str(t2) , ' .']);
save moda_result mo
end

