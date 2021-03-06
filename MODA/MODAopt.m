function MODAopt(  )
%MODAOPT Summary of this function goes here
%   Detailed explanation goes here
clc;
clear;
close all;
%% power flow initialize
addpath('.\GridData');
addpath('.\export_fig');
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
debugF = 1;
switch debugF
    case 0
        ObjectiveFunction=@RPOF;
    case 1
        ObjectiveFunction=@RPOF1;
    otherwise
        ObjectiveFunction = NULL;
end
date_str = date();
mo = MODA();
mo.init();
t0 = clock;
% StoreF = zeros(mo.N,mo.objNum,100);
StoreF = zeros(mo.N, 7);
% mkdir([cd,'\image']) 
switch debugF
    case 0
        directory=[cd,'\image_fig_RPOF\'];
    case 1
        directory=[cd,'\image_fig_RPOF1\'];
    otherwise
        ObjectiveFunction = NULL;
end
%% Before optimization 
P_Forgin = ObjectiveFunction(zeros(1,5), pf, Snew);
%% Optimization
outY = [];
bestY = [];
outX = [];
bestX = [];
for iter = 1:100
    t1 = clock;
    parfor it=1:mo.N 
        % mo.Particles_F(it,:) = ObjectiveFunction(mo.X(:,it)', pf, Snew);
        P_F(it,:) = ObjectiveFunction(mo.X(:,it)', pf, Snew);
    end
    StoreF(:,:,iter) = P_F;
    mo.Particles_F = P_F(:,[1:3]);
    mo.getfront();
    mo.operation(iter);
    mo.plot(iter);
    % saveas(gcf,[directory,'pred_prey'],'fig')
    saveas(gcf,[directory,'Fig',num2str(1000+iter),'.fig'])
    export_fig(gcf,[directory,'image/Fig_',num2str(1000+iter),'.eps']);
    [a1,b1]=eps2xxx([directory,'image/Fig_',num2str(1000+iter),'.eps'],{'png'});
    
    % weight function
    if debugF == 0
        weightFunc = P_F(:,4)/P_Forgin(4) + P_F(:,5)/P_Forgin(5) + P_F(:,6)/P_Forgin(6) + P_F(:,7)/P_Forgin(7);
        [outFunc, outIndex] = min(weightFunc);
        outX = [outX; round(mo.X(:,outIndex)')];
        outY = [outY; outFunc];
        [bestYtemp, bestIndex] = min(outY);
        bestX = [bestX, outX(bestIndex)];
        bestY = [bestY, bestYtemp];
    end
    % print time
    t2 = etime(clock, t1);
    display(['Iteration = ', num2str(iter), ' , ', num2str(mo.ArchiveSize), ' non-dominated solutions , time = ', num2str(t2) , ' .']);
    pause(0.05);
end
t2 = etime(clock,t0);
display([ 'time = ', num2str(t2) , ' .']);
if debugF == 0
    switch debugF
        case 0
            save(['moda_result_F0_',date_str,'.mat'],'mo','StoreF','outY','outX','bestY','bestX','P_Forgin')
    %         save(['StoreF_F0_',date_str,'.mat'],'StoreF')
        case 1
            save(['moda_result_F1_',date_str,'.mat'],'mo','StoreF')
    %         save(['StoreF_F1_',date_str,'.mat'],'StoreF')
    end
end

end

