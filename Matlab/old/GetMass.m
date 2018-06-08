function [mass] = GetMass ( t )
initialMass = 1.351;      % kg
initialFuelMass = .1326;  % kg
burnTime = .7;            % sec
if t>=0 && t<=burnTime
    mass = initialMass - initialFuelMass*(t/burnTime);
elseif t>burnTime
    mass = initialMass - initialFuelMass;
else
    mass = initialMass;
end
end