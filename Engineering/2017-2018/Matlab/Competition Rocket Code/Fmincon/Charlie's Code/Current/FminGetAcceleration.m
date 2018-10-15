
% ~ AETHER4 ~

function [a, d] = FminGetAcceleration (t , v, h, x)
g = 9.81;                      % Constant g through flight
f = GetThrust ( t );           % Calculates the thrust that is acted on the rocket through flight
m = GetMass ( t );             % Calculates mass of entire rocket, then sustainer after seperation
[d] = FminGetDrag ( v,h,t,x ); % Drag on whole rocket, then the sustainer at seperation
a = ( f - m*g - d )/ m ;       % Newton Second Law
end
