function [a] = GetAcceleration (t , v )
g = 9.81;
f = GetThrust ( t );
m = GetMass ( t );
d = GetDrag ( v );
a = ( f - m * g -d )/ m ; % Newton Second Law
end
