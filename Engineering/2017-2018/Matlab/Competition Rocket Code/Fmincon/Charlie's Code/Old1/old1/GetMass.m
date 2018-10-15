function [mass] = GetMass ( t, x )

% ~ Competition Rocket ~

BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube
PL = 4.882; % 4882 grams per square meter for Plate Parts



Mnosecone                = .150;
Mshoulder                = x(2)*BT;
Mebay                    = .400; % Whole E-Bay, Must find Value
Msustbodytube            = x(3)*BT;
Mforwardfins             = PL * .5* Cr*Ct*Ss;
Mstagingcoupler          = .058;    
Mboosterbodytube         = x(5) * BT;
Maftfins                 = PL * .5*Cr2*Ct2*Ss2; 
Msustcasingtuberetainer  = .110 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer
Mboostcasingtuberetainer = .110 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer
Mboostinit               = .294;                    % Initial mass of booster
Msustinit                = .349;                    % Initial mass of sustainer 
Mboostprop               = .139;                    % Mass of propellant 
Msustprop                = .184;                    % Mass of propellant

Mdrogueparachute         = .024;
Mmainparachute           = .071;
Mboosterparachute        = .036; 

initialMass = Mboostinit + Msustinit + Mnosecone + Mshoulder + Mebay + Mbattery + Msustbodytube + Mforwardfins + Msustcasingtuberetainer...
    + Mstagingcoupler + Mboosterbodytube + Mboostcasingtuberetainer + Maftfins +...
    Mdrogueparachute + Mmainparachute + Mboosterparachute;
initialSustMass = Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Msustcasingtuberetainer...
    + Mforwardfins + Mdrogueparachute + Mmainparachute;



burnTimeBoost  = .7;          % sec
burnTimeSust   = 1.7;            % sec
startTimesust = .7 + x(16);          % sec
startTimecoast = startTimesust + burnTimeSust;

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