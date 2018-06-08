function [mass] = GetMass ( t ) % Needs to be checked and verified
%Masses

Mnosecone        = .107;
Mshoulder        = .105;
Mebay            = .120;
Msustbodytube    = .073;
Mforwardfins     = .036;
Msustinit        = .1982;    % Initial mass of sustainer 
Msustprop        = .0865;    % Mass of propellant



% Internal pieces (kg)
Mdrogueparachute    = 0.010;
Mmainparachute      = 0.020;  
Mcenteringring      = 0.005;

initialMass = Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mdrogueparachute + Msustinit + Mmainparachute + 2*Mcenteringring;



burnTimeSust   = 3;      % sec


if (t>=0 && t<burnTimeSust)
    mass = initialMass - Msustprop *(t/burnTimeSust);
elseif (t>=burnTimeSust) 
    mass = initialMass - Msustprop;
else
    mass = initialMass;
    
end

end