% u=0:0.01:1.0;
% hc=50;
% for i=1:size(u,2)
%     if u<=0.5
%         b(i)=(2*u(i))^(1/(hc+1));
%     else
%         b(i)=1/((2*(1-u(i)))^(1/(hc+1)));
%     end
% end
% plot(u,b)
% hold on

r=0:0.01:1.0;
hm=20;
for i=1:size(r,2)
    if r(i)<0.5
        mu(i)=((2*r(i))^(1/(hm+1)))-1;
    else
        mu(i)=1-((2*(1-r(i)))^(1/(hm+1)));
    end
end
plot(u,mu)
hold on