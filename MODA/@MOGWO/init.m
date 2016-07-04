function obj = init(obj, mopt, varargin);
%INIT Summary of this function goes here
%   Detailed explanation goes here
if nargin > 1
    obj.fobj = mopt.CostFunction;      % Cost Function
    obj.nVar = mopt.nVar;              % Number of Decision Variables
    obj.VarSize = mopt.VarSize;        % Size of Decision Variables Matrix
    obj.lb = mopt.VarMin;              % Lower Bound of Variables
    obj.ub = mopt.VarMax;              % Upper Bound of Variables
    obj.MaxIt = mopt.MaxIt;            % Maximum Number of Iterations
    obj.GreyWolves_num = mopt.nPop;    % Population Size
    obj.Archive_size = mopt.nRep;      % Repository Size
    obj.nGrid = mopt.nGrid;            % Number of Grids per Dimension
    obj.alpha = mopt.alpha;            % Inflation Rate
    obj.beta = mopt.beta;              % Leader Selection Pressure
    obj.gamma = mopt.gamma;            % Deletion Selection Pressure

else
    obj.fobj = @(x) ZDTF(x);           % Cost Function
    obj.nVar = 5;                      % Number of Decision Variables
    obj.VarSize = [1 5];               % Size of Decision Variables Matrix
    obj.lb = zeros(1,5);               % Lower Bound of Variables
    obj.ub = 15*ones(1,5);             % Upper Bound of Variables
    obj.MaxIt = 100;                   % Maximum Number of Iterations
    obj.GreyWolves_num = 120;          % Population Size
    obj.Archive_size = 100;            % Repository Size
    obj.nGrid = 7;                     % Number of Grids per Dimension
    obj.alpha = 0.1;                   % Inflation Rate
    obj.beta = 2;                      % Leader Selection Pressure
    obj.gamma = 2;                     % Deletion Selection Pressure

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
obj.GreyWolves = repmat(obj.empty_particle,obj.GreyWolves_num,1);

for i=1:obj.GreyWolves_num
    % Random Initialize
    obj.GreyWolves(i).Position = unifrnd(obj.lb,obj.ub,obj.VarSize);
    obj.GreyWolves(i).Velocity = zeros(obj.VarSize);
    obj.GreyWolves(i).Cost = obj.fobj(obj.GreyWolves(i).Position);
    % Update Personal Best
    obj.GreyWolves(i).Best.Position = obj.GreyWolves(i).Position;
    obj.GreyWolves(i).Best.Cost = obj.GreyWolves(i).Cost;
end

% Determine Domination, find dominated solution.
obj.GreyWolves = obj.DetermineDomination( obj.GreyWolves );
% Find the Front and Store the Particle into Repository
obj.Archive = obj.GreyWolves( ~[ obj.GreyWolves.IsDominated ] );
obj.CreateHypercubes();
obj.GetGridIndex();

end

