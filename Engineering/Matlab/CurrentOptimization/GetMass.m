function [mass] = GetMass (t,x,Aether)

% ~ AETHER4 ~

BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube
PL = 4.882; % 4882 grams per square meter for Plate Parts


Mshoulder                = x(2)*BT;
Msustcoupler             = x(3) * CP;  % Whole E-Bay, Must find Value
Msustbodytube            = x(3)*BT;
Mforwardfins             = PL * .5*x(8)*x(9)*x(10);
Aether.StagingCoupler.mass   = x(11) * CP;    
Mboosterbodytube         = x(5) * BT;
Maftfins                 = PL * .5*x(13)*x(15); 
Msustcasingtuberetainer  = .120 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer
Mboostcasingtuberetainer = .120 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer

Mdrogueparachute         = .030; % Guesses, but good enough.
Mmainparachute           = .070;
Mboosterparachute        = .040; 

initialMass = Aether.BoosterMotor.mass + Aether.SustainerMotor.mass + Aether.Nosecone.mass + Mshoulder + Aether.Electronics.mass + Msustbodytube + Mforwardfins + Msustcasingtuberetainer...
    + Aether.StagingCoupler.mass + Mboosterbodytube + Mboostcasingtuberetainer + Maftfins +...
    Mdrogueparachute + Mmainparachute + Mboosterparachute;

initialSustMass = Aether.SustainerMotor.mass + Aether.Nosecone.mass + Mshoulder + Aether.Electronics.mass + Msustbodytube + Msustcasingtuberetainer...
    + Mforwardfins + Mdrogueparachute + Mmainparachute;

startTimeSust = Aether.BoosterMotor.burnTime+x(4);          % sec

if (t>=0 && t<Aether.BoosterMotor.burnTime)    %Launch to boost eject
    mass = initialMass - Aether.BoosterMotor.propMass *(t/Aether.BoosterMotor.burnTime);
elseif (t>=Aether.BoosterMotor.burnTime && t<startTimeSust) %Coast
    mass = initialMass - Aether.BoosterMotor.propMass;
elseif (t>=startTimeSust && t< startTimeSust + Aether.SustainerMotor.burnTime)    %Sust ign to MT
    mass = initialSustMass - Aether.SustainerMotor.propMass * (t/(Aether.SustainerMotor.burnTime + startTimeSust));
elseif (t>startTimeSust+Aether.SustainerMotor.burnTime)    %MT
    mass = initialSustMass - Aether.SustainerMotor.propMass;

else
    mass = initialMass;
    
end

end