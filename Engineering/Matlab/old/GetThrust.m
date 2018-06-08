function [thrust] = GetThrust ( t )
burnTime = .7;    %Seconds
if ( t>0 && t < burnTime )
    thrust = 403; %Newtons
else
    thrust = 0;   %Newtons
end
end