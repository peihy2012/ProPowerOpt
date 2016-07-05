function obj = search( obj )
%SEARCH Summary of this function goes here
%   Detailed explanation goes here

for tt = 1:obj.MaxIt
    obj.it = tt;
    obj.update();
    % Determine Domination, find dominated solution.
    obj.GreyWolves = obj.DetermineDomination( obj.GreyWolves );
%     non_dominated_wolves=GetNonDominatedParticles(GreyWolves);
    % Find the Front and Store the Particle into Repository
    non_dominated_wolves = obj.GreyWolves( ~[ obj.GreyWolves.IsDominated ] );
    obj.Archive=[obj.Archive; non_dominated_wolves];
    
    obj.Archive = obj.DetermineDomination( obj.Archive );
%     Archive=GetNonDominatedParticles(Archive);
    obj.Archive = obj.Archive( ~[ obj.Archive.IsDominated ] );
%     for i=1:numel(obj.Archive)
%         [obj.Archive(i).GridIndex obj.Archive(i).GridSubIndex]=obj.GetGridIndex(Archive(i),G);
%     end
    obj.CreateHypercubes();
    obj.GetGridIndex();
    if numel(obj.Archive)>obj.Archive_size
        EXTRA=numel(obj.Archive)-obj.Archive_size;
        obj.Archive=obj.DeleteFromRep(obj.Archive,EXTRA,obj.gamma);
        obj.CreateHypercubes();
%         Archive_costs=GetCosts(Archive);
%         G=CreateHypercubes(Archive_costs,nGrid,alpha);
    end
    
    disp(['In iteration ' num2str(obj.it) ': Number of solutions in the archive = ' num2str(numel(obj.Archive))]);
%     save results 
    % Results   
%     costs=GetCosts(GreyWolves);
%     Archive_costs=GetCosts(Archive); 
%     if drawing_flag==1
        costs=[obj.GreyWolves.Cost];
        plot3(costs(1,:),costs(2,:),costs(3,:),'k.');
        hold on;
        Archive_costs=[obj.Archive.Cost];
        plot3(Archive_costs(1,:),Archive_costs(2,:),Archive_costs(3,:),'rd');
%         legend('Grey wolves','Non-dominated solutions');
        grid;
        drawnow
        hold off
%     end
    
end

end

