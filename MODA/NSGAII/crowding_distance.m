%�۽�����ļ���,��������ǰn��Ϊ����ֵ����n+1��n+m��Ϊ����ֵ����n+m+1����¼rankֵ����n+m+2����¼ӵ������
function nsdcpop=crowding_distance(pop,m,n,rank_info)
[xsize,ysize]=size(pop);
index=0;%�洢ÿ��rank�ȼ���ʼ��������λ��
 pop(:,m+n+2)=0;%���ڴ洢cdֵ
for i=1:length(rank_info)
    for j=1:m
        [temp index_sort]=sort(pop(index+1:index+rank_info(i),n+j));%�Ե�ǰ�㼶�еĸ����������
        index_sort=index_sort+index;%��¼�����λ�ã�index_sortָʾ��ǰ��������Ⱥ�е����򣨲㼶���ȼ�����ӵ���ȣ�
       for k=1:rank_info(i)
           newpos=find(index_sort==index+k);%�ҵ�����k������λ�ã�Ȼ����ȡӵ������
           if (newpos==1 || newpos==rank_info(i))
                pop(index+k,m+n+2)=inf; %�߽紦ӵ����������Ϊ���޴�
           else
               pre_person_index=index_sort(newpos+1);
               next_person_index=index_sort(newpos-1);
               pop(index+k,m+n+2)=pop(index+k,m+n+2)+(pop(pre_person_index,n+j)-pop(next_person_index,n+j))/m;%����ӵ������
           end
       end
    end
    index =index+rank_info(i);
end
nsdcpop=pop;
end