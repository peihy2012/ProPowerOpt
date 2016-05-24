%___________________________________________________________________%
%  Multi-Objective Dragonfly Algorithm (MODA) source codes demo     %
%                           version 1.0                             %
%                                                                   %
%  Developed in MATLAB R2011b(7.13)                                 %
%                                                                   %
%  Author and programmer: Seyedali Mirjalili                        %
%                                                                   %
%         e-Mail: ali.mirjalili@gmail.com                           %
%                 seyedali.mirjalili@griffithuni.edu.au             %
%                                                                   %
%       Homepage: http://www.alimirjalili.com                       %
%                                                                   %
%   Main paper:                                                     %
%                                                                   %
%   S. Mirjalili, Dragonfly algorithm: a new meta-heuristic         %
%   optimization technique for solving single-objective, discrete,  %
%   and multi-objective problems, Neural Computing and Applications %
%   DOI: http://dx.doi.org/10.1007/s00521-015-1920-1                %
%___________________________________________________________________%

% Modify this file with respect to your objective function
function o = ZDT1(x)
%%
o = [0, 0];

dim = length(x);
g = 1 + 9*sum(x(2:dim))/(dim-1);

o(1) = x(1);
o(2) = g*(1-sqrt(x(1)/g));

% fobj = @F9;
% lb=-5.12;
% ub=5.12;
% dim=size(x,2);
% x1 = x.*(ub-lb)+lb;
% o(1)=sum(x1.^2-10*cos(2*pi.*x1))+10*dim;
% 
% aH=[10 3 17 3.5 1.7;.05 10 17 .1 8;3 3.5 1.7 10 17;17 8 .05 10 .1];
% cH=[1 1.2 3 3.2];
% pH=[.1312 .1696 .5569 .0124 .8283;.2329 .4135 .8307 .3736 .1004;...
% .2348 .1415 .3522 .2883 .3047;.4047 .8828 .8732 .5743 .1091];
% o(2)=0;
% for i=1:4
%     o(2)=o(2)-cH(i)*exp(-(sum(aH(i,:).*((x-pH(i,:)).^2))));
% end


