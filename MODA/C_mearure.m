% clear;clc;

% load('gwo_10_06.mat');
% gwoOut = [];
% for n = 1:numel(mo.Archive)
%     gwoOut = [gwoOut mo.Archive(n).Cost];
% end
% clear mo;
% load('pso_10_06.mat');
% psoOut = [];
% for n = 1:numel(mo.rep)
%     psoOut = [psoOut mo.rep(n).Cost];
% end
% clear mo;

% load('gwo_10.mat');
% gwoOut = [];
% for n = 1:numel(mo_gwo.Archive)
%     gwoOut = [gwoOut mo_gwo.Archive(n).Cost];
% end
% load('pso_10.mat');
% psoOut = [];
% for n = 1:numel(mo_pso.rep)
%     psoOut = [psoOut mo_pso.rep(n).Cost];
% end
% clear mo_pso mo_gwo;


% A = psoOut;
% B = gwoOut;
% B = moeadF;
% A = spea2F;
% numB = size(B,2);
% numA = size(A,2);
% isDominated = zeros(1,numB);
% for m = 1:numB
%     indA = 1;
%     for indA = 1:numA
%         if ( all(A(:,indA)<=B(:,m)) && any(A(:,indA)<B(:,m)) );
%            isDominated(m) = 1;
%            break;
%         end
%     end
% end
% indC = sum(isDominated)/numB;

% %%Cmeasure
% function indC = measureC(A,B)
% % B number of column
% numB = size(B,2);
% indC = 1/numB;
% end
% %%Dominate
% function b = Dominates(x,y)
%     b=all(x<=y) && any(x<y);
% end
% 
% load('mo_result_18_Aug_2016_12_10_04.mat')
% gridPath = '.\GridData';
% addpath(gridPath);


c1(1) = Cm(mor.gwo, mor.pso);
c1(2) = Cm(mor.gwo, mor.ead);
c1(3) = Cm(mor.gwo, mor.spea);

c1(4) = Cm(mor.pso, mor.gwo);
c1(5) = Cm(mor.pso, mor.ead);
c1(6) = Cm(mor.pso, mor.spea);

c1(7) = Cm(mor.ead, mor.gwo);
c1(8) = Cm(mor.ead, mor.pso);
c1(9) = Cm(mor.ead, mor.spea);

c1(10) = Cm(mor.spea, mor.gwo);
c1(11) = Cm(mor.spea, mor.pso);
c1(12) = Cm(mor.spea, mor.ead);















