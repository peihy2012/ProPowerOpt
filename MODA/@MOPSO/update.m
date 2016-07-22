function [ obj ] = update( obj )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
temppop = obj.pop;

parfor i=1:obj.nPop
    % select leader for one particle
    leader=obj.SelectLeader();

    temppop(i).Velocity = obj.w*obj.pop(i).Velocity ...
        +obj.c1*rand(obj.VarSize).*(obj.pop(i).Best.Position-obj.pop(i).Position) ...
        +obj.c2*rand(obj.VarSize).*(leader.Position-obj.pop(i).Position);
    temppop(i).Velocity = 2 * temppop(i).Velocity / (obj.w + obj.c1 + obj.c2);
    temppop(i).Position = obj.pop(i).Position + temppop(i).Velocity;

    temppop(i).Position = max(temppop(i).Position, obj.VarMin);
    temppop(i).Position = min(temppop(i).Position, obj.VarMax);
    
% end
% costtemp = zeros(3,obj.nPop);
% parfor i=1:obj.nPop
% %     obj.pop(i).Cost = obj.CostFunction(obj.pop(i).Position);
%     costtemp(:,i) = obj.CostFunction(obj.pop(i).Position); 
% end
% 
% for i=1:obj.nPop
%     obj.pop(i).Cost = costtemp(:,i);
    temppop(i).Cost = obj.CostFunction(temppop(i).Position);
    % Apply Mutation
    NewSolPosition = [];
    NewSolCost =[];
    pm=(1-(obj.it-1)/(obj.MaxIt-1))^(1/obj.mu);
    if rand<pm
        NewSolPosition = obj.Mutate( temppop(i).Position, pm, obj.VarMin, obj.VarMax );
        NewSolCost=obj.CostFunction(NewSolPosition);
        if obj.Dominates(NewSolCost,temppop(i).Cost)
            temppop(i).Position=NewSolPosition;
            temppop(i).Cost=NewSolCost;

        elseif obj.Dominates(temppop(i).Cost,NewSolCost)
            % Do Nothing
        else
            if rand<0.5
                temppop(i).Position=NewSolPosition;
                temppop(i).Cost=NewSolCost;
            end
        end
    end

    if obj.Dominates(temppop(i).Cost,temppop(i).Best.Cost)
        temppop(i).Best.Position=temppop(i).Position;
        temppop(i).Best.Cost=temppop(i).Cost;

    elseif obj.Dominates(temppop(i).Best.Cost,temppop(i).Cost)
        % Do Nothing
    else
        if rand<0.5
            temppop(i).Best.Position=temppop(i).Position;
            temppop(i).Best.Cost=temppop(i).Cost;
        end
    end

end
obj.pop = temppop;

end

