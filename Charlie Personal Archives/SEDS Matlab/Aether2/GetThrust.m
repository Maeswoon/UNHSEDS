function [thrust] = GetThrust ( t )  

burntimesust   = 3;    % Secondss

if ( t>=0 && t < burntimesust )
    thrust = 159/3;  % Newtons
else
    thrust = 0;    % Newtons
end

end