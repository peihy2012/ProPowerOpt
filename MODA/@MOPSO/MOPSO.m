classdef MOPSO < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        CostFunction          % Cost Function
        nVar                  % Number of Decision Variables
        VarSize               % Size of Decision Variables Matrix
        VarMin                % Lower Bound of Variables
        VarMax                % Upper Bound of Variables
        pop                   % Population
        rep                   % Repository
        empty_particle        % Empty Particle to Initialize Pop
        % MOPSO Parameters
        MaxIt = 100;          % Maximum Number of Iterations
        nPop = 120;           % Population Size
        nRep = 100;           % Repository Size
        w = 0.5;              % Inertia Weight
        wdamp = 0.99;         % Intertia Weight Damping Rate
        c1 = 1;               % Personal Learning Coefficient
        c2 = 2;               % Global Learning Coefficient
        Grid                  % Grids per Dimension
        nGrid = 7;            % Number of Grids per Dimension
        alpha = 0.1;          % Inflation Rate

        beta = 2;             % Leader Selection Pressure
        gamma = 2;            % Deletion Selection Pressure

        mu = 0.1;             % Mutation Rate
       
    end
    
    methods
        function pso_obj = MOPSO()
            
        end
        obj = init( obj, mopt, varargin );
        pop = DetermineDomination( obj, pop );
        obj = FindGridIndex( obj );
%         obj = getfront(obj);
%         obj = operation(obj,iter);
%         plot(obj,iter,varargin);
    end
    
end

