%��֧�����򣬾�������ǰn��Ϊ����ֵ����n+1��n+m��Ϊ����ֵ����n+m+1����¼rankֵ����n+m+2����¼ӵ������
function  [nspop,rank_info]=non_dominant_sort(pop,m,n)
  [xsize,ysize]=size(pop);
  %��¼����ȼ�
  rank=1;
  %����ṹ�����ڴ洢��ͬ����ni��si
  person(xsize)=struct('n',0,'s',[]);
  for i=1:xsize
      person(i).n=0;
  end
  %�洢��ͬ�ȼ�������Ϣ��.f��Ϊ�˱�֤�ýṹ����matlab������,����matlab����չ�Խṹ��
  F(rank).f=[];
  %��֧������
  for i=1:xsize
      for j=i+1:xsize
          less=0;  %���ڼ�¼ �ø��������������ıȽϹ�ϵ���
          equal=0;
          more=0;
           for k=1:m
              if (pop(i,n+k)<pop(j,n+k))  %��¼�ȽϹ�ϵ
                  less=less+1;
              elseif (pop(i,n+k)==pop(j,n+k))
                   equal=equal+1;
              else
                  more=more+1;
              end
           end
           if less==0 && equal~=m    %�����ڱ�����һ��ֵС���Ҳ�ȫ�����ڵ�����£���Ϊ��֧��
               person(i).n=person(i).n+1;
               person(j).s=[person(j).s i];
           elseif more==0 && equal~=m   %�����ڱ�����һ��ֵ���Ҳ�ȫ�����ڵ�����£���Ϊ��֧��
               person(i).s=[person(i).s j];
               person(j).n=person(j).n+1;
           end
      end
      if person(i).n==0   %��¼��һ��ǰ��
          F(rank).f=[F(rank).f i];
          pop(i,m+n+1)=1;
      end
  end
  %Ѱ�Һ���ǰ��
  rank_info=[];%���ڴ洢ÿ��ǰ���������������
  while(~isempty(F(rank).f))
      H=[];
      rank_info=[rank_info  length(F(rank).f)]; %Ϊ�����۽�����ļ���������
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
  nspop=pop(index,1:m+n+1);%����rankֵ��������Ⱥ
end