
% ~ AETHER4 ~

function [a, d] = GetAcceleration (t , v, h )
g = 9.81;
f = GetThrust ( t );
m = GetMass ( t );
d = GetDrag ( v,h,t );
a = ( f - m*g - d )/ m ; % Newton Second Law
end



