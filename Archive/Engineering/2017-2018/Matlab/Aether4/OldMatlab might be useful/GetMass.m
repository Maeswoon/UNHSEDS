function [mass] = GetMass ( t )

% AETHER4

Mnosecone                = .111;
Mshoulder                = .130;
Mebay                    = .215;
Mbattery                 = .000;
Msustbodytube            = .105;
Mforwardfins             = .123;
Mstagingcoupler          = .058;    
Mboosterbodytube         = .145;
Maftfins                 = .079; 
Msustcasingtuberetainer  = .101;    % Mass of the Engine Casing, Engine Tube and Retainer
Mboostcasingtuberetainer = .101;    % Mass of the Engine Casing, Engine Tube and Retainer
Mboostinit               = .198;    % Initial mass of booster
Msustinit                = .194;    % Initial mass of sustainer 
Mboostprop               = .082;    % Mass of propellant 
Msustprop                = .086;    % Mass of propellant


initialMass = Mboostinit + Msustinit + Mnosecone + Mshoulder + Mebay + Mbattery + Msustbodytube + Mforwardfins + Msustcasingtuberetainer...
    + Mstagingcoupler + Mboosterbodytube + Mboostcasingtuberetainer + Maftfins;
initialSustMass = Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Msustcasingtuberetainer + Mforwardfins;


burnTimeBoost  = 1.3;          % sec
burnTimeSust   = 3;            % sec
startTimeboost = 2.3;          % sec
startTimecoast = startTimeboost + burnTimeSust;

if (t>=0 && t<burnTimeBoost)
    mass = initialMass - Mboostprop *(t/burnTimeBoost);
elseif (t>=burnTimeBoost && t<startTimeboost)
    mass = initialMass - Mboostprop;
elseif (t>=startTimeboost && t< startTimeboost + burnTimeSust)
    mass = initialSustMass - Msustprop * (t/(burnTimeSust + startTimeboost));
elseif (t>startTimecoast)
    mass = initialSustMass - Msustprop;
else
    mass = initialMass;
    
end

end