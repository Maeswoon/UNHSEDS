function [thrust] = GetThrust ( t )  

burntimeboost = .7;    % Seconds
burntimesust = 1.7;    % Seconds
startTimeboost = 1;    % Seconds

if ( t>=0 && t < burntimeboost )
    thrust = 403;  % Newtons
elseif (t>=startTimeboost && t<startTimeboost + burntimesust) % During the time of Sustainer Thrust
    thrust = 205;  % Newtons
else
    thrust = 0;    % Newtons
end

end