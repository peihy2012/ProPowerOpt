%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YOEA122
% Project Title: Strength Pareto Evolutionary Algorithm 2 (SPEA2)
% Publisher: Yarpiz (www.yarpiz.com)
% 
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
% 
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%

function PlotCosts(PF)

%     PFC=[PF.Cost];
%     plot(PFC(1,:),PFC(2,:),'x');
%     xlabel('1^{st} Objective');
%     ylabel('2^{nd} Objective');
%     grid on;
    
    EPC=[PF.Cost];
    plot3(EPC(1,:),EPC(2,:),EPC(3,:),'x');
    xlabel('1^{st} Objective');
    ylabel('2^{nd} Objective');
    zlabel('3^{rd} Objective');
    grid on;
end