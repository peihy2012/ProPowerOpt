classdef MODA < handle
    %MODA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        % objFunc % name (or handle) of objective function 
        %         % example : objFunc = @ZDT1
        objNum  % output dimension of objective functions
        X       % swarm (or set) of control variables (position)
        fitness % fitness of control variables
        DeltaX  % step of control variables
        dim     % dimension of control variables 
        lb      % lower boundary the control variables
        ub      % upper boundary the control variables
        N       % size of swarm (or population)
        maxGen  % maximum of iteration
        
        ArchiveMaxSize  % maximum of archive (or storage) size
        Archive_X       % archive of control variables X
        Archive_F       % archive of functions
        ArchiveSize     % archive size
        Particles_F     % function value of the particles ( X )
        
        R         % radius of neighbourhood
        maxV      % maximum of velocity
        FoodFit   % food fitness
        FoodPos   % food position
        EnemyFit  % enemy fitness
        EnemyPos  % enemy position

    end
    
    methods
        function da = MODA(funcnum, xdim, xnum, gen)
%             if nargin > 0
%                 da.objFunc = func;
            if nargin > 0
                da.objNum = funcnum;
                if nargin > 1
                    da.dim = xdim;
                    if nargin > 3
                        da.N = xnum;
                        if nargin > 4
                            da.maxGen = gen;
                        end
                    end
                end
            end
%             else
%                 error('the objective function handle must be given.')
%             end
            
        end
        obj = init(obj, mopt);
        obj = getfront(obj);
        obj = operation(obj,iter);
        plot(obj,iter,varargin)
    end
    
end

