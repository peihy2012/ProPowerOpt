clear all;
clc;
addpath('.\GridData');

% %% MOPSO parameters 
psomopt.CostFunction = @(x) objfunc_24(x);  % Cost Function
psomopt.nVar = 5*24;                        % Number of Decision Variables
psomopt.VarSize = [1 5*24];                 % Size of Decision Variables Matrix
psomopt.VarMin = zeros(1,5*24);             % Lower Bound of Variables
psomopt.VarMax = 10*ones(1,5*24);           % Upper Bound of Variables
psomopt.MaxIt = 400;                     % Maximum Number of Iterations
psomopt.nPop = 100;                      % Population Size
psomopt.nRep = 100;                      % Repository Size
psomopt.w = 0.5;                         % Inertia Weight
psomopt.wdamp = 0.98;                    % Intertia Weight Damping Rate
psomopt.c1 = 0.2;                          % Personal Learning Coefficient
psomopt.c2 = 0.3;                          % Global Learning Coefficient
psomopt.nGrid = 10;                      % Number of Grids per Dimension
psomopt.alpha = 0.1;                     % Inflation Rate
psomopt.beta = 2;                        % Leader Selection Pressure
psomopt.gamma = 2;                       % Deletion Selection Pressure
psomopt.mu = 0.1;                        % Mutation Rate
%% try the algorithm
mo_pso = MOPSO();
% mo_pso.init(psomopt);
% mo_pso.search();

%% MOGWO parameters 
gwomopt.fobj = @(x) objfunc_24(x);      % Cost Function
gwomopt.nVar = 5*24;                       % Number of Decision Variables
gwomopt.VarSize = [1 5*24];                % Size of Decision Variables Matrix
gwomopt.VarMin = zeros(1,5*24);            % Lower Bound of Variables
gwomopt.VarMax = 10*ones(1,5*24);          % Upper Bound of Variables
gwomopt.MaxIt = 400;                    % Maximum Number of Iterations
gwomopt.it = 1;                         % Number of Iterations
gwomopt.nPop = 100;                     % Population Size
gwomopt.nRep = 100;                     % Repository Size
gwomopt.nGrid = 10;                     % Number of Grids per Dimension
gwomopt.alpha = 0.1;                    % Inflation Rate
gwomopt.beta = 2;                       % Leader Selection Pressure
gwomopt.gamma = 2;                      % Deletion Selection Pressure
%% try the algorithm
% mo_gwo = MOGWO();
% mo_gwo.init(gwomopt);
% mo_gwo.search();

groupSize = 1;
result.pso=[];
result.gwo=[];
mor = repmat(result,groupSize,1);

for gs = 1:groupSize
    
    mo_gwo = MOGWO();
    mo_gwo.init(gwomopt);
    mo_gwo.search();
    gwoOut = [];
    for n = 1:numel(mo_gwo.Archive)
        gwoOut = [gwoOut mo_gwo.Archive(n).Cost];
    end
    mo_pso = MOPSO(); 
    mo_pso.init(psomopt);
    mo_pso.search();
    psoOut = [];
    for n = 1:numel(mo_pso.rep)
        psoOut = [psoOut mo_pso.rep(n).Cost];
    end
    mor(gs).pso = psoOut;
    mor(gs).gwo = gwoOut;
    clear mo_gwo mo_pso;
    disp(['Group number = ',num2str(gs),' ;']);
end


str = datestr(now);
str = strrep(str,' ','_');
str = strrep(str,'-','_');
str = strrep(str,':','_');
save(['mo_result_',str],'mor')
