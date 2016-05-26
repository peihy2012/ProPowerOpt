function [ Swind ] = windsample( npoints, dim )
%WINDSAMPLE Summary of this function goes here
%   the wind speed follows Weibull distribution

c = rand(dim,npoints);     % 1 row, 100,000 columns
v = wblinv(c,10,1.4);      % k=1.4  lambda = 10 
% [vy,vt] = ksdensity( v, 'npoints',1000,'function','pdf' );
% figure(1)
% plot(vt,vy);hold on;
%% wind power output function (v-p function) 
Vc = 3;        % cut-in wind speed ( or velocity )
Vn = 12;       % nominal wind speed ( or velocity )
Vo = 25;       % cut-out wind speed ( or velocity )
Pn = 0.7990;   % nominal active power output
a = [36.14 -25.53 5.14 -0.21]/100.5*0.75;      % factors of n-order terms
f0 = @(x) a(1)+a(2)*x+a(3)*x.^2+a(4)*x.^3;     % v-p function
%% v-p function test and plot
% v1 = [3:0.01:15];
% y1 = f0(v1);
% figure(2)
% plot(y1)
%% active power output ranges
indVc_Vn = (v>Vc).*(v<=Vn);
indVn_Vo = (v>Vn).*(v<=Vo);
P = zeros(size(v));
Pv = f0(v);
Pwind = P + Pv.*indVc_Vn + Pn*indVn_Vo;
%% wind power output rate cos(phi)=0.8 phi =acos(0.8)
phi = acos(0.8);
Swind = P.*(1+i*tan(phi));
%% output active power distribution
% P(P<0.1)=[];
% P(P>=0.7990)=[];
% [py,pt] = ksdensity( P, 'npoints',1000,'support',[-0.1 0.82],'function','pdf' );
% figure(2)
% plot(pt,py);hold on;

end

