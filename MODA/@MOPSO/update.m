function [ obj ] = update( obj )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

for i=1:obj.nPop
    % select leader for one particle
    leader=obj.SelectLeader();

    obj.pop(i).Velocity = obj.w*obj.pop(i).Velocity ...
        +obj.c1*rand(obj.VarSize).*(obj.pop(i).Best.Position-obj.pop(i).Position) ...
        +obj.c2*rand(obj.VarSize).*(leader.Position-obj.pop(i).Position);

    obj.pop(i).Position = obj.pop(i).Position + obj.pop(i).Velocity;

    obj.pop(i).Position = max(obj.pop(i).Position, obj.VarMin);
    obj.pop(i).Position = min(obj.pop(i).Position, obj.VarMax);
end
costtemp = zeros(3,obj.nPop);
parfor i=1:obj.nPop
%     obj.pop(i).Cost = obj.CostFunction(obj.pop(i).Position);
    costtemp(:,i) = obj.CostFunction(obj.pop(i).Position); 
end

for i=1:obj.nPop
    obj.pop(i).Cost = costtemp(:,i);
    % Apply Mutation
    pm=(1-(obj.it-1)/(obj.MaxIt-1))^(1/obj.mu);
    if rand<pm
        NewSol.Position = obj.Mutate( obj.pop(i).Position, pm, obj.VarMin, obj.VarMax );
        NewSol.Cost=obj.CostFunction(NewSol.Position);
        if obj.Dominates(NewSol,obj.pop(i))
            obj.pop(i).Position=NewSol.Position;
            obj.pop(i).Cost=NewSol.Cost;

        elseif obj.Dominates(obj.pop(i),NewSol)
            % Do Nothing
        else
            if rand<0.5
                obj.pop(i).Position=NewSol.Position;
                obj.pop(i).Cost=NewSol.Cost;
            end
        end
    end

    if obj.Dominates(obj.pop(i),obj.pop(i).Best)
        obj.pop(i).Best.Position=obj.pop(i).Position;
        obj.pop(i).Best.Cost=obj.pop(i).Cost;

    elseif obj.Dominates(obj.pop(i).Best,obj.pop(i))
        % Do Nothing
    else
        if rand<0.5
            obj.pop(i).Best.Position=obj.pop(i).Position;
            obj.pop(i).Best.Cost=obj.pop(i).Cost;
        end
    end

end

end

