function obj = runopt( obj, Snew )
%RUNOPT Summary of this function goes here
%   Detailed explanation goes here
ObjectiveFunction = obj.objFunc;
for iter=1:obj.maxGen
   tic
%% calculate the weights of different patterns
    obj.R = (obj.ub-obj.lb)/4+((obj.ub-obj.lb)*(iter/obj.maxGen)*2);
    w = 0.9-iter*((0.9-0.2)/obj.maxGen);
    my_c = 0.1-iter*((0.1-0)/(obj.maxGen/2));
    if my_c<0
        my_c=0;
    end
    if iter<(3*obj.maxGen/4)
        s=my_c;             % Seperation weight
        a=my_c;             % Alignment weight
        c=my_c;             % Cohesion weight
        f=2*rand;           % Food attraction weight
        e=my_c;             % Enemy distraction weight
    else
        s=my_c/iter;        % Seperation weight
        a=my_c/iter;        % Alignment weight
        c=my_c/iter;        % Cohesion weight
        f=2*rand;           % Food attraction weight
        e=my_c/iter;        % Enemy distraction weight
    end
%% update the fitnesses ( or function values )

    % Calculate all the objective values first ( parellel compute )
    for i=1:obj.N 
        Particles_F(i,:) = ObjectiveFunction(obj.X(:,i)', obj.pf, Snew);
    end

%% find the food and enemy
    for i=1:obj.N 
        % Particles_F(i,:)=obj.objFunc(obj.obj.X(:,i)', pf, Snew);
        if dominates(Particles_F(i,:),obj.FoodFit)
            obj.FoodFit=Particles_F(i,:);
            obj.FoodPos=obj.X(:,i);
        end 
        if dominates(obj.EnemyFit,Particles_F(i,:))
            if all(obj.X(:,i)<obj.ub') && all( obj.X(:,i)>obj.lb')
                obj.EnemyFit=Particles_F(i,:);
                obj.EnemyPos=obj.X(:,i);
            end
        end
    end
%% update the Pareto front archive 
    [obj.Archive_X, obj.Archive_F, obj.ArchiveSize]=UpdateArchive(obj.Archive_X, obj.Archive_F, obj.X, Particles_F, obj.ArchiveSize);
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
%% optimize operations
    for i=1:obj.N
        index=0;
        neighbours_no=0; 
        clear Neighbours_V
        clear Neighbours_X
       %% Find the neighbouring solutions
        for j=1:obj.N
            Dist=distance(obj.X(:,i),obj.X(:,j));
            if (all(Dist<=obj.R) && all(Dist~=0))
                index=index+1;
                neighbours_no=neighbours_no+1;
                Neighbours_V(:,index)=obj.DeltaX(:,j);
                Neighbours_X(:,index)=obj.X(:,j);
            end
        end
       %% Seperation  Eq. (3.1)
        S=zeros(obj.dim,1);
        if neighbours_no>1
            for k=1:neighbours_no
                S=S+(Neighbours_X(:,k)-obj.X(:,i));
            end
            S=-S;
        else
            S=zeros(obj.dim,1);
        end
       %% Alignment Eq. (3.2)
        if neighbours_no>1
            A=(sum(Neighbours_V')')/neighbours_no;
        else
            A=obj.DeltaX(:,i);
        end
       %% Cohesion Eq. (3.3)
        if neighbours_no>1
            C_temp=(sum(Neighbours_X')')/neighbours_no;
        else
            C_temp=obj.X(:,i);
        end
        C=C_temp-obj.X(:,i);
       %% Attraction to food Eq. (3.4)
        Dist2Attraction=distance(obj.X(:,i),obj.FoodPos(:,1));
        if all(Dist2Attraction<=obj.R)
            F=obj.FoodPos-obj.X(:,i);
            iter;
        else
            F=0;
        end
       %% Distraction from enemy Eq. (3.5)
        Dist=distance(obj.X(:,i),obj.EnemyPos(:,1));
        if all(Dist<=obj.R)
            E=obj.EnemyPos+obj.X(:,i);
        else
            E=zeros(obj.dim,1);
        end
%% optimize operations 
        for tt=1:obj.dim
            if obj.X(tt,i)>obj.ub(tt)
                obj.X(tt,i)=obj.lb(tt);
                obj.DeltaX(tt,i)=rand;
            end
            if obj.X(tt,i)<obj.lb(tt)
                obj.X(tt,i)=obj.ub(tt);
                obj.DeltaX(tt,i)=rand;
            end
        end
        if any(Dist2Attraction>obj.R)
            if neighbours_no>1
                for j=1:obj.dim
                    obj.DeltaX(j,i)=w*obj.DeltaX(j,i)+rand*A(j,1)+rand*C(j,1)+rand*S(j,1);
                    if obj.DeltaX(j,i)>obj.maxV
                        obj.DeltaX(j,i)=obj.maxV;
                    end
                    if obj.DeltaX(j,i)<-obj.maxV
                        obj.DeltaX(j,i)=-obj.maxV;
                    end
                    obj.X(j,i)=obj.X(j,i)+obj.DeltaX(j,i);
                end      
            else
                obj.X(:,i)=obj.X(:,i)+Levy(obj.dim)'.*obj.X(:,i);
                obj.DeltaX(:,i)=0;
            end
        else    
            for j=1:obj.dim
                obj.DeltaX(j,i)=s*S(j,1)+a*A(j,1)+c*C(j,1)+f*F(j,1)+e*E(j,1) + w*obj.DeltaX(j,i);
                if obj.DeltaX(j,i)>obj.maxV
                    obj.DeltaX(j,i)=obj.maxV;
                end
                if obj.DeltaX(j,i)<-obj.maxV
                    obj.DeltaX(j,i)=-obj.maxV;
                end
                obj.X(j,i)=obj.X(j,i)+obj.DeltaX(j,i);
            end
        end
%% boundary check
        Flag4ub=obj.X(:,i)>obj.ub';
        Flag4lb=obj.X(:,i)<obj.lb';
        obj.X(:,i)=(obj.X(:,i).*(~(Flag4ub+Flag4lb)))+obj.ub'.*Flag4ub+obj.lb'.*Flag4lb;  
    end
%% plot Pareto front
    if obj.objNum==2
        plot(obj.Archive_F(:,1),obj.Archive_F(:,2),'ko','MarkerSize',4,'markerfacecolor','g');
    %     axis ([0  1  0  5]);
    %    set(gca,'XTick',0:0.1:1)    %设置坐标密度和范围，但不能固定坐标轴位置
    %    set(gca,'YTick',0:0.2:5)
        xlabel('Function 1');
        ylabel('Function 2');
    elseif obj.objNum==3  
        plot3(obj.Archive_F(:,1),obj.Archive_F(:,2),obj.Archive_F(:,3),'ko','MarkerSize',8,'markerfacecolor','k');
        xlabel('Function 1');
        ylabel('Function 2');
        zlabel('Function 3');
    end
     grid on;
     text(0,0.2,0,['gen =  ',int2str(iter)]);
     pause(0.01)  
    toc
    display(['Iteration = ', num2str(iter), ' , ', num2str(obj.ArchiveSize), ' non-dominated solutions']);
end

end

%% local function
function o = distance(a,b)
for i=1:size(a,1)
    o(1,i)=sqrt((a(i)-b(i))^2);
end
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


function o=Levy(d)
beta=3/2;
%Eq. (3.10)
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
u=randn(1,d)*sigma;
v=randn(1,d);
step=u./abs(v).^(1/beta);
% Eq. (3.9)
o=0.01*step;
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
