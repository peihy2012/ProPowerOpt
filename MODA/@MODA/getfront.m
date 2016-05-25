function obj = getfront( obj )
%GETFRONT Summary of this function goes here
%   Detailed explanation goes here
%% find the food and enemy
    for i=1:obj.N 
        if dominates(obj.Particles_F(i,:),obj.FoodFit)
            obj.FoodFit=obj.Particles_F(i,:);
            obj.FoodPos=obj.X(:,i);
        end 
        if dominates(obj.EnemyFit,obj.Particles_F(i,:))
            if all(obj.X(:,i)<obj.ub') && all( obj.X(:,i)>obj.lb')
                obj.EnemyFit=obj.Particles_F(i,:);
                obj.EnemyPos=obj.X(:,i);
            end
        end
    end
%% update the Pareto front archive 
    [obj.Archive_X, obj.Archive_F, obj.ArchiveSize]=UpdateArchive(obj.Archive_X, obj.Archive_F, obj.X, obj.Particles_F, obj.ArchiveSize);
    if obj.ArchiveSize>obj.ArchiveMaxSize
        Archive_mem_ranks=RankingProcess(obj.Archive_F, obj.ArchiveMaxSize, obj.objNum);
        [obj.Archive_X, obj.Archive_F, Archive_mem_ranks, obj.ArchiveSize]=HandleFullArchive(obj.Archive_X, obj.Archive_F, obj.ArchiveSize, Archive_mem_ranks, obj.ArchiveMaxSize);
    else
        Archive_mem_ranks=RankingProcess(obj.Archive_F, obj.ArchiveMaxSize, obj.objNum);
    end
    % Archive_mem_ranks=RankingProcess(obj.Archive_F, obj.ArchiveMaxSize, obj.objNum);
%% Roulette Wheel Select the food and enemy
    % Chose the archive member in the least population area as foods
    % to improve coverage
    index=RouletteWheelSelection(1./Archive_mem_ranks);
    if index==-1
        index=1;
    end
    obj.FoodFit=obj.Archive_F(index,:);
    obj.FoodPos=obj.Archive_X(index,:)';   
    % Chose the archive member in the most population area as enemies
    % to improve coverage
    index=RouletteWheelSelection(Archive_mem_ranks);
    if index==-1
        index=1;
    end
    obj.EnemyFit=obj.Archive_F(index,:);
    obj.EnemyPos=obj.Archive_X(index,:)';

end


function o=dominates(x,y)
o=all(x<=y) && any(x<y);
end

function [Archive_X_Chopped, Archive_F_Chopped, Archive_mem_ranks_updated, Archive_member_no]=HandleFullArchive(Archive_X, Archive_F, Archive_member_no, Archive_mem_ranks, ArchiveMaxSize)
for i=1:size(Archive_F,1)-ArchiveMaxSize
    index=RouletteWheelSelection(Archive_mem_ranks);
    
    Archive_X=[Archive_X(1:index-1,:) ; Archive_X(index+1:Archive_member_no,:)];
    Archive_F=[Archive_F(1:index-1,:) ; Archive_F(index+1:Archive_member_no,:)];
    Archive_mem_ranks=[Archive_mem_ranks(1:index-1) Archive_mem_ranks(index+1:Archive_member_no)];
    Archive_member_no=Archive_member_no-1;
end
Archive_X_Chopped=Archive_X;
Archive_F_Chopped=Archive_F;
Archive_mem_ranks_updated=Archive_mem_ranks;
end


function ranks=RankingProcess(Archive_F, ArchiveMaxSize, obj_no)
my_min=min(Archive_F);
my_max=max(Archive_F);
if size(Archive_F,1)==1
    my_min=Archive_F;
    my_max=Archive_F;
end
r=(my_max-my_min)/(20);
ranks=zeros(1,size(Archive_F,1));
for i=1:size(Archive_F,1)
    ranks(i)=0;
    for j=1:size(Archive_F,1)
        flag=0; % a flag to see if the point is in the neoghbourhood in all dimensions.
        for k=1:obj_no
            if (abs(Archive_F(j,k)-Archive_F(i,k))<r(k))
                flag=flag+1;
            end
        end
        if flag==obj_no
            ranks(i)=ranks(i)+1;
        end
    end
end
end


function o = RouletteWheelSelection(weights)
accumulation = cumsum(weights);
p = rand() * accumulation(end);
chosen_index = -1;
for ind = 1 : length(accumulation)
    if (accumulation(ind) > p)
        chosen_index = ind;
        break;
    end
end
o = chosen_index;
end


function [Archive_X_updated, Archive_F_updated, Archive_member_no]=UpdateArchive(Archive_X, Archive_F, Particles_X, Particles_F, Archive_member_no)
Archive_X_temp=[Archive_X ; Particles_X'];
Archive_F_temp=[Archive_F ; Particles_F];
o=zeros(1,size(Archive_F_temp,1));
for i=1:size(Archive_F_temp,1)
    o(i)=0;
    for j=1:i-1
        if any(Archive_F_temp(i,:) ~= Archive_F_temp(j,:))
            if dominates(Archive_F_temp(i,:),Archive_F_temp(j,:))
                o(j)=1;
            elseif dominates(Archive_F_temp(j,:),Archive_F_temp(i,:))
                o(i)=1;
                break;
            end
        else
            o(j)=1;
            o(i)=1;
        end
    end
end
Archive_member_no=0;
index=0;
for i=1:size(Archive_X_temp,1)
    if o(i)==0
        Archive_member_no=Archive_member_no+1;
        Archive_X_updated(Archive_member_no,:)=Archive_X_temp(i,:);
        Archive_F_updated(Archive_member_no,:)=Archive_F_temp(i,:);
    else
        index=index+1;
    end
end
end
