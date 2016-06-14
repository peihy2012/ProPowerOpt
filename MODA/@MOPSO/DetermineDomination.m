function pop = DetermineDomination( obj, pop )
%DetermineDomination Summary of this function goes here
%   Detailed explanation goes here

% number of pop elements.
nPop = numel(pop);
for i = 1:nPop
    pop(i).IsDominated = false;
end

for i = 1:nPop-1
    for j = i+1:nPop
        if Dominates(pop(i),pop(j))
           pop(j).IsDominated = true;
        end
        if Dominates(pop(j),pop(i))
           pop(i).IsDominated = true;
        end
    end
end
end
%%
function b = Dominates( x, y )
    if isstruct(x)
        x = x.Cost;
    end
    if isstruct(y)
        y = y.Cost;
    end
    b = all( x<=y ) && any( x<y );
end
