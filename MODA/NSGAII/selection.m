%ѡ�������ѡȡ���н������ĸ���
function selpop=selection(pop,popnum,tournum,m,n,xmax,xmin)
selpop=[];%���ڴ洢ѡ�����Ⱥ  
for i=1:popnum
     p=randperm(popnum);
     sel(1:tournum)=p(1:tournum);
     tourpop=pop(sel,:);%ѡ��toursize�����бȽ�
     minindex=find(tourpop(:,m+n+1)==min(tourpop(:,m+n+1)));%�Ȳ��ҵȼ����
     if length(minindex)==1 
         selpop(i,:)=tourpop(minindex,:);
     else%����ӵ���������
         maxindex=find(pop(minindex,m+n+2)==max(pop(minindex,m+n+2)));
         if length(maxindex~=1)
             selpop(i,:)=pop(maxindex(1),:);
         else
             selpop(i,:)=pop(maxindex,:);
         end
     end
end
end