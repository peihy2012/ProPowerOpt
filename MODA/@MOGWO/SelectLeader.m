
function rep_h = SelectLeader(obj, rep)

    [occ_cell_index occ_cell_member_count]=obj.GetOccupiedCells(rep);
    
    p=occ_cell_member_count.^(-obj.beta);
    p=p/sum(p);
    
    selected_cell_index=occ_cell_index(obj.RouletteWheelSelection(p));
    
    GridIndices=[rep.GridIndex];
    
    selected_cell_members=find(GridIndices==selected_cell_index);
    
    n=numel(selected_cell_members);
    
    selected_memebr_index=randi([1 n]);
    
    h=selected_cell_members(selected_memebr_index);
    
    rep_h=rep(h);
end