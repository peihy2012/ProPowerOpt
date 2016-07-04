
function pop = DetermineDomination( obj, pop )
    npop=numel(pop);
        for i=1:npop
        pop(i).IsDominated=false;
        for j=1:i-1
            if ~pop(j).IsDominated
                if obj.Dominates(pop(i),pop(j))
                    pop(j).IsDominated=true;
                elseif obj.Dominates(pop(j),pop(i))
                    pop(i).IsDominated=true;
                    break;
                end
            end
        end
    end

end