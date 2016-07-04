  
function obj = CreateHypercubes( obj )
    nobj=numel(obj.Archive(1).Cost);
    costs=reshape([obj.Archive.Cost],nobj,[]);
    nobj = size(costs,1);
    empty_grid.Lower=[];
    empty_grid.Upper=[];
    obj.G = repmat(empty_grid,nobj,1);
    
    for j=1:nobj
        
        min_cj=min(costs(j,:));
        max_cj=max(costs(j,:));
        
        dcj=obj.alpha*(max_cj-min_cj);
        
        min_cj=min_cj-dcj;
        max_cj=max_cj+dcj;
        
        gx=linspace(min_cj,max_cj,obj.nGrid-1);
        
        obj.G(j).Lower=[-inf gx];
        obj.G(j).Upper=[gx inf];
        
    end

end