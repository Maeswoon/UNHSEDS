function [mass] = GetMass ( t,x )

% ~ AETHER4 ~
%Densities [kg/m3]
FiberGlass=2600;
%BlueTube=
%CarbonFiber=
%Nylon=
BT = .330;  % 330 grams per meter for Body Tube 1.75" ID
CP = .322;  % 322 grams per meter for Coupler Body Tube 
ET = .167;  % 167 grams per meter for Engine Tube 29mm
PL = 4.882; % 4882 grams per square meter for Plate Parts

Mbattery                 = 0;
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


burnTimeBoost  = .9;          % sec
burnTimeSust   = 1.72;            % sec
startTimeboost = 1.9;          % sec
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