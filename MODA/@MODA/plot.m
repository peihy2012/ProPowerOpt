function plot( obj, iter, varargin )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
%     0.9047    0.1918    0.1988
%     0.2941    0.5447    0.7494
%     0.3718    0.7176    0.3612
%     1.0000    0.5482    0.1000
%     0.8650    0.8110    0.4330
%     0.6859    0.4035    0.2412
if obj.objNum==2
    % plot(obj.Archive_F(:,1),obj.Archive_F(:,2),'ko','MarkerSize',4,'markerfacecolor',[0.2,0.86,0.69]);
    plot(obj.Particles_F(:,1),obj.Particles_F(:,2),'o',...
        'LineWidth',2,...
        'MarkerEdgeColor',[0.3718    0.7176    0.3612],...
        'MarkerFaceColor',[0.3718    0.7176    0.3612],...
        'MarkerSize',4); hold on;
    plot(obj.Archive_F(:,1),obj.Archive_F(:,2),'o',...
        'LineWidth',2,...
        'MarkerEdgeColor',[0.9047    0.1918    0.1988],...
        'MarkerFaceColor',[0.2941    0.5447    0.7494],...
        'MarkerSize',5);hold off;
    % axis ([0  0.08  0  0.15]);
    % set(gca,'XTick',0:0.1:1)    %设置坐标密度和范围，但不能固定坐标轴位置
    % set(gca,'YTick',0:0.2:5)
    xlabel('Function 1');
    ylabel('Function 2');
elseif obj.objNum==3  
    % plot3(obj.Archive_F(:,1),obj.Archive_F(:,2),obj.Archive_F(:,3),'ko','MarkerSize',8,'markerfacecolor','k');
    plot3(obj.Archive_F(:,1),obj.Archive_F(:,2),obj.Archive_F(:,3),'o',...
        'LineWidth',2,...
        'MarkerEdgeColor','k',...
        'MarkerFaceColor','g',...
        'MarkerSize',5)      
    xlabel('Function 1');
    ylabel('Function 2');
    zlabel('Function 3');
end
grid on;
title(['gen =  ',int2str(iter)]);

end

