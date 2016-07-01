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

function PlotCosts(pop,rep)

    pop_costs=[pop.Cost];
    plot3(pop_costs(1,:),pop_costs(2,:),pop_costs(3,:),'ko');
    hold on;
    
    rep_costs=[rep.Cost];
    plot3(rep_costs(1,:),rep_costs(2,:),rep_costs(3,:),'r*');
    
    xlabel('1^{st} Objective');
    ylabel('2^{nd} Objective');
    zlabel('3^{nd} Objective');
    grid on;
    
    hold off;

end