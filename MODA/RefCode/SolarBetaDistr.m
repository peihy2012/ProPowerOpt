% photovoltaic follow Beta distribution
sampleNum = 100000;
Area = 200*4;
eta = 0.14;
Lmax = 700;
Lmin = 0;
alpha = 0.8;
beta = 1.87;
c = rand(1,sampleNum);
% x = betainv(c,1.5585,1.8629);
% x = betainv(c,1.7321,2.8884);
x = betainv(c,alpha,beta);
Psol = Area * eta * ( Lmax * x + Lmin ) / 1e6; 

% Psol = Area * eta * ( (Lmax-Lmin)*x + Lmin); 
% [yp,xp] = ksdensity(x,'npoints',1000,'function','pdf' );
% [yp,xp] = ksdensity(Psol,[0:0.001:1],'function','pdf' );

% [yp,xp] = ksdensity(Psol,'support','positive','function','pdf' );
% % [yp,xp] = ksdensity(Psol,'function','pdf' );
% plot(xp,yp)

