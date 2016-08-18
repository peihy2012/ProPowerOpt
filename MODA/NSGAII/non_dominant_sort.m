%非支配排序，矩阵行中前n个为变量值，第n+1：n+m个为函数值，第n+m+1个记录rank值，第n+m+2个记录拥挤距离
function  [nspop,rank_info]=non_dominant_sort(pop,m,n)
  [xsize,ysize]=size(pop);
  %记录排序等级
  rank=1;
  %构造结构，用于存储不同个体ni和si
  person(xsize)=struct('n',0,'s',[]);
  for i=1:xsize
      person(i).n=0;
  end
  %存储不同等级个体信息（.f是为了保证该结构能在matlab中运行,利用matlab可扩展性结构）
  F(rank).f=[];
  %非支配排序
  for i=1:xsize
      for j=i+1:xsize
          less=0;  %用于记录 该个体与其他个体间的比较关系情况
          equal=0;
          more=0;
           for k=1:m
              if (pop(i,n+k)<pop(j,n+k))  %记录比较关系
                  less=less+1;
              elseif (pop(i,n+k)==pop(j,n+k))
                   equal=equal+1;
              else
                  more=more+1;
              end
           end
           if less==0 && equal~=m    %不存在比另外一个值小，且不全部等于的情况下，即为被支配
               person(i).n=person(i).n+1;
               person(j).s=[person(j).s i];
           elseif more==0 && equal~=m   %不存在比另外一个值大，且不全部等于的情况下，即为被支配
               person(i).s=[person(i).s j];
               person(j).n=person(j).n+1;
           end
      end
      if person(i).n==0   %记录第一个前沿
          F(rank).f=[F(rank).f i];
          pop(i,m+n+1)=1;
      end
  end
  %寻找后续前沿
  rank_info=[];%用于存储每个前沿所包含个体个数
  while(~isempty(F(rank).f))
      H=[];
      rank_info=[rank_info  length(F(rank).f)]; %为后续聚焦距离的计算做服务
      for i=1:length(F(rank).f) 
         if ~isempty(person(F(rank).f(i)).s)
           for j=1:length(person(F(rank).f(i)).s)
                 person(person(F(rank).f(i)).s(j)).n=person(person(F(rank).f(i)).s(j)).n-1;
                 if person(person(F(rank).f(i)).s(j)).n==0
                     H=[H person(F(rank).f(i)).s(j)];
                     pop(person(F(rank).f(i)).s(j),m+n+1)=rank+1;
                 end
           end
         end
      end
      rank=rank+1;
      F(rank).f=H;
  end
  [temp,index]=sort(pop(:,m+n+1));
  nspop=pop(index,1:m+n+1);%按照rank值排序后的种群
end