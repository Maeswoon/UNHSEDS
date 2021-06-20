function [mass] = GetMass ( t, x )

% ~ Competition Rocket ~

BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube
PL = 4.882; % 4882 grams per square meter for Plate Parts



Mnosecone                = .150;                      % For simplification, mass of nosecone will be approximated and kept constant
Mshoulder                = x(2)*BT;                   % Varying Shoulder weight with changing dimensions
Mebay                    = .400;                      % Weight of unchanging E-Bay, must calculate value
Msustbodytube            = x(3)*BT;                   % Varying Sustainer body tube with changing dimensions         
Mforwardfins             = PL * .5* x(8)*x(9)*x(10);  % Varying Fin weight with changing dimensions
Mstagingcoupler          = CP * .05;                  % This will always be ~ 5cm for the competition rocket
Mboosterbodytube         = x(5) * BT;                 % Varying Booster tube weight with changing dimensions
Maftfins                 = PL * .5*x(12)*x(13)*x(14); % Varying Fin weight with changing dimensions
Msustcasingtuberetainer  = .110 + ET*.32;             % Mass of the Engine Casing, Engine Tube and Retainer
Mboostcasingtuberetainer = .110 + ET*.32;             % Mass of the Engine Casing, Engine Tube and Retainer
Mboostinit               = .294;                      % Initial mass of booster,   H399
Msustinit                = .349;                      % Initial mass of sustainer, I204 
Mboostprop               = .139;                      % Mass of propellant, H399
Msustprop                = .184;                      % Mass of propellant, I204

Mdrogueparachute         = .050;                      % Need to find the weight of the parachutes that we will be using
Mmainparachute           = .050;                      % " "
Mboosterparachute        = .050;                      % " "

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