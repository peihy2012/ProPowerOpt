clc;
%初始化参数
popnum=200;
gen=100;
xmin=0;%变量取值范围
xmax=1;
m=2;%目标函数个数
n=30;%决策变量数目
hc=20;%交叉变异参数
hm=20;
%产生初始种群
initpop=rand(popnum,n)*(xmax-xmin)+xmin;
init_value_pop=value_objective(initpop,m,n);
%画图显示初始图
plot(init_value_pop(:,n+1),init_value_pop(:,n+m),'B+')
pause(.1)
%非支配排序和聚集距离计算
[non_dominant_sort_pop, rankinfo]=non_dominant_sort(init_value_pop,m,n);
ns_dc_pop=crowding_distance(non_dominant_sort_pop,m,n,rankinfo);
%选择，交叉，变异产生下一个子代
poolsize=round(popnum/2);%选择进行交叉变异的个数
toursize=2;%选择锦标赛的元度
select_pop=selection(ns_dc_pop,poolsize,toursize,m,n);
hc=20;%存储交叉变异相关参数
hm=20;
offspring=genetic_operate(select_pop,m,n,hc,hm,xmax,xmin);%根据选择出来的父代，产生相同数目的子代
%循环开始
t=1;
while t<=gen
%合并种群(2N)，进入循环
combine_pop(1:popnum,1:m+n+2)=ns_dc_pop;%ns_dc_pop中已按层级排序，且携带拥挤度信息
[xsize ysize]=size(offspring);
combine_pop(popnum+1:popnum+xsize,1:m+n+2)=offspring;%此时offspring中的层级和拥挤度信息还未更新
%重新进行非支配排序和聚焦距离计算
[gen_non_dominant_pop,rankinfo]=non_dominant_sort(combine_pop,m,n);
nsdc_pop=crowding_distance(gen_non_dominant_pop,m,n,rankinfo);
%选择下一代的产生（然后用于交叉变异）
ns_dc_pop=generate_offsprings(nsdc_pop,m,n,popnum);%ns_dc_pop中最后一个层级之前的个体无须按拥挤度排序，而最后一个层级需要
 %显示下一代的情况
if m==2 
    plot(ns_dc_pop(:,n+1),ns_dc_pop(:,n+2),'r*')
    axis ([0  1  0  5]);
%    set(gca,'XTick',0:0.1:1)    %设置坐标密度和范围，但不能固定坐标轴位置
%    set(gca,'YTick',0:0.2:5)
    xlabel('Function 1');
    ylabel('Function 2');
elseif m==3  
    plot3(ns_dc_pop(:,n+1),ns_dc_pop(:,n+2),ns_dc_pop(:,n+3),'kd')  
    xlabel('Function 1');
    ylabel('Function 2');
    zlabel('Function 3');
end
 grid on;
 text(0,0.2,0,['第 ',int2str(t),' 代']);
 pause(0.1)    
 %收敛性计算
 if t>=(gen*0.9)
     %导入标准解
     opt=load('paretoZDT1.dat');
     %得到函数解
   funcval=ns_dc_pop(:,n+1:n+m);  
   for j=1:m %求取最大最小值
       maxfval(j)=max(funcval(:,j));
       minfval(j)=min(funcval(:,j));
   end
   distance=zeros(1,size(funcval,1));
   sumfval=zeros(1,size(opt,1));
   dsum=0;
   for i=1:size(funcval,1)
      for j=1:size(opt,1)
        for k=1:m
          sumfval(j)= sumfval(j)+((funcval(i,k)-opt(j,k))/(maxfval(k)-minfval(k)))^2;
          %sumfval(j)为标准解集中第j个解与算法解集中第i个解的距离
        end
      end
      distance(i)=sqrt(min(sumfval));%找到与标准解集中第j个解距离最近的算法解集中的解
      sumfval(:)=0;
      dsum=dsum+distance(i);
   end   
     c=dsum/size(funcval,1)
 end 
%选择，交叉，变异产生下一个子代
poolsize=round(popnum/2);%选择进行交叉变异的个数
toursize=2;%选择锦标赛的元度
select_pop=selection(ns_dc_pop,poolsize,toursize,m,n);
hc=20;%存储交叉变异相关参数
hm=20;
offspring=genetic_operate(select_pop,m,n,hc,hm,xmax,xmin);
t=t+1;
end
%显示标题
        title('MOP using NSGA-II with DCD');
        xlabel('f(x_1)');
        ylabel('f(x_2)');

