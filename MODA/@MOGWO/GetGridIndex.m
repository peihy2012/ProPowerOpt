
function obj = GetGridIndex( obj )
for i=1:numel(obj.Archive)
    c=obj.Archive(i).Cost;
    nobj=numel(c);
    ngrid=numel(obj.G(1).Upper);
    str=['sub2ind(' mat2str(ones(1,nobj)*ngrid)];
    obj.Archive(i).GridSubIndex=zeros(1,nobj);
    for j=1:nobj
        U=obj.G(j).Upper;
        i=find(c(j)<U,1,'first');
        obj.Archive(i).GridSubIndex(j)=i;
        str=[str ',' num2str(i)];
    end
    str=[str ');'];
    Archive(i).GridIndex=eval(str);
end
end