function obj = runopt( obj, Snew )
%RUNOPT Summary of this function goes here
%   Detailed explanation goes here
ObjectiveFunction = obj.objFunc;
for iter=1:obj.maxGen
   tic
%% update the fitnesses ( or function values )
    % Calculate all the objective values first ( parellel compute )
%     for i=1:obj.N 
%         Particles_F(i,:) = ObjectiveFunction(obj.X(:,i)', obj.pf, Snew);
%     end
    



%% plot Pareto front
    if obj.objNum==2
        plot(obj.Archive_F(:,1),obj.Archive_F(:,2),'ko','MarkerSize',4,'markerfacecolor','g');
    %     axis ([0  1  0  5]);
    %    set(gca,'XTick',0:0.1:1)    %设置坐标密度和范围，但不能固定坐标轴位置
    %    set(gca,'YTick',0:0.2:5)
        xlabel('Function 1');
        ylabel('Function 2');
    elseif obj.objNum==3  
        plot3(obj.Archive_F(:,1),obj.Archive_F(:,2),obj.Archive_F(:,3),'ko','MarkerSize',8,'markerfacecolor','k');
        xlabel('Function 1');
        ylabel('Function 2');
        zlabel('Function 3');
    end
     grid on;
     text(0,0.2,0,['gen =  ',int2str(iter)]);
     pause(0.01)  
     
    toc
    display(['Iteration = ', num2str(iter), ' , ', num2str(obj.ArchiveSize), ' non-dominated solutions']);
end

end

%% local function


