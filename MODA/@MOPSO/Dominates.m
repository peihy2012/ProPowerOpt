function b = Dominates( obj, x, y )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if isstruct(x)
    x = x.Cost;
end
if isstruct(y)
    y = y.Cost;
end
b = all( x<=y ) && any( x<y );

end

