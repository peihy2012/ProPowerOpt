function obj = init( obj, mopt )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
if nargin > 1
    error('the struct "mopt" must be given.')
else
    % ObjectiveFunc = @ZDT1;
    funcnum = 2;
    xdim = 5;
    xnum = 120;
    gen = 100;
    arcMaxSize = 100;
    u_b = ones(1,xdim)*15;
    l_b = ones(1,xdim)*0;
    % obj.objFunc = @ObjectiveFunc;  % name (or handle) of objective function 
                                   % example : objFunc = @ZDT1
    obj.objNum = funcnum;          % output dimension of objective functions
    obj.dim = xdim;                % dimension of control variables                  
    obj.N = xnum;                  % size of swarm (or population)
    obj.maxGen = gen;              % maximum of iteration

    obj.ub = u_b;                  % lower boundary the control variables
    obj.lb = l_b;                  % upper boundary the control variables               
    obj.X = initX(xnum,xdim,u_b,l_b);             % swarm (or set) of control variables (position)
    obj.fitness = zeros(xnum,funcnum);                     % fitness of control variables
    obj.DeltaX = initX(xnum,xdim,u_b,l_b);        % step of control variables


    obj.ArchiveMaxSize = arcMaxSize;              % maximum of archive (or storage) size
    obj.Archive_X = zeros(xnum,xdim);             % archive of control variables X
    obj.Archive_F = ones(xnum,funcnum)*inf;       % archive of functions
    obj.ArchiveSize = 0;                          % archive size

    obj.R = (u_b-l_b)/2;                          % radius of neighbourhood
    obj.maxV = (u_b-l_b)/10;                      % maximum of velocity
    obj.FoodFit = inf*ones(1,funcnum);            % food fitness
    obj.FoodPos = zeros(xdim,1);                  % food position
    obj.EnemyFit = inf*ones(1,funcnum);           % enemy fitness
    obj.EnemyPos = zeros(xdim,1);                 % enemy position
end
end

function X = initX(SearchAgents_no,dim,ub,lb)
    Boundary_no = size(ub,2); % numnber of boundaries
    % If the boundaries of all variables are equal and user enter a signle
    % number for both ub and lb
    if Boundary_no==1
        ub_new=ones(1,dim)*ub;
        lb_new=ones(1,dim)*lb;
    else
        ub_new=ub;
        lb_new=lb;
    end
    % If each variable has a different lb and ub
    for i=1:dim
        ub_i=ub_new(i);
        lb_i=lb_new(i);
        X(:,i)=rand(SearchAgents_no,1).*(ub_i-lb_i)+lb_i;
    end
    X=X';
end

