%交叉变异
function  nextgen=genetic_operate(pop,m,n,hc,hm,xmax,xmin)
[xsize ysize]=size(pop);
p=1;
nextgen_temp=[];%用于存储产生的子代
while p<=xsize
   temprand=randperm(xsize);
   selcrossindex=temprand(1:2);
   crosser=pop(selcrossindex,:);%选择交叉父代
   for i=1:n
     %交叉过程
     if rand<0.9%交叉概率
          %SBX交叉系数产生
           u=rand;
           if u<=0.5
               b=(2*u)^(1/(hc+1));
           else
               b=1/((2*(1-u))^(1/(hc+1)));
           end
       crosser(1,i)=0.5*((1-b)*crosser(1,i)+(1+b)*crosser(2,i)); %SBX交叉
       crosser(2,i)=0.5*((1-b)*crosser(2,i)+(1+b)*crosser(1,i));
              for j=1:2  %限制上下限
                if crosser(j,i)>xmax
                   crosser(j,i)=xmax;
                elseif  crosser(j,i)<xmin
                     crosser(j,i)=xmin;
                end
              end
     end  
     %变异操作
     for j=1:2
        if rand<1/n
             r=rand;
             if r<0.5
                 mu=((2*r)^(1/(hm+1)))-1;
             else
                 mu=1-((2*(1-r))^(1/(hm+1)));
             end
             crosser(j,i)=crosser(j,i)+(xmax-xmin)*(mu);
               %设定上下限 
               if crosser(j,i)>xmax
                   crosser(j,i)=xmax;
                elseif  crosser(j,i)<xmin
                     crosser(j,i)=xmin;
                end
        end
     end   
   end
   nextgen_temp(p:p+1,:)=crosser;
   p=p+2;
end
  nextgen=value_objective(nextgen_temp,m,n);
end