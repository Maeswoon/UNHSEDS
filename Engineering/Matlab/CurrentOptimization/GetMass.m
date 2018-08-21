function [mass] = GetMass (t,x,Aether)

% ~ AETHER4 ~

BT = .330;  % 330 grams per meter for Body Tube
CP = .322;  % 322 grams per meter for Coupler Body Tube
ET = .168;  % 168 grams per meter for Engine Tube
PL = 4.882; % 4882 grams per square meter for Plate Parts

Mshoulder                = Aether.Nosecone.ShoulderLength * BT;
Msustcoupler             = Aether.ForwardCoupler.length * CP + Aether.ForwardCoupler.lipLength * BT;  % Whole E-Bay, Must find Value
Msustbodytube            = x(3) * BT;
Mforwardfins             = PL * x(4)*x(6)* 3;
Maftcoupler              = Aether.AftCoupler.length * CP + Aether.AftCoupler.lipLength * BT;    
Mboosterbodytube         = x(9) * BT;
Maftfins                 = PL * .5*x(10)*x(12) * 3; 
Msustcasingtuberetainer  = .120 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer
Mboostcasingtuberetainer = .120 + ET*.3;            % Mass of the Engine Casing, Engine Tube and Retainer

Mdrogueparachute         = .030; % Guesses, but good enough.
Mmainparachute           = .070;
Mboosterparachute        = .040; 

initialMass = Aether.BoosterMotor.mass + Aether.SustainerMotor.mass + Aether.Nosecone.mass + Mshoulder + Msustcoupler + Msustbodytube + Mforwardfins...
    + Msustcasingtuberetainer + Maftcoupler + Mboosterbodytube + Mboostcasingtuberetainer + Maftfins +...
    Mdrogueparachute + Mmainparachute + Mboosterparachute;

initialSustMass = Aether.SustainerMotor.mass + Aether.Nosecone.mass + Mshoulder + Msustcoupler + Msustbodytube + Msustcasingtuberetainer...
    + Mforwardfins + Mdrogueparachute + Mmainparachute;


startTimeSust = Aether.BoosterMotor.burnTime + x(2); % sec

if (t>=0 && t<Aether.BoosterMotor.burnTime) %Launch to boost eject
    mass = initialMass - Aether.BoosterMotor.propMass *(t/Aether.BoosterMotor.burnTime);
elseif (t>=Aether.BoosterMotor.burnTime && t<startTimeSust) %Coast
    mass = initialMass - Aether.BoosterMotor.propMass;
elseif (t>=startTimeSust && t< startTimeSust + Aether.SustainerMotor.burnTime) %Sustainer ignition to Sustainer Cutoff
    mass = initialSustMass - Aether.SustainerMotor.propMass * (t - startTimeSust/(Aether.SustainerMotor.burnTime));
elseif (t>startTimeSust+Aether.SustainerMotor.burnTime)    % Last coast to apogee
    mass = initialSustMass - Aether.SustainerMotor.propMass;
else
    mass = initialMass;
end
end