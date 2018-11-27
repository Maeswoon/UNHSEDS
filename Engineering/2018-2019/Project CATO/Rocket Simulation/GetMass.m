function [mass] = GetMass ( t )

% ~ AETHER4 ~

Mnosecone                = .111;
Mshoulder                = .130;
Mebay                    = .155;
Mbattery                 = .000;
Msustbodytube            = .105;
Mforwardfins             = .123;
Msustcasingtuberetainer  = .101;    % Mass of the Engine Casing, Engine Tube and Retainer
Msustinit                = .194;    % Initial mass of sustainer 
Msustprop                = .086;    % Mass of propellant
Mdrogueparachute         = .024;
Mmainparachute           = .071;


initialMass =  Msustinit + Mnosecone + Mshoulder + Mebay + Mbattery + Msustbodytube...
    + Mforwardfins + Msustcasingtuberetainer + Mdrogueparachute + Mmainparachute;

burnTimeSust   = 3;            % sec

if (t>=0 && t< burnTimeSust)
    mass = initialMass - Msustprop * (t/(burnTimeSust));
elseif (t>burnTimeSust)
    mass = initialMass - Msustprop;
else
    mass = initialMass;
    
end

end