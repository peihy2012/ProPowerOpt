%选择操作，选取进行交叉变异的个体
function selpop=selection(pop,popnum,tournum,m,n,xmax,xmin)
selpop=[];%用于存储选择出种群  
for i=1:popnum
     p=randperm(popnum);
     sel(1:tournum)=p(1:tournum);
     tourpop=pop(sel,:);%选择toursize个进行比较
     minindex=find(tourpop(:,m+n+1)==min(tourpop(:,m+n+1)));%先查找等级最低
     if length(minindex)==1 
         selpop(i,:)=tourpop(minindex,:);
     else%查找拥挤距离最长的
         maxindex=find(pop(minindex,m+n+2)==max(pop(minindex,m+n+2)));
         if length(maxindex~=1)
             selpop(i,:)=pop(maxindex(1),:);
         else
             selpop(i,:)=pop(maxindex,:);
         end
     end
end
end