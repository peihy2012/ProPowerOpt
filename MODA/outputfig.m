clear;clc;
addpath('.\export_fig');
%%
% file=dir('H:\Research\屏\20140627\位移分析200Hz\*.txt');
% filenum=length(file);
% fs=200;
% T=120;
% nn=fs*T+1;
% m=zeros(1,filenum);
% doubleamp=m;
% stdz=zeros(1,filenum);
% data=zeros(nn,filenum);
% data2=data;
% t=0:1/fs:T;
% for i=1:1
%     filename = strcat('H:\Research\屏\20140627\位移分析200Hz\',file(i).name);
%     fid=fopen(filename,'r');
%     data(:,i)=fscanf(fid,'%f',nn);
%     fclose(fid);
%     m(i)=mean(data(:,i));
%     data2(:,i)=data(:,i)-m(i);
%     doubleamp(i)=max(data2(:,i))-min(data2(:,i));
%     stdz(i)=std(data(:,i));
%     figure(2*i-1);
%     plot(t,data2(:,i));
%     xlim([0 120]);
%     xlabel('时间(s)','fontsize',30,'FontName','Times New Roman');
%     ylabel('双幅值(μm)','fontsize',30,'FontName','Times New Roman');
%     set(gcf, 'Position', [0 0 1400 500]);
%     set(gca,'FontName','Times New Roman','FontSize',30,'xtick',[0:20:120]);
%     jpegname=filename(1:45);     %每个汉字算一个字节
%     print(gcf,'-djpeg',[jpegname,'-t.jpeg']);
% end
%%
% % Im=imread('pic.jpg');
% % imwrite(Im,'testdpi.tif', 'tiff', 'Resolution',300); 
% exportfig(gcf,'Fig1001.jpeg')
% exportfig(fi, 'image/fig2.eps', 'FontMode', 'fixed','FontSize', 10, 'color', 'cmyk' );
%%
% figure(1)
% mkdir([cd,'\image']) 
directory=[cd,'\image\'];
for n = 1:100

    fi = open([directory,'Fig',num2str(1000+n),'.fig']);
    set(gca,'FontName','Times New Roman','FontSize',8);
    export_fig(gcf,['image_eps/Fig_',num2str(1000+n),'.eps']);
    [a,b]=eps2xxx(['image_eps/Fig_',num2str(1000+n),'.eps'],{'png'});
    close(fi);

end





















