clc;
%��ʼ������
popnum=200;
gen=100;
xmin=0;%����ȡֵ��Χ
xmax=1;
m=2;%Ŀ�꺯������
n=30;%���߱�����Ŀ
hc=20;%����������
hm=20;
%������ʼ��Ⱥ
initpop=rand(popnum,n)*(xmax-xmin)+xmin;
init_value_pop=value_objective(initpop,m,n);
%��ͼ��ʾ��ʼͼ
plot(init_value_pop(:,n+1),init_value_pop(:,n+m),'B+')
pause(.1)
%��֧������;ۼ��������
[non_dominant_sort_pop, rankinfo]=non_dominant_sort(init_value_pop,m,n);
ns_dc_pop=crowding_distance(non_dominant_sort_pop,m,n,rankinfo);
%ѡ�񣬽��棬���������һ���Ӵ�
poolsize=round(popnum/2);%ѡ����н������ĸ���
toursize=2;%ѡ���������Ԫ��
select_pop=selection(ns_dc_pop,poolsize,toursize,m,n);
hc=20;%�洢���������ز���
hm=20;
offspring=genetic_operate(select_pop,m,n,hc,hm,xmax,xmin);%����ѡ������ĸ�����������ͬ��Ŀ���Ӵ�
%ѭ����ʼ
t=1;
while t<=gen
%�ϲ���Ⱥ(2N)������ѭ��
combine_pop(1:popnum,1:m+n+2)=ns_dc_pop;%ns_dc_pop���Ѱ��㼶������Я��ӵ������Ϣ
[xsize ysize]=size(offspring);
combine_pop(popnum+1:popnum+xsize,1:m+n+2)=offspring;%��ʱoffspring�еĲ㼶��ӵ������Ϣ��δ����
%���½��з�֧������;۽��������
[gen_non_dominant_pop,rankinfo]=non_dominant_sort(combine_pop,m,n);
nsdc_pop=crowding_distance(gen_non_dominant_pop,m,n,rankinfo);
%ѡ����һ���Ĳ�����Ȼ�����ڽ�����죩
ns_dc_pop=generate_offsprings(nsdc_pop,m,n,popnum);%ns_dc_pop�����һ���㼶֮ǰ�ĸ������밴ӵ�������򣬶����һ���㼶��Ҫ
 %��ʾ��һ�������
if m==2 
    plot(ns_dc_pop(:,n+1),ns_dc_pop(:,n+2),'r*')
    axis ([0  1  0  5]);
%    set(gca,'XTick',0:0.1:1)    %���������ܶȺͷ�Χ�������̶ܹ�������λ��
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
 text(0,0.2,0,['�� ',int2str(t),' ��']);
 pause(0.1)    
 %�����Լ���
 if t>=(gen*0.9)
     %�����׼��
     opt=load('paretoZDT1.dat');
     %�õ�������
   funcval=ns_dc_pop(:,n+1:n+m);  
   for j=1:m %��ȡ�����Сֵ
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
          %sumfval(j)Ϊ��׼�⼯�е�j�������㷨�⼯�е�i����ľ���
        end
      end
      distance(i)=sqrt(min(sumfval));%�ҵ����׼�⼯�е�j�������������㷨�⼯�еĽ�
      sumfval(:)=0;
      dsum=dsum+distance(i);
   end   
     c=dsum/size(funcval,1)
 end 
%ѡ�񣬽��棬���������һ���Ӵ�
poolsize=round(popnum/2);%ѡ����н������ĸ���
toursize=2;%ѡ���������Ԫ��
select_pop=selection(ns_dc_pop,poolsize,toursize,m,n);
hc=20;%�洢���������ز���
hm=20;
offspring=genetic_operate(select_pop,m,n,hc,hm,xmax,xmin);
t=t+1;
end
%��ʾ����
        title('MOP using NSGA-II with DCD');
        xlabel('f(x_1)');
        ylabel('f(x_2)');

