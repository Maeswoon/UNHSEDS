function [mass] = GetMass ( t ) % Needs to be checked and verified
%Masses

Mnosecone        = .063;
Mshoulder        = .089;
Mebay            = .120;
Msustbodytube    = .169;
Mforwardfins     = .104;
Mstagingcoupler  = .045;     % With 1 bulkhead = 9g
Mboosterbodytube = .165;    % need to add mass of 2 centering rings for both motors soon, need their own centroid 
Maftfins         = .084;   
Mboostinit       = .294;    % Initial mass of booster
Msustinit        = .349;    % Initial mass of sustainer 
Mboostprop       = .132;    % Mass of propellant 
Msustprop        = .185;    % Mass of propellant

initialMass = Mboostinit + Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins + Mstagingcoupler + Mboosterbodytube + Maftfins; % Add propellant mass ***********
initialSustMass = Msustinit + Mnosecone + Mshoulder + Mebay + Msustbodytube + Mforwardfins;


burnTimeBoost  = .7;       % sec
burnTimeSust   = 1.7;      % sec
startTimeboost = 1;        % sec
startTimecoast = startTimeboost + burnTimeSust;

if (t>=0 && t<burnTimeBoost)
    mass = initialMass - Mboostprop *(t/burnTimeBoost);
elseif (t>=burnTimeBoost && t<startTimeboost)
    mass = initialMass - Mboostprop;
elseif (t>=startTimeboost && t< startTimeboost + burnTimeSust);
    mass = initialSustMass - Msustprop * (t/(burnTimeSust + startTimeboost));
elseif (t>startTimecoast)
    mass = initialSustMass - Msustprop;
else
    mass = initialMass;
    
end

end