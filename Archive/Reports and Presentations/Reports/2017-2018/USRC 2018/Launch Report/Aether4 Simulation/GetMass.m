function [mass] = GetMass ( t )

% ~ AETHER4 ~

Sustainer_Mass = 1.229; %kg
Booster_Mass   = 0.873; %kg
Mboostprop     = 0.187; %kg
Msustprop      = 0.185; %kg
initialMass = Sustainer_Mass + Booster_Mass; %kg
initialSustMass = Sustainer_Mass; %kg

burnTimeBoost  = 1.9;              % sec
burnTimeSust   = 1.72;             % sec
startTimesust = burnTimeBoost + 2.9; % sec
startTimecoast = startTimesust + burnTimeSust; %sec

% Conditional to print total mass of rocket at any given time.
if (t>=0 && t<burnTimeBoost)
    mass = initialMass - Mboostprop *(t/burnTimeBoost);
elseif (t>=burnTimeBoost && t<startTimesust)
    mass = initialMass - Mboostprop;
elseif (t>=startTimesust && t< startTimesust + burnTimeSust)
    mass = initialSustMass - Msustprop * (t/(burnTimeSust + startTimesust));
elseif (t>startTimecoast)
    mass = initialSustMass - Msustprop;
else
    mass = initialMass;
end
end