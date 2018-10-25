% Achieve acceleration of the booster after seperation

% ~ AETHER4 ~

function [a, d] = GetAcceleration2 ( v,h )

Mass_Booster_Burnout = .596; % Weight of flown booster, constant (kg)
g = 9.80;                    % Gravity through flight (constant < 10,000 feet)
f = 0;                       % No upwards thrust
d = GetDrag2 ( v,h );        % Drag of booster through flight
a = ( f - m*g - d )/ m ;     % Newton's Second Law with Drag, Gravity and no Thrust                    
end




