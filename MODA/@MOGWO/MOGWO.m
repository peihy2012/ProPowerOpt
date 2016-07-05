classdef MOGWO < handle
    %MOGWO Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        fobj;             % Multi-objective Function Handle
        nVar;             % Variables Dimensions
        lb;               % Variables Low Limits
        ub;               % Variables Up Limits
        VarSize;          % Size of Decision Variables Vector
        GreyWolves_num;   % Number of Grey Wolves
        MaxIt;            % Maximum Number of Iterations
        it                % Number of Iterations
        Archive_size;     % Repository Size
        alpha=0.1;        % Grid Inflation Parameter
        G                 % Grids per Dimension
        nGrid=10;         % Number of Grids per each Dimension
        beta=4;           % Leader Selection Pressure Parameter
        gamma=2;          % Extra (to be deleted) Repository Member Selection Pressure
        GreyWolves        % Population
        Archive           % Repository
        empty_particle    % Empty Particle to Initialize Pop
    end
    
    methods
        function  gwo_obj = MOGWO()
            
        end
        obj = init(obj, mopt, varargin);
        pop = DetermineDomination( obj, pop );
        obj = CreateHypercubes( obj );
        obj = GetGridIndex( obj );
        dom = Dominates( obj, x, y );
        obj = search( obj );
        obj = update( obj );
        rep_h = SelectLeader( obj, rep );
        [occ_cell_index occ_cell_member_count] = GetOccupiedCells( obj, pop );
        i = RouletteWheelSelection( obj, p );
        rep = DeleteFromRep(obj,rep,EXTRA,gamma);
        
    end
    
end

