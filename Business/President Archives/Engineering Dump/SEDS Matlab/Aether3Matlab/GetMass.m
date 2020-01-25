function [mass] = GetMass ( t ) % Needs to be checked and verified
%Masses

Mnosecone                = .107;
Mshoulder                = .052;
Mebay                    = .401; % .221 + 180 for payload of 4 bolts
Mbattery                 = .045;
Msustbodytube            = .075;
Mforwardfins             = .030;
Mstagingcoupler          = .082;    
Mboosterbodytube         = .114;    
Maftfins                 = .030; 
Msustcasingtuberetainer  = .077;    % Mass of the Engine Casing, Engine Tube and Retainer
Mboostcasingtuberetainer = .081;    % Mass of the Engine Casing, Engine Tube and Retainer
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