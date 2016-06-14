function obj = FindGridIndex( obj )
%FindGridIndex Summary of this function goes here
%   Detailed explanation goes here

for i = 1:numel(obj.rep)
    % obj.rep(i)=FindGridIndex(rep(i),Grid);
    nObj = numel(obj.rep(i).Cost);
    nGrid = numel(obj.Grid(1).LB);
    obj.rep(i).GridSubIndex = zeros(1,nObj);
    for j = 1:nObj 
        obj.rep(i).GridSubIndex(j)=...
            find( obj.rep(i).Cost(j)<obj.Grid(j).UB, 1, 'first');
    end
    obj.rep(i).GridIndex = obj.rep(i).GridSubIndex(1);
    for j = 2:nObj
        obj.rep(i).GridIndex = obj.rep(i).GridIndex - 1;
        obj.rep(i).GridIndex = nGrid * obj.rep(i).GridIndex;
        obj.rep(i).GridIndex = obj.rep(i).GridIndex + obj.rep(i).GridSubIndex(j);
    end
end

end
%% 
% function particle=FindGridIndex(particle,Grid)
%     nObj=numel(particle.Cost);
%     nGrid=numel(Grid(1).LB);
%     particle.GridSubIndex=zeros(1,nObj);
%     for j=1:nObj 
%         particle.GridSubIndex(j)=...
%             find(particle.Cost(j)<Grid(j).UB,1,'first');
%     end
%     particle.GridIndex=particle.GridSubIndex(1);
%     for j=2:nObj
%         particle.GridIndex=particle.GridIndex-1;
%         particle.GridIndex=nGrid*particle.GridIndex;
%         particle.GridIndex=particle.GridIndex+particle.GridSubIndex(j);
%     end
% end
