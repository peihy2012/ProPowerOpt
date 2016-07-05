
function obj = GetGridIndex( obj )
for i=1:numel(obj.Archive)
    c=obj.Archive(i).Cost;
    nobj=numel(c);
    ngrid=numel(obj.G(1).Upper);
    str=['sub2ind(' mat2str(ones(1,nobj)*ngrid)];
    obj.Archive(i).GridSubIndex=zeros(1,nobj);
    for j=1:nobj
        U=obj.G(j).Upper;
        ind=find(c(j)<U,1,'first');
        obj.Archive(i).GridSubIndex(j)=ind;
        str=[str ',' num2str(ind)];
    end
    str=[str ');'];
    obj.Archive(i).GridIndex=eval(str);
end
% 
% for i = 1:numel(obj.Archive)
%     % obj.rep(i)=FindGridIndex(rep(i),Grid);
%     nObj = numel(obj.Archive(i).Cost);
%     nGrid = numel(obj.G(1).Upper);
%     obj.Archive(i).GridSubIndex = zeros(1,nObj);
%     for j = 1:nObj 
%         obj.Archive(i).GridSubIndex(j)=...
%             find( obj.Archive(i).Cost(j)<obj.G(j).Upper, 1, 'first');
%     end
%     obj.Archive(i).GridIndex = obj.Archive(i).GridSubIndex(1);
%     for j = 2:nObj
%         obj.Archive(i).GridIndex = obj.Archive(i).GridIndex - 1;
%         obj.Archive(i).GridIndex = nGrid * obj.Archive(i).GridIndex;
%         obj.Archive(i).GridIndex = obj.Archive(i).GridIndex + obj.Archive(i).GridSubIndex(j);
%     end
% end

end