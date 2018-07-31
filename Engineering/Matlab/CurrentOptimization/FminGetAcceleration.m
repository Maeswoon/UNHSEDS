
% ~ AETHER4 ~

function [a, d] = FminGetAcceleration (t , v, h, x)
g = 9.81;
f = GetThrust ( t,x );
m = GetMass ( t,x ); %THIS WILL CHANGE WITH ITERATIONS
[d] = FminGetDrag ( v,h,t,x );
a = ( f - m*g - d )/ m ; % Newton Second Law
end
