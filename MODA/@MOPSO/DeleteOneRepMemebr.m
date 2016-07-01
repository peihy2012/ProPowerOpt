function obj = DeleteOneRepMemebr( obj )

    % Grid Index of All Repository Members
    GI=[obj.rep.GridIndex];
    % Occupied Cells
    OC=unique(GI);
    % Number of Particles in Occupied Cells
    N=zeros(size(OC));
    for k=1:numel(OC)
        N(k)=numel(find(GI==OC(k)));
    end
    % Selection Probabilities
    P=exp(obj.gamma*N);
    P=P/sum(P);
    % Selected Cell Index
    sci=obj.RouletteWheelSelection(P);
    % Selected Cell
    sc=OC(sci);
    % Selected Cell Members
    SCM=find(GI==sc);
    % Selected Member Index
    smi=randi([1 numel(SCM)]); 
    % Selected Member
    sm=SCM(smi);
    % Delete Selected Member
    obj.rep(sm)=[];

end