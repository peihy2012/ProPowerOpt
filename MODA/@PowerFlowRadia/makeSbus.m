function makeSbus( obj )
%MAKESBUS   Builds the vector of complex bus power injections.
%   MAKESBUS(OBJ) returns the vector of complex bus
%   power injections, that is, generation minus load. Power is expressed
%   in per unit.

obj.Sbus =  (obj.busdata(:, 5) + 1j * obj.busdata(:, 6));


end

