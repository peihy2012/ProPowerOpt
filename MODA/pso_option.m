function mopt = pso_option(  )
%PSO_OPTION Summary of this function goes here
%   Detailed explanation goes here

mopt.CostFunction = @(x) ZDTF(x);    % Cost Function
mopt.nVar = 5;                      % Number of Decision Variables
mopt.VarSize = [1 5];               % Size of Decision Variables Matrix
mopt.VarMin = zeros(1,5);           % Lower Bound of Variables
mopt.VarMax = 15*ones(1,5);         % Upper Bound of Variables
mopt.MaxIt = 100;                   % Maximum Number of Iterations
mopt.nPop = 120;                    % Population Size
mopt.nRep = 100;                    % Repository Size
mopt.w = 0.5;                       % Inertia Weight
mopt.wdamp = 0.99;                  % Intertia Weight Damping Rate
mopt.c1 = 1;                        % Personal Learning Coefficient
mopt.c2 = 2;                        % Global Learning Coefficient
mopt.nGrid = 7;                     % Number of Grids per Dimension
mopt.alpha = 0.1;                   % Inflation Rate
mopt.beta = 2;                      % Leader Selection Pressure
mopt.gamma = 2;                     % Deletion Selection Pressure
mopt.mu = 0.1;                      % Mutation Rate

end

