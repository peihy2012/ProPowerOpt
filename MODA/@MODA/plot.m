function plot( obj, iter, varargin )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
if obj.objNum==2
    plot(obj.Archive_F(:,1),obj.Archive_F(:,2),'ko','MarkerSize',4,'markerfacecolor','g');
    % axis ([0  0.08  0  0.15]);
    % set(gca,'XTick',0:0.1:1)    %设置坐标密度和范围，但不能固定坐标轴位置
    % set(gca,'YTick',0:0.2:5)
    xlabel('Function 1');
    ylabel('Function 2');
elseif obj.objNum==3  
    plot3(obj.Archive_F(:,1),obj.Archive_F(:,2),obj.Archive_F(:,3),'ko','MarkerSize',8,'markerfacecolor','k');
    xlabel('Function 1');
    ylabel('Function 2');
    zlabel('Function 3');
end
grid on;
title(['gen =  ',int2str(iter)]);

end

