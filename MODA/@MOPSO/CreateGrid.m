function obj = CreateGrid( obj )
%CreateGrid Summary of this function goes here
%   Detailed explanation goes here

    c = [obj.rep.Cost]; 
    cmin = min(c,[],2);
    cmax = max(c,[],2);   
    dc = cmax-cmin;
    cmin = cmin-obj.alpha*dc;
    cmax = cmax+obj.alpha*dc;
    nObj = size(c,1);
    empty_grid.LB = [];
    empty_grid.UB = [];
    obj.Grid = repmat(empty_grid,nObj,1);
    for j = 1:nObj
        cj = linspace(cmin(j),cmax(j),obj.nGrid+1);
        obj.Grid(j).LB = [-inf cj];
        obj.Grid(j).UB = [cj +inf];
    end

end

