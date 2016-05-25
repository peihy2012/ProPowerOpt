function obj = operation( obj,iter )
%OPERATION Summary of this function goes here
%   Detailed explanation goes here
    
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
        if any( Dist2Attraction > obj.R )
            if neighbours_no > 1
                obj.DeltaX(:,i)=w*obj.DeltaX(:,i)+rand*A(:,1)+rand*C(:,1)+rand*S(:,1);
                Flag4uV = obj.DeltaX(:,i) > obj.maxV';
                Flag4lV = obj.DeltaX(:,i) < -obj.maxV';
                obj.DeltaX(:,i)=(obj.DeltaX(:,i).*(~(Flag4uV+Flag4lV))) + obj.maxV'.*Flag4uV - obj.maxV'.*Flag4lV; 
                obj.X(:,i)=obj.X(:,i)+obj.DeltaX(:,i);
%                 for j=1:obj.dim
%                     obj.DeltaX(j,i)=w*obj.DeltaX(j,i)+rand*A(j,1)+rand*C(j,1)+rand*S(j,1);
%                     if obj.DeltaX(j,i)>obj.maxV
%                         obj.DeltaX(j,i)=obj.maxV;
%                     end
%                     if obj.DeltaX(j,i)<-obj.maxV
%                         obj.DeltaX(j,i)=-obj.maxV;
%                     end
%                     obj.X(j,i)=obj.X(j,i)+obj.DeltaX(j,i);
%                 end     
            else
                obj.X(:,i)=obj.X(:,i)+Levy(obj.dim)'.*obj.X(:,i);
                obj.DeltaX(:,i)=0;
            end
        else 
            obj.DeltaX(:,i)=s*S(:,1)+a*A(:,1)+c*C(:,1)+f*F(:,1)+e*E(:,1) + w*obj.DeltaX(:,i);
            Flag4uV = obj.DeltaX(:,i) > obj.maxV';
            Flag4lV = obj.DeltaX(:,i) < -obj.maxV';
            obj.DeltaX(:,i)=(obj.DeltaX(:,i).*(~(Flag4uV+Flag4lV))) + obj.maxV'.*Flag4uV - obj.maxV'.*Flag4lV; 
            obj.X(:,i)=obj.X(:,i)+obj.DeltaX(:,i);
%             for j=1:obj.dim
%                 obj.DeltaX(j,i)=s*S(j,1)+a*A(j,1)+c*C(j,1)+f*F(j,1)+e*E(j,1) + w*obj.DeltaX(j,i);
%                 if obj.DeltaX(j,i)>obj.maxV
%                     obj.DeltaX(j,i)=obj.maxV;
%                 end
%                 if obj.DeltaX(j,i)<-obj.maxV
%                     obj.DeltaX(j,i)=-obj.maxV;
%                 end
%                 obj.X(j,i)=obj.X(j,i)+obj.DeltaX(j,i);
%             end
        end
%% boundary check
        Flag4ub=obj.X(:,i)>obj.ub';
        Flag4lb=obj.X(:,i)<obj.lb';
        obj.X(:,i)=(obj.X(:,i).*(~(Flag4ub+Flag4lb)))+obj.ub'.*Flag4ub+obj.lb'.*Flag4lb;  
    end

end

function o = distance(a,b)
for i=1:size(a,1)
    o(1,i)=sqrt((a(i)-b(i))^2);
end
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
