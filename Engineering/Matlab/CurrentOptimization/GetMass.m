function [mass] = GetMass (t,x,Part)

% ~ AETHER4 ~

BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube
PL = 4.882; % 4882 grams per square meter for Plate Parts

Mbattery                 =0;
Mnosecone                = .150;
Mshoulder                = x(2)*BT;
Mebay                    = .400; % Whole E-Bay, Must find Value
Msustbodytube            = x(3)*BT;
Mforwardfins             = PL * .5*x(8)*x(9)*x(10);
Mstagingcoupler          = .058;    
Mboosterbodytube         = x(5) * BT;
Maftfins                 = PL * .5*x(12)*x(13)*x(14); 
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


          % sec
startTimeSust = Part(10).burnTime+x(4);          % sec

if (t>=0 && t<Part(10).burnTime)    %Launch to boost eject
    mass = initialMass - Mboostprop *(t/Part(10).burnTime);
elseif (t>=Part(10).burnTime && t<startTimeSust) %Coast
    mass = initialMass - Mboostprop;
elseif (t>=startTimeSust && t< startTimeSust + Part(6).burnTime)    %Sust ign to MT
    mass = initialSustMass - Msustprop * (t/(Part(6).burnTime + startTimeSust));
elseif (t>startTimeSust+Part(6).burnTime)    %MT
    mass = initialSustMass - Msustprop;
else
    mass = initialMass;
    
end

end