% Achieve acceleration of the booster after seperation

% ~ AETHER4 ~

function [a, d] = GetAcceleration2 ( v,h )

% Mass of Booster parts
Mstagingcoupler     = .058;    % Mass of Staging Coupler
Mboosterbodytube    = .145;    % Body tube and two centering rings
Maftfins            = .079;    % Mass of the 3 aft fins
Mboostinit          = .198;    % Initial mass of booster
Mboostprop          = .082;    % Mass of booster propellant 
Mcasingtuberetainer = .101;    % Mass of the Engine Casing, Engine Tube and Retainer


g = 9.81;                                                                                            % Gravity through flight (constant < 10,000 feet)
f = 0;                                                                                               % No upwards thrust
m = Mstagingcoupler + Mboosterbodytube + Maftfins + Mboostinit - Mboostprop + Mcasingtuberetainer;   % Mass of falling booster
[d] = GetDrag2 ( v,h );                                                                                % Drag of booster through flight
a = ( f - m*g - d )/ m ; % Newton's Second Law                                                     % Acceleration equation for a falling body with drag
end




