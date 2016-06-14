function obj = init( obj, mopt, varargin )
%INIT Initialize the class MOPSO
%   Detailed explanation goes here
if nargin > 1
    obj.CostFunction = mopt.CostFunction;  % Cost Function
    obj.nVar = mopt.nVar;              % Number of Decision Variables
    obj.VarSize = mopt.VarSize;        % Size of Decision Variables Matrix
    obj.VarMin = mopt.VarMin;          % Lower Bound of Variables
    obj.VarMax = mopt.VarMax;          % Upper Bound of Variables
    obj.MaxIt = mopt.MaxIt;            % Maximum Number of Iterations
    obj.nPop = mopt.nPop;              % Population Size
    obj.nRep = mopt.nRep;              % Repository Size
    obj.w = mopt.w;                    % Inertia Weight
    obj.wdamp = mopt.wdamp;            % Intertia Weight Damping Rate
    obj.c1 = mopt.c1;                  % Personal Learning Coefficient
    obj.c2 = mopt.c2;                  % Global Learning Coefficient
    obj.nGrid = mopt.nGrid;            % Number of Grids per Dimension
    obj.alpha = mopt.alpha;            % Inflation Rate
    obj.beta = mopt.beta;              % Leader Selection Pressure
    obj.gamma = mopt.gamma;            % Deletion Selection Pressure
    obj.mu = mopt.mu;                  % Mutation Rate
else
    obj.CostFunction = @(x) ZDTF(x);        % Cost Function
    obj.nVar = 5;                      % Number of Decision Variables
    obj.VarSize = [1 5];               % Size of Decision Variables Matrix
    obj.VarMin = zeros(1,5);           % Lower Bound of Variables
    obj.VarMax = 15*ones(1,5);         % Upper Bound of Variables
    obj.MaxIt = 100;                   % Maximum Number of Iterations
    obj.nPop = 120;                    % Population Size
    obj.nRep = 100;                    % Repository Size
    obj.w = 0.5;                       % Inertia Weight
    obj.wdamp = 0.99;                  % Intertia Weight Damping Rate
    obj.c1 = 1;                        % Personal Learning Coefficient
    obj.c2 = 2;                        % Global Learning Coefficient
    obj.nGrid = 7;                     % Number of Grids per Dimension
    obj.alpha = 0.1;                   % Inflation Rate
    obj.beta = 2;                      % Leader Selection Pressure
    obj.gamma = 2;                     % Deletion Selection Pressure
    obj.mu = 0.1;                      % Mutation Rate
end
% Initialize Empty Particle
obj.empty_particle.Position=[];
obj.empty_particle.Velocity=[];
obj.empty_particle.Cost=[];
obj.empty_particle.Best.Position=[];
obj.empty_particle.Best.Cost=[];
obj.empty_particle.IsDominated=[];
obj.empty_particle.GridIndex=[];
obj.empty_particle.GridSubIndex=[];  
obj.pop = repmat(obj.empty_particle,obj.nPop,1);

for i=1:obj.nPop
    % Random Initialize
    obj.pop(i).Position = unifrnd(obj.VarMin,obj.VarMax,obj.VarSize);
    obj.pop(i).Velocity = zeros(obj.VarSize);
    obj.pop(i).Cost = obj.CostFunction(obj.pop(i).Position);
    % Update Personal Best
    obj.pop(i).Best.Position = obj.pop(i).Position;
    obj.pop(i).Best.Cost = obj.pop(i).Cost;
end

% Determine Domination, find dominated solution.
obj.pop = obj.DetermineDomination( obj.pop );
% Find the Front and Store the Particle into Repository
obj.rep = obj.pop( ~[ obj.pop.IsDominated ] );
obj.CreateGrid();
obj.FindGridIndex();
% for i=1:numel( obj.rep )
%     obj.rep(i) = obj.FindGridIndex( obj.rep(i), obj.Grid );
% end

end

