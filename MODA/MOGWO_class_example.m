clear all;
clc;
addpath('.\GridData');
% %% MOGWO parameters 
% mopt.fobj = @(x) objfunc(x);         % Cost Function
% mopt.nVar = 5;                       % Number of Decision Variables
% mopt.VarSize = [1 5];                % Size of Decision Variables Matrix
% mopt.VarMin = zeros(1,5);            % Lower Bound of Variables
% mopt.VarMax = 15*ones(1,5);          % Upper Bound of Variables
% mopt.MaxIt = 100;                    % Maximum Number of Iterations
% mopt.it = 1;                         % Number of Iterations
% mopt.nPop = 120;                     % Population Size
% mopt.nRep = 100;                     % Repository Size
% mopt.nGrid = 10;                     % Number of Grids per Dimension
% mopt.alpha = 0.1;                    % Inflation Rate
% mopt.beta = 2;                       % Leader Selection Pressure
% mopt.gamma = 2;                      % Deletion Selection Pressure
% %% try the algorithm
% mo = MOGWO();
% mo.init(mopt);
% mo.search();


%% MOGWO parameters 
mopt.fobj = @(x) objfunc_24(x);      % Cost Function
mopt.nVar = 5*24;                       % Number of Decision Variables
mopt.VarSize = [1 5*24];                % Size of Decision Variables Matrix
mopt.VarMin = zeros(1,5*24);            % Lower Bound of Variables
mopt.VarMax = 5*ones(1,5*24);          % Upper Bound of Variables
mopt.MaxIt = 400;                    % Maximum Number of Iterations
mopt.it = 1;                         % Number of Iterations
mopt.nPop = 120;                     % Population Size
mopt.nRep = 100;                     % Repository Size
mopt.nGrid = 10;                     % Number of Grids per Dimension
mopt.alpha = 0.1;                    % Inflation Rate
mopt.beta = 2;                       % Leader Selection Pressure
mopt.gamma = 2;                      % Deletion Selection Pressure
%% try the algorithm
mo = MOGWO();
mo.init(mopt);
mo.search();
% 


