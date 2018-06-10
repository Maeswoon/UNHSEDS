% Achieve acceleration of the booster after seperation

function [a] = GetAcceleration2 ( v )

% Mass of Booster parts
Mstagingcoupler     = .045;    % Mass of Staging Coupler
Mboosterbodytube    = .18;     % Body tube and two centering rings
Maftfins            = .084;    % Mass of the 3 aft fins
Mboostinit          = .294;    % Initial mass of booster
Mboostprop          = .132;    % Mass of booster propellant 
Mcasingtuberetainer = .077;    % Mass of the Engine Casing, Engine Tube and Retainer


g = 9.81;                                                                                            % Gravity through flight (constant < 10,000 feet)
f = 0;                                                                                               % No upwards thrust
m = Mstagingcoupler + Mboosterbodytube + Maftfins + Mboostinit - Mboostprop + Mcasingtuberetainer;   % Mass of falling booster
d = GetDrag ( v );                                                                                   % Drag of booster through flight
a = ( f - m * g -d )/ m ; % Newton's Second Law                                                      % Acceleration equation for a falling body with drag
end
