function [ obj ] = search( obj )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
for tt = 1:obj.MaxIt
    obj.it = tt;
    obj.update();
    obj.pop = obj.DetermineDomination(obj.pop);
    % Add Non-Dominated Particles to REPOSITORY
    obj.rep=[ obj.rep; obj.pop(~[obj.pop.IsDominated]) ]; 
    % Determine Domination of New Resository Members
    obj.rep = obj.DetermineDomination(obj.rep);
    % Keep only Non-Dminated Memebrs in the Repository
    obj.rep=obj.rep(~[obj.rep.IsDominated]);
    % Update Grid
    obj.CreateGrid();
    % Update Grid Indices
    obj.FindGridIndex();
    % Check if Repository is Full
    if numel(obj.rep)>obj.nRep
        Extra=numel(obj.rep)-obj.nRep;
        for e=1:Extra
            obj.DeleteOneRepMemebr();
        end 
    end

    % % Plot Costs
%     figure(1);
%     obj.plot();
%     pause(0.01);
%     % % Show Iteration Information
%     disp(['Iteration ' num2str(obj.it) ': Number of Rep Members = ' num2str(numel(obj.rep))]);
    % Damping Inertia Weight
    obj.w = obj.w * obj.wdamp;
%     obj.w = 
end
end

