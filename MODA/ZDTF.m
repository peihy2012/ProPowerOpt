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
    persistent cnt pf Snew
    if isempty(cnt)
       cnt = 1;
       addpath('.\GridData');
       % global pf Snew
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
    
       disp(['cnt=',num2str(cnt)])  
    end
    % disp(['inside function cnt = ',num2str(cnt)])
    % disp(['inside function pf.nb = ',num2str(pf.nb)])
    
    n=numel(x);

    f1=x(1);
    
    g=1+9/(n-1)*sum(x(2:end));
    
    h=1-sqrt(f1/g);
    
    f2=g*h;
    f3=sum(cos(x));
    z=[f1
       f2 
       f3];

end