
function i = RouletteWheelSelection( obj,p )

    r=rand;
    c=cumsum(p);
    i=find(r<=c,1,'first');

end