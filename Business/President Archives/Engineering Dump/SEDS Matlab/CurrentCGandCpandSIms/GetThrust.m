function [thrust] = GetThrust ( t )  

burntimeboost = 1.3;    % Seconds
burntimesust = 3;    % Seconds
startTimeboost = 2.3;    % Seconds   % 1.3 + 1 second delay

if ( t>=0 && t < burntimeboost )
    thrust = 159/1.3;  % Newtons
elseif (t>=startTimeboost && t<startTimeboost + burntimesust) % During the time of Sustainer Thrust
    thrust = 159/3;  % Newtons
else
    thrust = 0;    % Newtons
end

end