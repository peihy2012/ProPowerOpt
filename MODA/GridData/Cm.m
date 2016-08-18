function [ C ] = Cm( A, B )
%C measure Summary of this function goes here
%   Detailed explanation goes here
numB = size(B,2);
numA = size(A,2);
isDominated = zeros(1,numB);
for m = 1:numB
    indA = 1;
    for indA = 1:numA
        if ( all(A(:,indA)<=B(:,m)) && any(A(:,indA)<B(:,m)) );
           isDominated(m) = 1;
           break;
        end
    end
end
C = sum(isDominated)/numB;

end

