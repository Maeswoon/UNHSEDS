function [mass] = GetMass ( t )

% ~ AETHER4 ~

Mrocket   = 31.75; % kg (70 lb) mass of dry rocket
Msustprop = 5.9; % kg (13 lb) mass of propellant



initialMass =  Mrocket + Msustprop;

burnTimeSust   = 35; % sec

if (t>=0 && t< burnTimeSust)
    mass = initialMass - Msustprop * (t/(burnTimeSust));
elseif (t>burnTimeSust)
    mass = initialMass - Msustprop;
else
    mass = initialMass;
    
end

end