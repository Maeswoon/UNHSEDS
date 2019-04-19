function [mass] = GetMass ( t )

% ~ AETHER4 ~

Mrocket   = 20;
Msustinit = 15;    % Initial mass of sustainer 
Msustprop = 8.00;    % Mass of propellant



initialMass =  Msustinit + Mrocket + Msustprop;

burnTimeSust   = 11;            % sec

if (t>=0 && t< burnTimeSust)
    mass = initialMass - Msustprop * (t/(burnTimeSust));
elseif (t>burnTimeSust)
    mass = initialMass - Msustprop;
else
    mass = initialMass;
    
end

end