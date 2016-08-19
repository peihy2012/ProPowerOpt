function obj = update( obj )
%UPDATE Summary of this function goes here
%   Detailed explanation goes here
a=2-obj.it*((2)/obj.MaxIt);

Wolves.Position=[];
Wolves.Cost=[];
Wolves = repmat(Wolves,obj.GreyWolves_num,1);

for i=1:obj.GreyWolves_num
    rep2 = repmat(obj.empty_particle,0,1);
    rep3 = repmat(obj.empty_particle,0,1);
    % Choose the alpha, beta, and delta grey wolves
    Delta = obj.SelectLeader(obj.Archive);
    Beta = obj.SelectLeader(obj.Archive);
    Alpha = obj.SelectLeader(obj.Archive);

    % If there are less than three solutions in the least crowded
    % hypercube, the second least crowded hypercube is also found
    % to choose other leaders from.
    if size(obj.Archive,1)>1
        counter=0;
        for newi=1:size(obj.Archive,1)
            if sum(Delta.Position~=obj.Archive(newi).Position)~=0
                counter=counter+1;
                rep2(counter,1)=obj.Archive(newi);
            end
        end
        Beta=obj.SelectLeader(rep2);
    end

    % This scenario is the same if the second least crowded hypercube
    % has one solution, so the delta leader should be chosen from the
    % third least crowded hypercube.
    if size(obj.Archive,1)>2
        counter=0;
        for newi=1:size(rep2,1)
            if sum(Beta.Position~=rep2(newi).Position)~=0
                counter=counter+1;
                rep3(counter,1)=rep2(newi);
            end
        end
        Alpha=obj.SelectLeader(rep3);
    end

    % Eq.(3.4) in the paper
    c=2.*rand(1, obj.nVar);
    % Eq.(3.1) in the paper
    D=abs(c.*Delta.Position-obj.GreyWolves(i).Position);
    % Eq.(3.3) in the paper
    A=2.*a.*rand(1, obj.nVar)-a;
    % Eq.(3.8) in the paper
    X1=Delta.Position-A.*abs(D);


    % Eq.(3.4) in the paper
    c=2.*rand(1, obj.nVar);
    % Eq.(3.1) in the paper
    D=abs(c.*Beta.Position-obj.GreyWolves(i).Position);
    % Eq.(3.3) in the paper
    A=2.*a.*rand()-a;
    % Eq.(3.9) in the paper
    X2=Beta.Position-A.*abs(D);


    % Eq.(3.4) in the paper
    c=2.*rand(1, obj.nVar);
    % Eq.(3.1) in the paper
    D=abs(c.*Alpha.Position-obj.GreyWolves(i).Position);
    % Eq.(3.3) in the paper
    A=2.*a.*rand()-a;
    % Eq.(3.10) in the paper
    X3=Alpha.Position-A.*abs(D);
    
    % Eq.(3.11) in the paper
    Wolves(i).Position=(X1+X2+X3)./3;
    % Boundary checking
    Wolves(i).Position=min(max(Wolves(i).Position,obj.lb),obj.ub);
    Wolves(i).Cost=obj.fobj(Wolves(i).Position);
end

for i=1:obj.GreyWolves_num
    % Boundary checking
    obj.GreyWolves(i).Position=Wolves(i).Position;
    obj.GreyWolves(i).Cost=Wolves(i).Cost;
%         rep2 = null;        
%         rep3 = null;
end

end

